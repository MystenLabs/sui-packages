module 0xfefb22070efb76092ee91aca2b09e332500f8fb6f70f1e1d978fd5ae1791fa0a::jinxy {
    struct JINXY has drop {
        dummy_field: bool,
    }

    fun init(arg0: JINXY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JINXY>(arg0, 6, b"JINXY", b"JINXY Pnut's sister", x"68747470733a2f2f7777772e696e7374616772616d2e636f6d2f7065616e75745f7468655f737175697272656c31322f702f42715345545179416a75732f0a0a6c657473206d616b65206120636f6d6d756e6974792064726976656e20746f6b656e21", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/jinxy2_67b2d647f2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JINXY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JINXY>>(v1);
    }

    // decompiled from Move bytecode v6
}

