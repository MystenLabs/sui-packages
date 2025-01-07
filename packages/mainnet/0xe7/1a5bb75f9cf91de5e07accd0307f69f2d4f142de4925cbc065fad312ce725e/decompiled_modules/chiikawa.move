module 0xe71a5bb75f9cf91de5e07accd0307f69f2d4f142de4925cbc065fad312ce725e::chiikawa {
    struct CHIIKAWA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHIIKAWA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHIIKAWA>(arg0, 6, b"CHIIKAWA", b"Chiikawa", b"u u . wa . wa . uwa uwa wata (kigou) ku ta (kigou) kuchi yaao uwa wa wa uwa wai wai tore ri uwa wa waiwai tara chiro u u . wa . wa . uwa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Whats_App_Oct_13_5_05_AM_7062fe6a4e.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHIIKAWA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHIIKAWA>>(v1);
    }

    // decompiled from Move bytecode v6
}

