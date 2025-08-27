module 0x7812b83ddc7ce8620200583b49221dd47a94df60e09ec3e91a39457a834664bd::fee {
    struct FeeObject has key {
        id: 0x2::object::UID,
        admin: address,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public entry fun change_admin(arg0: &AdminCap, arg1: &mut FeeObject, arg2: address) {
        arg1.admin = arg2;
    }

    public entry fun collect_fees<T0>(arg0: &mut FeeObject, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 1);
        let v0 = 0x1::type_name::get<T0>();
        0x7812b83ddc7ce8620200583b49221dd47a94df60e09ec3e91a39457a834664bd::utils::send_coin<T0>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(0x2::dynamic_field::borrow_mut<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut arg0.id, 0x1::type_name::get_address(&v0))), arg1), 0x2::tx_context::sender(arg1));
    }

    public(friend) fun get_mut_fee_id(arg0: &mut FeeObject) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = FeeObject{
            id    : 0x2::object::new(arg0),
            admin : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<FeeObject>(v1);
    }

    // decompiled from Move bytecode v6
}

