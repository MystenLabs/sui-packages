module 0x946a03eb496cece70b05f26e9f8bde47e5a339789611c8210bba8e0667d7fdd::ccat {
    struct CCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CCAT>(arg0, 6, b"CCAT", b"Croc Cat", b"A croc cat setting waves on sui chain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lavender-gentle-primate-223.mypinata.cloud/ipfs/QmfW1AZ7XLntuvMtcnk6ZK2nL9HxGfXK2jfvTAEX7m6Tk5?pinataGatewayToken=M45Jh03NicrVqTZJJhQIwDtl7G6fGS90bjJiIQrmyaQXC_xXj4BgRqjjBNyGV7q2")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CCAT>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CCAT>>(v2, @0x2530b803f60cbccf88bdc9b2b0d22315dcc295b85be95891d7c8e49440030b50);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

