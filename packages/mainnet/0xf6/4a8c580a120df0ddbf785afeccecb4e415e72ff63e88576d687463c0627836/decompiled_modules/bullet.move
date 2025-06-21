module 0xf64a8c580a120df0ddbf785afeccecb4e415e72ff63e88576d687463c0627836::bullet {
    struct BULLET has drop {
        dummy_field: bool,
    }

    fun init(arg0: BULLET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BULLET>(arg0, 9, b"BULLET", b"Bullets", b"@PEWMARKETSBOT ON TELEGRAM", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://magenta-rainy-scallop-849.mypinata.cloud/ipfs/bafybeieurl5qmmxtrx3qhykiuc4w2katbcdczqir4prum42crkr5kko25u")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BULLET>(&mut v2, 5500000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BULLET>>(v2, @0x6d5ebb378475aa26dd5dcddd42ab00cf6005385bf344c89fca55fda576e37b24);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BULLET>>(v1);
    }

    // decompiled from Move bytecode v6
}

