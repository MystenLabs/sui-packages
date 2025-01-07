module 0xbfd7c07392e2a9a61919f7c7ab694eb6a58787266242b3465b1b268a43c8606b::csy {
    struct CSY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CSY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CSY>(arg0, 6, b"CSY", b"Chansy", b"Chansey :0", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lavender-gentle-primate-223.mypinata.cloud/ipfs/QmVMySZ5M4fwRs3pMj5efdK6ydYd9GBF5w1y1bWdQPAzED?pinataGatewayToken=M45Jh03NicrVqTZJJhQIwDtl7G6fGS90bjJiIQrmyaQXC_xXj4BgRqjjBNyGV7q2")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CSY>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CSY>>(v2, @0x9f279c8467608d6aa55c9514135bb4921a5faf0c6335e3b3e5096ac7cb1cd251);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CSY>>(v1);
    }

    // decompiled from Move bytecode v6
}

