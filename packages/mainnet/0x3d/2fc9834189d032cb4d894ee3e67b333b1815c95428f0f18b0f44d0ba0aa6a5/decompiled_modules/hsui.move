module 0x3d2fc9834189d032cb4d894ee3e67b333b1815c95428f0f18b0f44d0ba0aa6a5::hsui {
    struct HSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HSUI>(arg0, 9, b"hiveSUI", b"hiveSUI", b"HiveSUI: Transforming DeFi earnings into a stream of rewards for DegenHive's decision-makers", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://degenhive.ai/assets/hive_sui_logo.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

