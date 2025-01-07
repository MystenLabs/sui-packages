module 0x557ace4d8790e996c09d49a9689b0be53fd59140db1804329f91ff5b272843e::pickle {
    struct PICKLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PICKLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PICKLE>(arg0, 6, b"Pickle", b"Magic Pickle", b"In the years before humankind when the internet had yet to be captured and enslaved, the wild entity was to roam freely and frolic in the meadows. Cyber wizards at the time had formulated a way to extract the internet into a liquid vinegar element without doing it any harm. The extraction took 5000 years and resulted in only 750ml of 100% pure distilled internet vinegar.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_03_15_19_36_3ccf84cf35.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PICKLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PICKLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

