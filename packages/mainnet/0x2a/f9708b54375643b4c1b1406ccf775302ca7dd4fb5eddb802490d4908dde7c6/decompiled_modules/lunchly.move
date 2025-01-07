module 0x2af9708b54375643b4c1b1406ccf775302ca7dd4fb5eddb802490d4908dde7c6::lunchly {
    struct LUNCHLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUNCHLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUNCHLY>(arg0, 6, b"LUNCHLY", b"Lunchly on Sui", b"Meet $LUNCHLY, Cheese always stays drippy on Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/character_40b93a08_1_af9cd6d52c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUNCHLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LUNCHLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

