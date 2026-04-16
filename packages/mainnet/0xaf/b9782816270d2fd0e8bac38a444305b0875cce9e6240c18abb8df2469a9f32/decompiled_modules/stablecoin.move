module 0xafb9782816270d2fd0e8bac38a444305b0875cce9e6240c18abb8df2469a9f32::stablecoin {
    struct STABLECOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: STABLECOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<STABLECOIN>(arg0, 6, b"STABLE", b"US Dollar Yield", b"US Dollar Yield", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ondo.finance/images/tokens/usdy.svg")), true, arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<STABLECOIN>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STABLECOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<STABLECOIN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

