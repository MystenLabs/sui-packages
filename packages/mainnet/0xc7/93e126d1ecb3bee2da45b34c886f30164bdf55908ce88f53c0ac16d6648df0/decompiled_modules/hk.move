module 0xc793e126d1ecb3bee2da45b34c886f30164bdf55908ce88f53c0ac16d6648df0::hk {
    struct HK has drop {
        dummy_field: bool,
    }

    fun init(arg0: HK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HK>(arg0, 6, b"HK", b"Hello Kitty", b"hellokitty", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lavender-gentle-primate-223.mypinata.cloud/ipfs/QmYWX3iBBTQrVuQgANf16QRbV4pZYVy5PYuwc54SdY9irj?pinataGatewayToken=M45Jh03NicrVqTZJJhQIwDtl7G6fGS90bjJiIQrmyaQXC_xXj4BgRqjjBNyGV7q2")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HK>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HK>>(v2, @0xc77dc69c8550c4b5033e76720351935fd4bc4315a2b97b2bd65b7ca97fa690c0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HK>>(v1);
    }

    // decompiled from Move bytecode v6
}

