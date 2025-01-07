module 0xd6fa9d921eec2050925c74d01bef5587ba6baf75ef658604b39ae30492749113::suiyoh {
    struct SUIYOH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIYOH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIYOH>(arg0, 6, b"SUIYOH", b"Suiyoh", b"What you waiting for haiyaaaah.. Send it already! SUIYOH!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0997_f6900f6aa0.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIYOH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIYOH>>(v1);
    }

    // decompiled from Move bytecode v6
}

