module 0x77e8ceb1be38d05c0cbb0057a8f3395d669ebfb5003504900d518caa48558d44::sc {
    struct SC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SC>(arg0, 6, b"SC", b"Shark Cat", x"4974e2809973206120736861726b202c206974e2809973206120636174202c206974e2809973206120736861726b206361742e205468652063757465737420636174206f6e207375692e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lavender-gentle-primate-223.mypinata.cloud/ipfs/QmQn8USnKpBCHgCD5QFy3wy6BfHxmyL81Atxd1HLKYEZiT?pinataGatewayToken=M45Jh03NicrVqTZJJhQIwDtl7G6fGS90bjJiIQrmyaQXC_xXj4BgRqjjBNyGV7q2")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SC>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SC>>(v2, @0xaf0e5d3f64d77e9bf68df53087de9d81f757961c701217d94a2d6092087d8ee9);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SC>>(v1);
    }

    // decompiled from Move bytecode v6
}

