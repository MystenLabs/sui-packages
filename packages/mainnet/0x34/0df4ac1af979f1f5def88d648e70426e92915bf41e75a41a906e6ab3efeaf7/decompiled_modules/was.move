module 0x340df4ac1af979f1f5def88d648e70426e92915bf41e75a41a906e6ab3efeaf7::was {
    struct WAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAS>(arg0, 1, b"WAS", b"Washington Bullets", b"Mb5 sports team", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://arivmarketplace.sirv.com/Restaurant%20Images/sui.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<WAS>(&mut v2, 10000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAS>>(v2, @0x2a45e366fcdc28761c83fd2ee9ba81c7e7af31d1fba5d80519b0c23e4a1a71cb);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

