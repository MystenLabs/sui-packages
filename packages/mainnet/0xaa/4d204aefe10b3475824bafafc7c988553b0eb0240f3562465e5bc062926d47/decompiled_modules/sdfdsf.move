module 0xaa4d204aefe10b3475824bafafc7c988553b0eb0240f3562465e5bc062926d47::sdfdsf {
    struct SDFDSF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDFDSF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDFDSF>(arg0, 6, b"sdfdsf", b"thfgd", b"gfhf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lavender-gentle-primate-223.mypinata.cloud/ipfs/QmSWsdgiBtTdi5ZHoW4dMhmYyPt7v86BT1rzpVeqDXpPdd?pinataGatewayToken=M45Jh03NicrVqTZJJhQIwDtl7G6fGS90bjJiIQrmyaQXC_xXj4BgRqjjBNyGV7q2")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SDFDSF>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDFDSF>>(v2, @0xa5b1611d756c1b2723df1b97782cacfd10c8f94df571935db87b7f54ef653d66);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SDFDSF>>(v1);
    }

    // decompiled from Move bytecode v6
}

