module 0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::registry {
    struct Registry has key {
        id: 0x2::object::UID,
        wallets_by_signer: 0x2::table::Table<address, vector<0x2::object::ID>>,
        wallet_count: u64,
    }

    public(friend) fun add_signer(arg0: &mut Registry, arg1: address, arg2: 0x2::object::ID) {
        if (!0x2::table::contains<address, vector<0x2::object::ID>>(&arg0.wallets_by_signer, arg1)) {
            0x2::table::add<address, vector<0x2::object::ID>>(&mut arg0.wallets_by_signer, arg1, 0x1::vector::empty<0x2::object::ID>());
        };
        let v0 = 0x2::table::borrow_mut<address, vector<0x2::object::ID>>(&mut arg0.wallets_by_signer, arg1);
        if (!0x1::vector::contains<0x2::object::ID>(v0, &arg2)) {
            0x1::vector::push_back<0x2::object::ID>(v0, arg2);
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Registry{
            id                : 0x2::object::new(arg0),
            wallets_by_signer : 0x2::table::new<address, vector<0x2::object::ID>>(arg0),
            wallet_count      : 0,
        };
        0x2::transfer::share_object<Registry>(v0);
    }

    public(friend) fun register_wallet(arg0: &mut Registry) {
        arg0.wallet_count = arg0.wallet_count + 1;
    }

    public(friend) fun remove_signer(arg0: &mut Registry, arg1: address, arg2: 0x2::object::ID) {
        if (!0x2::table::contains<address, vector<0x2::object::ID>>(&arg0.wallets_by_signer, arg1)) {
            return
        };
        let v0 = 0x2::table::borrow_mut<address, vector<0x2::object::ID>>(&mut arg0.wallets_by_signer, arg1);
        let (v1, v2) = 0x1::vector::index_of<0x2::object::ID>(v0, &arg2);
        if (v1) {
            0x1::vector::swap_remove<0x2::object::ID>(v0, v2);
        };
    }

    public fun wallet_count(arg0: &Registry) : u64 {
        arg0.wallet_count
    }

    public fun wallets_of(arg0: &Registry, arg1: address) : vector<0x2::object::ID> {
        if (0x2::table::contains<address, vector<0x2::object::ID>>(&arg0.wallets_by_signer, arg1)) {
            *0x2::table::borrow<address, vector<0x2::object::ID>>(&arg0.wallets_by_signer, arg1)
        } else {
            0x1::vector::empty<0x2::object::ID>()
        }
    }

    // decompiled from Move bytecode v7
}

