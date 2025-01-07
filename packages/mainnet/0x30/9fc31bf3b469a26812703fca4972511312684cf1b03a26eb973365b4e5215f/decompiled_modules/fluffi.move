module 0x309fc31bf3b469a26812703fca4972511312684cf1b03a26eb973365b4e5215f::fluffi {
    struct FLUFFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLUFFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLUFFI>(arg0, 6, b"Fluffi", b"Fluffington", b"An unknown dev, inspired by Musks tweet and Grok2 AI, launched $FLUFFI on pump.fun and left it to the community. What followed was Groks first generated memecoin, blending cutting-edge tech with the playful spirit of Fluffington. Built for innovation and fun, Fluffi took off, and the community quickly embraced it as a gateway to explore the potential of AI in crypto and overall meme culture. With Grok2 AI, users can engage with Fluffingtons cosmic adventures in real-time, making $FLUFFI more than just a coinits become a creative movement.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/9tao8i_m_400x400_b775a88cb4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLUFFI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLUFFI>>(v1);
    }

    // decompiled from Move bytecode v6
}

