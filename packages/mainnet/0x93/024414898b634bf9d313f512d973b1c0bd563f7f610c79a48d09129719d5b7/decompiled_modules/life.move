module 0x93024414898b634bf9d313f512d973b1c0bd563f7f610c79a48d09129719d5b7::life {
    struct LIFE has drop {
        dummy_field: bool,
    }

    fun init(arg0: LIFE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LIFE>(arg0, 6, b"LIFE", b"LIF3", b"https://twitter.com/Official_LIF3 join our community!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/images_f9224a7501.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LIFE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LIFE>>(v1);
    }

    // decompiled from Move bytecode v6
}

