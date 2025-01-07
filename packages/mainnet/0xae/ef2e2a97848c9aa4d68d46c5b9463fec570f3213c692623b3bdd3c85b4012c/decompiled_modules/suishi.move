module 0xaeef2e2a97848c9aa4d68d46c5b9463fec570f3213c692623b3bdd3c85b4012c::suishi {
    struct SUISHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISHI>(arg0, 6, b"SUISHI", b"SUISHI Coin", b"In Tokyo's crypto scene, a shadowy project emerged: SUISHI Coin. Promising underwater riches, it hooked investors. As the hype faded, only the legend of mysterious gains remained.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Default_A_vibrant_anthropomorphic_sushi_with_a_beaming_smile_a_3_b7dbb7d1_fcbf_4bed_9817_a1640726fdac_0_57480f9862.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

