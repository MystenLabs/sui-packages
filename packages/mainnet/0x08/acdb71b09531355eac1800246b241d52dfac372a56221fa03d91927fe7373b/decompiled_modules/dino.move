module 0x8acdb71b09531355eac1800246b241d52dfac372a56221fa03d91927fe7373b::dino {
    struct DINO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DINO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DINO>(arg0, 6, b"DINO", b"Sui Dino", x"5375695361757275732044696e6f206f722053756944696e6f20697320637574652066756e2d6c6f76696e672c2044696e6f206f6e207468652073756920626c6f636b636861696e2e20486520646f65736e27742073746179206375746520616e6420736d616c6c20666f72657665722074686f7567682e2053756944696e6f2067726f77732c20616e642068652067726f777320666173742e200a0a576562736974653a2068747470733a2f2f73756964696e6f2e66756e0a547769747465723a2068747470733a2f2f782e636f6d2f53756944696e6f5f5375690a54656c656772616d3a2068747470733a2f2f742e6d652f53756944696e6f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250105_215647_975_aaf050f091.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DINO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DINO>>(v1);
    }

    // decompiled from Move bytecode v6
}

