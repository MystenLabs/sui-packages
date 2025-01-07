module 0x20a8146f75958cc5993c55a4fdbf79e900daa7ff8d11d52c21bddbbbb0c5e520::kwif {
    struct KWIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: KWIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KWIF>(arg0, 6, b"kwif", b"KotaroWifHat", b"Just a roly poly kotaro wif hat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lavender-gentle-primate-223.mypinata.cloud/ipfs/QmQgGeSFE4C3fG1x8v6G1VjAnMndr5BzJNdZvo9qEPUFj7?pinataGatewayToken=M45Jh03NicrVqTZJJhQIwDtl7G6fGS90bjJiIQrmyaQXC_xXj4BgRqjjBNyGV7q2")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<KWIF>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KWIF>>(v2, @0x1622d4e37f62561ebd33e1160b01dfafb547bb615b125c8f34f27ae846d14c33);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KWIF>>(v1);
    }

    // decompiled from Move bytecode v6
}

