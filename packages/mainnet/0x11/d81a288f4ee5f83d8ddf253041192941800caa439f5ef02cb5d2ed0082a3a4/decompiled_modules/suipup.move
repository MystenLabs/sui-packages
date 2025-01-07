module 0x11d81a288f4ee5f83d8ddf253041192941800caa439f5ef02cb5d2ed0082a3a4::suipup {
    struct SUIPUP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPUP>(arg0, 6, b"SUIPUP", b"SUI PUPPY", b"The Pup on SUI THAT WILL MARZ!!! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3294_5f65b235c1.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUP>>(v1);
    }

    // decompiled from Move bytecode v6
}

