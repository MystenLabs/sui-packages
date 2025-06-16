module 0xc484c8788c3626230bb8fe21048e3d02a9a6fb11a7a7589a6fb7d25426e5701f::moon {
    struct MOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOON>(arg0, 6, b"MOON", b"Moonpig Sui", b"Oing Oing", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreie3xtw5st2dxuwu6ruqfuhfuzfb3zdvsjnijyurp2topsxuwljlni")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MOON>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

