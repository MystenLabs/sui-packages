module 0xa5c82ada6976597076d2ef0c8a4fb18b84ea40b6b8d3c30f49b4c27f6e022c1e::referral_bindings {
    struct ReferralBindings has key {
        id: 0x2::object::UID,
        ve_sca_binding: 0x2::table::Table<address, 0x2::object::ID>,
    }

    public fun bind_ve_sca_referrer(arg0: &mut ReferralBindings, arg1: 0x2::object::ID, arg2: &0xb15b6e0cdd85afb5028bea851dd249405e734d800a259147bbc24980629723a4::ve_sca::VeScaTable, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(has_ve_sca_binding(arg0, v0) == false, 405);
        0xb15b6e0cdd85afb5028bea851dd249405e734d800a259147bbc24980629723a4::ve_sca::ve_sca_amount(arg1, arg2, arg3);
        0x2::table::add<address, 0x2::object::ID>(&mut arg0.ve_sca_binding, v0, arg1);
    }

    public fun get_binding(arg0: &ReferralBindings, arg1: address) : 0x1::option::Option<0x2::object::ID> {
        if (0x2::table::contains<address, 0x2::object::ID>(&arg0.ve_sca_binding, arg1)) {
            0x1::option::some<0x2::object::ID>(*0x2::table::borrow<address, 0x2::object::ID>(&arg0.ve_sca_binding, arg1))
        } else {
            0x1::option::none<0x2::object::ID>()
        }
    }

    public fun has_ve_sca_binding(arg0: &ReferralBindings, arg1: address) : bool {
        0x2::table::contains<address, 0x2::object::ID>(&arg0.ve_sca_binding, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ReferralBindings{
            id             : 0x2::object::new(arg0),
            ve_sca_binding : 0x2::table::new<address, 0x2::object::ID>(arg0),
        };
        0x2::transfer::share_object<ReferralBindings>(v0);
    }

    public fun is_binded_to_the_given_referrer_ve_sca(arg0: &ReferralBindings, arg1: 0x2::object::ID, arg2: address) : bool {
        if (0x2::table::contains<address, 0x2::object::ID>(&arg0.ve_sca_binding, arg2)) {
            return *0x2::table::borrow<address, 0x2::object::ID>(&arg0.ve_sca_binding, arg2) == arg1
        };
        false
    }

    // decompiled from Move bytecode v6
}

