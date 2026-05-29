module 0x50ab30e6fb02425e856e2d0c7919875f285d1e12a1d747f29a130ddd22af8e83::mailgate {
    struct MAILGATE has drop {
        dummy_field: bool,
    }

    struct DelegatePolicy has copy, drop, store {
        permissions: u64,
        label: 0x1::string::String,
        created_at: u64,
    }

    struct MailGateAccount<phantom T0> has key {
        id: 0x2::object::UID,
        owner: address,
        email_hash: vector<u8>,
        external_email_hash: vector<u8>,
        mode: u8,
        toll_amount: u64,
        delegates: 0x2::vec_map::VecMap<address, DelegatePolicy>,
        blacklist: 0x2::vec_map::VecMap<address, bool>,
        contacts: 0x2::vec_map::VecMap<address, bool>,
        whitelist: 0x2::vec_map::VecMap<address, bool>,
        balance: 0x2::balance::Balance<T0>,
    }

    struct AccountUpgradeCommitment has store, key {
        id: 0x2::object::UID,
        request_id: 0x1::string::String,
        account_object_id: address,
        current_owner: address,
        target_wallet: address,
        treasury: address,
        amount_mist: u64,
        status: u8,
        created_at: u64,
        expires_at: u64,
    }

    struct StripeMailCommitment has store, key {
        id: 0x2::object::UID,
        email_hash: vector<u8>,
        sender: address,
        recipient: address,
        stripe_session_id: 0x1::string::String,
        amount_usd_cents: u64,
        status: u8,
        created_at: u64,
    }

    struct EmailRegistry has key {
        id: 0x2::object::UID,
        registry: 0x2::table::Table<vector<u8>, address>,
    }

    struct AccountCreated has copy, drop {
        account_id: 0x2::object::ID,
        owner: address,
        email_hash: vector<u8>,
    }

    struct TollUpdated has copy, drop {
        account_id: 0x2::object::ID,
        old_amount: u64,
        new_amount: u64,
    }

    struct ModeUpdated has copy, drop {
        account_id: 0x2::object::ID,
        old_mode: u8,
        new_mode: u8,
    }

    struct AccountUpgraded has copy, drop {
        account_id: 0x2::object::ID,
        owner: address,
        old_email_hash: vector<u8>,
        new_email_hash: vector<u8>,
        new_mode: u8,
    }

    struct StripeMailCommitted has copy, drop {
        commitment_id: 0x2::object::ID,
        sender: address,
        recipient: address,
        stripe_session_id: 0x1::string::String,
        amount_usd_cents: u64,
    }

    struct AccountUpgradeCommitted has copy, drop {
        commitment_id: 0x2::object::ID,
        request_id: 0x1::string::String,
        account_object_id: address,
        current_owner: address,
        target_wallet: address,
        amount_mist: u64,
    }

    struct AccountUpgradePaid has copy, drop {
        commitment_id: 0x2::object::ID,
        request_id: 0x1::string::String,
        account_object_id: address,
        current_owner: address,
        target_wallet: address,
        amount: u64,
    }

    struct AccountOwnershipTransferred has copy, drop {
        account_id: 0x2::object::ID,
        old_owner: address,
        new_owner: address,
    }

    struct DelegateAdded has copy, drop {
        account_id: 0x2::object::ID,
        delegate_address: address,
        permissions: u64,
        label: 0x1::string::String,
    }

    struct DelegateRemoved has copy, drop {
        account_id: 0x2::object::ID,
        delegate_address: address,
    }

    struct BlacklistAdded has copy, drop {
        account_id: 0x2::object::ID,
        addr: address,
    }

    struct BlacklistRemoved has copy, drop {
        account_id: 0x2::object::ID,
        addr: address,
    }

    struct WhitelistAdded has copy, drop {
        account_id: 0x2::object::ID,
        addr: address,
    }

    struct WhitelistRemoved has copy, drop {
        account_id: 0x2::object::ID,
        addr: address,
    }

    struct BalanceDeposited has copy, drop {
        account_id: 0x2::object::ID,
        depositor: address,
        amount: u64,
    }

    struct BalanceWithdrawn has copy, drop {
        account_id: 0x2::object::ID,
        owner: address,
        amount: u64,
    }

    struct TollTransferred has copy, drop {
        sender_account_id: 0x2::object::ID,
        recipient_account_id: 0x2::object::ID,
        delegate: address,
        amount: u64,
    }

    public fun add_delegate<T0>(arg0: &mut MailGateAccount<T0>, arg1: address, arg2: u64, arg3: 0x1::string::String, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg5), 2);
        assert!(!0x2::vec_map::contains<address, DelegatePolicy>(&arg0.delegates, &arg1), 10);
        assert!(arg2 & 18446744073709551584 == 0, 11);
        let v0 = DelegatePolicy{
            permissions : arg2,
            label       : arg3,
            created_at  : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::vec_map::insert<address, DelegatePolicy>(&mut arg0.delegates, arg1, v0);
        let v1 = DelegateAdded{
            account_id       : 0x2::object::id<MailGateAccount<T0>>(arg0),
            delegate_address : arg1,
            permissions      : arg2,
            label            : arg3,
        };
        0x2::event::emit<DelegateAdded>(v1);
    }

    public fun add_to_blacklist<T0>(arg0: &mut MailGateAccount<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert_authorized<T0>(arg0, 0x2::tx_context::sender(arg2), 8);
        assert!(!0x2::vec_map::contains<address, bool>(&arg0.blacklist, &arg1), 13);
        assert!(0x2::vec_map::length<address, bool>(&arg0.blacklist) < 1000, 15);
        if (0x2::vec_map::contains<address, bool>(&arg0.contacts, &arg1)) {
            let (_, _) = 0x2::vec_map::remove<address, bool>(&mut arg0.contacts, &arg1);
        };
        if (0x2::vec_map::contains<address, bool>(&arg0.whitelist, &arg1)) {
            let (_, _) = 0x2::vec_map::remove<address, bool>(&mut arg0.whitelist, &arg1);
        };
        0x2::vec_map::insert<address, bool>(&mut arg0.blacklist, arg1, true);
        let v4 = BlacklistAdded{
            account_id : 0x2::object::id<MailGateAccount<T0>>(arg0),
            addr       : arg1,
        };
        0x2::event::emit<BlacklistAdded>(v4);
    }

    public fun add_to_whitelist<T0>(arg0: &mut MailGateAccount<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert_authorized<T0>(arg0, 0x2::tx_context::sender(arg2), 8);
        assert!(!0x2::vec_map::contains<address, bool>(&arg0.whitelist, &arg1), 13);
        assert!(0x2::vec_map::length<address, bool>(&arg0.whitelist) < 1000, 15);
        if (0x2::vec_map::contains<address, bool>(&arg0.blacklist, &arg1)) {
            let (_, _) = 0x2::vec_map::remove<address, bool>(&mut arg0.blacklist, &arg1);
        };
        if (0x2::vec_map::contains<address, bool>(&arg0.contacts, &arg1)) {
            let (_, _) = 0x2::vec_map::remove<address, bool>(&mut arg0.contacts, &arg1);
        };
        0x2::vec_map::insert<address, bool>(&mut arg0.whitelist, arg1, true);
        let v4 = WhitelistAdded{
            account_id : 0x2::object::id<MailGateAccount<T0>>(arg0),
            addr       : arg1,
        };
        0x2::event::emit<WhitelistAdded>(v4);
    }

    public fun assert_authorized<T0>(arg0: &MailGateAccount<T0>, arg1: address, arg2: u64) {
        if (arg1 == arg0.owner) {
            return
        };
        let v0 = 0x2::vec_map::try_get<address, DelegatePolicy>(&arg0.delegates, &arg1);
        assert!(0x1::option::is_some<DelegatePolicy>(&v0), 8);
        let v1 = 0x1::option::destroy_some<DelegatePolicy>(v0);
        assert!(v1.permissions & arg2 != 0, 8);
    }

    public fun create_account<T0>(arg0: &mut EmailRegistry, arg1: vector<u8>, arg2: u8, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(!0x2::table::contains<vector<u8>, address>(&arg0.registry, arg1), 0);
        assert!(arg2 == 0 || arg2 == 1, 9);
        let v1 = MailGateAccount<T0>{
            id                  : 0x2::object::new(arg4),
            owner               : v0,
            email_hash          : arg1,
            external_email_hash : b"",
            mode                : arg2,
            toll_amount         : arg3,
            delegates           : 0x2::vec_map::empty<address, DelegatePolicy>(),
            blacklist           : 0x2::vec_map::empty<address, bool>(),
            contacts            : 0x2::vec_map::empty<address, bool>(),
            whitelist           : 0x2::vec_map::empty<address, bool>(),
            balance             : 0x2::balance::zero<T0>(),
        };
        0x2::table::add<vector<u8>, address>(&mut arg0.registry, arg1, v0);
        let v2 = AccountCreated{
            account_id : 0x2::object::id<MailGateAccount<T0>>(&v1),
            owner      : v0,
            email_hash : arg1,
        };
        0x2::event::emit<AccountCreated>(v2);
        0x2::transfer::share_object<MailGateAccount<T0>>(v1);
    }

    public fun create_custodial_account<T0, T1>(arg0: &mut EmailRegistry, arg1: &0x50ab30e6fb02425e856e2d0c7919875f285d1e12a1d747f29a130ddd22af8e83::enclave::Enclave<T0>, arg2: vector<u8>, arg3: u8, arg4: u64, arg5: vector<u8>, arg6: vector<u8>, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        assert!(!0x2::table::contains<vector<u8>, address>(&arg0.registry, arg2), 0);
        assert!(arg3 == 0 || arg3 == 1, 9);
        assert!(0x2::ed25519::ed25519_verify(&arg5, 0x50ab30e6fb02425e856e2d0c7919875f285d1e12a1d747f29a130ddd22af8e83::enclave::pk<T0>(arg1), &arg6), 8);
        let v1 = MailGateAccount<T1>{
            id                  : 0x2::object::new(arg7),
            owner               : v0,
            email_hash          : arg2,
            external_email_hash : b"",
            mode                : arg3,
            toll_amount         : arg4,
            delegates           : 0x2::vec_map::empty<address, DelegatePolicy>(),
            blacklist           : 0x2::vec_map::empty<address, bool>(),
            contacts            : 0x2::vec_map::empty<address, bool>(),
            whitelist           : 0x2::vec_map::empty<address, bool>(),
            balance             : 0x2::balance::zero<T1>(),
        };
        0x2::table::add<vector<u8>, address>(&mut arg0.registry, arg2, v0);
        let v2 = AccountCreated{
            account_id : 0x2::object::id<MailGateAccount<T1>>(&v1),
            owner      : v0,
            email_hash : arg2,
        };
        0x2::event::emit<AccountCreated>(v2);
        0x2::transfer::share_object<MailGateAccount<T1>>(v1);
    }

    public fun create_custodial_account_fleet<T0, T1>(arg0: &mut EmailRegistry, arg1: &0x50ab30e6fb02425e856e2d0c7919875f285d1e12a1d747f29a130ddd22af8e83::enclave::EnclaveConfig<T0>, arg2: vector<u8>, arg3: u8, arg4: u64, arg5: vector<u8>, arg6: vector<u8>, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        assert!(!0x2::table::contains<vector<u8>, address>(&arg0.registry, arg2), 0);
        assert!(arg3 == 0 || arg3 == 1, 9);
        assert!(0x50ab30e6fb02425e856e2d0c7919875f285d1e12a1d747f29a130ddd22af8e83::enclave::verify_fleet_raw_signature<T0>(arg1, &arg5, &arg6), 8);
        let v1 = MailGateAccount<T1>{
            id                  : 0x2::object::new(arg7),
            owner               : v0,
            email_hash          : arg2,
            external_email_hash : b"",
            mode                : arg3,
            toll_amount         : arg4,
            delegates           : 0x2::vec_map::empty<address, DelegatePolicy>(),
            blacklist           : 0x2::vec_map::empty<address, bool>(),
            contacts            : 0x2::vec_map::empty<address, bool>(),
            whitelist           : 0x2::vec_map::empty<address, bool>(),
            balance             : 0x2::balance::zero<T1>(),
        };
        0x2::table::add<vector<u8>, address>(&mut arg0.registry, arg2, v0);
        let v2 = AccountCreated{
            account_id : 0x2::object::id<MailGateAccount<T1>>(&v1),
            owner      : v0,
            email_hash : arg2,
        };
        0x2::event::emit<AccountCreated>(v2);
        0x2::transfer::share_object<MailGateAccount<T1>>(v1);
    }

    public fun create_stripe_commitment(arg0: vector<u8>, arg1: address, arg2: address, arg3: 0x1::string::String, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = StripeMailCommitment{
            id                : 0x2::object::new(arg6),
            email_hash        : arg0,
            sender            : arg1,
            recipient         : arg2,
            stripe_session_id : arg3,
            amount_usd_cents  : arg4,
            status            : 1,
            created_at        : 0x2::clock::timestamp_ms(arg5),
        };
        let v1 = StripeMailCommitted{
            commitment_id     : 0x2::object::id<StripeMailCommitment>(&v0),
            sender            : arg1,
            recipient         : arg2,
            stripe_session_id : arg3,
            amount_usd_cents  : arg4,
        };
        0x2::event::emit<StripeMailCommitted>(v1);
        0x2::transfer::transfer<StripeMailCommitment>(v0, arg2);
    }

    public fun create_upgrade_commitment(arg0: 0x1::string::String, arg1: address, arg2: address, arg3: address, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x2::clock::timestamp_ms(arg5);
        let v2 = AccountUpgradeCommitment{
            id                : 0x2::object::new(arg6),
            request_id        : arg0,
            account_object_id : arg1,
            current_owner     : arg2,
            target_wallet     : v0,
            treasury          : arg3,
            amount_mist       : arg4,
            status            : 0,
            created_at        : v1,
            expires_at        : v1 + 259200000,
        };
        let v3 = AccountUpgradeCommitted{
            commitment_id     : 0x2::object::id<AccountUpgradeCommitment>(&v2),
            request_id        : arg0,
            account_object_id : arg1,
            current_owner     : arg2,
            target_wallet     : v0,
            amount_mist       : arg4,
        };
        0x2::event::emit<AccountUpgradeCommitted>(v3);
        0x2::transfer::transfer<AccountUpgradeCommitment>(v2, v0);
    }

    public fun delegate_pay_toll<T0>(arg0: &mut MailGateAccount<T0>, arg1: &mut MailGateAccount<T0>, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert!(arg2 >= arg1.toll_amount, 7);
        assert_authorized<T0>(arg0, 0x2::tx_context::sender(arg3), 16);
        assert!(0x2::balance::value<T0>(&arg0.balance) >= arg2, 20);
        0x2::balance::join<T0>(&mut arg1.balance, 0x2::balance::split<T0>(&mut arg0.balance, arg2));
        let v0 = TollTransferred{
            sender_account_id    : 0x2::object::id<MailGateAccount<T0>>(arg0),
            recipient_account_id : 0x2::object::id<MailGateAccount<T0>>(arg1),
            delegate             : 0x2::tx_context::sender(arg3),
            amount               : arg2,
        };
        0x2::event::emit<TollTransferred>(v0);
    }

    public fun deposit_balance<T0>(arg0: &mut MailGateAccount<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::tx_context::TxContext) {
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg1));
        let v0 = BalanceDeposited{
            account_id : 0x2::object::id<MailGateAccount<T0>>(arg0),
            depositor  : 0x2::tx_context::sender(arg2),
            amount     : 0x2::coin::value<T0>(&arg1),
        };
        0x2::event::emit<BalanceDeposited>(v0);
    }

    public fun get_account_owner(arg0: &EmailRegistry, arg1: &vector<u8>) : address {
        assert!(0x2::table::contains<vector<u8>, address>(&arg0.registry, *arg1), 1);
        *0x2::table::borrow<vector<u8>, address>(&arg0.registry, *arg1)
    }

    public fun get_balance<T0>(arg0: &MailGateAccount<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun get_blacklist<T0>(arg0: &MailGateAccount<T0>) : 0x2::vec_map::VecMap<address, bool> {
        arg0.blacklist
    }

    public fun get_delegate_permissions<T0>(arg0: &MailGateAccount<T0>, arg1: address) : u64 {
        if (0x2::vec_map::contains<address, DelegatePolicy>(&arg0.delegates, &arg1)) {
            0x2::vec_map::get<address, DelegatePolicy>(&arg0.delegates, &arg1).permissions
        } else {
            0
        }
    }

    public fun get_delegates<T0>(arg0: &MailGateAccount<T0>) : 0x2::vec_map::VecMap<address, DelegatePolicy> {
        arg0.delegates
    }

    public fun get_email_hash<T0>(arg0: &MailGateAccount<T0>) : vector<u8> {
        arg0.email_hash
    }

    public fun get_external_email_hash<T0>(arg0: &MailGateAccount<T0>) : vector<u8> {
        arg0.external_email_hash
    }

    public fun get_mode<T0>(arg0: &MailGateAccount<T0>) : u8 {
        arg0.mode
    }

    public fun get_owner<T0>(arg0: &MailGateAccount<T0>) : address {
        arg0.owner
    }

    public fun get_stripe_commitment_amount(arg0: &StripeMailCommitment) : u64 {
        arg0.amount_usd_cents
    }

    public fun get_stripe_commitment_recipient(arg0: &StripeMailCommitment) : address {
        arg0.recipient
    }

    public fun get_stripe_commitment_sender(arg0: &StripeMailCommitment) : address {
        arg0.sender
    }

    public fun get_stripe_commitment_status(arg0: &StripeMailCommitment) : u8 {
        arg0.status
    }

    public fun get_stripe_session_id(arg0: &StripeMailCommitment) : 0x1::string::String {
        arg0.stripe_session_id
    }

    public fun get_toll_amount<T0>(arg0: &MailGateAccount<T0>) : u64 {
        arg0.toll_amount
    }

    public fun get_upgrade_commitment_amount(arg0: &AccountUpgradeCommitment) : u64 {
        arg0.amount_mist
    }

    public fun get_upgrade_commitment_request_id(arg0: &AccountUpgradeCommitment) : 0x1::string::String {
        arg0.request_id
    }

    public fun get_upgrade_commitment_status(arg0: &AccountUpgradeCommitment) : u8 {
        arg0.status
    }

    public fun get_upgrade_commitment_target_wallet(arg0: &AccountUpgradeCommitment) : address {
        arg0.target_wallet
    }

    public fun get_whitelist<T0>(arg0: &MailGateAccount<T0>) : 0x2::vec_map::VecMap<address, bool> {
        arg0.whitelist
    }

    fun init(arg0: MAILGATE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = EmailRegistry{
            id       : 0x2::object::new(arg1),
            registry : 0x2::table::new<vector<u8>, address>(arg1),
        };
        0x2::transfer::share_object<EmailRegistry>(v0);
    }

    public fun is_blacklisted<T0>(arg0: &MailGateAccount<T0>, arg1: address) : bool {
        0x2::vec_map::contains<address, bool>(&arg0.blacklist, &arg1)
    }

    public fun is_whitelisted<T0>(arg0: &MailGateAccount<T0>, arg1: address) : bool {
        0x2::vec_map::contains<address, bool>(&arg0.whitelist, &arg1)
    }

    public fun migrate_contacts_to_whitelist<T0>(arg0: &mut MailGateAccount<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg1), 2);
        while (!0x2::vec_map::is_empty<address, bool>(&arg0.contacts)) {
            let (v0, _) = 0x2::vec_map::pop<address, bool>(&mut arg0.contacts);
            let v2 = v0;
            if (!0x2::vec_map::contains<address, bool>(&arg0.whitelist, &v2)) {
                assert!(0x2::vec_map::length<address, bool>(&arg0.whitelist) < 1000, 15);
                0x2::vec_map::insert<address, bool>(&mut arg0.whitelist, v2, true);
                let v3 = WhitelistAdded{
                    account_id : 0x2::object::id<MailGateAccount<T0>>(arg0),
                    addr       : v2,
                };
                0x2::event::emit<WhitelistAdded>(v3);
            };
        };
    }

    public fun pay_upgrade_commitment(arg0: &mut AccountUpgradeCommitment, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.target_wallet, 12);
        assert!(0x2::clock::timestamp_ms(arg2) < arg0.expires_at, 5);
        assert!(arg0.status == 0, 6);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= arg0.amount_mist, 7);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        if (v0 > arg0.amount_mist) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, v0 - arg0.amount_mist, arg3), 0x2::tx_context::sender(arg3));
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, arg0.treasury);
        arg0.status = 1;
        let v1 = AccountUpgradePaid{
            commitment_id     : 0x2::object::id<AccountUpgradeCommitment>(arg0),
            request_id        : arg0.request_id,
            account_object_id : arg0.account_object_id,
            current_owner     : arg0.current_owner,
            target_wallet     : arg0.target_wallet,
            amount            : arg0.amount_mist,
        };
        0x2::event::emit<AccountUpgradePaid>(v1);
    }

    public fun remove_delegate<T0>(arg0: &mut MailGateAccount<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 2);
        assert!(0x2::vec_map::contains<address, DelegatePolicy>(&arg0.delegates, &arg1), 3);
        let (_, _) = 0x2::vec_map::remove<address, DelegatePolicy>(&mut arg0.delegates, &arg1);
        let v2 = DelegateRemoved{
            account_id       : 0x2::object::id<MailGateAccount<T0>>(arg0),
            delegate_address : arg1,
        };
        0x2::event::emit<DelegateRemoved>(v2);
    }

    public fun remove_from_blacklist<T0>(arg0: &mut MailGateAccount<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert_authorized<T0>(arg0, 0x2::tx_context::sender(arg2), 8);
        assert!(0x2::vec_map::contains<address, bool>(&arg0.blacklist, &arg1), 14);
        let (_, _) = 0x2::vec_map::remove<address, bool>(&mut arg0.blacklist, &arg1);
        let v2 = BlacklistRemoved{
            account_id : 0x2::object::id<MailGateAccount<T0>>(arg0),
            addr       : arg1,
        };
        0x2::event::emit<BlacklistRemoved>(v2);
    }

    public fun remove_from_whitelist<T0>(arg0: &mut MailGateAccount<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert_authorized<T0>(arg0, 0x2::tx_context::sender(arg2), 8);
        assert!(0x2::vec_map::contains<address, bool>(&arg0.whitelist, &arg1), 14);
        let (_, _) = 0x2::vec_map::remove<address, bool>(&mut arg0.whitelist, &arg1);
        let v2 = WhitelistRemoved{
            account_id : 0x2::object::id<MailGateAccount<T0>>(arg0),
            addr       : arg1,
        };
        0x2::event::emit<WhitelistRemoved>(v2);
    }

    public fun set_external_email_hash<T0>(arg0: &mut MailGateAccount<T0>, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 2);
        arg0.external_email_hash = arg1;
    }

    public fun transfer_account_owner<T0>(arg0: MailGateAccount<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 2);
        arg0.owner = arg1;
        let v0 = AccountOwnershipTransferred{
            account_id : 0x2::object::id<MailGateAccount<T0>>(&arg0),
            old_owner  : arg0.owner,
            new_owner  : arg1,
        };
        0x2::event::emit<AccountOwnershipTransferred>(v0);
        0x2::transfer::transfer<MailGateAccount<T0>>(arg0, arg1);
    }

    public fun update_mode<T0>(arg0: &mut MailGateAccount<T0>, arg1: u8, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 2);
        assert!(arg1 == 0 || arg1 == 1, 9);
        arg0.mode = arg1;
        let v0 = ModeUpdated{
            account_id : 0x2::object::id<MailGateAccount<T0>>(arg0),
            old_mode   : arg0.mode,
            new_mode   : arg1,
        };
        0x2::event::emit<ModeUpdated>(v0);
    }

    public fun update_toll<T0>(arg0: &mut MailGateAccount<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 2);
        arg0.toll_amount = arg1;
        let v0 = TollUpdated{
            account_id : 0x2::object::id<MailGateAccount<T0>>(arg0),
            old_amount : arg0.toll_amount,
            new_amount : arg1,
        };
        0x2::event::emit<TollUpdated>(v0);
    }

    public fun upgrade_account<T0>(arg0: &mut EmailRegistry, arg1: &mut MailGateAccount<T0>, arg2: vector<u8>, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(arg1.owner == v0, 2);
        assert!(!0x2::table::contains<vector<u8>, address>(&arg0.registry, arg2), 0);
        assert!(arg3 == 0 || arg3 == 1, 9);
        let v1 = arg1.email_hash;
        if (0x2::table::contains<vector<u8>, address>(&arg0.registry, v1)) {
            0x2::table::remove<vector<u8>, address>(&mut arg0.registry, v1);
        };
        arg1.email_hash = arg2;
        arg1.mode = arg3;
        0x2::table::add<vector<u8>, address>(&mut arg0.registry, arg2, v0);
        let v2 = AccountUpgraded{
            account_id     : 0x2::object::id<MailGateAccount<T0>>(arg1),
            owner          : v0,
            old_email_hash : v1,
            new_email_hash : arg2,
            new_mode       : arg3,
        };
        0x2::event::emit<AccountUpgraded>(v2);
    }

    public fun withdraw_balance<T0>(arg0: &mut MailGateAccount<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 2);
        assert!(0x2::balance::value<T0>(&arg0.balance) >= arg1, 20);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, arg1), arg2), 0x2::tx_context::sender(arg2));
        let v0 = BalanceWithdrawn{
            account_id : 0x2::object::id<MailGateAccount<T0>>(arg0),
            owner      : 0x2::tx_context::sender(arg2),
            amount     : arg1,
        };
        0x2::event::emit<BalanceWithdrawn>(v0);
    }

    // decompiled from Move bytecode v7
}

