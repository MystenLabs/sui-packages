module 0x15b64f06f29c98b66871aa2904481b55f8171eb661eccc978d8a0d59ef114795::deepdive {
    struct DEEPDIVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEEPDIVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEEPDIVE>(arg0, 6, b"DeepDive", b"DeepDive on sui", b"With the strong development of the cryptocurrency and AI market, DeepDevisui can bring attractive profits to investors.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2025_01_05_08_35_06_c864aaab0a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEEPDIVE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DEEPDIVE>>(v1);
    }

    // decompiled from Move bytecode v6
}

