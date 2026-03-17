module 0x3ea8086d86d553af887e758efe2fc67554ee599b9428a9e26312881a7a26b007::liquidator {
    struct LIQUIDATOR has drop {
        dummy_field: bool,
    }

    struct LiquidatorAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Liquidator has store, key {
        id: 0x2::object::UID,
        package_caller_cap: 0x1::option::Option<0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::app::PackageCallerCap>,
        whitelist: 0x2::vec_set::VecSet<address>,
        recipient: 0x1::option::Option<address>,
        slippage_tolerance_bps: u32,
        package_whitelist: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
    }

    struct LiquidatorUpdated has copy, drop {
        who: address,
        is_remove: bool,
    }

    public(friend) fun borrow_package_caller_cap(arg0: &Liquidator) : &0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::app::PackageCallerCap {
        0x1::option::borrow<0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::app::PackageCallerCap>(&arg0.package_caller_cap)
    }

    public(friend) fun ensure_caller_whitelisted(arg0: &Liquidator, arg1: address) {
        assert!(0x2::vec_set::contains<address>(&arg0.whitelist, &arg1), 0x3ea8086d86d553af887e758efe2fc67554ee599b9428a9e26312881a7a26b007::error::not_whitelisted());
    }

    public fun get_recipient(arg0: &Liquidator) : address {
        *0x1::option::borrow<address>(&arg0.recipient)
    }

    fun init(arg0: LIQUIDATOR, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<LIQUIDATOR>(arg0, arg1);
        let v0 = LiquidatorAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<LiquidatorAdminCap>(v0, 0x2::tx_context::sender(arg1));
        let v1 = Liquidator{
            id                     : 0x2::object::new(arg1),
            package_caller_cap     : 0x1::option::none<0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::app::PackageCallerCap>(),
            whitelist              : 0x2::vec_set::empty<address>(),
            recipient              : 0x1::option::none<address>(),
            slippage_tolerance_bps : 200,
            package_whitelist      : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
        };
        0x2::transfer::public_share_object<Liquidator>(v1);
    }

    public(friend) fun is_package_whitelisted<T0: drop>(arg0: &Liquidator) : bool {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.package_whitelist, &v0)
    }

    public fun is_whitelisted(arg0: &Liquidator, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.whitelist, &arg1)
    }

    public fun populate_package_caller_cap(arg0: &LiquidatorAdminCap, arg1: &mut 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::app::ProtocolApp, arg2: &mut Liquidator, arg3: 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::app::PackageCallerCap) {
        if (0x1::option::is_some<0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::app::PackageCallerCap>(&arg2.package_caller_cap)) {
            0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::whitelist_admin::burn_whitelist(arg1, 0x1::option::extract<0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::app::PackageCallerCap>(&mut arg2.package_caller_cap));
        };
        0x1::option::fill<0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::app::PackageCallerCap>(&mut arg2.package_caller_cap, arg3);
    }

    public fun slippage_tolerance_bps(arg0: &Liquidator) : u32 {
        arg0.slippage_tolerance_bps
    }

    public(friend) fun transfer_to_recipient<T0>(arg0: &Liquidator, arg1: 0x2::coin::Coin<T0>) {
        if (0x2::coin::value<T0>(&arg1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, *0x1::option::borrow<address>(&arg0.recipient));
        } else {
            0x2::coin::destroy_zero<T0>(arg1);
        };
    }

    public fun update_package_whitelist<T0: drop>(arg0: &LiquidatorAdminCap, arg1: &mut Liquidator, arg2: bool) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (arg2) {
            0x2::vec_set::remove<0x1::type_name::TypeName>(&mut arg1.package_whitelist, &v0);
        } else {
            0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg1.package_whitelist, v0);
        };
    }

    public fun update_recipient(arg0: &LiquidatorAdminCap, arg1: &mut Liquidator, arg2: address) {
        arg1.recipient = 0x1::option::some<address>(arg2);
    }

    public fun update_slippage_tolerance(arg0: &LiquidatorAdminCap, arg1: &mut Liquidator, arg2: u32) {
        assert!(arg2 <= 10000, 0x3ea8086d86d553af887e758efe2fc67554ee599b9428a9e26312881a7a26b007::error::invalid_slippage());
        arg1.slippage_tolerance_bps = arg2;
    }

    public fun update_whitelist(arg0: &LiquidatorAdminCap, arg1: &mut Liquidator, arg2: address, arg3: bool) {
        if (arg3) {
            0x2::vec_set::remove<address>(&mut arg1.whitelist, &arg2);
        } else {
            0x2::vec_set::insert<address>(&mut arg1.whitelist, arg2);
        };
        let v0 = LiquidatorUpdated{
            who       : arg2,
            is_remove : arg3,
        };
        0x2::event::emit<LiquidatorUpdated>(v0);
    }

    public fun whitelisted(arg0: &Liquidator) : vector<address> {
        0x2::vec_set::into_keys<address>(arg0.whitelist)
    }

    // decompiled from Move bytecode v6
}

