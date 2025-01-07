module 0x60edcdd61727c06b94e0e9e5b034240d3c905d00a82ffb06b63d9aedbac2c5a0::asset_locker {
    struct AssetLocker<T0: store, phantom T1: drop> has store, key {
        id: 0x2::object::UID,
        assets_of: 0x2::table::Table<address, vector<T0>>,
    }

    public fun new<T0: store, T1: drop>(arg0: &T1, arg1: &mut 0x2::tx_context::TxContext) : AssetLocker<T0, T1> {
        AssetLocker<T0, T1>{
            id        : 0x2::object::new(arg1),
            assets_of : 0x2::table::new<address, vector<T0>>(arg1),
        }
    }

    public fun assets_of<T0: store, T1: drop>(arg0: &AssetLocker<T0, T1>, arg1: &T1, arg2: address) : &vector<T0> {
        0x2::table::borrow<address, vector<T0>>(&arg0.assets_of, arg2)
    }

    public fun assets_of_mut<T0: store, T1: drop>(arg0: &mut AssetLocker<T0, T1>, arg1: &mut T1, arg2: address) : &mut vector<T0> {
        0x2::table::borrow_mut<address, vector<T0>>(&mut arg0.assets_of, arg2)
    }

    public(friend) fun assets_of_unsafe<T0: store, T1: drop>(arg0: &AssetLocker<T0, T1>, arg1: address) : &vector<T0> {
        0x2::table::borrow<address, vector<T0>>(&arg0.assets_of, arg1)
    }

    public fun create<T0: store, T1: drop>(arg0: &T1, arg1: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = AssetLocker<T0, T1>{
            id        : 0x2::object::new(arg1),
            assets_of : 0x2::table::new<address, vector<T0>>(arg1),
        };
        0x2::transfer::share_object<AssetLocker<T0, T1>>(v0);
        0x2::object::id<AssetLocker<T0, T1>>(&v0)
    }

    public fun has_assets<T0: store, T1: drop>(arg0: &AssetLocker<T0, T1>, arg1: address) : bool {
        0x2::table::contains<address, vector<T0>>(&arg0.assets_of, arg1) && 0x1::vector::length<T0>(0x2::table::borrow<address, vector<T0>>(&arg0.assets_of, arg1)) > 0
    }

    fun init_owner_assets<T0: store, T1: drop>(arg0: &mut AssetLocker<T0, T1>, arg1: address) {
        if (!0x2::table::contains<address, vector<T0>>(&arg0.assets_of, arg1)) {
            0x2::table::add<address, vector<T0>>(&mut arg0.assets_of, arg1, 0x1::vector::empty<T0>());
        };
    }

    public fun lock<T0: store, T1: drop>(arg0: &mut AssetLocker<T0, T1>, arg1: &mut T1, arg2: address, arg3: T0, arg4: 0x1::ascii::String, arg5: u256, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        init_owner_assets<T0, T1>(arg0, arg2);
        0x1::vector::push_back<T0>(0x2::table::borrow_mut<address, vector<T0>>(&mut arg0.assets_of, arg2), arg3);
        0xb5b6c91d3161c1fc27075339dbe8afafef5f85f6762157be484ed49583f7ef53::point::send_stake_point_req_with_owner<T1>(arg1, arg2, arg4, arg5, arg6, arg7, arg8);
    }

    public fun unlock<T0: store, T1: drop>(arg0: &mut AssetLocker<T0, T1>, arg1: &mut T1, arg2: address, arg3: u64, arg4: 0x1::ascii::String, arg5: u256, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : T0 {
        assert!(0x2::table::contains<address, vector<T0>>(&arg0.assets_of, arg2), 101);
        0xb5b6c91d3161c1fc27075339dbe8afafef5f85f6762157be484ed49583f7ef53::point::send_unstake_point_req_with_owner<T1>(arg1, arg2, arg4, arg5, arg6, arg7, arg8);
        0x1::vector::remove<T0>(0x2::table::borrow_mut<address, vector<T0>>(&mut arg0.assets_of, arg2), arg3)
    }

    // decompiled from Move bytecode v6
}

