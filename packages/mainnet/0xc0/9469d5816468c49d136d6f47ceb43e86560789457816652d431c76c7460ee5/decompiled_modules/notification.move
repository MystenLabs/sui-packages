module 0xc09469d5816468c49d136d6f47ceb43e86560789457816652d431c76c7460ee5::notification {
    struct Config has key {
        id: 0x2::object::UID,
        admin: address,
        authorized_operator: address,
        active_wallets: 0x2::table::Table<address, 0x2::object::ID>,
    }

    struct NotificationPolicy has store, key {
        id: 0x2::object::UID,
        owner: address,
        active: bool,
        created_at: u64,
    }

    struct NotificationCredential has store, key {
        id: 0x2::object::UID,
        owner: address,
        policy_id: 0x2::object::ID,
        encrypted_blob: vector<u8>,
    }

    struct NotificationActivated has copy, drop {
        policy_id: 0x2::object::ID,
        credential_id: 0x2::object::ID,
        owner: address,
        created_at: u64,
    }

    struct NotificationDeactivated has copy, drop {
        policy_id: 0x2::object::ID,
        owner: address,
    }

    struct NotificationReactivated has copy, drop {
        policy_id: 0x2::object::ID,
        owner: address,
    }

    struct NotificationCredentialUpdated has copy, drop {
        policy_id: 0x2::object::ID,
        credential_id: 0x2::object::ID,
        owner: address,
    }

    struct NotificationCancelled has copy, drop {
        policy_id: 0x2::object::ID,
        owner: address,
        cancelled_at: u64,
    }

    struct OperatorRotated has copy, drop {
        old_operator: address,
        new_operator: address,
    }

    public fun activate_notification(arg0: &mut Config, arg1: vector<u8>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!0x2::table::contains<address, 0x2::object::ID>(&arg0.active_wallets, 0x2::tx_context::sender(arg3)), 6);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = NotificationPolicy{
            id         : 0x2::object::new(arg3),
            owner      : 0x2::tx_context::sender(arg3),
            active     : true,
            created_at : v0,
        };
        let v2 = 0x2::object::id<NotificationPolicy>(&v1);
        let v3 = NotificationCredential{
            id             : 0x2::object::new(arg3),
            owner          : 0x2::tx_context::sender(arg3),
            policy_id      : v2,
            encrypted_blob : arg1,
        };
        0x2::table::add<address, 0x2::object::ID>(&mut arg0.active_wallets, 0x2::tx_context::sender(arg3), v2);
        let v4 = NotificationActivated{
            policy_id     : v2,
            credential_id : 0x2::object::id<NotificationCredential>(&v3),
            owner         : 0x2::tx_context::sender(arg3),
            created_at    : v0,
        };
        0x2::event::emit<NotificationActivated>(v4);
        0x2::transfer::share_object<NotificationPolicy>(v1);
        0x2::transfer::transfer<NotificationCredential>(v3, 0x2::tx_context::sender(arg3));
    }

    public fun admin(arg0: &Config) : address {
        arg0.admin
    }

    public fun authorized_operator(arg0: &Config) : address {
        arg0.authorized_operator
    }

    public fun created_at(arg0: &NotificationPolicy) : u64 {
        arg0.created_at
    }

    public fun deactivate_and_delete(arg0: &mut Config, arg1: &mut NotificationPolicy, arg2: NotificationCredential, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg1.owner, 3);
        assert!(arg2.policy_id == 0x2::object::id<NotificationPolicy>(arg1), 5);
        arg1.active = false;
        if (0x2::table::contains<address, 0x2::object::ID>(&arg0.active_wallets, 0x2::tx_context::sender(arg4))) {
            0x2::table::remove<address, 0x2::object::ID>(&mut arg0.active_wallets, 0x2::tx_context::sender(arg4));
        };
        let NotificationCredential {
            id             : v0,
            owner          : _,
            policy_id      : _,
            encrypted_blob : _,
        } = arg2;
        0x2::object::delete(v0);
        let v4 = NotificationCancelled{
            policy_id    : 0x2::object::id<NotificationPolicy>(arg1),
            owner        : 0x2::tx_context::sender(arg4),
            cancelled_at : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<NotificationCancelled>(v4);
    }

    public fun deactivate_notification(arg0: &mut NotificationPolicy, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 3);
        arg0.active = false;
        let v0 = NotificationDeactivated{
            policy_id : 0x2::object::id<NotificationPolicy>(arg0),
            owner     : arg0.owner,
        };
        0x2::event::emit<NotificationDeactivated>(v0);
    }

    public fun encrypted_blob(arg0: &NotificationCredential) : vector<u8> {
        arg0.encrypted_blob
    }

    public fun has_active_policy(arg0: &Config, arg1: address) : bool {
        0x2::table::contains<address, 0x2::object::ID>(&arg0.active_wallets, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Config{
            id                  : 0x2::object::new(arg0),
            admin               : 0x2::tx_context::sender(arg0),
            authorized_operator : 0x2::tx_context::sender(arg0),
            active_wallets      : 0x2::table::new<address, 0x2::object::ID>(arg0),
        };
        0x2::transfer::share_object<Config>(v0);
    }

    public fun is_active(arg0: &NotificationPolicy) : bool {
        arg0.active
    }

    public fun owner(arg0: &NotificationPolicy) : address {
        arg0.owner
    }

    public fun policy_id(arg0: &NotificationCredential) : 0x2::object::ID {
        arg0.policy_id
    }

    public fun reactivate_notification(arg0: &mut NotificationPolicy, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 3);
        assert!(!arg0.active, 4);
        arg0.active = true;
        let v0 = NotificationReactivated{
            policy_id : 0x2::object::id<NotificationPolicy>(arg0),
            owner     : arg0.owner,
        };
        0x2::event::emit<NotificationReactivated>(v0);
    }

    entry fun seal_approve(arg0: vector<u8>, arg1: &Config, arg2: &NotificationPolicy, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg1.authorized_operator, 0);
        assert!(arg2.active, 2);
    }

    public fun transfer_admin(arg0: &mut Config, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 1);
        arg0.admin = arg1;
    }

    public fun update_authorized_operator(arg0: &mut Config, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 1);
        arg0.authorized_operator = arg1;
        let v0 = OperatorRotated{
            old_operator : arg0.authorized_operator,
            new_operator : arg1,
        };
        0x2::event::emit<OperatorRotated>(v0);
    }

    public fun update_notification_credential(arg0: &NotificationPolicy, arg1: &mut NotificationCredential, arg2: vector<u8>, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 3);
        assert!(arg1.policy_id == 0x2::object::id<NotificationPolicy>(arg0), 5);
        arg1.encrypted_blob = arg2;
        let v0 = NotificationCredentialUpdated{
            policy_id     : 0x2::object::id<NotificationPolicy>(arg0),
            credential_id : 0x2::object::id<NotificationCredential>(arg1),
            owner         : arg0.owner,
        };
        0x2::event::emit<NotificationCredentialUpdated>(v0);
    }

    // decompiled from Move bytecode v7
}

