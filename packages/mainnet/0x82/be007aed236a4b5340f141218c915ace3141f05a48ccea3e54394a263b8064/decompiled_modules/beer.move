module 0x82be007aed236a4b5340f141218c915ace3141f05a48ccea3e54394a263b8064::beer {
    struct BEER has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEER>(arg0, 6, b"BEER", b"King of Sui Beers", b"Find Your Beach: Suronia Beer", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/corona_2bfa9de409.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BEER>>(v1);
    }

    // decompiled from Move bytecode v6
}

