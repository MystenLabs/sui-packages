module 0x9f781361c2c9a4c0b610538fca0ddd4ef5de2b841e03ce02c637849eb2b344::horo {
    struct HORO has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Treasury has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<HORO>,
    }

    fun init(arg0: HORO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HORO>(arg0, 9, b"HORO", b"Horo Coin", b"The first fate-powered degen coin on Sui, for all brave souls willing to surf the skies and shoot for the moon! Claim your daily $HORO at https://horocoin.com", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        let v3 = AdminCap{id: 0x2::object::new(arg1)};
        let v4 = Treasury{
            id      : 0x2::object::new(arg1),
            balance : 0x2::coin::into_balance<HORO>(0x2::coin::mint<HORO>(&mut v2, 10000000000000000000, arg1)),
        };
        let v5 = 0x2::tx_context::sender(arg1);
        0x2::transfer::transfer<AdminCap>(v3, v5);
        0x2::transfer::transfer<Treasury>(v4, v5);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HORO>>(v2, v5);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HORO>>(v1);
    }

    public fun split_from_treasury(arg0: &mut Treasury, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<HORO> {
        0x2::coin::from_balance<HORO>(0x2::balance::split<HORO>(&mut arg0.balance, arg1), arg2)
    }

    public fun treasury_balance(arg0: &Treasury) : u64 {
        0x2::balance::value<HORO>(&arg0.balance)
    }

    // decompiled from Move bytecode v6
}

