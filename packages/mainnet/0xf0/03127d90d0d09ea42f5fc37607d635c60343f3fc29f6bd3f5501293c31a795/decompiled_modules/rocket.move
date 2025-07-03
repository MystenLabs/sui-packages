module 0xf003127d90d0d09ea42f5fc37607d635c60343f3fc29f6bd3f5501293c31a795::rocket {
    struct ROCKET has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROCKET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROCKET>(arg0, 9, b"ROCKET", b"rocket", b"{\"description\":\"rocket in da house\",\"twitter\":\"https://twitter.com/rocket\",\"website\":\"https://rocket.com\",\"telegram\":\"https://t.me/rocket\",\"tags\":[\"rocket\",\"fire\"]}", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kappa-dev.sgp1.cdn.digitaloceanspaces.com/kappa-dev/coins/8babbac7-9d6e-42d8-98b4-ebf9ed8403c2.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ROCKET>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROCKET>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

