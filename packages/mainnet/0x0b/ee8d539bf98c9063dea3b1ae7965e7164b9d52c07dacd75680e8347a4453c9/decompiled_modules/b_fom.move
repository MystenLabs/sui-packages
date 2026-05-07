module 0xbee8d539bf98c9063dea3b1ae7965e7164b9d52c07dacd75680e8347a4453c9::b_fom {
    struct B_FOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_FOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_FOM>(arg0, 9, b"bFOM", b"bToken FOM", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_FOM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_FOM>>(v1);
    }

    // decompiled from Move bytecode v6
}

