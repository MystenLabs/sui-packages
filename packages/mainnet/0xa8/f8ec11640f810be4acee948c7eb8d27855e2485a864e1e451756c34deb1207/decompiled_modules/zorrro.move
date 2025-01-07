module 0xa8f8ec11640f810be4acee948c7eb8d27855e2485a864e1e451756c34deb1207::zorrro {
    struct ZORRRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZORRRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZORRRO>(arg0, 6, b"ZORRRO", b"zkZORRO", b"Real ZORRO on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Zorro_Rizz_ce9f854e2bec7503e223_120d78975d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZORRRO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZORRRO>>(v1);
    }

    // decompiled from Move bytecode v6
}

