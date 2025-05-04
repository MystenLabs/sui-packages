module 0x923bb8e3f6d3abac0c0dc1aafef082757d44ad0c7220c581fac5c66c525d35aa::zonkster {
    struct ZONKSTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZONKSTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZONKSTER>(arg0, 9, b"ZONKS", b"Zonkster", b"For those who press buy and immediately nap. Zonkster never panics, always snoozes through the mooning.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeie4zcjfxt6lepy4fa6spy3i2yun54mqoit6hq4j3ifhswceyox4si")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ZONKSTER>(&mut v2, 1000000000000000000, @0xae42d2ec4d8ad9708972e523c8aad72bdd89ee7df04afc8a221545ac9577763c, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZONKSTER>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZONKSTER>>(v1);
    }

    // decompiled from Move bytecode v6
}

