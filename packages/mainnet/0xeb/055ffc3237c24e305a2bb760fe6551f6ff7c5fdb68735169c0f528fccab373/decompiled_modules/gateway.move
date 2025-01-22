module 0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::gateway {
    struct Gateway has key {
        id: 0x2::object::UID,
        inner: 0x2::versioned::Versioned,
    }

    fun version_control() : 0x647a3b34b3a16f5f00443bdafd13d281983b2280703ab4f416cf706e6d739087::version_control::VersionControl {
        let v0 = 0x1::vector::empty<0x1::ascii::String>();
        let v1 = vector[b"approve_messages", b"rotate_signers", b"is_message_approved", b"is_message_executed", b"take_approved_message", b"send_message", b"allow_function", b"disallow_function"];
        0x1::vector::reverse<vector<u8>>(&mut v1);
        while (0x1::vector::length<vector<u8>>(&v1) != 0) {
            0x1::vector::push_back<0x1::ascii::String>(&mut v0, 0x1::ascii::string(0x1::vector::pop_back<vector<u8>>(&mut v1)));
        };
        0x1::vector::destroy_empty<vector<u8>>(v1);
        let v2 = 0x1::vector::empty<vector<0x1::ascii::String>>();
        0x1::vector::push_back<vector<0x1::ascii::String>>(&mut v2, v0);
        0x647a3b34b3a16f5f00443bdafd13d281983b2280703ab4f416cf706e6d739087::version_control::new(v2)
    }

    entry fun setup(arg0: &0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::owner_cap::OwnerCap, arg1: address, arg2: address, arg3: u64, arg4: u64, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(arg5);
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::length<u8>(&v1) == 0, 9223372462056538111);
        let v2 = Gateway{
            id    : 0x2::object::new(arg7),
            inner : 0x2::versioned::create<0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::gateway_v0::Gateway_v0>(0, 0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::gateway_v0::new(arg1, 0x2::table::new<0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::bytes32::Bytes32, 0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::message_status::MessageStatus>(arg7), 0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::auth::setup(0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::bytes32::new(arg2), arg3, arg4, 0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::weighted_signers::peel(&mut v0), arg6, arg7), version_control()), arg7),
        };
        0x2::transfer::share_object<Gateway>(v2);
    }

    entry fun allow_function(arg0: &mut Gateway, arg1: &0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::owner_cap::OwnerCap, arg2: u64, arg3: 0x1::ascii::String) {
        let v0 = 0x2::versioned::load_value_mut<0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::gateway_v0::Gateway_v0>(&mut arg0.inner);
        0x647a3b34b3a16f5f00443bdafd13d281983b2280703ab4f416cf706e6d739087::version_control::check(0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::gateway_v0::version_control(v0), 0, 0x1::ascii::string(b"allow_function"));
        0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::gateway_v0::allow_function(v0, arg2, arg3);
    }

    entry fun approve_messages(arg0: &mut Gateway, arg1: vector<u8>, arg2: vector<u8>) {
        let v0 = 0x2::versioned::load_value_mut<0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::gateway_v0::Gateway_v0>(&mut arg0.inner);
        0x647a3b34b3a16f5f00443bdafd13d281983b2280703ab4f416cf706e6d739087::version_control::check(0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::gateway_v0::version_control(v0), 0, 0x1::ascii::string(b"approve_messages"));
        0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::gateway_v0::approve_messages(v0, arg1, arg2);
    }

    entry fun disallow_function(arg0: &mut Gateway, arg1: &0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::owner_cap::OwnerCap, arg2: u64, arg3: 0x1::ascii::String) {
        let v0 = 0x2::versioned::load_value_mut<0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::gateway_v0::Gateway_v0>(&mut arg0.inner);
        0x647a3b34b3a16f5f00443bdafd13d281983b2280703ab4f416cf706e6d739087::version_control::check(0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::gateway_v0::version_control(v0), 0, 0x1::ascii::string(b"disallow_function"));
        0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::gateway_v0::disallow_function(v0, arg2, arg3);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::owner_cap::OwnerCap>(0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::owner_cap::create(arg0), 0x2::tx_context::sender(arg0));
    }

    public fun is_message_approved(arg0: &Gateway, arg1: 0x1::ascii::String, arg2: 0x1::ascii::String, arg3: 0x1::ascii::String, arg4: address, arg5: 0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::bytes32::Bytes32) : bool {
        let v0 = 0x2::versioned::load_value<0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::gateway_v0::Gateway_v0>(&arg0.inner);
        0x647a3b34b3a16f5f00443bdafd13d281983b2280703ab4f416cf706e6d739087::version_control::check(0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::gateway_v0::version_control(v0), 0, 0x1::ascii::string(b"is_message_approved"));
        0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::gateway_v0::is_message_approved(v0, arg1, arg2, arg3, arg4, arg5)
    }

    public fun is_message_executed(arg0: &Gateway, arg1: 0x1::ascii::String, arg2: 0x1::ascii::String) : bool {
        let v0 = 0x2::versioned::load_value<0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::gateway_v0::Gateway_v0>(&arg0.inner);
        0x647a3b34b3a16f5f00443bdafd13d281983b2280703ab4f416cf706e6d739087::version_control::check(0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::gateway_v0::version_control(v0), 0, 0x1::ascii::string(b"is_message_executed"));
        0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::gateway_v0::is_message_executed(v0, arg1, arg2)
    }

    public fun prepare_message(arg0: &0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::channel::Channel, arg1: 0x1::ascii::String, arg2: 0x1::ascii::String, arg3: vector<u8>) : 0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::message_ticket::MessageTicket {
        0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::message_ticket::new(0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::channel::to_address(arg0), arg1, arg2, arg3, 0)
    }

    entry fun rotate_signers(arg0: &mut Gateway, arg1: &0x2::clock::Clock, arg2: vector<u8>, arg3: vector<u8>, arg4: &0x2::tx_context::TxContext) {
        let v0 = 0x2::versioned::load_value_mut<0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::gateway_v0::Gateway_v0>(&mut arg0.inner);
        0x647a3b34b3a16f5f00443bdafd13d281983b2280703ab4f416cf706e6d739087::version_control::check(0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::gateway_v0::version_control(v0), 0, 0x1::ascii::string(b"rotate_signers"));
        0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::gateway_v0::rotate_signers(v0, arg1, arg2, arg3, arg4);
    }

    public fun send_message(arg0: &Gateway, arg1: 0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::message_ticket::MessageTicket) {
        let v0 = 0x2::versioned::load_value<0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::gateway_v0::Gateway_v0>(&arg0.inner);
        0x647a3b34b3a16f5f00443bdafd13d281983b2280703ab4f416cf706e6d739087::version_control::check(0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::gateway_v0::version_control(v0), 0, 0x1::ascii::string(b"send_message"));
        0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::gateway_v0::send_message(v0, arg1, 0);
    }

    public fun take_approved_message(arg0: &mut Gateway, arg1: 0x1::ascii::String, arg2: 0x1::ascii::String, arg3: 0x1::ascii::String, arg4: address, arg5: vector<u8>) : 0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::channel::ApprovedMessage {
        let v0 = 0x2::versioned::load_value_mut<0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::gateway_v0::Gateway_v0>(&mut arg0.inner);
        0x647a3b34b3a16f5f00443bdafd13d281983b2280703ab4f416cf706e6d739087::version_control::check(0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::gateway_v0::version_control(v0), 0, 0x1::ascii::string(b"take_approved_message"));
        0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::gateway_v0::take_approved_message(v0, arg1, arg2, arg3, arg4, arg5)
    }

    // decompiled from Move bytecode v6
}

