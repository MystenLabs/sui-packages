module 0x7640409291d6032684982e3f6b95384b2e5d9a7311695e0bda92a938ccf7097b::gwada {
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

