module 0x5f7b94db94f580dd34abc7677881046c98fe650c81104c607d170cecc4c803af::bc {
    struct BC has drop {
        dummy_field: bool,
    }

    fun init(arg0: BC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BC>(arg0, 6, b"BC", b"Black cat", b"Just black cat and send it to moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000199_e16b5c1d2f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BC>>(v1);
    }

    // decompiled from Move bytecode v6
}

