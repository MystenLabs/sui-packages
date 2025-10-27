module 0x4165e4e273439f14daf2071f97fd1ad4608851d50d304e65e0df221c5480902d::whitelist {
    public fun allow_all(arg0: &0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::app::AdminCap, arg1: &mut 0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::market::Market) {
        0x1318fdc90319ec9c24df1456d960a447521b0a658316155895014a6e39b5482f::whitelist::allow_all(0xb4b3941738323f2623f822124a9c5bdd7b63f6ac4e4af02550d5c20489d767b6::app::ext(arg0, arg1));
    }

    // decompiled from Move bytecode v6
}

