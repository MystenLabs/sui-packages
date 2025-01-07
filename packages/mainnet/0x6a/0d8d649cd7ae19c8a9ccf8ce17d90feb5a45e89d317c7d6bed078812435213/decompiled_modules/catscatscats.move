module 0x6a0d8d649cd7ae19c8a9ccf8ce17d90feb5a45e89d317c7d6bed078812435213::catscatscats {
    struct CATSCATSCATS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATSCATSCATS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATSCATSCATS>(arg0, 6, b"CATSCATSCATS", b"Everyone loves CATs", b"So cute CATs\\n. CATs are very cute\\n.Live with them.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdn.hydropump.xyz/logo/01JEQB6Z4MXZ6JB105NA5F3RPA/01JEQB6ZCSBMQ9DYQC1XEGFTW0")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATSCATSCATS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CATSCATSCATS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

