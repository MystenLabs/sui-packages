module 0x2e700447d0fb488fb5145ba870e77c26e7ba4b4ca54cb809859844e8edeff2ed::nye {
    struct NYE has drop {
        dummy_field: bool,
    }

    fun init(arg0: NYE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NYE>(arg0, 9, b"NYE", b"New Years Eve", b"New Years Eve meme token on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/Qme45Tq22VpxbLcc2u2FLhxcfvAuxyFiUUyVSQvFX4vLZt")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<NYE>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NYE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NYE>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

