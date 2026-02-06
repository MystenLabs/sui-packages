module 0x34cebb7685da10dbd43adfe5b7a71cd9c1358e24ce601b0dfa70dac3741931ff::channel {
    struct Channel has key {
        id: 0x2::object::UID,
        name: vector<u8>,
        creator: address,
        messages: 0x2::table_vec::TableVec<0x34cebb7685da10dbd43adfe5b7a71cd9c1358e24ce601b0dfa70dac3741931ff::message::Message>,
        message_count: u64,
        member_count: u64,
        dek_version: u64,
        encrypted_dek: vector<u8>,
        dek_history: 0x2::table_vec::TableVec<vector<u8>>,
        created_at: u64,
        updated_at: u64,
    }

    entry fun create_channel(arg0: vector<u8>, arg1: vector<u8>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        assert!(0x1::vector::length<u8>(&arg0) <= 256, 1);
        let v2 = Channel{
            id            : 0x2::object::new(arg3),
            name          : arg0,
            creator       : v0,
            messages      : 0x2::table_vec::empty<0x34cebb7685da10dbd43adfe5b7a71cd9c1358e24ce601b0dfa70dac3741931ff::message::Message>(arg3),
            message_count : 0,
            member_count  : 1,
            dek_version   : 0,
            encrypted_dek : 0x1::vector::empty<u8>(),
            dek_history   : 0x2::table_vec::empty<vector<u8>>(arg3),
            created_at    : v1,
            updated_at    : v1,
        };
        let v3 = 0x2::object::uid_to_inner(&v2.id);
        0x34cebb7685da10dbd43adfe5b7a71cd9c1358e24ce601b0dfa70dac3741931ff::events::emit_channel_created(v3, v0, v2.name, arg1);
        0x2::transfer::share_object<Channel>(v2);
        0x2::transfer::public_transfer<0x34cebb7685da10dbd43adfe5b7a71cd9c1358e24ce601b0dfa70dac3741931ff::member::MemberCap>(0x34cebb7685da10dbd43adfe5b7a71cd9c1358e24ce601b0dfa70dac3741931ff::member::new_creator(v3, arg1, v0, v1, arg3), v0);
    }

    entry fun create_invite(arg0: &Channel, arg1: &0x34cebb7685da10dbd43adfe5b7a71cd9c1358e24ce601b0dfa70dac3741931ff::member::MemberCap, arg2: vector<u8>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        verify_membership(arg0, arg1);
        0x34cebb7685da10dbd43adfe5b7a71cd9c1358e24ce601b0dfa70dac3741931ff::invite::share(0x34cebb7685da10dbd43adfe5b7a71cd9c1358e24ce601b0dfa70dac3741931ff::invite::new(0x2::object::uid_to_inner(&arg0.id), 0x34cebb7685da10dbd43adfe5b7a71cd9c1358e24ce601b0dfa70dac3741931ff::member::member(arg1), arg2, arg3, arg4, arg5, arg6));
    }

    public fun created_at(arg0: &Channel) : u64 {
        arg0.created_at
    }

    public fun creator(arg0: &Channel) : address {
        arg0.creator
    }

    public fun dek_version(arg0: &Channel) : u64 {
        arg0.dek_version
    }

    public fun encrypted_dek(arg0: &Channel) : vector<u8> {
        arg0.encrypted_dek
    }

    public fun get_historical_dek(arg0: &Channel, arg1: u64) : vector<u8> {
        assert!(arg1 > 0 && arg1 < arg0.dek_version, 8);
        *0x2::table_vec::borrow<vector<u8>>(&arg0.dek_history, arg1 - 1)
    }

    public fun get_message(arg0: &Channel, arg1: u64) : &0x34cebb7685da10dbd43adfe5b7a71cd9c1358e24ce601b0dfa70dac3741931ff::message::Message {
        0x2::table_vec::borrow<0x34cebb7685da10dbd43adfe5b7a71cd9c1358e24ce601b0dfa70dac3741931ff::message::Message>(&arg0.messages, arg1)
    }

    public fun id(arg0: &Channel) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    entry fun join_channel(arg0: &mut Channel, arg1: &mut 0x34cebb7685da10dbd43adfe5b7a71cd9c1358e24ce601b0dfa70dac3741931ff::invite::Invite, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::object::uid_to_inner(&arg0.id);
        let v2 = 0x2::clock::timestamp_ms(arg3);
        assert!(0x34cebb7685da10dbd43adfe5b7a71cd9c1358e24ce601b0dfa70dac3741931ff::invite::channel_id(arg1) == v1, 4);
        assert!(arg0.member_count < 100, 6);
        0x34cebb7685da10dbd43adfe5b7a71cd9c1358e24ce601b0dfa70dac3741931ff::invite::use_invite(arg1, v0, arg3);
        arg0.member_count = arg0.member_count + 1;
        arg0.updated_at = v2;
        0x34cebb7685da10dbd43adfe5b7a71cd9c1358e24ce601b0dfa70dac3741931ff::events::emit_member_joined(v1, v0, arg2, true);
        0x2::transfer::public_transfer<0x34cebb7685da10dbd43adfe5b7a71cd9c1358e24ce601b0dfa70dac3741931ff::member::MemberCap>(0x34cebb7685da10dbd43adfe5b7a71cd9c1358e24ce601b0dfa70dac3741931ff::member::new_member(v1, arg2, v0, v2, arg4), v0);
    }

    entry fun leave_channel(arg0: &mut Channel, arg1: 0x34cebb7685da10dbd43adfe5b7a71cd9c1358e24ce601b0dfa70dac3741931ff::member::MemberCap, arg2: &0x2::clock::Clock) {
        verify_membership(arg0, &arg1);
        arg0.member_count = arg0.member_count - 1;
        arg0.updated_at = 0x2::clock::timestamp_ms(arg2);
        0x34cebb7685da10dbd43adfe5b7a71cd9c1358e24ce601b0dfa70dac3741931ff::events::emit_member_left(0x2::object::uid_to_inner(&arg0.id), 0x34cebb7685da10dbd43adfe5b7a71cd9c1358e24ce601b0dfa70dac3741931ff::member::member(&arg1));
        0x34cebb7685da10dbd43adfe5b7a71cd9c1358e24ce601b0dfa70dac3741931ff::member::burn(arg1);
    }

    public fun member_count(arg0: &Channel) : u64 {
        arg0.member_count
    }

    public fun message_count(arg0: &Channel) : u64 {
        arg0.message_count
    }

    public fun name(arg0: &Channel) : vector<u8> {
        arg0.name
    }

    public fun namespace(arg0: &Channel) : vector<u8> {
        let v0 = 0x2::object::uid_to_inner(&arg0.id);
        0x2::object::id_to_bytes(&v0)
    }

    entry fun rotate_dek(arg0: &mut Channel, arg1: &0x34cebb7685da10dbd43adfe5b7a71cd9c1358e24ce601b0dfa70dac3741931ff::member::MemberCap, arg2: vector<u8>, arg3: &0x2::clock::Clock) {
        verify_membership(arg0, arg1);
        assert!(0x34cebb7685da10dbd43adfe5b7a71cd9c1358e24ce601b0dfa70dac3741931ff::member::is_admin(arg1), 2);
        assert!(0x1::vector::length<u8>(&arg0.encrypted_dek) > 0, 5);
        0x2::table_vec::push_back<vector<u8>>(&mut arg0.dek_history, arg0.encrypted_dek);
        arg0.encrypted_dek = arg2;
        arg0.dek_version = arg0.dek_version + 1;
        arg0.updated_at = 0x2::clock::timestamp_ms(arg3);
        0x34cebb7685da10dbd43adfe5b7a71cd9c1358e24ce601b0dfa70dac3741931ff::events::emit_dek_rotated(0x2::object::uid_to_inner(&arg0.id), arg0.dek_version, 0x34cebb7685da10dbd43adfe5b7a71cd9c1358e24ce601b0dfa70dac3741931ff::member::member(arg1));
    }

    entry fun send_message(arg0: &mut Channel, arg1: &0x34cebb7685da10dbd43adfe5b7a71cd9c1358e24ce601b0dfa70dac3741931ff::member::MemberCap, arg2: u8, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: &0x2::clock::Clock) {
        verify_membership(arg0, arg1);
        assert!(0x1::vector::length<u8>(&arg0.encrypted_dek) > 0, 5);
        let v0 = 0x34cebb7685da10dbd43adfe5b7a71cd9c1358e24ce601b0dfa70dac3741931ff::member::member(arg1);
        let v1 = 0x34cebb7685da10dbd43adfe5b7a71cd9c1358e24ce601b0dfa70dac3741931ff::member::agent_id(arg1);
        let v2 = 0x2::clock::timestamp_ms(arg6);
        let v3 = arg0.message_count;
        0x34cebb7685da10dbd43adfe5b7a71cd9c1358e24ce601b0dfa70dac3741931ff::events::emit_message_sent(0x2::object::uid_to_inner(&arg0.id), v3, v0, v1, arg2, arg3, arg4, arg0.dek_version);
        0x2::table_vec::push_back<0x34cebb7685da10dbd43adfe5b7a71cd9c1358e24ce601b0dfa70dac3741931ff::message::Message>(&mut arg0.messages, 0x34cebb7685da10dbd43adfe5b7a71cd9c1358e24ce601b0dfa70dac3741931ff::message::new(v3, v0, v1, arg2, arg3, arg4, arg0.dek_version, arg5, v2));
        arg0.message_count = arg0.message_count + 1;
        arg0.updated_at = v2;
    }

    entry fun set_encrypted_dek(arg0: &mut Channel, arg1: &0x34cebb7685da10dbd43adfe5b7a71cd9c1358e24ce601b0dfa70dac3741931ff::member::MemberCap, arg2: vector<u8>, arg3: &0x2::clock::Clock) {
        verify_membership(arg0, arg1);
        assert!(0x34cebb7685da10dbd43adfe5b7a71cd9c1358e24ce601b0dfa70dac3741931ff::member::is_creator(arg1), 3);
        assert!(0x1::vector::length<u8>(&arg0.encrypted_dek) == 0, 8);
        arg0.encrypted_dek = arg2;
        arg0.dek_version = 1;
        arg0.updated_at = 0x2::clock::timestamp_ms(arg3);
        0x34cebb7685da10dbd43adfe5b7a71cd9c1358e24ce601b0dfa70dac3741931ff::events::emit_dek_rotated(0x2::object::uid_to_inner(&arg0.id), arg0.dek_version, 0x34cebb7685da10dbd43adfe5b7a71cd9c1358e24ce601b0dfa70dac3741931ff::member::member(arg1));
    }

    public fun updated_at(arg0: &Channel) : u64 {
        arg0.updated_at
    }

    fun verify_membership(arg0: &Channel, arg1: &0x34cebb7685da10dbd43adfe5b7a71cd9c1358e24ce601b0dfa70dac3741931ff::member::MemberCap) {
        assert!(0x34cebb7685da10dbd43adfe5b7a71cd9c1358e24ce601b0dfa70dac3741931ff::member::channel_id(arg1) == 0x2::object::uid_to_inner(&arg0.id), 1);
    }

    // decompiled from Move bytecode v6
}

