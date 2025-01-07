module 0x3811c96dd493895c6c8f6c0cf44c88d02e7b26cee612779c78613fc884da980d::eddy {
    struct EDDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: EDDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EDDY>(arg0, 6, b"EDDY", b"EDDY Griffin", b"EDDY, a Family Guy-inspired memecoin with a custom-built AI, brings a unique voice to the crypto space. Created with sharp insight and a distinct style by Family Guys language model, Eddy is more than a coin; hes a clever, mischievous kid with a keen eye on the latest trends. With plans to expand across multiple blockchains, EDDY aims to reach and engage a broader audience within the crypto community.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/meme_bcdb241a04.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EDDY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EDDY>>(v1);
    }

    // decompiled from Move bytecode v6
}

