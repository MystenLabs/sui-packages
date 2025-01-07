module 0x93eb07d667a583656c52dfae2a5874d4ab461e2410ba4c8b5cf49d67ed832f6e::trade {
    struct TRADE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRADE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRADE>(arg0, 6, b"Trade", b"Just Trade", b"Just Trade is a cryptocurrency with a straightforward and uncomplicated purpose: to facilitate trading. Created exclusively for those who want to buy and sell with speed and efficiency, Just Trade is designed to serve traders of all levels, offering liquidity and quick transactions. Without complex functions or secondary features, this cryptocurrency focuses solely on the essentials, allowing investors to maximize their trading experience without distractions.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/OIP_220a2da661.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRADE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRADE>>(v1);
    }

    // decompiled from Move bytecode v6
}

