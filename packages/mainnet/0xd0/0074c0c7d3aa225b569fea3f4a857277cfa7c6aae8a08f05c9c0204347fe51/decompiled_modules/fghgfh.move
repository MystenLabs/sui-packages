module 0xd00074c0c7d3aa225b569fea3f4a857277cfa7c6aae8a08f05c9c0204347fe51::fghgfh {
    struct FGHGFH has drop {
        dummy_field: bool,
    }

    fun init(arg0: FGHGFH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FGHGFH>(arg0, 6, b"fghgfh", b"hgjgh", b"fghfgh", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lavender-gentle-primate-223.mypinata.cloud/ipfs/QmSWsdgiBtTdi5ZHoW4dMhmYyPt7v86BT1rzpVeqDXpPdd?pinataGatewayToken=M45Jh03NicrVqTZJJhQIwDtl7G6fGS90bjJiIQrmyaQXC_xXj4BgRqjjBNyGV7q2")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FGHGFH>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FGHGFH>>(v2, @0x8d186303aac66396cd1ae3d31a6b0c8779b7b439815f1f373151290c5bf0cfa1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FGHGFH>>(v1);
    }

    // decompiled from Move bytecode v6
}

