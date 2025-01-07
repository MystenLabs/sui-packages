module 0xfafd864133993c5b4906df41cb81ab0a3bed32d7befb79cf0a2a721d6a03b2a::chillpengu {
    struct CHILLPENGU has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHILLPENGU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHILLPENGU>(arg0, 6, b"CHILLPENGU", b"Chill Pengu", b"I know I'm expected to be Chill Pengu, always laid-back and seemingly indifferent, but I'm tired of pretending to be something I'm not. I want you to think of something that genuinely makes you happy right now. That thing, that spark that lights you upchase it with every ounce of your being. It's too easy to dismiss the possibilities life holds, and I'm not here to tell you that life is simple. In fact, I'd argue that true fulfillment comes only if you're ready to embrace the challenges that come your way. If something truly matters, it demands your effort and resilience; otherwise, it was never meant to be anything more than a missed chance. Yes, the journey will be tough, but here's the profound truth we discover: everything of value in life is hard-earned.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Chill_Pengu_8b46b5c93e.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHILLPENGU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHILLPENGU>>(v1);
    }

    // decompiled from Move bytecode v6
}

