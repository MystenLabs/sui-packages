module 0xba7472b054e2a018294eeff85e843928762baab17f09ae1ca9321f2b0f966b0::afelix {
    struct AFELIX has drop {
        dummy_field: bool,
    }

    fun init(arg0: AFELIX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AFELIX>(arg0, 6, b"AFelix", b"aaaFelix", b"Felix the cat CTO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Felix_the_Cat_TV_series_title_174fd362d8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AFELIX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AFELIX>>(v1);
    }

    // decompiled from Move bytecode v6
}

