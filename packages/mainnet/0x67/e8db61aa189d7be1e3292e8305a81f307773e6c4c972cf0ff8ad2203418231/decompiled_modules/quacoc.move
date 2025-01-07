module 0x67e8db61aa189d7be1e3292e8305a81f307773e6c4c972cf0ff8ad2203418231::quacoc {
    struct QUACOC has drop {
        dummy_field: bool,
    }

    fun init(arg0: QUACOC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QUACOC>(arg0, 6, b"QUACOC", b"Quack Cocaine", x"517561636b20697320686967682061732061206b697465206f6e20434f4341494e45212121200a464c5920484947482041532041204455434b204f4e205448452053554920434841494e205749544820555321212121210a4e554d4220594f55522046414345212121", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/MAINLOGOQUACK_b84121baab.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QUACOC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<QUACOC>>(v1);
    }

    // decompiled from Move bytecode v6
}

