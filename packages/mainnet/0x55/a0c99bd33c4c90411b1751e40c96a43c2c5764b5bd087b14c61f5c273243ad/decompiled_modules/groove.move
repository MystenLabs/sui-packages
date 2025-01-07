module 0x55a0c99bd33c4c90411b1751e40c96a43c2c5764b5bd087b14c61f5c273243ad::groove {
    struct GROOVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GROOVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GROOVE>(arg0, 6, b"GROOVE", b"Animal Groove", b"Its time for $GROOVE! Lets have some fun! It was created for one purpose, to create a new and fun community", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/biglogo3_fb88eb642e.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GROOVE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GROOVE>>(v1);
    }

    // decompiled from Move bytecode v6
}

