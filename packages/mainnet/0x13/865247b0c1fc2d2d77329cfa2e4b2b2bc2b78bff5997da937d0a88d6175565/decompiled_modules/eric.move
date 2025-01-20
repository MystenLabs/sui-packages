module 0x13865247b0c1fc2d2d77329cfa2e4b2b2bc2b78bff5997da937d0a88d6175565::eric {
    struct ERIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: ERIC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ERIC>(arg0, 6, b"ERIC", b"Eric Meme", b"unOfficial Eric Trump Token. Eric is following Sui. It's time for Sui to pump. Those who believe in Sui's vision, buy and hold. $Sui and $ERIC will make you rich. There is no initial site. This pursues the CTO token.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/EFS_2a1bc5b1bc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ERIC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ERIC>>(v1);
    }

    // decompiled from Move bytecode v6
}

