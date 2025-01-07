module 0xd04cd23ff0be6f0be940d56bd7edb15474b9ae0a3e429733b6f9c1ac2da5c76::bmoon {
    struct BMOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: BMOON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BMOON>(arg0, 6, b"BMOON", b"BlueMoon", x"426c75654d6f6f6e3a20412052617265204f70706f7274756e69747920696e2043727970746f20f09f8c990a0a426c75654d6f6f6e206973206120756e697175652c20636f6d6d756e6974792d706f776572656420746f6b656e206f6e207468652065636f2d667269656e646c792053554920626c6f636b636861696e2c20696e737069726564206279207468652072617269747920616e6420626561757479206f66206120e2809c626c7565206d6f6f6e2ee2809d204a6f696e20757320746f207265616368206e6577206865696768747320696e207468652063727970746f20756e6976657273652120f09f8c8c", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730969048708.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BMOON>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BMOON>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

