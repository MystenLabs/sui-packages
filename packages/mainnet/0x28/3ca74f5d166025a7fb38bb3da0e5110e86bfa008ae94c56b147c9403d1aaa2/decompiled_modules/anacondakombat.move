module 0x283ca74f5d166025a7fb38bb3da0e5110e86bfa008ae94c56b147c9403d1aaa2::anacondakombat {
    struct ANACONDAKOMBAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANACONDAKOMBAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANACONDAKOMBAT>(arg0, 6, b"ANACONDAKOMBAT", b"ANACONDA KOMBAT", b"Anaconda Kombat to flip Hamster Kombat, Huge Tap to Earn game launch soon, Bot Ready", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1722358950513_59e5e5c7a9a88936fce2e576f728712d_25e2bc3222.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANACONDAKOMBAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ANACONDAKOMBAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

