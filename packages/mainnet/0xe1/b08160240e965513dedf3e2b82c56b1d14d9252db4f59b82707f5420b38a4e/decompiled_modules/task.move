module 0xe1b08160240e965513dedf3e2b82c56b1d14d9252db4f59b82707f5420b38a4e::task {
    struct Treasury has key {
        id: 0x2::object::UID,
        admin: address,
        fund_recipient: address,
        balances: 0x2::bag::Bag,
        supported_tokens: vector<0x1::type_name::TypeName>,
    }

    struct CheckInEvent has copy, drop {
        user_id: u64,
        sender: address,
    }

    struct RechargeEvent has copy, drop {
        order_id: u64,
        amount: u64,
        coin_type: 0x1::type_name::TypeName,
        sender: address,
        treasury_address: address,
    }

    struct WithdrawEvent has copy, drop {
        amount: u64,
        coin_type: 0x1::type_name::TypeName,
        receiver: address,
        treasury_address: address,
    }

    struct TreasuryCreatedEvent has copy, drop {
        treasury_id: 0x2::object::ID,
        treasury_address: address,
        admin: address,
        fund_recipient: address,
    }

    struct TokenAddedEvent has copy, drop {
        token_type: 0x1::type_name::TypeName,
        admin: address,
    }

    struct TokenRemovedEvent has copy, drop {
        token_type: 0x1::type_name::TypeName,
        admin: address,
    }

    public fun add_supported_token<T0>(arg0: &mut Treasury, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(v0 == arg0.admin, 4);
        let v1 = 0x1::type_name::get<T0>();
        if (!is_token_supported(arg0, v1)) {
            0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg0.supported_tokens, v1);
            let v2 = TokenAddedEvent{
                token_type : v1,
                admin      : v0,
            };
            0x2::event::emit<TokenAddedEvent>(v2);
        };
    }

    public fun check_in(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0 != 0, 2);
        let v0 = CheckInEvent{
            user_id : arg0,
            sender  : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<CheckInEvent>(v0);
    }

    public fun contains_coin_type<T0>(arg0: &Treasury) : bool {
        0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, 0x1::type_name::get<T0>())
    }

    public fun get_admin(arg0: &Treasury) : address {
        arg0.admin
    }

    public fun get_balance<T0>(arg0: &Treasury) : u64 {
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, v0)) {
            0x2::balance::value<T0>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.balances, v0))
        } else {
            0
        }
    }

    public fun get_fund_recipient(arg0: &Treasury) : address {
        arg0.fund_recipient
    }

    public fun get_supported_tokens(arg0: &Treasury) : vector<0x1::type_name::TypeName> {
        arg0.supported_tokens
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Treasury{
            id               : 0x2::object::new(arg0),
            admin            : @0x724f4f8920bc2b06619c865ffc03af2dc004c434c37de46948e3bedc22b5919a,
            fund_recipient   : @0xf450a878a25377ac405846c370a8483da2c3272bb8c533fb454d9568f8946138,
            balances         : 0x2::bag::new(arg0),
            supported_tokens : 0x1::vector::empty<0x1::type_name::TypeName>(),
        };
        let v1 = 0x2::object::id<Treasury>(&v0);
        0x2::transfer::share_object<Treasury>(v0);
        let v2 = TreasuryCreatedEvent{
            treasury_id      : v1,
            treasury_address : 0x2::object::id_to_address(&v1),
            admin            : @0x724f4f8920bc2b06619c865ffc03af2dc004c434c37de46948e3bedc22b5919a,
            fund_recipient   : @0xf450a878a25377ac405846c370a8483da2c3272bb8c533fb454d9568f8946138,
        };
        0x2::event::emit<TreasuryCreatedEvent>(v2);
    }

    fun is_token_supported(arg0: &Treasury, arg1: 0x1::type_name::TypeName) : bool {
        0x1::vector::contains<0x1::type_name::TypeName>(&arg0.supported_tokens, &arg1)
    }

    public fun is_token_type_supported<T0>(arg0: &Treasury) : bool {
        is_token_supported(arg0, 0x1::type_name::get<T0>())
    }

    public fun recharge<T0>(arg0: &mut Treasury, arg1: u64, arg2: &mut 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 > 0, 1);
        assert!(0x2::coin::value<T0>(arg2) >= arg3, 3);
        let v0 = 0x1::type_name::get<T0>();
        assert!(is_token_supported(arg0, v0), 5);
        let v1 = 0x2::object::id<Treasury>(arg0);
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, v0)) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0), 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(arg2, arg3, arg4)));
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(arg2, arg3, arg4)));
        };
        let v2 = RechargeEvent{
            order_id         : arg1,
            amount           : arg3,
            coin_type        : v0,
            sender           : 0x2::tx_context::sender(arg4),
            treasury_address : 0x2::object::id_to_address(&v1),
        };
        0x2::event::emit<RechargeEvent>(v2);
    }

    public fun remove_supported_token<T0>(arg0: &mut Treasury, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(v0 == arg0.admin, 4);
        let v1 = 0x1::type_name::get<T0>();
        let (v2, v3) = 0x1::vector::index_of<0x1::type_name::TypeName>(&arg0.supported_tokens, &v1);
        if (v2) {
            0x1::vector::remove<0x1::type_name::TypeName>(&mut arg0.supported_tokens, v3);
            let v4 = TokenRemovedEvent{
                token_type : v1,
                admin      : v0,
            };
            0x2::event::emit<TokenRemovedEvent>(v4);
        };
    }

    public fun withdraw<T0>(arg0: &mut Treasury, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 4);
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, v0), 3);
        let v1 = 0x2::balance::value<T0>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.balances, v0));
        assert!(v1 > 0, 1);
        let v2 = 0x2::object::id<Treasury>(arg0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::bag::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0), arg1), arg0.fund_recipient);
        let v3 = WithdrawEvent{
            amount           : v1,
            coin_type        : v0,
            receiver         : arg0.fund_recipient,
            treasury_address : 0x2::object::id_to_address(&v2),
        };
        0x2::event::emit<WithdrawEvent>(v3);
    }

    // decompiled from Move bytecode v6
}

