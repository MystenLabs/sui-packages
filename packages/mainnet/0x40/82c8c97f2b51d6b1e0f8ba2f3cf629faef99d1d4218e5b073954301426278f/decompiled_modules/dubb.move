module 0x4082c8c97f2b51d6b1e0f8ba2f3cf629faef99d1d4218e5b073954301426278f::dubb {
    struct DUBB has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUBB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUBB>(arg0, 6, b"DUBB", b"DUBBIN AROUND", b"Hey my name is Dubb, im Dubbin around SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/b_cf0eaef12f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUBB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DUBB>>(v1);
    }

    // decompiled from Move bytecode v6
}

