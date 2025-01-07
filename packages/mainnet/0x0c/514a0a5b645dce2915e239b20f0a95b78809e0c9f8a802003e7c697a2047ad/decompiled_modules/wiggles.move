module 0xc514a0a5b645dce2915e239b20f0a95b78809e0c9f8a802003e7c697a2047ad::wiggles {
    struct WIGGLES has drop {
        dummy_field: bool,
    }

    fun init(arg0: WIGGLES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WIGGLES>(arg0, 6, b"WIGGLES", b"Wiggles the Walrus", b"A fun, friendly mascot for the SUI blockchain, Wiggles is all about smooth transactions and effortless movement. Just like a walrus gliding through the water, Wiggles represents the fast, seamless experience of using SUI. With his playful nature and impressive tusks, he embodies the power and flexibility of the network, making the complex world of crypto feel approachable and fun.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/walrus_ede0b50370.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WIGGLES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WIGGLES>>(v1);
    }

    // decompiled from Move bytecode v6
}

