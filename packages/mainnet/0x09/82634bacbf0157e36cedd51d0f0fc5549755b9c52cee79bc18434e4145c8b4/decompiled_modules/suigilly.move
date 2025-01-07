module 0x982634bacbf0157e36cedd51d0f0fc5549755b9c52cee79bc18434e4145c8b4::suigilly {
    struct SUIGILLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGILLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGILLY>(arg0, 6, b"SuiGilly", b"Sui-Gilly", b" Gilly's the flappiest slicker from the waters of the planet Sui. She's got the speed and agility and knows her way around all kinds of blocks and their chains. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Sui_Gilly_The_collector_dab87683f5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGILLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIGILLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

