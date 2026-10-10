module 0xf91a7b97c188e7cd1093cd198d55c2f0173297c2c18af073b38f6ae7829ee64f::index {
    struct Index<phantom T0> has key {
        id: 0x2::object::UID,
        creator: address,
        creator_bps: u64,
        treasury_cap: 0x2::coin::TreasuryCap<T0>,
        components: vector<0x1::type_name::TypeName>,
        dead_shares: 0x2::balance::Balance<T0>,
        busy: bool,
    }

    struct CompKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct CreateTicket<phantom T0> {
        index: Index<T0>,
        amounts: vector<u64>,
    }

    struct MintTicket<phantom T0> {
        index_id: 0x2::object::ID,
        supply: u64,
        balances: vector<u64>,
        deposits: vector<u64>,
        settled: bool,
        shares: u64,
        required: vector<u64>,
        changed: u64,
    }

    struct RedeemTicket<phantom T0> {
        index_id: 0x2::object::ID,
        supply: u64,
        burnt: u64,
        creator_fee: u64,
        platform_fee: u64,
        amounts: vector<u64>,
    }

    struct IndexCreated has copy, drop {
        index: 0x2::object::ID,
        coin: 0x1::ascii::String,
        creator: address,
        components: vector<0x1::ascii::String>,
        amounts: vector<u64>,
        shares: u64,
    }

    struct Minted has copy, drop {
        index: 0x2::object::ID,
        sender: address,
        shares: u64,
        creator_fee: u64,
        platform_fee: u64,
        amounts: vector<u64>,
    }

    struct Redeemed has copy, drop {
        index: 0x2::object::ID,
        sender: address,
        shares: u64,
        creator_fee: u64,
        platform_fee: u64,
        amounts: vector<u64>,
    }

    struct CreatorTransferred has copy, drop {
        index: 0x2::object::ID,
        from: address,
        to: address,
    }

    public fun creator_bps<T0>(arg0: &Index<T0>) : u64 {
        arg0.creator_bps
    }

    public fun add_component<T0, T1>(arg0: &0xf91a7b97c188e7cd1093cd198d55c2f0173297c2c18af073b38f6ae7829ee64f::config::Config, arg1: &mut CreateTicket<T0>, arg2: 0x2::coin::Coin<T1>) {
        let v0 = &mut arg1.index;
        assert!(0x1::vector::length<0x1::type_name::TypeName>(&v0.components) < 10, 205);
        let v1 = 0x1::type_name::with_original_ids<T1>();
        assert!(!0x1::vector::contains<0x1::type_name::TypeName>(&v0.components, &v1), 207);
        assert!(!0xf91a7b97c188e7cd1093cd198d55c2f0173297c2c18af073b38f6ae7829ee64f::config::is_share<T1>(arg0), 208);
        assert!(!0xf91a7b97c188e7cd1093cd198d55c2f0173297c2c18af073b38f6ae7829ee64f::config::is_dead<T1>(arg0), 209);
        let v2 = 0x2::coin::value<T1>(&arg2);
        assert!(v2 > 0, 210);
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut v0.components, v1);
        let v3 = CompKey<T1>{dummy_field: false};
        0x2::dynamic_field::add<CompKey<T1>, 0x2::balance::Balance<T1>>(&mut v0.id, v3, 0x2::coin::into_balance<T1>(arg2));
        0x1::vector::push_back<u64>(&mut arg1.amounts, v2);
    }

    fun assert_component<T0, T1>(arg0: &Index<T0>, arg1: u64) {
        assert!(arg1 < 0x1::vector::length<0x1::type_name::TypeName>(&arg0.components), 213);
        assert!(*0x1::vector::borrow<0x1::type_name::TypeName>(&arg0.components, arg1) == 0x1::type_name::with_original_ids<T1>(), 213);
    }

    public fun balance_of<T0, T1>(arg0: &Index<T0>) : u64 {
        let v0 = CompKey<T1>{dummy_field: false};
        0x2::balance::value<T1>(0x2::dynamic_field::borrow<CompKey<T1>, 0x2::balance::Balance<T1>>(&arg0.id, v0))
    }

    public fun busy<T0>(arg0: &Index<T0>) : bool {
        arg0.busy
    }

    public fun change<T0, T1>(arg0: &mut Index<T0>, arg1: &mut MintTicket<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(arg1.index_id == 0x2::object::id<Index<T0>>(arg0), 212);
        assert!(arg1.settled, 215);
        let v0 = arg1.changed;
        assert_component<T0, T1>(arg0, v0);
        arg1.changed = v0 + 1;
        let v1 = CompKey<T1>{dummy_field: false};
        0x2::coin::from_balance<T1>(0x2::balance::split<T1>(0x2::dynamic_field::borrow_mut<CompKey<T1>, 0x2::balance::Balance<T1>>(&mut arg0.id, v1), *0x1::vector::borrow<u64>(&arg1.deposits, v0) - *0x1::vector::borrow<u64>(&arg1.required, v0)), arg2)
    }

    public fun components<T0>(arg0: &Index<T0>) : vector<0x1::type_name::TypeName> {
        arg0.components
    }

    public fun create<T0>(arg0: &mut 0xf91a7b97c188e7cd1093cd198d55c2f0173297c2c18af073b38f6ae7829ee64f::config::Config, arg1: 0x2::coin::TreasuryCap<T0>, arg2: &0x2::coin_registry::Currency<T0>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) : CreateTicket<T0> {
        0xf91a7b97c188e7cd1093cd198d55c2f0173297c2c18af073b38f6ae7829ee64f::config::assert_open(arg0);
        assert!(0x2::coin_registry::treasury_cap_id<T0>(arg2) == 0x1::option::some<0x2::object::ID>(0x2::object::id<0x2::coin::TreasuryCap<T0>>(&arg1)), 200);
        assert!(!0x2::coin_registry::is_regulated<T0>(arg2), 201);
        let v0 = 0x2::coin_registry::deny_cap_id<T0>(arg2);
        assert!(0x1::option::is_none<0x2::object::ID>(&v0), 201);
        assert!(0x2::coin_registry::decimals<T0>(arg2) == 6, 202);
        assert!(0x2::coin::total_supply<T0>(&arg1) == 0, 203);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) == 0xf91a7b97c188e7cd1093cd198d55c2f0173297c2c18af073b38f6ae7829ee64f::config::launch_fee(arg0), 204);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, 0xf91a7b97c188e7cd1093cd198d55c2f0173297c2c18af073b38f6ae7829ee64f::config::fee_recipient(arg0));
        let v1 = Index<T0>{
            id           : 0x2::object::new(arg4),
            creator      : 0x2::tx_context::sender(arg4),
            creator_bps  : 0xf91a7b97c188e7cd1093cd198d55c2f0173297c2c18af073b38f6ae7829ee64f::config::creator_bps(arg0),
            treasury_cap : arg1,
            components   : 0x1::vector::empty<0x1::type_name::TypeName>(),
            dead_shares  : 0x2::balance::zero<T0>(),
            busy         : false,
        };
        0xf91a7b97c188e7cd1093cd198d55c2f0173297c2c18af073b38f6ae7829ee64f::config::register_share<T0>(arg0, 0x2::object::id<Index<T0>>(&v1));
        CreateTicket<T0>{
            index   : v1,
            amounts : vector[],
        }
    }

    public fun creator<T0>(arg0: &Index<T0>) : address {
        arg0.creator
    }

    public fun dead_share_count() : u64 {
        1000
    }

    public fun dead_shares<T0>(arg0: &Index<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.dead_shares)
    }

    public fun deposit<T0, T1>(arg0: &0xf91a7b97c188e7cd1093cd198d55c2f0173297c2c18af073b38f6ae7829ee64f::config::Config, arg1: &mut Index<T0>, arg2: &mut MintTicket<T0>, arg3: 0x2::coin::Coin<T1>) {
        assert!(arg2.index_id == 0x2::object::id<Index<T0>>(arg1), 212);
        assert!(!arg2.settled, 216);
        assert_component<T0, T1>(arg1, 0x1::vector::length<u64>(&arg2.deposits));
        assert!(!0xf91a7b97c188e7cd1093cd198d55c2f0173297c2c18af073b38f6ae7829ee64f::config::is_dead<T1>(arg0), 209);
        let v0 = CompKey<T1>{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow_mut<CompKey<T1>, 0x2::balance::Balance<T1>>(&mut arg1.id, v0);
        0x1::vector::push_back<u64>(&mut arg2.balances, 0x2::balance::value<T1>(v1));
        0x1::vector::push_back<u64>(&mut arg2.deposits, 0x2::coin::value<T1>(&arg3));
        0x2::balance::join<T1>(v1, 0x2::coin::into_balance<T1>(arg3));
    }

    public fun finish_create<T0>(arg0: CreateTicket<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let CreateTicket {
            index   : v0,
            amounts : v1,
        } = arg0;
        let v2 = v0;
        assert!(0x1::vector::length<0x1::type_name::TypeName>(&v2.components) >= 2, 206);
        let v3 = 0x2::coin::mint_balance<T0>(&mut v2.treasury_cap, 100000000);
        0x2::balance::join<T0>(&mut v2.dead_shares, 0x2::balance::split<T0>(&mut v3, 1000));
        let v4 = &v2.components;
        let v5 = 0x1::vector::empty<0x1::ascii::String>();
        let v6 = 0;
        while (v6 < 0x1::vector::length<0x1::type_name::TypeName>(v4)) {
            0x1::vector::push_back<0x1::ascii::String>(&mut v5, 0x1::type_name::into_string(*0x1::vector::borrow<0x1::type_name::TypeName>(v4, v6)));
            v6 = v6 + 1;
        };
        let v7 = IndexCreated{
            index      : 0x2::object::id<Index<T0>>(&v2),
            coin       : 0x1::type_name::into_string(0x1::type_name::with_original_ids<T0>()),
            creator    : v2.creator,
            components : v5,
            amounts    : v1,
            shares     : 100000000,
        };
        0x2::event::emit<IndexCreated>(v7);
        0x2::transfer::share_object<Index<T0>>(v2);
        0x2::coin::from_balance<T0>(v3, arg1)
    }

    public fun finish_mint<T0>(arg0: &0xf91a7b97c188e7cd1093cd198d55c2f0173297c2c18af073b38f6ae7829ee64f::config::Config, arg1: &mut Index<T0>, arg2: MintTicket<T0>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let MintTicket {
            index_id : v0,
            supply   : _,
            balances : _,
            deposits : _,
            settled  : v4,
            shares   : v5,
            required : v6,
            changed  : v7,
        } = arg2;
        assert!(v0 == 0x2::object::id<Index<T0>>(arg1), 212);
        assert!(v4, 215);
        assert!(v7 == 0x1::vector::length<0x1::type_name::TypeName>(&arg1.components), 214);
        let v8 = mul_div_up(v5, 0xf91a7b97c188e7cd1093cd198d55c2f0173297c2c18af073b38f6ae7829ee64f::config::mint_fee_bps(arg0), 0xf91a7b97c188e7cd1093cd198d55c2f0173297c2c18af073b38f6ae7829ee64f::config::bps());
        assert!(v5 > v8, 218);
        let v9 = 0x2::coin::mint_balance<T0>(&mut arg1.treasury_cap, v5);
        let v10 = &mut v9;
        let (v11, v12) = pay_fee<T0>(arg0, arg1, v10, v8, arg3);
        arg1.busy = false;
        let v13 = Minted{
            index        : v0,
            sender       : 0x2::tx_context::sender(arg3),
            shares       : v5 - v8,
            creator_fee  : v11,
            platform_fee : v12,
            amounts      : v6,
        };
        0x2::event::emit<Minted>(v13);
        0x2::coin::from_balance<T0>(v9, arg3)
    }

    public fun finish_redeem<T0>(arg0: &mut Index<T0>, arg1: RedeemTicket<T0>, arg2: &0x2::tx_context::TxContext) {
        let RedeemTicket {
            index_id     : v0,
            supply       : _,
            burnt        : v2,
            creator_fee  : v3,
            platform_fee : v4,
            amounts      : v5,
        } = arg1;
        let v6 = v5;
        assert!(v0 == 0x2::object::id<Index<T0>>(arg0), 212);
        assert!(0x1::vector::length<u64>(&v6) == 0x1::vector::length<0x1::type_name::TypeName>(&arg0.components), 214);
        arg0.busy = false;
        let v7 = Redeemed{
            index        : v0,
            sender       : 0x2::tx_context::sender(arg2),
            shares       : v2,
            creator_fee  : v3,
            platform_fee : v4,
            amounts      : v6,
        };
        0x2::event::emit<Redeemed>(v7);
    }

    public fun forfeit<T0, T1>(arg0: &Index<T0>, arg1: &mut RedeemTicket<T0>) {
        assert!(arg1.index_id == 0x2::object::id<Index<T0>>(arg0), 212);
        assert_component<T0, T1>(arg0, 0x1::vector::length<u64>(&arg1.amounts));
        0x1::vector::push_back<u64>(&mut arg1.amounts, 0);
    }

    public fun genesis_shares() : u64 {
        100000000
    }

    public fun max_components() : u64 {
        10
    }

    public fun mint_ticket_shares<T0>(arg0: &MintTicket<T0>) : u64 {
        arg0.shares
    }

    public fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    public fun mul_div_up(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = (arg2 as u128);
        ((((arg0 as u128) * (arg1 as u128) + v0 - 1) / v0) as u64)
    }

    fun pay_fee<T0>(arg0: &0xf91a7b97c188e7cd1093cd198d55c2f0173297c2c18af073b38f6ae7829ee64f::config::Config, arg1: &Index<T0>, arg2: &mut 0x2::balance::Balance<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        let v0 = mul_div(arg3, arg1.creator_bps, 0xf91a7b97c188e7cd1093cd198d55c2f0173297c2c18af073b38f6ae7829ee64f::config::bps());
        let v1 = arg3 - v0;
        send<T0>(0x2::balance::split<T0>(arg2, v0), arg1.creator, arg4);
        send<T0>(0x2::balance::split<T0>(arg2, v1), 0xf91a7b97c188e7cd1093cd198d55c2f0173297c2c18af073b38f6ae7829ee64f::config::fee_recipient(arg0), arg4);
        (v0, v1)
    }

    public fun payout_for(arg0: u64, arg1: u64, arg2: u64) : u64 {
        mul_div(arg0, arg1, arg2)
    }

    public fun redeem_ticket_burnt<T0>(arg0: &RedeemTicket<T0>) : u64 {
        arg0.burnt
    }

    public fun required_for(arg0: u64, arg1: u64, arg2: u64) : u64 {
        mul_div_up(arg0, arg1, arg2)
    }

    fun send<T0>(arg0: 0x2::balance::Balance<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0) == 0) {
            0x2::balance::destroy_zero<T0>(arg0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg2), arg1);
        };
    }

    public fun settle<T0>(arg0: &Index<T0>, arg1: &mut MintTicket<T0>) {
        assert!(arg1.index_id == 0x2::object::id<Index<T0>>(arg0), 212);
        assert!(!arg1.settled, 216);
        let v0 = 0x1::vector::length<0x1::type_name::TypeName>(&arg0.components);
        assert!(0x1::vector::length<u64>(&arg1.deposits) == v0, 214);
        let v1 = arg1.supply;
        let v2 = 18446744073709551615;
        let v3 = v2;
        let v4 = 0;
        while (v4 < v0) {
            let v5 = shares_for(*0x1::vector::borrow<u64>(&arg1.deposits, v4), *0x1::vector::borrow<u64>(&arg1.balances, v4), v1);
            if (v5 < v2) {
                v3 = v5;
            };
            v4 = v4 + 1;
        };
        assert!(v3 > 0, 218);
        let v6 = vector[];
        let v7 = 0;
        while (v7 < v0) {
            0x1::vector::push_back<u64>(&mut v6, required_for(v3, *0x1::vector::borrow<u64>(&arg1.balances, v7), v1));
            v7 = v7 + 1;
        };
        arg1.required = v6;
        arg1.shares = v3;
        arg1.settled = true;
    }

    public fun shares_for(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = (arg0 as u128) * (arg2 as u128) / (arg1 as u128);
        let v1 = 18446744073709551615;
        let v2 = if (v0 > v1) {
            v1
        } else {
            v0
        };
        (v2 as u64)
    }

    public fun start_mint<T0>(arg0: &0xf91a7b97c188e7cd1093cd198d55c2f0173297c2c18af073b38f6ae7829ee64f::config::Config, arg1: &mut Index<T0>) : MintTicket<T0> {
        0xf91a7b97c188e7cd1093cd198d55c2f0173297c2c18af073b38f6ae7829ee64f::config::assert_open(arg0);
        assert!(!arg1.busy, 211);
        arg1.busy = true;
        MintTicket<T0>{
            index_id : 0x2::object::id<Index<T0>>(arg1),
            supply   : 0x2::coin::total_supply<T0>(&arg1.treasury_cap),
            balances : vector[],
            deposits : vector[],
            settled  : false,
            shares   : 0,
            required : vector[],
            changed  : 0,
        }
    }

    public fun start_redeem<T0>(arg0: &0xf91a7b97c188e7cd1093cd198d55c2f0173297c2c18af073b38f6ae7829ee64f::config::Config, arg1: &mut Index<T0>, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) : RedeemTicket<T0> {
        assert!(!arg1.busy, 211);
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 > 0, 210);
        let v1 = mul_div_up(v0, 0xf91a7b97c188e7cd1093cd198d55c2f0173297c2c18af073b38f6ae7829ee64f::config::redeem_fee_bps(arg0), 0xf91a7b97c188e7cd1093cd198d55c2f0173297c2c18af073b38f6ae7829ee64f::config::bps());
        assert!(v0 > v1, 218);
        arg1.busy = true;
        let v2 = 0x2::coin::into_balance<T0>(arg2);
        let v3 = &mut v2;
        let (v4, v5) = pay_fee<T0>(arg0, arg1, v3, v1, arg3);
        0x2::balance::decrease_supply<T0>(0x2::coin::supply_mut<T0>(&mut arg1.treasury_cap), v2);
        RedeemTicket<T0>{
            index_id     : 0x2::object::id<Index<T0>>(arg1),
            supply       : 0x2::coin::total_supply<T0>(&arg1.treasury_cap),
            burnt        : 0x2::balance::value<T0>(&v2),
            creator_fee  : v4,
            platform_fee : v5,
            amounts      : vector[],
        }
    }

    public fun supply<T0>(arg0: &Index<T0>) : u64 {
        0x2::coin::total_supply<T0>(&arg0.treasury_cap)
    }

    public fun transfer_creator<T0>(arg0: &mut Index<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.creator, 219);
        assert!(arg1 != @0x0, 220);
        let v0 = CreatorTransferred{
            index : 0x2::object::id<Index<T0>>(arg0),
            from  : arg0.creator,
            to    : arg1,
        };
        0x2::event::emit<CreatorTransferred>(v0);
        arg0.creator = arg1;
    }

    public fun withdraw<T0, T1>(arg0: &mut Index<T0>, arg1: &mut RedeemTicket<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(arg1.index_id == 0x2::object::id<Index<T0>>(arg0), 212);
        assert_component<T0, T1>(arg0, 0x1::vector::length<u64>(&arg1.amounts));
        let v0 = CompKey<T1>{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow_mut<CompKey<T1>, 0x2::balance::Balance<T1>>(&mut arg0.id, v0);
        let v2 = payout_for(arg1.burnt, 0x2::balance::value<T1>(v1), arg1.supply);
        0x1::vector::push_back<u64>(&mut arg1.amounts, v2);
        0x2::coin::from_balance<T1>(0x2::balance::split<T1>(v1, v2), arg2)
    }

    // decompiled from Move bytecode v7
}

