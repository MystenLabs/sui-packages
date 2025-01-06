module 0xbb9f461a4938b40826a96faef1846ea4dd7cb1cda6e667c35dcefd83e9be275e::soma {
    struct SOMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOMA>(arg0, 9, b"SOMA", b"Somali Coin", b"Somali coin for all Somalis", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SOMA>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOMA>>(v2, @0x28649ee96599b9da715335d99088b885d63a5ec5f3a4c58843b947b5b8a9f223);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

