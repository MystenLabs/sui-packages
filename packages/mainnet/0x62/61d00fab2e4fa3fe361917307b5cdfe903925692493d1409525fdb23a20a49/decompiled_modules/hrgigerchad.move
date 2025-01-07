module 0x6261d00fab2e4fa3fe361917307b5cdfe903925692493d1409525fdb23a20a49::hrgigerchad {
    struct HRGIGERCHAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: HRGIGERCHAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HRGIGERCHAD>(arg0, 6, b"HRGIGERCHAD", b"H R GIGER CHAD", b"Giger chadding ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/hrigerchad_99e93de407.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HRGIGERCHAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HRGIGERCHAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

