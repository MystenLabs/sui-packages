module 0x1951e7af62c7c01cddeeb53da86379ae1f356792cdf5b707f5570fa46ceb4418::subscription {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct ProtocolConfig has key {
        id: 0x2::object::UID,
        treasury: address,
        standard_monthly_price_mist: u64,
        subscription_epochs: u64,
        paused: bool,
    }

    struct BotSubscription has key {
        id: 0x2::object::UID,
        owner: address,
        config_blob_id: vector<u8>,
        config_version: u64,
        channel_id: vector<u8>,
        bot_token_hash: vector<u8>,
        expires_epoch: u64,
        features: u64,
        tier: u8,
    }

    struct SubscriptionCreated has copy, drop {
        subscription_id: 0x2::object::ID,
        owner: address,
        tier: u8,
        expires_epoch: u64,
    }

    struct SubscriptionRenewed has copy, drop {
        subscription_id: 0x2::object::ID,
        owner: address,
        tier: u8,
        expires_epoch: u64,
    }

    struct ConfigUpdated has copy, drop {
        subscription_id: 0x2::object::ID,
        owner: address,
        config_version: u64,
    }

    struct ProtocolConfigUpdated has copy, drop {
        config_id: 0x2::object::ID,
        treasury: address,
        standard_monthly_price_mist: u64,
        subscription_epochs: u64,
        paused: bool,
    }

    public fun id(arg0: &BotSubscription) : 0x2::object::ID {
        0x2::object::id<BotSubscription>(arg0)
    }

    fun assert_valid_payload(arg0: &vector<u8>, arg1: &vector<u8>, arg2: &vector<u8>) {
        assert!(0x1::vector::length<u8>(arg0) > 0, 4);
        assert!(0x1::vector::length<u8>(arg1) > 0, 5);
        assert!(0x1::vector::length<u8>(arg2) == 32, 3);
    }

    public fun bot_token_hash(arg0: &BotSubscription) : &vector<u8> {
        &arg0.bot_token_hash
    }

    public fun bot_token_hash_len() : u64 {
        32
    }

    public fun channel_id(arg0: &BotSubscription) : &vector<u8> {
        &arg0.channel_id
    }

    fun collect_payment(arg0: &ProtocolConfig, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 >= arg2, 2);
        if (arg2 == 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, 0x2::tx_context::sender(arg3));
        } else {
            if (v0 > arg2) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, v0 - arg2, arg3), 0x2::tx_context::sender(arg3));
            };
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, arg0.treasury);
        };
    }

    public fun config_blob_id(arg0: &BotSubscription) : &vector<u8> {
        &arg0.config_blob_id
    }

    public fun config_version(arg0: &BotSubscription) : u64 {
        arg0.config_version
    }

    fun create_protocol(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, v0);
        let v2 = ProtocolConfig{
            id                          : 0x2::object::new(arg0),
            treasury                    : v0,
            standard_monthly_price_mist : 20000000000,
            subscription_epochs         : 30,
            paused                      : false,
        };
        0x2::transfer::share_object<ProtocolConfig>(v2);
    }

    public fun default_subscription_epochs() : u64 {
        30
    }

    fun emit_protocol_config_updated(arg0: &ProtocolConfig) {
        let v0 = ProtocolConfigUpdated{
            config_id                   : 0x2::object::id<ProtocolConfig>(arg0),
            treasury                    : arg0.treasury,
            standard_monthly_price_mist : arg0.standard_monthly_price_mist,
            subscription_epochs         : arg0.subscription_epochs,
            paused                      : arg0.paused,
        };
        0x2::event::emit<ProtocolConfigUpdated>(v0);
    }

    public fun error_empty_channel_id() : u64 {
        5
    }

    public fun error_empty_config_blob_id() : u64 {
        4
    }

    public fun error_insufficient_payment() : u64 {
        2
    }

    public fun error_invalid_bot_token_hash() : u64 {
        3
    }

    public fun error_invalid_tier() : u64 {
        1
    }

    public fun error_not_owner() : u64 {
        0
    }

    public fun error_protocol_paused() : u64 {
        6
    }

    public fun error_zero_subscription_epochs() : u64 {
        7
    }

    public fun expires_epoch(arg0: &BotSubscription) : u64 {
        arg0.expires_epoch
    }

    public fun feature_emoji_reactor() : u64 {
        64
    }

    public fun feature_keyword_reply() : u64 {
        1
    }

    public fun feature_kuiper_blast() : u64 {
        128
    }

    public fun feature_mvp_all() : u64 {
        127
    }

    public fun feature_price_alert() : u64 {
        16
    }

    public fun feature_promo_scheduler() : u64 {
        4
    }

    public fun feature_pulse_scheduler() : u64 {
        8
    }

    public fun feature_raid_detector() : u64 {
        32
    }

    public fun feature_welcome() : u64 {
        2
    }

    public fun features(arg0: &BotSubscription) : u64 {
        arg0.features
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        create_protocol(arg0);
    }

    public fun is_expired(arg0: &BotSubscription, arg1: &0x2::tx_context::TxContext) : bool {
        arg0.expires_epoch <= 0x2::tx_context::epoch(arg1)
    }

    public fun is_paused(arg0: &ProtocolConfig) : bool {
        arg0.paused
    }

    public fun monthly_price_mist(arg0: &ProtocolConfig, arg1: u8) : u64 {
        if (arg1 == 0) {
            0
        } else {
            assert!(arg1 == 1, 1);
            arg0.standard_monthly_price_mist
        }
    }

    public fun owner(arg0: &BotSubscription) : address {
        arg0.owner
    }

    public entry fun renew(arg0: &ProtocolConfig, arg1: &mut BotSubscription, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 6);
        assert!(arg1.owner == 0x2::tx_context::sender(arg3), 0);
        collect_payment(arg0, arg2, monthly_price_mist(arg0, arg1.tier), arg3);
        let v0 = 0x2::tx_context::epoch(arg3);
        let v1 = if (arg1.expires_epoch > v0) {
            arg1.expires_epoch
        } else {
            v0
        };
        arg1.expires_epoch = v1 + arg0.subscription_epochs;
        let v2 = SubscriptionRenewed{
            subscription_id : 0x2::object::id<BotSubscription>(arg1),
            owner           : arg1.owner,
            tier            : arg1.tier,
            expires_epoch   : arg1.expires_epoch,
        };
        0x2::event::emit<SubscriptionRenewed>(v2);
    }

    public entry fun set_paused(arg0: &AdminCap, arg1: &mut ProtocolConfig, arg2: bool) {
        arg1.paused = arg2;
        emit_protocol_config_updated(arg1);
    }

    public entry fun set_standard_monthly_price(arg0: &AdminCap, arg1: &mut ProtocolConfig, arg2: u64) {
        arg1.standard_monthly_price_mist = arg2;
        emit_protocol_config_updated(arg1);
    }

    public entry fun set_subscription_epochs(arg0: &AdminCap, arg1: &mut ProtocolConfig, arg2: u64) {
        assert!(arg2 > 0, 7);
        arg1.subscription_epochs = arg2;
        emit_protocol_config_updated(arg1);
    }

    public entry fun set_treasury(arg0: &AdminCap, arg1: &mut ProtocolConfig, arg2: address) {
        arg1.treasury = arg2;
        emit_protocol_config_updated(arg1);
    }

    public entry fun setup(arg0: &ProtocolConfig, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: u8, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 6);
        assert_valid_payload(&arg2, &arg3, &arg4);
        collect_payment(arg0, arg1, monthly_price_mist(arg0, arg5), arg7);
        let v0 = BotSubscription{
            id             : 0x2::object::new(arg7),
            owner          : 0x2::tx_context::sender(arg7),
            config_blob_id : arg2,
            config_version : 1,
            channel_id     : arg3,
            bot_token_hash : arg4,
            expires_epoch  : 0x2::tx_context::epoch(arg7) + arg0.subscription_epochs,
            features       : arg6,
            tier           : arg5,
        };
        let v1 = SubscriptionCreated{
            subscription_id : 0x2::object::id<BotSubscription>(&v0),
            owner           : v0.owner,
            tier            : arg5,
            expires_epoch   : v0.expires_epoch,
        };
        0x2::event::emit<SubscriptionCreated>(v1);
        0x2::transfer::share_object<BotSubscription>(v0);
    }

    public fun standard_monthly_price_mist(arg0: &ProtocolConfig) : u64 {
        arg0.standard_monthly_price_mist
    }

    public fun standard_monthly_price_mist_default() : u64 {
        20000000000
    }

    public fun subscription_epochs(arg0: &ProtocolConfig) : u64 {
        arg0.subscription_epochs
    }

    public fun tier(arg0: &BotSubscription) : u8 {
        arg0.tier
    }

    public fun tier_free() : u8 {
        0
    }

    public fun tier_pro() : u8 {
        2
    }

    public fun tier_standard() : u8 {
        1
    }

    public fun treasury(arg0: &ProtocolConfig) : address {
        arg0.treasury
    }

    public entry fun update_bot_token_hash(arg0: &mut BotSubscription, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 0);
        assert!(0x1::vector::length<u8>(&arg1) == 32, 3);
        arg0.bot_token_hash = arg1;
    }

    public entry fun update_config(arg0: &mut BotSubscription, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 0);
        assert!(0x1::vector::length<u8>(&arg1) > 0, 4);
        arg0.config_blob_id = arg1;
        arg0.config_version = arg0.config_version + 1;
        let v0 = ConfigUpdated{
            subscription_id : 0x2::object::id<BotSubscription>(arg0),
            owner           : arg0.owner,
            config_version  : arg0.config_version,
        };
        0x2::event::emit<ConfigUpdated>(v0);
    }

    // decompiled from Move bytecode v6
}

