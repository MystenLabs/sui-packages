module 0xb877fe150db8e9af55c399b4e49ba8afe658bd05317cb378c940344851125e9a::access_control {
    struct AdminWitness<phantom T0> has drop {
        pos0: u128,
    }

    struct SuperAdmin<phantom T0> has key {
        id: 0x2::object::UID,
        new_admin: address,
        start: u64,
        delay: u64,
    }

    struct Admin<phantom T0> has store, key {
        id: 0x2::object::UID,
    }

    struct ACL<phantom T0> has store, key {
        id: 0x2::object::UID,
        admins: 0x2::vec_map::VecMap<address, u128>,
    }

    public fun new<T0: drop>(arg0: &T0, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : ACL<T0> {
        assert!(0x2::types::is_one_time_witness<T0>(arg0), 0);
        new_impl<T0>(arg1, arg2, arg3)
    }

    public fun add_role<T0: drop>(arg0: &mut ACL<T0>, arg1: &SuperAdmin<T0>, arg2: address, arg3: u8) {
        assert!(128 > arg3, 4);
        assert!(is_admin<T0>(arg0, arg2), 2);
        0xb877fe150db8e9af55c399b4e49ba8afe658bd05317cb378c940344851125e9a::events::role_added<T0>(arg2, arg3);
        let v0 = 0x2::vec_map::get_mut<address, u128>(&mut arg0.admins, &arg2);
        *v0 = *v0 | 1 << arg3;
    }

    public fun admin_address<T0: drop>(arg0: &Admin<T0>) : address {
        0x2::object::uid_to_address(&arg0.id)
    }

    public fun assert_has_role<T0: drop>(arg0: &AdminWitness<T0>, arg1: u8) {
        assert!(check_role(arg0.pos0, arg1), 5);
    }

    fun check_role(arg0: u128, arg1: u8) : bool {
        if (arg1 > 128) {
            return false
        };
        arg0 & 1 << arg1 != 0
    }

    public fun default<T0: drop>(arg0: &T0, arg1: &mut 0x2::tx_context::TxContext) : ACL<T0> {
        let v0 = 0x2::tx_context::sender(arg1);
        new<T0>(arg0, 3, v0, arg1)
    }

    public fun destroy_admin<T0: drop>(arg0: &mut ACL<T0>, arg1: Admin<T0>) {
        let Admin { id: v0 } = arg1;
        let v1 = 0x2::object::uid_to_address(&v0);
        if (0x2::vec_map::contains<address, u128>(&arg0.admins, &v1)) {
            let (_, _) = 0x2::vec_map::remove<address, u128>(&mut arg0.admins, &v1);
        };
        0xb877fe150db8e9af55c399b4e49ba8afe658bd05317cb378c940344851125e9a::events::admin_destroyed<T0>(v1);
        0x2::object::delete(v0);
    }

    public fun destroy_super_admin<T0: drop>(arg0: SuperAdmin<T0>) {
        let SuperAdmin {
            id        : v0,
            new_admin : _,
            start     : _,
            delay     : _,
        } = arg0;
        let v4 = v0;
        0xb877fe150db8e9af55c399b4e49ba8afe658bd05317cb378c940344851125e9a::events::super_admin_destroyed<T0>(0x2::object::uid_to_address(&v4));
        0x2::object::delete(v4);
    }

    public fun finish_transfer<T0: drop>(arg0: SuperAdmin<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::epoch(arg1) > arg0.start + arg0.delay, 1);
        let v0 = arg0.new_admin;
        arg0.new_admin = @0x0;
        arg0.start = 18446744073709551615;
        0x2::transfer::transfer<SuperAdmin<T0>>(arg0, v0);
        0xb877fe150db8e9af55c399b4e49ba8afe658bd05317cb378c940344851125e9a::events::finish_super_admin_transfer<T0>(v0);
    }

    public fun has_role<T0: drop>(arg0: &ACL<T0>, arg1: address, arg2: u8) : bool {
        if (!is_admin<T0>(arg0, arg1) || arg2 > 128) {
            return false
        };
        check_role(*0x2::vec_map::get<address, u128>(&arg0.admins, &arg1), arg2)
    }

    public fun is_admin<T0: drop>(arg0: &ACL<T0>, arg1: address) : bool {
        0x2::vec_map::contains<address, u128>(&arg0.admins, &arg1)
    }

    public fun new_admin<T0: drop>(arg0: &mut ACL<T0>, arg1: &SuperAdmin<T0>, arg2: &mut 0x2::tx_context::TxContext) : Admin<T0> {
        let v0 = Admin<T0>{id: 0x2::object::new(arg2)};
        0x2::vec_map::insert<address, u128>(&mut arg0.admins, 0x2::object::uid_to_address(&v0.id), 0);
        0xb877fe150db8e9af55c399b4e49ba8afe658bd05317cb378c940344851125e9a::events::new_admin<T0>(0x2::object::uid_to_address(&v0.id));
        v0
    }

    fun new_impl<T0: drop>(arg0: u64, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : ACL<T0> {
        assert!(arg1 != @0x0, 3);
        let v0 = ACL<T0>{
            id     : 0x2::object::new(arg2),
            admins : 0x2::vec_map::empty<address, u128>(),
        };
        let v1 = SuperAdmin<T0>{
            id        : 0x2::object::new(arg2),
            new_admin : @0x0,
            start     : 18446744073709551615,
            delay     : arg0,
        };
        0xb877fe150db8e9af55c399b4e49ba8afe658bd05317cb378c940344851125e9a::events::new_super_admin<T0>(0x2::object::uid_to_address(&v0.id), 0x2::object::uid_to_address(&v1.id), arg1, arg0);
        0x2::transfer::transfer<SuperAdmin<T0>>(v1, arg1);
        v0
    }

    public fun permissions<T0: drop>(arg0: &ACL<T0>, arg1: address) : 0x1::option::Option<u128> {
        if (!is_admin<T0>(arg0, arg1)) {
            return 0x1::option::none<u128>()
        };
        0x1::option::some<u128>(*0x2::vec_map::get<address, u128>(&arg0.admins, &arg1))
    }

    public fun remove_role<T0: drop>(arg0: &mut ACL<T0>, arg1: &SuperAdmin<T0>, arg2: address, arg3: u8) {
        assert!(128 > arg3, 4);
        assert!(is_admin<T0>(arg0, arg2), 2);
        0xb877fe150db8e9af55c399b4e49ba8afe658bd05317cb378c940344851125e9a::events::role_removed<T0>(arg2, arg3);
        let v0 = 0x2::vec_map::get_mut<address, u128>(&mut arg0.admins, &arg2);
        *v0 = *v0 - (1 << arg3);
    }

    public fun revoke<T0: drop>(arg0: &mut ACL<T0>, arg1: &SuperAdmin<T0>, arg2: address) {
        let (_, _) = 0x2::vec_map::remove<address, u128>(&mut arg0.admins, &arg2);
        0xb877fe150db8e9af55c399b4e49ba8afe658bd05317cb378c940344851125e9a::events::revoke_admin<T0>(arg2);
    }

    public fun sign_in<T0: drop>(arg0: &ACL<T0>, arg1: &Admin<T0>) : AdminWitness<T0> {
        let v0 = 0x2::object::uid_to_address(&arg1.id);
        assert!(is_admin<T0>(arg0, v0), 2);
        AdminWitness<T0>{pos0: *0x2::vec_map::get<address, u128>(&arg0.admins, &v0)}
    }

    public fun start_transfer<T0: drop>(arg0: &mut SuperAdmin<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 != @0x0 && arg1 != 0x2::tx_context::sender(arg2), 3);
        arg0.start = 0x2::tx_context::epoch(arg2);
        arg0.new_admin = arg1;
        0xb877fe150db8e9af55c399b4e49ba8afe658bd05317cb378c940344851125e9a::events::start_super_admin_transfer<T0>(arg1, arg0.start);
    }

    // decompiled from Move bytecode v6
}

