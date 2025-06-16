module 0x7947fc620ee7a904b26f7687e9ee9a5a4a525e4a721a01890d7c3980d74e4735::admin_control {
    struct AdminControl<phantom T0> has key {
        id: 0x2::object::UID,
        manager_set: 0x2::vec_set::VecSet<address>,
        cap_referent: 0x2::borrow::Referent<0x2a721777dc1fcf7cda19492ad7c2272ee284214652bde3e9740e2f49c3bff457::sbuck_saving_vault::AdminCap>,
    }

    public fun borrow<T0>(arg0: &mut AdminControl<T0>, arg1: &0x2::tx_context::TxContext) : (0x2a721777dc1fcf7cda19492ad7c2272ee284214652bde3e9740e2f49c3bff457::sbuck_saving_vault::AdminCap, 0x2::borrow::Borrow) {
        assert_sender_is_manager<T0>(arg0, arg1);
        0x2::borrow::borrow<0x2a721777dc1fcf7cda19492ad7c2272ee284214652bde3e9740e2f49c3bff457::sbuck_saving_vault::AdminCap>(&mut arg0.cap_referent)
    }

    public fun destroy<T0>(arg0: AdminControl<T0>, arg1: &0x2a721777dc1fcf7cda19492ad7c2272ee284214652bde3e9740e2f49c3bff457::vault::AdminCap<T0>) : 0x2a721777dc1fcf7cda19492ad7c2272ee284214652bde3e9740e2f49c3bff457::sbuck_saving_vault::AdminCap {
        let AdminControl {
            id           : v0,
            manager_set  : _,
            cap_referent : v2,
        } = arg0;
        0x2::object::delete(v0);
        0x2::borrow::destroy<0x2a721777dc1fcf7cda19492ad7c2272ee284214652bde3e9740e2f49c3bff457::sbuck_saving_vault::AdminCap>(v2)
    }

    public fun put_back<T0>(arg0: &mut AdminControl<T0>, arg1: 0x2a721777dc1fcf7cda19492ad7c2272ee284214652bde3e9740e2f49c3bff457::sbuck_saving_vault::AdminCap, arg2: 0x2::borrow::Borrow) {
        0x2::borrow::put_back<0x2a721777dc1fcf7cda19492ad7c2272ee284214652bde3e9740e2f49c3bff457::sbuck_saving_vault::AdminCap>(&mut arg0.cap_referent, arg1, arg2);
    }

    public fun add_manager<T0>(arg0: &mut AdminControl<T0>, arg1: &0x2a721777dc1fcf7cda19492ad7c2272ee284214652bde3e9740e2f49c3bff457::vault::AdminCap<T0>, arg2: address) {
        0x2::vec_set::insert<address>(&mut arg0.manager_set, arg2);
    }

    fun assert_sender_is_manager<T0>(arg0: &AdminControl<T0>, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        if (!0x2::vec_set::contains<address>(&arg0.manager_set, &v0)) {
            err_sender_is_not_manager();
        };
    }

    public fun create<T0>(arg0: &0x2a721777dc1fcf7cda19492ad7c2272ee284214652bde3e9740e2f49c3bff457::vault::AdminCap<T0>, arg1: 0x2a721777dc1fcf7cda19492ad7c2272ee284214652bde3e9740e2f49c3bff457::sbuck_saving_vault::AdminCap, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminControl<T0>{
            id           : 0x2::object::new(arg3),
            manager_set  : 0x2::vec_set::from_keys<address>(arg2),
            cap_referent : 0x2::borrow::new<0x2a721777dc1fcf7cda19492ad7c2272ee284214652bde3e9740e2f49c3bff457::sbuck_saving_vault::AdminCap>(arg1, arg3),
        };
        0x2::transfer::share_object<AdminControl<T0>>(v0);
    }

    fun err_sender_is_not_manager() {
        abort 0
    }

    public fun remove_manager<T0>(arg0: &mut AdminControl<T0>, arg1: &0x2a721777dc1fcf7cda19492ad7c2272ee284214652bde3e9740e2f49c3bff457::vault::AdminCap<T0>, arg2: address) {
        0x2::vec_set::remove<address>(&mut arg0.manager_set, &arg2);
    }

    // decompiled from Move bytecode v6
}

