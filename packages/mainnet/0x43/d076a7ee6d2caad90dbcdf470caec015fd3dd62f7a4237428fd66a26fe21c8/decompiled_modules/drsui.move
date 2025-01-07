module 0x43d076a7ee6d2caad90dbcdf470caec015fd3dd62f7a4237428fd66a26fe21c8::drsui {
    struct DRSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRSUI>(arg0, 6, b"DRSUI", b"DROIDS ON SUI", b"Once a celebrated companion of humanity, this outcast droid's story unravels from technological relevance to societal oblivion.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_08_08_10_03_12_58c19fabe6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DRSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

