module 0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::payment {
    struct PaymentConfig has key {
        id: 0x2::object::UID,
        version: u64,
        owner: address,
        pending_owner: 0x1::option::Option<address>,
        recipient: address,
        paused: bool,
    }

    struct PaymentConfigCreated has copy, drop {
        owner: address,
        recipient: address,
    }

    struct PaymentReceived has copy, drop {
        payer: address,
        recipient: address,
        amount: u64,
        ref: vector<u8>,
        timestamp_ms: u64,
    }

    struct TokenRecipientSet has copy, drop {
        old_recipient: address,
        new_recipient: address,
    }

    struct PaymentPauseUpdated has copy, drop {
        paused: bool,
    }

    struct OwnershipTransferStarted has copy, drop {
        previous_owner: address,
        new_owner: address,
    }

    struct OwnershipTransferred has copy, drop {
        previous_owner: address,
        new_owner: address,
    }

    struct VersionMigrated has copy, drop {
        previous_version: u64,
        new_version: u64,
    }

    public fun owner(arg0: &PaymentConfig) : address {
        arg0.owner
    }

    public fun payment(arg0: &PaymentConfig, arg1: &0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::compliance::Compliance, arg2: &0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::policy::Policy<0x2::balance::Balance<0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::xaua::XAUA>>, arg3: &mut 0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::account::Account, arg4: u64, arg5: vector<u8>, arg6: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert!(!arg0.paused, 13835340410727301123);
        assert!(arg4 > 0, 13835903364975951879);
        let v0 = 0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::account::new_auth(arg6);
        let v1 = 0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::account::unsafe_send_balance<0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::xaua::XAUA>(arg3, &v0, arg0.recipient, arg4, arg6);
        0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::compliance::approve_transfer(arg1, &mut v1);
        0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::send_funds::resolve_balance<0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::xaua::XAUA>(v1, arg2);
        let v2 = PaymentReceived{
            payer        : 0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::account::owner(arg3),
            recipient    : arg0.recipient,
            amount       : arg4,
            ref          : arg5,
            timestamp_ms : 0x2::tx_context::epoch_timestamp_ms(arg6),
        };
        0x2::event::emit<PaymentReceived>(v2);
    }

    public fun accept_ownership(arg0: &mut PaymentConfig, arg1: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert!(0x1::option::is_some<address>(&arg0.pending_owner), 13836466190375583755);
        let v0 = *0x1::option::borrow<address>(&arg0.pending_owner);
        assert!(0x2::tx_context::sender(arg1) == v0, 13836184723988676617);
        arg0.owner = v0;
        arg0.pending_owner = 0x1::option::none<address>();
        let v1 = OwnershipTransferred{
            previous_owner : arg0.owner,
            new_owner      : v0,
        };
        0x2::event::emit<OwnershipTransferred>(v1);
    }

    fun assert_owner(arg0: &PaymentConfig, arg1: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 13835059038829674497);
    }

    public fun assert_version(arg0: &PaymentConfig) {
        assert!(arg0.version == 0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::version::current(), 13836747321755041805);
    }

    public fun cancel_ownership_transfer(arg0: &mut PaymentConfig, arg1: &mut 0x2::tx_context::TxContext) {
        assert_owner(arg0, arg1);
        arg0.pending_owner = 0x1::option::none<address>();
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = PaymentConfig{
            id            : 0x2::object::new(arg0),
            version       : 0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::version::current(),
            owner         : v0,
            pending_owner : 0x1::option::none<address>(),
            recipient     : v0,
            paused        : false,
        };
        0x2::transfer::share_object<PaymentConfig>(v1);
        let v2 = PaymentConfigCreated{
            owner     : v0,
            recipient : v0,
        };
        0x2::event::emit<PaymentConfigCreated>(v2);
    }

    public fun is_paused(arg0: &PaymentConfig) : bool {
        arg0.paused
    }

    public fun migrate(arg0: &mut PaymentConfig, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 13835058527728566273);
        assert!(arg0.version < 0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::version::current(), 13837028856861425679);
        arg0.version = 0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::version::current();
        let v0 = VersionMigrated{
            previous_version : arg0.version,
            new_version      : 0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::version::current(),
        };
        0x2::event::emit<VersionMigrated>(v0);
    }

    public fun pending_owner(arg0: &PaymentConfig) : 0x1::option::Option<address> {
        arg0.pending_owner
    }

    public fun recipient(arg0: &PaymentConfig) : address {
        arg0.recipient
    }

    public fun set_paused(arg0: &mut PaymentConfig, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        assert_owner(arg0, arg2);
        arg0.paused = arg1;
        let v0 = PaymentPauseUpdated{paused: arg1};
        0x2::event::emit<PaymentPauseUpdated>(v0);
    }

    public fun set_recipient(arg0: &mut PaymentConfig, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert_owner(arg0, arg2);
        assert!(arg1 != @0x0, 13835621615121203205);
        arg0.recipient = arg1;
        let v0 = TokenRecipientSet{
            old_recipient : arg0.recipient,
            new_recipient : arg1,
        };
        0x2::event::emit<TokenRecipientSet>(v0);
    }

    public fun transfer_ownership(arg0: &mut PaymentConfig, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert_owner(arg0, arg2);
        assert!(arg1 != @0x0, 13835621713905451013);
        arg0.pending_owner = 0x1::option::some<address>(arg1);
        let v0 = OwnershipTransferStarted{
            previous_owner : arg0.owner,
            new_owner      : arg1,
        };
        0x2::event::emit<OwnershipTransferStarted>(v0);
    }

    public fun version(arg0: &PaymentConfig) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v7
}

