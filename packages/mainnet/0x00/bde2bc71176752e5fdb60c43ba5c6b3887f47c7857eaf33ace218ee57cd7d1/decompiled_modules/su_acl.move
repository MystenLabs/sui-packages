module 0xbde2bc71176752e5fdb60c43ba5c6b3887f47c7857eaf33ace218ee57cd7d1::su_acl {
    struct AdminWitness has drop {
        pos0: u128,
    }

    struct SuperAdminCap has key {
        id: 0x2::object::UID,
        new_admin: address,
        start: u64,
        delay: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Acl has key {
        id: 0x2::object::UID,
        admins: 0x2::vec_map::VecMap<address, u128>,
    }

    public fun new_admin(arg0: &mut Acl, arg1: &SuperAdminCap, arg2: &mut 0x2::tx_context::TxContext) : AdminCap {
        let v0 = AdminCap{id: 0x2::object::new(arg2)};
        0x2::vec_map::insert<address, u128>(&mut arg0.admins, 0x2::object::uid_to_address(&v0.id), 0);
        0xbde2bc71176752e5fdb60c43ba5c6b3887f47c7857eaf33ace218ee57cd7d1::events::new_admin(0x2::object::uid_to_address(&v0.id), 0);
        v0
    }

    public fun add_role(arg0: &mut Acl, arg1: &SuperAdminCap, arg2: address, arg3: u8) {
        assert!(128 > arg3, 0);
        assert!(is_admin(arg0, arg2), 1);
        let v0 = 0x2::vec_map::get_mut<address, u128>(&mut arg0.admins, &arg2);
        let v1 = *v0 | 1 << arg3;
        *v0 = v1;
        0xbde2bc71176752e5fdb60c43ba5c6b3887f47c7857eaf33ace218ee57cd7d1::events::role_added(arg2, arg3, v1);
    }

    public fun assert_has_role(arg0: &AdminWitness, arg1: u8) {
        assert!(check_role(arg0.pos0, arg1), 4);
    }

    fun check_role(arg0: u128, arg1: u8) : bool {
        if (arg1 >= 128) {
            return false
        };
        arg0 & 1 << arg1 != 0
    }

    public fun destroy_admin(arg0: &mut Acl, arg1: AdminCap) {
        let AdminCap { id: v0 } = arg1;
        let v1 = 0x2::object::uid_to_address(&v0);
        let v2 = 0;
        let v3 = 0x2::vec_map::contains<address, u128>(&arg0.admins, &v1);
        if (v3) {
            v2 = *0x2::vec_map::get<address, u128>(&arg0.admins, &v1);
            let (_, _) = 0x2::vec_map::remove<address, u128>(&mut arg0.admins, &v1);
        };
        0xbde2bc71176752e5fdb60c43ba5c6b3887f47c7857eaf33ace218ee57cd7d1::events::admin_destroyed(v1, v2, v3);
        0x2::object::delete(v0);
    }

    public fun destroy_super_admin(arg0: SuperAdminCap) {
        let SuperAdminCap {
            id        : v0,
            new_admin : _,
            start     : _,
            delay     : _,
        } = arg0;
        let v4 = v0;
        0xbde2bc71176752e5fdb60c43ba5c6b3887f47c7857eaf33ace218ee57cd7d1::events::super_admin_destroyed(0x2::object::uid_to_address(&v4));
        0x2::object::delete(v4);
    }

    public fun finish_transfer(arg0: SuperAdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.start != 18446744073709551615, 3);
        assert!(arg0.new_admin != @0x0, 2);
        assert!(0x2::tx_context::epoch(arg1) > arg0.start + arg0.delay, 3);
        let v0 = arg0.new_admin;
        arg0.new_admin = @0x0;
        arg0.start = 18446744073709551615;
        0x2::transfer::transfer<SuperAdminCap>(arg0, v0);
        0xbde2bc71176752e5fdb60c43ba5c6b3887f47c7857eaf33ace218ee57cd7d1::events::finish_super_admin_transfer(0x2::object::uid_to_address(&arg0.id), 0x2::tx_context::sender(arg1), v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Acl{
            id     : 0x2::object::new(arg0),
            admins : 0x2::vec_map::empty<address, u128>(),
        };
        let v1 = SuperAdminCap{
            id        : 0x2::object::new(arg0),
            new_admin : @0x0,
            start     : 18446744073709551615,
            delay     : 7,
        };
        0xbde2bc71176752e5fdb60c43ba5c6b3887f47c7857eaf33ace218ee57cd7d1::events::acl_created(0x2::object::id<Acl>(&v0), 0x2::object::uid_to_address(&v1.id), 0x2::tx_context::sender(arg0), v1.new_admin, v1.start, v1.delay);
        0x2::transfer::transfer<SuperAdminCap>(v1, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<Acl>(v0);
    }

    fun is_admin(arg0: &Acl, arg1: address) : bool {
        0x2::vec_map::contains<address, u128>(&arg0.admins, &arg1)
    }

    public fun remove_role(arg0: &mut Acl, arg1: &SuperAdminCap, arg2: address, arg3: u8) {
        assert!(128 > arg3, 0);
        assert!(is_admin(arg0, arg2), 1);
        let v0 = 0x2::vec_map::get_mut<address, u128>(&mut arg0.admins, &arg2);
        let v1 = *v0 & (340282366920938463463374607431768211455 ^ 1 << arg3);
        *v0 = v1;
        0xbde2bc71176752e5fdb60c43ba5c6b3887f47c7857eaf33ace218ee57cd7d1::events::role_removed(arg2, arg3, v1);
    }

    public fun revoke(arg0: &mut Acl, arg1: &SuperAdminCap, arg2: address) {
        assert!(is_admin(arg0, arg2), 1);
        let (_, _) = 0x2::vec_map::remove<address, u128>(&mut arg0.admins, &arg2);
        0xbde2bc71176752e5fdb60c43ba5c6b3887f47c7857eaf33ace218ee57cd7d1::events::revoke_admin(arg2, *0x2::vec_map::get<address, u128>(&arg0.admins, &arg2));
    }

    public fun sign_in(arg0: &Acl, arg1: &AdminCap) : AdminWitness {
        let v0 = 0x2::object::uid_to_address(&arg1.id);
        assert!(is_admin(arg0, v0), 1);
        AdminWitness{pos0: *0x2::vec_map::get<address, u128>(&arg0.admins, &v0)}
    }

    public fun start_transfer(arg0: &mut SuperAdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 != @0x0 && arg1 != 0x2::tx_context::sender(arg2), 2);
        arg0.start = 0x2::tx_context::epoch(arg2);
        arg0.new_admin = arg1;
        0xbde2bc71176752e5fdb60c43ba5c6b3887f47c7857eaf33ace218ee57cd7d1::events::start_super_admin_transfer(0x2::object::uid_to_address(&arg0.id), 0x2::tx_context::sender(arg2), arg1, arg0.start, arg0.delay);
    }

    // decompiled from Move bytecode v7
}

