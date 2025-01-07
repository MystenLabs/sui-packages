module 0x38415f9abbfaf25c76408221d05cff4eba47dee496d922fffa1212cad62e913::nazi {
    struct NAZI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NAZI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NAZI>(arg0, 6, b"nazi", b"nazi meme coin", b"nazi meme coin nazi meme coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lavender-gentle-primate-223.mypinata.cloud/ipfs/QmVo22JSSm1eY79ix3NkfbcbZ9CwskUX3qx7aFJE17j5J1?pinataGatewayToken=M45Jh03NicrVqTZJJhQIwDtl7G6fGS90bjJiIQrmyaQXC_xXj4BgRqjjBNyGV7q2")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<NAZI>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NAZI>>(v2, @0xa5b1611d756c1b2723df1b97782cacfd10c8f94df571935db87b7f54ef653d66);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NAZI>>(v1);
    }

    // decompiled from Move bytecode v6
}

