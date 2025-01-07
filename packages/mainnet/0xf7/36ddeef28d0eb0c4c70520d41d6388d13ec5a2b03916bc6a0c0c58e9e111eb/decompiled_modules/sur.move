module 0xf736ddeef28d0eb0c4c70520d41d6388d13ec5a2b03916bc6a0c0c58e9e111eb::sur {
    struct SUR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUR>(arg0, 6, b"Sur", b"25/12/24Surprise", b"No TG, X and Web links will be available. It's just a MEME isn't it?. I am going to buy my 8 sui worthy of tokens and that is it. Have fun ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_8412_5005eacb3a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUR>>(v1);
    }

    // decompiled from Move bytecode v6
}

