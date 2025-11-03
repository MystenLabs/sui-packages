module 0x17b6f25b7b81db73f10f7cb787c6b704b9e2d47887c9c184e02d8d42e1046fa6::auth {
    struct Auth has store, key {
        id: 0x2::object::UID,
        inner: 0x2::versioned::Versioned,
    }

    struct AuthInner has store {
        roles: 0x2::bag::Bag,
        admin_count: u8,
    }

    struct AdminCap has drop, store {
        dummy_field: bool,
    }

    struct ControllerCap has drop, store {
        dummy_field: bool,
    }

    struct OracleCap has drop, store {
        dummy_field: bool,
    }

    struct AssessorCap has drop, store {
        dummy_field: bool,
    }

    struct RoleKey<phantom T0> has copy, drop, store {
        owner: address,
    }

    struct AddCapabilityEvent has copy, drop {
        updated_by: address,
        account: address,
        cap_type: 0x1::type_name::TypeName,
    }

    struct RemoveCapabilityEvent has copy, drop {
        updated_by: address,
        account: address,
        cap_type: 0x1::type_name::TypeName,
    }

    public(friend) fun add_cap<T0: drop + store>(arg0: &mut Auth, arg1: address, arg2: T0) {
        let v0 = RoleKey<T0>{owner: arg1};
        0x2::bag::add<RoleKey<T0>, T0>(&mut load_inner_mut(arg0).roles, v0, arg2);
    }

    public fun add_capability<T0: drop + store>(arg0: &mut Auth, arg1: address, arg2: T0, arg3: &mut 0x2::tx_context::TxContext) {
        assert_cap<AdminCap>(arg0, 0x2::tx_context::sender(arg3));
        assert_not_cap<T0>(arg0, arg1);
        if (0x1::type_name::get<T0>() == 0x1::type_name::get<AdminCap>()) {
            let v0 = admin_count_mut(arg0);
            let v1 = *v0 + 1;
            let v2 = admin_count_mut(arg0);
            *v2 = v1;
        };
        add_cap<T0>(arg0, arg1, arg2);
        let v3 = AddCapabilityEvent{
            updated_by : 0x2::tx_context::sender(arg3),
            account    : arg1,
            cap_type   : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<AddCapabilityEvent>(v3);
    }

    public(friend) fun admin_count(arg0: &Auth) : u8 {
        load_inner(arg0).admin_count
    }

    fun admin_count_mut(arg0: &mut Auth) : &mut u8 {
        &mut load_inner_mut(arg0).admin_count
    }

    public fun assert_cap<T0: store>(arg0: &Auth, arg1: address) {
        assert!(has_cap<T0>(arg0, arg1), 1);
    }

    public fun assert_not_cap<T0: store>(arg0: &Auth, arg1: address) {
        assert!(!has_cap<T0>(arg0, arg1), 2);
    }

    public fun has_cap<T0: store>(arg0: &Auth, arg1: address) : bool {
        let v0 = RoleKey<T0>{owner: arg1};
        0x2::bag::contains<RoleKey<T0>>(&load_inner(arg0).roles, v0)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AuthInner{
            roles       : 0x2::bag::new(arg0),
            admin_count : 1,
        };
        let v1 = Auth{
            id    : 0x2::object::new(arg0),
            inner : 0x2::versioned::create<AuthInner>(1, v0, arg0),
        };
        let v2 = &mut v1;
        add_cap<AdminCap>(v2, 0x2::tx_context::sender(arg0), new_admin_cap());
        0x2::transfer::public_share_object<Auth>(v1);
    }

    fun load_inner(arg0: &Auth) : &AuthInner {
        assert!(0x2::versioned::version(&arg0.inner) == 1, 4);
        0x2::versioned::load_value<AuthInner>(&arg0.inner)
    }

    fun load_inner_mut(arg0: &mut Auth) : &mut AuthInner {
        assert!(0x2::versioned::version(&arg0.inner) == 1, 4);
        0x2::versioned::load_value_mut<AuthInner>(&mut arg0.inner)
    }

    public fun new_admin_cap() : AdminCap {
        AdminCap{dummy_field: false}
    }

    public fun new_assessor_cap() : AssessorCap {
        AssessorCap{dummy_field: false}
    }

    public fun new_controller_cap() : ControllerCap {
        ControllerCap{dummy_field: false}
    }

    public fun new_oracle_cap() : OracleCap {
        OracleCap{dummy_field: false}
    }

    public(friend) fun remove_cap<T0: drop + store>(arg0: &mut Auth, arg1: address) : T0 {
        let v0 = RoleKey<T0>{owner: arg1};
        0x2::bag::remove<RoleKey<T0>, T0>(&mut load_inner_mut(arg0).roles, v0)
    }

    public fun remove_capability<T0: drop + store>(arg0: &mut Auth, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert_cap<AdminCap>(arg0, 0x2::tx_context::sender(arg2));
        assert_cap<T0>(arg0, arg1);
        if (0x1::type_name::get<T0>() == 0x1::type_name::get<AdminCap>()) {
            assert!(admin_count(arg0) > 1, 3);
            let v0 = admin_count_mut(arg0);
            let v1 = *v0 - 1;
            let v2 = admin_count_mut(arg0);
            *v2 = v1;
        };
        remove_cap<T0>(arg0, arg1);
        let v3 = RemoveCapabilityEvent{
            updated_by : 0x2::tx_context::sender(arg2),
            account    : arg1,
            cap_type   : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<RemoveCapabilityEvent>(v3);
    }

    // decompiled from Move bytecode v6
}

