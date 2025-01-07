module 0x31036527dcef242ded53780d6f493c1d86982c97111a8cf4e7c9e22b60c2a3a5::access_control {
    struct AdminCap<phantom T0> has store, key {
        id: 0x2::object::UID,
    }

    struct Role<phantom T0> has store, key {
        id: 0x2::object::UID,
        members: vector<address>,
    }

    struct Member<phantom T0> has store, key {
        id: 0x2::object::UID,
    }

    struct RoleCreated<phantom T0> has copy, drop {
        sender: address,
    }

    struct RoleGranted<phantom T0> has copy, drop {
        member: address,
        sender: address,
    }

    struct RoleRevoked<phantom T0> has copy, drop {
        member: address,
        sender: address,
    }

    struct MemberCreated<phantom T0> has copy, drop {
        member: 0x2::object::ID,
    }

    public fun check_role<T0>(arg0: &Role<T0>, arg1: &Member<T0>) {
        assert!(has_role<T0>(arg0, arg1), 1);
    }

    public fun create_member<T0>(arg0: &mut 0x2::tx_context::TxContext) : Member<T0> {
        Member<T0>{id: 0x2::object::new(arg0)}
    }

    public entry fun create_member_and_transfer<T0>(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::transfer<Member<T0>>(create_member<T0>(arg1), arg0);
    }

    public fun create_role<T0: drop>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) : AdminCap<T0> {
        assert!(0x2::types::is_one_time_witness<T0>(&arg0), 0);
        let v0 = RoleCreated<T0>{sender: 0x2::tx_context::sender(arg1)};
        0x2::event::emit<RoleCreated<T0>>(v0);
        let v1 = Role<T0>{
            id      : 0x2::object::new(arg1),
            members : 0x1::vector::empty<address>(),
        };
        0x2::transfer::share_object<Role<T0>>(v1);
        AdminCap<T0>{id: 0x2::object::new(arg1)}
    }

    public entry fun grant_role<T0>(arg0: &AdminCap<T0>, arg1: &mut Role<T0>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        grant_role_internal<T0>(arg1, arg2, arg3);
    }

    fun grant_role_internal<T0>(arg0: &mut Role<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        if (!has_role_internal<T0>(arg0, arg1)) {
            0x1::vector::push_back<address>(&mut arg0.members, arg1);
            let v0 = RoleGranted<T0>{
                member : arg1,
                sender : 0x2::tx_context::sender(arg2),
            };
            0x2::event::emit<RoleGranted<T0>>(v0);
        };
    }

    public fun has_role<T0>(arg0: &Role<T0>, arg1: &Member<T0>) : bool {
        has_role_internal<T0>(arg0, 0x2::object::id_address<Member<T0>>(arg1))
    }

    fun has_role_internal<T0>(arg0: &Role<T0>, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.members, &arg1)
    }

    public entry fun revoke_role<T0>(arg0: &AdminCap<T0>, arg1: &mut Role<T0>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        revoke_role_internal<T0>(arg1, arg2, arg3);
    }

    fun revoke_role_internal<T0>(arg0: &mut Role<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        if (has_role_internal<T0>(arg0, arg1)) {
            let (_, v1) = 0x1::vector::index_of<address>(&arg0.members, &arg1);
            0x1::vector::remove<address>(&mut arg0.members, v1);
            let v2 = RoleRevoked<T0>{
                member : arg1,
                sender : 0x2::tx_context::sender(arg2),
            };
            0x2::event::emit<RoleRevoked<T0>>(v2);
        };
    }

    // decompiled from Move bytecode v6
}

