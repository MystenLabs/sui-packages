module 0x8c63728d38eb9a57a5b618795943fa710ff9a6556e1c278330edbf590f1160f1::fag {
    struct FAG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FAG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAG>(arg0, 6, b"FAG", b"Faggot", b"You sell youre gay", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lavender-gentle-primate-223.mypinata.cloud/ipfs/QmVdCYuhdXPZoZQBu69MD59bYEEANHodrQYaBDVHFoQmkk?pinataGatewayToken=M45Jh03NicrVqTZJJhQIwDtl7G6fGS90bjJiIQrmyaQXC_xXj4BgRqjjBNyGV7q2")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FAG>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FAG>>(v2, @0x2b2cde18872350ee38c47ec524cf966b60deb17e505eea8b3df7f527b6bd7982);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FAG>>(v1);
    }

    // decompiled from Move bytecode v6
}

