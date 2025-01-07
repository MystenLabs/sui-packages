module 0x3ed852dcc91f6beb8fab368fbb5d9c60052351bf33c8ee361fe28a1f24f7c0f9::spx5 {
    struct SPX5 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPX5, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPX5>(arg0, 6, b"SPX5", b"SpaceX 5", b"\"A Meme coin that embodies the exploratory spirit of SpaceX's fifth launch, aiming to spearhead a space exploration craze in the digital currency realm.\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6793_b6b012e7e6.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPX5>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPX5>>(v1);
    }

    // decompiled from Move bytecode v6
}

