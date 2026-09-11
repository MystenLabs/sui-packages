module 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::ticket {
    struct NavTicket {
        version: u64,
        registry: 0x2::object::ID,
        expected: u64,
        priced: vector<0x1::type_name::TypeName>,
        total: u64,
    }

    struct DepositTicket {
        id: 0x2::object::UID,
        version: u64,
        registry: 0x2::object::ID,
        depositor: address,
        to_mint: u64,
        net_value: u64,
        expected_legs: u64,
        bought: vector<0x1::type_name::TypeName>,
    }

    struct WithdrawTicket {
        id: 0x2::object::UID,
        version: u64,
        registry: 0x2::object::ID,
        withdrawer: address,
        burned: u64,
        supply_at_burn: u64,
        expected_legs: u64,
        denomination: 0x1::option::Option<0x1::type_name::TypeName>,
        sold: vector<0x1::type_name::TypeName>,
        proceeds: u64,
    }

    struct RedeemTicket {
        id: 0x2::object::UID,
        version: u64,
        registry: 0x2::object::ID,
        redeemer: address,
        burned: u64,
        supply_at_burn: u64,
        expected_legs: u64,
        taken: vector<0x1::type_name::TypeName>,
    }

    struct SwapReceipt {
        version: u64,
        registry: 0x2::object::ID,
        parent: 0x1::option::Option<0x2::object::ID>,
        token_in: 0x1::type_name::TypeName,
        token_out: 0x1::type_name::TypeName,
        amount_in: u64,
        min_out: u64,
    }

    public(friend) fun consume_deposit(arg0: DepositTicket, arg1: u64, arg2: 0x2::object::ID) : (address, u64) {
        let DepositTicket {
            id            : v0,
            version       : v1,
            registry      : v2,
            depositor     : v3,
            to_mint       : v4,
            net_value     : _,
            expected_legs : v6,
            bought        : v7,
        } = arg0;
        let v8 = v7;
        0x2::object::delete(v0);
        assert!(v1 == arg1, 1100);
        assert!(v2 == arg2, 1101);
        assert!(0x1::vector::length<0x1::type_name::TypeName>(&v8) == v6, 1104);
        (v3, v4)
    }

    public(friend) fun consume_nav(arg0: NavTicket, arg1: u64, arg2: 0x2::object::ID) : u64 {
        let NavTicket {
            version  : v0,
            registry : v1,
            expected : v2,
            priced   : v3,
            total    : v4,
        } = arg0;
        let v5 = v3;
        assert!(v0 == arg1, 1100);
        assert!(v1 == arg2, 1101);
        assert!(0x1::vector::length<0x1::type_name::TypeName>(&v5) == v2, 1104);
        v4
    }

    public(friend) fun consume_redeem(arg0: RedeemTicket, arg1: u64, arg2: 0x2::object::ID) : address {
        let RedeemTicket {
            id             : v0,
            version        : v1,
            registry       : v2,
            redeemer       : v3,
            burned         : _,
            supply_at_burn : _,
            expected_legs  : _,
            taken          : _,
        } = arg0;
        0x2::object::delete(v0);
        assert!(v1 == arg1, 1100);
        assert!(v2 == arg2, 1101);
        v3
    }

    public(friend) fun consume_withdraw(arg0: WithdrawTicket, arg1: u64, arg2: 0x2::object::ID) : (address, u64, u64) {
        let WithdrawTicket {
            id             : v0,
            version        : v1,
            registry       : v2,
            withdrawer     : v3,
            burned         : v4,
            supply_at_burn : _,
            expected_legs  : v6,
            denomination   : _,
            sold           : v8,
            proceeds       : v9,
        } = arg0;
        let v10 = v8;
        0x2::object::delete(v0);
        assert!(v1 == arg1, 1100);
        assert!(v2 == arg2, 1101);
        assert!(0x1::vector::length<0x1::type_name::TypeName>(&v10) == v6, 1104);
        (v3, v4, v9)
    }

    public(friend) fun deposit_id(arg0: &DepositTicket) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public(friend) fun deposit_mark_bought(arg0: &mut DepositTicket, arg1: 0x1::type_name::TypeName) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1::type_name::TypeName>(&arg0.bought)) {
            assert!(*0x1::vector::borrow<0x1::type_name::TypeName>(&arg0.bought, v0) != arg1, 1103);
            v0 = v0 + 1;
        };
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg0.bought, arg1);
    }

    public(friend) fun deposit_net_value(arg0: &DepositTicket) : u64 {
        arg0.net_value
    }

    public(friend) fun deposit_registry(arg0: &DepositTicket) : 0x2::object::ID {
        arg0.registry
    }

    public(friend) fun deposit_to_mint(arg0: &DepositTicket) : u64 {
        arg0.to_mint
    }

    public(friend) fun deposit_version(arg0: &DepositTicket) : u64 {
        arg0.version
    }

    public(friend) fun nav_add(arg0: &mut NavTicket, arg1: 0x1::type_name::TypeName, arg2: u64) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1::type_name::TypeName>(&arg0.priced)) {
            assert!(*0x1::vector::borrow<0x1::type_name::TypeName>(&arg0.priced, v0) != arg1, 1103);
            v0 = v0 + 1;
        };
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg0.priced, arg1);
        arg0.total = arg0.total + arg2;
    }

    public(friend) fun nav_priced_count(arg0: &NavTicket) : u64 {
        0x1::vector::length<0x1::type_name::TypeName>(&arg0.priced)
    }

    public(friend) fun nav_registry(arg0: &NavTicket) : 0x2::object::ID {
        arg0.registry
    }

    public(friend) fun nav_total(arg0: &NavTicket) : u64 {
        arg0.total
    }

    public(friend) fun nav_version(arg0: &NavTicket) : u64 {
        arg0.version
    }

    public(friend) fun new_deposit(arg0: u64, arg1: 0x2::object::ID, arg2: address, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : DepositTicket {
        DepositTicket{
            id            : 0x2::object::new(arg6),
            version       : arg0,
            registry      : arg1,
            depositor     : arg2,
            to_mint       : arg3,
            net_value     : arg4,
            expected_legs : arg5,
            bought        : 0x1::vector::empty<0x1::type_name::TypeName>(),
        }
    }

    public(friend) fun new_nav(arg0: u64, arg1: 0x2::object::ID, arg2: u64) : NavTicket {
        NavTicket{
            version  : arg0,
            registry : arg1,
            expected : arg2,
            priced   : 0x1::vector::empty<0x1::type_name::TypeName>(),
            total    : 0,
        }
    }

    public(friend) fun new_receipt(arg0: u64, arg1: 0x2::object::ID, arg2: 0x1::option::Option<0x2::object::ID>, arg3: 0x1::type_name::TypeName, arg4: 0x1::type_name::TypeName, arg5: u64, arg6: u64) : SwapReceipt {
        SwapReceipt{
            version   : arg0,
            registry  : arg1,
            parent    : arg2,
            token_in  : arg3,
            token_out : arg4,
            amount_in : arg5,
            min_out   : arg6,
        }
    }

    public(friend) fun new_redeem(arg0: u64, arg1: 0x2::object::ID, arg2: address, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : RedeemTicket {
        RedeemTicket{
            id             : 0x2::object::new(arg6),
            version        : arg0,
            registry       : arg1,
            redeemer       : arg2,
            burned         : arg3,
            supply_at_burn : arg4,
            expected_legs  : arg5,
            taken          : 0x1::vector::empty<0x1::type_name::TypeName>(),
        }
    }

    public(friend) fun new_withdraw(arg0: u64, arg1: 0x2::object::ID, arg2: address, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : WithdrawTicket {
        WithdrawTicket{
            id             : 0x2::object::new(arg6),
            version        : arg0,
            registry       : arg1,
            withdrawer     : arg2,
            burned         : arg3,
            supply_at_burn : arg4,
            expected_legs  : arg5,
            denomination   : 0x1::option::none<0x1::type_name::TypeName>(),
            sold           : 0x1::vector::empty<0x1::type_name::TypeName>(),
            proceeds       : 0,
        }
    }

    public(friend) fun receipt_amount_in(arg0: &SwapReceipt) : u64 {
        arg0.amount_in
    }

    public(friend) fun receipt_min_out(arg0: &SwapReceipt) : u64 {
        arg0.min_out
    }

    public(friend) fun receipt_parent(arg0: &SwapReceipt) : 0x1::option::Option<0x2::object::ID> {
        arg0.parent
    }

    public(friend) fun receipt_registry(arg0: &SwapReceipt) : 0x2::object::ID {
        arg0.registry
    }

    public(friend) fun receipt_token_in(arg0: &SwapReceipt) : 0x1::type_name::TypeName {
        arg0.token_in
    }

    public(friend) fun receipt_token_out(arg0: &SwapReceipt) : 0x1::type_name::TypeName {
        arg0.token_out
    }

    public(friend) fun receipt_version(arg0: &SwapReceipt) : u64 {
        arg0.version
    }

    public(friend) fun redeem_burned(arg0: &RedeemTicket) : u64 {
        arg0.burned
    }

    public(friend) fun redeem_id(arg0: &RedeemTicket) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public(friend) fun redeem_mark_taken(arg0: &mut RedeemTicket, arg1: 0x1::type_name::TypeName) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1::type_name::TypeName>(&arg0.taken)) {
            assert!(*0x1::vector::borrow<0x1::type_name::TypeName>(&arg0.taken, v0) != arg1, 1103);
            v0 = v0 + 1;
        };
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg0.taken, arg1);
    }

    public(friend) fun redeem_registry(arg0: &RedeemTicket) : 0x2::object::ID {
        arg0.registry
    }

    public(friend) fun redeem_supply_at_burn(arg0: &RedeemTicket) : u64 {
        arg0.supply_at_burn
    }

    public(friend) fun redeem_version(arg0: &RedeemTicket) : u64 {
        arg0.version
    }

    public(friend) fun settle_receipt(arg0: SwapReceipt, arg1: u64, arg2: 0x2::object::ID, arg3: 0x1::option::Option<0x2::object::ID>, arg4: 0x1::type_name::TypeName, arg5: 0x1::type_name::TypeName, arg6: u64) : u64 {
        let SwapReceipt {
            version   : v0,
            registry  : v1,
            parent    : v2,
            token_in  : v3,
            token_out : v4,
            amount_in : v5,
            min_out   : v6,
        } = arg0;
        assert!(v0 == arg1, 1100);
        assert!(v1 == arg2, 1101);
        assert!(v2 == arg3, 1102);
        assert!(v3 == arg4, 1103);
        assert!(v4 == arg5, 1103);
        assert!(arg6 >= v6, 1105);
        v5
    }

    public(friend) fun withdraw_assert_denomination(arg0: &WithdrawTicket, arg1: 0x1::type_name::TypeName) {
        assert!(!0x1::option::is_none<0x1::type_name::TypeName>(&arg0.denomination), 1103);
        assert!(*0x1::option::borrow<0x1::type_name::TypeName>(&arg0.denomination) == arg1, 1103);
    }

    public(friend) fun withdraw_bind_denomination(arg0: &mut WithdrawTicket, arg1: 0x1::type_name::TypeName) {
        if (0x1::option::is_none<0x1::type_name::TypeName>(&arg0.denomination)) {
            arg0.denomination = 0x1::option::some<0x1::type_name::TypeName>(arg1);
        } else {
            assert!(*0x1::option::borrow<0x1::type_name::TypeName>(&arg0.denomination) == arg1, 1103);
        };
    }

    public(friend) fun withdraw_burned(arg0: &WithdrawTicket) : u64 {
        arg0.burned
    }

    public(friend) fun withdraw_id(arg0: &WithdrawTicket) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public(friend) fun withdraw_mark_sold(arg0: &mut WithdrawTicket, arg1: 0x1::type_name::TypeName, arg2: u64) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1::type_name::TypeName>(&arg0.sold)) {
            assert!(*0x1::vector::borrow<0x1::type_name::TypeName>(&arg0.sold, v0) != arg1, 1103);
            v0 = v0 + 1;
        };
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg0.sold, arg1);
        arg0.proceeds = arg0.proceeds + arg2;
    }

    public(friend) fun withdraw_proceeds(arg0: &WithdrawTicket) : u64 {
        arg0.proceeds
    }

    public(friend) fun withdraw_registry(arg0: &WithdrawTicket) : 0x2::object::ID {
        arg0.registry
    }

    public(friend) fun withdraw_supply_at_burn(arg0: &WithdrawTicket) : u64 {
        arg0.supply_at_burn
    }

    public(friend) fun withdraw_version(arg0: &WithdrawTicket) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v7
}

