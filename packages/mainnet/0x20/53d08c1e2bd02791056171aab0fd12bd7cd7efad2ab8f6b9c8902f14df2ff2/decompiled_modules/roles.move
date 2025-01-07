module 0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::roles {
    struct Roles has store {
        data: 0x2::bag::Bag,
        admin_count: u8,
    }

    struct Role<phantom T0> has copy, drop, store {
        addr: address,
    }

    struct Pause<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct AdminRole has drop {
        dummy_field: bool,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : Roles {
        Roles{
            data        : 0x2::bag::new(arg0),
            admin_count : 0,
        }
    }

    public(friend) fun addr<T0: drop>(arg0: &Role<T0>) : address {
        arg0.addr
    }

    public(friend) fun admin_count(arg0: &Roles) : u8 {
        arg0.admin_count
    }

    public(friend) fun assert_is_authorized<T0: drop>(arg0: &Roles, arg1: address) {
        assert!(is_authorized<T0>(arg0, arg1), 3);
    }

    public(friend) fun assert_is_not_paused<T0: drop>(arg0: &Roles) {
        assert!(!is_paused<T0>(arg0), 4);
    }

    public(friend) fun authorize<T0: drop, T1: drop + store>(arg0: &mut Roles, arg1: Role<T0>, arg2: T1) {
        assert!(!0x2::bag::contains<Role<T0>>(&arg0.data, arg1), 2);
        if (0x1::type_name::get<T0>() == 0x1::type_name::get<AdminRole>()) {
            arg0.admin_count = arg0.admin_count + 1;
        };
        0x2::bag::add<Role<T0>, T1>(&mut arg0.data, arg1, arg2);
    }

    public(friend) fun config<T0: drop, T1: drop + store>(arg0: &Roles, arg1: address) : &T1 {
        let v0 = Role<T0>{addr: arg1};
        0x2::bag::borrow<Role<T0>, T1>(&arg0.data, v0)
    }

    public(friend) fun config_mut<T0: drop, T1: drop + store>(arg0: &mut Roles, arg1: address) : &mut T1 {
        let v0 = Role<T0>{addr: arg1};
        0x2::bag::borrow_mut<Role<T0>, T1>(&mut arg0.data, v0)
    }

    public(friend) fun data(arg0: &Roles) : &0x2::bag::Bag {
        &arg0.data
    }

    public(friend) fun deauthorize<T0: drop, T1: drop + store>(arg0: &mut Roles, arg1: Role<T0>) : T1 {
        assert!(0x2::bag::contains_with_type<Role<T0>, T1>(&arg0.data, arg1), 7);
        if (0x1::type_name::get<T0>() == 0x1::type_name::get<AdminRole>()) {
            arg0.admin_count = arg0.admin_count - 1;
            assert!(arg0.admin_count > 0, 1);
        };
        0x2::bag::remove<Role<T0>, T1>(&mut arg0.data, arg1)
    }

    public(friend) fun is_authorized<T0: drop>(arg0: &Roles, arg1: address) : bool {
        let v0 = Role<T0>{addr: arg1};
        0x2::bag::contains<Role<T0>>(&arg0.data, v0)
    }

    public(friend) fun is_paused<T0: drop>(arg0: &Roles) : bool {
        let v0 = Pause<T0>{dummy_field: false};
        0x2::bag::contains<Pause<T0>>(&arg0.data, v0)
    }

    public(friend) fun new_role<T0: drop>(arg0: address) : Role<T0> {
        Role<T0>{addr: arg0}
    }

    public(friend) fun pause<T0: drop>(arg0: &mut Roles) {
        assert!(!is_paused<T0>(arg0), 5);
        let v0 = Pause<T0>{dummy_field: false};
        0x2::bag::add<Pause<T0>, bool>(&mut arg0.data, v0, true);
    }

    public(friend) fun unpause<T0: drop>(arg0: &mut Roles) {
        assert!(is_paused<T0>(arg0), 6);
        let v0 = Pause<T0>{dummy_field: false};
        0x2::bag::remove<Pause<T0>, bool>(&mut arg0.data, v0);
    }

    // decompiled from Move bytecode v6
}

