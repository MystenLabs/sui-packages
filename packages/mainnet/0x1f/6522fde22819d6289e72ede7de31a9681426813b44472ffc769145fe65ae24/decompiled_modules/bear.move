module 0x1f6522fde22819d6289e72ede7de31a9681426813b44472ffc769145fe65ae24::bear {
    struct BEAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEAR>(arg0, 6, b"BEAR", b"Blue Bear", b"Blue Bear is the token that brings the spirit of strength and serenity to the Sui Chain. Inspired by a blue bear, it combines stability and innovation, offering secure and lasting opportunities in the crypto universe.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/blue_bear_logo_265968d3e2.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BEAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

