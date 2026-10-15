module 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin {
    struct Version has key {
        id: 0x2::object::UID,
        value: u64,
        authority: 0x2::vec_set::VecSet<address>,
        u64_padding: vector<u64>,
    }

    struct ExtensionRegistered has copy, drop {
        witness: 0x1::type_name::TypeName,
    }

    struct AdminEvent has copy, drop {
        sender: address,
        scope: u8,
        kind: u8,
        index: u64,
        types: vector<0x1::type_name::TypeName>,
        ids: vector<0x2::object::ID>,
        values: vector<u64>,
    }

    entry fun add_authorized_user(arg0: &mut Version, arg1: address, arg2: &0x2::tx_context::TxContext) {
        verify(arg0, arg2);
        assert!(!0x2::vec_set::contains<address>(&arg0.authority, &arg1), 0);
        0x2::vec_set::insert<address>(&mut arg0.authority, arg1);
    }

    public fun assert_authority(arg0: &Version, arg1: &0x2::tx_context::TxContext) {
        verify(arg0, arg1);
    }

    public fun assert_version(arg0: &Version) {
        version_check(arg0);
    }

    public(friend) fun emit_admin_event(arg0: u8, arg1: u8, arg2: u64, arg3: vector<0x1::type_name::TypeName>, arg4: vector<0x2::object::ID>, arg5: vector<u64>, arg6: &0x2::tx_context::TxContext) {
        let v0 = AdminEvent{
            sender : 0x2::tx_context::sender(arg6),
            scope  : arg0,
            kind   : arg1,
            index  : arg2,
            types  : arg3,
            ids    : arg4,
            values : arg5,
        };
        0x2::event::emit<AdminEvent>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Version{
            id          : 0x2::object::new(arg0),
            value       : 6,
            authority   : 0x2::vec_set::singleton<address>(0x2::tx_context::sender(arg0)),
            u64_padding : vector[],
        };
        0x2::transfer::share_object<Version>(v0);
    }

    public fun register_extension<T0: drop>(arg0: &mut Version, arg1: &0x2::tx_context::TxContext) {
        verify(arg0, arg1);
        let v0 = 0x1::string::utf8(b"extension_witness");
        assert!(!0x2::dynamic_field::exists_<0x1::string::String>(&arg0.id, v0), 3000);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        0x2::dynamic_field::add<0x1::string::String, 0x1::type_name::TypeName>(&mut arg0.id, v0, v1);
        let v2 = ExtensionRegistered{witness: v1};
        0x2::event::emit<ExtensionRegistered>(v2);
    }

    entry fun remove_authorized_user(arg0: &mut Version, arg1: address, arg2: &0x2::tx_context::TxContext) {
        verify(arg0, arg2);
        assert!(0x2::vec_set::contains<address>(&arg0.authority, &arg1), 1);
        0x2::vec_set::remove<address>(&mut arg0.authority, &arg1);
        assert!(0x2::vec_set::length<address>(&arg0.authority) > 0, 2);
    }

    public fun uid(arg0: &Version) : &0x2::object::UID {
        &arg0.id
    }

    public fun uid_mut<T0: drop>(arg0: &mut Version, arg1: T0) : &mut 0x2::object::UID {
        let v0 = 0x1::string::utf8(b"extension_witness");
        assert!(0x2::dynamic_field::exists_<0x1::string::String>(&arg0.id, v0), 3001);
        assert!(*0x2::dynamic_field::borrow<0x1::string::String, 0x1::type_name::TypeName>(&arg0.id, v0) == 0x1::type_name::with_defining_ids<T0>(), 3002);
        &mut arg0.id
    }

    entry fun upgrade(arg0: &mut Version, arg1: &0x2::tx_context::TxContext) {
        verify(arg0, arg1);
        arg0.value = 6;
    }

    public fun value(arg0: &Version) : u64 {
        arg0.value
    }

    public fun verify(arg0: &Version, arg1: &0x2::tx_context::TxContext) {
        version_check(arg0);
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x2::vec_set::contains<address>(&arg0.authority, &v0), 4);
    }

    public fun verify_authority_only(arg0: &Version, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x2::vec_set::contains<address>(&arg0.authority, &v0), 4);
    }

    public fun version_check(arg0: &Version) {
        assert!(6 >= arg0.value, 3);
    }

    // decompiled from Move bytecode v7
}

