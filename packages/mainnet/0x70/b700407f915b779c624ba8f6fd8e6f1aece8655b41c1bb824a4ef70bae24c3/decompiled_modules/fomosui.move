module 0x70b700407f915b779c624ba8f6fd8e6f1aece8655b41c1bb824a4ef70bae24c3::fomosui {
    struct FOMOSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOMOSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOMOSUI>(arg0, 6, b"Fomosui", b"Fomo", b"Let do together FOMO SUI Project", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/fomo_sui_it_03e73c47a4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOMOSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FOMOSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

