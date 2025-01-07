module 0xba9f03545d1f8a7280e98daba21fb3902f3d16a385ea6a83d3ee8b4306f90af4::suif {
    struct SUIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIF>(arg0, 6, b"Suif", b"Suiwifhat", b"Meme and point.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731002890028.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIF>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIF>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

