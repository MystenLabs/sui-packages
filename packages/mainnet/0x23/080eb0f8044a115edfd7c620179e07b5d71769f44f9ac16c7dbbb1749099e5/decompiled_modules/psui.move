module 0x23080eb0f8044a115edfd7c620179e07b5d71769f44f9ac16c7dbbb1749099e5::psui {
    struct PSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PSUI>(arg0, 6, b"PSUI", b"PunksSUI", b"Free from adulteration or alterations, allowing you to live the pure essence of this nfts revolution", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Punks_SUI_1000_74076a0b0f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

