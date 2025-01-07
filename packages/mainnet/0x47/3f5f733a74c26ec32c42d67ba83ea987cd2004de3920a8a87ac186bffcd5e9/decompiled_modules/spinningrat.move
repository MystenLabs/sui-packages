module 0x473f5f733a74c26ec32c42d67ba83ea987cd2004de3920a8a87ac186bffcd5e9::spinningrat {
    struct SPINNINGRAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPINNINGRAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPINNINGRAT>(arg0, 6, b"SPINNINGRAT", b"Spinning Rat", b"The spinning rat, featured on POPCAT, is the real reason behind its popularity-without it, POPCAT wouldn't be popping.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000035369_7d516015cf.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPINNINGRAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPINNINGRAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

