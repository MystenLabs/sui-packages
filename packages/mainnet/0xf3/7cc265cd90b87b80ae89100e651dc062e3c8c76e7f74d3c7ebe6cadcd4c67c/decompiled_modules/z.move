module 0xf37cc265cd90b87b80ae89100e651dc062e3c8c76e7f74d3c7ebe6cadcd4c67c::z {
    struct Z has drop {
        dummy_field: bool,
    }

    fun init(arg0: Z, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<Z>(arg0, 9, b"Z", b"Zee", b"Testing", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.vecteezy.com/vector-art/2172884-elegant-and-luxury-letter-z-infinity-logo-classy-infinity-with-initial-z-letter-logo-template")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<Z>(&mut v2, 100000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<Z>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<Z>>(v1);
    }

    // decompiled from Move bytecode v6
}

