module 0x782716705e81a98a80d3eca78ab2ecf5fe8586b804aefc8ffb7ec0fb3b04df88::club {
    struct Global has store, key {
        id: 0x2::object::UID,
        admin: address,
        clubs: 0x2::table::Table<address, Club>,
    }

    struct Club has store {
        owner: address,
        messages: 0x2::table_vec::TableVec<Message>,
    }

    struct Message has store {
        sender: address,
        content: vector<u8>,
        timestamp: u64,
        deleted: bool,
    }

    public entry fun delete_message(arg0: &mut Global, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::table::borrow_mut<address, Club>(&mut arg0.clubs, arg1);
        assert!(arg2 < 0x2::table_vec::length<Message>(&v1.messages), 2);
        let v2 = 0x2::table_vec::borrow_mut<Message>(&mut v1.messages, arg2);
        assert!(v2.sender == v0 || arg0.admin == v0, 1);
        assert!(!v2.deleted, 3);
        v2.content = 0x1::vector::empty<u8>();
        v2.deleted = true;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Global{
            id    : 0x2::object::new(arg0),
            admin : 0x2::tx_context::sender(arg0),
            clubs : 0x2::table::new<address, Club>(arg0),
        };
        0x2::transfer::share_object<Global>(v0);
    }

    public entry fun new_message(arg0: &0x2::clock::Clock, arg1: &0x782716705e81a98a80d3eca78ab2ecf5fe8586b804aefc8ffb7ec0fb3b04df88::socialcoin::Global, arg2: &mut Global, arg3: address, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(0x782716705e81a98a80d3eca78ab2ecf5fe8586b804aefc8ffb7ec0fb3b04df88::socialcoin::is_holder(arg1, v0, arg3), 1);
        if (!0x2::table::contains<address, Club>(&arg2.clubs, arg3)) {
            let v1 = Club{
                owner    : arg3,
                messages : 0x2::table_vec::empty<Message>(arg5),
            };
            0x2::table::add<address, Club>(&mut arg2.clubs, arg3, v1);
        };
        let v2 = Message{
            sender    : v0,
            content   : arg4,
            timestamp : 0x2::clock::timestamp_ms(arg0),
            deleted   : false,
        };
        0x2::table_vec::push_back<Message>(&mut 0x2::table::borrow_mut<address, Club>(&mut arg2.clubs, arg3).messages, v2);
    }

    // decompiled from Move bytecode v6
}

