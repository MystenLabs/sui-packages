module 0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::treasury {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct DepoisitToken<phantom T0> has store, key {
        id: 0x2::object::UID,
        is_lp: bool,
        deposit_balance: 0x2::balance::Balance<T0>,
        decimals: u8,
    }

    struct Treasury has store, key {
        id: 0x2::object::UID,
        managers: 0x2::vec_set::VecSet<address>,
        total_reserves: u64,
    }

    struct InitEvent has copy, drop {
        sender: address,
        treasury_id: 0x2::object::ID,
    }

    struct SetDepositTokenEvent has copy, drop {
        sender: address,
        id: 0x2::object::ID,
    }

    struct RewardsMintedEvent has copy, drop {
        amount: u64,
    }

    struct DepositEvent has copy, drop {
        sender: address,
        deposit_token_id: 0x2::object::ID,
        amount: u64,
        value: u64,
    }

    struct WithdrawEvent has copy, drop {
        sender: address,
        deposit_token_id: 0x2::object::ID,
        amount: u64,
        value: u64,
    }

    struct ReservesUpdatedEvent has copy, drop {
        total_reserves: u64,
    }

    struct ReservesManagedEvent has copy, drop {
        sender: address,
        deposit_token_id: 0x2::object::ID,
        amount: u64,
        value: u64,
    }

    public fun decimals<T0>(arg0: &DepoisitToken<T0>) : u8 {
        arg0.decimals
    }

    public(friend) fun deposit<T0>(arg0: &mut Treasury, arg1: &mut DepoisitToken<T0>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: &mut 0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::vim::TreasuryLock<0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::vim::VIM>, arg6: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::vim::VIM> {
        assert!(0x2::coin::value<T0>(&arg2) >= arg3, 5);
        let v0 = 0x2::coin::into_balance<T0>(arg2);
        0x2::balance::join<T0>(&mut arg1.deposit_balance, 0x2::balance::split<T0>(&mut v0, arg3));
        return_back_or_delete<T0>(v0, arg6);
        let v1 = value_of<T0>(arg1, arg3);
        arg0.total_reserves = arg0.total_reserves + v1;
        let v2 = ReservesUpdatedEvent{total_reserves: arg0.total_reserves};
        0x2::event::emit<ReservesUpdatedEvent>(v2);
        let v3 = DepositEvent{
            sender           : 0x2::tx_context::sender(arg6),
            deposit_token_id : 0x2::object::id<DepoisitToken<T0>>(arg1),
            amount           : arg3,
            value            : v1,
        };
        0x2::event::emit<DepositEvent>(v3);
        0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::vim::mint_balance<0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::vim::VIM>(arg5, 0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::math::sub(v1, arg4))
    }

    public fun deposit_balance<T0>(arg0: &DepoisitToken<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.deposit_balance)
    }

    public fun excess_reserves(arg0: &Treasury, arg1: &0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::vim::TreasuryLock<0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::vim::VIM>) : u64 {
        0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::math::sub(arg0.total_reserves, 0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::vim::total_supply<0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::vim::VIM>(arg1))
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = Treasury{
            id             : 0x2::object::new(arg0),
            managers       : 0x2::vec_set::empty<address>(),
            total_reserves : 0,
        };
        0x2::vec_set::insert<address>(&mut v1.managers, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<Treasury>(v1);
        let v2 = InitEvent{
            sender      : 0x2::tx_context::sender(arg0),
            treasury_id : 0x2::object::id<Treasury>(&v1),
        };
        0x2::event::emit<InitEvent>(v2);
    }

    public entry fun manage<T0>(arg0: &mut Treasury, arg1: &mut DepoisitToken<T0>, arg2: u64, arg3: &mut 0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::vim::TreasuryLock<0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::vim::VIM>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0x2::vec_set::contains<address>(&arg0.managers, &v0), 4);
        assert!(0x2::balance::value<T0>(&arg1.deposit_balance) >= arg2, 5);
        let v1 = value_of<T0>(arg1, arg2);
        assert!(v1 <= excess_reserves(arg0, arg3), 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.deposit_balance, arg2), arg4), v0);
        arg0.total_reserves = 0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::math::sub(arg0.total_reserves, v1);
        let v2 = ReservesUpdatedEvent{total_reserves: arg0.total_reserves};
        0x2::event::emit<ReservesUpdatedEvent>(v2);
        let v3 = ReservesManagedEvent{
            sender           : v0,
            deposit_token_id : 0x2::object::id<DepoisitToken<T0>>(arg1),
            amount           : arg2,
            value            : v1,
        };
        0x2::event::emit<ReservesManagedEvent>(v3);
    }

    public(friend) fun mint_rewards(arg0: &mut Treasury, arg1: u64, arg2: &mut 0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::vim::TreasuryLock<0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::vim::VIM>) : 0x2::balance::Balance<0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::vim::VIM> {
        assert!(arg1 > 0, 3);
        assert!(arg1 <= excess_reserves(arg0, arg2), 2);
        let v0 = RewardsMintedEvent{amount: arg1};
        0x2::event::emit<RewardsMintedEvent>(v0);
        0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::vim::mint_balance<0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::vim::VIM>(arg2, arg1)
    }

    fun return_back_or_delete<T0>(arg0: 0x2::balance::Balance<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg1), 0x2::tx_context::sender(arg1));
        } else {
            0x2::balance::destroy_zero<T0>(arg0);
        };
    }

    public entry fun set_deposit_token<T0>(arg0: &AdminCap, arg1: bool, arg2: &0x2::coin::CoinMetadata<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = DepoisitToken<T0>{
            id              : 0x2::object::new(arg3),
            is_lp           : arg1,
            deposit_balance : 0x2::balance::zero<T0>(),
            decimals        : 0x2::coin::get_decimals<T0>(arg2),
        };
        0x2::transfer::share_object<DepoisitToken<T0>>(v0);
        let v1 = SetDepositTokenEvent{
            sender : 0x2::tx_context::sender(arg3),
            id     : 0x2::object::id<DepoisitToken<T0>>(&v0),
        };
        0x2::event::emit<SetDepositTokenEvent>(v1);
    }

    public entry fun set_mamager(arg0: &AdminCap, arg1: &mut Treasury, arg2: address, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) {
        if (arg3) {
            assert!(!0x2::vec_set::contains<address>(&arg1.managers, &arg2), 1);
            0x2::vec_set::insert<address>(&mut arg1.managers, arg2);
        } else {
            assert!(0x2::vec_set::contains<address>(&arg1.managers, &arg2), 0);
            0x2::vec_set::remove<address>(&mut arg1.managers, &arg2);
        };
    }

    public entry fun set_total_reserves(arg0: &AdminCap, arg1: &mut Treasury, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.total_reserves = arg2;
    }

    public fun total_reserves(arg0: &Treasury) : u64 {
        arg0.total_reserves
    }

    public fun value_of<T0>(arg0: &DepoisitToken<T0>, arg1: u64) : u64 {
        0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::math::safe_mul_div_u64(arg1, 0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::math::pow(10, 6), 0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::math::pow(10, arg0.decimals))
    }

    public entry fun withdraw<T0>(arg0: &mut Treasury, arg1: &mut DepoisitToken<T0>, arg2: u64, arg3: 0x2::coin::Coin<0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::vim::VIM>, arg4: &mut 0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::vim::TreasuryLock<0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::vim::VIM>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(0x2::vec_set::contains<address>(&arg0.managers, &v0), 4);
        assert!(0x2::balance::value<T0>(&arg1.deposit_balance) >= arg2, 5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.deposit_balance, arg2), arg5), v0);
        let v1 = value_of<T0>(arg1, arg2);
        0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::vim::burn<0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::vim::VIM>(arg4, arg3, v1, arg5);
        arg0.total_reserves = 0xa9f3177485987dc5686c42a11c82b5cc29be96422c5565de8e7bd6413a29565b::math::sub(arg0.total_reserves, v1);
        let v2 = ReservesUpdatedEvent{total_reserves: arg0.total_reserves};
        0x2::event::emit<ReservesUpdatedEvent>(v2);
        let v3 = WithdrawEvent{
            sender           : v0,
            deposit_token_id : 0x2::object::id<DepoisitToken<T0>>(arg1),
            amount           : arg2,
            value            : v1,
        };
        0x2::event::emit<WithdrawEvent>(v3);
    }

    // decompiled from Move bytecode v6
}

