module 0x27c693131b9602b9424788794569f9bb9281f330db1ff145c81f32b15d8b946d::monke {
    struct MONKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MONKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MONKE>(arg0, 6, b"MONKE", b"Monkey", b"Monkey is an exciting memecoin set to launch on the Sui network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731335668924.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MONKE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MONKE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

