module 0xafe01ef5ec7ac7876b96bc1c43fd85b77463e87493dbdabf6825b4ee64fad::usdt_ {
    struct USDT_ has drop {
        dummy_field: bool,
    }

    fun init(arg0: USDT_, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USDT_>(arg0, 9, b"USDT ", b"Tatr USD", b"yulezhuanyong", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/bafkreicbmczfunilkzp7c73sl7bfbar2jncttdixne2pvl73powk33x4k4")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<USDT_>(&mut v2, 68808650000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USDT_>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<USDT_>>(v1);
    }

    // decompiled from Move bytecode v6
}

