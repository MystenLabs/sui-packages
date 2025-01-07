module 0x54dc9085541f7afef5fea35a3863dee6f99074ebb95c393beccf853ed6e0b747::kenji {
    struct KENJI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KENJI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KENJI>(arg0, 6, b"KENJI", b"Kenji On Sui", b"Welcome to the world of $KENJI, a unique meme token that combines the love for dogs with the excitement of cryptocurrency .", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1724382194919_38d18513b87f07b57b35b9fbf9d99afe_3485294063.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KENJI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KENJI>>(v1);
    }

    // decompiled from Move bytecode v6
}

