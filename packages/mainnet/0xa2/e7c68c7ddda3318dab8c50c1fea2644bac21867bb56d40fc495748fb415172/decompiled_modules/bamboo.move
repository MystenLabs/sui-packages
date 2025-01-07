module 0xa2e7c68c7ddda3318dab8c50c1fea2644bac21867bb56d40fc495748fb415172::bamboo {
    struct BAMBOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAMBOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAMBOO>(arg0, 6, b"BAMBOO", b"Bamboo Sui Coin", x"42616d626f6f20636f696e2067726f7773206c696b652062616d626f6f2121210a58203a2068747470733a2f2f782e636f6d2f62616d626f6f5f636f696e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Tak_berjudul68_20250106034812_98f25bd567.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAMBOO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BAMBOO>>(v1);
    }

    // decompiled from Move bytecode v6
}

