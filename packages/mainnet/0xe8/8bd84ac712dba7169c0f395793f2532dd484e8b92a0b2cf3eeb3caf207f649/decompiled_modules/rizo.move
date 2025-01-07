module 0xe88bd84ac712dba7169c0f395793f2532dd484e8b92a0b2cf3eeb3caf207f649::rizo {
    struct RIZO has drop {
        dummy_field: bool,
    }

    fun init(arg0: RIZO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RIZO>(arg0, 6, b"RIZO", b"HahaYes", b"Meme $RIZO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/l73_D_Vvml_400x400_f0f039c868.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RIZO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RIZO>>(v1);
    }

    // decompiled from Move bytecode v6
}

