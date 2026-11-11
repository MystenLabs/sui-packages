module 0x1f75c33b9dde9d4614133dcdcb6116e49fc5d77bfa54cee8d4c8f5a5091bc4b3::creator_vault {
    struct CreatorVault has key {
        id: 0x2::object::UID,
        creator: address,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        graduated: bool,
        unlock_time_ms: u64,
    }

    struct VaultCreated has copy, drop {
        vault_id: 0x2::object::ID,
        creator: address,
    }

    struct VaultDeposit has copy, drop {
        vault_id: 0x2::object::ID,
        amount: u64,
    }

    struct VaultGraduated has copy, drop {
        vault_id: 0x2::object::ID,
        unlock_time_ms: u64,
    }

    struct VaultClaimed has copy, drop {
        vault_id: 0x2::object::ID,
        creator: address,
        amount: u64,
    }

    public(friend) fun new(arg0: address, arg1: &mut 0x2::tx_context::TxContext) : CreatorVault {
        let v0 = CreatorVault{
            id             : 0x2::object::new(arg1),
            creator        : arg0,
            balance        : 0x2::balance::zero<0x2::sui::SUI>(),
            graduated      : false,
            unlock_time_ms : 0,
        };
        let v1 = VaultCreated{
            vault_id : 0x2::object::id<CreatorVault>(&v0),
            creator  : arg0,
        };
        0x2::event::emit<VaultCreated>(v1);
        v0
    }

    public fun balance_value(arg0: &CreatorVault) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.balance)
    }

    public entry fun claim(arg0: &0x1f75c33b9dde9d4614133dcdcb6116e49fc5d77bfa54cee8d4c8f5a5091bc4b3::global::Config, arg1: &mut CreatorVault, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x1f75c33b9dde9d4614133dcdcb6116e49fc5d77bfa54cee8d4c8f5a5091bc4b3::global::assert_version(arg0);
        assert!(0x2::tx_context::sender(arg3) == arg1.creator, 0);
        assert!(arg1.graduated, 1);
        assert!(0x2::clock::timestamp_ms(arg2) >= arg1.unlock_time_ms, 2);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg1.balance);
        assert!(v0 > 0, 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.balance, v0), arg3), arg1.creator);
        let v1 = VaultClaimed{
            vault_id : 0x2::object::id<CreatorVault>(arg1),
            creator  : arg1.creator,
            amount   : v0,
        };
        0x2::event::emit<VaultClaimed>(v1);
    }

    public fun creator(arg0: &CreatorVault) : address {
        arg0.creator
    }

    public(friend) fun deposit(arg0: &mut CreatorVault, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let v0 = VaultDeposit{
            vault_id : 0x2::object::id<CreatorVault>(arg0),
            amount   : 0x2::coin::value<0x2::sui::SUI>(&arg1),
        };
        0x2::event::emit<VaultDeposit>(v0);
    }

    public fun is_graduated(arg0: &CreatorVault) : bool {
        arg0.graduated
    }

    public(friend) fun mark_graduated(arg0: &mut CreatorVault, arg1: &0x2::clock::Clock) {
        arg0.graduated = true;
        arg0.unlock_time_ms = 0x2::clock::timestamp_ms(arg1) + 0x1f75c33b9dde9d4614133dcdcb6116e49fc5d77bfa54cee8d4c8f5a5091bc4b3::global::creator_lock_ms();
        let v0 = VaultGraduated{
            vault_id       : 0x2::object::id<CreatorVault>(arg0),
            unlock_time_ms : arg0.unlock_time_ms,
        };
        0x2::event::emit<VaultGraduated>(v0);
    }

    public(friend) fun share(arg0: CreatorVault) {
        0x2::transfer::share_object<CreatorVault>(arg0);
    }

    public fun unlock_time_ms(arg0: &CreatorVault) : u64 {
        arg0.unlock_time_ms
    }

    // decompiled from Move bytecode v7
}

