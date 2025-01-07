module 0x992ad1c8073c06d26c066e716fa1825219949605a5deb05b5922de23dab49cce::wave {
    struct WAVE has drop {
        dummy_field: bool,
    }

    struct WaveEvent has copy, drop {
        sender: address,
        incoming_amount: u64,
        outcoming_amount: u64,
    }

    struct Storage has key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<WAVE>,
    }

    fun init(arg0: WAVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAVE>(arg0, 6, b"WAVE", b"Random Wave", b"Random Wave combines the power of waves with the thrill of randomness. Ride the wave to unpredictable rewards.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://files.catbox.moe/1ssrwp.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WAVE>>(v1);
        0x2::coin::mint_and_transfer<WAVE>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        let v3 = Storage{
            id           : 0x2::object::new(arg1),
            treasury_cap : v2,
        };
        0x2::transfer::share_object<Storage>(v3);
    }

    entry fun rand(arg0: 0x2::coin::Coin<WAVE>, arg1: &mut Storage, arg2: &0x2::random::Random, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<WAVE>(&arg0);
        0x2::coin::burn<WAVE>(&mut arg1.treasury_cap, arg0);
        let v1 = 0x2::random::new_generator(arg2, arg3);
        let v2 = &mut v1;
        let v3 = roll_amount(v0, 0x2::coin::total_supply<WAVE>(&arg1.treasury_cap), v2);
        0x2::coin::mint_and_transfer<WAVE>(&mut arg1.treasury_cap, v3, 0x2::tx_context::sender(arg3), arg3);
        let v4 = WaveEvent{
            sender           : 0x2::tx_context::sender(arg3),
            incoming_amount  : v0,
            outcoming_amount : v3,
        };
        0x2::event::emit<WaveEvent>(v4);
    }

    fun roll_amount(arg0: u64, arg1: u64, arg2: &mut 0x2::random::RandomGenerator) : u64 {
        let v0 = 0x2::random::generate_u128_in_range(arg2, 1, 10000000);
        if (v0 > 5010001) {
            return 0
        };
        let v1 = (arg0 as u128);
        let v2 = (arg1 as u128);
        if (v0 > 3010001) {
            return (0x1::u128::min(v1 * 1, v2) as u64)
        };
        if (v0 > 2010001) {
            return (0x1::u128::min(v1 * 6 / 5, v2) as u64)
        };
        if (v0 > 1010001) {
            return (0x1::u128::min(v1 * 3 / 2, v2) as u64)
        };
        if (v0 > 110001) {
            return (0x1::u128::min(v1 * 2, v2) as u64)
        };
        if (v0 > 10001) {
            return (0x1::u128::min(v1 * 10, v2) as u64)
        };
        if (v0 > 1) {
            return (0x1::u128::min(v1 * 100, v2) as u64)
        };
        (0x1::u128::min(v1 * 1000000, v2) as u64)
    }

    // decompiled from Move bytecode v6
}

