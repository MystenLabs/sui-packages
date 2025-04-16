module 0xe9576f2231294bc03b9284f1d31e7ff9fa581bffdd762b572c6d90e41901cf71::multi_token_sale {
    struct TokenReceipt has store, key {
        id: 0x2::object::UID,
        token_type: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct TokenTreasury has key {
        id: 0x2::object::UID,
    }

    struct TokenSale has key {
        id: 0x2::object::UID,
        token_type: 0x1::type_name::TypeName,
        tokens_left: u64,
        tokens_per_mist: u64,
        is_active: bool,
        proceeds: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct SaleCreatedEvent has copy, drop {
        sale_id: 0x2::object::ID,
        token_type: 0x1::type_name::TypeName,
        tokens_left: u64,
        tokens_per_mist: u64,
    }

    struct RateUpdatedEvent has copy, drop {
        sale_id: 0x2::object::ID,
        token_type: 0x1::type_name::TypeName,
        new_tokens_per_mist: u64,
    }

    struct TokensPurchasedEvent has copy, drop {
        sale_id: 0x2::object::ID,
        buyer: address,
        token_type: 0x1::type_name::TypeName,
        amount: u64,
        cost: u64,
        ref: 0x1::ascii::String,
    }

    struct UtilEvent has copy, drop {
        evtype: 0x1::ascii::String,
        data: 0x1::ascii::String,
        step: u8,
    }

    public entry fun add_tokens(arg0: &AdminCap, arg1: &mut TokenSale, arg2: u64) {
        arg1.tokens_left = arg1.tokens_left + arg2;
    }

    public entry fun buy_tokens<T0>(arg0: &mut TokenTreasury, arg1: &mut TokenSale, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: address, arg4: 0x1::ascii::String, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = coin_type_name<T0>();
        assert!(v0 == arg1.token_type, 7);
        assert!(0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&arg0.id, v0), 6);
        assert!(arg1.is_active, 1);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert!(v1 > 0, 5);
        let v2 = v1 * arg1.tokens_per_mist;
        assert!(v2 > 0, 4);
        assert!(arg1.tokens_left >= v2, 2);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.proceeds, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
        arg1.tokens_left = arg1.tokens_left - v2;
        let v3 = TokensPurchasedEvent{
            sale_id    : 0x2::object::uid_to_inner(&arg1.id),
            buyer      : 0x2::tx_context::sender(arg5),
            token_type : arg1.token_type,
            amount     : v2,
            cost       : v1,
            ref        : arg4,
        };
        0x2::event::emit<TokensPurchasedEvent>(v3);
        if (!0x1::ascii::is_empty(&arg4)) {
            let v4 = UtilEvent{
                evtype : 0x1::ascii::string(b"ref"),
                data   : arg4,
                step   : 1,
            };
            0x2::event::emit<UtilEvent>(v4);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.id, v0), v2, arg5), arg3);
    }

    fun coin_type_name<T0>() : 0x1::type_name::TypeName {
        0x1::type_name::get<T0>()
    }

    public entry fun create_sale<T0>(arg0: &AdminCap, arg1: &TokenTreasury, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 > 0, 3);
        assert!(arg2 > 0, 5);
        let v0 = coin_type_name<T0>();
        assert!(0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&arg1.id, v0), 6);
        let v1 = TokenSale{
            id              : 0x2::object::new(arg4),
            token_type      : v0,
            tokens_left     : arg2,
            tokens_per_mist : arg3,
            is_active       : true,
            proceeds        : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        let v2 = SaleCreatedEvent{
            sale_id         : 0x2::object::uid_to_inner(&v1.id),
            token_type      : v0,
            tokens_left     : arg2,
            tokens_per_mist : arg3,
        };
        0x2::event::emit<SaleCreatedEvent>(v2);
        0x2::transfer::share_object<TokenSale>(v1);
    }

    public fun deposit<T0>(arg0: &AdminCap, arg1: &mut TokenTreasury, arg2: 0x2::coin::Coin<T0>) {
        assert!(0x2::coin::value<T0>(&arg2) > 0, 5);
        let v0 = coin_type_name<T0>();
        if (0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&arg1.id, v0)) {
            0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg1.id, v0), 0x2::coin::into_balance<T0>(arg2));
        } else {
            0x2::dynamic_field::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg1.id, v0, 0x2::coin::into_balance<T0>(arg2));
        };
    }

    public fun has_token_type<T0>(arg0: &TokenTreasury) : bool {
        0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&arg0.id, coin_type_name<T0>())
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = TokenTreasury{id: 0x2::object::new(arg0)};
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<TokenTreasury>(v0);
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun is_active(arg0: &TokenSale) : bool {
        arg0.is_active
    }

    public entry fun set_active(arg0: &AdminCap, arg1: &mut TokenSale, arg2: bool) {
        arg1.is_active = arg2;
    }

    public entry fun set_rate(arg0: &AdminCap, arg1: &mut TokenSale, arg2: u64) {
        assert!(arg2 > 0, 3);
        arg1.tokens_per_mist = arg2;
        let v0 = RateUpdatedEvent{
            sale_id             : 0x2::object::uid_to_inner(&arg1.id),
            token_type          : arg1.token_type,
            new_tokens_per_mist : arg2,
        };
        0x2::event::emit<RateUpdatedEvent>(v0);
    }

    public fun token_type(arg0: &TokenSale) : 0x1::type_name::TypeName {
        arg0.token_type
    }

    public fun tokens_left(arg0: &TokenSale) : u64 {
        arg0.tokens_left
    }

    public fun tokens_per_mist(arg0: &TokenSale) : u64 {
        arg0.tokens_per_mist
    }

    public entry fun withdraw_proceeds(arg0: &AdminCap, arg1: &mut TokenSale, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg1.proceeds, arg2, arg4), arg3);
    }

    public entry fun withdraw_tokens<T0>(arg0: &AdminCap, arg1: &mut TokenTreasury, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = coin_type_name<T0>();
        assert!(0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&arg1.id, v0), 6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg1.id, v0), arg2, arg4), arg3);
    }

    // decompiled from Move bytecode v6
}

