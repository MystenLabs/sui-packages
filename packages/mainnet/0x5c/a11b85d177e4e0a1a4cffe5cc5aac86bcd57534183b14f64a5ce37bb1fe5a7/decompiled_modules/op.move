module 0x5ca11b85d177e4e0a1a4cffe5cc5aac86bcd57534183b14f64a5ce37bb1fe5a7::op {
    struct OP has drop {
        dummy_field: bool,
    }

    fun init(arg0: OP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OP>(arg0, 6, b"OP", b"One Piece", b"In the vibrant Sui ecosystem, Monkey D. Luffy and his crew navigate a decentralized world powered by blockchain, seeking the legendary \"One Piece,\" a treasure rumored to unlock ultimate sovereignty over the digital seas.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732502426623.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

