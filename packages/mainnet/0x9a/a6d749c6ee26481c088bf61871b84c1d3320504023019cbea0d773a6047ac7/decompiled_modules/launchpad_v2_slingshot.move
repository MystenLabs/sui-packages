module 0x9aa6d749c6ee26481c088bf61871b84c1d3320504023019cbea0d773a6047ac7::launchpad_v2_slingshot {
    struct Slingshot has store, key {
        id: 0x2::object::UID,
        admin: address,
        live: bool,
        market_fee: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
        market_fee: u64,
    }

    struct LaunchpadCap<phantom T0: store + key> has key {
        id: 0x2::object::UID,
        market_fee: u64,
    }

    public fun add_multi_launchpad<T0: store + key>(arg0: &mut Slingshot, arg1: vector<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg2), 0);
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<T0>(&arg1)) {
            let v2 = 0x1::vector::pop_back<T0>(&mut arg1);
            let v3 = 0x2::object::id<T0>(&v2);
            0x1::vector::push_back<0x2::object::ID>(&mut v0, v3);
            0x2::dynamic_object_field::add<0x2::object::ID, T0>(&mut arg0.id, v3, v2);
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<T0>(arg1);
    }

    public fun borrow_admin(arg0: &Slingshot) : address {
        arg0.admin
    }

    public fun borrow_launchpad<T0: store + key>(arg0: &Slingshot, arg1: 0x2::object::ID) : &T0 {
        0x2::dynamic_object_field::borrow<0x2::object::ID, T0>(&arg0.id, arg1)
    }

    public fun borrow_live(arg0: &Slingshot) : bool {
        arg0.live
    }

    public fun borrow_market_fee(arg0: &Slingshot) : u64 {
        arg0.market_fee
    }

    public fun borrow_mut_launchpad<T0: store + key>(arg0: &mut Slingshot, arg1: 0x2::object::ID) : &mut T0 {
        0x2::dynamic_object_field::borrow_mut<0x2::object::ID, T0>(&mut arg0.id, arg1)
    }

    public fun create_slingshot<T0: store + key>(arg0: &LaunchpadCap<T0>, arg1: address, arg2: bool, arg3: vector<T0>, arg4: &mut 0x2::tx_context::TxContext) : (0x2::object::ID, u64) {
        let v0 = Slingshot{
            id         : 0x2::object::new(arg4),
            admin      : arg1,
            live       : arg2,
            market_fee : arg0.market_fee,
        };
        let v1 = 0;
        while (v1 < 0x1::vector::length<T0>(&arg3)) {
            let v2 = 0x1::vector::pop_back<T0>(&mut arg3);
            0x2::dynamic_object_field::add<0x2::object::ID, T0>(&mut v0.id, 0x2::object::id<T0>(&v2), v2);
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<T0>(arg3);
        0x2::transfer::share_object<Slingshot>(v0);
        (0x2::object::id<Slingshot>(&v0), arg0.market_fee)
    }

    public entry fun create_slingshot_cap<T0: store + key>(arg0: &AdminCap, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = LaunchpadCap<T0>{
            id         : 0x2::object::new(arg3),
            market_fee : arg1,
        };
        0x2::transfer::transfer<LaunchpadCap<T0>>(v0, arg2);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{
            id         : 0x2::object::new(arg0),
            market_fee : 5,
        };
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun modify_status(arg0: &mut Slingshot, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg2), 0);
        arg0.live = arg1;
    }

    public fun remove_launchpad<T0: store + key>(arg0: &mut Slingshot, arg1: 0x2::object::ID) : T0 {
        0x2::dynamic_object_field::remove<0x2::object::ID, T0>(&mut arg0.id, arg1)
    }

    public entry fun send_admin(arg0: AdminCap, arg1: address) {
        0x2::transfer::public_transfer<AdminCap>(arg0, arg1);
    }

    public fun update_admin(arg0: &mut Slingshot, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg2), 0);
        arg0.admin = arg1;
    }

    // decompiled from Move bytecode v6
}

