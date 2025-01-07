module 0x142eb3ed009d68f083576135608eaf2eefe178311565697cf6e0e168cc372706::slot {
    struct Slot has store, key {
        id: 0x2::object::UID,
        owner: address,
        balances: 0x2::bag::Bag,
    }

    struct SlotCreated has copy, drop, store {
        slot: address,
        owner: address,
    }

    struct Deposit has copy, drop, store {
        slot: address,
        token: 0x1::ascii::String,
        amount: u64,
    }

    struct Withdraw has copy, drop, store {
        slot: address,
        token: 0x1::ascii::String,
        amount: u64,
    }

    public fun balance<T0>(arg0: &Slot) : u64 {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v1 = 0;
        if (0x2::bag::contains<0x1::ascii::String>(&arg0.balances, v0)) {
            v1 = 0x2::balance::value<T0>(0x2::bag::borrow<0x1::ascii::String, 0x2::balance::Balance<T0>>(&arg0.balances, v0));
        };
        v1
    }

    public(friend) fun add_to_balance<T0>(arg0: &mut Slot, arg1: 0x2::balance::Balance<T0>) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        if (0x2::bag::contains<0x1::ascii::String>(&arg0.balances, v0)) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0), arg1);
        } else {
            0x2::bag::add<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0, arg1);
        };
    }

    public entry fun create(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Slot{
            id       : 0x2::object::new(arg0),
            owner    : 0x2::tx_context::sender(arg0),
            balances : 0x2::bag::new(arg0),
        };
        let v1 = SlotCreated{
            slot  : 0x2::object::id_address<Slot>(&v0),
            owner : 0x2::tx_context::sender(arg0),
        };
        0x2::event::emit<SlotCreated>(v1);
        0x2::transfer::public_share_object<Slot>(v0);
    }

    public entry fun deposit_base(arg0: &mut Slot, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        let v0 = Deposit{
            slot   : 0x2::object::id_address<Slot>(arg0),
            token  : 0x1::type_name::into_string(0x1::type_name::get<0x2::sui::SUI>()),
            amount : 0x2::coin::value<0x2::sui::SUI>(&arg1),
        };
        0x2::event::emit<Deposit>(v0);
        add_to_balance<0x2::sui::SUI>(arg0, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
    }

    public entry fun deposit_v2<T0>(arg0: &mut Slot, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg3: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::Dex_Info, arg4: &mut 0x92fecee99603c0628ced2fbd37f85c05f6c0049c183eb6b1b58db24764c6c7bc::move_pump::Configuration, arg5: u8, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x142eb3ed009d68f083576135608eaf2eefe178311565697cf6e0e168cc372706::utils::not_base<T0>();
        let (v0, v1) = 0x142eb3ed009d68f083576135608eaf2eefe178311565697cf6e0e168cc372706::swap_router::swap_base_v2<T0>(arg1, 0x2::coin::zero<0x2::sui::SUI>(arg7), 0, arg2, arg3, arg4, arg5, arg6, arg7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x2::tx_context::sender(arg7));
        deposit_base(arg0, v0);
    }

    public entry fun deposit_v3_cetus<T0>(arg0: &mut Slot, arg1: 0x2::coin::Coin<T0>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x142eb3ed009d68f083576135608eaf2eefe178311565697cf6e0e168cc372706::utils::not_base<T0>();
        let (v0, v1) = 0x142eb3ed009d68f083576135608eaf2eefe178311565697cf6e0e168cc372706::swap_router::swap_v3_cetus<T0, 0x2::sui::SUI>(arg1, 0x2::coin::zero<0x2::sui::SUI>(arg5), arg2, arg3, arg4, arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg5));
        deposit_base(arg0, v1);
    }

    public entry fun deposit_v3_turbos<T0, T1>(arg0: &mut Slot, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, 0x2::sui::SUI, T1>, arg2: 0x2::coin::Coin<T0>, arg3: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x142eb3ed009d68f083576135608eaf2eefe178311565697cf6e0e168cc372706::utils::not_base<T0>();
        let (v0, v1) = 0x142eb3ed009d68f083576135608eaf2eefe178311565697cf6e0e168cc372706::swap_router::swap_v3_turbos<T0, 0x2::sui::SUI, T1>(arg2, 0x2::coin::zero<0x2::sui::SUI>(arg5), arg1, arg3, arg4, arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg5));
        deposit_base(arg0, v1);
    }

    public fun get_owner(arg0: &Slot) : address {
        arg0.owner
    }

    public(friend) fun take_from_balance<T0>(arg0: &mut Slot, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        assert!(0x2::bag::contains<0x1::ascii::String>(&arg0.balances, v0), 1);
        let v1 = 0x2::bag::borrow_mut<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0);
        assert!(0x2::balance::value<T0>(v1) >= arg1, 2);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v1, arg1), arg2)
    }

    public(friend) fun take_from_balance_with_permission<T0>(arg0: &mut Slot, arg1: u64, arg2: &0x142eb3ed009d68f083576135608eaf2eefe178311565697cf6e0e168cc372706::platform_permission::Platform, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        if (!0x142eb3ed009d68f083576135608eaf2eefe178311565697cf6e0e168cc372706::platform_permission::has_permission(arg2, get_owner(arg0), arg3, arg4)) {
            assert!(arg0.owner == 0x2::tx_context::sender(arg4), 0);
        };
        take_from_balance<T0>(arg0, arg1, arg4)
    }

    public(friend) fun take_from_balance_with_sender<T0>(arg0: &mut Slot, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 0);
        take_from_balance<T0>(arg0, arg1, arg2)
    }

    fun withdraw_after_swap<T0>(arg0: &Slot, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::tx_context::TxContext) {
        let v0 = Withdraw{
            slot   : 0x2::object::id_address<Slot>(arg0),
            token  : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            amount : 0x2::coin::value<0x2::sui::SUI>(&arg1),
        };
        0x2::event::emit<Withdraw>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, 0x2::tx_context::sender(arg2));
    }

    public entry fun withdraw_base(arg0: &mut Slot, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = take_from_balance_with_sender<0x2::sui::SUI>(arg0, arg1, arg2);
        withdraw_after_swap<0x2::sui::SUI>(arg0, v0, arg2);
    }

    public entry fun withdraw_v2<T0>(arg0: &mut Slot, arg1: u64, arg2: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg3: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::Dex_Info, arg4: &mut 0x92fecee99603c0628ced2fbd37f85c05f6c0049c183eb6b1b58db24764c6c7bc::move_pump::Configuration, arg5: u8, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x142eb3ed009d68f083576135608eaf2eefe178311565697cf6e0e168cc372706::utils::not_base<T0>();
        let v0 = take_from_balance_with_sender<T0>(arg0, arg1, arg7);
        let (v1, v2) = 0x142eb3ed009d68f083576135608eaf2eefe178311565697cf6e0e168cc372706::swap_router::swap_base_v2<T0>(v0, 0x2::coin::zero<0x2::sui::SUI>(arg7), 0, arg2, arg3, arg4, arg5, arg6, arg7);
        add_to_balance<T0>(arg0, 0x2::coin::into_balance<T0>(v2));
        withdraw_after_swap<0x2::sui::SUI>(arg0, v1, arg7);
    }

    public entry fun withdraw_v3_cetus<T0>(arg0: &mut Slot, arg1: u64, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x142eb3ed009d68f083576135608eaf2eefe178311565697cf6e0e168cc372706::utils::not_base<T0>();
        let v0 = take_from_balance_with_sender<T0>(arg0, arg1, arg5);
        let (v1, v2) = 0x142eb3ed009d68f083576135608eaf2eefe178311565697cf6e0e168cc372706::swap_router::swap_v3_cetus<T0, 0x2::sui::SUI>(v0, 0x2::coin::zero<0x2::sui::SUI>(arg5), arg2, arg3, arg4, arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x2::tx_context::sender(arg5));
        withdraw_after_swap<0x2::sui::SUI>(arg0, v2, arg5);
    }

    public entry fun withdraw_v3_turbos<T0, T1>(arg0: &mut Slot, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, 0x2::sui::SUI, T1>, arg2: u64, arg3: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x142eb3ed009d68f083576135608eaf2eefe178311565697cf6e0e168cc372706::utils::not_base<T0>();
        let v0 = take_from_balance_with_sender<T0>(arg0, arg2, arg5);
        let (v1, v2) = 0x142eb3ed009d68f083576135608eaf2eefe178311565697cf6e0e168cc372706::swap_router::swap_v3_turbos<T0, 0x2::sui::SUI, T1>(v0, 0x2::coin::zero<0x2::sui::SUI>(arg5), arg1, arg3, arg4, arg5);
        add_to_balance<T0>(arg0, 0x2::coin::into_balance<T0>(v1));
        withdraw_after_swap<0x2::sui::SUI>(arg0, v2, arg5);
    }

    // decompiled from Move bytecode v6
}

