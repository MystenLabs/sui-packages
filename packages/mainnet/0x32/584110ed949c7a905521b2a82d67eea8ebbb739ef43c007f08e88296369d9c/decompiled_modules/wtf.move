module 0x32584110ed949c7a905521b2a82d67eea8ebbb739ef43c007f08e88296369d9c::wtf {
    struct WTF has drop {
        dummy_field: bool,
    }

    fun init(arg0: WTF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WTF>(arg0, 6, b"WTF", b"Meme Games WTF", b" Worlds First Web3 Meme Games Platform on Sol and Sui blockchains", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6329_d38219b772.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WTF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WTF>>(v1);
    }

    // decompiled from Move bytecode v6
}

