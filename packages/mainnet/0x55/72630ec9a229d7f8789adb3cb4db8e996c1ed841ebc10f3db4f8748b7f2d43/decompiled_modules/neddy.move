module 0x5572630ec9a229d7f8789adb3cb4db8e996c1ed841ebc10f3db4f8748b7f2d43::neddy {
    struct NEDDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEDDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEDDY>(arg0, 6, b"NEDDY", b"Nerd Cat", b"this helped me regulate myself in a meltdown", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/3a17cca9dfbcd4850fad4d8950707824_c26187eaa1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEDDY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NEDDY>>(v1);
    }

    // decompiled from Move bytecode v6
}

