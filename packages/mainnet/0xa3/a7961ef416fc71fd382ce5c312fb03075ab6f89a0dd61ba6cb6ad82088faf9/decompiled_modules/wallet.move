module 0x644b305ca21dba04d53b6b8a04d88665c57b9593a80e8a435366f72b5653985f::wallet {
    struct Wallet has key {
        id: 0x2::object::UID,
        owner: address,
        signer: 0x5ea91cfad5399ecbf7ef1669379ea305e9bf9a4fda50667b8be82bda5da452ee::account::Account,
        auth: 0x2::linked_table::LinkedTable<0x1::type_name::TypeName, vector<0x1::type_name::TypeName>>,
        nfts: 0x2::object_bag::ObjectBag,
    }

    struct WalletCreated has copy, drop {
        wallet_id: 0x2::object::ID,
        owner: address,
        signer_address: address,
    }

    struct ServiceGranted has copy, drop {
        wallet_id: 0x2::object::ID,
        service: 0x1::type_name::TypeName,
        coin: 0x1::type_name::TypeName,
    }

    struct ServiceCoinRevoked has copy, drop {
        wallet_id: 0x2::object::ID,
        service: 0x1::type_name::TypeName,
        coin: 0x1::type_name::TypeName,
    }

    struct ServiceRevoked has copy, drop {
        wallet_id: 0x2::object::ID,
        service: 0x1::type_name::TypeName,
    }

    struct CoinDeposited has copy, drop {
        wallet_id: 0x2::object::ID,
        service: 0x1::option::Option<0x1::type_name::TypeName>,
        coin: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct CoinWithdrawn has copy, drop {
        wallet_id: 0x2::object::ID,
        service: 0x1::option::Option<0x1::type_name::TypeName>,
        coin: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct AssetReclaimed has copy, drop {
        wallet_id: 0x2::object::ID,
        asset_name: 0x1::string::String,
    }

    public fun balance<T0>(arg0: &Wallet, arg1: &0x2::accumulator::AccumulatorRoot) : u64 {
        0x5ea91cfad5399ecbf7ef1669379ea305e9bf9a4fda50667b8be82bda5da452ee::account::balance_value<T0>(&arg0.signer, arg1)
    }

    public fun id(arg0: &Wallet) : 0x2::object::ID {
        0x2::object::id<Wallet>(arg0)
    }

    public fun add_asset<T0: store + key>(arg0: &mut Wallet, arg1: T0, arg2: 0x1::string::String, arg3: &0x2::tx_context::TxContext) {
        assert_owner(arg0, arg3);
        0x2::object_bag::add<0x1::string::String, T0>(&mut arg0.nfts, arg2, arg1);
    }

    public fun add_coin<T0>(arg0: &mut Wallet, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::tx_context::TxContext) {
        assert_owner(arg0, arg2);
        deposit_internal<T0>(arg0, arg1, 0x1::option::none<0x1::type_name::TypeName>());
    }

    public(friend) fun assert_owner(arg0: &Wallet, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 5);
    }

    public fun create(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = 0x5ea91cfad5399ecbf7ef1669379ea305e9bf9a4fda50667b8be82bda5da452ee::account::new(0x1::option::none<0x1::string::String>(), arg0);
        let v2 = Wallet{
            id     : 0x2::object::new(arg0),
            owner  : v0,
            signer : v1,
            auth   : 0x2::linked_table::new<0x1::type_name::TypeName, vector<0x1::type_name::TypeName>>(arg0),
            nfts   : 0x2::object_bag::new(arg0),
        };
        0x2::transfer::share_object<Wallet>(v2);
        let v3 = WalletCreated{
            wallet_id      : 0x2::object::id<Wallet>(&v2),
            owner          : v0,
            signer_address : 0x5ea91cfad5399ecbf7ef1669379ea305e9bf9a4fda50667b8be82bda5da452ee::account::account_address(&v1),
        };
        0x2::event::emit<WalletCreated>(v3);
    }

    fun deposit_internal<T0>(arg0: &mut Wallet, arg1: 0x2::coin::Coin<T0>, arg2: 0x1::option::Option<0x1::type_name::TypeName>) {
        0x5ea91cfad5399ecbf7ef1669379ea305e9bf9a4fda50667b8be82bda5da452ee::account::send_funds<T0>(&arg0.signer, arg1);
        let v0 = CoinDeposited{
            wallet_id : 0x2::object::id<Wallet>(arg0),
            service   : arg2,
            coin      : 0x1::type_name::with_defining_ids<T0>(),
            amount    : 0x2::coin::value<T0>(&arg1),
        };
        0x2::event::emit<CoinDeposited>(v0);
    }

    public fun grant_service_coin<T0, T1>(arg0: &mut Wallet, arg1: &0x2::tx_context::TxContext) {
        assert_owner(arg0, arg1);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = 0x1::type_name::with_defining_ids<T1>();
        if (0x2::linked_table::contains<0x1::type_name::TypeName, vector<0x1::type_name::TypeName>>(&arg0.auth, v0)) {
            let v2 = 0x2::linked_table::borrow_mut<0x1::type_name::TypeName, vector<0x1::type_name::TypeName>>(&mut arg0.auth, v0);
            if (!0x1::vector::contains<0x1::type_name::TypeName>(v2, &v1)) {
                0x1::vector::push_back<0x1::type_name::TypeName>(v2, v1);
            };
        } else {
            let v3 = 0x1::vector::empty<0x1::type_name::TypeName>();
            0x1::vector::push_back<0x1::type_name::TypeName>(&mut v3, v1);
            0x2::linked_table::push_back<0x1::type_name::TypeName, vector<0x1::type_name::TypeName>>(&mut arg0.auth, v0, v3);
        };
        let v4 = ServiceGranted{
            wallet_id : 0x2::object::id<Wallet>(arg0),
            service   : v0,
            coin      : v1,
        };
        0x2::event::emit<ServiceGranted>(v4);
    }

    public fun identity(arg0: &Wallet) : address {
        0x5ea91cfad5399ecbf7ef1669379ea305e9bf9a4fda50667b8be82bda5da452ee::account::account_address(&arg0.signer)
    }

    public fun is_authorized<T0, T1>(arg0: &Wallet) : bool {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (!0x2::linked_table::contains<0x1::type_name::TypeName, vector<0x1::type_name::TypeName>>(&arg0.auth, v0)) {
            return false
        };
        let v1 = 0x1::type_name::with_defining_ids<T1>();
        0x1::vector::contains<0x1::type_name::TypeName>(0x2::linked_table::borrow<0x1::type_name::TypeName, vector<0x1::type_name::TypeName>>(&arg0.auth, v0), &v1)
    }

    public fun owner(arg0: &Wallet) : address {
        arg0.owner
    }

    public(friend) fun pay_by_service<T0, T1>(arg0: &mut Wallet, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        withdraw_internal<T1>(arg0, arg1, 0x1::option::some<0x1::type_name::TypeName>(0x1::type_name::with_defining_ids<T0>()), arg2)
    }

    public fun receive_from_service<T0: drop, T1>(arg0: &mut Wallet, arg1: 0x2::coin::Coin<T1>, arg2: T0) {
        deposit_internal<T1>(arg0, arg1, 0x1::option::some<0x1::type_name::TypeName>(0x1::type_name::with_defining_ids<T0>()));
    }

    public(friend) fun receive_from_service_internal<T0, T1>(arg0: &mut Wallet, arg1: 0x2::coin::Coin<T1>) {
        deposit_internal<T1>(arg0, arg1, 0x1::option::some<0x1::type_name::TypeName>(0x1::type_name::with_defining_ids<T0>()));
    }

    public fun reclaim_asset<T0: store + key>(arg0: &mut Wallet, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        assert_owner(arg0, arg2);
        0x2::transfer::public_transfer<T0>(0x2::object_bag::remove<0x1::string::String, T0>(&mut arg0.nfts, arg1), 0x2::tx_context::sender(arg2));
        let v0 = AssetReclaimed{
            wallet_id  : 0x2::object::id<Wallet>(arg0),
            asset_name : arg1,
        };
        0x2::event::emit<AssetReclaimed>(v0);
    }

    public fun revoke_service<T0>(arg0: &mut Wallet, arg1: &0x2::tx_context::TxContext) {
        assert_owner(arg0, arg1);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::linked_table::contains<0x1::type_name::TypeName, vector<0x1::type_name::TypeName>>(&arg0.auth, v0), 10);
        0x2::linked_table::remove<0x1::type_name::TypeName, vector<0x1::type_name::TypeName>>(&mut arg0.auth, v0);
        let v1 = ServiceRevoked{
            wallet_id : 0x2::object::id<Wallet>(arg0),
            service   : v0,
        };
        0x2::event::emit<ServiceRevoked>(v1);
    }

    public fun revoke_service_coin<T0, T1>(arg0: &mut Wallet, arg1: &0x2::tx_context::TxContext) {
        assert_owner(arg0, arg1);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = 0x1::type_name::with_defining_ids<T1>();
        assert!(0x2::linked_table::contains<0x1::type_name::TypeName, vector<0x1::type_name::TypeName>>(&arg0.auth, v0), 10);
        let v2 = 0x2::linked_table::borrow_mut<0x1::type_name::TypeName, vector<0x1::type_name::TypeName>>(&mut arg0.auth, v0);
        let (v3, v4) = 0x1::vector::index_of<0x1::type_name::TypeName>(v2, &v1);
        assert!(v3, 11);
        0x1::vector::remove<0x1::type_name::TypeName>(v2, v4);
        let v5 = ServiceCoinRevoked{
            wallet_id : 0x2::object::id<Wallet>(arg0),
            service   : v0,
            coin      : v1,
        };
        0x2::event::emit<ServiceCoinRevoked>(v5);
    }

    public fun set_signer_alias(arg0: &mut Wallet, arg1: 0x1::string::String, arg2: &0x2::tx_context::TxContext) {
        assert_owner(arg0, arg2);
        0x5ea91cfad5399ecbf7ef1669379ea305e9bf9a4fda50667b8be82bda5da452ee::account::update_alias(&mut arg0.signer, arg1);
    }

    public fun sign(arg0: &Wallet, arg1: &0x2::tx_context::TxContext) : 0x5ea91cfad5399ecbf7ef1669379ea305e9bf9a4fda50667b8be82bda5da452ee::account::AccountRequest {
        assert_owner(arg0, arg1);
        0x5ea91cfad5399ecbf7ef1669379ea305e9bf9a4fda50667b8be82bda5da452ee::account::request_with_account(&arg0.signer)
    }

    public fun take_coin<T0>(arg0: &mut Wallet, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert_owner(arg0, arg2);
        let v0 = withdraw_internal<T0>(arg0, arg1, 0x1::option::none<0x1::type_name::TypeName>(), arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg2));
    }

    public fun uid(arg0: &Wallet) : &0x2::object::UID {
        &arg0.id
    }

    public(friend) fun uid_mut(arg0: &mut Wallet) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public fun withdraw_coin<T0>(arg0: &mut Wallet, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_owner(arg0, arg2);
        withdraw_internal<T0>(arg0, arg1, 0x1::option::none<0x1::type_name::TypeName>(), arg2)
    }

    fun withdraw_internal<T0>(arg0: &mut Wallet, arg1: u64, arg2: 0x1::option::Option<0x1::type_name::TypeName>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = CoinWithdrawn{
            wallet_id : 0x2::object::id<Wallet>(arg0),
            service   : arg2,
            coin      : 0x1::type_name::with_defining_ids<T0>(),
            amount    : arg1,
        };
        0x2::event::emit<CoinWithdrawn>(v0);
        0x2::coin::from_balance<T0>(0x5ea91cfad5399ecbf7ef1669379ea305e9bf9a4fda50667b8be82bda5da452ee::account::withdraw_funds<T0>(&mut arg0.signer, arg1), arg3)
    }

    // decompiled from Move bytecode v7
}

