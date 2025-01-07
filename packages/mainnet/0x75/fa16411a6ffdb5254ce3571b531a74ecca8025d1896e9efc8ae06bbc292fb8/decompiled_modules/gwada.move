module 0x75fa16411a6ffdb5254ce3571b531a74ecca8025d1896e9efc8ae06bbc292fb8::gwada {
    struct GWADA has drop {
        dummy_field: bool,
    }

    fun init(arg0: GWADA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GWADA>(arg0, 6, b"Gwada", b"Guadeloupe paradis", b"Guadeloupe is a Caribbean archipelago forming a region and a French overseas department. The main part, shaped like a butterfly, is composed of two islands: Grande-Terre to the east and Basse-Terre to the west, separated by an arm of the sea, called \"La Rivire Sale\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/carte_guadeloupe_t_shirt_manches_longues_bebe_f25dff298b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GWADA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GWADA>>(v1);
    }

    // decompiled from Move bytecode v6
}

