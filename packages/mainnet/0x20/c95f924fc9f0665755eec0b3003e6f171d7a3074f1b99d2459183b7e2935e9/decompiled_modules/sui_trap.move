module 0x20c95f924fc9f0665755eec0b3003e6f171d7a3074f1b99d2459183b7e2935e9::sui_trap {
    struct SUI_TRAP has drop {
        dummy_field: bool,
    }

    struct ApproveCap has store, key {
        id: 0x2::object::UID,
    }

    struct Container has key {
        id: 0x2::object::UID,
        held: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct DofShell has key {
        id: 0x2::object::UID,
    }

    struct OpaqueKey has copy, drop, store {
        dummy_field: bool,
    }

    struct CoinCage<phantom T0> has key {
        id: 0x2::object::UID,
        held: 0x2::balance::Balance<T0>,
    }

    struct TransferOpaqueRule has drop {
        dummy_field: bool,
    }

    struct TableShell has key {
        id: 0x2::object::UID,
        table: 0x2::table::Table<OpaqueKey, 0x2::balance::Balance<0x2::sui::SUI>>,
    }

    struct L3 has store {
        held: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct L2 has store {
        level3: L3,
    }

    struct L1 has key {
        id: 0x2::object::UID,
        level2: L2,
    }

    struct BagShell has key {
        id: 0x2::object::UID,
        contents: 0x2::bag::Bag,
    }

    public fun add_opaque_approval<T0>(arg0: &ApproveCap, arg1: &mut 0x2::token::ActionRequest<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = TransferOpaqueRule{dummy_field: false};
        0x2::token::add_approval<T0, TransferOpaqueRule>(v0, arg1, arg2);
    }

    public entry fun always_abort() {
        abort 13897264295718158337
    }

    public entry fun div_zero_abort() {
    }

    fun init(arg0: SUI_TRAP, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::types::is_one_time_witness<SUI_TRAP>(&arg0), 0);
        let v0 = ApproveCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<ApproveCap>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun park_bag_and_send(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bag::new(arg2);
        let v1 = OpaqueKey{dummy_field: false};
        0x2::bag::add<OpaqueKey, 0x2::balance::Balance<0x2::sui::SUI>>(&mut v0, v1, 0x2::coin::into_balance<0x2::sui::SUI>(arg0));
        let v2 = BagShell{
            id       : 0x2::object::new(arg2),
            contents : v0,
        };
        0x2::transfer::transfer<BagShell>(v2, arg1);
    }

    public entry fun park_dof_and_send(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = DofShell{id: 0x2::object::new(arg2)};
        let v1 = OpaqueKey{dummy_field: false};
        0x2::dynamic_field::add<OpaqueKey, 0x2::balance::Balance<0x2::sui::SUI>>(&mut v0.id, v1, 0x2::coin::into_balance<0x2::sui::SUI>(arg0));
        0x2::transfer::transfer<DofShell>(v0, arg1);
    }

    public entry fun park_table_and_send(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::table::new<OpaqueKey, 0x2::balance::Balance<0x2::sui::SUI>>(arg2);
        let v1 = OpaqueKey{dummy_field: false};
        0x2::table::add<OpaqueKey, 0x2::balance::Balance<0x2::sui::SUI>>(&mut v0, v1, 0x2::coin::into_balance<0x2::sui::SUI>(arg0));
        let v2 = TableShell{
            id    : 0x2::object::new(arg2),
            table : v0,
        };
        0x2::transfer::transfer<TableShell>(v2, arg1);
    }

    public fun policy_add_opaque_transfer_rule<T0>(arg0: &mut 0x2::token::TokenPolicy<T0>, arg1: &0x2::token::TokenPolicyCap<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::token::add_rule_for_action<T0, TransferOpaqueRule>(arg0, arg1, 0x1::string::utf8(b"transfer"), arg2);
    }

    public entry fun wrap_3_levels_and_send(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = L3{held: 0x2::coin::into_balance<0x2::sui::SUI>(arg0)};
        let v1 = L2{level3: v0};
        let v2 = L1{
            id     : 0x2::object::new(arg2),
            level2 : v1,
        };
        0x2::transfer::transfer<L1>(v2, arg1);
    }

    public entry fun wrap_and_send(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Container{
            id   : 0x2::object::new(arg2),
            held : 0x2::coin::into_balance<0x2::sui::SUI>(arg0),
        };
        0x2::transfer::transfer<Container>(v0, arg1);
    }

    public entry fun wrap_any_and_send<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = CoinCage<T0>{
            id   : 0x2::object::new(arg2),
            held : 0x2::coin::into_balance<T0>(arg0),
        };
        0x2::transfer::transfer<CoinCage<T0>>(v0, arg1);
    }

    // decompiled from Move bytecode v7
}

