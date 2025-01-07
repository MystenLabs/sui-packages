module 0x42acf830fb324b95119a1c60cf1f7ae916bfc0881925e4397816712110393bd9::cch {
    struct CCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: CCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CCH>(arg0, 6, b"CCH", b"heekyChihuahua", b"Small body, big personality. CheekyChihuahua represents fearless warriors who break rules and take on challenges despite their size.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/CCH_3632e82e68.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CCH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CCH>>(v1);
    }

    // decompiled from Move bytecode v6
}

