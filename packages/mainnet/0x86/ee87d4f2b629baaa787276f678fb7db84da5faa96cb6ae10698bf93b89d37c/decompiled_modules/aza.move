module 0x86ee87d4f2b629baaa787276f678fb7db84da5faa96cb6ae10698bf93b89d37c::aza {
    struct AZA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AZA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<AZA>(arg0, 6, b"AZA", b"a by SuiAI", b"a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Gg_V29jw_Xc_AA_5h4_A_9dd3974533.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AZA>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AZA>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

