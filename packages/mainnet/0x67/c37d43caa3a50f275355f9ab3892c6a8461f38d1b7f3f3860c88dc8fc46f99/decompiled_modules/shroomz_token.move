module 0x67c37d43caa3a50f275355f9ab3892c6a8461f38d1b7f3f3860c88dc8fc46f99::shroomz_token {
    struct SHROOMZ_TOKEN has drop {
        dummy_field: bool,
    }

    struct Treasury has key {
        id: 0x2::object::UID,
        cap: 0x2::coin::TreasuryCap<SHROOMZ_TOKEN>,
        burn_balance: 0x2::balance::Balance<SHROOMZ_TOKEN>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun burn_tokens(arg0: &mut Treasury, arg1: 0x2::coin::Coin<SHROOMZ_TOKEN>) {
        0x2::balance::join<SHROOMZ_TOKEN>(&mut arg0.burn_balance, 0x2::coin::into_balance<SHROOMZ_TOKEN>(arg1));
    }

    public fun get_burned_amount(arg0: &Treasury) : u64 {
        0x2::balance::value<SHROOMZ_TOKEN>(&arg0.burn_balance)
    }

    fun init(arg0: SHROOMZ_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHROOMZ_TOKEN>(arg0, 9, b"SHROOMZ", b"Shroomz Token", b"The magic mushroom token - Grow, harvest, and trade on Sui blockchain", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHROOMZ_TOKEN>>(v1);
        let v2 = Treasury{
            id           : 0x2::object::new(arg1),
            cap          : v0,
            burn_balance : 0x2::balance::zero<SHROOMZ_TOKEN>(),
        };
        let v3 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::share_object<Treasury>(v2);
        0x2::transfer::transfer<AdminCap>(v3, 0x2::tx_context::sender(arg1));
    }

    public fun mint_initial_supply(arg0: &mut Treasury, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SHROOMZ_TOKEN>>(0x2::coin::mint<SHROOMZ_TOKEN>(&mut arg0.cap, 420690000000000, arg2), 0x2::tx_context::sender(arg2));
    }

    public fun transfer_tokens(arg0: 0x2::coin::Coin<SHROOMZ_TOKEN>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SHROOMZ_TOKEN>>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

