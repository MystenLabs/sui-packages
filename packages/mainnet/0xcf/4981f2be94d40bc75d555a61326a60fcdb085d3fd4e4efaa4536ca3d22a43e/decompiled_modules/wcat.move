module 0xcf4981f2be94d40bc75d555a61326a60fcdb085d3fd4e4efaa4536ca3d22a43e::wcat {
    struct WCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: WCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WCAT>(arg0, 6, b"WCAT", b"Watermelon Cat", b"A cute Watermelon Cat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lavender-gentle-primate-223.mypinata.cloud/ipfs/QmWD2bKzoFacZkzfAP6PgScxKN5zwDqFLsdZ3S43zZP12L?pinataGatewayToken=M45Jh03NicrVqTZJJhQIwDtl7G6fGS90bjJiIQrmyaQXC_xXj4BgRqjjBNyGV7q2")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<WCAT>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WCAT>>(v2, @0x69dcc36ff42c17ba3346a37896d92da19e990637b745ebd70a5d86815163115);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

