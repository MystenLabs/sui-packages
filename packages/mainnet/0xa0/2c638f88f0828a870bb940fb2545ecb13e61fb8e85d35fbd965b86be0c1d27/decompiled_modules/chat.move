module 0xa02c638f88f0828a870bb940fb2545ecb13e61fb8e85d35fbd965b86be0c1d27::chat {
    struct Channel has store, key {
        id: 0x2::object::UID,
        moderators: vector<address>,
        current_message_counter: u64,
        owner: address,
    }

    struct Message has store, key {
        id: 0x2::object::UID,
        message_number: u64,
        sender: address,
        suins: 0x1::option::Option<0x1::string::String>,
        timestamp: u64,
        message: 0x1::string::String,
    }

    public entry fun add_mod(arg0: address, arg1: &mut Channel, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(is_sender_mod(0x2::tx_context::sender(arg2), arg1) || is_sender_owner(0x2::tx_context::sender(arg2), arg1), 1);
        0x1::vector::push_back<address>(&mut arg1.moderators, arg0);
    }

    public entry fun batch_delete(arg0: vector<u64>, arg1: &mut Channel, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(is_sender_mod(0x2::tx_context::sender(arg2), arg1) || is_sender_owner(0x2::tx_context::sender(arg2), arg1), 1);
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(&arg0)) {
            let v1 = 0x1::vector::borrow<u64>(&arg0, v0);
            v0 = v0 + 1;
            let Message {
                id             : v2,
                message_number : _,
                sender         : _,
                suins          : _,
                timestamp      : _,
                message        : _,
            } = 0x2::dynamic_field::remove<address, Message>(&mut arg1.id, 0x2::address::from_u256((*v1 as u256)));
            0x2::object::delete(v2);
        };
    }

    public entry fun create_channel(arg0: vector<address>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Channel{
            id                      : 0x2::object::new(arg1),
            moderators              : arg0,
            current_message_counter : 18446744073709551615,
            owner                   : 0x2::tx_context::sender(arg1),
        };
        0x2::transfer::share_object<Channel>(v0);
    }

    public fun current_message_counter(arg0: &Channel) : u64 {
        arg0.current_message_counter
    }

    public entry fun delete_message(arg0: u64, arg1: &mut Channel, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(is_sender_mod(0x2::tx_context::sender(arg2), arg1) || is_sender_owner(0x2::tx_context::sender(arg2), arg1), 1);
        let Message {
            id             : v0,
            message_number : _,
            sender         : _,
            suins          : _,
            timestamp      : _,
            message        : _,
        } = 0x2::dynamic_field::remove<address, Message>(&mut arg1.id, 0x2::address::from_u256((arg0 as u256)));
        0x2::object::delete(v0);
    }

    fun is_sender_mod(arg0: address, arg1: &Channel) : bool {
        let v0 = moderators(arg1);
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(&v0)) {
            if (arg0 == *0x1::vector::borrow<address>(&v0, v1)) {
                return true
            };
            v1 = v1 + 1;
        };
        false
    }

    fun is_sender_owner(arg0: address, arg1: &Channel) : bool {
        arg0 == owner(arg1)
    }

    public fun moderators(arg0: &Channel) : vector<address> {
        arg0.moderators
    }

    public fun owner(arg0: &Channel) : address {
        arg0.owner
    }

    public entry fun remove_mod(arg0: address, arg1: &mut Channel, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(is_sender_mod(0x2::tx_context::sender(arg2), arg1) || is_sender_owner(0x2::tx_context::sender(arg2), arg1), 1);
        let v0 = false;
        let v1 = moderators(arg1);
        let v2 = 0;
        while (v2 < 0x1::vector::length<address>(&v1)) {
            if (arg0 == *0x1::vector::borrow<address>(&v1, v2)) {
                v0 = true;
                break
            };
            v2 = v2 + 1;
        };
        assert!(v0, 2);
        0x1::vector::remove<address>(&mut arg1.moderators, v2);
    }

    public entry fun send_message(arg0: 0x1::string::String, arg1: &mut Channel, arg2: &0x2::clock::Clock, arg3: 0x1::option::Option<0x1::string::String>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = current_message_counter(arg1);
        assert!(v0 != 0, 0);
        let v1 = Message{
            id             : 0x2::object::new(arg4),
            message_number : v0,
            sender         : 0x2::tx_context::sender(arg4),
            suins          : arg3,
            timestamp      : 0x2::clock::timestamp_ms(arg2),
            message        : arg0,
        };
        arg1.current_message_counter = v0 - 1;
        0x2::dynamic_field::add<address, Message>(&mut arg1.id, 0x2::address::from_u256((v0 as u256)), v1);
    }

    // decompiled from Move bytecode v6
}

