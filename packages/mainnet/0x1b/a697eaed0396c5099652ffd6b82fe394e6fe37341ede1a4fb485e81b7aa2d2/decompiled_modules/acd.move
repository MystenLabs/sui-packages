module 0x1ba697eaed0396c5099652ffd6b82fe394e6fe37341ede1a4fb485e81b7aa2d2::acd {
    struct ACD has drop {
        dummy_field: bool,
    }

    fun init(arg0: ACD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ACD>(arg0, 6, b"ACD", b"Altcoindaily", b"Social crypto Influencer coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20240919_194634_85bfed24d9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ACD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ACD>>(v1);
    }

    // decompiled from Move bytecode v6
}

