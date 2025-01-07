module 0x2bd37fbba9b7ceb9d6ca4473d664c836c7db60acfc8b219003bfbedadcde6b7c::suibull {
    struct SUIBULL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBULL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBULL>(arg0, 6, b"SuiBull", b"Bull", b"The BULL token isn't just another cryptoit's a movement. Born out of the community and driven by the people, $BULL is here to make waves in the Ethereum ecosystem. With 10% of our total supply sent directly to Elon the creator of Sui, we've already made a bold statement. But this is just the beginning.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/14_e471c250e7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBULL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBULL>>(v1);
    }

    // decompiled from Move bytecode v6
}

