module 0x8416345428526e5e80efe3beb9b134e822bd388f761b868dc2919517336cd0f7::elon {
    struct ELON has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELON>(arg0, 6, b"ELON", b"Meme Czar (ELON)", b"KING of MEMES", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734933449028.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ELON>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELON>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

