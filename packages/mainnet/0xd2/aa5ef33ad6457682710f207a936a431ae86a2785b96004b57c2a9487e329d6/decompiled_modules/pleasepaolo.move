module 0xd2aa5ef33ad6457682710f207a936a431ae86a2785b96004b57c2a9487e329d6::pleasepaolo {
    struct PLEASEPAOLO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLEASEPAOLO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLEASEPAOLO>(arg0, 6, b"PLEASEPAOLO", b"please deploy be paolo", b"my family is hungry man please faster", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lavender-gentle-primate-223.mypinata.cloud/ipfs/QmXvhs8oAS6A1KWDP9xfu9UDtxbUs1Tb7nbXHLfBTwFAdz?pinataGatewayToken=M45Jh03NicrVqTZJJhQIwDtl7G6fGS90bjJiIQrmyaQXC_xXj4BgRqjjBNyGV7q2")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PLEASEPAOLO>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLEASEPAOLO>>(v2, @0xa5b1611d756c1b2723df1b97782cacfd10c8f94df571935db87b7f54ef653d66);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PLEASEPAOLO>>(v1);
    }

    // decompiled from Move bytecode v6
}

