module 0x6d2e4cb59027cb05b61fe34cc247dfb2fe744d000c4e61a901c0ece2ddc011e5::gnies {
    struct GNIES has drop {
        dummy_field: bool,
    }

    fun init(arg0: GNIES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GNIES>(arg0, 6, b"GNIES", b"GREENIESUI", b"Greenie is dreaming of a future where blockchain will change our lives!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/3_a040ba32eb.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GNIES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GNIES>>(v1);
    }

    // decompiled from Move bytecode v6
}

