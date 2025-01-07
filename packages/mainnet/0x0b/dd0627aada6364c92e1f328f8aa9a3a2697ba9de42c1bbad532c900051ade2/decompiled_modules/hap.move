module 0xbdd0627aada6364c92e1f328f8aa9a3a2697ba9de42c1bbad532c900051ade2::hap {
    struct HAP has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAP>(arg0, 6, b"HAP", b"Happy", b"Happy coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lavender-gentle-primate-223.mypinata.cloud/ipfs/QmPaAgNwaYwdsXeKf4pes4n9fziXUXjGuCiBzu5TVYjyoJ?pinataGatewayToken=M45Jh03NicrVqTZJJhQIwDtl7G6fGS90bjJiIQrmyaQXC_xXj4BgRqjjBNyGV7q2")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HAP>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAP>>(v2, @0x3f7efe2d67c1acfea60ae036d1a7492a9c931ea0655039252fb977fb7536e651);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HAP>>(v1);
    }

    // decompiled from Move bytecode v6
}

