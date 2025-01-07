module 0x7302b76eea6c71a74736b43ff2f4359ea00d71ec993dee262f080be9ba8d9b4d::suieep {
    struct SUIEEP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIEEP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIEEP>(arg0, 6, b"SUIEEP", b"SUIJEEP", b"SUIEEP...Sui blockchain vehicle to the future.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1112_1a94f913d2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIEEP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIEEP>>(v1);
    }

    // decompiled from Move bytecode v6
}

