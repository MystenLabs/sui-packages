module 0x418a9da6fc51ca01d1a1e8cbb968e3afafc18bfc3cd6fcba076e46ca73831d77::ifykykhaha {
    struct IFYKYKHAHA has drop {
        dummy_field: bool,
    }

    fun init(arg0: IFYKYKHAHA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IFYKYKHAHA>(arg0, 6, b"ifykykhaha", b"ifykyk", b"ifykyk3", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lavender-gentle-primate-223.mypinata.cloud/ipfs/QmRcKt4aLmePXVpuhnBMXTtwKZAxFQKEnpWpn9BJkM3g46?pinataGatewayToken=M45Jh03NicrVqTZJJhQIwDtl7G6fGS90bjJiIQrmyaQXC_xXj4BgRqjjBNyGV7q2")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<IFYKYKHAHA>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IFYKYKHAHA>>(v2, @0xa5b1611d756c1b2723df1b97782cacfd10c8f94df571935db87b7f54ef653d66);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IFYKYKHAHA>>(v1);
    }

    // decompiled from Move bytecode v6
}

