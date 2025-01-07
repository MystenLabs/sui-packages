module 0x4d6b697b023acafa60dd0905d959c3e4211f29001c966ac7ea5861de2d10874d::unto {
    struct UNTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: UNTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UNTO>(arg0, 9, b"UNTO", b"Universe Token", b"Universe Token is a platform empowering university students to overcome financial challenges. By turning small amounts of money into potential profits, students can address their financial needs. Our app connects students with local manufacturers and allows them to buy and sell goods within their campus community. Through trading, in-app tasks, and earning our token, students can generate additional income. We believe that by starting small and utilizing available resources, students can build financial resilience and achieve their academic goals.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<UNTO>(&mut v2, 12000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UNTO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UNTO>>(v1);
    }

    // decompiled from Move bytecode v6
}

