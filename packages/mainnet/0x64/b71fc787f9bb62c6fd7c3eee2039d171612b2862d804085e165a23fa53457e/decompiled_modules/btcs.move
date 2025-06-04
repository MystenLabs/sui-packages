module 0x64b71fc787f9bb62c6fd7c3eee2039d171612b2862d804085e165a23fa53457e::btcs {
    struct BTCS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTCS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BTCS>(arg0, 9, b"BTCS", b"BTCS", b"MY BTCS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://strapi-dev.scand.app/uploads/Bitcoin_svg_3d3d928a26.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BTCS>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BTCS>>(v2, @0x29c6b6986a1d607fae0f0efcd934fd91adda350f5c7c561ec2f268b24f2f141a);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BTCS>>(v1);
    }

    // decompiled from Move bytecode v6
}

