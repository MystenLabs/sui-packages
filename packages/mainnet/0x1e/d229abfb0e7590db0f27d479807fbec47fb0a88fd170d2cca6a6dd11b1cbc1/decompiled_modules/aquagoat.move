module 0x1ed229abfb0e7590db0f27d479807fbec47fb0a88fd170d2cca6a6dd11b1cbc1::aquagoat {
    struct AQUAGOAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: AQUAGOAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AQUAGOAT>(arg0, 9, b"AQUAGOAT", b"Aqua Goat", b"AQUAGOAT IS MEME NUMBER 0.1 FROM 20W2", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.app.goo.gl/A94Tq76eu5NQ4LAy5")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<AQUAGOAT>(&mut v2, 6666699999000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AQUAGOAT>>(v2, @0xd7dd7cb48e6ba0d32574354254a28a5cf996b1a041c95a20f4cbc51bfe5b0739);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AQUAGOAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

