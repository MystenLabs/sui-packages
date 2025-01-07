module 0x72731c08f71ec5de67aec790a5b4bf81b66067782710985907ec8870119244ac::twin {
    struct TWIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TWIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TWIN>(arg0, 6, b"Twin", b"Trump WIN", b"The **Trump Win Coin** on the Sui Network is a cryptocurrency token that celebrates the spirit of leadership and innovation through the symbolic representation of **Donald Trump and Elon Musk** as \"twin brothers\" working together to \"Make America Great Again.\" This digital asset honors both their impact on politics and technology, creating a powerful narrative of partnership. The limited-edition coin offers holders the opportunity to participate in exclusive events, access special NFTs, and engage with a community committed to this vision. With its fast and secure transactions, the Trump Win Coin embodies the boldness and futuristic vision both figures represent.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ap24279825715038_ebe0a0d2f7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TWIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TWIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

