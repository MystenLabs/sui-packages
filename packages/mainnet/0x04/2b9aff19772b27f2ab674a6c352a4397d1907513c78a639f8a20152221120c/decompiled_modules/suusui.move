module 0x42b9aff19772b27f2ab674a6c352a4397d1907513c78a639f8a20152221120c::suusui {
    struct SUUSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUUSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUUSUI>(arg0, 6, b"SuuSui", b"Suuflex meme", b"Not just another streaming platform. We make move's, we make waves", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dsadsa_f564df4ae9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUUSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUUSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

