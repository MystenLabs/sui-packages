module 0x5fb06abe3a55ca303ac75314cf4a4ea404d52110f6323a562f99b796d38d86d6::poo {
    struct POO has drop {
        dummy_field: bool,
    }

    fun init(arg0: POO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POO>(arg0, 6, b"POO", b"Sui Poo", b"Blue poops pooped by Sui hodlers.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Blue_Poop_Emoji_9e8b48ae3b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POO>>(v1);
    }

    // decompiled from Move bytecode v6
}

