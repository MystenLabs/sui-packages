module 0x4a101d25cb12cc52aedd2558f7732177910b8a7aadc48b59392a586aebbc1738::deepbookv3 {
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
        0x2::table::add<0x2::object::ID, bool>(&mut arg1.whitelist, arg2, arg3);
    }

    public(friend) fun alternative_payment_deep(arg0: &mut DeepbookV3Config, arg1: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP> {
        assert!(is_alternative_payment(arg0), 1);
        assert!(0x2::balance::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&arg0.deep_fee_vault) >= arg2, 0);
        let v0 = 0x2::coin::into_balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg1);
        0x2::balance::join<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&mut v0, 0x2::balance::split<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&mut arg0.deep_fee_vault, arg2));
        0x2::coin::from_balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v0, arg3)
    }

    public fun deposit_deep_fee(arg0: &mut DeepbookV3Config, arg1: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>) {
        0x2::balance::join<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&mut arg0.deep_fee_vault, 0x2::coin::into_balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg1));
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
    }

    public fun is_alternative_payment(arg0: &DeepbookV3Config) : bool {
        arg0.is_alternative_payment
    }

    public(friend) fun is_whitelisted(arg0: &DeepbookV3Config, arg1: 0x2::object::ID) : bool {
        0x2::table::contains<0x2::object::ID, bool>(&arg0.whitelist, arg1)
    }

    public fun remove_whitelist(arg0: &AdminCap, arg1: &mut DeepbookV3Config, arg2: 0x2::object::ID) {
        if (!is_whitelisted(arg1, arg2)) {
            return
        };
        0x2::table::remove<0x2::object::ID, bool>(&mut arg1.whitelist, arg2);
    }

    public fun set_alternative_payment(arg0: &AdminCap, arg1: &mut DeepbookV3Config, arg2: bool) {
        arg1.is_alternative_payment = arg2;
    }

    public fun withdraw_deep_fee(arg0: &mut DeepbookV3Config, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP> {
        0x2::coin::from_balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(0x2::balance::split<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&mut arg0.deep_fee_vault, arg1), arg2)
    }

    // decompiled from Move bytecode v6
}

