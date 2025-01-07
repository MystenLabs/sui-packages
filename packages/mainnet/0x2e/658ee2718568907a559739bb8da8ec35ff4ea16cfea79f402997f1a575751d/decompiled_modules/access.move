module 0x2e658ee2718568907a559739bb8da8ec35ff4ea16cfea79f402997f1a575751d::access {
    struct Access has store, key {
        id: 0x2::object::UID,
        version: u64,
        name: 0x1::string::String,
        role_cap: 0x2::table::Table<address, 0x2::vec_set::VecSet<0x2::object::ID>>,
        witness_cap: 0x2::table::Table<0x1::type_name::TypeName, 0x2::vec_set::VecSet<0x2::object::ID>>,
    }

    struct CreateAccessEvent has copy, drop {
        access: 0x2::object::ID,
    }

    struct GrantRolesForSenderEvent has copy, drop {
        access: 0x2::object::ID,
        sender: address,
        roles: vector<0x2::object::ID>,
    }

    struct RevokeRolesForSenderEvent has copy, drop {
        access: 0x2::object::ID,
        sender: address,
        roles: vector<0x2::object::ID>,
    }

    struct GrantRolesForWitnessEvent has copy, drop {
        access: 0x2::object::ID,
        witness: 0x1::type_name::TypeName,
        roles: vector<0x2::object::ID>,
    }

    struct RevokeRolesForWitnessEvent has copy, drop {
        access: 0x2::object::ID,
        witness: 0x1::type_name::TypeName,
        roles: vector<0x2::object::ID>,
    }

    struct Witness has drop {
        dummy_field: bool,
    }

    struct ACCESS has drop {
        dummy_field: bool,
    }

    public fun all_match_for_sender(arg0: &Access, arg1: address, arg2: vector<0x2::object::ID>) : bool {
        let v0 = true;
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x2::object::ID>(&arg2)) {
            let v2 = has_role_for_sender(arg0, arg1, *0x1::vector::borrow<0x2::object::ID>(&arg2, v1));
            v0 = v2;
            if (!v2) {
                break
            };
            v1 = v1 + 1;
        };
        v0
    }

    public fun all_match_for_witness(arg0: &Access, arg1: 0x1::type_name::TypeName, arg2: vector<0x2::object::ID>) : bool {
        let v0 = true;
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x2::object::ID>(&arg2)) {
            let v2 = has_role_for_witness(arg0, arg1, *0x1::vector::borrow<0x2::object::ID>(&arg2, v1));
            v0 = v2;
            if (!v2) {
                break
            };
            v1 = v1 + 1;
        };
        v0
    }

    public fun anyone_match_for_sender(arg0: &Access, arg1: address, arg2: vector<0x2::object::ID>) : bool {
        let v0 = false;
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x2::object::ID>(&arg2)) {
            let v2 = has_role_for_sender(arg0, arg1, *0x1::vector::borrow<0x2::object::ID>(&arg2, v1));
            v0 = v2;
            if (v2) {
                break
            };
            v1 = v1 + 1;
        };
        v0
    }

    public fun anyone_match_for_witness(arg0: &Access, arg1: 0x1::type_name::TypeName, arg2: vector<0x2::object::ID>) : bool {
        let v0 = false;
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x2::object::ID>(&arg2)) {
            let v2 = has_role_for_witness(arg0, arg1, *0x1::vector::borrow<0x2::object::ID>(&arg2, v1));
            v0 = v2;
            if (v2) {
                break
            };
            v1 = v1 + 1;
        };
        v0
    }

    public fun assert_all_match_for_sender(arg0: &Access, arg1: address, arg2: vector<0x2::object::ID>) {
        assert!(all_match_for_sender(arg0, arg1, arg2), 10003);
    }

    public fun assert_all_match_for_witness(arg0: &Access, arg1: 0x1::type_name::TypeName, arg2: vector<0x2::object::ID>) {
        assert!(all_match_for_witness(arg0, arg1, arg2), 10003);
    }

    public fun assert_anyone_match_for_sender(arg0: &Access, arg1: address, arg2: vector<0x2::object::ID>) {
        assert!(anyone_match_for_sender(arg0, arg1, arg2), 10004);
    }

    public fun assert_anyone_match_for_witness(arg0: &Access, arg1: 0x1::type_name::TypeName, arg2: vector<0x2::object::ID>) {
        assert!(anyone_match_for_witness(arg0, arg1, arg2), 10004);
    }

    public fun assert_only_role_for_sender(arg0: &Access, arg1: address, arg2: 0x2::object::ID) {
        assert!(has_role_for_sender(arg0, arg1, arg2), 10005);
    }

    public fun assert_only_role_for_witness(arg0: &Access, arg1: 0x1::type_name::TypeName, arg2: 0x2::object::ID) {
        assert!(has_role_for_witness(arg0, arg1, arg2), 10005);
    }

    public fun assert_version(arg0: &Access) {
        assert!(arg0.version == 1, 10001);
    }

    public fun borrow_mut_name(arg0: &mut Access) : &mut 0x1::string::String {
        assert_version(arg0);
        &mut arg0.name
    }

    public fun borrow_mut_role_cap(arg0: &mut Access) : &mut 0x2::table::Table<address, 0x2::vec_set::VecSet<0x2::object::ID>> {
        assert_version(arg0);
        &mut arg0.role_cap
    }

    public fun borrow_mut_uid(arg0: &mut Access) : &mut 0x2::object::UID {
        assert_version(arg0);
        &mut arg0.id
    }

    public fun borrow_mut_witness_cap(arg0: &mut Access) : &mut 0x2::table::Table<0x1::type_name::TypeName, 0x2::vec_set::VecSet<0x2::object::ID>> {
        assert_version(arg0);
        &mut arg0.witness_cap
    }

    public fun borrow_name(arg0: &Access) : &0x1::string::String {
        &arg0.name
    }

    public fun borrow_role_cap(arg0: &Access) : &0x2::table::Table<address, 0x2::vec_set::VecSet<0x2::object::ID>> {
        &arg0.role_cap
    }

    public fun borrow_uid(arg0: &Access) : &0x2::object::UID {
        &arg0.id
    }

    public fun borrow_version(arg0: &Access) : &u64 {
        &arg0.version
    }

    public fun borrow_witness_cap(arg0: &Access) : &0x2::table::Table<0x1::type_name::TypeName, 0x2::vec_set::VecSet<0x2::object::ID>> {
        &arg0.witness_cap
    }

    public fun grant_roles_for_sender(arg0: &mut Access, arg1: address, arg2: vector<0x2::object::ID>, arg3: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        if (!0x2::table::contains<address, 0x2::vec_set::VecSet<0x2::object::ID>>(&arg0.role_cap, arg1)) {
            0x2::table::add<address, 0x2::vec_set::VecSet<0x2::object::ID>>(&mut arg0.role_cap, arg1, 0x2::vec_set::empty<0x2::object::ID>());
        };
        let v0 = 0x2::table::borrow_mut<address, 0x2::vec_set::VecSet<0x2::object::ID>>(&mut arg0.role_cap, arg1);
        let v1 = 0x1::vector::empty<0x2::object::ID>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x2::object::ID>(&arg2)) {
            let v3 = 0x1::vector::borrow<0x2::object::ID>(&arg2, v2);
            if (!0x2::vec_set::contains<0x2::object::ID>(v0, v3)) {
                0x1::vector::push_back<0x2::object::ID>(&mut v1, *v3);
                0x2::vec_set::insert<0x2::object::ID>(v0, *v3);
            };
            v2 = v2 + 1;
        };
        let v4 = GrantRolesForSenderEvent{
            access : 0x2::object::id<Access>(arg0),
            sender : arg1,
            roles  : v1,
        };
        0x2::event::emit<GrantRolesForSenderEvent>(v4);
    }

    public fun grant_roles_for_witness<T0>(arg0: &mut Access, arg1: vector<0x2::object::ID>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::get<T0>();
        if (!0x2::table::contains<0x1::type_name::TypeName, 0x2::vec_set::VecSet<0x2::object::ID>>(&arg0.witness_cap, v0)) {
            0x2::table::add<0x1::type_name::TypeName, 0x2::vec_set::VecSet<0x2::object::ID>>(&mut arg0.witness_cap, v0, 0x2::vec_set::empty<0x2::object::ID>());
        };
        let v1 = 0x2::table::borrow_mut<0x1::type_name::TypeName, 0x2::vec_set::VecSet<0x2::object::ID>>(&mut arg0.witness_cap, v0);
        let v2 = 0x1::vector::empty<0x2::object::ID>();
        let v3 = 0;
        while (v3 < 0x1::vector::length<0x2::object::ID>(&arg1)) {
            let v4 = 0x1::vector::borrow<0x2::object::ID>(&arg1, v3);
            if (!0x2::vec_set::contains<0x2::object::ID>(v1, v4)) {
                0x1::vector::push_back<0x2::object::ID>(&mut v2, *v4);
                0x2::vec_set::insert<0x2::object::ID>(v1, *v4);
            };
            v3 = v3 + 1;
        };
        let v5 = GrantRolesForWitnessEvent{
            access  : 0x2::object::id<Access>(arg0),
            witness : v0,
            roles   : v2,
        };
        0x2::event::emit<GrantRolesForWitnessEvent>(v5);
    }

    public fun has_role_for_sender(arg0: &Access, arg1: address, arg2: 0x2::object::ID) : bool {
        0x2::table::contains<address, 0x2::vec_set::VecSet<0x2::object::ID>>(&arg0.role_cap, arg1) && 0x2::vec_set::contains<0x2::object::ID>(0x2::table::borrow<address, 0x2::vec_set::VecSet<0x2::object::ID>>(&arg0.role_cap, arg1), &arg2)
    }

    public fun has_role_for_witness(arg0: &Access, arg1: 0x1::type_name::TypeName, arg2: 0x2::object::ID) : bool {
        0x2::table::contains<0x1::type_name::TypeName, 0x2::vec_set::VecSet<0x2::object::ID>>(&arg0.witness_cap, arg1) && 0x2::vec_set::contains<0x2::object::ID>(0x2::table::borrow<0x1::type_name::TypeName, 0x2::vec_set::VecSet<0x2::object::ID>>(&arg0.witness_cap, arg1), &arg2)
    }

    fun init(arg0: ACCESS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<ACCESS>(arg0, arg1);
        let v1 = 0x2::display::new<Access>(&v0, arg1);
        0x2::display::add<Access>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::update_version<Access>(&mut v1);
        0x2::transfer::public_transfer<0x2::display::Display<Access>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun init_access(arg0: &mut 0x2::tx_context::TxContext) : Access {
        let v0 = Access{
            id          : 0x2::object::new(arg0),
            version     : 1,
            name        : 0x1::string::utf8(b"Access"),
            role_cap    : 0x2::table::new<address, 0x2::vec_set::VecSet<0x2::object::ID>>(arg0),
            witness_cap : 0x2::table::new<0x1::type_name::TypeName, 0x2::vec_set::VecSet<0x2::object::ID>>(arg0),
        };
        let v1 = CreateAccessEvent{access: 0x2::object::id<Access>(&v0)};
        0x2::event::emit<CreateAccessEvent>(v1);
        v0
    }

    public entry fun migrate(arg0: &mut Access) {
        assert!(arg0.version < 1, 10002);
        arg0.version = 1;
    }

    public fun revoke_roles_for_sender(arg0: &mut Access, arg1: address, arg2: vector<0x2::object::ID>) {
        assert_version(arg0);
        assert!(0x2::table::contains<address, 0x2::vec_set::VecSet<0x2::object::ID>>(&arg0.role_cap, arg1), 10006);
        let v0 = 0x2::table::borrow_mut<address, 0x2::vec_set::VecSet<0x2::object::ID>>(&mut arg0.role_cap, arg1);
        let v1 = 0x1::vector::empty<0x2::object::ID>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x2::object::ID>(&arg2)) {
            let v3 = 0x1::vector::borrow<0x2::object::ID>(&arg2, v2);
            if (0x2::vec_set::contains<0x2::object::ID>(v0, v3)) {
                0x1::vector::push_back<0x2::object::ID>(&mut v1, *v3);
                0x2::vec_set::remove<0x2::object::ID>(v0, v3);
            };
            v2 = v2 + 1;
        };
        let v4 = RevokeRolesForSenderEvent{
            access : 0x2::object::id<Access>(arg0),
            sender : arg1,
            roles  : v1,
        };
        0x2::event::emit<RevokeRolesForSenderEvent>(v4);
    }

    public fun revoke_roles_for_witness<T0>(arg0: &mut Access, arg1: vector<0x2::object::ID>) {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, 0x2::vec_set::VecSet<0x2::object::ID>>(&arg0.witness_cap, v0), 1);
        let v1 = 0x2::table::borrow_mut<0x1::type_name::TypeName, 0x2::vec_set::VecSet<0x2::object::ID>>(&mut arg0.witness_cap, v0);
        let v2 = 0x1::vector::empty<0x2::object::ID>();
        let v3 = 0;
        while (v3 < 0x1::vector::length<0x2::object::ID>(&arg1)) {
            let v4 = 0x1::vector::borrow<0x2::object::ID>(&arg1, v3);
            if (0x2::vec_set::contains<0x2::object::ID>(v1, v4)) {
                0x1::vector::push_back<0x2::object::ID>(&mut v2, *v4);
                0x2::vec_set::remove<0x2::object::ID>(v1, v4);
            };
            v3 = v3 + 1;
        };
        let v5 = RevokeRolesForWitnessEvent{
            access  : 0x2::object::id<Access>(arg0),
            witness : v0,
            roles   : v2,
        };
        0x2::event::emit<RevokeRolesForWitnessEvent>(v5);
    }

    public fun to_role(arg0: vector<u8>) : 0x2::object::ID {
        0x2::object::id_from_bytes(0x2::hash::keccak256(&arg0))
    }

    public fun version() : u64 {
        1
    }

    // decompiled from Move bytecode v6
}

