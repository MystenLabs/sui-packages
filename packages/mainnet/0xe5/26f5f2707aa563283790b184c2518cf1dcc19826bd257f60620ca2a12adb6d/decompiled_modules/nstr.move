module 0xe526f5f2707aa563283790b184c2518cf1dcc19826bd257f60620ca2a12adb6d::nstr {
    struct NSTR has drop {
        dummy_field: bool,
    }

    fun init(arg0: NSTR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NSTR>(arg0, 9, b"NSTR", b"NEW STAR", b"NEW STAR Token is an innovative digital asset designed to revolutionize the cryptocurrency market. It offers users a secure and decentralized platform for trading and investment. Illuminate your financial journey with NEW STAR and reach new heights!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0b2b6eb5-0308-4840-abcd-e6ec91bdd794.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NSTR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NSTR>>(v1);
    }

    // decompiled from Move bytecode v6
}

