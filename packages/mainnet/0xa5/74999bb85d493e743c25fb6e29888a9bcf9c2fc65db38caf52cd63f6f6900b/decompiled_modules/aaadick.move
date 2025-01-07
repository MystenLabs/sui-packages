module 0xa574999bb85d493e743c25fb6e29888a9bcf9c2fc65db38caf52cd63f6f6900b::aaadick {
    struct AAADICK has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAADICK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAADICK>(arg0, 6, b"aaaDick", b"MobyDick", b"Introducing $aaaDick, the ultimate ruler of the deep! Inspired by the legendary Moby Dick, this token is a colossal force in the crypto ocean, designed to dominate and conquer the waves of the SUI network. Like the great white whale, $aaaDick commands respect, navigating through the treacherous waters of volatility with unstoppable power. Holders of $aaaDick are not just investorsthey are captains of the crypto seas, steering toward untold riches beneath the surface. Sail with $aaaDick, the true King of the Ocean, and unleash the beast within! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/aaaa_AAAA_Aaaa_AA_Aaa_AAA_Aaa_A_Aaa_A_2_50caaca4c0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAADICK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAADICK>>(v1);
    }

    // decompiled from Move bytecode v6
}

