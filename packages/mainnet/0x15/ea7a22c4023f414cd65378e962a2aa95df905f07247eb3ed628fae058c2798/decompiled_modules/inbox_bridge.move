module 0x15ea7a22c4023f414cd65378e962a2aa95df905f07247eb3ed628fae058c2798::inbox_bridge {
    struct InboxBridge has key {
        id: 0x2::object::UID,
        package_version: u64,
        registered_packages: 0x2::table::Table<0x1::ascii::String, 0x1::type_name::TypeName>,
        inbox_counter: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
        bridge_id: 0x2::object::ID,
    }

    struct INBOX_BRIDGE has drop {
        dummy_field: bool,
    }

    struct PackageRegisteredEvent has copy, drop {
        package_addr: 0x1::ascii::String,
        witness_type: 0x1::type_name::TypeName,
    }

    struct InboxMessageEvent has copy, drop {
        version: u8,
        msg_id: u64,
        caller: address,
        msg_hash: vector<u8>,
        timestamp: u64,
        msg_data: vector<u8>,
    }

    fun assert_bridge_version(arg0: &InboxBridge) {
        assert!(arg0.package_version == 1, 5);
    }

    fun create_inbox_message_hash(arg0: u64, arg1: address, arg2: &vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::push_back<u8>(&mut v0, 1);
        0x1::vector::append<u8>(&mut v0, 0x15ea7a22c4023f414cd65378e962a2aa95df905f07247eb3ed628fae058c2798::utils::u64_to_be_bytes(arg0));
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg1));
        0x1::vector::append<u8>(&mut v0, *arg2);
        0x1::hash::sha2_256(v0)
    }

    public fun inbox_counter(arg0: &InboxBridge) : u64 {
        arg0.inbox_counter
    }

    fun init(arg0: INBOX_BRIDGE, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<INBOX_BRIDGE>(arg0, arg1);
        let (v0, v1) = init_bridge(arg1);
        0x2::transfer::share_object<InboxBridge>(v0);
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg1));
    }

    fun init_bridge(arg0: &mut 0x2::tx_context::TxContext) : (InboxBridge, AdminCap) {
        let v0 = InboxBridge{
            id                  : 0x2::object::new(arg0),
            package_version     : 1,
            registered_packages : 0x2::table::new<0x1::ascii::String, 0x1::type_name::TypeName>(arg0),
            inbox_counter       : 0,
        };
        let v1 = AdminCap{
            id        : 0x2::object::new(arg0),
            bridge_id : 0x2::object::id<InboxBridge>(&v0),
        };
        (v0, v1)
    }

    public fun is_registered(arg0: &InboxBridge, arg1: 0x1::ascii::String) : bool {
        0x2::table::contains<0x1::ascii::String, 0x1::type_name::TypeName>(&arg0.registered_packages, arg1)
    }

    public fun migrate_bridge_version(arg0: &AdminCap, arg1: &mut InboxBridge) {
        assert_bridge_version(arg1);
        assert!(arg0.bridge_id == 0x2::object::id<InboxBridge>(arg1), 6);
        arg1.package_version = 1 + 1;
    }

    public fun register<T0: drop>(arg0: &mut InboxBridge, arg1: &0x2::package::Publisher, arg2: &mut 0x2::tx_context::TxContext) {
        assert_bridge_version(arg0);
        assert!(0x2::package::from_package<T0>(arg1), 4);
        let v0 = *0x2::package::published_package(arg1);
        let v1 = 0x1::type_name::with_original_ids<T0>();
        assert!(!0x2::table::contains<0x1::ascii::String, 0x1::type_name::TypeName>(&arg0.registered_packages, v0), 1);
        0x2::table::add<0x1::ascii::String, 0x1::type_name::TypeName>(&mut arg0.registered_packages, v0, v1);
        let v2 = PackageRegisteredEvent{
            package_addr : v0,
            witness_type : v1,
        };
        0x2::event::emit<PackageRegisteredEvent>(v2);
    }

    public fun submit_inbox_message<T0: drop>(arg0: &mut InboxBridge, arg1: T0, arg2: vector<u8>, arg3: &0x2::clock::Clock) : (u64, vector<u8>) {
        assert_bridge_version(arg0);
        let v0 = 0x1::type_name::with_original_ids<T0>();
        let v1 = 0x1::type_name::address_string(&v0);
        assert!(0x2::table::contains<0x1::ascii::String, 0x1::type_name::TypeName>(&arg0.registered_packages, v1), 2);
        assert!(v0 == *0x2::table::borrow<0x1::ascii::String, 0x1::type_name::TypeName>(&arg0.registered_packages, v1), 3);
        let v2 = arg0.inbox_counter;
        arg0.inbox_counter = v2 + 1;
        let v3 = 0x2::address::from_ascii_bytes(0x1::ascii::as_bytes(&v1));
        let v4 = create_inbox_message_hash(v2, v3, &arg2);
        let v5 = InboxMessageEvent{
            version   : 1,
            msg_id    : v2,
            caller    : v3,
            msg_hash  : v4,
            timestamp : 0x2::clock::timestamp_ms(arg3) / 1000,
            msg_data  : arg2,
        };
        0x2::event::emit<InboxMessageEvent>(v5);
        (v2, v4)
    }

    entry fun submit_inbox_message_as_eoa(arg0: &mut InboxBridge, arg1: vector<u8>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert_bridge_version(arg0);
        let v0 = arg0.inbox_counter;
        arg0.inbox_counter = v0 + 1;
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = InboxMessageEvent{
            version   : 1,
            msg_id    : v0,
            caller    : v1,
            msg_hash  : create_inbox_message_hash(v0, v1, &arg1),
            timestamp : 0x2::clock::timestamp_ms(arg2) / 1000,
            msg_data  : arg1,
        };
        0x2::event::emit<InboxMessageEvent>(v2);
    }

    // decompiled from Move bytecode v6
}

