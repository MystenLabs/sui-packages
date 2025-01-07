module 0x588805f852035c5ba60adfeae99c147238dd330c14995508082e43fc59e71be::raccoonius {
    struct RACCOONIUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: RACCOONIUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RACCOONIUS>(arg0, 6, b"RACCOONIUS", b"racconius", b"racconius", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RACCOONIUS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<RACCOONIUS>>(0x2::coin::mint<RACCOONIUS>(&mut v2, 2100000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RACCOONIUS>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

