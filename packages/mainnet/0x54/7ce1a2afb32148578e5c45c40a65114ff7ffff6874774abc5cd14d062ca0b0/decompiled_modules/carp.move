module 0x547ce1a2afb32148578e5c45c40a65114ff7ffff6874774abc5cd14d062ca0b0::carp {
    struct CARP has drop {
        dummy_field: bool,
    }

    fun init(arg0: CARP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CARP>(arg0, 6, b"CARP", b"Carp", b"GET READY, IM GOING TO CHARGE BUYBOOT TO THE COMMUNITY!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/carp_56dec0e75b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CARP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CARP>>(v1);
    }

    // decompiled from Move bytecode v6
}

