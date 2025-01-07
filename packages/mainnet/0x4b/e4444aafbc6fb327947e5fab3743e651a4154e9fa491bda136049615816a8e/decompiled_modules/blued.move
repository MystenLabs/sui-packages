module 0x4be4444aafbc6fb327947e5fab3743e651a4154e9fa491bda136049615816a8e::blued {
    struct BLUED has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUED>(arg0, 6, b"BLUED", b"Blue Eyes White Dragon", b"Fuck another blue eyed, i'm the real one", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Blue_Eyes_White_Dragon_7d6f8b57bc.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUED>>(v1);
    }

    // decompiled from Move bytecode v6
}

