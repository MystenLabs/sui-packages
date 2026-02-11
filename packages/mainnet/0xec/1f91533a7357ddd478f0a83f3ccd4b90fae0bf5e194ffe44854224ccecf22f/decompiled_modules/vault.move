module 0xb749f8a72f200793e9df0fa3ac554ce94f81576ef901e7c5e871a140163cd85b::vault {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct TradeCap has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
    }

    struct Vault has key {
        id: 0x2::object::UID,
        admin: address,
        balances: 0x2::bag::Bag,
        positions: 0x2::bag::Bag,
        position_refs: vector<PositionRef>,
    }

    struct BalanceKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct PositionRef has copy, drop, store {
        id: 0x2::object::ID,
        protocol: u8,
    }

    public fun balance<T0: store>(arg0: &AdminCap, arg1: &Vault, arg2: &0x2::tx_context::TxContext) : u64 {
        assert_admin(arg1, arg2);
        balance_internal<T0>(arg1)
    }

    fun all_positions(arg0: &Vault) : vector<PositionRef> {
        let v0 = 0x1::vector::empty<PositionRef>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<PositionRef>(&arg0.position_refs)) {
            0x1::vector::push_back<PositionRef>(&mut v0, *0x1::vector::borrow<PositionRef>(&arg0.position_refs, v1));
            v1 = v1 + 1;
        };
        v0
    }

    public fun all_positions_with_admin_cap(arg0: &AdminCap, arg1: &Vault, arg2: &0x2::tx_context::TxContext) : vector<PositionRef> {
        assert_admin(arg1, arg2);
        all_positions(arg1)
    }

    public fun all_positions_with_trade_cap(arg0: &TradeCap, arg1: &Vault) : vector<PositionRef> {
        assert_trade_cap_vault(arg0, arg1);
        all_positions(arg1)
    }

    public fun assert_admin(arg0: &Vault, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 0);
    }

    fun assert_trade_cap_vault(arg0: &TradeCap, arg1: &Vault) {
        assert!(arg0.vault_id == 0x2::object::id<Vault>(arg1), 1);
    }

    fun balance_internal<T0: store>(arg0: &Vault) : u64 {
        let v0 = BalanceKey<T0>{dummy_field: false};
        if (0x2::bag::contains<BalanceKey<T0>>(&arg0.balances, v0)) {
            0x2::balance::value<T0>(0x2::bag::borrow<BalanceKey<T0>, 0x2::balance::Balance<T0>>(&arg0.balances, v0))
        } else {
            0
        }
    }

    public fun balance_with_trade_cap<T0: store>(arg0: &TradeCap, arg1: &Vault) : u64 {
        assert_trade_cap_vault(arg0, arg1);
        balance_internal<T0>(arg1)
    }

    fun borrow_balance_mut<T0: store>(arg0: &mut Vault) : &mut 0x2::balance::Balance<T0> {
        let v0 = BalanceKey<T0>{dummy_field: false};
        if (!0x2::bag::contains<BalanceKey<T0>>(&arg0.balances, v0)) {
            0x2::bag::add<BalanceKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0, 0x2::balance::zero<T0>());
        };
        0x2::bag::borrow_mut<BalanceKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0)
    }

    public fun create_vault(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Vault{
            id            : 0x2::object::new(arg0),
            admin         : 0x2::tx_context::sender(arg0),
            balances      : 0x2::bag::new(arg0),
            positions     : 0x2::bag::new(arg0),
            position_refs : 0x1::vector::empty<PositionRef>(),
        };
        0x2::transfer::share_object<Vault>(v0);
    }

    fun delete_position<T0: store>(arg0: &mut Vault, arg1: 0x2::object::ID) : T0 {
        remove_position_ref(arg0, arg1);
        0x2::bag::remove<0x2::object::ID, T0>(&mut arg0.positions, arg1)
    }

    public fun delete_position_with_admin_cap<T0: store>(arg0: &AdminCap, arg1: &mut Vault, arg2: 0x2::object::ID, arg3: &0x2::tx_context::TxContext) : T0 {
        assert_admin(arg1, arg3);
        delete_position<T0>(arg1, arg2)
    }

    public fun delete_position_with_trade_cap<T0: store>(arg0: &TradeCap, arg1: &mut Vault, arg2: 0x2::object::ID) : T0 {
        assert_trade_cap_vault(arg0, arg1);
        delete_position<T0>(arg1, arg2)
    }

    public fun deposit<T0>(arg0: &AdminCap, arg1: &mut Vault, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::tx_context::TxContext) {
        assert_admin(arg1, arg3);
        put_balance<T0>(arg1, 0x2::coin::into_balance<T0>(arg2));
    }

    public fun deposit_with_trade_cap<T0>(arg0: &TradeCap, arg1: &mut Vault, arg2: 0x2::coin::Coin<T0>) {
        assert_trade_cap_vault(arg0, arg1);
        put_balance<T0>(arg1, 0x2::coin::into_balance<T0>(arg2));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun mint_trade_cap(arg0: &AdminCap, arg1: &Vault, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg1, arg3);
        let v0 = TradeCap{
            id       : 0x2::object::new(arg3),
            vault_id : 0x2::object::id<Vault>(arg1),
        };
        0x2::transfer::public_transfer<TradeCap>(v0, arg2);
    }

    public fun position_ref_id(arg0: &PositionRef) : 0x2::object::ID {
        arg0.id
    }

    public fun position_ref_protocol(arg0: &PositionRef) : u8 {
        arg0.protocol
    }

    public fun position_refs_with_admin_cap(arg0: &AdminCap, arg1: &Vault, arg2: &0x2::tx_context::TxContext) : &vector<PositionRef> {
        assert_admin(arg1, arg2);
        &arg1.position_refs
    }

    public fun position_refs_with_trade_cap(arg0: &TradeCap, arg1: &Vault) : &vector<PositionRef> {
        assert_trade_cap_vault(arg0, arg1);
        &arg1.position_refs
    }

    fun positions_by_protocol(arg0: &Vault, arg1: u8) : vector<PositionRef> {
        let v0 = 0x1::vector::empty<PositionRef>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<PositionRef>(&arg0.position_refs)) {
            let v2 = *0x1::vector::borrow<PositionRef>(&arg0.position_refs, v1);
            if (v2.protocol == arg1) {
                0x1::vector::push_back<PositionRef>(&mut v0, v2);
            };
            v1 = v1 + 1;
        };
        v0
    }

    public fun positions_by_protocol_with_admin_cap(arg0: &AdminCap, arg1: &Vault, arg2: u8, arg3: &0x2::tx_context::TxContext) : vector<PositionRef> {
        assert_admin(arg1, arg3);
        positions_by_protocol(arg1, arg2)
    }

    public fun positions_by_protocol_with_trade_cap(arg0: &TradeCap, arg1: &Vault, arg2: u8) : vector<PositionRef> {
        assert_trade_cap_vault(arg0, arg1);
        positions_by_protocol(arg1, arg2)
    }

    fun put_balance<T0>(arg0: &mut Vault, arg1: 0x2::balance::Balance<T0>) {
        if (0x2::balance::value<T0>(&arg1) == 0) {
            0x2::balance::destroy_zero<T0>(arg1);
            return
        };
        let v0 = BalanceKey<T0>{dummy_field: false};
        if (0x2::bag::contains<BalanceKey<T0>>(&arg0.balances, v0)) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<BalanceKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0), arg1);
        } else {
            0x2::bag::add<BalanceKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0, arg1);
        };
    }

    public fun put_balance_with_admin_cap<T0>(arg0: &AdminCap, arg1: &mut Vault, arg2: 0x2::balance::Balance<T0>, arg3: &0x2::tx_context::TxContext) {
        assert_admin(arg1, arg3);
        put_balance<T0>(arg1, arg2);
    }

    public fun put_balance_with_trade_cap<T0>(arg0: &TradeCap, arg1: &mut Vault, arg2: 0x2::balance::Balance<T0>) {
        assert_trade_cap_vault(arg0, arg1);
        put_balance<T0>(arg1, arg2);
    }

    fun remove_position_ref(arg0: &mut Vault, arg1: 0x2::object::ID) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<PositionRef>(&arg0.position_refs)) {
            let v1 = *0x1::vector::borrow<PositionRef>(&arg0.position_refs, v0);
            if (v1.id == arg1) {
                0x1::vector::remove<PositionRef>(&mut arg0.position_refs, v0);
                return
            };
            v0 = v0 + 1;
        };
        abort 2
    }

    fun store_position<T0: store>(arg0: &mut Vault, arg1: 0x2::object::ID, arg2: T0, arg3: u8) {
        0x2::bag::add<0x2::object::ID, T0>(&mut arg0.positions, arg1, arg2);
        let v0 = PositionRef{
            id       : arg1,
            protocol : arg3,
        };
        0x1::vector::push_back<PositionRef>(&mut arg0.position_refs, v0);
    }

    public fun store_position_with_admin_cap<T0: store>(arg0: &AdminCap, arg1: &mut Vault, arg2: 0x2::object::ID, arg3: T0, arg4: u8, arg5: &0x2::tx_context::TxContext) {
        assert_admin(arg1, arg5);
        store_position<T0>(arg1, arg2, arg3, arg4);
    }

    public fun store_position_with_trade_cap<T0: store>(arg0: &TradeCap, arg1: &mut Vault, arg2: 0x2::object::ID, arg3: T0, arg4: u8) {
        assert_trade_cap_vault(arg0, arg1);
        store_position<T0>(arg1, arg2, arg3, arg4);
    }

    fun take_all_balance<T0: store>(arg0: &mut Vault) : 0x2::balance::Balance<T0> {
        let v0 = BalanceKey<T0>{dummy_field: false};
        if (0x2::bag::contains<BalanceKey<T0>>(&arg0.balances, v0)) {
            0x2::bag::remove<BalanceKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0)
        } else {
            0x2::balance::zero<T0>()
        }
    }

    public fun take_all_balance_with_admin_cap<T0: store>(arg0: &AdminCap, arg1: &mut Vault, arg2: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        assert_admin(arg1, arg2);
        take_all_balance<T0>(arg1)
    }

    public fun take_all_balance_with_trade_cap<T0: store>(arg0: &TradeCap, arg1: &mut Vault) : 0x2::balance::Balance<T0> {
        assert_trade_cap_vault(arg0, arg1);
        take_all_balance<T0>(arg1)
    }

    fun take_balance<T0: store>(arg0: &mut Vault, arg1: u64) : 0x2::balance::Balance<T0> {
        0x2::balance::split<T0>(borrow_balance_mut<T0>(arg0), arg1)
    }

    public fun withdraw<T0: store>(arg0: &AdminCap, arg1: &mut Vault, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg1, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(take_balance<T0>(arg1, arg2), arg4), arg3);
    }

    public fun withdraw_with_trade_cap<T0: store>(arg0: &TradeCap, arg1: &mut Vault, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert_trade_cap_vault(arg0, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(take_balance<T0>(arg1, arg2), arg4), arg3);
    }

    // decompiled from Move bytecode v6
}

