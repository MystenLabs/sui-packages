module 0x4fa4bfc7a17d5f2f0b86501ca4e2bb94d9abd29c62494c6c85f06c7e63fe50b0::reflection {
    struct ReflectionDistributed has copy, drop {
        amount: u64,
        holders_count: u64,
    }

    struct TokenMinted has copy, drop {
        amount: u64,
        recipient: address,
    }

    struct ReflectionToken has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        symbol: 0x1::string::String,
        decimals: u8,
        icon_url: 0x2::url::Url,
        total_supply: u64,
        fee_percentage: u64,
        reflection_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        holder_balances: 0x2::vec_map::VecMap<address, u64>,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    public entry fun transfer(arg0: &mut ReflectionToken, arg1: u64, arg2: address, arg3: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = arg1 * arg0.fee_percentage / 100;
        let v2 = extract_sui_fee(arg3, v1, arg4);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.reflection_balance, v2);
        decrease_balance(arg0, v0, arg1);
        increase_balance(arg0, arg2, arg1 - v1);
        distribute_reflections(arg0, arg4);
    }

    fun decrease_balance(arg0: &mut ReflectionToken, arg1: address, arg2: u64) {
        if (!0x2::vec_map::contains<address, u64>(&arg0.holder_balances, &arg1)) {
            0x2::vec_map::insert<address, u64>(&mut arg0.holder_balances, arg1, 0);
        };
        let v0 = 0x2::vec_map::get_mut<address, u64>(&mut arg0.holder_balances, &arg1);
        assert!(*v0 >= arg2, 1);
        *v0 = *v0 - arg2;
    }

    fun distribute_reflections(arg0: &mut ReflectionToken, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.reflection_balance);
        if (v0 == 0) {
            return
        };
        let v1 = 0x2::vec_map::size<address, u64>(&arg0.holder_balances);
        let v2 = 0;
        while (v2 < v1) {
            let (v3, v4) = 0x2::vec_map::get_entry_by_idx<address, u64>(&arg0.holder_balances, v2);
            let v5 = *v4 * v0 / (v1 as u64) / arg0.total_supply;
            if (v5 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.reflection_balance, v5, arg1), *v3);
            };
            v2 = v2 + 1;
        };
        let v6 = ReflectionDistributed{
            amount        : v0,
            holders_count : v1,
        };
        0x2::event::emit<ReflectionDistributed>(v6);
    }

    fun extract_sui_fee(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(arg0, arg1, arg2))
    }

    public fun get_balance(arg0: &ReflectionToken, arg1: address) : u64 {
        if (!0x2::vec_map::contains<address, u64>(&arg0.holder_balances, &arg1)) {
            return 0
        };
        *0x2::vec_map::get<address, u64>(&arg0.holder_balances, &arg1)
    }

    public fun get_fee_percentage(arg0: &ReflectionToken) : u64 {
        arg0.fee_percentage
    }

    public fun get_total_supply(arg0: &ReflectionToken) : u64 {
        arg0.total_supply
    }

    public entry fun handle_trade(arg0: &mut ReflectionToken, arg1: u64, arg2: address, arg3: address, arg4: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = arg1 * arg0.fee_percentage / 100;
        let v1 = extract_sui_fee(arg4, v0, arg5);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.reflection_balance, v1);
        decrease_balance(arg0, arg2, arg1);
        increase_balance(arg0, arg3, arg1 - v0);
        distribute_reflections(arg0, arg5);
    }

    fun increase_balance(arg0: &mut ReflectionToken, arg1: address, arg2: u64) {
        if (!0x2::vec_map::contains<address, u64>(&arg0.holder_balances, &arg1)) {
            0x2::vec_map::insert<address, u64>(&mut arg0.holder_balances, arg1, 0);
        };
        let v0 = 0x2::vec_map::get_mut<address, u64>(&mut arg0.holder_balances, &arg1);
        *v0 = *v0 + arg2;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = ReflectionToken{
            id                 : 0x2::object::new(arg0),
            name               : 0x1::string::utf8(b"Reflection SUI Token"),
            symbol             : 0x1::string::utf8(b"RFLX"),
            decimals           : 9,
            icon_url           : 0x2::url::new_unsafe_from_bytes(b"https://example.com/icon.png"),
            total_supply       : 1000000000,
            fee_percentage     : 5,
            reflection_balance : 0x2::balance::zero<0x2::sui::SUI>(),
            holder_balances    : 0x2::vec_map::empty<address, u64>(),
        };
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<ReflectionToken>(v1);
    }

    public entry fun mint(arg0: &mut ReflectionToken, arg1: u64, arg2: address, arg3: &AdminCap, arg4: &mut 0x2::tx_context::TxContext) {
        if (!0x2::vec_map::contains<address, u64>(&arg0.holder_balances, &arg2)) {
            0x2::vec_map::insert<address, u64>(&mut arg0.holder_balances, arg2, 0);
        };
        let v0 = 0x2::vec_map::get_mut<address, u64>(&mut arg0.holder_balances, &arg2);
        *v0 = *v0 + arg1;
        let v1 = TokenMinted{
            amount    : arg1,
            recipient : arg2,
        };
        0x2::event::emit<TokenMinted>(v1);
    }

    // decompiled from Move bytecode v6
}

