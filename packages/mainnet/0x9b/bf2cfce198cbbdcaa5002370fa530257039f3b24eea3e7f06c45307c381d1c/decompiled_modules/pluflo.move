module 0x9bbf2cfce198cbbdcaa5002370fa530257039f3b24eea3e7f06c45307c381d1c::pluflo {
    struct PLUFLO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLUFLO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLUFLO>(arg0, 6, b"Pluflo", b"PLUFLO SUI", b"Pluflo for fun memes and a vibrant community. Dont miss it,  join the excitement!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241010_061811_59b39144a5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLUFLO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PLUFLO>>(v1);
    }

    // decompiled from Move bytecode v6
}

