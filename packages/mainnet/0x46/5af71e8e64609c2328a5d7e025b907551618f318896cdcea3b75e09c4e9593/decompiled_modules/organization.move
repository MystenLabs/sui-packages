module 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::organization {
    struct Organization has key {
        id: 0x2::object::UID,
        packages: vector<Package>,
        rbac: 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::rbac::RBAC,
    }

    struct Package has store, key {
        id: 0x2::object::UID,
        package_id: 0x2::object::ID,
    }

    struct Key has copy, drop, store {
        dummy_field: bool,
    }

    struct Witness has drop {
        dummy_field: bool,
    }

    struct REMOVE_PACKAGE {
        dummy_field: bool,
    }

    struct ADD_PACKAGE {
        dummy_field: bool,
    }

    struct Endorsement has copy, drop, store {
        from: address,
    }

    struct ENDORSE {
        dummy_field: bool,
    }

    public fun add_endorsement(arg0: &mut Organization, arg1: address, arg2: &0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::TxAuthority) {
        assert!(0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::can_act_as_address<ENDORSE>(arg1, arg2), 0);
        let v0 = Endorsement{from: arg1};
        0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::dynamic_field2::set<Endorsement, bool>(&mut arg0.id, v0, true);
    }

    public entry fun add_endorsement_(arg0: &mut Organization, arg1: address, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::begin(arg2);
        add_endorsement(arg0, arg1, &v0);
    }

    public fun add_package(arg0: &mut 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::publish_receipt::PublishReceipt, arg1: &mut Organization, arg2: &0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::TxAuthority, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::ownership::can_act_as_owner<0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action::ADMIN>(&arg1.id, arg2), 1);
        add_package_internal(arg0, arg1, arg3);
    }

    public entry fun add_package_(arg0: &mut Organization, arg1: &mut 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::publish_receipt::PublishReceipt, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::begin(arg2);
        add_package(arg1, arg0, &v0, arg2);
    }

    public fun add_package_from_stored(arg0: &mut Organization, arg1: Package, arg2: &0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::TxAuthority) {
        assert!(0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::ownership::can_act_as_owner<0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action::ADMIN>(&arg0.id, arg2), 1);
        0x1::vector::push_back<Package>(&mut arg0.packages, arg1);
    }

    public entry fun add_package_from_stored_(arg0: &mut Organization, arg1: Package, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::begin(arg2);
        add_package_from_stored(arg0, arg1, &v0);
    }

    fun add_package_internal(arg0: &mut 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::publish_receipt::PublishReceipt, arg1: &mut Organization, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::publish_receipt::uid_mut(arg0);
        let v1 = Key{dummy_field: false};
        assert!(!0x2::dynamic_field::exists_<Key>(v0, v1), 2);
        let v2 = Key{dummy_field: false};
        0x2::dynamic_field::add<Key, bool>(v0, v2, true);
        let v3 = Package{
            id         : 0x2::object::new(arg2),
            package_id : 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::publish_receipt::into_package_id(arg0),
        };
        0x1::vector::push_back<Package>(&mut arg1.packages, v3);
    }

    public fun add_to_tx_authority(arg0: &Organization, arg1: &0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::TxAuthority) : 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::TxAuthority {
        0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::add_organization_internal(packages(arg0), principal(arg0), arg1)
    }

    public fun assert_login<T0>(arg0: &Organization, arg1: &0x2::tx_context::TxContext) : 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::TxAuthority {
        let v0 = 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::begin(arg1);
        assert_login_<T0>(arg0, &v0)
    }

    public fun assert_login_<T0>(arg0: &Organization, arg1: &0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::TxAuthority) : 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::TxAuthority {
        let v0 = claim_actions_(arg0, arg1);
        assert!(0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::can_act_as_address<T0>(0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::rbac::principal(&arg0.rbac), &v0), 0);
        v0
    }

    public fun claim_actions(arg0: &Organization, arg1: &0x2::tx_context::TxContext) : 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::TxAuthority {
        let v0 = 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::begin(arg1);
        let v1 = &v0;
        v0 = claim_actions_for_agent(arg0, 0x2::tx_context::sender(arg1), v1);
        0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::add_organization_internal(packages(arg0), principal(arg0), &v0)
    }

    public fun claim_actions_(arg0: &Organization, arg1: &0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::TxAuthority) : 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::TxAuthority {
        let v0 = 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::copy_(arg1);
        let v1 = 0;
        let v2 = 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::agents(&v0);
        while (v1 < 0x1::vector::length<address>(&v2)) {
            let v3 = &v0;
            v0 = claim_actions_for_agent(arg0, *0x1::vector::borrow<address>(&v2, v1), v3);
            v1 = v1 + 1;
        };
        0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::add_organization_internal(packages(arg0), principal(arg0), &v0)
    }

    fun claim_actions_for_agent(arg0: &Organization, arg1: address, arg2: &0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::TxAuthority) : 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::TxAuthority {
        let v0 = if (0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::ownership::get_owner(&arg0.id) == 0x1::option::some<address>(arg1)) {
            0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::rbac::get_admin()
        } else {
            0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::rbac::get_agent_actions(&arg0.rbac, arg1)
        };
        0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::add_actions_internal(principal(arg0), arg1, v0, arg2)
    }

    public fun create_from_package(arg0: Package, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : Organization {
        let v0 = create_internal(arg1, arg2);
        0x1::vector::push_back<Package>(&mut v0.packages, arg0);
        v0
    }

    public entry fun create_from_package_(arg0: Package, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        return_and_share(create_from_package(arg0, v0, arg1));
    }

    public fun create_from_receipt(arg0: &mut 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::publish_receipt::PublishReceipt, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : Organization {
        let v0 = create_internal(arg1, arg2);
        let v1 = &mut v0;
        add_package_internal(arg0, v1, arg2);
        v0
    }

    public entry fun create_from_receipt_(arg0: &mut 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::publish_receipt::PublishReceipt, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        return_and_share(create_from_receipt(arg0, v0, arg1));
    }

    fun create_internal(arg0: address, arg1: &mut 0x2::tx_context::TxContext) : Organization {
        let v0 = 0x2::object::new(arg1);
        let v1 = Organization{
            id       : v0,
            packages : 0x1::vector::empty<Package>(),
            rbac     : 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::rbac::create(0x2::object::uid_to_address(&v0)),
        };
        let v2 = Witness{dummy_field: false};
        let v3 = 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::begin_with_package_witness<Witness, 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::ownership::INITIALIZE>(v2);
        0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::ownership::as_shared_object<Organization, 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::org_transfer::OrgTransfer>(&mut v1.id, 0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::typed_id::new<Organization>(&v1), arg0, &v3);
        v1
    }

    public fun delete_agent(arg0: &mut Organization, arg1: address, arg2: &0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::TxAuthority) {
        assert!(0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::ownership::can_act_as_owner<0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action::ADMIN>(&arg0.id, arg2), 1);
        0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::rbac::delete_agent(&mut arg0.rbac, arg1);
    }

    public entry fun delete_agent_(arg0: &mut Organization, arg1: address, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::begin(arg2);
        delete_agent(arg0, arg1, &v0);
    }

    public fun delete_role_and_agents(arg0: &mut Organization, arg1: 0x1::string::String, arg2: &0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::TxAuthority) {
        assert!(0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::ownership::can_act_as_owner<0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action::ADMIN>(&arg0.id, arg2), 1);
        0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::rbac::delete_role_and_agents(&mut arg0.rbac, arg1);
    }

    public entry fun delete_role_and_agents_(arg0: &mut Organization, arg1: 0x1::string::String, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::begin(arg2);
        delete_role_and_agents(arg0, arg1, &v0);
    }

    public fun destroy(arg0: Organization, arg1: &0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::TxAuthority) {
        assert!(0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::ownership::can_act_as_owner<0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action::ADMIN>(&arg0.id, arg1), 1);
        assert!(0x1::vector::is_empty<Package>(&arg0.packages), 3);
        let Organization {
            id       : v0,
            packages : v1,
            rbac     : _,
        } = arg0;
        0x2::object::delete(v0);
        0x1::vector::destroy_empty<Package>(v1);
    }

    public entry fun destroy_(arg0: Organization, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::begin(arg1);
        destroy(arg0, &v0);
    }

    public fun grant_action_to_role<T0>(arg0: &mut Organization, arg1: 0x1::string::String, arg2: &0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::TxAuthority) {
        assert!(0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::ownership::can_act_as_owner<0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action::ADMIN>(&arg0.id, arg2), 1);
        0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::rbac::grant_action_to_role<T0>(&mut arg0.rbac, arg1);
    }

    public entry fun grant_action_to_role_<T0>(arg0: &mut Organization, arg1: 0x1::string::String, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::begin(arg2);
        grant_action_to_role<T0>(arg0, arg1, &v0);
    }

    public fun is_endorsed_by(arg0: &Organization, arg1: address) : bool {
        let v0 = Endorsement{from: arg1};
        0x2::dynamic_field::exists_<Endorsement>(&arg0.id, v0)
    }

    public fun is_endorsed_by_num(arg0: &Organization, arg1: vector<address>) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v0 < 0x1::vector::length<address>(&arg1)) {
            if (is_endorsed_by(arg0, *0x1::vector::borrow<address>(&arg1, v0))) {
                v1 = v1 + 1;
            };
            v0 = v0 + 1;
        };
        v1
    }

    public fun package_uid(arg0: &Package) : &0x2::object::UID {
        &arg0.id
    }

    public fun package_uid_(arg0: &Organization, arg1: 0x2::object::ID) : &0x2::object::UID {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Package>(&arg0.packages)) {
            let v1 = 0x1::vector::borrow<Package>(&arg0.packages, v0);
            if (v1.package_id == arg1) {
                return &v1.id
            };
            v0 = v0 + 1;
        };
        abort 5
    }

    public fun package_uid_mut(arg0: &mut Package) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public fun package_uid_mut_(arg0: &mut Organization, arg1: 0x2::object::ID, arg2: &0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::TxAuthority) : &mut 0x2::object::UID {
        assert!(0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::ownership::can_borrow_uid_mut(&arg0.id, arg2), 0);
        let v0 = 0;
        while (v0 < 0x1::vector::length<Package>(&arg0.packages)) {
            let v1 = 0x1::vector::borrow_mut<Package>(&mut arg0.packages, v0);
            if (v1.package_id == arg1) {
                return &mut v1.id
            };
            v0 = v0 + 1;
        };
        abort 5
    }

    public fun packages(arg0: &Organization) : vector<0x2::object::ID> {
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<Package>(&arg0.packages)) {
            0x1::vector::push_back<0x2::object::ID>(&mut v0, 0x1::vector::borrow<Package>(&arg0.packages, v1).package_id);
            v1 = v1 + 1;
        };
        v0
    }

    public fun principal(arg0: &Organization) : address {
        0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::rbac::principal(&arg0.rbac)
    }

    public fun remove_endorsement(arg0: &mut Organization, arg1: address, arg2: &0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::TxAuthority) {
        assert!(0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::can_act_as_address<ENDORSE>(arg1, arg2), 0);
        let v0 = Endorsement{from: arg1};
        0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::dynamic_field2::drop<Endorsement, bool>(&mut arg0.id, v0);
    }

    public entry fun remove_endorsement_(arg0: &mut Organization, arg1: address, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::begin(arg2);
        remove_endorsement(arg0, arg1, &v0);
    }

    public fun remove_package(arg0: &mut Organization, arg1: 0x2::object::ID, arg2: &0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::TxAuthority) : Package {
        assert!(0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::ownership::can_act_as_owner<0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action::ADMIN>(&arg0.id, arg2), 1);
        let v0 = 0;
        while (v0 < 0x1::vector::length<Package>(&arg0.packages)) {
            if (0x1::vector::borrow<Package>(&arg0.packages, v0).package_id == arg1) {
                return 0x1::vector::remove<Package>(&mut arg0.packages, v0)
            };
            v0 = v0 + 1;
        };
        abort 5
    }

    public entry fun remove_package_(arg0: &mut Organization, arg1: 0x2::object::ID, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::begin(arg3);
        0x2::transfer::transfer<Package>(remove_package(arg0, arg1, &v0), arg2);
    }

    public fun return_and_share(arg0: Organization) {
        0x2::transfer::share_object<Organization>(arg0);
    }

    public fun revoke_action_from_role<T0>(arg0: &mut Organization, arg1: 0x1::string::String, arg2: &0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::TxAuthority) {
        assert!(0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::ownership::can_act_as_owner<0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action::ADMIN>(&arg0.id, arg2), 1);
        0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::rbac::revoke_action_from_role<T0>(&mut arg0.rbac, arg1);
    }

    public entry fun revoke_action_from_role_<T0>(arg0: &mut Organization, arg1: 0x1::string::String, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::begin(arg2);
        revoke_action_from_role<T0>(arg0, arg1, &v0);
    }

    public fun set_role_for_agent(arg0: &mut Organization, arg1: address, arg2: 0x1::string::String, arg3: &0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::TxAuthority) {
        assert!(0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::ownership::can_act_as_owner<0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::action::ADMIN>(&arg0.id, arg3), 1);
        0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::rbac::set_role_for_agent(&mut arg0.rbac, arg1, arg2);
    }

    public entry fun set_role_for_agent_(arg0: &mut Organization, arg1: address, arg2: 0x1::string::String, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::begin(arg3);
        set_role_for_agent(arg0, arg1, arg2, &v0);
    }

    public fun uid(arg0: &Organization) : &0x2::object::UID {
        &arg0.id
    }

    public fun uid_mut(arg0: &mut Organization, arg1: &0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::TxAuthority) : &mut 0x2::object::UID {
        assert!(0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::ownership::can_borrow_uid_mut(&arg0.id, arg1), 0);
        &mut arg0.id
    }

    // decompiled from Move bytecode v6
}

