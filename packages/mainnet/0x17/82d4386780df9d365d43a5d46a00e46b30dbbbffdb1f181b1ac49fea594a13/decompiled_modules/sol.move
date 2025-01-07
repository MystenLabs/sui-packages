module 0x1782d4386780df9d365d43a5d46a00e46b30dbbbffdb1f181b1ac49fea594a13::sol {
    struct SOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOL>(arg0, 6, b"SOL", b"Solana", b"SOL just got an upgrade. Faster, cheaper and guess what, no MEV bots.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0052_0bbbbcbd67.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOL>>(v1);
    }

    // decompiled from Move bytecode v6
}

