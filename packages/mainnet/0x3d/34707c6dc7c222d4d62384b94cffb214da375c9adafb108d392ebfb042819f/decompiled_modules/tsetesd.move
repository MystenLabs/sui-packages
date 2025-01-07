module 0x3d34707c6dc7c222d4d62384b94cffb214da375c9adafb108d392ebfb042819f::tsetesd {
    struct TSETESD has drop {
        dummy_field: bool,
    }

    fun init(arg0: TSETESD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TSETESD>(arg0, 6, b"tsetesd", b"testsetest", b"etset", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lavender-gentle-primate-223.mypinata.cloud/ipfs/QmSWsdgiBtTdi5ZHoW4dMhmYyPt7v86BT1rzpVeqDXpPdd?pinataGatewayToken=M45Jh03NicrVqTZJJhQIwDtl7G6fGS90bjJiIQrmyaQXC_xXj4BgRqjjBNyGV7q2")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TSETESD>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TSETESD>>(v2, @0xa5b1611d756c1b2723df1b97782cacfd10c8f94df571935db87b7f54ef653d66);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TSETESD>>(v1);
    }

    // decompiled from Move bytecode v6
}

