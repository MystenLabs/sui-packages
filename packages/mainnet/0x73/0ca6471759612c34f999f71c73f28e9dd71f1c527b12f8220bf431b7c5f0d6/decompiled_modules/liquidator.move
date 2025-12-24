module 0x27f1af3cd6ad85388a8414e16c9c31c1a17b484048844c4b7428d18d972844d0::liquidator {
    struct LIQUIDATOR has drop {
        dummy_field: bool,
    }

    struct LiquidatorAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Liquidator has store, key {
        id: 0x2::object::UID,
        package_caller_cap: 0x1::option::Option<0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::app::PackageCallerCap>,
        whitelist: 0x2::vec_set::VecSet<address>,
        recipient: 0x1::option::Option<address>,
    }

    public(friend) fun borrow_package_caller_cap(arg0: &Liquidator) : &0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::app::PackageCallerCap {
        0x1::option::borrow<0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::app::PackageCallerCap>(&arg0.package_caller_cap)
    }

    public(friend) fun ensure_caller_whitelisted(arg0: &Liquidator, arg1: address) {
        assert!(0x2::vec_set::contains<address>(&arg0.whitelist, &arg1), 0);
    }

    public fun get_recipient(arg0: &Liquidator) : address {
        *0x1::option::borrow<address>(&arg0.recipient)
    }

    fun init(arg0: LIQUIDATOR, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<LIQUIDATOR>(arg0, arg1);
        let v0 = LiquidatorAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<LiquidatorAdminCap>(v0, 0x2::tx_context::sender(arg1));
        let v1 = Liquidator{
            id                 : 0x2::object::new(arg1),
            package_caller_cap : 0x1::option::none<0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::app::PackageCallerCap>(),
            whitelist          : 0x2::vec_set::empty<address>(),
            recipient          : 0x1::option::none<address>(),
        };
        0x2::transfer::public_share_object<Liquidator>(v1);
    }

    public fun is_whitelisted(arg0: &Liquidator, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.whitelist, &arg1)
    }

    public fun populate_package_caller_cap(arg0: &LiquidatorAdminCap, arg1: &mut 0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::app::ProtocolApp, arg2: &mut Liquidator, arg3: 0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::app::PackageCallerCap) {
        if (0x1::option::is_some<0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::app::PackageCallerCap>(&arg2.package_caller_cap)) {
            0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::whitelist_admin::burn_whitelist(arg1, 0x1::option::extract<0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::app::PackageCallerCap>(&mut arg2.package_caller_cap));
        };
        0x1::option::fill<0xecae6de3e13c04e3168806456b356b87a3a33ce11a7cdd8e265e1113316c6b2::app::PackageCallerCap>(&mut arg2.package_caller_cap, arg3);
    }

    public(friend) fun transfer_to_recipient<T0>(arg0: &Liquidator, arg1: 0x2::coin::Coin<T0>) {
        if (0x2::coin::value<T0>(&arg1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, *0x1::option::borrow<address>(&arg0.recipient));
        } else {
            0x2::coin::destroy_zero<T0>(arg1);
        };
    }

    public fun update_recipient(arg0: &LiquidatorAdminCap, arg1: &mut Liquidator, arg2: address) {
        arg1.recipient = 0x1::option::some<address>(arg2);
    }

    public fun update_whitelist(arg0: &LiquidatorAdminCap, arg1: &mut Liquidator, arg2: address, arg3: bool) {
        if (arg3) {
            0x2::vec_set::remove<address>(&mut arg1.whitelist, &arg2);
        } else {
            0x2::vec_set::insert<address>(&mut arg1.whitelist, arg2);
        };
    }

    public fun whitelisted(arg0: &Liquidator) : vector<address> {
        0x2::vec_set::into_keys<address>(arg0.whitelist)
    }

    // decompiled from Move bytecode v6
}

