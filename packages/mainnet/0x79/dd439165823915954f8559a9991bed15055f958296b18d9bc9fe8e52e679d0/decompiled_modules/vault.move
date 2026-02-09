module 0x79dd439165823915954f8559a9991bed15055f958296b18d9bc9fe8e52e679d0::vault {
    struct Vault<phantom T0> has key {
        id: 0x2::object::UID,
        owner: address,
        balance: 0x2::balance::Balance<T0>,
        global_donation_percentage: u8,
        total_donated: u64,
        created_at: u64,
    }

    struct AllocationConfig has drop, store {
        percentage: u8,
        total_donated: u64,
        last_donation_at: u64,
    }

    struct VaultCreatedEvent has copy, drop {
        vault_id: 0x2::object::ID,
        owner: address,
        initial_balance: u64,
        timestamp: u64,
    }

    struct DepositEvent has copy, drop {
        vault_id: 0x2::object::ID,
        amount: u64,
        new_balance: u64,
        timestamp: u64,
    }

    struct WithdrawalEvent has copy, drop {
        vault_id: 0x2::object::ID,
        amount: u64,
        new_balance: u64,
        timestamp: u64,
    }

    struct ConfigUpdatedEvent has copy, drop {
        vault_id: 0x2::object::ID,
        global_donation_percentage: u8,
        allocations_count: u64,
        timestamp: u64,
    }

    struct DonationExecutedEvent has copy, drop {
        vault_id: 0x2::object::ID,
        project_id: 0x2::object::ID,
        amount: u64,
        donor: address,
        timestamp: u64,
    }

    public fun add_allocation<T0>(arg0: &mut Vault<T0>, arg1: 0x2::object::ID, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg3), 0);
        assert!(arg2 <= 100, 2);
        let v0 = AllocationConfig{
            percentage       : arg2,
            total_donated    : 0,
            last_donation_at : 0,
        };
        if (0x2::dynamic_field::exists_<0x2::object::ID>(&arg0.id, arg1)) {
            0x2::dynamic_field::remove<0x2::object::ID, AllocationConfig>(&mut arg0.id, arg1);
        };
        0x2::dynamic_field::add<0x2::object::ID, AllocationConfig>(&mut arg0.id, arg1, v0);
    }

    public fun calculate_donation_pool<T0>(arg0: &Vault<T0>, arg1: u64) : u64 {
        0x2::balance::value<T0>(&arg0.balance) * arg1 / 10000 * (arg0.global_donation_percentage as u64) / 100
    }

    public fun create_vault<T0>(arg0: &mut 0x79dd439165823915954f8559a9991bed15055f958296b18d9bc9fe8e52e679d0::platform::DonationPlatform, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::tx_context::epoch_timestamp_ms(arg2);
        let v2 = 0x2::coin::value<T0>(&arg1);
        let v3 = 0x2::object::new(arg2);
        let v4 = 0x2::object::uid_to_inner(&v3);
        let v5 = Vault<T0>{
            id                         : v3,
            owner                      : v0,
            balance                    : 0x2::coin::into_balance<T0>(arg1),
            global_donation_percentage : 0,
            total_donated              : 0,
            created_at                 : v1,
        };
        0x79dd439165823915954f8559a9991bed15055f958296b18d9bc9fe8e52e679d0::platform::increment_vault_count(arg0);
        0x79dd439165823915954f8559a9991bed15055f958296b18d9bc9fe8e52e679d0::platform::add_to_tvl(arg0, v2);
        let v6 = VaultCreatedEvent{
            vault_id        : v4,
            owner           : v0,
            initial_balance : v2,
            timestamp       : v1,
        };
        0x2::event::emit<VaultCreatedEvent>(v6);
        0x2::transfer::transfer<Vault<T0>>(v5, v0);
        v4
    }

    public fun deposit<T0>(arg0: &mut Vault<T0>, arg1: &mut 0x79dd439165823915954f8559a9991bed15055f958296b18d9bc9fe8e52e679d0::platform::DonationPlatform, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg3), 0);
        let v0 = 0x2::coin::value<T0>(&arg2);
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg2));
        0x79dd439165823915954f8559a9991bed15055f958296b18d9bc9fe8e52e679d0::platform::add_to_tvl(arg1, v0);
        let v1 = DepositEvent{
            vault_id    : 0x2::object::id<Vault<T0>>(arg0),
            amount      : v0,
            new_balance : 0x2::balance::value<T0>(&arg0.balance),
            timestamp   : 0x2::tx_context::epoch_timestamp_ms(arg3),
        };
        0x2::event::emit<DepositEvent>(v1);
    }

    public fun execute_donation<T0>(arg0: &mut Vault<T0>, arg1: &mut 0x79dd439165823915954f8559a9991bed15055f958296b18d9bc9fe8e52e679d0::project::Project<T0>, arg2: 0x2::object::ID, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg4), 0);
        assert!(0x2::dynamic_field::exists_<0x2::object::ID>(&arg0.id, arg2), 3);
        let v0 = 0x2::coin::value<T0>(&arg3);
        let v1 = 0x2::dynamic_field::borrow_mut<0x2::object::ID, AllocationConfig>(&mut arg0.id, arg2);
        let v2 = v0 * (arg0.global_donation_percentage as u64) / 100 * (v1.percentage as u64) / 100;
        assert!(v2 > 0, 6);
        assert!(v2 <= v0, 7);
        arg0.total_donated = arg0.total_donated + v2;
        v1.total_donated = v1.total_donated + v2;
        v1.last_donation_at = 0x2::tx_context::epoch_timestamp_ms(arg4);
        0x79dd439165823915954f8559a9991bed15055f958296b18d9bc9fe8e52e679d0::project::receive_donation<T0>(arg1, 0x2::coin::split<T0>(&mut arg3, v2, arg4), arg0.owner, arg4);
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg3));
        let v3 = DonationExecutedEvent{
            vault_id   : 0x2::object::id<Vault<T0>>(arg0),
            project_id : arg2,
            amount     : v2,
            donor      : arg0.owner,
            timestamp  : 0x2::tx_context::epoch_timestamp_ms(arg4),
        };
        0x2::event::emit<DonationExecutedEvent>(v3);
    }

    public fun get_allocation<T0>(arg0: &Vault<T0>, arg1: 0x2::object::ID) : &AllocationConfig {
        0x2::dynamic_field::borrow<0x2::object::ID, AllocationConfig>(&arg0.id, arg1)
    }

    public fun get_allocation_details(arg0: &AllocationConfig) : (u8, u64, u64) {
        (arg0.percentage, arg0.total_donated, arg0.last_donation_at)
    }

    public fun get_info<T0>(arg0: &Vault<T0>) : (address, u64, u8, u64, u64) {
        (arg0.owner, 0x2::balance::value<T0>(&arg0.balance), arg0.global_donation_percentage, arg0.total_donated, arg0.created_at)
    }

    public fun has_allocation<T0>(arg0: &Vault<T0>, arg1: 0x2::object::ID) : bool {
        0x2::dynamic_field::exists_<0x2::object::ID>(&arg0.id, arg1)
    }

    public fun remove_allocation<T0>(arg0: &mut Vault<T0>, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 0);
        assert!(0x2::dynamic_field::exists_<0x2::object::ID>(&arg0.id, arg1), 3);
        0x2::dynamic_field::remove<0x2::object::ID, AllocationConfig>(&mut arg0.id, arg1);
    }

    public fun update_allocation<T0>(arg0: &mut Vault<T0>, arg1: 0x2::object::ID, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg3), 0);
        assert!(arg2 <= 100, 2);
        assert!(0x2::dynamic_field::exists_<0x2::object::ID>(&arg0.id, arg1), 3);
        0x2::dynamic_field::borrow_mut<0x2::object::ID, AllocationConfig>(&mut arg0.id, arg1).percentage = arg2;
    }

    public fun update_donation_config<T0>(arg0: &mut Vault<T0>, arg1: u8, arg2: vector<0x2::object::ID>, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg4), 0);
        assert!(arg1 <= 100, 2);
        assert!(0x1::vector::length<0x2::object::ID>(&arg2) == 0x1::vector::length<u8>(&arg3), 4);
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(&arg3)) {
            v0 = v0 + (*0x1::vector::borrow<u8>(&arg3, v1) as u64);
            v1 = v1 + 1;
        };
        assert!(v0 == 100, 5);
        arg0.global_donation_percentage = arg1;
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x2::object::ID>(&arg2)) {
            let v3 = *0x1::vector::borrow<0x2::object::ID>(&arg2, v2);
            if (0x2::dynamic_field::exists_<0x2::object::ID>(&arg0.id, v3)) {
                0x2::dynamic_field::borrow_mut<0x2::object::ID, AllocationConfig>(&mut arg0.id, v3).percentage = *0x1::vector::borrow<u8>(&arg3, v2);
            } else {
                let v4 = AllocationConfig{
                    percentage       : *0x1::vector::borrow<u8>(&arg3, v2),
                    total_donated    : 0,
                    last_donation_at : 0,
                };
                0x2::dynamic_field::add<0x2::object::ID, AllocationConfig>(&mut arg0.id, v3, v4);
            };
            v2 = v2 + 1;
        };
        let v5 = ConfigUpdatedEvent{
            vault_id                   : 0x2::object::id<Vault<T0>>(arg0),
            global_donation_percentage : arg1,
            allocations_count          : 0x1::vector::length<0x2::object::ID>(&arg2),
            timestamp                  : 0x2::tx_context::epoch_timestamp_ms(arg4),
        };
        0x2::event::emit<ConfigUpdatedEvent>(v5);
    }

    public fun update_global_percentage<T0>(arg0: &mut Vault<T0>, arg1: u8, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 0);
        assert!(arg1 <= 100, 2);
        arg0.global_donation_percentage = arg1;
    }

    public fun withdraw<T0>(arg0: &mut Vault<T0>, arg1: &mut 0x79dd439165823915954f8559a9991bed15055f958296b18d9bc9fe8e52e679d0::platform::DonationPlatform, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg0.owner == 0x2::tx_context::sender(arg3), 0);
        assert!(0x2::balance::value<T0>(&arg0.balance) >= arg2, 1);
        0x79dd439165823915954f8559a9991bed15055f958296b18d9bc9fe8e52e679d0::platform::subtract_from_tvl(arg1, arg2);
        let v0 = WithdrawalEvent{
            vault_id    : 0x2::object::id<Vault<T0>>(arg0),
            amount      : arg2,
            new_balance : 0x2::balance::value<T0>(&arg0.balance),
            timestamp   : 0x2::tx_context::epoch_timestamp_ms(arg3),
        };
        0x2::event::emit<WithdrawalEvent>(v0);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, arg2), arg3)
    }

    // decompiled from Move bytecode v6
}

