module 0x7af05e90dea5b3e966a74b773c0732c6634381fa6b732d82ee7d97044052390d::weow {
    struct WEOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEOW>(arg0, 6, b"Weow", b"Weow", x"436f6d6d756e6973742070757373790a576520646f6e2774206d656f77206d656f772077652077656f772077656f772077656f772077656f772077656f772077656f772077656f772077656f772077656f772077656f772077656f772077656f772077656f772077656f772077656f772077656f772077656f772077656f770a0a2d4c656e696e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lavender-gentle-primate-223.mypinata.cloud/ipfs/Qma8z2XFog4LcQk6kvjJM5rJ8w75nwTQ7C9Yzm1ixWGV5k?pinataGatewayToken=M45Jh03NicrVqTZJJhQIwDtl7G6fGS90bjJiIQrmyaQXC_xXj4BgRqjjBNyGV7q2")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<WEOW>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEOW>>(v2, @0xf1ce321a2017abb89398884d430e9cb8e38480d334a6d04129c6855a5d0fdd7f);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WEOW>>(v1);
    }

    // decompiled from Move bytecode v6
}

