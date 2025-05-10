module 0x7cfa62056710be5085a17a8c8aa33706c4de1ebe7b4be9872d9a9ac1fa115151::afhinitiative {
    struct AFHINITIATIVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: AFHINITIATIVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AFHINITIATIVE>(arg0, 6, b"AFHInitiative", b"Action for Humanitarian Initiatives Uganda", b"NGO that serves to support women, orphans and other vulnerable children including the youth. These categories are considered vulnerable.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiedz47wvkvqvxkavbsncua5ftjbkfrj5mi3wvzvrhpsarpznzwteu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AFHINITIATIVE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AFHINITIATIVE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

