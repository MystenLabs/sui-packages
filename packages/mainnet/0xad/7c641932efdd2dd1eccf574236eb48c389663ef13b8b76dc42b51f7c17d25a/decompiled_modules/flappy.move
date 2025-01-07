module 0xad7c641932efdd2dd1eccf574236eb48c389663ef13b8b76dc42b51f7c17d25a::flappy {
    struct FLAPPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLAPPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLAPPY>(arg0, 6, b"FLAPPY", b"Flappy On Sui", x"4465736372697074696f6e3a0a49747320666c6170206f72206661696c2120466c617070797320676f742077696e6773206f6620737465656c2c20616e6420796f7520626574746572206b656570207570207769746820746865206372617a6965737420636f696e207275736820746869732073696465206f662074686520626c6f636b636861696e21", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000048479_bb97906d83.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLAPPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLAPPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

