module 0x9c1551e7ce50216bda02913487ab76037d2e9236cc3bac007d15f1e86868b629::deepbookv3 {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct DeepbookV3Config has store, key {
        id: 0x2::object::UID,
        is_alternative_payment: bool,
        deep_fee_vault: 0x2::balance::Balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>,
        whitelist: 0x2::table::Table<0x2::object::ID, bool>,
    }

    struct InitDeepbookV3Event has copy, drop {
        admin_cap_id: 0x2::object::ID,
        deepbook_v3_config_id: 0x2::object::ID,
    }

    struct DeepbookV3SwapEvent has copy, drop, store {
        pool: 0x2::object::ID,
        amount_in: u64,
        amount_out: u64,
        a2b: bool,
        by_amount_in: bool,
        deep_fee: u64,
        alt_payment_deep_fee: u64,
        coin_a: 0x1::type_name::TypeName,
        coin_b: 0x1::type_name::TypeName,
    }

    public fun add_whitelist(arg0: &AdminCap, arg1: &mut DeepbookV3Config, arg2: 0x2::object::ID, arg3: bool) {
        abort 0
    }

    public(friend) fun alternative_payment_deep(arg0: &mut DeepbookV3Config, arg1: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP> {
        abort 0
    }

    public fun deposit_deep_fee(arg0: &mut DeepbookV3Config, arg1: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>) {
        abort 0
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = DeepbookV3Config{
            id                     : 0x2::object::new(arg0),
            is_alternative_payment : true,
            deep_fee_vault         : 0x2::balance::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(),
            whitelist              : 0x2::table::new<0x2::object::ID, bool>(arg0),
        };
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<DeepbookV3Config>(v0);
        let v2 = InitDeepbookV3Event{
            admin_cap_id          : 0x2::object::id<AdminCap>(&v1),
            deepbook_v3_config_id : 0x2::object::id<DeepbookV3Config>(&v0),
        };
        0x2::event::emit<InitDeepbookV3Event>(v2);
    }

    public fun is_alternative_payment(arg0: &DeepbookV3Config) : bool {
        abort 0
    }

    public(friend) fun is_whitelisted(arg0: &DeepbookV3Config, arg1: 0x2::object::ID) : bool {
        abort 0
    }

    public fun remove_whitelist(arg0: &AdminCap, arg1: &mut DeepbookV3Config, arg2: 0x2::object::ID) {
        abort 0
    }

    public fun set_alternative_payment(arg0: &AdminCap, arg1: &mut DeepbookV3Config, arg2: bool) {
        abort 0
    }

    public fun swap_a2b<T0, T1>(arg0: &mut DeepbookV3Config, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        abort 0
    }

    public fun swap_b2a<T0, T1>(arg0: &mut DeepbookV3Config, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        abort 0
    }

    public fun withdraw_deep_fee(arg0: &mut DeepbookV3Config, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP> {
        abort 0
    }

    // decompiled from Move bytecode v6
}

