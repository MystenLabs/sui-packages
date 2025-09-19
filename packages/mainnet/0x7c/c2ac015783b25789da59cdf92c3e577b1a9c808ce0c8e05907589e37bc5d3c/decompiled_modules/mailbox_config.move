module 0x8deb60b1c0604f0f6363ad5acdc3d77813ce14cc87783e9aacbedb78e0494cf4::mailbox_config {
    struct MailBoxAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct MailboxConfig has store, key {
        id: 0x2::object::UID,
        create_mailbox_tax: u64,
        store_message_tax: u64,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        mailboxes: 0x2::table::Table<address, 0x2::object::ID>,
        version: u64,
        emails_sent: u64,
    }

    public fun add_balance(arg0: &mut MailboxConfig, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::coin::put<0x2::sui::SUI>(&mut arg0.balance, arg1);
    }

    public fun get_balance(arg0: &MailboxConfig) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.balance)
    }

    public fun get_create_mailbox_tax(arg0: &MailboxConfig) : u64 {
        arg0.create_mailbox_tax
    }

    public fun get_emails_sent(arg0: &MailboxConfig) : u64 {
        arg0.emails_sent
    }

    public(friend) fun get_mailbox_id(arg0: &MailboxConfig, arg1: address) : 0x2::object::ID {
        *0x2::table::borrow<address, 0x2::object::ID>(&arg0.mailboxes, arg1)
    }

    public fun get_store_message_tax(arg0: &MailboxConfig) : u64 {
        arg0.store_message_tax
    }

    public fun get_version(arg0: &MailboxConfig) : u64 {
        arg0.version
    }

    public(friend) fun increment_emails_sent(arg0: &mut MailboxConfig) {
        arg0.emails_sent = arg0.emails_sent + 1;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MailBoxAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<MailBoxAdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = MailboxConfig{
            id                 : 0x2::object::new(arg0),
            create_mailbox_tax : 1000,
            store_message_tax  : 10,
            balance            : 0x2::balance::zero<0x2::sui::SUI>(),
            mailboxes          : 0x2::table::new<address, 0x2::object::ID>(arg0),
            version            : 1,
            emails_sent        : 0,
        };
        0x2::transfer::share_object<MailboxConfig>(v1);
    }

    public(friend) fun register_mailbox(arg0: &mut MailboxConfig, arg1: address, arg2: 0x2::object::ID) {
        assert!(!0x2::table::contains<address, 0x2::object::ID>(&arg0.mailboxes, arg1), 1);
        0x2::table::add<address, 0x2::object::ID>(&mut arg0.mailboxes, arg1, arg2);
    }

    public fun update_create_mailbox_tax(arg0: &mut MailboxConfig, arg1: &MailBoxAdminCap, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        arg0.create_mailbox_tax = arg2;
    }

    public fun update_store_message_tax(arg0: &mut MailboxConfig, arg1: &MailBoxAdminCap, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        arg0.store_message_tax = arg2;
    }

    public fun update_version(arg0: &mut MailboxConfig, arg1: &MailBoxAdminCap, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        arg0.version = arg2;
    }

    public fun withdraw_balance(arg0: &mut MailboxConfig, arg1: &MailBoxAdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x2::coin::take<0x2::sui::SUI>(&mut arg0.balance, arg2, arg3)
    }

    // decompiled from Move bytecode v6
}

