module 0x841feb5e0622c8993cc839713638fa9aa496217560a33d1eea245d2bb6644bce::leech {
    struct LEECH has drop {
        dummy_field: bool,
    }

    fun init(arg0: LEECH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LEECH>(arg0, 6, b"LEECH", b"LEECH ON SUI", b"Leeching off trends and hype over sui memecoins.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20240930_194229_701_d824529c3f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LEECH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LEECH>>(v1);
    }

    // decompiled from Move bytecode v6
}

