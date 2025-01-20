module 0xc214358eed78f5275f14d7263fd95ac7dca8f279948e96d507fa6b6f0e87b6d4::BBAxol {
    struct BBAXOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBAXOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBAXOL>(arg0, 9, b"BBAxol", b"Baby Axol", x"426162792041786f6c2c207468652061646f7261626c6520737563636573736f7220746f207468652041786f6c206d656d6520746f6b656e206f6e207468652053756920626c6f636b636861696e2c20756e697465732063727970746f20656e74687573696173747320776974682069747320706c61792d746f2d6561726e2067616d65732c2076696272616e74204e4654732c20616e6420696e636c7573697665206574686f732e204d6f7265207468616e2061207370696e2d6f66662c206974e2809973206120626f6c64207374657020666f72776172642c2070726f76696e67206772656174207468696e677320636f6d6520696e20736d616c6c2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1878278600048394240/Uh7QrIcJ_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BBAXOL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<BBAXOL>>(0x2::coin::mint<BBAXOL>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<BBAXOL>>(v2);
    }

    // decompiled from Move bytecode v6
}

