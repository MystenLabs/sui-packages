module 0x66247ead0662452f0e8ad1e5370349c8bdee675110346910c75a9a169df199f3::baka {
    struct BAKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAKA>(arg0, 6, b"BAKA", b"BAKAS", x"53756962616b612069732061206d656d6520636f696e206f6e207468652053756920626c6f636b636861696e2c20706f74656e7469616c6c7920696e7370697265642062792068756d6f726f757320696e7465726e65742063756c7475726520616e6420e2809c62616b61e2809d20286120706c617966756c204a6170616e657365207465726d206d65616e696e6720e2809c666f6f6ce2809d206f7220e2809c73696c6c79e2809d292e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730951665869.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BAKA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAKA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

