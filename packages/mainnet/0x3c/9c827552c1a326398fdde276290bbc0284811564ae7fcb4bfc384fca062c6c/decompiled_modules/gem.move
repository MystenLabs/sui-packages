module 0x3c9c827552c1a326398fdde276290bbc0284811564ae7fcb4bfc384fca062c6c::gem {
    struct GEM has drop {
        dummy_field: bool,
    }

    fun init(arg0: GEM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GEM>(arg0, 6, b"GEM", b"Grand Egyptian Museum", b"The Grand Egyptian Museum (GEM; Arabic:    al-Mataf al-Mariyy al-Kabr), also known as the Giza Museum, is an archaeological museum under construction in Giza, Egypt, about 2 kilometres (1.2 miles) from the Giza pyramid complex. The Museum will host over 100,000 artifacts from ancient Egyptian civilization, including the complete Tutankhamun collection, and many pieces will be displayed for the first time. With 81,000 m2 (872,000 sq ft) of floor space, it will be the world's largest archeological museum. It is being built as part of a new master plan for the Giza Plateau, known as \"Giza 2030\".", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/TUTNKAMON_58031f1522.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GEM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GEM>>(v1);
    }

    // decompiled from Move bytecode v6
}

