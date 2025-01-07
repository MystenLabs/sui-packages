module 0x5e7358f5187c702ec33725b597ef91aa8e7a2d49550644c65f7ebf6ce85810dc::sui6900 {
    struct SUI6900 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI6900, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI6900>(arg0, 6, b"SUI6900", b"SUI 6900", b"Bringing the stock market to Sui Blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_2024_10_08_T163015_428_1649872297.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI6900>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUI6900>>(v1);
    }

    // decompiled from Move bytecode v6
}

