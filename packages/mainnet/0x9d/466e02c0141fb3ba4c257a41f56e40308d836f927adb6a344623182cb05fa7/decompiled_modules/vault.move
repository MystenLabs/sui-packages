module 0x9d466e02c0141fb3ba4c257a41f56e40308d836f927adb6a344623182cb05fa7::vault {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Vault<phantom T0> has key {
        id: 0x2::object::UID,
        treasury: 0x2::coin::TreasuryCap<T0>,
        balances: 0x2::bag::Bag,
        constituents: vector<0x1::type_name::TypeName>,
    }

    struct MintTicket {
        vault: 0x2::object::ID,
        mint_amount: u64,
        supply: u64,
        remaining: vector<0x1::type_name::TypeName>,
    }

    struct RedeemTicket {
        vault: 0x2::object::ID,
        num: u64,
        den: u64,
        remaining: vector<0x1::type_name::TypeName>,
    }

    public fun total_supply<T0>(arg0: &Vault<T0>) : u64 {
        0x2::coin::total_supply<T0>(&arg0.treasury)
    }

    public fun add_constituent<T0, T1>(arg0: &mut Vault<T0>, arg1: &AdminCap, arg2: 0x2::coin::Coin<T1>) {
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        assert!(!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, v0), 1);
        0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.balances, v0, 0x2::coin::into_balance<T1>(arg2));
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg0.constituents, v0);
    }

    public(friend) fun assert_admin<T0>(arg0: &Vault<T0>, arg1: &AdminCap) {
    }

    public fun begin_deposit<T0>(arg0: &Vault<T0>, arg1: u64) : MintTicket {
        assert!(arg1 > 0, 6);
        let v0 = 0x2::coin::total_supply<T0>(&arg0.treasury);
        assert!(v0 > 0, 5);
        MintTicket{
            vault       : 0x2::object::id<Vault<T0>>(arg0),
            mint_amount : arg1,
            supply      : v0,
            remaining   : arg0.constituents,
        }
    }

    public fun begin_redeem<T0>(arg0: &mut Vault<T0>, arg1: 0x2::coin::Coin<T0>) : RedeemTicket {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 6);
        0x2::coin::burn<T0>(&mut arg0.treasury, arg1);
        RedeemTicket{
            vault     : 0x2::object::id<Vault<T0>>(arg0),
            num       : v0,
            den       : 0x2::coin::total_supply<T0>(&arg0.treasury),
            remaining : arg0.constituents,
        }
    }

    fun ceil_mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        ((((arg0 as u128) * (arg1 as u128) + (arg2 as u128) - 1) / (arg2 as u128)) as u64)
    }

    public fun constituents<T0>(arg0: &Vault<T0>) : vector<0x1::type_name::TypeName> {
        arg0.constituents
    }

    public fun create<T0>(arg0: 0x2::coin::TreasuryCap<T0>, arg1: &mut 0x2::tx_context::TxContext) : AdminCap {
        let v0 = Vault<T0>{
            id           : 0x2::object::new(arg1),
            treasury     : arg0,
            balances     : 0x2::bag::new(arg1),
            constituents : 0x1::vector::empty<0x1::type_name::TypeName>(),
        };
        0x2::transfer::share_object<Vault<T0>>(v0);
        AdminCap{id: 0x2::object::new(arg1)}
    }

    public fun deposit_put<T0, T1>(arg0: &mut Vault<T0>, arg1: &mut MintTicket, arg2: 0x2::coin::Coin<T1>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::id<Vault<T0>>(arg0) == arg1.vault, 3);
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        let v1 = &mut arg1.remaining;
        drop_key(v1, v0);
        let v2 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.balances, v0);
        let v3 = ceil_mul_div(0x2::balance::value<T1>(v2), arg1.mint_amount, arg1.supply);
        assert!(0x2::coin::value<T1>(&arg2) >= v3, 7);
        0x2::balance::join<T1>(v2, 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg2, v3, arg3)));
        refund_or_zero<T1>(arg2, arg3);
    }

    fun drop_key(arg0: &mut vector<0x1::type_name::TypeName>, arg1: 0x1::type_name::TypeName) {
        let (v0, v1) = 0x1::vector::index_of<0x1::type_name::TypeName>(arg0, &arg1);
        assert!(v0, 8);
        0x1::vector::swap_remove<0x1::type_name::TypeName>(arg0, v1);
    }

    public fun finish_deposit<T0>(arg0: &mut Vault<T0>, arg1: MintTicket, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let MintTicket {
            vault       : v0,
            mint_amount : v1,
            supply      : _,
            remaining   : v3,
        } = arg1;
        let v4 = v3;
        assert!(v0 == 0x2::object::id<Vault<T0>>(arg0), 3);
        assert!(0x1::vector::is_empty<0x1::type_name::TypeName>(&v4), 2);
        0x2::coin::mint<T0>(&mut arg0.treasury, v1, arg2)
    }

    public fun finish_redeem(arg0: RedeemTicket) {
        let RedeemTicket {
            vault     : _,
            num       : _,
            den       : _,
            remaining : v3,
        } = arg0;
        let v4 = v3;
        assert!(0x1::vector::is_empty<0x1::type_name::TypeName>(&v4), 2);
    }

    fun floor_mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    public fun holding<T0, T1>(arg0: &Vault<T0>) : u64 {
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, v0)) {
            0
        } else {
            0x2::balance::value<T1>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&arg0.balances, v0))
        }
    }

    public(friend) fun put_balance<T0, T1>(arg0: &mut Vault<T0>, arg1: 0x2::balance::Balance<T1>) {
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, v0)) {
            0x2::balance::join<T1>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.balances, v0), arg1);
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.balances, v0, arg1);
            0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg0.constituents, v0);
        };
    }

    public fun redeem_claim<T0, T1>(arg0: &mut Vault<T0>, arg1: &mut RedeemTicket, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(0x2::object::id<Vault<T0>>(arg0) == arg1.vault, 3);
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        let v1 = &mut arg1.remaining;
        drop_key(v1, v0);
        let v2 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.balances, v0);
        0x2::coin::from_balance<T1>(0x2::balance::split<T1>(v2, floor_mul_div(0x2::balance::value<T1>(v2), arg1.num, arg1.den)), arg2)
    }

    fun refund_or_zero<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &0x2::tx_context::TxContext) {
        if (0x2::coin::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg1));
        } else {
            0x2::coin::destroy_zero<T0>(arg0);
        };
    }

    public fun remove_constituent<T0, T1>(arg0: &mut Vault<T0>, arg1: &AdminCap) {
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        let v1 = 0x2::bag::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.balances, v0);
        assert!(0x2::balance::value<T1>(&v1) == 0, 4);
        0x2::balance::destroy_zero<T1>(v1);
        let v2 = &mut arg0.constituents;
        drop_key(v2, v0);
    }

    public(friend) fun take_balance<T0, T1>(arg0: &mut Vault<T0>, arg1: u64) : 0x2::balance::Balance<T1> {
        0x2::balance::split<T1>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.balances, 0x1::type_name::with_defining_ids<T1>()), arg1)
    }

    // decompiled from Move bytecode v7
}

