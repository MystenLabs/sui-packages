module 0x4683d45d9e62b3d9061699d0f7748080ba82c5e4c345640a1dc79ba33cbff353::suihuahua {
    struct SUIHUAHUA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIHUAHUA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIHUAHUA>(arg0, 6, b"SUIHUAHUA", b"Suihuahua", b"Suihuahua: The Whimsical \"Unofficial\" Mascot of Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_Move_Pump_4eae74d6c1.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIHUAHUA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIHUAHUA>>(v1);
    }

    // decompiled from Move bytecode v6
}

