module 0x4a1581a9a502343957f3b503e0ac1517f3f596c8f67b6a9b5b33bba65863b8d1::group {
    struct PrivateGroup has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        admin: address,
        members: vector<address>,
        member_count: u64,
        message_count: u64,
        created_at: u64,
    }

    public fun admin(arg0: &PrivateGroup) : address {
        arg0.admin
    }

    entry fun create_private_group(arg0: vector<u8>, arg1: vector<address>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::clock::timestamp_ms(arg2) / 1000;
        let v2 = 0x1::vector::length<address>(&arg1);
        let v3 = PrivateGroup{
            id            : 0x2::object::new(arg3),
            name          : 0x1::string::utf8(arg0),
            admin         : v0,
            members       : arg1,
            member_count  : v2,
            message_count : 0,
            created_at    : v1,
        };
        0x4a1581a9a502343957f3b503e0ac1517f3f596c8f67b6a9b5b33bba65863b8d1::events::emit_group_created(0x2::object::uid_to_inner(&v3.id), v0, v2, v1);
        0x2::transfer::share_object<PrivateGroup>(v3);
    }

    public fun get_info(arg0: &PrivateGroup) : (0x1::string::String, address, u64, u64) {
        (arg0.name, arg0.admin, arg0.member_count, arg0.message_count)
    }

    public fun member_count(arg0: &PrivateGroup) : u64 {
        arg0.member_count
    }

    public fun message_count(arg0: &PrivateGroup) : u64 {
        arg0.message_count
    }

    public fun name(arg0: &PrivateGroup) : 0x1::string::String {
        arg0.name
    }

    entry fun send_group_message(arg0: &mut PrivateGroup, arg1: vector<u8>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x1::vector::contains<address>(&arg0.members, &v0), 21);
        arg0.message_count = arg0.message_count + 1;
        0x4a1581a9a502343957f3b503e0ac1517f3f596c8f67b6a9b5b33bba65863b8d1::events::emit_group_message_sent(0x2::object::uid_to_inner(&arg0.id), v0, 0x2::clock::timestamp_ms(arg2) / 1000);
    }

    entry fun set_members(arg0: &mut PrivateGroup, arg1: vector<address>, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg2), 20);
        arg0.member_count = 0x1::vector::length<address>(&arg1);
        arg0.members = arg1;
    }

    // decompiled from Move bytecode v6
}

