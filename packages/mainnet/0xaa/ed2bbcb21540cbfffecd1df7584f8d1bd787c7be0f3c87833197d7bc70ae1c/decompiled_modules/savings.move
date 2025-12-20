module 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::savings {
    struct SavingsVault has key {
        id: 0x2::object::UID,
        version: u64,
        dori_balance: 0x2::balance::Balance<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>,
        sdori_supply: 0x2::balance::Supply<0x1e881f5933f56d4db5ae61b35c87eb24d08ac370000c55a1124f836ab52ef058::sdori::SDORI>,
        total_yield_distributed: u64,
        last_distribution_timestamp: u64,
    }

    public fun deposit(arg0: &mut SavingsVault, arg1: 0x2::coin::Coin<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x1e881f5933f56d4db5ae61b35c87eb24d08ac370000c55a1124f836ab52ef058::sdori::SDORI> {
        assert!(arg0.version == 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::constants::VERSION(), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::EWrongPackageVersion());
        let v0 = 0x2::coin::value<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(&arg1);
        assert!(v0 > 0, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::EValueZero());
        let v1 = dori_to_sdori(arg0, v0);
        0x2::balance::join<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(&mut arg0.dori_balance, 0x2::coin::into_balance<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(arg1));
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::events_v1::emit_savings_deposit_event(0x2::tx_context::sender(arg2), v0, v1, get_exchange_rate(arg0));
        0x2::coin::from_balance<0x1e881f5933f56d4db5ae61b35c87eb24d08ac370000c55a1124f836ab52ef058::sdori::SDORI>(0x2::balance::increase_supply<0x1e881f5933f56d4db5ae61b35c87eb24d08ac370000c55a1124f836ab52ef058::sdori::SDORI>(&mut arg0.sdori_supply, v1), arg2)
    }

    public fun distribute_yield(arg0: &mut SavingsVault, arg1: 0x2::coin::Coin<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>, arg2: &0x2::clock::Clock) {
        let v0 = 0x2::coin::value<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(&arg1);
        assert!(v0 > 0, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::EValueZero());
        0x2::balance::join<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(&mut arg0.dori_balance, 0x2::coin::into_balance<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(arg1));
        arg0.total_yield_distributed = arg0.total_yield_distributed + v0;
        arg0.last_distribution_timestamp = 0x2::clock::timestamp_ms(arg2);
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::events_v1::emit_savings_yield_distributed_event(v0, get_exchange_rate(arg0), 0x2::balance::value<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(&arg0.dori_balance), 0x2::balance::supply_value<0x1e881f5933f56d4db5ae61b35c87eb24d08ac370000c55a1124f836ab52ef058::sdori::SDORI>(&arg0.sdori_supply));
    }

    public fun dori_to_sdori(arg0: &SavingsVault, arg1: u64) : u64 {
        let v0 = 0x2::balance::value<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(&arg0.dori_balance);
        let v1 = 0x2::balance::supply_value<0x1e881f5933f56d4db5ae61b35c87eb24d08ac370000c55a1124f836ab52ef058::sdori::SDORI>(&arg0.sdori_supply);
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
        let v0 = 0x2::balance::supply_value<0x1e881f5933f56d4db5ae61b35c87eb24d08ac370000c55a1124f836ab52ef058::sdori::SDORI>(&arg0.sdori_supply);
        if (v0 == 0) {
            (1000000000 as u64)
        } else {
            (((0x2::balance::value<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(&arg0.dori_balance) as u256) * 1000000000 / (v0 as u256)) as u64)
        }
    }

    public(friend) fun init_savings(arg0: 0x2::coin::TreasuryCap<0x1e881f5933f56d4db5ae61b35c87eb24d08ac370000c55a1124f836ab52ef058::sdori::SDORI>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = SavingsVault{
            id                          : 0x2::object::new(arg1),
            version                     : 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::constants::VERSION(),
            dori_balance                : 0x2::balance::zero<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(),
            sdori_supply                : 0x2::coin::treasury_into_supply<0x1e881f5933f56d4db5ae61b35c87eb24d08ac370000c55a1124f836ab52ef058::sdori::SDORI>(arg0),
            total_yield_distributed     : 0,
            last_distribution_timestamp : 0,
        };
        0x2::transfer::share_object<SavingsVault>(v0);
    }

    entry fun migrate(arg0: &mut 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::governance_admin::AdminCap, arg1: &mut SavingsVault) {
        assert!(arg1.version < 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::constants::VERSION(), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::ENotUpgrade());
        arg1.version = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::constants::VERSION();
    }

    public fun sdori_to_dori(arg0: &SavingsVault, arg1: u64) : u64 {
        let v0 = 0x2::balance::supply_value<0x1e881f5933f56d4db5ae61b35c87eb24d08ac370000c55a1124f836ab52ef058::sdori::SDORI>(&arg0.sdori_supply);
        if (v0 == 0) {
            0
        } else {
            (((arg1 as u256) * (0x2::balance::value<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(&arg0.dori_balance) as u256) / (v0 as u256)) as u64)
        }
    }

    public fun withdraw(arg0: &mut SavingsVault, arg1: 0x2::coin::Coin<0x1e881f5933f56d4db5ae61b35c87eb24d08ac370000c55a1124f836ab52ef058::sdori::SDORI>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI> {
        assert!(arg0.version == 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::constants::VERSION(), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::EWrongPackageVersion());
        let v0 = 0x2::coin::value<0x1e881f5933f56d4db5ae61b35c87eb24d08ac370000c55a1124f836ab52ef058::sdori::SDORI>(&arg1);
        assert!(v0 > 0, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::EValueZero());
        let v1 = sdori_to_dori(arg0, v0);
        assert!(0x2::balance::value<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(&arg0.dori_balance) >= v1, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::errors::EInsufficientBalance());
        0x2::balance::decrease_supply<0x1e881f5933f56d4db5ae61b35c87eb24d08ac370000c55a1124f836ab52ef058::sdori::SDORI>(&mut arg0.sdori_supply, 0x2::coin::into_balance<0x1e881f5933f56d4db5ae61b35c87eb24d08ac370000c55a1124f836ab52ef058::sdori::SDORI>(arg1));
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::events_v1::emit_savings_withdraw_event(0x2::tx_context::sender(arg2), v0, v1, get_exchange_rate(arg0));
        0x2::coin::from_balance<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(0x2::balance::split<0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::dori::DORI>(&mut arg0.dori_balance, v1), arg2)
    }

    // decompiled from Move bytecode v6
}

