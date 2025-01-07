module 0xe6f6ffeeb569b7bd2a0dda0e55d5adf4df94d729892cadbb98c3a639c03e2ee1::coin23 {
    struct COIN23 has drop {
        dummy_field: bool,
    }

    struct Witness has drop {
        dummy_field: bool,
    }

    struct Coin23<phantom T0> has key {
        id: 0x2::object::UID,
        available: 0x2::balance::Balance<T0>,
        rebills: 0x2::linked_table::LinkedTable<address, vector<Rebill>>,
        held_funds: 0x2::linked_table::LinkedTable<address, Hold<T0>>,
        frozen: bool,
    }

    struct Rebill has copy, drop, store {
        available: u64,
        refresh_amount: u64,
        refresh_cadence: u64,
        latest_refresh: u64,
    }

    struct Hold<phantom T0> has store {
        funds: 0x2::balance::Balance<T0>,
        expiry_ms: u64,
    }

    struct WITHDRAW {
        dummy_field: bool,
    }

    struct MERCHANT {
        dummy_field: bool,
    }

    struct CurrencyRegistry has key {
        id: 0x2::object::UID,
    }

    struct CurrencyControls<phantom T0> has store {
        creator_can_withdraw: bool,
        creator_can_freeze: bool,
        user_transfer_enum: u8,
        transfer_fee: 0x1::option::Option<TransferFee>,
        export_auths: vector<address>,
    }

    struct TransferFee has copy, drop, store {
        bps: u64,
        pay_to: address,
    }

    struct FREEZE {
        dummy_field: bool,
    }

    public fun destroy_empty<T0>(arg0: Coin23<T0>, arg1: &0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::TxAuthority) {
        assert!(0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::ownership::can_act_as_owner<WITHDRAW>(&arg0.id, arg1), 0);
        let Coin23 {
            id         : v0,
            available  : v1,
            rebills    : v2,
            held_funds : v3,
            frozen     : _,
        } = arg0;
        0x2::object::delete(v0);
        0x2::balance::destroy_zero<T0>(v1);
        0x2::linked_table::drop<address, vector<Rebill>>(v2);
        0x2::linked_table::destroy_empty<address, Hold<T0>>(v3);
    }

    public fun transfer<T0>(arg0: &mut Coin23<T0>, arg1: &mut Coin23<T0>, arg2: u64, arg3: &CurrencyRegistry, arg4: &0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::TxAuthority, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(is_valid_transfer<T0>(arg0, arg3, arg4), 4);
        assert!(!arg0.frozen && !arg1.frozen, 3);
        let v0 = pay_transfer_fee<T0>(arg0, arg2, arg3, arg5);
        0x2::balance::join<T0>(&mut arg1.available, 0x2::balance::split<T0>(&mut arg0.available, arg2 - v0));
    }

    public fun add_hold<T0>(arg0: &mut Coin23<T0>, arg1: address, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &CurrencyRegistry, arg6: &0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::TxAuthority) : u64 {
        assert!(arg3 >= 60000, 8);
        assert!(arg3 <= 31536000000, 8);
        assert!(arg2 > 0, 8);
        assert!(0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::ownership::can_act_as_owner<WITHDRAW>(&arg0.id, arg6), 0);
        assert!(is_currency_transferable<T0>(arg5), 7);
        assert!(!arg0.frozen, 3);
        let v0 = 0x2::clock::timestamp_ms(arg4) + arg3;
        if (0x2::linked_table::contains<address, Hold<T0>>(&arg0.held_funds, arg1)) {
            let v1 = 0x2::linked_table::borrow_mut<address, Hold<T0>>(&mut arg0.held_funds, arg1);
            v1.expiry_ms = 0x2::math::max(v1.expiry_ms, v0);
            let v2 = 0x2::balance::value<T0>(&v1.funds);
            if (v2 < arg2) {
                0x2::balance::join<T0>(&mut v1.funds, 0x2::balance::split<T0>(&mut arg0.available, arg2 - v2));
            };
        } else {
            let v3 = Hold<T0>{
                funds     : 0x2::balance::split<T0>(&mut arg0.available, arg2),
                expiry_ms : v0,
            };
            0x2::linked_table::push_back<address, Hold<T0>>(&mut arg0.held_funds, arg1, v3);
        };
        v0
    }

    public entry fun add_hold_<T0>(arg0: &mut Coin23<T0>, arg1: address, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &CurrencyRegistry, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::begin(arg6);
        add_hold<T0>(arg0, arg1, arg2, arg3, arg4, arg5, &v0);
    }

    public fun add_rebill<T0>(arg0: &mut Coin23<T0>, arg1: address, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &CurrencyRegistry, arg6: &0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::TxAuthority) {
        assert!(arg2 > 0, 2);
        assert!(0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::ownership::can_act_as_owner<WITHDRAW>(&arg0.id, arg6), 0);
        assert!(is_currency_transferable<T0>(arg5), 7);
        assert!(!arg0.frozen, 3);
        let v0 = Rebill{
            available       : 0,
            refresh_amount  : arg2,
            refresh_cadence : arg3,
            latest_refresh  : 0x2::clock::timestamp_ms(arg4),
        };
        0x1::vector::push_back<Rebill>(0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::linked_table2::borrow_mut_fill<address, vector<Rebill>>(&mut arg0.rebills, arg1, 0x1::vector::empty<Rebill>()), v0);
    }

    public fun balance_available<T0>(arg0: &Coin23<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.available)
    }

    public fun calculate_transfer_fee<T0>(arg0: u64, arg1: &CurrencyRegistry) : (u64, 0x1::option::Option<address>) {
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&arg1.id, v0)) {
            let v3 = 0x2::dynamic_field::borrow<0x1::type_name::TypeName, CurrencyControls<T0>>(&arg1.id, v0);
            if (0x1::option::is_some<TransferFee>(&v3.transfer_fee)) {
                let v4 = 0x1::option::borrow<TransferFee>(&v3.transfer_fee);
                ((((v4.bps as u128) * (arg0 as u128) / 10000) as u64), 0x1::option::some<address>(v4.pay_to))
            } else {
                (0, 0x1::option::none<address>())
            }
        } else {
            (0, 0x1::option::none<address>())
        }
    }

    public fun cancel_all_rebills_for_merchant<T0>(arg0: &mut Coin23<T0>, arg1: address, arg2: &0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::TxAuthority) {
        assert!(0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::ownership::can_act_as_owner<WITHDRAW>(&arg0.id, arg2) || 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::can_act_as_address<MERCHANT>(arg1, arg2), 0);
        0x2::linked_table::remove<address, vector<Rebill>>(&mut arg0.rebills, arg1);
    }

    public fun cancel_rebill<T0>(arg0: &mut Coin23<T0>, arg1: address, arg2: u64, arg3: &0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::TxAuthority) {
        assert!(0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::ownership::can_act_as_owner<WITHDRAW>(&arg0.id, arg3) || 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::can_act_as_address<MERCHANT>(arg1, arg3), 0);
        let v0 = 0x2::linked_table::borrow_mut<address, vector<Rebill>>(&mut arg0.rebills, arg1);
        0x1::vector::swap_remove<Rebill>(v0, arg2);
        if (0x1::vector::length<Rebill>(v0) == 0) {
            0x2::linked_table::remove<address, vector<Rebill>>(&mut arg0.rebills, arg1);
        };
    }

    public entry fun charge_and_rebill<T0>(arg0: &mut Coin23<T0>, arg1: &mut Coin23<T0>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &CurrencyRegistry, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::begin(arg6);
        let v1 = 0x1::option::destroy_some<address>(0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::ownership::get_owner(&arg1.id));
        transfer<T0>(arg0, arg1, arg2, arg5, &v0, arg6);
        add_rebill<T0>(arg0, v1, arg2, arg3, arg4, arg5, &v0);
    }

    public entry fun charge_and_release_hold<T0>(arg0: &mut Coin23<T0>, arg1: &mut Coin23<T0>, arg2: u64, arg3: &0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::organization::Organization, arg4: &0x2::clock::Clock, arg5: &CurrencyRegistry, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::organization::assert_login<MERCHANT>(arg3, arg6);
        let v1 = 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::organization::principal(arg3);
        withdraw_from_held_funds_<T0>(arg0, arg1, v1, arg2, arg4, arg5, &v0, arg6);
        release_held_funds<T0>(arg0, v1, &v0);
    }

    public fun crank<T0>(arg0: &mut Coin23<T0>, arg1: &0x2::clock::Clock) {
        let v0 = *0x2::linked_table::front<address, vector<Rebill>>(&arg0.rebills);
        while (0x1::option::is_some<address>(&v0)) {
            let v1 = *0x1::option::borrow<address>(&v0);
            let v2 = 0x2::linked_table::borrow_mut<address, vector<Rebill>>(&mut arg0.rebills, v1);
            let v3 = 0;
            while (v3 < 0x1::vector::length<Rebill>(v2)) {
                let v4 = 0x1::vector::borrow_mut<Rebill>(v2, v3);
                crank_rebill(v4, arg1);
                v3 = v3 + 1;
            };
            v0 = *0x2::linked_table::next<address, vector<Rebill>>(&arg0.rebills, v1);
        };
        let v5 = *0x2::linked_table::front<address, Hold<T0>>(&arg0.held_funds);
        while (0x1::option::is_some<address>(&v5)) {
            let v6 = *0x1::option::borrow<address>(&v5);
            v5 = *0x2::linked_table::next<address, Hold<T0>>(&arg0.held_funds, v6);
            if (0x2::linked_table::borrow<address, Hold<T0>>(&arg0.held_funds, v6).expiry_ms < 0x2::clock::timestamp_ms(arg1)) {
                release_hold_internal<T0>(arg0, v6);
            };
        };
    }

    public fun crank_rebill(arg0: &mut Rebill, arg1: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        if (v0 >= arg0.latest_refresh + arg0.refresh_cadence) {
            arg0.latest_refresh = arg0.latest_refresh + (((arg0.refresh_cadence as u128) * (((v0 - arg0.latest_refresh) / arg0.refresh_cadence) as u128)) as u64);
            arg0.available = arg0.refresh_amount;
        };
    }

    public fun create<T0>(arg0: &mut 0x2::tx_context::TxContext) : Coin23<T0> {
        Coin23<T0>{
            id         : 0x2::object::new(arg0),
            available  : 0x2::balance::zero<T0>(),
            rebills    : 0x2::linked_table::new<address, vector<Rebill>>(arg0),
            held_funds : 0x2::linked_table::new<address, Hold<T0>>(arg0),
            frozen     : false,
        }
    }

    public entry fun create_<T0>(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        return_and_share<T0>(create<T0>(arg1), arg0);
    }

    public fun destroy<T0>(arg0: Coin23<T0>, arg1: &CurrencyRegistry, arg2: &0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::TxAuthority) : 0x2::balance::Balance<T0> {
        assert!(is_valid_export<T0>(&arg0, arg1, arg2), 5);
        assert!(!arg0.frozen, 3);
        let Coin23 {
            id         : v0,
            available  : v1,
            rebills    : v2,
            held_funds : v3,
            frozen     : _,
        } = arg0;
        0x2::object::delete(v0);
        0x2::linked_table::drop<address, vector<Rebill>>(v2);
        0x2::linked_table::destroy_empty<address, Hold<T0>>(v3);
        v1
    }

    public entry fun destroy_currency() {
    }

    public fun disable_creator_withdraw<T0>(arg0: &mut CurrencyRegistry, arg1: &0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::TxAuthority) {
        assert!(0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::can_act_as_package<T0, 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action::ADMIN>(arg1), 1);
        0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, CurrencyControls<T0>>(&mut arg0.id, 0x1::type_name::get<T0>()).creator_can_withdraw = false;
    }

    public fun disable_freeze_ability<T0>(arg0: &mut CurrencyRegistry, arg1: &0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::TxAuthority) {
        assert!(0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::can_act_as_package<T0, 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action::ADMIN>(arg1), 1);
        0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, CurrencyControls<T0>>(&mut arg0.id, 0x1::type_name::get<T0>()).creator_can_freeze = false;
    }

    public fun export_auths<T0>(arg0: &CurrencyRegistry) : vector<address> {
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&arg0.id, v0)) {
            0x2::dynamic_field::borrow<0x1::type_name::TypeName, CurrencyControls<T0>>(&arg0.id, v0).export_auths
        } else {
            vector[]
        }
    }

    public fun export_to_balance<T0>(arg0: &mut Coin23<T0>, arg1: &CurrencyRegistry, arg2: u64, arg3: &0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::TxAuthority) : 0x2::balance::Balance<T0> {
        assert!(is_valid_export<T0>(arg0, arg1, arg3), 5);
        assert!(!arg0.frozen, 3);
        0x2::balance::split<T0>(&mut arg0.available, arg2)
    }

    public fun export_to_coin<T0>(arg0: &mut Coin23<T0>, arg1: &CurrencyRegistry, arg2: u64, arg3: &0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::TxAuthority, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(is_valid_export<T0>(arg0, arg1, arg3), 5);
        assert!(!arg0.frozen, 3);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.available, arg2), arg4)
    }

    public fun freeze_<T0>(arg0: &mut Coin23<T0>, arg1: &CurrencyRegistry, arg2: &0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::TxAuthority) {
        assert!(0x2::dynamic_field::borrow<0x1::type_name::TypeName, CurrencyControls<T0>>(&arg1.id, 0x1::type_name::get<T0>()).creator_can_freeze, 12);
        assert!(0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::can_act_as_package<T0, FREEZE>(arg2), 1);
        arg0.frozen = true;
    }

    public entry fun grant_currency() {
    }

    public fun import_from_balance<T0>(arg0: &mut Coin23<T0>, arg1: 0x2::balance::Balance<T0>) {
        assert!(!arg0.frozen, 3);
        0x2::balance::join<T0>(&mut arg0.available, arg1);
    }

    public entry fun import_from_coin<T0>(arg0: &mut Coin23<T0>, arg1: 0x2::coin::Coin<T0>) {
        assert!(!arg0.frozen, 3);
        0x2::balance::join<T0>(&mut arg0.available, 0x2::coin::into_balance<T0>(arg1));
    }

    fun init(arg0: COIN23, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = CurrencyRegistry{id: 0x2::object::new(arg1)};
        0x2::transfer::share_object<CurrencyRegistry>(v0);
        0x2::package::burn_publisher(0x2::package::claim<COIN23>(arg0, arg1));
    }

    public fun inspect_creator_currency_controls<T0>(arg0: &CurrencyRegistry) : (bool, bool) {
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&arg0.id, v0)) {
            let v3 = 0x2::dynamic_field::borrow<0x1::type_name::TypeName, CurrencyControls<T0>>(&arg0.id, v0);
            (v3.creator_can_withdraw, v3.creator_can_freeze)
        } else {
            (false, false)
        }
    }

    public fun inspect_hold<T0>(arg0: &Coin23<T0>, arg1: address) : (u64, u64) {
        if (!0x2::linked_table::contains<address, Hold<T0>>(&arg0.held_funds, arg1)) {
            return (0, 0)
        };
        let v0 = 0x2::linked_table::borrow<address, Hold<T0>>(&arg0.held_funds, arg1);
        (0x2::balance::value<T0>(&v0.funds), v0.expiry_ms)
    }

    public fun inspect_rebill(arg0: &Rebill) : (u64, u64, u64, u64) {
        (arg0.available, arg0.refresh_amount, arg0.refresh_cadence, arg0.latest_refresh)
    }

    public fun is_currency_exportable<T0>(arg0: &CurrencyRegistry) : bool {
        let v0 = 0x1::type_name::get<T0>();
        0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&arg0.id, v0) && 0x2::dynamic_field::borrow<0x1::type_name::TypeName, CurrencyControls<T0>>(&arg0.id, v0).user_transfer_enum > 1 || true
    }

    public fun is_currency_transferable<T0>(arg0: &CurrencyRegistry) : bool {
        let v0 = 0x1::type_name::get<T0>();
        0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&arg0.id, v0) && 0x2::dynamic_field::borrow<0x1::type_name::TypeName, CurrencyControls<T0>>(&arg0.id, v0).user_transfer_enum > 0 || true
    }

    public fun is_frozen<T0>(arg0: &Coin23<T0>) : bool {
        arg0.frozen
    }

    public fun is_valid_export<T0>(arg0: &Coin23<T0>, arg1: &CurrencyRegistry, arg2: &0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::TxAuthority) : bool {
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&arg1.id, v0)) {
            let v2 = 0x2::dynamic_field::borrow<0x1::type_name::TypeName, CurrencyControls<T0>>(&arg1.id, v0);
            if (v2.user_transfer_enum > 1 && 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::ownership::can_act_as_owner<WITHDRAW>(&arg0.id, arg2)) {
                return true
            };
            if (v2.creator_can_withdraw && 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::can_act_as_package<T0, WITHDRAW>(arg2)) {
                return true
            };
            let v3 = 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::agents(arg2);
            let v4 = false;
            while (0x1::vector::length<address>(&v3) > 0) {
                let v5 = 0x1::vector::pop_back<address>(&mut v3);
                if (0x1::vector::contains<address>(&v2.export_auths, &v5) && 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::can_act_as_address<WITHDRAW>(v5, arg2)) {
                    v4 = true;
                    break
                };
            };
            v4 && 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::ownership::can_act_as_owner<WITHDRAW>(&arg0.id, arg2)
        } else {
            0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::ownership::can_act_as_owner<WITHDRAW>(&arg0.id, arg2)
        }
    }

    public fun is_valid_transfer<T0>(arg0: &Coin23<T0>, arg1: &CurrencyRegistry, arg2: &0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::TxAuthority) : bool {
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&arg1.id, v0)) {
            let v2 = 0x2::dynamic_field::borrow<0x1::type_name::TypeName, CurrencyControls<T0>>(&arg1.id, v0);
            v2.user_transfer_enum > 0 && 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::ownership::can_act_as_owner<WITHDRAW>(&arg0.id, arg2) || v2.creator_can_withdraw && 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::can_act_as_package<T0, WITHDRAW>(arg2)
        } else {
            0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::ownership::can_act_as_owner<WITHDRAW>(&arg0.id, arg2)
        }
    }

    public fun merchants_with_held_funds<T0>(arg0: &Coin23<T0>) : vector<address> {
        0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::linked_table2::keys<address, Hold<T0>>(&arg0.held_funds)
    }

    public fun merchants_with_rebills<T0>(arg0: &Coin23<T0>) : vector<address> {
        0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::linked_table2::keys<address, vector<Rebill>>(&arg0.rebills)
    }

    fun pay_transfer_fee<T0>(arg0: &mut Coin23<T0>, arg1: u64, arg2: &CurrencyRegistry, arg3: &mut 0x2::tx_context::TxContext) : u64 {
        let (v0, v1) = calculate_transfer_fee<T0>(arg1, arg2);
        let v2 = v1;
        if (v0 > 0 && 0x1::option::is_some<address>(&v2)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.available, v0), arg3), 0x1::option::destroy_some<address>(v2));
        };
        v0
    }

    public fun rebills_for_merchant<T0>(arg0: &Coin23<T0>, arg1: address) : &vector<Rebill> {
        0x2::linked_table::borrow<address, vector<Rebill>>(&arg0.rebills, arg1)
    }

    public fun register_currency<T0: drop>(arg0: &mut CurrencyRegistry, arg1: bool, arg2: bool, arg3: u8, arg4: 0x1::option::Option<u64>, arg5: 0x1::option::Option<address>, arg6: vector<address>, arg7: &0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::TxAuthority) {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::can_act_as_package<T0, 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action::ADMIN>(arg7), 1);
        assert!(!0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&arg0.id, v0), 11);
        let v1 = CurrencyControls<T0>{
            creator_can_withdraw : arg1,
            creator_can_freeze   : arg2,
            user_transfer_enum   : arg3,
            transfer_fee         : transfer_fee_struct(arg4, arg5),
            export_auths         : arg6,
        };
        0x2::dynamic_field::add<0x1::type_name::TypeName, CurrencyControls<T0>>(&mut arg0.id, v0, v1);
    }

    public fun release_held_funds<T0>(arg0: &mut Coin23<T0>, arg1: address, arg2: &0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::TxAuthority) {
        assert!(0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::can_act_as_address<MERCHANT>(arg1, arg2), 6);
        release_hold_internal<T0>(arg0, arg1);
    }

    fun release_hold_internal<T0>(arg0: &mut Coin23<T0>, arg1: address) {
        if (0x2::linked_table::contains<address, Hold<T0>>(&arg0.held_funds, arg1)) {
            let Hold {
                funds     : v0,
                expiry_ms : _,
            } = 0x2::linked_table::remove<address, Hold<T0>>(&mut arg0.held_funds, arg1);
            0x2::balance::join<T0>(&mut arg0.available, v0);
        };
    }

    public fun return_and_share<T0>(arg0: Coin23<T0>, arg1: address) {
        let v0 = Witness{dummy_field: false};
        let v1 = 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::begin_with_package_witness_<Witness>(v0);
        0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::ownership::as_shared_object_<Coin23<T0>>(&mut arg0.id, 0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::typed_id::new<Coin23<T0>>(&arg0), arg1, @0x0, &v1);
        0x2::transfer::share_object<Coin23<T0>>(arg0);
    }

    public fun set_transfer_fee<T0>(arg0: &mut CurrencyRegistry, arg1: 0x1::option::Option<u64>, arg2: 0x1::option::Option<address>, arg3: &0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::TxAuthority) {
        assert!(0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::can_act_as_package<T0, 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action::ADMIN>(arg3), 1);
        0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, CurrencyControls<T0>>(&mut arg0.id, 0x1::type_name::get<T0>()).transfer_fee = transfer_fee_struct(arg1, arg2);
    }

    public fun set_transfer_policy<T0>(arg0: &mut CurrencyRegistry, arg1: u8, arg2: vector<address>, arg3: &0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::TxAuthority) {
        assert!(0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::can_act_as_package<T0, 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action::ADMIN>(arg3), 1);
        let v0 = 0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, CurrencyControls<T0>>(&mut arg0.id, 0x1::type_name::get<T0>());
        v0.user_transfer_enum = arg1;
        v0.export_auths = arg2;
    }

    fun transfer_fee_struct(arg0: 0x1::option::Option<u64>, arg1: 0x1::option::Option<address>) : 0x1::option::Option<TransferFee> {
        if (0x1::option::is_some<u64>(&arg0) && 0x1::option::is_some<address>(&arg1)) {
            assert!(*0x1::option::borrow<u64>(&arg0) > 0, 10);
            let v1 = TransferFee{
                bps    : 0x1::option::destroy_some<u64>(arg0),
                pay_to : 0x1::option::destroy_some<address>(arg1),
            };
            0x1::option::some<TransferFee>(v1)
        } else {
            0x1::option::none<TransferFee>()
        }
    }

    public fun uid<T0>(arg0: &Coin23<T0>) : &0x2::object::UID {
        &arg0.id
    }

    public fun uid_mut<T0>(arg0: &mut Coin23<T0>) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public fun unfreeze<T0>(arg0: &mut Coin23<T0>, arg1: &0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::TxAuthority) {
        assert!(0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::can_act_as_package<T0, FREEZE>(arg1), 1);
        arg0.frozen = false;
    }

    public fun withdraw_from_held_funds<T0>(arg0: &mut Coin23<T0>, arg1: &mut Coin23<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &CurrencyRegistry, arg5: &0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::TxAuthority, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::option::destroy_some<address>(0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::ownership::get_owner(&arg1.id));
        withdraw_from_held_funds_<T0>(arg0, arg1, v0, arg2, arg3, arg4, arg5, arg6);
    }

    public fun withdraw_from_held_funds_<T0>(arg0: &mut Coin23<T0>, arg1: &mut Coin23<T0>, arg2: address, arg3: u64, arg4: &0x2::clock::Clock, arg5: &CurrencyRegistry, arg6: &0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::TxAuthority, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::can_act_as_address<MERCHANT>(arg2, arg6), 6);
        assert!(!arg1.frozen, 3);
        let v0 = pay_transfer_fee<T0>(arg0, arg3, arg5, arg7);
        let v1 = 0x2::linked_table::borrow_mut<address, Hold<T0>>(&mut arg0.held_funds, arg2);
        assert!(v1.expiry_ms >= 0x2::clock::timestamp_ms(arg4), 9);
        0x2::balance::join<T0>(&mut arg1.available, 0x2::balance::split<T0>(&mut v1.funds, arg3 - v0));
        if (0x2::balance::value<T0>(&v1.funds) == 0) {
            release_hold_internal<T0>(arg0, arg2);
        };
    }

    public fun withdraw_with_rebill<T0>(arg0: &mut Coin23<T0>, arg1: &mut Coin23<T0>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &CurrencyRegistry, arg6: &0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::TxAuthority, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::option::destroy_some<address>(0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::ownership::get_owner(&arg1.id));
        assert!(0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::can_act_as_address<MERCHANT>(v0, arg6), 6);
        assert!(is_currency_transferable<T0>(arg5), 7);
        assert!(!arg0.frozen && !arg1.frozen, 3);
        let v1 = 0x1::vector::borrow_mut<Rebill>(0x2::linked_table::borrow_mut<address, vector<Rebill>>(&mut arg0.rebills, v0), arg2);
        crank_rebill(v1, arg4);
        v1.available = v1.available - arg3;
        let v2 = pay_transfer_fee<T0>(arg0, arg3, arg5, arg7);
        0x2::balance::join<T0>(&mut arg1.available, 0x2::balance::split<T0>(&mut arg0.available, arg3 - v2));
    }

    // decompiled from Move bytecode v6
}

