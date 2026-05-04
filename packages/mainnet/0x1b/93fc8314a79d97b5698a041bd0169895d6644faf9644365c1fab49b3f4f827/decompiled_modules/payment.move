module 0x1b93fc8314a79d97b5698a041bd0169895d6644faf9644365c1fab49b3f4f827::payment {
    struct ProtocolVault has store, key {
        id: 0x2::object::UID,
        protocol_name: 0x1::string::String,
        protocol_address: address,
        protocol_uid: u64,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        created_at: u64,
        total_settlements: u64,
    }

    struct PaymentRegistry has key {
        id: 0x2::object::UID,
        protocol_vaults: 0x2::table::Table<address, 0x2::object::ID>,
        protocol_uid_mapping: 0x2::table::Table<u64, address>,
        nft_settlements: 0x2::table::Table<0x2::object::ID, bool>,
        suiverify_vault: 0x2::balance::Balance<0x2::sui::SUI>,
        total_protocols: u64,
        total_settlements: u64,
        next_protocol_uid: u64,
    }

    struct PaymentCap has key {
        id: 0x2::object::UID,
        registry_id: 0x2::object::ID,
    }

    struct ProtocolRegistered has copy, drop {
        protocol_address: address,
        protocol_name: 0x1::string::String,
        protocol_uid: u64,
        vault_id: 0x2::object::ID,
        initial_amount: u64,
        timestamp: u64,
    }

    struct VaultFunded has copy, drop {
        protocol_address: address,
        protocol_name: 0x1::string::String,
        protocol_uid: u64,
        amount: u64,
        new_balance: u64,
        timestamp: u64,
    }

    struct NFTSettled has copy, drop {
        protocol_address: address,
        protocol_name: 0x1::string::String,
        protocol_uid: u64,
        nft_id: 0x2::object::ID,
        nft_name: 0x1::string::String,
        settlement_amount: u64,
        timestamp: u64,
    }

    struct TreasuryWithdrawal has copy, drop {
        amount: u64,
        withdrawn_to: address,
        timestamp: u64,
    }

    public fun emergency_withdraw_vault(arg0: &mut ProtocolVault, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(arg0.protocol_address == 0x2::tx_context::sender(arg2), 1);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, arg1), arg2)
    }

    entry fun fund_vault(arg0: &PaymentRegistry, arg1: &PaymentCap, arg2: &mut ProtocolVault, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert!(arg1.registry_id == 0x2::object::id<PaymentRegistry>(arg0), 6);
        0x2::balance::join<0x2::sui::SUI>(&mut arg2.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg3));
        let v0 = VaultFunded{
            protocol_address : arg2.protocol_address,
            protocol_name    : arg2.protocol_name,
            protocol_uid     : arg2.protocol_uid,
            amount           : 0x2::coin::value<0x2::sui::SUI>(&arg3),
            new_balance      : 0x2::balance::value<0x2::sui::SUI>(&arg2.balance),
            timestamp        : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<VaultFunded>(v0);
    }

    public fun get_protocol_by_uid(arg0: &PaymentRegistry, arg1: u64) : 0x1::option::Option<address> {
        if (0x2::table::contains<u64, address>(&arg0.protocol_uid_mapping, arg1)) {
            0x1::option::some<address>(*0x2::table::borrow<u64, address>(&arg0.protocol_uid_mapping, arg1))
        } else {
            0x1::option::none<address>()
        }
    }

    public fun get_registry_stats(arg0: &PaymentRegistry) : (u64, u64, u64) {
        (arg0.total_protocols, arg0.total_settlements, 0x2::balance::value<0x2::sui::SUI>(&arg0.suiverify_vault))
    }

    public fun get_vault_balance(arg0: &ProtocolVault) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.balance)
    }

    public fun get_vault_info(arg0: &ProtocolVault) : (0x1::string::String, address, u64, u64, u64, u64) {
        (arg0.protocol_name, arg0.protocol_address, arg0.protocol_uid, 0x2::balance::value<0x2::sui::SUI>(&arg0.balance), arg0.created_at, arg0.total_settlements)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PaymentRegistry{
            id                   : 0x2::object::new(arg0),
            protocol_vaults      : 0x2::table::new<address, 0x2::object::ID>(arg0),
            protocol_uid_mapping : 0x2::table::new<u64, address>(arg0),
            nft_settlements      : 0x2::table::new<0x2::object::ID, bool>(arg0),
            suiverify_vault      : 0x2::balance::zero<0x2::sui::SUI>(),
            total_protocols      : 0,
            total_settlements    : 0,
            next_protocol_uid    : 1000,
        };
        let v1 = PaymentCap{
            id          : 0x2::object::new(arg0),
            registry_id : 0x2::object::id<PaymentRegistry>(&v0),
        };
        0x2::transfer::share_object<PaymentRegistry>(v0);
        0x2::transfer::transfer<PaymentCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun is_nft_settled(arg0: &PaymentRegistry, arg1: 0x2::object::ID) : bool {
        0x2::table::contains<0x2::object::ID, bool>(&arg0.nft_settlements, arg1) && *0x2::table::borrow<0x2::object::ID, bool>(&arg0.nft_settlements, arg1)
    }

    public fun is_protocol_registered(arg0: &PaymentRegistry, arg1: address) : bool {
        0x2::table::contains<address, 0x2::object::ID>(&arg0.protocol_vaults, arg1)
    }

    entry fun register_protocol(arg0: &mut PaymentRegistry, arg1: &PaymentCap, arg2: 0x1::string::String, arg3: address, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.registry_id == 0x2::object::id<PaymentRegistry>(arg0), 6);
        assert!(!0x2::table::contains<address, 0x2::object::ID>(&arg0.protocol_vaults, arg3), 5);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg4);
        assert!(v0 >= 3000000, 4);
        let v1 = arg0.next_protocol_uid;
        arg0.next_protocol_uid = arg0.next_protocol_uid + 1;
        let v2 = ProtocolVault{
            id                : 0x2::object::new(arg6),
            protocol_name     : arg2,
            protocol_address  : arg3,
            protocol_uid      : v1,
            balance           : 0x2::coin::into_balance<0x2::sui::SUI>(arg4),
            created_at        : 0x2::clock::timestamp_ms(arg5),
            total_settlements : 0,
        };
        let v3 = 0x2::object::id<ProtocolVault>(&v2);
        0x2::table::add<address, 0x2::object::ID>(&mut arg0.protocol_vaults, arg3, v3);
        0x2::table::add<u64, address>(&mut arg0.protocol_uid_mapping, v1, arg3);
        arg0.total_protocols = arg0.total_protocols + 1;
        0x2::transfer::share_object<ProtocolVault>(v2);
        let v4 = ProtocolRegistered{
            protocol_address : arg3,
            protocol_name    : arg2,
            protocol_uid     : v1,
            vault_id         : v3,
            initial_amount   : v0,
            timestamp        : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<ProtocolRegistered>(v4);
    }

    entry fun settle_nft_payment(arg0: &mut PaymentRegistry, arg1: &PaymentCap, arg2: u64, arg3: 0x2::object::ID, arg4: 0x1::string::String, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        assert!(arg1.registry_id == 0x2::object::id<PaymentRegistry>(arg0), 6);
        assert!(0x2::table::contains<u64, address>(&arg0.protocol_uid_mapping, arg2), 7);
        let v0 = *0x2::table::borrow<u64, address>(&arg0.protocol_uid_mapping, arg2);
        if (0x2::table::contains<0x2::object::ID, bool>(&arg0.nft_settlements, arg3)) {
            assert!(!*0x2::table::borrow<0x2::object::ID, bool>(&arg0.nft_settlements, arg3), 3);
        } else {
            0x2::table::add<0x2::object::ID, bool>(&mut arg0.nft_settlements, arg3, false);
        };
        *0x2::table::borrow_mut<0x2::object::ID, bool>(&mut arg0.nft_settlements, arg3) = true;
        arg0.total_settlements = arg0.total_settlements + 1;
        let v1 = NFTSettled{
            protocol_address  : v0,
            protocol_name     : 0x1::string::utf8(b""),
            protocol_uid      : arg2,
            nft_id            : arg3,
            nft_name          : arg4,
            settlement_amount : 3000000,
            timestamp         : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<NFTSettled>(v1);
    }

    entry fun settle_nft_payment_with_vault(arg0: &mut PaymentRegistry, arg1: &PaymentCap, arg2: &mut ProtocolVault, arg3: u64, arg4: 0x2::object::ID, arg5: 0x1::string::String, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        assert!(arg1.registry_id == 0x2::object::id<PaymentRegistry>(arg0), 6);
        assert!(arg2.protocol_uid == arg3, 1);
        if (0x2::table::contains<0x2::object::ID, bool>(&arg0.nft_settlements, arg4)) {
            assert!(!*0x2::table::borrow<0x2::object::ID, bool>(&arg0.nft_settlements, arg4), 3);
        } else {
            0x2::table::add<0x2::object::ID, bool>(&mut arg0.nft_settlements, arg4, false);
        };
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg2.balance) >= 3000000, 2);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.suiverify_vault, 0x2::balance::split<0x2::sui::SUI>(&mut arg2.balance, 3000000));
        *0x2::table::borrow_mut<0x2::object::ID, bool>(&mut arg0.nft_settlements, arg4) = true;
        arg2.total_settlements = arg2.total_settlements + 1;
        arg0.total_settlements = arg0.total_settlements + 1;
        let v0 = NFTSettled{
            protocol_address  : arg2.protocol_address,
            protocol_name     : arg2.protocol_name,
            protocol_uid      : arg2.protocol_uid,
            nft_id            : arg4,
            nft_name          : arg5,
            settlement_amount : 3000000,
            timestamp         : 0x2::clock::timestamp_ms(arg6),
        };
        0x2::event::emit<NFTSettled>(v0);
    }

    entry fun withdraw_treasury(arg0: &mut PaymentRegistry, arg1: &PaymentCap, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.registry_id == 0x2::object::id<PaymentRegistry>(arg0), 6);
        let v0 = TreasuryWithdrawal{
            amount       : arg2,
            withdrawn_to : 0x2::tx_context::sender(arg4),
            timestamp    : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<TreasuryWithdrawal>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.suiverify_vault, arg2), arg4), 0x2::tx_context::sender(arg4));
    }

    // decompiled from Move bytecode v6
}

