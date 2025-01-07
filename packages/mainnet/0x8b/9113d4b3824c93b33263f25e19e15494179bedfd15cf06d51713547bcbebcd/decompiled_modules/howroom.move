module 0x8b9113d4b3824c93b33263f25e19e15494179bedfd15cf06d51713547bcbebcd::howroom {
    struct HOWROOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOWROOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOWROOM>(arg0, 6, b"HOWROOM", b"howroom howroom girL", b"HOWROOM HOWROOOOOOOOMMMMMMMMMMM", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GIRL_3f5877be02.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOWROOM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOWROOM>>(v1);
    }

    // decompiled from Move bytecode v6
}

