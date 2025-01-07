module 0x928d8f276dc47b34bda65804e3757153236fbb68f6096de32d7dbf6122778b31::ff {
    struct FF has drop {
        dummy_field: bool,
    }

    fun init(arg0: FF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FF>(arg0, 6, b"FF", b"Fartcoin", b"#FF Before you shit there is a fart, before a shitcoin is $FartCoin ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/my_JWUJUQ_400x400_53fd30eca0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FF>>(v1);
    }

    // decompiled from Move bytecode v6
}

