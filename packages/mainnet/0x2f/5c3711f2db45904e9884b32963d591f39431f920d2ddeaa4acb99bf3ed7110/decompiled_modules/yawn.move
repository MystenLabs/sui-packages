module 0x2f5c3711f2db45904e9884b32963d591f39431f920d2ddeaa4acb99bf3ed7110::yawn {
    struct YAWN has drop {
        dummy_field: bool,
    }

    fun init(arg0: YAWN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YAWN>(arg0, 6, b"YAWN", b"SUIYawn", b"$YAWN, the sleepiest and funniest mascot on SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/YAWNS_c4cb7c8a2d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YAWN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YAWN>>(v1);
    }

    // decompiled from Move bytecode v6
}

