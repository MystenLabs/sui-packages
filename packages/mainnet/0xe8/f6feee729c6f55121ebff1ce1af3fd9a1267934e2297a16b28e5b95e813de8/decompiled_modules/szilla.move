module 0xe8f6feee729c6f55121ebff1ce1af3fd9a1267934e2297a16b28e5b95e813de8::szilla {
    struct SZILLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SZILLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SZILLA>(arg0, 9, b"SZILLA", b"Sui Zilla", b"Zilla Is Meme Token On sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1845542208927301632/1Y3j59r2.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SZILLA>(&mut v2, 666000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SZILLA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SZILLA>>(v1);
    }

    // decompiled from Move bytecode v6
}

