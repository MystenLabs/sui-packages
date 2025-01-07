module 0x523c3c19ead8c4925f7745e931ac37767899a073b70588c1ca780f24a78a6dc4::sdfgfsdfgfds {
    struct SDFGFSDFGFDS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDFGFSDFGFDS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDFGFSDFGFDS>(arg0, 6, b"sdfgfsdfgfds", b"dsfgsdfg", b"ddsfgsdfg", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lavender-gentle-primate-223.mypinata.cloud/ipfs/QmVo22JSSm1eY79ix3NkfbcbZ9CwskUX3qx7aFJE17j5J1?pinataGatewayToken=M45Jh03NicrVqTZJJhQIwDtl7G6fGS90bjJiIQrmyaQXC_xXj4BgRqjjBNyGV7q2")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SDFGFSDFGFDS>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDFGFSDFGFDS>>(v2, @0xa5b1611d756c1b2723df1b97782cacfd10c8f94df571935db87b7f54ef653d66);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SDFGFSDFGFDS>>(v1);
    }

    // decompiled from Move bytecode v6
}

