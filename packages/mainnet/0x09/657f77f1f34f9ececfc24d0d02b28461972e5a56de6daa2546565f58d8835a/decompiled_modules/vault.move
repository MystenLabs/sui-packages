module 0x9657f77f1f34f9ececfc24d0d02b28461972e5a56de6daa2546565f58d8835a::vault {
    struct VaultAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Vault has key {
        id: 0x2::object::UID,
        lucky_number: u64,
        user_credits: 0x2::table::Table<address, u64>,
        exchange_rate: u64,
        token_balance: 0x2::balance::Balance<0x9657f77f1f34f9ececfc24d0d02b28461972e5a56de6daa2546565f58d8835a::credit_token::CREDIT_TOKEN>,
    }

    struct VAULT has drop {
        dummy_field: bool,
    }

    public entry fun buy_credit(arg0: &mut Vault, arg1: 0x2::coin::Coin<0x9657f77f1f34f9ececfc24d0d02b28461972e5a56de6daa2546565f58d8835a::credit_token::CREDIT_TOKEN>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 7);
        assert!(0x2::coin::value<0x9657f77f1f34f9ececfc24d0d02b28461972e5a56de6daa2546565f58d8835a::credit_token::CREDIT_TOKEN>(&arg1) > 0, 2);
        let v0 = arg2 * arg0.exchange_rate;
        let v1 = 0x2::coin::value<0x9657f77f1f34f9ececfc24d0d02b28461972e5a56de6daa2546565f58d8835a::credit_token::CREDIT_TOKEN>(&arg1);
        assert!(v1 >= v0, 6);
        let v2 = 0x2::tx_context::sender(arg3);
        if (0x2::table::contains<address, u64>(&arg0.user_credits, v2)) {
            let v3 = 0x2::table::borrow_mut<address, u64>(&mut arg0.user_credits, v2);
            *v3 = *v3 + arg2;
        } else {
            0x2::table::add<address, u64>(&mut arg0.user_credits, v2, arg2);
        };
        if (v1 > v0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x9657f77f1f34f9ececfc24d0d02b28461972e5a56de6daa2546565f58d8835a::credit_token::CREDIT_TOKEN>>(0x2::coin::split<0x9657f77f1f34f9ececfc24d0d02b28461972e5a56de6daa2546565f58d8835a::credit_token::CREDIT_TOKEN>(&mut arg1, v1 - v0, arg3), v2);
        };
        0x2::balance::join<0x9657f77f1f34f9ececfc24d0d02b28461972e5a56de6daa2546565f58d8835a::credit_token::CREDIT_TOKEN>(&mut arg0.token_balance, 0x2::coin::into_balance<0x9657f77f1f34f9ececfc24d0d02b28461972e5a56de6daa2546565f58d8835a::credit_token::CREDIT_TOKEN>(arg1));
    }

    public fun fetch_credit(arg0: &Vault, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.user_credits, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.user_credits, arg1)
        } else {
            0
        }
    }

    public fun get_rate(arg0: &Vault) : u64 {
        arg0.exchange_rate
    }

    public entry fun guess(arg0: &mut Vault, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : bool {
        let v0 = 0x2::table::borrow_mut<address, u64>(&mut arg0.user_credits, 0x2::tx_context::sender(arg2));
        assert!(*v0 > 0, 1);
        assert!(arg1 > 0, 4);
        *v0 = *v0 - 1;
        arg1 == arg0.lucky_number
    }

    fun init(arg0: VAULT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = VaultAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<VaultAdminCap>(v0, 0x2::tx_context::sender(arg1));
        let v1 = Vault{
            id            : 0x2::object::new(arg1),
            lucky_number  : 0,
            user_credits  : 0x2::table::new<address, u64>(arg1),
            exchange_rate : 1000000000,
            token_balance : 0x2::balance::zero<0x9657f77f1f34f9ececfc24d0d02b28461972e5a56de6daa2546565f58d8835a::credit_token::CREDIT_TOKEN>(),
        };
        0x2::transfer::share_object<Vault>(v1);
    }

    public entry fun set_rate(arg0: &VaultAdminCap, arg1: &mut Vault, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 3);
        arg1.exchange_rate = arg2;
    }

    public entry fun setup_game(arg0: &VaultAdminCap, arg1: &mut Vault, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 >= 1 && arg2 <= 999, 5);
        arg1.lucky_number = arg2;
    }

    // decompiled from Move bytecode v6
}

