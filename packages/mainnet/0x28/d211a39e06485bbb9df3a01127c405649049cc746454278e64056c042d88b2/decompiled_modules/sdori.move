module 0x28d211a39e06485bbb9df3a01127c405649049cc746454278e64056c042d88b2::sdori {
    struct DepositEvent has copy, drop {
        user: address,
        dori_amount: u64,
        sdori_amount: u64,
        exchange_rate: u64,
    }

    struct WithdrawEvent has copy, drop {
        user: address,
        sdori_amount: u64,
        dori_amount: u64,
        exchange_rate: u64,
    }

    struct YieldDistributedEvent has copy, drop {
        amount: u64,
        new_exchange_rate: u64,
        total_dori: u64,
        total_sdori: u64,
    }

    struct SDORI has drop {
        dummy_field: bool,
    }

    struct SavingsVault has key {
        id: 0x2::object::UID,
        version: u64,
        dori_balance: 0x2::balance::Balance<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>,
        sdori_supply: 0x2::balance::Supply<SDORI>,
        total_yield_distributed: u64,
        last_distribution_timestamp: u64,
    }

    public fun deposit(arg0: &mut SavingsVault, arg1: 0x2::coin::Coin<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<SDORI> {
        assert!(arg0.version == 1, 0);
        let v0 = 0x2::coin::value<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(&arg1);
        assert!(v0 > 0, 1);
        let v1 = dori_to_sdori(arg0, v0);
        0x2::balance::join<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(&mut arg0.dori_balance, 0x2::coin::into_balance<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(arg1));
        let v2 = DepositEvent{
            user          : 0x2::tx_context::sender(arg2),
            dori_amount   : v0,
            sdori_amount  : v1,
            exchange_rate : get_exchange_rate(arg0),
        };
        0x2::event::emit<DepositEvent>(v2);
        0x2::coin::from_balance<SDORI>(0x2::balance::increase_supply<SDORI>(&mut arg0.sdori_supply, v1), arg2)
    }

    public fun distribute_yield(arg0: &mut SavingsVault, arg1: 0x2::coin::Coin<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>, arg2: &0x2::clock::Clock) {
        let v0 = 0x2::coin::value<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(&arg1);
        assert!(v0 > 0, 1);
        0x2::balance::join<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(&mut arg0.dori_balance, 0x2::coin::into_balance<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(arg1));
        arg0.total_yield_distributed = arg0.total_yield_distributed + v0;
        arg0.last_distribution_timestamp = 0x2::clock::timestamp_ms(arg2);
        let v1 = YieldDistributedEvent{
            amount            : v0,
            new_exchange_rate : get_exchange_rate(arg0),
            total_dori        : 0x2::balance::value<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(&arg0.dori_balance),
            total_sdori       : 0x2::balance::supply_value<SDORI>(&arg0.sdori_supply),
        };
        0x2::event::emit<YieldDistributedEvent>(v1);
    }

    public fun dori_to_sdori(arg0: &SavingsVault, arg1: u64) : u64 {
        let v0 = 0x2::balance::value<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(&arg0.dori_balance);
        let v1 = 0x2::balance::supply_value<SDORI>(&arg0.sdori_supply);
        if (v1 == 0 || v0 == 0) {
            arg1
        } else {
            (((arg1 as u256) * (v1 as u256) / (v0 as u256)) as u64)
        }
    }

    public fun get_estimated_apy(arg0: &SavingsVault, arg1: &0x2::clock::Clock, arg2: u64) : u64 {
        let v0 = 0x2::clock::timestamp_ms(arg1) - arg0.last_distribution_timestamp;
        if (v0 > arg2 || arg0.total_yield_distributed == 0) {
            return 0
        };
        let v1 = get_exchange_rate(arg0);
        if (v1 <= (1000000000 as u64)) {
            return 0
        };
        ((((v1 - (1000000000 as u64)) as u256) * 31536000000 / (v0 as u256) * 10000 / 1000000000) as u64)
    }

    public fun get_exchange_rate(arg0: &SavingsVault) : u64 {
        let v0 = 0x2::balance::supply_value<SDORI>(&arg0.sdori_supply);
        if (v0 == 0) {
            (1000000000 as u64)
        } else {
            (((0x2::balance::value<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(&arg0.dori_balance) as u256) * 1000000000 / (v0 as u256)) as u64)
        }
    }

    fun init(arg0: SDORI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<SDORI>(arg0, 9, 0x1::string::utf8(b"sDORI"), 0x1::string::utf8(b"Savings DORI"), 0x1::string::utf8(b"Yield-bearing DORI. Deposit to earn protocol yield from Weiss.Finance."), 0x1::string::utf8(b"https://weissfi.s3.eu-west-3.amazonaws.com/sdori.svg"), arg1);
        0x2::transfer::public_freeze_object<0x2::coin_registry::MetadataCap<SDORI>>(0x2::coin_registry::finalize<SDORI>(v0, arg1));
        let v2 = SavingsVault{
            id                          : 0x2::object::new(arg1),
            version                     : 1,
            dori_balance                : 0x2::balance::zero<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(),
            sdori_supply                : 0x2::coin::treasury_into_supply<SDORI>(v1),
            total_yield_distributed     : 0,
            last_distribution_timestamp : 0,
        };
        0x2::transfer::share_object<SavingsVault>(v2);
    }

    entry fun migrate(arg0: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::governance_admin::AdminCap, arg1: &mut SavingsVault) {
        assert!(arg1.version < 1, 3);
        arg1.version = 1;
    }

    public fun sdori_to_dori(arg0: &SavingsVault, arg1: u64) : u64 {
        let v0 = 0x2::balance::supply_value<SDORI>(&arg0.sdori_supply);
        if (v0 == 0) {
            0
        } else {
            (((arg1 as u256) * (0x2::balance::value<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(&arg0.dori_balance) as u256) / (v0 as u256)) as u64)
        }
    }

    public fun withdraw(arg0: &mut SavingsVault, arg1: 0x2::coin::Coin<SDORI>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI> {
        assert!(arg0.version == 1, 0);
        let v0 = 0x2::coin::value<SDORI>(&arg1);
        assert!(v0 > 0, 1);
        let v1 = sdori_to_dori(arg0, v0);
        assert!(0x2::balance::value<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(&arg0.dori_balance) >= v1, 2);
        0x2::balance::decrease_supply<SDORI>(&mut arg0.sdori_supply, 0x2::coin::into_balance<SDORI>(arg1));
        let v2 = WithdrawEvent{
            user          : 0x2::tx_context::sender(arg2),
            sdori_amount  : v0,
            dori_amount   : v1,
            exchange_rate : get_exchange_rate(arg0),
        };
        0x2::event::emit<WithdrawEvent>(v2);
        0x2::coin::from_balance<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(0x2::balance::split<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(&mut arg0.dori_balance, v1), arg2)
    }

    // decompiled from Move bytecode v6
}

