module 0xd872a836060c7d75da81b5dbde7c720647ad05422e906a2f7e3c89dc7bc84fc::paul2 {
    struct PAUL2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAUL2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAUL2>(arg0, 9, b"PAUL2", b"Paul VC", b"VC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<PAUL2>>(v0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PAUL2>>(v1);
    }

    // decompiled from Move bytecode v6
}

