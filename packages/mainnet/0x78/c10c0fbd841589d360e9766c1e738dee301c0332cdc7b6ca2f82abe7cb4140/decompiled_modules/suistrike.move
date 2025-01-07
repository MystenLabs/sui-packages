module 0x78c10c0fbd841589d360e9766c1e738dee301c0332cdc7b6ca2f82abe7cb4140::suistrike {
    struct SUISTRIKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISTRIKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISTRIKE>(arg0, 6, b"SUISTRIKE", b"Sui Strike", b"We are launching the first real online game on the Sui Network. You can play online games with Sui Strike and win Sui Strike. The V1 version of the game is now live, many more will come soon. You can enter Sui Strike award-winning battles with your friends, we are coming soon.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000033412_e765f8bfdc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISTRIKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISTRIKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

