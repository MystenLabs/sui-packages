module 0xe1384b33ed8e139d9a86d29c105363bd550f11a8bd67476aeeb586fac2d2441b::scubacat {
    struct SCUBACAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCUBACAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCUBACAT>(arg0, 6, b"SCUBACAT", b"SCUBA CAT", b"SCUBA CAT ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3724_a86fbd9363.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCUBACAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCUBACAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

