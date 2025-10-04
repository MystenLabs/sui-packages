module 0x2aaad5d1ce7482b5850dd11642358bf23cb0e6432b12a581eb77d212dca54045::su_messaging {
    struct User has store, key {
        id: 0x2::object::UID,
        wallet: address,
        display_name: vector<u8>,
        encryption_key: vector<u8>,
        name_change_count: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct CallRecord has store, key {
        id: 0x2::object::UID,
        caller: address,
        callee: address,
        timestamp: u64,
    }

    struct Message has store, key {
        id: 0x2::object::UID,
        sender: address,
        recipient: address,
        group_id: 0x1::option::Option<address>,
        encrypted_content: vector<u8>,
        timestamp: u64,
        is_read: bool,
        is_voice: bool,
        encrypted_voice: vector<u8>,
        is_video: bool,
        encrypted_attachment: 0x1::option::Option<vector<u8>>,
    }

    struct Group has store, key {
        id: 0x2::object::UID,
        name: vector<u8>,
        members: vector<address>,
    }

    struct MessageCreated has copy, drop {
        message_id: 0x2::object::ID,
        sender: address,
        recipient: address,
        group_id: 0x1::option::Option<address>,
        timestamp: u64,
    }

    struct CallInitiated has copy, drop {
        caller: address,
        callee: address,
        timestamp: u64,
    }

    struct NameUpdated has copy, drop {
        user: address,
        new_name: vector<u8>,
    }

    public entry fun create_group(arg0: vector<u8>, arg1: vector<address>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Group{
            id      : 0x2::object::new(arg2),
            name    : arg0,
            members : arg1,
        };
        0x2::transfer::share_object<Group>(v0);
    }

    public fun get_display_name(arg0: &User) : &vector<u8> {
        &arg0.display_name
    }

    public fun get_message_details(arg0: &Message) : (&address, &address, &0x1::option::Option<address>, &vector<u8>, u64, bool, &vector<u8>, bool, &0x1::option::Option<vector<u8>>) {
        (&arg0.sender, &arg0.recipient, &arg0.group_id, &arg0.encrypted_content, arg0.timestamp, arg0.is_voice, &arg0.encrypted_voice, arg0.is_video, &arg0.encrypted_attachment)
    }

    public fun get_name_change_count(arg0: &User) : u64 {
        arg0.name_change_count
    }

    public entry fun initiate_call(arg0: address, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = CallRecord{
            id        : 0x2::object::new(arg2),
            caller    : 0x2::tx_context::sender(arg2),
            callee    : arg0,
            timestamp : 0x2::clock::timestamp_ms(arg1),
        };
        let v1 = CallInitiated{
            caller    : 0x2::tx_context::sender(arg2),
            callee    : arg0,
            timestamp : v0.timestamp,
        };
        0x2::event::emit<CallInitiated>(v1);
        0x2::transfer::share_object<CallRecord>(v0);
    }

    public entry fun mark_read(arg0: &mut Message, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.recipient || 0x1::option::is_some<address>(&arg0.group_id), 0);
        arg0.is_read = true;
    }

    public entry fun register(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = User{
            id                : 0x2::object::new(arg0),
            wallet            : 0x2::tx_context::sender(arg0),
            display_name      : b"Anonymous",
            encryption_key    : 0x2::bcs::to_bytes<address>(&v0),
            name_change_count : 0,
        };
        let v2 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<User>(v1, 0x2::tx_context::sender(arg0));
        0x2::transfer::transfer<AdminCap>(v2, 0x2::tx_context::sender(arg0));
    }

    public entry fun send_attachment(arg0: address, arg1: vector<u8>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Message{
            id                   : 0x2::object::new(arg3),
            sender               : 0x2::tx_context::sender(arg3),
            recipient            : arg0,
            group_id             : 0x1::option::none<address>(),
            encrypted_content    : 0x1::vector::empty<u8>(),
            timestamp            : 0x2::clock::timestamp_ms(arg2),
            is_read              : false,
            is_voice             : false,
            encrypted_voice      : 0x1::vector::empty<u8>(),
            is_video             : false,
            encrypted_attachment : 0x1::option::some<vector<u8>>(arg1),
        };
        let v1 = MessageCreated{
            message_id : 0x2::object::id<Message>(&v0),
            sender     : 0x2::tx_context::sender(arg3),
            recipient  : arg0,
            group_id   : 0x1::option::none<address>(),
            timestamp  : v0.timestamp,
        };
        0x2::event::emit<MessageCreated>(v1);
        0x2::transfer::share_object<Message>(v0);
    }

    public entry fun send_group_message(arg0: address, arg1: vector<u8>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Message{
            id                   : 0x2::object::new(arg3),
            sender               : 0x2::tx_context::sender(arg3),
            recipient            : @0x0,
            group_id             : 0x1::option::some<address>(arg0),
            encrypted_content    : arg1,
            timestamp            : 0x2::clock::timestamp_ms(arg2),
            is_read              : false,
            is_voice             : false,
            encrypted_voice      : 0x1::vector::empty<u8>(),
            is_video             : false,
            encrypted_attachment : 0x1::option::none<vector<u8>>(),
        };
        let v1 = MessageCreated{
            message_id : 0x2::object::id<Message>(&v0),
            sender     : 0x2::tx_context::sender(arg3),
            recipient  : @0x0,
            group_id   : 0x1::option::some<address>(arg0),
            timestamp  : v0.timestamp,
        };
        0x2::event::emit<MessageCreated>(v1);
        0x2::transfer::share_object<Message>(v0);
    }

    public entry fun send_message(arg0: address, arg1: vector<u8>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Message{
            id                   : 0x2::object::new(arg3),
            sender               : 0x2::tx_context::sender(arg3),
            recipient            : arg0,
            group_id             : 0x1::option::none<address>(),
            encrypted_content    : arg1,
            timestamp            : 0x2::clock::timestamp_ms(arg2),
            is_read              : false,
            is_voice             : false,
            encrypted_voice      : 0x1::vector::empty<u8>(),
            is_video             : false,
            encrypted_attachment : 0x1::option::none<vector<u8>>(),
        };
        let v1 = MessageCreated{
            message_id : 0x2::object::id<Message>(&v0),
            sender     : 0x2::tx_context::sender(arg3),
            recipient  : arg0,
            group_id   : 0x1::option::none<address>(),
            timestamp  : v0.timestamp,
        };
        0x2::event::emit<MessageCreated>(v1);
        0x2::transfer::share_object<Message>(v0);
    }

    public entry fun send_voice_message(arg0: address, arg1: vector<u8>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Message{
            id                   : 0x2::object::new(arg3),
            sender               : 0x2::tx_context::sender(arg3),
            recipient            : arg0,
            group_id             : 0x1::option::none<address>(),
            encrypted_content    : 0x1::vector::empty<u8>(),
            timestamp            : 0x2::clock::timestamp_ms(arg2),
            is_read              : false,
            is_voice             : true,
            encrypted_voice      : arg1,
            is_video             : false,
            encrypted_attachment : 0x1::option::none<vector<u8>>(),
        };
        let v1 = MessageCreated{
            message_id : 0x2::object::id<Message>(&v0),
            sender     : 0x2::tx_context::sender(arg3),
            recipient  : arg0,
            group_id   : 0x1::option::none<address>(),
            timestamp  : v0.timestamp,
        };
        0x2::event::emit<MessageCreated>(v1);
        0x2::transfer::share_object<Message>(v0);
    }

    public entry fun update_name_free(arg0: &mut User, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.wallet, 0);
        assert!(arg0.name_change_count < 3, 1);
        arg0.display_name = arg1;
        arg0.name_change_count = arg0.name_change_count + 1;
        let v0 = NameUpdated{
            user     : arg0.wallet,
            new_name : arg0.display_name,
        };
        0x2::event::emit<NameUpdated>(v0);
    }

    public entry fun update_name_paid(arg0: &mut User, arg1: vector<u8>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.wallet, 0);
        assert!(arg0.name_change_count >= 3, 2);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= 1000000, 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, @0xd1b0ff621a6803c8f0cd8051359ce312ece62b485e010e32b58a99d5ec13201c);
        arg0.display_name = arg1;
        arg0.name_change_count = arg0.name_change_count + 1;
        let v0 = NameUpdated{
            user     : arg0.wallet,
            new_name : arg0.display_name,
        };
        0x2::event::emit<NameUpdated>(v0);
    }

    // decompiled from Move bytecode v6
}

