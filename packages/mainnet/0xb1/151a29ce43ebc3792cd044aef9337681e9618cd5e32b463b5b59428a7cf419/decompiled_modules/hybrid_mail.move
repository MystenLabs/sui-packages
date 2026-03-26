module 0xb1151a29ce43ebc3792cd044aef9337681e9618cd5e32b463b5b59428a7cf419::hybrid_mail {
    struct MailDomain has store, key {
        id: 0x2::object::UID,
        domain: 0x1::string::String,
        owner: address,
        open_registration: bool,
        registered_handles: vector<0x1::string::String>,
        sponsor_config_ids: vector<0x2::object::ID>,
        created_at_ms: u64,
        updated_at_ms: u64,
    }

    struct MailHandle has store, key {
        id: 0x2::object::UID,
        domain_id: 0x2::object::ID,
        handle: 0x1::string::String,
        normalized_email: 0x1::string::String,
        owner: address,
        mailbox_ids: vector<0x2::object::ID>,
        created_at_ms: u64,
        updated_at_ms: u64,
    }

    struct Mailbox has store, key {
        id: 0x2::object::UID,
        owner: address,
        handle_id: 0x2::object::ID,
        settings_ref: vector<u8>,
        storage_account_id: 0x2::object::ID,
        current_plan: u8,
        created_at_ms: u64,
        updated_at_ms: u64,
    }

    struct MessageEnvelope has store, key {
        id: 0x2::object::UID,
        sender_mailbox_id: 0x2::object::ID,
        sender_handle_id: 0x2::object::ID,
        thread_id: 0x2::object::ID,
        manifest_blob_id: 0x1::string::String,
        body_blob_id: 0x1::string::String,
        attachment_blob_ids: vector<0x1::string::String>,
        recipient_count: u64,
        route_kind: u8,
        route_status: u8,
        content_digest: vector<u8>,
        access_policy_ref: vector<u8>,
        access_id: 0x1::string::String,
        created_at_ms: u64,
    }

    struct MailboxItem has store, key {
        id: 0x2::object::UID,
        mailbox_id: 0x2::object::ID,
        envelope_id: 0x2::object::ID,
        thread_id: 0x2::object::ID,
        owner: address,
        direction: u8,
        folder: u8,
        is_read: bool,
        is_starred: bool,
        route_status: u8,
        manifest_blob_id: 0x1::string::String,
        access_id: 0x1::string::String,
        created_at_ms: u64,
        updated_at_ms: u64,
    }

    struct ThreadRoot has store, key {
        id: 0x2::object::UID,
        mailbox_id: 0x2::object::ID,
        message_envelope_ids: vector<0x2::object::ID>,
        created_at_ms: u64,
        updated_at_ms: u64,
    }

    struct StorageAccount has store, key {
        id: 0x2::object::UID,
        mailbox_id: 0x2::object::ID,
        plan: u8,
        used_total_bytes: u64,
        message_bytes: u64,
        attachment_bytes: u64,
        vault_bytes: u64,
        plan_limit_bytes: u64,
        max_attachment_size_bytes: u64,
        renewal_status: u8,
    }

    struct SponsorConfig has store, key {
        id: 0x2::object::UID,
        admin: address,
        sponsor: address,
        sponsorship_enabled: bool,
        monthly_limit_per_user: u64,
        fallback_to_user_signing: bool,
        policy_ref: vector<u8>,
        updated_at_ms: u64,
    }

    fun contains_handle(arg0: &vector<0x1::string::String>, arg1: &0x1::string::String) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1::string::String>(arg0)) {
            if (0x1::vector::borrow<0x1::string::String>(arg0, v0) == arg1) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun create_domain(arg0: 0x1::string::String, arg1: address, arg2: bool, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : MailDomain {
        MailDomain{
            id                 : 0x2::object::new(arg4),
            domain             : arg0,
            owner              : arg1,
            open_registration  : arg2,
            registered_handles : 0x1::vector::empty<0x1::string::String>(),
            sponsor_config_ids : 0x1::vector::empty<0x2::object::ID>(),
            created_at_ms      : arg3,
            updated_at_ms      : arg3,
        }
    }

    public fun create_mailbox(arg0: &mut MailHandle, arg1: vector<u8>, arg2: u8, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : (Mailbox, StorageAccount, ThreadRoot) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg6), 2);
        assert!(0x1::vector::length<0x2::object::ID>(&arg0.mailbox_ids) == 0, 4);
        let v0 = 0x2::object::new(arg6);
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = 0x2::object::new(arg6);
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.mailbox_ids, v1);
        arg0.updated_at_ms = arg5;
        let v3 = Mailbox{
            id                 : v0,
            owner              : arg0.owner,
            handle_id          : 0x2::object::id<MailHandle>(arg0),
            settings_ref       : arg1,
            storage_account_id : 0x2::object::uid_to_inner(&v2),
            current_plan       : arg2,
            created_at_ms      : arg5,
            updated_at_ms      : arg5,
        };
        let v4 = StorageAccount{
            id                        : v2,
            mailbox_id                : v1,
            plan                      : arg2,
            used_total_bytes          : 0,
            message_bytes             : 0,
            attachment_bytes          : 0,
            vault_bytes               : 0,
            plan_limit_bytes          : arg3,
            max_attachment_size_bytes : arg4,
            renewal_status            : 0,
        };
        let v5 = ThreadRoot{
            id                   : 0x2::object::new(arg6),
            mailbox_id           : v1,
            message_envelope_ids : 0x1::vector::empty<0x2::object::ID>(),
            created_at_ms        : arg5,
            updated_at_ms        : arg5,
        };
        (v3, v4, v5)
    }

    public fun create_sponsor_config(arg0: address, arg1: address, arg2: bool, arg3: u64, arg4: bool, arg5: vector<u8>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : SponsorConfig {
        SponsorConfig{
            id                       : 0x2::object::new(arg7),
            admin                    : arg0,
            sponsor                  : arg1,
            sponsorship_enabled      : arg2,
            monthly_limit_per_user   : arg3,
            fallback_to_user_signing : arg4,
            policy_ref               : arg5,
            updated_at_ms            : arg6,
        }
    }

    public fun decrease_storage_usage(arg0: &mut StorageAccount, arg1: u8, arg2: u64) {
        arg0.used_total_bytes = arg0.used_total_bytes - arg2;
        if (arg1 == 0) {
            arg0.message_bytes = arg0.message_bytes - arg2;
        } else if (arg1 == 1) {
            arg0.attachment_bytes = arg0.attachment_bytes - arg2;
        } else {
            arg0.vault_bytes = arg0.vault_bytes - arg2;
        };
    }

    public fun deliver_mailbox_item(arg0: &MessageEnvelope, arg1: &Mailbox, arg2: 0x1::string::String, arg3: u8, arg4: u8, arg5: u8, arg6: 0x1::string::String, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : MailboxItem {
        MailboxItem{
            id               : 0x2::object::new(arg8),
            mailbox_id       : 0x2::object::id<Mailbox>(arg1),
            envelope_id      : 0x2::object::id<MessageEnvelope>(arg0),
            thread_id        : arg0.thread_id,
            owner            : arg1.owner,
            direction        : arg3,
            folder           : arg4,
            is_read          : false,
            is_starred       : false,
            route_status     : arg5,
            manifest_blob_id : arg2,
            access_id        : arg6,
            created_at_ms    : arg7,
            updated_at_ms    : arg7,
        }
    }

    public fun destroy_mail_domain(arg0: MailDomain) {
        let MailDomain {
            id                 : v0,
            domain             : _,
            owner              : _,
            open_registration  : _,
            registered_handles : _,
            sponsor_config_ids : _,
            created_at_ms      : _,
            updated_at_ms      : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun destroy_mail_handle(arg0: MailHandle) {
        let MailHandle {
            id               : v0,
            domain_id        : _,
            handle           : _,
            normalized_email : _,
            owner            : _,
            mailbox_ids      : _,
            created_at_ms    : _,
            updated_at_ms    : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun destroy_mailbox(arg0: Mailbox) {
        let Mailbox {
            id                 : v0,
            owner              : _,
            handle_id          : _,
            settings_ref       : _,
            storage_account_id : _,
            current_plan       : _,
            created_at_ms      : _,
            updated_at_ms      : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun destroy_mailbox_item(arg0: MailboxItem) {
        let MailboxItem {
            id               : v0,
            mailbox_id       : _,
            envelope_id      : _,
            thread_id        : _,
            owner            : _,
            direction        : _,
            folder           : _,
            is_read          : _,
            is_starred       : _,
            route_status     : _,
            manifest_blob_id : _,
            access_id        : _,
            created_at_ms    : _,
            updated_at_ms    : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun destroy_message_envelope(arg0: MessageEnvelope) {
        let MessageEnvelope {
            id                  : v0,
            sender_mailbox_id   : _,
            sender_handle_id    : _,
            thread_id           : _,
            manifest_blob_id    : _,
            body_blob_id        : _,
            attachment_blob_ids : _,
            recipient_count     : _,
            route_kind          : _,
            route_status        : _,
            content_digest      : _,
            access_policy_ref   : _,
            access_id           : _,
            created_at_ms       : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun destroy_sponsor_config(arg0: SponsorConfig) {
        let SponsorConfig {
            id                       : v0,
            admin                    : _,
            sponsor                  : _,
            sponsorship_enabled      : _,
            monthly_limit_per_user   : _,
            fallback_to_user_signing : _,
            policy_ref               : _,
            updated_at_ms            : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun destroy_storage_account(arg0: StorageAccount) {
        let StorageAccount {
            id                        : v0,
            mailbox_id                : _,
            plan                      : _,
            used_total_bytes          : _,
            message_bytes             : _,
            attachment_bytes          : _,
            vault_bytes               : _,
            plan_limit_bytes          : _,
            max_attachment_size_bytes : _,
            renewal_status            : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun destroy_thread_root(arg0: ThreadRoot) {
        let ThreadRoot {
            id                   : v0,
            mailbox_id           : _,
            message_envelope_ids : _,
            created_at_ms        : _,
            updated_at_ms        : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun increase_storage_usage(arg0: &mut StorageAccount, arg1: u8, arg2: u64) {
        arg0.used_total_bytes = arg0.used_total_bytes + arg2;
        if (arg1 == 0) {
            arg0.message_bytes = arg0.message_bytes + arg2;
        } else if (arg1 == 1) {
            arg0.attachment_bytes = arg0.attachment_bytes + arg2;
        } else {
            arg0.vault_bytes = arg0.vault_bytes + arg2;
        };
    }

    public fun mark_read_unread(arg0: &mut MailboxItem, arg1: bool, arg2: u64) {
        arg0.is_read = arg1;
        arg0.updated_at_ms = arg2;
    }

    public fun move_message_folder(arg0: &mut MailboxItem, arg1: u8, arg2: u64) {
        arg0.folder = arg1;
        arg0.updated_at_ms = arg2;
    }

    public fun register_handle(arg0: &mut MailDomain, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : MailHandle {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(arg0.open_registration || arg0.owner == v0, 1);
        assert!(!contains_handle(&arg0.registered_handles, &arg1), 0);
        0x1::vector::push_back<0x1::string::String>(&mut arg0.registered_handles, arg1);
        arg0.updated_at_ms = arg3;
        MailHandle{
            id               : 0x2::object::new(arg4),
            domain_id        : 0x2::object::id<MailDomain>(arg0),
            handle           : arg1,
            normalized_email : arg2,
            owner            : v0,
            mailbox_ids      : 0x1::vector::empty<0x2::object::ID>(),
            created_at_ms    : arg3,
            updated_at_ms    : arg3,
        }
    }

    public fun seal_approve_mailbox_access(arg0: &Mailbox, arg1: 0x1::string::String, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 5);
    }

    public fun seal_approve_mailbox_item_access(arg0: &MailboxItem, arg1: 0x1::string::String, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 6);
    }

    public fun send_internal_message_header(arg0: &Mailbox, arg1: &MailHandle, arg2: &mut ThreadRoot, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: vector<0x1::string::String>, arg6: u64, arg7: u8, arg8: u8, arg9: vector<u8>, arg10: vector<u8>, arg11: 0x1::string::String, arg12: u64, arg13: &mut 0x2::tx_context::TxContext) : (MessageEnvelope, MailboxItem) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg13), 5);
        let v0 = 0x2::object::new(arg13);
        let v1 = 0x2::object::uid_to_inner(&v0);
        0x1::vector::push_back<0x2::object::ID>(&mut arg2.message_envelope_ids, v1);
        arg2.updated_at_ms = arg12;
        let v2 = MessageEnvelope{
            id                  : v0,
            sender_mailbox_id   : 0x2::object::id<Mailbox>(arg0),
            sender_handle_id    : 0x2::object::id<MailHandle>(arg1),
            thread_id           : 0x2::object::id<ThreadRoot>(arg2),
            manifest_blob_id    : arg3,
            body_blob_id        : arg4,
            attachment_blob_ids : arg5,
            recipient_count     : arg6,
            route_kind          : arg7,
            route_status        : arg8,
            content_digest      : arg9,
            access_policy_ref   : arg10,
            access_id           : arg11,
            created_at_ms       : arg12,
        };
        let v3 = MailboxItem{
            id               : 0x2::object::new(arg13),
            mailbox_id       : 0x2::object::id<Mailbox>(arg0),
            envelope_id      : v1,
            thread_id        : 0x2::object::id<ThreadRoot>(arg2),
            owner            : arg0.owner,
            direction        : 1,
            folder           : 1,
            is_read          : true,
            is_starred       : false,
            route_status     : arg8,
            manifest_blob_id : arg3,
            access_id        : arg11,
            created_at_ms    : arg12,
            updated_at_ms    : arg12,
        };
        (v2, v3)
    }

    public fun set_plan(arg0: &mut StorageAccount, arg1: &mut Mailbox, arg2: u8, arg3: u64, arg4: u64, arg5: u64) {
        arg0.plan = arg2;
        arg0.plan_limit_bytes = arg3;
        arg0.max_attachment_size_bytes = arg4;
        arg1.current_plan = arg2;
        arg1.updated_at_ms = arg5;
    }

    public fun set_sponsor_rules(arg0: &mut SponsorConfig, arg1: address, arg2: address, arg3: bool, arg4: u64, arg5: bool, arg6: vector<u8>, arg7: u64) {
        assert!(arg0.admin == arg1, 3);
        arg0.sponsor = arg2;
        arg0.sponsorship_enabled = arg3;
        arg0.monthly_limit_per_user = arg4;
        arg0.fallback_to_user_signing = arg5;
        arg0.policy_ref = arg6;
        arg0.updated_at_ms = arg7;
    }

    public fun star_unstar(arg0: &mut MailboxItem, arg1: bool, arg2: u64) {
        arg0.is_starred = arg1;
        arg0.updated_at_ms = arg2;
    }

    public fun update_settings_refs(arg0: &mut Mailbox, arg1: vector<u8>, arg2: u64) {
        arg0.settings_ref = arg1;
        arg0.updated_at_ms = arg2;
    }

    // decompiled from Move bytecode v6
}

