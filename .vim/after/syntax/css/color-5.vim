syn region cssFunction contained matchgroup=cssFunctionName start="\<\(color-\(mix\|contrast\|adjust\)\|red\|green\|blue\|alpha\|hue\|saturation\|lightness\|whiteness\|blackness\|a\|b\|chroma\)\s*(" end=")" contains=cssCustomProp,cssFunction,cssColor,cssFunctionComma oneline