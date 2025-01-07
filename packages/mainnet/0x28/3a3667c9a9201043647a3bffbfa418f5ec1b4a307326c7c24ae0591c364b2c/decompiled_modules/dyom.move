module 0x283a3667c9a9201043647a3bffbfa418f5ec1b4a307326c7c24ae0591c364b2c::dyom {
    struct DYOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: DYOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DYOM>(arg0, 6, b"DYOM", b"DIOM", b"DIOM Network is a crazy experiment to create a decentralized cryptocurrency ecosystem powered by the $DIOM coin, designed to create a global network of trust regions. Individuals and organizations can bid to become rulers of specific regions (cities, provinces, or countries), acting as certifying authorities that verify local businesses, service providers, and manufacturers. Rulers award \"Verified\" badges to deserving entities, and their decisions impact the trust score of their region. The system incorporates AI-powered tools for accurate trust evaluation, incentivizing transparency and accountability in the global trust economy.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1500x500_059de0bed8.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DYOM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DYOM>>(v1);
    }

    // decompiled from Move bytecode v6
}

