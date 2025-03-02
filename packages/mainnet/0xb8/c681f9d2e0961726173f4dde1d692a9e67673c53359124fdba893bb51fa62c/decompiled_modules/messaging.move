module 0xb8c681f9d2e0961726173f4dde1d692a9e67673c53359124fdba893bb51fa62c::messaging {
    struct SendMessage has copy, drop {
        sender: address,
        recipient: address,
        cid: vector<u8>,
        key: vector<u8>,
        timestamp: u64,
    }

    struct Mailbox has store, key {
        id: 0x2::object::UID,
        owner: address,
        messages: vector<Message>,
    }

    struct Message has store {
        sender: address,
        cid: vector<u8>,
        key: vector<u8>,
        timestamp: u64,
    }

    struct MailboxRegistry has key {
        id: 0x2::object::UID,
        owner: address,
        owner_to_mailbox: 0x2::table::Table<address, Mailbox>,
        fee_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        mailbox_creation_fee: u64,
        message_send_fee: u64,
    }

    public entry fun collect_fees(arg0: &mut MailboxRegistry, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(v0 == arg0.owner, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.fee_balance, 0x2::balance::value<0x2::sui::SUI>(&arg0.fee_balance), arg1), v0);
    }

    public entry fun create_mailbox(arg0: &mut MailboxRegistry, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(!0x2::table::contains<address, Mailbox>(&arg0.owner_to_mailbox, v0), 2);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) == arg0.mailbox_creation_fee, 3);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.fee_balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let v1 = Mailbox{
            id       : 0x2::object::new(arg2),
            owner    : v0,
            messages : 0x1::vector::empty<Message>(),
        };
        0x2::table::add<address, Mailbox>(&mut arg0.owner_to_mailbox, v0, v1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MailboxRegistry{
            id                   : 0x2::object::new(arg0),
            owner                : 0x2::tx_context::sender(arg0),
            owner_to_mailbox     : 0x2::table::new<address, Mailbox>(arg0),
            fee_balance          : 0x2::balance::zero<0x2::sui::SUI>(),
            mailbox_creation_fee : 1000000000,
            message_send_fee     : 50000000,
        };
        0x2::transfer::share_object<MailboxRegistry>(v0);
    }

    public entry fun send_message(arg0: &mut MailboxRegistry, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: address, arg3: vector<u8>, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        assert!(0x2::table::contains<address, Mailbox>(&arg0.owner_to_mailbox, arg2), 4);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) == arg0.message_send_fee, 3);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.fee_balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let v1 = 0x2::clock::timestamp_ms(arg5);
        let v2 = Message{
            sender    : v0,
            cid       : arg3,
            key       : arg4,
            timestamp : v1,
        };
        let v3 = SendMessage{
            sender    : v0,
            recipient : arg2,
            cid       : arg3,
            key       : arg4,
            timestamp : v1,
        };
        0x2::event::emit<SendMessage>(v3);
        0x1::vector::push_back<Message>(&mut 0x2::table::borrow_mut<address, Mailbox>(&mut arg0.owner_to_mailbox, arg2).messages, v2);
    }

    public entry fun set_mailbox_creation_fee(arg0: &mut MailboxRegistry, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 1);
        arg0.mailbox_creation_fee = arg1;
    }

    public entry fun set_message_send_fee(arg0: &mut MailboxRegistry, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 1);
        arg0.message_send_fee = arg1;
    }

    // decompiled from Move bytecode v6
}

