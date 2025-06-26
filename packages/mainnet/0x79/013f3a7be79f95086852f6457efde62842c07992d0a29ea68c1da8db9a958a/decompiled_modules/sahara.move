module 0x79013f3a7be79f95086852f6457efde62842c07992d0a29ea68c1da8db9a958a::sahara {
    struct SAHARA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAHARA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAHARA>(arg0, 8, b"SAHARA", b"SAHARA AI", x"4275696c642c20436f6e7472696275746520746f2c20616e64204d6f6e6574697a652041492e0a0a46756c6c2d737461636b2c204149206e617469766520626c6f636b636861696e20706c6174666f726d20746f20616363656c657261746520616e2041492d64726976656e206675747572652c206f70656e20616e642061636365737369626c6520746f20616c6c", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://storage.slaunch.xyz/assets/tokens/c4e4ffac-a683-485f-af78-d824d23525db.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SAHARA>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAHARA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAHARA>>(v1);
    }

    // decompiled from Move bytecode v6
}

