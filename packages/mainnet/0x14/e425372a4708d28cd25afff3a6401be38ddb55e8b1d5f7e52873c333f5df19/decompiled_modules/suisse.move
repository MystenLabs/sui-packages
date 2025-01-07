module 0x14e425372a4708d28cd25afff3a6401be38ddb55e8b1d5f7e52873c333f5df19::suisse {
    struct SUISSE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISSE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISSE>(arg0, 6, b"SUISSE", b"Suisse Cheese", b"A hole lot better on Sui-sse", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/Screenshot_2024_09_24_at_8_14_19a_PM_f6e4d301f1.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISSE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISSE>>(v1);
    }

    // decompiled from Move bytecode v6
}

