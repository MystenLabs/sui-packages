module 0x5abd777c4daaa898adaaacf97c690c9c9e27dafdaf42733367f3d2545a3fd6d3::suicats {
    struct SUICATS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICATS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICATS>(arg0, 6, b"SUICATS", b"SuicatsOnSui", b"$Suicats is an ambitious project on the sui network based on cat lovers around the world", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000260_2fe3330c9c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICATS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICATS>>(v1);
    }

    // decompiled from Move bytecode v6
}

