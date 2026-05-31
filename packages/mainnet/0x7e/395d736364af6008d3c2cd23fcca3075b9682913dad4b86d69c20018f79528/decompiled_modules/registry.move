module 0x7e395d736364af6008d3c2cd23fcca3075b9682913dad4b86d69c20018f79528::registry {
    struct WalletAccountRegistry has key {
        id: 0x2::object::UID,
        per_wallet: 0x2::table::Table<address, vector<0x2::object::ID>>,
        total_accounts: u64,
    }

    struct AccountRegistered has copy, drop {
        registry_id: 0x2::object::ID,
        wallet_identity: address,
        os_account_id: 0x2::object::ID,
        wallet_account_count_after: u64,
    }

    public fun id(arg0: &WalletAccountRegistry) : 0x2::object::ID {
        0x2::object::id<WalletAccountRegistry>(arg0)
    }

    public fun new(arg0: &mut 0x2::tx_context::TxContext) : WalletAccountRegistry {
        WalletAccountRegistry{
            id             : 0x2::object::new(arg0),
            per_wallet     : 0x2::table::new<address, vector<0x2::object::ID>>(arg0),
            total_accounts : 0,
        }
    }

    public fun account_at(arg0: &WalletAccountRegistry, arg1: address, arg2: u64) : 0x2::object::ID {
        assert!(0x2::table::contains<address, vector<0x2::object::ID>>(&arg0.per_wallet, arg1), 0);
        *0x1::vector::borrow<0x2::object::ID>(0x2::table::borrow<address, vector<0x2::object::ID>>(&arg0.per_wallet, arg1), arg2)
    }

    public fun account_count(arg0: &WalletAccountRegistry, arg1: address) : u64 {
        if (!0x2::table::contains<address, vector<0x2::object::ID>>(&arg0.per_wallet, arg1)) {
            return 0
        };
        0x1::vector::length<0x2::object::ID>(0x2::table::borrow<address, vector<0x2::object::ID>>(&arg0.per_wallet, arg1))
    }

    public fun create_and_share(arg0: &mut 0x2::tx_context::TxContext) {
        share_registry(new(arg0));
    }

    public fun has_wallet(arg0: &WalletAccountRegistry, arg1: address) : bool {
        0x2::table::contains<address, vector<0x2::object::ID>>(&arg0.per_wallet, arg1)
    }

    public fun list_accounts(arg0: &WalletAccountRegistry, arg1: address) : vector<0x2::object::ID> {
        assert!(0x2::table::contains<address, vector<0x2::object::ID>>(&arg0.per_wallet, arg1), 0);
        *0x2::table::borrow<address, vector<0x2::object::ID>>(&arg0.per_wallet, arg1)
    }

    public(friend) fun register(arg0: &mut WalletAccountRegistry, arg1: address, arg2: 0x2::object::ID) {
        let v0 = if (!0x2::table::contains<address, vector<0x2::object::ID>>(&arg0.per_wallet, arg1)) {
            let v1 = 0x1::vector::empty<0x2::object::ID>();
            0x1::vector::push_back<0x2::object::ID>(&mut v1, arg2);
            0x2::table::add<address, vector<0x2::object::ID>>(&mut arg0.per_wallet, arg1, v1);
            1
        } else {
            let v2 = 0x2::table::borrow_mut<address, vector<0x2::object::ID>>(&mut arg0.per_wallet, arg1);
            0x1::vector::push_back<0x2::object::ID>(v2, arg2);
            0x1::vector::length<0x2::object::ID>(v2)
        };
        arg0.total_accounts = arg0.total_accounts + 1;
        let v3 = AccountRegistered{
            registry_id                : 0x2::object::id<WalletAccountRegistry>(arg0),
            wallet_identity            : arg1,
            os_account_id              : arg2,
            wallet_account_count_after : v0,
        };
        0x2::event::emit<AccountRegistered>(v3);
    }

    public fun share_registry(arg0: WalletAccountRegistry) {
        0x2::transfer::share_object<WalletAccountRegistry>(arg0);
    }

    public fun total_accounts(arg0: &WalletAccountRegistry) : u64 {
        arg0.total_accounts
    }

    // decompiled from Move bytecode v7
}

