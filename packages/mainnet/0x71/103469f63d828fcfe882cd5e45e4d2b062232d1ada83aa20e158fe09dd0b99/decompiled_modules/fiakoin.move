module 0x71103469f63d828fcfe882cd5e45e4d2b062232d1ada83aa20e158fe09dd0b99::fiakoin {
    struct FIAKOIN has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<FIAKOIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<FIAKOIN>>(0x2::coin::mint<FIAKOIN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: FIAKOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FIAKOIN>(arg0, 6, b"FIAKOIN", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FIAKOIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FIAKOIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

