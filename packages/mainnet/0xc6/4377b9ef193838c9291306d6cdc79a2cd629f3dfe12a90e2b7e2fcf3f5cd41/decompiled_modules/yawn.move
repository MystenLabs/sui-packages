module 0xc64377b9ef193838c9291306d6cdc79a2cd629f3dfe12a90e2b7e2fcf3f5cd41::yawn {
    struct YAWN has drop {
        dummy_field: bool,
    }

    fun init(arg0: YAWN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YAWN>(arg0, 6, b"YAWN", b"YawnSUI", b"Sleepiest mascot on SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/YAWNS_5d09e24481.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YAWN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YAWN>>(v1);
    }

    // decompiled from Move bytecode v6
}

