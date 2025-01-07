module 0x7ae12c573e35af994f6e83731b9764f9e1b7b3936bb2877d6abe4f62b184f324::suidian {
    struct SUIDIAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDIAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDIAN>(arg0, 6, b"Suidian", b"SUIDIAN DOG", b"indian dog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sfdsfsfsdfsd_5c3d77e401.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDIAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIDIAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

