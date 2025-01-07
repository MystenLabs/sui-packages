module 0xfed73d66fda9847643c145b53723a9b0eb6261723209b9320eae6f82e0e8d25a::sortuals {
    struct SORTUALS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SORTUALS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SORTUALS>(arg0, 6, b"Sortuals", b"Sortuals on Sui", b"The Fantasia of Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1_0_1024x836_a3ba936466.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SORTUALS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SORTUALS>>(v1);
    }

    // decompiled from Move bytecode v6
}

