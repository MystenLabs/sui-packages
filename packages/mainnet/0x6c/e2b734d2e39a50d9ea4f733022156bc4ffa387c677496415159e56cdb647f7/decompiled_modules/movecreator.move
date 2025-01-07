module 0x6ce2b734d2e39a50d9ea4f733022156bc4ffa387c677496415159e56cdb647f7::movecreator {
    struct MOVECREATOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOVECREATOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOVECREATOR>(arg0, 6, b"MoveCreator", b"Move Creator", x"54686973206973204a5553542061205041524f4459204163636f756e74206f66204d6f76652043726561746f72204d454d4520425920495058205445414d200a0a4e4f5445204e4f204f464649434120425920495058205445414d207c204a75737420666f722066756e204e4641207c5468652054776974746572204163636f756e74206973206e6f74206f662074686973206d656d6520207c0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/m_36666f016e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOVECREATOR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOVECREATOR>>(v1);
    }

    // decompiled from Move bytecode v6
}

