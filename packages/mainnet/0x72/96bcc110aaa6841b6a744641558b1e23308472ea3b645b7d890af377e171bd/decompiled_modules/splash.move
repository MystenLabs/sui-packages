module 0x7296bcc110aaa6841b6a744641558b1e23308472ea3b645b7d890af377e171bd::splash {
    struct Email has store, key {
        id: 0x2::object::UID,
        sender: address,
        recipient: address,
        subject: vector<u8>,
        content: vector<u8>,
        attachment: vector<u8>,
        timestamp: u64,
    }

    struct Inbox has key {
        id: 0x2::object::UID,
        emails: vector<0x2::object::ID>,
    }

    public fun get_mailbox_id(arg0: &0x7296bcc110aaa6841b6a744641558b1e23308472ea3b645b7d890af377e171bd::mailbox_config::MailboxConfig, arg1: address) : 0x2::object::ID {
        0x7296bcc110aaa6841b6a744641558b1e23308472ea3b645b7d890af377e171bd::mailbox_config::get_mailbox_id(arg0, arg1)
    }

    fun approve_internal(arg0: address, arg1: vector<u8>, arg2: &Email) : bool {
        arg2.recipient == arg0 || arg2.sender == arg0
    }

    entry fun burn_email(arg0: &0x7296bcc110aaa6841b6a744641558b1e23308472ea3b645b7d890af377e171bd::mailbox_config::MailboxConfig, arg1: &mut Inbox, arg2: Email, arg3: &0x2::tx_context::TxContext) {
        check_version(arg0);
        assert!(arg2.recipient == 0x2::tx_context::sender(arg3), 1);
        let v0 = 0x2::object::id<Email>(&arg2);
        let v1 = &mut arg1.emails;
        assert!(remove_email(v1, &v0), 2);
        let Email {
            id         : v2,
            sender     : _,
            recipient  : _,
            subject    : _,
            content    : _,
            attachment : _,
            timestamp  : _,
        } = arg2;
        0x2::object::delete(v2);
    }

    fun check_version(arg0: &0x7296bcc110aaa6841b6a744641558b1e23308472ea3b645b7d890af377e171bd::mailbox_config::MailboxConfig) {
        assert!(0x7296bcc110aaa6841b6a744641558b1e23308472ea3b645b7d890af377e171bd::mailbox_config::get_version(arg0) == 1, 3);
    }

    public fun clear_emails(arg0: &0x7296bcc110aaa6841b6a744641558b1e23308472ea3b645b7d890af377e171bd::mailbox_config::MailboxConfig, arg1: &mut Inbox) {
        check_version(arg0);
        arg1.emails = 0x1::vector::empty<0x2::object::ID>();
    }

    public fun create_inbox(arg0: &mut 0x7296bcc110aaa6841b6a744641558b1e23308472ea3b645b7d890af377e171bd::mailbox_config::MailboxConfig, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        let v0 = 0x7296bcc110aaa6841b6a744641558b1e23308472ea3b645b7d890af377e171bd::mailbox_config::get_create_mailbox_tax(arg0);
        handle_payment(arg0, arg1, v0, arg2);
        let v1 = Inbox{
            id     : 0x2::object::new(arg2),
            emails : 0x1::vector::empty<0x2::object::ID>(),
        };
        0x2::transfer::share_object<Inbox>(v1);
        0x7296bcc110aaa6841b6a744641558b1e23308472ea3b645b7d890af377e171bd::mailbox_config::register_mailbox(arg0, 0x2::tx_context::sender(arg2), 0x2::object::id<Inbox>(&v1));
    }

    fun handle_payment(arg0: &mut 0x7296bcc110aaa6841b6a744641558b1e23308472ea3b645b7d890af377e171bd::mailbox_config::MailboxConfig, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= arg2, 0);
        0x7296bcc110aaa6841b6a744641558b1e23308472ea3b645b7d890af377e171bd::mailbox_config::add_balance(arg0, 0x2::coin::split<0x2::sui::SUI>(&mut arg1, arg2, arg3));
        if (0x2::coin::value<0x2::sui::SUI>(&arg1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg1);
        };
    }

    public fun read_emails(arg0: &Inbox) : &vector<0x2::object::ID> {
        &arg0.emails
    }

    fun remove_email(arg0: &mut vector<0x2::object::ID>, arg1: &0x2::object::ID) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x2::object::ID>(arg0)) {
            if (0x1::vector::borrow<0x2::object::ID>(arg0, v0) == arg1) {
                0x1::vector::remove<0x2::object::ID>(arg0, v0);
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    entry fun seal_approve(arg0: vector<u8>, arg1: &0x7296bcc110aaa6841b6a744641558b1e23308472ea3b645b7d890af377e171bd::mailbox_config::MailboxConfig, arg2: &Email, arg3: &0x2::tx_context::TxContext) {
        check_version(arg1);
        assert!(approve_internal(0x2::tx_context::sender(arg3), arg0, arg2), 1);
    }

    public fun send_email(arg0: &mut 0x7296bcc110aaa6841b6a744641558b1e23308472ea3b645b7d890af377e171bd::mailbox_config::MailboxConfig, arg1: &mut Inbox, arg2: address, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        let v0 = 0x7296bcc110aaa6841b6a744641558b1e23308472ea3b645b7d890af377e171bd::mailbox_config::get_store_message_tax(arg0);
        handle_payment(arg0, arg6, v0, arg7);
        let v1 = 0x2::tx_context::sender(arg7);
        let v2 = Email{
            id         : 0x2::object::new(arg7),
            sender     : v1,
            recipient  : arg2,
            subject    : arg3,
            content    : arg4,
            attachment : arg5,
            timestamp  : 0x2::tx_context::epoch_timestamp_ms(arg7),
        };
        0x2::transfer::share_object<Email>(v2);
        0x1::vector::push_back<0x2::object::ID>(&mut arg1.emails, 0x2::object::id<Email>(&v2));
        0x7296bcc110aaa6841b6a744641558b1e23308472ea3b645b7d890af377e171bd::mailbox_config::increment_emails_sent(arg0);
        0x7296bcc110aaa6841b6a744641558b1e23308472ea3b645b7d890af377e171bd::events::emit_email_sent(0x2::object::id<Inbox>(arg1), v1, arg2, 0x1::vector::length<0x2::object::ID>(&arg1.emails) - 1);
    }

    // decompiled from Move bytecode v6
}

