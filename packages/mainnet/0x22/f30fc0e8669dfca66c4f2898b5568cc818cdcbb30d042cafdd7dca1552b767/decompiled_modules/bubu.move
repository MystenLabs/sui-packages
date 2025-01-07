module 0x22f30fc0e8669dfca66c4f2898b5568cc818cdcbb30d042cafdd7dca1552b767::bubu {
    struct BUBU has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUBU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUBU>(arg0, 6, b"BUBU", b"SUI BUBU", b"Bubu is already known by many people around the world as a cute and finest meme, but it hasn't found a place on the blockchains yet. So, everyone, please support Sui Bubu so it can become an iconic meme on SUI NETWORK", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_10_a4bdea8677.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUBU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUBU>>(v1);
    }

    // decompiled from Move bytecode v6
}

