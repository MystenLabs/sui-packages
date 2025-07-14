module 0x1f4aa27b327cbbceffb448cbacf918bf126dadb479aecbe65c51ef36b08d858a::personal_vault {
    struct PersonalVault has store, key {
        id: 0x2::object::UID,
        deposits: 0x2::bag::Bag,
        owner: address,
    }

    struct VaultCap has store, key {
        id: 0x2::object::UID,
        vault_id: address,
    }

    struct DepositEvent has copy, drop {
        vault_id: address,
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
        depositor: address,
    }

    struct WithdrawEvent has copy, drop {
        vault_id: address,
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
        withdrawer: address,
    }

    struct VaultCreated has copy, drop {
        vault_id: address,
        owner: address,
    }

    public entry fun create_and_share_vault(arg0: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = create_vault(arg0);
        0x2::transfer::public_share_object<PersonalVault>(v0);
        0x2::transfer::public_transfer<VaultCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun create_vault(arg0: &mut 0x2::tx_context::TxContext) : (PersonalVault, VaultCap) {
        let v0 = 0x2::object::new(arg0);
        let v1 = 0x2::object::uid_to_address(&v0);
        let v2 = PersonalVault{
            id       : v0,
            deposits : 0x2::bag::new(arg0),
            owner    : 0x2::tx_context::sender(arg0),
        };
        let v3 = VaultCap{
            id       : 0x2::object::new(arg0),
            vault_id : v1,
        };
        let v4 = VaultCreated{
            vault_id : v1,
            owner    : 0x2::tx_context::sender(arg0),
        };
        0x2::event::emit<VaultCreated>(v4);
        (v2, v3)
    }

    public fun deposit<T0>(arg0: &mut PersonalVault, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.deposits, v0)) {
            let v1 = 0x2::bag::remove<0x1::type_name::TypeName, 0x2::coin::Coin<T0>>(&mut arg0.deposits, v0);
            0x2::coin::join<T0>(&mut v1, arg1);
            0x2::bag::add<0x1::type_name::TypeName, 0x2::coin::Coin<T0>>(&mut arg0.deposits, v0, v1);
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::coin::Coin<T0>>(&mut arg0.deposits, v0, arg1);
        };
        let v2 = DepositEvent{
            vault_id  : 0x2::object::uid_to_address(&arg0.id),
            coin_type : v0,
            amount    : 0x2::coin::value<T0>(&arg1),
            depositor : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<DepositEvent>(v2);
    }

    public entry fun deposit_sui(arg0: &mut PersonalVault, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        deposit<0x2::sui::SUI>(arg0, arg1, arg2);
    }

    public fun get_balance<T0>(arg0: &PersonalVault) : u64 {
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.deposits, v0)) {
            0x2::coin::value<T0>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::coin::Coin<T0>>(&arg0.deposits, v0))
        } else {
            0
        }
    }

    public fun get_owner(arg0: &PersonalVault) : address {
        arg0.owner
    }

    public fun get_vault_id(arg0: &PersonalVault) : address {
        0x2::object::uid_to_address(&arg0.id)
    }

    public fun has_coin_type<T0>(arg0: &PersonalVault) : bool {
        0x2::bag::contains<0x1::type_name::TypeName>(&arg0.deposits, 0x1::type_name::get<T0>())
    }

    public fun share_vault(arg0: PersonalVault) {
        0x2::transfer::public_share_object<PersonalVault>(arg0);
    }

    public fun transfer_vault(arg0: PersonalVault, arg1: VaultCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::uid_to_address(&arg0.id) == arg1.vault_id, 999);
        0x2::transfer::public_transfer<PersonalVault>(arg0, arg2);
        0x2::transfer::public_transfer<VaultCap>(arg1, arg2);
    }

    public fun withdraw<T0>(arg0: &mut PersonalVault, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&arg0.deposits, v0), 1);
        let v1 = 0x2::bag::remove<0x1::type_name::TypeName, 0x2::coin::Coin<T0>>(&mut arg0.deposits, v0);
        assert!(0x2::coin::value<T0>(&v1) >= arg1, 0);
        if (0x2::coin::value<T0>(&v1) > 0) {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::coin::Coin<T0>>(&mut arg0.deposits, v0, v1);
        } else {
            0x2::coin::destroy_zero<T0>(v1);
        };
        let v2 = WithdrawEvent{
            vault_id   : 0x2::object::uid_to_address(&arg0.id),
            coin_type  : v0,
            amount     : arg1,
            withdrawer : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<WithdrawEvent>(v2);
        0x2::coin::split<T0>(&mut v1, arg1, arg2)
    }

    public fun withdraw_all<T0>(arg0: &mut PersonalVault, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&arg0.deposits, v0), 1);
        let v1 = 0x2::bag::remove<0x1::type_name::TypeName, 0x2::coin::Coin<T0>>(&mut arg0.deposits, v0);
        let v2 = WithdrawEvent{
            vault_id   : 0x2::object::uid_to_address(&arg0.id),
            coin_type  : v0,
            amount     : 0x2::coin::value<T0>(&v1),
            withdrawer : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<WithdrawEvent>(v2);
        v1
    }

    public entry fun withdraw_all_sui(arg0: &mut PersonalVault, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = withdraw_all<0x2::sui::SUI>(arg0, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun withdraw_sui(arg0: &mut PersonalVault, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = withdraw<0x2::sui::SUI>(arg0, arg1, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v0, 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

