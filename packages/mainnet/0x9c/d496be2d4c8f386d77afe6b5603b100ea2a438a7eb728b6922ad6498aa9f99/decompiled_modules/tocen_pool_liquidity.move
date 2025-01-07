module 0x9cd496be2d4c8f386d77afe6b5603b100ea2a438a7eb728b6922ad6498aa9f99::tocen_pool_liquidity {
    struct PoolAllocation has copy, drop, store {
        turn: u64,
        total_supply: u64,
        total_released: u64,
    }

    struct TocenPoolLiquidity has store, key {
        id: 0x2::object::UID,
        balance_liquidity: 0x2::balance::Balance<0xd2013e206f7983f06132d5b61f7c577638ff63171221f4f600a98863febdfb47::toce::TOCE>,
        total_supply_liquidity: u64,
        total_released: u64,
        total_turns_allocation_created: u64,
    }

    struct EventAddPool has copy, drop, store {
        owner_add_pool: address,
        balance_add_pool: u64,
    }

    public entry fun add_liquidity(arg0: &mut TocenPoolLiquidity, arg1: 0x2::coin::Coin<0xd2013e206f7983f06132d5b61f7c577638ff63171221f4f600a98863febdfb47::toce::TOCE>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = &mut arg0.balance_liquidity;
        transferToce(v0, arg1, arg2, arg3);
        let v1 = EventAddPool{
            owner_add_pool   : 0x2::tx_context::sender(arg3),
            balance_add_pool : arg2,
        };
        0x2::event::emit<EventAddPool>(v1);
    }

    public entry fun create_pool_allocation(arg0: &mut TocenPoolLiquidity, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x9cd496be2d4c8f386d77afe6b5603b100ea2a438a7eb728b6922ad6498aa9f99::witness::check_owner(arg3), 1);
        assert!(arg2 + arg0.total_turns_allocation_created <= arg0.total_supply_liquidity, 3);
        let v0 = PoolAllocation{
            turn           : arg1,
            total_supply   : arg2,
            total_released : 0,
        };
        arg0.total_turns_allocation_created = arg0.total_turns_allocation_created + arg2;
        0x2::dynamic_field::add<u64, PoolAllocation>(&mut arg0.id, arg1, v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        init_ido(arg0);
    }

    public fun init_ido(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = TocenPoolLiquidity{
            id                             : 0x2::object::new(arg0),
            balance_liquidity              : 0x2::balance::zero<0xd2013e206f7983f06132d5b61f7c577638ff63171221f4f600a98863febdfb47::toce::TOCE>(),
            total_supply_liquidity         : 0x9cd496be2d4c8f386d77afe6b5603b100ea2a438a7eb728b6922ad6498aa9f99::utils::get_total_supply_liquidity(),
            total_released                 : 0,
            total_turns_allocation_created : 0,
        };
        0x2::transfer::share_object<TocenPoolLiquidity>(v0);
    }

    fun transferToce(arg0: &mut 0x2::balance::Balance<0xd2013e206f7983f06132d5b61f7c577638ff63171221f4f600a98863febdfb47::toce::TOCE>, arg1: 0x2::coin::Coin<0xd2013e206f7983f06132d5b61f7c577638ff63171221f4f600a98863febdfb47::toce::TOCE>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0xd2013e206f7983f06132d5b61f7c577638ff63171221f4f600a98863febdfb47::toce::TOCE>(&arg1) >= arg2, 2);
        0x2::balance::join<0xd2013e206f7983f06132d5b61f7c577638ff63171221f4f600a98863febdfb47::toce::TOCE>(arg0, 0x2::balance::split<0xd2013e206f7983f06132d5b61f7c577638ff63171221f4f600a98863febdfb47::toce::TOCE>(0x2::coin::balance_mut<0xd2013e206f7983f06132d5b61f7c577638ff63171221f4f600a98863febdfb47::toce::TOCE>(&mut arg1), arg2));
        0x2::transfer::public_transfer<0x2::coin::Coin<0xd2013e206f7983f06132d5b61f7c577638ff63171221f4f600a98863febdfb47::toce::TOCE>>(arg1, 0x2::tx_context::sender(arg3));
    }

    public entry fun up_pool_allocation(arg0: &mut TocenPoolLiquidity, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x9cd496be2d4c8f386d77afe6b5603b100ea2a438a7eb728b6922ad6498aa9f99::witness::check_owner(arg3), 1);
        let v0 = &mut 0x2::dynamic_field::borrow_mut<u64, PoolAllocation>(&mut arg0.id, arg1).total_supply;
        if (arg2 > *v0) {
            assert!(arg0.total_turns_allocation_created + arg2 - *v0 <= arg0.total_supply_liquidity, 3);
            arg0.total_turns_allocation_created = arg0.total_turns_allocation_created + arg2 - *v0;
            *v0 = arg2;
        } else {
            arg0.total_turns_allocation_created = arg0.total_turns_allocation_created - *v0 - arg2;
            *v0 = arg2;
        };
    }

    public entry fun val_pool_allocation(arg0: &mut TocenPoolLiquidity, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x9cd496be2d4c8f386d77afe6b5603b100ea2a438a7eb728b6922ad6498aa9f99::witness::check_owner(arg3), 1);
        let v0 = 0x2::dynamic_field::borrow_mut<u64, PoolAllocation>(&mut arg0.id, arg1);
        let v1 = &mut v0.total_released;
        assert!(*v1 + arg2 <= v0.total_supply, 4);
        assert!(arg0.total_released + arg2 <= arg0.total_supply_liquidity, 4);
        *v1 = *v1 + arg2;
        arg0.total_released = arg0.total_released + arg2;
        0x2::transfer::public_transfer<0x2::coin::Coin<0xd2013e206f7983f06132d5b61f7c577638ff63171221f4f600a98863febdfb47::toce::TOCE>>(0x2::coin::from_balance<0xd2013e206f7983f06132d5b61f7c577638ff63171221f4f600a98863febdfb47::toce::TOCE>(0x2::balance::split<0xd2013e206f7983f06132d5b61f7c577638ff63171221f4f600a98863febdfb47::toce::TOCE>(&mut arg0.balance_liquidity, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun witness(arg0: &mut TocenPoolLiquidity, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x9cd496be2d4c8f386d77afe6b5603b100ea2a438a7eb728b6922ad6498aa9f99::witness::check_owner(arg2), 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xd2013e206f7983f06132d5b61f7c577638ff63171221f4f600a98863febdfb47::toce::TOCE>>(0x2::coin::from_balance<0xd2013e206f7983f06132d5b61f7c577638ff63171221f4f600a98863febdfb47::toce::TOCE>(0x2::balance::split<0xd2013e206f7983f06132d5b61f7c577638ff63171221f4f600a98863febdfb47::toce::TOCE>(&mut arg0.balance_liquidity, arg1), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

