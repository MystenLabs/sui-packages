module 0x1b8d2340ef5f6d5ba229ee4a280ba2a844c5a3710134741e682c1ba24dabd1ee::scn {
    struct SCN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCN>(arg0, 6, b"Scn", b"suicune", b"it's a pokemon from sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1754668520279.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SCN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

