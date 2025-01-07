module 0x6db40f5b434af5a94d51c726eb3ab55b5d0877a290d276154e5de11b912ba872::owo {
    struct OWO has drop {
        dummy_field: bool,
    }

    fun init(arg0: OWO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OWO>(arg0, 6, b"OWO", b"OWO", b"Memeable owo cat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lavender-gentle-primate-223.mypinata.cloud/ipfs/QmXB1G2NKqVPFW3fCLgDnLrjxFTQ3HtcXmk9idHqT1SA3S?pinataGatewayToken=M45Jh03NicrVqTZJJhQIwDtl7G6fGS90bjJiIQrmyaQXC_xXj4BgRqjjBNyGV7q2")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<OWO>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OWO>>(v2, @0xfd027529d044b9555ab919378bf6af8efe30e6b03ec79be23d57fe6fc9caab61);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OWO>>(v1);
    }

    // decompiled from Move bytecode v6
}

