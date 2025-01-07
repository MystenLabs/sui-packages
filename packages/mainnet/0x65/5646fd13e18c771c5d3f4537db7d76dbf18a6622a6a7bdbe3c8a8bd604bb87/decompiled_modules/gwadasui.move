module 0x655646fd13e18c771c5d3f4537db7d76dbf18a6622a6a7bdbe3c8a8bd604bb87::gwadasui {
    struct GWADASUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GWADASUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GWADASUI>(arg0, 6, b"GWADASUI", b"SUIGWADA", b"La Guadeloupe est un archipel des Carabes formant une rgion et un dpartement d'outre-mer franais. La partie principale en forme de papillon est compose de deux les : la Grande-Terre  l'est et la Basse-Terre  l'ouest, spares par un bras de mer, appel  la Rivire Sale .", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/carte_guadeloupe_t_shirt_manches_longues_bebe_a3095be341.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GWADASUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GWADASUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

