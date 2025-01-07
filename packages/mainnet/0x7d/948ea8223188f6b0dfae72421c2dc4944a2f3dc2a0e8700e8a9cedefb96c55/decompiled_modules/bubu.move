module 0x7d948ea8223188f6b0dfae72421c2dc4944a2f3dc2a0e8700e8a9cedefb96c55::bubu {
    struct BUBU has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUBU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUBU>(arg0, 6, b"BUBU", b"SUIBUBU", b"Bubu is already known by many people around the world as a cute and finest meme, but it hasn't found a place on the blockchains yet. So, everyone, please support Sui Bubu so it can become an iconic meme on SUI NETWOR", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000037898_0d509a78be.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUBU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUBU>>(v1);
    }

    // decompiled from Move bytecode v6
}

