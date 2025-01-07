module 0x53b34182d60d57131bd164844357422adc5a8349401595d9cbbe852f2312f619::suionsui {
    struct SUIONSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIONSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIONSUI>(arg0, 6, b"SUIonSUI", b"SUI on SUI meme", x"537569206f6e205375692069732061206d656d652070726f6a656374206275696c74206f6e2074686520537569206e6574776f726b207769746820706c617966756c20636861726d20616e6420636f6d6d756e6974792d64726976656e2067726f7774682e204a6f696e20757320696e206372656174696e6720612066756e20616e6420656e676167696e6720646563656e7472616c697a656420667574757265210a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20947_7d83143c98.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIONSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIONSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

