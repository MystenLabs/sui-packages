module 0x9aa6d749c6ee26481c088bf61871b84c1d3320504023019cbea0d773a6047ac7::launchpad_slingshot {
    struct Slingshot<phantom T0: store + key, T1: store> has store, key {
        id: 0x2::object::UID,
        admin: address,
        live: bool,
        market_fee: u64,
        sales: 0x2::object_table::ObjectTable<0x2::object::ID, 0x9aa6d749c6ee26481c088bf61871b84c1d3320504023019cbea0d773a6047ac7::launchpad_sale::Sale<T0, T1>>,
    }

    public fun add_multi_sales<T0: store + key, T1: store>(arg0: &mut Slingshot<T0, T1>, arg1: vector<0x9aa6d749c6ee26481c088bf61871b84c1d3320504023019cbea0d773a6047ac7::launchpad_sale::Sale<T0, T1>>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg2), 0);
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x9aa6d749c6ee26481c088bf61871b84c1d3320504023019cbea0d773a6047ac7::launchpad_sale::Sale<T0, T1>>(&arg1)) {
            let v2 = 0x1::vector::pop_back<0x9aa6d749c6ee26481c088bf61871b84c1d3320504023019cbea0d773a6047ac7::launchpad_sale::Sale<T0, T1>>(&mut arg1);
            let v3 = 0x2::object::id<0x9aa6d749c6ee26481c088bf61871b84c1d3320504023019cbea0d773a6047ac7::launchpad_sale::Sale<T0, T1>>(&v2);
            0x1::vector::push_back<0x2::object::ID>(&mut v0, v3);
            0x2::object_table::add<0x2::object::ID, 0x9aa6d749c6ee26481c088bf61871b84c1d3320504023019cbea0d773a6047ac7::launchpad_sale::Sale<T0, T1>>(&mut arg0.sales, v3, v2);
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<0x9aa6d749c6ee26481c088bf61871b84c1d3320504023019cbea0d773a6047ac7::launchpad_sale::Sale<T0, T1>>(arg1);
    }

    public fun borrow_admin<T0: store + key, T1: store>(arg0: &Slingshot<T0, T1>) : address {
        arg0.admin
    }

    public fun borrow_live<T0: store + key, T1: store>(arg0: &Slingshot<T0, T1>) : bool {
        arg0.live
    }

    public fun borrow_market_fee<T0: store + key, T1: store>(arg0: &Slingshot<T0, T1>) : u64 {
        arg0.market_fee
    }

    public(friend) fun borrow_mut_sales<T0: store + key, T1: store>(arg0: &mut Slingshot<T0, T1>, arg1: 0x2::object::ID) : &mut 0x9aa6d749c6ee26481c088bf61871b84c1d3320504023019cbea0d773a6047ac7::launchpad_sale::Sale<T0, T1> {
        0x2::object_table::borrow_mut<0x2::object::ID, 0x9aa6d749c6ee26481c088bf61871b84c1d3320504023019cbea0d773a6047ac7::launchpad_sale::Sale<T0, T1>>(&mut arg0.sales, arg1)
    }

    public fun borrow_sales<T0: store + key, T1: store>(arg0: &Slingshot<T0, T1>, arg1: 0x2::object::ID) : &0x9aa6d749c6ee26481c088bf61871b84c1d3320504023019cbea0d773a6047ac7::launchpad_sale::Sale<T0, T1> {
        0x2::object_table::borrow<0x2::object::ID, 0x9aa6d749c6ee26481c088bf61871b84c1d3320504023019cbea0d773a6047ac7::launchpad_sale::Sale<T0, T1>>(&arg0.sales, arg1)
    }

    public(friend) fun create_slingshot<T0: store + key, T1: store>(arg0: address, arg1: bool, arg2: u64, arg3: vector<0x9aa6d749c6ee26481c088bf61871b84c1d3320504023019cbea0d773a6047ac7::launchpad_sale::Sale<T0, T1>>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = Slingshot<T0, T1>{
            id         : 0x2::object::new(arg4),
            admin      : arg0,
            live       : arg1,
            market_fee : arg2,
            sales      : 0x2::object_table::new<0x2::object::ID, 0x9aa6d749c6ee26481c088bf61871b84c1d3320504023019cbea0d773a6047ac7::launchpad_sale::Sale<T0, T1>>(arg4),
        };
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x9aa6d749c6ee26481c088bf61871b84c1d3320504023019cbea0d773a6047ac7::launchpad_sale::Sale<T0, T1>>(&arg3)) {
            let v2 = 0x1::vector::pop_back<0x9aa6d749c6ee26481c088bf61871b84c1d3320504023019cbea0d773a6047ac7::launchpad_sale::Sale<T0, T1>>(&mut arg3);
            0x2::object_table::add<0x2::object::ID, 0x9aa6d749c6ee26481c088bf61871b84c1d3320504023019cbea0d773a6047ac7::launchpad_sale::Sale<T0, T1>>(&mut v0.sales, 0x2::object::id<0x9aa6d749c6ee26481c088bf61871b84c1d3320504023019cbea0d773a6047ac7::launchpad_sale::Sale<T0, T1>>(&v2), v2);
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<0x9aa6d749c6ee26481c088bf61871b84c1d3320504023019cbea0d773a6047ac7::launchpad_sale::Sale<T0, T1>>(arg3);
        0x2::transfer::share_object<Slingshot<T0, T1>>(v0);
        0x2::object::id<Slingshot<T0, T1>>(&v0)
    }

    public fun modify_status<T0: store + key, T1: store>(arg0: &mut Slingshot<T0, T1>, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg2), 0);
        arg0.live = arg1;
    }

    public(friend) fun remove_sales<T0: store + key, T1: store>(arg0: &mut Slingshot<T0, T1>, arg1: 0x2::object::ID) : 0x9aa6d749c6ee26481c088bf61871b84c1d3320504023019cbea0d773a6047ac7::launchpad_sale::Sale<T0, T1> {
        0x2::object_table::remove<0x2::object::ID, 0x9aa6d749c6ee26481c088bf61871b84c1d3320504023019cbea0d773a6047ac7::launchpad_sale::Sale<T0, T1>>(&mut arg0.sales, arg1)
    }

    public fun update_admin<T0: store + key, T1: store>(arg0: &mut Slingshot<T0, T1>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg2), 0);
        arg0.admin = arg1;
    }

    // decompiled from Move bytecode v6
}

