module 0x94e8cb8df7796c7ea57f747f330ef61aedd8f48d48f7ac21bc975708a6ca6a1a::roles {
    struct AdminRole has drop {
        dummy_field: bool,
    }

    struct Roles has store {
        data: 0x2::bag::Bag,
        admin_count: u64,
    }

    struct Role<phantom T0> has copy, drop, store {
        addr: address,
    }

    struct Pause<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    public(friend) fun contains<T0: drop, T1: drop + store>(arg0: &Roles, arg1: address) : bool {
        let v0 = Role<T0>{addr: arg1};
        0x2::bag::contains_with_type<Role<T0>, T1>(&arg0.data, v0)
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

    public(friend) fun assert_is_authorized<T0: drop>(arg0: &Roles, arg1: address) {
        assert!(is_authorized<T0>(arg0, arg1), 13835621606531137539);
    }

    public(friend) fun assert_is_not_paused<T0: drop>(arg0: &Roles) {
        assert!(!is_paused<T0>(arg0), 13836466057231466505);
    }

    public(friend) fun authorize<T0: drop, T1: drop + store>(arg0: &mut Roles, arg1: address, arg2: T1) {
        let v0 = Role<T0>{addr: arg1};
        assert!(!0x2::bag::contains<Role<T0>>(&arg0.data, v0), 13835339860971356161);
        if (is_admin_role<T0>()) {
            arg0.admin_count = arg0.admin_count + 1;
        };
        0x2::bag::add<Role<T0>, T1>(&mut arg0.data, v0, arg2);
    }

    public(friend) fun config<T0: drop, T1: drop + store>(arg0: &Roles, arg1: address) : &T1 {
        let v0 = Role<T0>{addr: arg1};
        0x2::bag::borrow<Role<T0>, T1>(&arg0.data, v0)
    }

    public(friend) fun config_mut<T0: drop, T1: drop + store>(arg0: &mut Roles, arg1: address) : &mut T1 {
        let v0 = Role<T0>{addr: arg1};
        0x2::bag::borrow_mut<Role<T0>, T1>(&mut arg0.data, v0)
    }

    public(friend) fun deauthorize<T0: drop, T1: drop + store>(arg0: &mut Roles, arg1: address) {
        let v0 = Role<T0>{addr: arg1};
        assert!(0x2::bag::contains_with_type<Role<T0>, T1>(&arg0.data, v0), 13835902871054581765);
        if (is_admin_role<T0>()) {
            assert!(arg0.admin_count > 1, 13836184363211292679);
            arg0.admin_count = arg0.admin_count - 1;
        };
        0x2::bag::remove<Role<T0>, T1>(&mut arg0.data, v0);
    }

    fun is_admin_role<T0: drop>() : bool {
        0x1::type_name::with_defining_ids<AdminRole>() == 0x1::type_name::with_defining_ids<T0>()
    }

    public(friend) fun is_authorized<T0: drop>(arg0: &Roles, arg1: address) : bool {
        let v0 = Role<T0>{addr: arg1};
        0x2::bag::contains<Role<T0>>(&arg0.data, v0)
    }

    public(friend) fun is_paused<T0: drop>(arg0: &Roles) : bool {
        let v0 = Pause<T0>{dummy_field: false};
        0x2::bag::contains<Pause<T0>>(&arg0.data, v0)
    }

    public(friend) fun pause<T0: drop>(arg0: &mut Roles) {
        assert!(!is_paused<T0>(arg0), 13836747399064322059);
        let v0 = Pause<T0>{dummy_field: false};
        0x2::bag::add<Pause<T0>, bool>(&mut arg0.data, v0, true);
    }

    public(friend) fun unpause<T0: drop>(arg0: &mut Roles) {
        assert!(is_paused<T0>(arg0), 13837028904105934861);
        let v0 = Pause<T0>{dummy_field: false};
        0x2::bag::remove<Pause<T0>, bool>(&mut arg0.data, v0);
    }

    // decompiled from Move bytecode v6
}

