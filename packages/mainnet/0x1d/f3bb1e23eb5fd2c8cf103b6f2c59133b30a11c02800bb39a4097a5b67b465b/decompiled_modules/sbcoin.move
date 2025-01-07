module 0x1df3bb1e23eb5fd2c8cf103b6f2c59133b30a11c02800bb39a4097a5b67b465b::sbcoin {
    struct SBCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBCOIN>(arg0, 6, b"Sbcoin", b"Peace", b"Help us build a world full of peace and wealth by developing games without war and violence.gaim token ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_U_U_U_U_U_U_U_U_U_U_U_U_U_U_Gallery_9a427372f9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SBCOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

