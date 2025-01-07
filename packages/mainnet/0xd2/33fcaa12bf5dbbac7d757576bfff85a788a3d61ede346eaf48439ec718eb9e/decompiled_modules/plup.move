module 0xd233fcaa12bf5dbbac7d757576bfff85a788a3d61ede346eaf48439ec718eb9e::plup {
    struct PLUP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLUP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLUP>(arg0, 6, b"Plup", b"SuiPlup", b"The most cutest water pokemon is now on $SUI ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/FLUP_38d9716912.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLUP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PLUP>>(v1);
    }

    // decompiled from Move bytecode v6
}

