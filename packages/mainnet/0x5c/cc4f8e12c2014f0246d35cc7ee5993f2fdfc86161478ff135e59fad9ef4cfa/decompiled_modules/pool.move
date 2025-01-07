module 0x5ccc4f8e12c2014f0246d35cc7ee5993f2fdfc86161478ff135e59fad9ef4cfa::pool {
    struct AdminCap<phantom T0> has store, key {
        id: 0x2::object::UID,
    }

    struct Pool<phantom T0> has store, key {
        id: 0x2::object::UID,
        name: vector<u8>,
        borrow_coin_type: 0x1::type_name::TypeName,
        xTokenSupply: u64,
        tokensInvested: u64,
        rewards: 0x2::bag::Bag,
        acc_rewards_per_xtoken: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u256>,
        bal: 0x2::balance::Balance<T0>,
    }

    struct Receipt has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        pool_id: 0x2::object::ID,
        xTokenBalance: u64,
        last_acc_reward_per_xtoken: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u256>,
    }

    struct POOL has drop {
        dummy_field: bool,
    }

    struct Display has drop, store {
        pool_id: 0x2::object::ID,
        xTokenBalance: u64,
        alpha_balance: u64,
        last_acc_alpha_per_xtoken: u256,
        investedAmount: u64,
        balance: u256,
    }

    struct CheckPlease has copy, drop {
        val1: u64,
        val2: u64,
        val3: u64,
    }

    fun assert_receipt<T0>(arg0: &mut Receipt, arg1: &mut Pool<T0>) {
        assert!(arg0.pool_id == 0x2::object::uid_to_inner(&arg1.id), 0);
    }

    public fun create<T0, T1>(arg0: vector<u8>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Pool<T0>{
            id                     : 0x2::object::new(arg1),
            name                   : arg0,
            borrow_coin_type       : 0x1::type_name::get<T1>(),
            xTokenSupply           : 0,
            tokensInvested         : 0,
            rewards                : 0x2::bag::new(arg1),
            acc_rewards_per_xtoken : 0x2::vec_map::empty<0x1::type_name::TypeName, u256>(),
            bal                    : 0x2::balance::zero<T0>(),
        };
        0x2::transfer::public_share_object<Pool<T0>>(v0);
        let v1 = AdminCap<T0>{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap<T0>>(v1, 0x2::tx_context::sender(arg1));
    }

    fun deposit<T0, T1>(arg0: 0x1::option::Option<Receipt>, arg1: &mut Pool<T0>, arg2: 0x2::balance::Balance<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::tx_context::sender(arg3);
        let v0 = exchange_rate<T0>(arg1);
        let v1 = 0x2::balance::value<T0>(&arg2);
        arg1.tokensInvested = arg1.tokensInvested + v1;
        0x2::balance::join<T0>(&mut arg1.bal, arg2);
        let v2 = (v1 as u256) * v0 / (1000000000 as u256);
        arg1.xTokenSupply = arg1.xTokenSupply + (v2 as u64);
        if (0x1::option::is_some<Receipt>(&arg0) == true) {
            let v3 = 0x1::option::extract<Receipt>(&mut arg0);
            v3.xTokenBalance = v3.xTokenBalance + (v2 as u64);
            0x2::transfer::public_transfer<Receipt>(v3, 0x2::tx_context::sender(arg3));
        } else {
            let v4 = 0x2::vec_map::empty<0x1::type_name::TypeName, u256>();
            let v5 = 0;
            while (v5 < 0x2::vec_map::size<0x1::type_name::TypeName, u256>(&arg1.acc_rewards_per_xtoken)) {
                let (v6, v7) = 0x2::vec_map::get_entry_by_idx_mut<0x1::type_name::TypeName, u256>(&mut arg1.acc_rewards_per_xtoken, v5);
                0x2::vec_map::insert<0x1::type_name::TypeName, u256>(&mut v4, *v6, *v7);
                v5 = v5 + 1;
            };
            let v8 = Receipt{
                id                         : 0x2::object::new(arg3),
                name                       : 0x1::string::utf8(arg1.name),
                pool_id                    : 0x2::object::uid_to_inner(&arg1.id),
                xTokenBalance              : (v2 as u64),
                last_acc_reward_per_xtoken : v4,
            };
            0x2::transfer::public_transfer<Receipt>(v8, 0x2::tx_context::sender(arg3));
        };
        0x1::option::destroy_none<Receipt>(arg0);
    }

    public fun destroy(arg0: Receipt) {
        let Receipt {
            id                         : v0,
            name                       : _,
            pool_id                    : _,
            xTokenBalance              : _,
            last_acc_reward_per_xtoken : v4,
        } = arg0;
        let v5 = v4;
        0x2::object::delete(v0);
        let v6 = 0;
        while (v6 < 0x2::vec_map::size<0x1::type_name::TypeName, u256>(&v5)) {
            let (_, _) = 0x2::vec_map::pop<0x1::type_name::TypeName, u256>(&mut v5);
            v6 = v6 + 1;
        };
        0x2::vec_map::destroy_empty<0x1::type_name::TypeName, u256>(v5);
    }

    fun exchange_rate<T0>(arg0: &mut Pool<T0>) : u256 {
        if (arg0.tokensInvested == 0 || arg0.xTokenSupply == 0) {
            (1000000000 as u256)
        } else {
            (arg0.xTokenSupply as u256) * (1000000000 as u256) / (arg0.tokensInvested as u256)
        }
    }

    fun init(arg0: POOL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://media.gq.com/photos/5b6b20e3a3a1320b7280f029/16:9/w_2560%2Cc_limit/The-Brutal-Wonders-Of-The-Architecture-World-GQ-Style-Fall-2018_07.jpg"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Your stake object"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Unknown Sui Fan"));
        let v4 = 0x2::package::claim<POOL>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<Receipt>(&v4, v0, v2, arg1);
        0x2::display::update_version<Receipt>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Receipt>>(v5, 0x2::tx_context::sender(arg1));
    }

    public fun take_all<T0>(arg0: &mut Pool<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.bal), arg1), 0x2::tx_context::sender(arg1));
    }

    public fun user_deposit<T0, T1>(arg0: 0x1::option::Option<Receipt>, arg1: &mut Pool<T0>, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::type_name::get<T1>() == arg1.borrow_coin_type, 5);
        if (0x1::option::is_some<Receipt>(&arg0) == true) {
            let v0 = 0x1::option::borrow_mut<Receipt>(&mut arg0);
            assert_receipt<T0>(v0, arg1);
        };
        deposit<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(arg2), arg3);
    }

    public fun user_withdraw<T0, T1>(arg0: Receipt, arg1: &mut Pool<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::type_name::get<T1>() == arg1.borrow_coin_type, 5);
        let v0 = &mut arg0;
        assert_receipt<T0>(v0, arg1);
        withdraw<T0, T1>(arg0, arg1, arg2, arg3);
    }

    fun withdraw<T0, T1>(arg0: Receipt, arg1: &mut Pool<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = exchange_rate<T0>(arg1);
        let v1 = (arg2 as u256) * v0 / (1000000000 as u256);
        arg1.xTokenSupply = arg1.xTokenSupply - (v1 as u64);
        arg0.xTokenBalance = arg0.xTokenBalance - (v1 as u64);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.bal, arg2), arg3), 0x2::tx_context::sender(arg3));
        let v2 = CheckPlease{
            val1 : arg1.tokensInvested,
            val2 : arg2,
            val3 : (v0 as u64),
        };
        0x2::event::emit<CheckPlease>(v2);
        let v3 = if (arg2 > arg1.tokensInvested) {
            0
        } else {
            arg1.tokensInvested - arg2
        };
        arg1.tokensInvested = v3;
        0x2::transfer::public_transfer<Receipt>(arg0, 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

