module 0x4cdc6c06f5423dcc56b39d5ddda3e00c7c8e9e23d26247243aff235cda247ff2::betty {
    struct BETTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BETTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BETTY>(arg0, 9, b"BETTY", b"BETTY ON BOOP", b"BETTY meme token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://mainnet-boop.s3.us-east-1.amazonaws.com/6N7CrWe6qNt27G4sHXcjQMMy6btKRb7i9n4RYkKboop/f7c32bd8a66325cc76595563af405c911919e63c9d7359cb890f96d9aa752878.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BETTY>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BETTY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BETTY>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

