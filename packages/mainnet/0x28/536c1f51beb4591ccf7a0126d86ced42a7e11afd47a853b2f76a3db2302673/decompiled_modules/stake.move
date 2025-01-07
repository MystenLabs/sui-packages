module 0x28536c1f51beb4591ccf7a0126d86ced42a7e11afd47a853b2f76a3db2302673::stake {
    struct STAKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: STAKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STAKE>(arg0, 6, b"Stake", b"StakeCasinoToken", b"The Stake Casino Token (STK) is a Sui-based utility token that enhances the gaming experience at Stake, a prominent Australian-Curaaoan online casino and sportsbook. Offering casino games, live dealer streams, and sports betting, Stake ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/stake_1b19c0aca9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STAKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STAKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

