module 0xab455f69b8fb2bb84f5c8d302475cd1e73556d4ddda1808529ab9aa7214af4a7::smea {
    struct SMEA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMEA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMEA>(arg0, 6, b"SMEA", b"smeagol", b"Smeagol the troll of all time", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lavender-gentle-primate-223.mypinata.cloud/ipfs/QmVwx73Sp6PskUnsAtmsxcgoJmEN1uSCQMjyKmkZKoScj8?pinataGatewayToken=M45Jh03NicrVqTZJJhQIwDtl7G6fGS90bjJiIQrmyaQXC_xXj4BgRqjjBNyGV7q2")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SMEA>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMEA>>(v2, @0x6676f8f1576988f735adeaf93772a86dc96c4ca4660ba301db4fd82b5afd0f12);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMEA>>(v1);
    }

    // decompiled from Move bytecode v6
}

