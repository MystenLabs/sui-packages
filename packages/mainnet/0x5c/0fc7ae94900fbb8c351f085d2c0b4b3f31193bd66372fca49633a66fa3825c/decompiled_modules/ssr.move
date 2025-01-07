module 0x5c0fc7ae94900fbb8c351f085d2c0b4b3f31193bd66372fca49633a66fa3825c::ssr {
    struct SSR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSR>(arg0, 6, b"SSR", b"Sui Silk Road", b"History can repeat itself again and again", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Road_131bba32a4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SSR>>(v1);
    }

    // decompiled from Move bytecode v6
}

