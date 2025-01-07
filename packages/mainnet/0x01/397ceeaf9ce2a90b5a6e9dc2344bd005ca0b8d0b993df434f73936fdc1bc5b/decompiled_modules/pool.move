module 0x1397ceeaf9ce2a90b5a6e9dc2344bd005ca0b8d0b993df434f73936fdc1bc5b::pool {
    struct PoolData<phantom T0> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
    }

    struct HouseData has key {
        id: 0x2::object::UID,
        owner: address,
        exchanger_public_keys: vector<vector<u8>>,
        user_used_nonces: 0x2::vec_map::VecMap<address, vector<u64>>,
    }

    struct Claimed has copy, drop {
        coin_type: 0x1::string::String,
        user_address: address,
        amount: u64,
        nonce: u64,
    }

    public entry fun add_exchanger(arg0: &mut HouseData, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(is_admin(arg0.owner, arg2), 2);
        0x1::vector::push_back<vector<u8>>(&mut arg0.exchanger_public_keys, arg1);
    }

    public entry fun deposit<T0>(arg0: &mut PoolData<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(give_change<T0>(arg1, arg2, arg3)));
    }

    fun give_change<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::coin::value<T0>(&arg0) >= arg1, 0);
        if (0x2::coin::value<T0>(&arg0) == arg1) {
            return arg0
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg2));
        0x2::coin::split<T0>(&mut arg0, arg1, arg2)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = HouseData{
            id                    : 0x2::object::new(arg0),
            owner                 : 0x2::tx_context::sender(arg0),
            exchanger_public_keys : 0x1::vector::empty<vector<u8>>(),
            user_used_nonces      : 0x2::vec_map::empty<address, vector<u64>>(),
        };
        0x2::transfer::share_object<HouseData>(v0);
    }

    public entry fun init_pool<T0>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PoolData<T0>{
            id      : 0x2::object::new(arg0),
            balance : 0x2::balance::zero<T0>(),
        };
        0x2::transfer::share_object<PoolData<T0>>(v0);
    }

    fun is_admin(arg0: address, arg1: &0x2::tx_context::TxContext) : bool {
        0x2::tx_context::sender(arg1) == @0xd405b4b6cc3b704270de1452e0c37557e372c638e19c9008ed55a56329016d64 || 0x2::tx_context::sender(arg1) == arg0
    }

    fun raw_msg(arg0: &0x1::string::String, arg1: &address, arg2: &u64, arg3: &u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<0x1::string::String>(arg0));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<address>(arg1));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(arg2));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(arg3));
        v0
    }

    public entry fun remove_exchanger(arg0: &mut HouseData, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(is_admin(arg0.owner, arg2), 2);
        let (_, v1) = 0x1::vector::index_of<vector<u8>>(&arg0.exchanger_public_keys, &arg1);
        0x1::vector::remove<vector<u8>>(&mut arg0.exchanger_public_keys, v1);
    }

    public entry fun withdraw<T0>(arg0: &mut HouseData, arg1: &mut PoolData<T0>, arg2: vector<u8>, arg3: u64, arg4: u64, arg5: vector<u8>, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        assert!(0x1::vector::contains<vector<u8>>(&arg0.exchanger_public_keys, &arg2), 5);
        if (!0x2::vec_map::contains<address, vector<u64>>(&arg0.user_used_nonces, &v0)) {
            0x2::vec_map::insert<address, vector<u64>>(&mut arg0.user_used_nonces, v0, 0x1::vector::empty<u64>());
        };
        let v1 = 0x2::vec_map::get_mut<address, vector<u64>>(&mut arg0.user_used_nonces, &v0);
        let v2 = *v1;
        assert!(!0x1::vector::contains<u64>(&v2, &arg4), 3);
        let v3 = 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<0x2::coin::Coin<T0>>()));
        let v4 = raw_msg(&v3, &v0, &arg3, &arg4);
        assert!(0x2::ed25519::ed25519_verify(&arg5, &arg2, &v4), 4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg1.balance, arg3, arg6), 0x2::tx_context::sender(arg6));
        0x1::vector::push_back<u64>(v1, arg4);
        let v5 = Claimed{
            coin_type    : v3,
            user_address : v0,
            amount       : arg3,
            nonce        : arg4,
        };
        0x2::event::emit<Claimed>(v5);
    }

    // decompiled from Move bytecode v6
}

