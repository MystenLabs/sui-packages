module 0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::payment {
    struct PaymentConfig has key {
        id: 0x2::object::UID,
        owner: address,
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

    public fun owner(arg0: &PaymentConfig) : address {
        arg0.owner
    }

    public fun payment(arg0: &PaymentConfig, arg1: &0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::compliance::Compliance, arg2: &0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::policy::Policy<0x2::balance::Balance<0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::xaua::XAUA>>, arg3: &mut 0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::account::Account, arg4: u64, arg5: vector<u8>, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 13835339968345669635);
        assert!(arg4 > 0, 13835902922594320391);
        let v0 = 0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::account::new_auth(arg6);
        let v1 = 0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::account::unsafe_send_balance<0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::xaua::XAUA>(arg3, &v0, arg0.recipient, arg4, arg6);
        0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::compliance::approve_transfer(arg1, &mut v1);
        0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::send_funds::resolve_balance<0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::xaua::XAUA>(v1, arg2);
        let v2 = PaymentReceived{
            payer        : 0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::account::owner(arg3),
            recipient    : arg0.recipient,
            amount       : arg4,
            ref          : arg5,
            timestamp_ms : 0x2::tx_context::epoch_timestamp_ms(arg6),
        };
        0x2::event::emit<PaymentReceived>(v2);
    }

    fun assert_owner(arg0: &PaymentConfig, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 13835058592153075713);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = PaymentConfig{
            id        : 0x2::object::new(arg0),
            owner     : v0,
            recipient : v0,
            paused    : false,
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
        assert!(arg1 != @0x0, 13835621340243296261);
        arg0.recipient = arg1;
        let v0 = TokenRecipientSet{
            old_recipient : arg0.recipient,
            new_recipient : arg1,
        };
        0x2::event::emit<TokenRecipientSet>(v0);
    }

    // decompiled from Move bytecode v7
}

