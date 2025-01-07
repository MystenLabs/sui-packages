module 0x8bb90554b9470674be43988bf1f6dae72d1ece9621659d17c36d8468370cf2cf::mew {
    struct MEW has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEW>(arg0, 6, b"MEW", b"MeowWoof", b"MeowWoof isn't just some other meme coin. It's a symbol of unity, loyalty, ambition, and enthusiasm.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/meow_6c9a7c17aa.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEW>>(v1);
    }

    // decompiled from Move bytecode v6
}

