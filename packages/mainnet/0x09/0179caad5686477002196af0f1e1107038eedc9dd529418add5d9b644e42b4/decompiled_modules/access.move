module 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::access {
    struct ReturnOwnerCapReceipt {
        owner_id: address,
        owner_cap_id: 0x2::object::ID,
    }

    struct AdminACL has key {
        id: 0x2::object::UID,
        authorized_sponsors: 0x2::table::Table<address, bool>,
    }

    struct OwnerCap<phantom T0> has key {
        id: 0x2::object::UID,
        authorized_object_id: 0x2::object::ID,
    }

    struct ServerAddressRegistry has key {
        id: 0x2::object::UID,
        authorized_address: 0x2::table::Table<address, bool>,
    }

    struct OwnerCapCreatedEvent has copy, drop {
        owner_cap_id: 0x2::object::ID,
        authorized_object_id: 0x2::object::ID,
    }

    struct OwnerCapTransferred has copy, drop {
        owner_cap_id: 0x2::object::ID,
        authorized_object_id: 0x2::object::ID,
        previous_owner: address,
        owner: address,
    }

    fun transfer<T0: key>(arg0: OwnerCap<T0>, arg1: address, arg2: address) {
        let v0 = OwnerCapTransferred{
            owner_cap_id         : 0x2::object::id<OwnerCap<T0>>(&arg0),
            authorized_object_id : arg0.authorized_object_id,
            previous_owner       : arg1,
            owner                : arg2,
        };
        0x2::event::emit<OwnerCapTransferred>(v0);
        0x2::transfer::transfer<OwnerCap<T0>>(arg0, arg2);
    }

    public fun add_sponsor_to_acl(arg0: &mut AdminACL, arg1: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::world::GovernorCap, arg2: address) {
        0x2::table::add<address, bool>(&mut arg0.authorized_sponsors, arg2, true);
    }

    public fun admin_acl_id(arg0: &AdminACL) : 0x2::object::ID {
        0x2::object::id<AdminACL>(arg0)
    }

    public(friend) fun create_and_transfer_owner_cap<T0: key>(arg0: 0x2::object::ID, arg1: &AdminACL, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = create_owner_cap_by_id<T0>(arg0, arg1, arg3);
        transfer<T0>(v0, @0x0, arg2);
        0x2::object::id<OwnerCap<T0>>(&v0)
    }

    public fun create_owner_cap<T0: key>(arg0: &AdminACL, arg1: &T0, arg2: &mut 0x2::tx_context::TxContext) : OwnerCap<T0> {
        verify_sponsor(arg0, arg2);
        let v0 = 0x2::object::id<T0>(arg1);
        let v1 = OwnerCap<T0>{
            id                   : 0x2::object::new(arg2),
            authorized_object_id : v0,
        };
        let v2 = OwnerCapCreatedEvent{
            owner_cap_id         : 0x2::object::id<OwnerCap<T0>>(&v1),
            authorized_object_id : v0,
        };
        0x2::event::emit<OwnerCapCreatedEvent>(v2);
        v1
    }

    public fun create_owner_cap_by_id<T0: key>(arg0: 0x2::object::ID, arg1: &AdminACL, arg2: &mut 0x2::tx_context::TxContext) : OwnerCap<T0> {
        verify_sponsor(arg1, arg2);
        let v0 = OwnerCap<T0>{
            id                   : 0x2::object::new(arg2),
            authorized_object_id : arg0,
        };
        let v1 = OwnerCapCreatedEvent{
            owner_cap_id         : 0x2::object::id<OwnerCap<T0>>(&v0),
            authorized_object_id : arg0,
        };
        0x2::event::emit<OwnerCapCreatedEvent>(v1);
        v0
    }

    public(friend) fun create_return_receipt(arg0: 0x2::object::ID, arg1: address) : ReturnOwnerCapReceipt {
        ReturnOwnerCapReceipt{
            owner_id     : arg1,
            owner_cap_id : arg0,
        }
    }

    public fun delete_owner_cap<T0: key>(arg0: OwnerCap<T0>, arg1: &AdminACL, arg2: &0x2::tx_context::TxContext) {
        verify_sponsor(arg1, arg2);
        let OwnerCap {
            id                   : v0,
            authorized_object_id : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ServerAddressRegistry{
            id                 : 0x2::object::new(arg0),
            authorized_address : 0x2::table::new<address, bool>(arg0),
        };
        let v1 = AdminACL{
            id                  : 0x2::object::new(arg0),
            authorized_sponsors : 0x2::table::new<address, bool>(arg0),
        };
        0x2::transfer::share_object<ServerAddressRegistry>(v0);
        0x2::transfer::share_object<AdminACL>(v1);
    }

    public fun is_authorized<T0: key>(arg0: &OwnerCap<T0>, arg1: 0x2::object::ID) : bool {
        arg0.authorized_object_id == arg1
    }

    public fun is_authorized_server_address(arg0: &ServerAddressRegistry, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.authorized_address, arg1)
    }

    public fun receive_owner_cap<T0: key>(arg0: &mut 0x2::object::UID, arg1: 0x2::transfer::Receiving<OwnerCap<T0>>) : OwnerCap<T0> {
        0x2::transfer::receive<OwnerCap<T0>>(arg0, arg1)
    }

    public fun register_server_address(arg0: &mut ServerAddressRegistry, arg1: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::world::GovernorCap, arg2: address) {
        0x2::table::add<address, bool>(&mut arg0.authorized_address, arg2, true);
    }

    public fun remove_server_address(arg0: &mut ServerAddressRegistry, arg1: &0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::world::GovernorCap, arg2: address) {
        0x2::table::remove<address, bool>(&mut arg0.authorized_address, arg2);
    }

    public fun return_owner_cap_to_object<T0: key>(arg0: OwnerCap<T0>, arg1: ReturnOwnerCapReceipt, arg2: address) {
        validate_return_receipt(arg1, 0x2::object::id<OwnerCap<T0>>(&arg0), arg2);
        transfer_owner_cap<T0>(arg0, arg2);
    }

    public fun server_address_registry_id(arg0: &ServerAddressRegistry) : 0x2::object::ID {
        0x2::object::id<ServerAddressRegistry>(arg0)
    }

    public fun transfer_owner_cap<T0: key>(arg0: OwnerCap<T0>, arg1: address) {
        0x2::transfer::transfer<OwnerCap<T0>>(arg0, arg1);
    }

    public fun transfer_owner_cap_to_address<T0: key>(arg0: OwnerCap<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = 0x1::type_name::module_string(&v0) == 0x1::ascii::string(b"character") && 0x1::type_name::datatype_string(&v0) == 0x1::ascii::string(b"Character");
        assert!(!v1, 13835058544908435457);
        transfer<T0>(arg0, 0x2::tx_context::sender(arg2), arg1);
    }

    public fun transfer_owner_cap_with_receipt<T0: key>(arg0: OwnerCap<T0>, arg1: ReturnOwnerCapReceipt, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let ReturnOwnerCapReceipt {
            owner_id     : _,
            owner_cap_id : v1,
        } = arg1;
        assert!(v1 == 0x2::object::id<OwnerCap<T0>>(&arg0), 13835903064328241159);
        transfer_owner_cap_to_address<T0>(arg0, arg2, arg3);
    }

    fun validate_return_receipt(arg0: ReturnOwnerCapReceipt, arg1: 0x2::object::ID, arg2: address) {
        let ReturnOwnerCapReceipt {
            owner_id     : v0,
            owner_cap_id : v1,
        } = arg0;
        assert!(v0 == arg2, 13835622259366297605);
        assert!(v1 == arg1, 13835903738638106631);
    }

    public fun verify_sponsor(arg0: &AdminACL, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sponsor(arg1);
        let v1 = if (0x1::option::is_some<address>(&v0)) {
            *0x1::option::borrow<address>(&v0)
        } else {
            0x2::tx_context::sender(arg1)
        };
        assert!(0x2::table::contains<address, bool>(&arg0.authorized_sponsors, v1), 13835340273288347651);
    }

    // decompiled from Move bytecode v6
}

