module 0xc82f67ad02c27eb07d380e550e9c15b27232bb4b4bc6ed67b5c07d3c1af2fb1b::kids {
    struct KIDS has drop {
        dummy_field: bool,
    }

    fun init(arg0: KIDS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KIDS>(arg0, 6, b"KIDS", b"KIDS NOT HAPPENING", b"KIDS ? NOT HAPPENING!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/kids_611cf5733d.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KIDS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KIDS>>(v1);
    }

    // decompiled from Move bytecode v6
}

