module 0x506a6fc25f1c7d52ceb06ea44a3114c9380f8e2029b4356019822f248b49e411::roles {
    struct Roles has store {
        data: 0x2::bag::Bag,
    }

    struct Role<phantom T0> has copy, drop, store {
        addr: address,
    }

    struct ApiRole {
        dummy_field: bool,
    }

    public(friend) fun destroy_empty(arg0: Roles) {
        let Roles { data: v0 } = arg0;
        0x2::bag::destroy_empty(v0);
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : Roles {
        Roles{data: 0x2::bag::new(arg0)}
    }

    public(friend) fun addr<T0>(arg0: &Role<T0>) : address {
        arg0.addr
    }

    public(friend) fun assert_has_role<T0>(arg0: &Roles, arg1: address) {
        assert!(is_authorized<T0>(arg0, arg1), 3);
    }

    public(friend) fun assert_publisher_from_package(arg0: &0x2::package::Publisher) {
        assert!(0x2::package::from_package<0x506a6fc25f1c7d52ceb06ea44a3114c9380f8e2029b4356019822f248b49e411::memefi::MEMEFI>(arg0), 5);
    }

    public(friend) fun authorize<T0>(arg0: &mut Roles, arg1: Role<T0>) {
        assert!(!0x2::bag::contains<Role<T0>>(&arg0.data, arg1), 2);
        0x2::bag::add<Role<T0>, bool>(&mut arg0.data, arg1, true);
    }

    public(friend) fun config<T0, T1: drop + store>(arg0: &Roles, arg1: address) : &T1 {
        let v0 = Role<T0>{addr: arg1};
        0x2::bag::borrow<Role<T0>, T1>(&arg0.data, v0)
    }

    public(friend) fun data(arg0: &Roles) : &0x2::bag::Bag {
        &arg0.data
    }

    public(friend) fun deauthorize<T0>(arg0: &mut Roles, arg1: Role<T0>) : bool {
        assert!(0x2::bag::contains<Role<T0>>(&arg0.data, arg1), 4);
        0x2::bag::remove<Role<T0>, bool>(&mut arg0.data, arg1)
    }

    public(friend) fun is_authorized<T0>(arg0: &Roles, arg1: address) : bool {
        let v0 = Role<T0>{addr: arg1};
        0x2::bag::contains<Role<T0>>(&arg0.data, v0)
    }

    public(friend) fun new_role<T0>(arg0: address) : Role<T0> {
        Role<T0>{addr: arg0}
    }

    // decompiled from Move bytecode v6
}

