module 0x384c39fffe46953b9a75a8f08b5795fe98ab627c3622f37fd10ac8a1d2536f64::stake {
    struct STAKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: STAKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STAKE>(arg0, 6, b"Stake", b"StakeCasinoToken", b"The Stake Casino Token (STK) is a Sui-based utility token that enhances the gaming experience at Stake, a prominent Australian-Curaaoan online casino and sportsbook. Offering casino games, live dealer streams, and sports betting, Stake ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/stake_e38dec0e73.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STAKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STAKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

