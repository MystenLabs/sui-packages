module 0xf1f9e54271add673f6bbf6fc802c053b95e1d469a76f7e7d6693f1a966caa006::vault {
    struct CreditPurchased has copy, drop {
        user: address,
        credits_bought: u64,
        tokens_paid: u64,
        timestamp_ms: u64,
    }

    struct GuessMade has copy, drop {
        user: address,
        guessed_number: u64,
        is_correct: bool,
        timestamp_ms: u64,
    }

    struct GameSetup has copy, drop {
        lucky_number: u64,
        timestamp_ms: u64,
    }

    struct RateSet has copy, drop {
        new_rate: u64,
        timestamp_ms: u64,
    }

    struct VaultAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Vault has key {
        id: 0x2::object::UID,
        lucky_number: u64,
        user_credits: 0x2::table::Table<address, u64>,
        exchange_rate: u64,
        token_balance: 0x2::balance::Balance<0xf1f9e54271add673f6bbf6fc802c053b95e1d469a76f7e7d6693f1a966caa006::credit_token::CREDIT_TOKEN>,
    }

    struct VAULT has drop {
        dummy_field: bool,
    }

    public entry fun buy_credit(arg0: &mut Vault, arg1: 0x2::coin::Coin<0xf1f9e54271add673f6bbf6fc802c053b95e1d469a76f7e7d6693f1a966caa006::credit_token::CREDIT_TOKEN>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 7);
        assert!(0x2::coin::value<0xf1f9e54271add673f6bbf6fc802c053b95e1d469a76f7e7d6693f1a966caa006::credit_token::CREDIT_TOKEN>(&arg1) > 0, 2);
        let v0 = arg2 * arg0.exchange_rate;
        let v1 = 0x2::coin::value<0xf1f9e54271add673f6bbf6fc802c053b95e1d469a76f7e7d6693f1a966caa006::credit_token::CREDIT_TOKEN>(&arg1);
        assert!(v1 >= v0, 6);
        let v2 = 0x2::tx_context::sender(arg3);
        if (0x2::table::contains<address, u64>(&arg0.user_credits, v2)) {
            let v3 = 0x2::table::borrow_mut<address, u64>(&mut arg0.user_credits, v2);
            *v3 = *v3 + arg2;
        } else {
            0x2::table::add<address, u64>(&mut arg0.user_credits, v2, arg2);
        };
        let v4 = CreditPurchased{
            user           : v2,
            credits_bought : arg2,
            tokens_paid    : v0,
            timestamp_ms   : 0x2::tx_context::epoch_timestamp_ms(arg3),
        };
        0x2::event::emit<CreditPurchased>(v4);
        if (v1 > v0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xf1f9e54271add673f6bbf6fc802c053b95e1d469a76f7e7d6693f1a966caa006::credit_token::CREDIT_TOKEN>>(0x2::coin::split<0xf1f9e54271add673f6bbf6fc802c053b95e1d469a76f7e7d6693f1a966caa006::credit_token::CREDIT_TOKEN>(&mut arg1, v1 - v0, arg3), v2);
        };
        0x2::balance::join<0xf1f9e54271add673f6bbf6fc802c053b95e1d469a76f7e7d6693f1a966caa006::credit_token::CREDIT_TOKEN>(&mut arg0.token_balance, 0x2::coin::into_balance<0xf1f9e54271add673f6bbf6fc802c053b95e1d469a76f7e7d6693f1a966caa006::credit_token::CREDIT_TOKEN>(arg1));
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
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::table::borrow_mut<address, u64>(&mut arg0.user_credits, v0);
        assert!(*v1 > 0, 1);
        assert!(arg1 > 0, 4);
        *v1 = *v1 - 1;
        let v2 = arg1 == arg0.lucky_number;
        let v3 = GuessMade{
            user           : v0,
            guessed_number : arg1,
            is_correct     : v2,
            timestamp_ms   : 0x2::tx_context::epoch_timestamp_ms(arg2),
        };
        0x2::event::emit<GuessMade>(v3);
        v2
    }

    fun init(arg0: VAULT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = VaultAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<VaultAdminCap>(v0, 0x2::tx_context::sender(arg1));
        let v1 = Vault{
            id            : 0x2::object::new(arg1),
            lucky_number  : 0,
            user_credits  : 0x2::table::new<address, u64>(arg1),
            exchange_rate : 1000000000,
            token_balance : 0x2::balance::zero<0xf1f9e54271add673f6bbf6fc802c053b95e1d469a76f7e7d6693f1a966caa006::credit_token::CREDIT_TOKEN>(),
        };
        0x2::transfer::share_object<Vault>(v1);
    }

    public entry fun set_rate(arg0: &VaultAdminCap, arg1: &mut Vault, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 3);
        arg1.exchange_rate = arg2;
        let v0 = RateSet{
            new_rate     : arg2,
            timestamp_ms : 0x2::tx_context::epoch_timestamp_ms(arg3),
        };
        0x2::event::emit<RateSet>(v0);
    }

    public entry fun setup_game(arg0: &VaultAdminCap, arg1: &mut Vault, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 >= 1 && arg2 <= 999, 5);
        arg1.lucky_number = arg2;
        let v0 = GameSetup{
            lucky_number : arg2,
            timestamp_ms : 0x2::tx_context::epoch_timestamp_ms(arg3),
        };
        0x2::event::emit<GameSetup>(v0);
    }

    // decompiled from Move bytecode v6
}

