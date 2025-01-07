module 0xec25e2fc0e53cf0e1a73c1d1e9218757a0ba8562aad7b42e8def31929530a401::nosui {
    struct NOSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOSUI>(arg0, 6, b"NOSUI", b"NoSuignal", b"NO SUIGNAL", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/409775a4e4edf009579966d3d03cb29a_048015cf74.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NOSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

