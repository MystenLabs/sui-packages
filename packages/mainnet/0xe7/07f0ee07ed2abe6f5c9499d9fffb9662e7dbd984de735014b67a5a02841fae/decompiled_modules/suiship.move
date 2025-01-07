module 0xe707f0ee07ed2abe6f5c9499d9fffb9662e7dbd984de735014b67a5a02841fae::suiship {
    struct SUISHIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISHIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISHIP>(arg0, 6, b"SUISHIP", b"Sui Ship", b"Anchored in Sui, sailing strong. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ship_1_3abd69d810.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISHIP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISHIP>>(v1);
    }

    // decompiled from Move bytecode v6
}

