module 0x19e5c20e3e6f56552459e822ab1b9aa8f72c344578e411c21c77312aa84a7435::stake {
    struct STAKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: STAKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STAKE>(arg0, 6, b"Stake", b"StakeCasinoToken", b"The Stake Casino Token (STK) is a Sui-based utility token that enhances the gaming experience at Stake, a prominent Australian-Curaaoan online casino and sportsbook. Offering casino games, live dealer streams, and sports betting, Stake leads in online gambling. With partnerships in sports, the STK token gives players enhanced rewards, faster transactions, and longer playtime, making it a key to an improved gaming experience.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/stake_8e8d6d72fa.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STAKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STAKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

