module 0xb3c7d1e333dc322b399da23ff9324b26684c30c68ba1cb17fc3abf41f78d4658::zeldazelda {
    struct ZELDAZELDA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZELDAZELDA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZELDAZELDA>(arg0, 6, b"ZELDAZELDA", b"ZELD", b"ZZELDAZELDA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_27_fbc0fc6be0_23f87a7c1d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZELDAZELDA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZELDAZELDA>>(v1);
    }

    // decompiled from Move bytecode v6
}

