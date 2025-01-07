module 0x297f0a2ef1cae77260bc9eedcbfc3e639ec93165d999ace7f70ab81ab15c3156::woof {
    struct WOOF has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOOF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOOF>(arg0, 6, b"WOOF", b"Suishi Dog", x"53756973686920776974682061207477697374206f66207061772d736f6d652070657266656374696f6e2c20636f6d62696e696e672074686520706c617966756c20656e65726779206f6620646f677320616e642074686520617274206f66207375736869535549534849444f472024574f4f46207374796c65210a0a68747470733a2f2f782e636f6d2f537569736869446f675355490a0a68747470733a2f2f737569736869646f672e66756e2f0a0a68747470733a2f2f742e6d652f737569736869646f67706f7274616c", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pp_68895d55fc.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOOF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WOOF>>(v1);
    }

    // decompiled from Move bytecode v6
}

