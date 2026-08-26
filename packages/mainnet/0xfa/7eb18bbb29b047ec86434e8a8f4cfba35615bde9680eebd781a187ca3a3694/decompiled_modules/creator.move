module 0xc5c833991ed1123d70b1001c0bcdb01ec5728b09f25dfc42a0edaf16005d404d::creator {
    struct Tier has copy, drop, store {
        name: 0x1::string::String,
        price: u64,
        period_ms: u64,
        active: bool,
    }

    struct CreatorCap has store, key {
        id: 0x2::object::UID,
        vault: 0x2::object::ID,
    }

    struct CreatorVault<phantom T0> has key {
        id: 0x2::object::UID,
        version: u64,
        platform: 0x2::object::ID,
        owner: address,
        account: 0x2::object::ID,
        fee_bps_snapshot: u64,
        referral_share_bps_snapshot: u64,
        tiers: vector<Tier>,
        content_prices: 0x2::table::Table<vector<u8>, u64>,
        min_tip: u64,
        accepting: bool,
        earnings: 0x2::balance::Balance<T0>,
        platform_fees: 0x2::balance::Balance<T0>,
        gross_volume: u64,
        subscriptions_sold: u64,
        unlocks_sold: u64,
        tips_received: u64,
    }

    struct VaultOpened has copy, drop {
        vault: 0x2::object::ID,
        platform: 0x2::object::ID,
        owner: address,
        account: 0x2::object::ID,
        fee_bps_snapshot: u64,
        referral_share_bps_snapshot: u64,
    }

    struct PaymentSettled has copy, drop {
        vault: 0x2::object::ID,
        payer: address,
        kind: u8,
        gross: u64,
        creator_net: u64,
        platform_net: u64,
        referral_cut: u64,
        referrer: 0x1::option::Option<address>,
    }

    struct TiersUpdated has copy, drop {
        vault: 0x2::object::ID,
        tier_count: u64,
    }

    struct ContentPriced has copy, drop {
        vault: 0x2::object::ID,
        content_key: vector<u8>,
        price: u64,
    }

    struct ContentUnpriced has copy, drop {
        vault: 0x2::object::ID,
        content_key: vector<u8>,
    }

    struct EarningsClaimed has copy, drop {
        vault: 0x2::object::ID,
        amount: u64,
        recipient: address,
    }

    struct PlatformFeesClaimed has copy, drop {
        vault: 0x2::object::ID,
        amount: u64,
        recipient: address,
    }

    struct TermsAccepted has copy, drop {
        vault: 0x2::object::ID,
        previous_fee_bps: u64,
        fee_bps: u64,
        previous_referral_share_bps: u64,
        referral_share_bps: u64,
    }

    struct AcceptingSet has copy, drop {
        vault: 0x2::object::ID,
        accepting: bool,
    }

    public fun accept_current_terms<T0>(arg0: &mut CreatorVault<T0>, arg1: &CreatorCap, arg2: &0xc5c833991ed1123d70b1001c0bcdb01ec5728b09f25dfc42a0edaf16005d404d::platform::Platform) {
        assert_version<T0>(arg0);
        assert_cap<T0>(arg0, arg1);
        assert!(arg0.platform == 0x2::object::id<0xc5c833991ed1123d70b1001c0bcdb01ec5728b09f25dfc42a0edaf16005d404d::platform::Platform>(arg2), 3);
        arg0.fee_bps_snapshot = 0xc5c833991ed1123d70b1001c0bcdb01ec5728b09f25dfc42a0edaf16005d404d::platform::fee_bps(arg2);
        arg0.referral_share_bps_snapshot = 0xc5c833991ed1123d70b1001c0bcdb01ec5728b09f25dfc42a0edaf16005d404d::platform::referral_share_bps(arg2);
        let v0 = TermsAccepted{
            vault                       : 0x2::object::id<CreatorVault<T0>>(arg0),
            previous_fee_bps            : arg0.fee_bps_snapshot,
            fee_bps                     : arg0.fee_bps_snapshot,
            previous_referral_share_bps : arg0.referral_share_bps_snapshot,
            referral_share_bps          : arg0.referral_share_bps_snapshot,
        };
        0x2::event::emit<TermsAccepted>(v0);
    }

    public fun accepting<T0>(arg0: &CreatorVault<T0>) : bool {
        arg0.accepting
    }

    public fun account_id<T0>(arg0: &CreatorVault<T0>) : 0x2::object::ID {
        arg0.account
    }

    public fun add_tier<T0>(arg0: &mut CreatorVault<T0>, arg1: &CreatorCap, arg2: 0x1::string::String, arg3: u64, arg4: u64) {
        assert_version<T0>(arg0);
        assert_cap<T0>(arg0, arg1);
        assert!(0x1::vector::length<Tier>(&arg0.tiers) < 16, 8);
        assert!(0x1::vector::length<u8>(0x1::string::as_bytes(&arg2)) > 0, 16);
        assert!(arg3 > 0, 10);
        assert!(arg4 >= 2592000000 && arg4 <= 315360000000, 9);
        assert!(arg4 % 0xc5c833991ed1123d70b1001c0bcdb01ec5728b09f25dfc42a0edaf16005d404d::entitlement::seal_period_ms() == 0, 18);
        let v0 = Tier{
            name      : arg2,
            price     : arg3,
            period_ms : arg4,
            active    : true,
        };
        0x1::vector::push_back<Tier>(&mut arg0.tiers, v0);
        let v1 = TiersUpdated{
            vault      : 0x2::object::id<CreatorVault<T0>>(arg0),
            tier_count : 0x1::vector::length<Tier>(&arg0.tiers),
        };
        0x2::event::emit<TiersUpdated>(v1);
    }

    fun assert_cap<T0>(arg0: &CreatorVault<T0>, arg1: &CreatorCap) {
        assert!(arg1.vault == 0x2::object::id<CreatorVault<T0>>(arg0), 2);
    }

    fun assert_payable<T0>(arg0: &0xc5c833991ed1123d70b1001c0bcdb01ec5728b09f25dfc42a0edaf16005d404d::platform::Platform, arg1: &CreatorVault<T0>, arg2: &0xc5c833991ed1123d70b1001c0bcdb01ec5728b09f25dfc42a0edaf16005d404d::account::SocialAccount, arg3: &0x2::tx_context::TxContext) : address {
        assert_version<T0>(arg1);
        0xc5c833991ed1123d70b1001c0bcdb01ec5728b09f25dfc42a0edaf16005d404d::platform::assert_can_pay(arg0);
        assert!(arg1.platform == 0x2::object::id<0xc5c833991ed1123d70b1001c0bcdb01ec5728b09f25dfc42a0edaf16005d404d::platform::Platform>(arg0), 3);
        assert!(arg1.accepting, 4);
        let v0 = 0x2::tx_context::sender(arg3);
        0xc5c833991ed1123d70b1001c0bcdb01ec5728b09f25dfc42a0edaf16005d404d::account::assert_authenticates(arg2, v0, arg1.platform);
        assert!(v0 != arg1.owner, 13);
        v0
    }

    fun assert_version<T0>(arg0: &CreatorVault<T0>) {
        assert!(arg0.version == 1, 1);
    }

    public fun bps_denominator() : u64 {
        10000
    }

    public fun cap_vault_id(arg0: &CreatorCap) : 0x2::object::ID {
        arg0.vault
    }

    public fun claim_earnings<T0>(arg0: &mut CreatorVault<T0>, arg1: &CreatorCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_version<T0>(arg0);
        assert_cap<T0>(arg0, arg1);
        assert!(0x2::balance::value<T0>(&arg0.earnings) >= arg2, 14);
        let v0 = EarningsClaimed{
            vault     : 0x2::object::id<CreatorVault<T0>>(arg0),
            amount    : arg2,
            recipient : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<EarningsClaimed>(v0);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.earnings, arg2), arg3)
    }

    public fun claim_platform_fees<T0>(arg0: &mut CreatorVault<T0>, arg1: &0xc5c833991ed1123d70b1001c0bcdb01ec5728b09f25dfc42a0edaf16005d404d::platform::PlatformCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_version<T0>(arg0);
        assert!(0xc5c833991ed1123d70b1001c0bcdb01ec5728b09f25dfc42a0edaf16005d404d::platform::cap_platform_id(arg1) == arg0.platform, 3);
        assert!(0x2::balance::value<T0>(&arg0.platform_fees) >= arg2, 14);
        let v0 = PlatformFeesClaimed{
            vault     : 0x2::object::id<CreatorVault<T0>>(arg0),
            amount    : arg2,
            recipient : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<PlatformFeesClaimed>(v0);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.platform_fees, arg2), arg3)
    }

    public fun compute_split(arg0: u64, arg1: u64, arg2: u64, arg3: bool) : (u64, u64, u64) {
        let v0 = (((arg0 as u128) * (arg1 as u128) / (10000 as u128)) as u64);
        let v1 = if (arg3) {
            (((v0 as u128) * (arg2 as u128) / (10000 as u128)) as u64)
        } else {
            0
        };
        (arg0 - v0, v0 - v1, v1)
    }

    public fun content_price<T0>(arg0: &CreatorVault<T0>, arg1: vector<u8>) : u64 {
        assert!(0x2::table::contains<vector<u8>, u64>(&arg0.content_prices, arg1), 12);
        *0x2::table::borrow<vector<u8>, u64>(&arg0.content_prices, arg1)
    }

    public fun earnings_value<T0>(arg0: &CreatorVault<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.earnings)
    }

    public fun fee_bps_snapshot<T0>(arg0: &CreatorVault<T0>) : u64 {
        arg0.fee_bps_snapshot
    }

    public fun gross_volume<T0>(arg0: &CreatorVault<T0>) : u64 {
        arg0.gross_volume
    }

    public fun is_for_sale<T0>(arg0: &CreatorVault<T0>, arg1: vector<u8>) : bool {
        0x2::table::contains<vector<u8>, u64>(&arg0.content_prices, arg1)
    }

    public fun kind_renewal() : u8 {
        2
    }

    public fun kind_subscription() : u8 {
        1
    }

    public fun kind_tip() : u8 {
        3
    }

    public fun kind_unlock() : u8 {
        4
    }

    public fun max_period_ms() : u64 {
        315360000000
    }

    public fun max_tiers() : u64 {
        16
    }

    public fun migrate<T0>(arg0: &mut CreatorVault<T0>, arg1: &CreatorCap) {
        assert_cap<T0>(arg0, arg1);
        assert!(arg0.version < 1, 17);
        arg0.version = 1;
    }

    public fun min_period_ms() : u64 {
        2592000000
    }

    public fun min_tip<T0>(arg0: &CreatorVault<T0>) : u64 {
        arg0.min_tip
    }

    public fun open_vault<T0>(arg0: &mut 0xc5c833991ed1123d70b1001c0bcdb01ec5728b09f25dfc42a0edaf16005d404d::platform::Platform, arg1: &0xc5c833991ed1123d70b1001c0bcdb01ec5728b09f25dfc42a0edaf16005d404d::account::SocialAccount, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) : (CreatorCap, 0x2::coin::Coin<0x2::sui::SUI>) {
        0xc5c833991ed1123d70b1001c0bcdb01ec5728b09f25dfc42a0edaf16005d404d::platform::assert_can_create(arg0);
        let v0 = 0x2::object::id<0xc5c833991ed1123d70b1001c0bcdb01ec5728b09f25dfc42a0edaf16005d404d::platform::Platform>(arg0);
        let v1 = 0x2::tx_context::sender(arg3);
        0xc5c833991ed1123d70b1001c0bcdb01ec5728b09f25dfc42a0edaf16005d404d::account::assert_authenticates(arg1, v1, v0);
        let v2 = CreatorVault<T0>{
            id                          : 0x2::object::new(arg3),
            version                     : 1,
            platform                    : v0,
            owner                       : v1,
            account                     : 0x2::object::id<0xc5c833991ed1123d70b1001c0bcdb01ec5728b09f25dfc42a0edaf16005d404d::account::SocialAccount>(arg1),
            fee_bps_snapshot            : 0xc5c833991ed1123d70b1001c0bcdb01ec5728b09f25dfc42a0edaf16005d404d::platform::fee_bps(arg0),
            referral_share_bps_snapshot : 0xc5c833991ed1123d70b1001c0bcdb01ec5728b09f25dfc42a0edaf16005d404d::platform::referral_share_bps(arg0),
            tiers                       : 0x1::vector::empty<Tier>(),
            content_prices              : 0x2::table::new<vector<u8>, u64>(arg3),
            min_tip                     : 1,
            accepting                   : true,
            earnings                    : 0x2::balance::zero<T0>(),
            platform_fees               : 0x2::balance::zero<T0>(),
            gross_volume                : 0,
            subscriptions_sold          : 0,
            unlocks_sold                : 0,
            tips_received               : 0,
        };
        let v3 = 0x2::object::id<CreatorVault<T0>>(&v2);
        let v4 = VaultOpened{
            vault                       : v3,
            platform                    : v0,
            owner                       : v1,
            account                     : 0x2::object::id<0xc5c833991ed1123d70b1001c0bcdb01ec5728b09f25dfc42a0edaf16005d404d::account::SocialAccount>(arg1),
            fee_bps_snapshot            : v2.fee_bps_snapshot,
            referral_share_bps_snapshot : v2.referral_share_bps_snapshot,
        };
        0x2::event::emit<VaultOpened>(v4);
        0xc5c833991ed1123d70b1001c0bcdb01ec5728b09f25dfc42a0edaf16005d404d::platform::record_vault_created(arg0);
        0x2::transfer::share_object<CreatorVault<T0>>(v2);
        let v5 = CreatorCap{
            id    : 0x2::object::new(arg3),
            vault : v3,
        };
        (v5, 0xc5c833991ed1123d70b1001c0bcdb01ec5728b09f25dfc42a0edaf16005d404d::platform::collect_creation_fee(arg0, arg2, arg3))
    }

    public fun owner<T0>(arg0: &CreatorVault<T0>) : address {
        arg0.owner
    }

    public fun platform_fees_value<T0>(arg0: &CreatorVault<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.platform_fees)
    }

    public fun referral_share_bps_snapshot<T0>(arg0: &CreatorVault<T0>) : u64 {
        arg0.referral_share_bps_snapshot
    }

    public fun renew<T0>(arg0: &0xc5c833991ed1123d70b1001c0bcdb01ec5728b09f25dfc42a0edaf16005d404d::platform::Platform, arg1: &mut CreatorVault<T0>, arg2: &0xc5c833991ed1123d70b1001c0bcdb01ec5728b09f25dfc42a0edaf16005d404d::account::SocialAccount, arg3: &mut 0xc5c833991ed1123d70b1001c0bcdb01ec5728b09f25dfc42a0edaf16005d404d::entitlement::Subscription, arg4: 0x2::coin::Coin<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = assert_payable<T0>(arg0, arg1, arg2, arg6);
        assert!(0xc5c833991ed1123d70b1001c0bcdb01ec5728b09f25dfc42a0edaf16005d404d::entitlement::subscription_vault(arg3) == 0x2::object::id<CreatorVault<T0>>(arg1), 15);
        assert!(0xc5c833991ed1123d70b1001c0bcdb01ec5728b09f25dfc42a0edaf16005d404d::entitlement::subscriber(arg3) == v0, 15);
        let v1 = 0xc5c833991ed1123d70b1001c0bcdb01ec5728b09f25dfc42a0edaf16005d404d::entitlement::tier(arg3);
        assert!(v1 < 0x1::vector::length<Tier>(&arg1.tiers), 6);
        let v2 = *0x1::vector::borrow<Tier>(&arg1.tiers, v1);
        assert!(v2.active, 7);
        let v3 = &mut arg4;
        let v4 = take_price<T0>(v3, v2.price, arg6);
        settle<T0>(arg1, v4, v0, 0xc5c833991ed1123d70b1001c0bcdb01ec5728b09f25dfc42a0edaf16005d404d::account::referrer(arg2), 2, arg6);
        0xc5c833991ed1123d70b1001c0bcdb01ec5728b09f25dfc42a0edaf16005d404d::entitlement::extend(arg3, v2.price, v2.period_ms, arg5);
        arg4
    }

    public fun set_accepting<T0>(arg0: &mut CreatorVault<T0>, arg1: &CreatorCap, arg2: bool) {
        assert_version<T0>(arg0);
        assert_cap<T0>(arg0, arg1);
        arg0.accepting = arg2;
        let v0 = AcceptingSet{
            vault     : 0x2::object::id<CreatorVault<T0>>(arg0),
            accepting : arg2,
        };
        0x2::event::emit<AcceptingSet>(v0);
    }

    public fun set_content_price<T0>(arg0: &mut CreatorVault<T0>, arg1: &CreatorCap, arg2: vector<u8>, arg3: u64) {
        assert_version<T0>(arg0);
        assert_cap<T0>(arg0, arg1);
        assert!(0x1::vector::length<u8>(&arg2) > 0, 16);
        assert!(arg3 > 0, 10);
        if (0x2::table::contains<vector<u8>, u64>(&arg0.content_prices, arg2)) {
            *0x2::table::borrow_mut<vector<u8>, u64>(&mut arg0.content_prices, arg2) = arg3;
        } else {
            0x2::table::add<vector<u8>, u64>(&mut arg0.content_prices, arg2, arg3);
        };
        let v0 = ContentPriced{
            vault       : 0x2::object::id<CreatorVault<T0>>(arg0),
            content_key : arg2,
            price       : arg3,
        };
        0x2::event::emit<ContentPriced>(v0);
    }

    public fun set_min_tip<T0>(arg0: &mut CreatorVault<T0>, arg1: &CreatorCap, arg2: u64) {
        assert_version<T0>(arg0);
        assert_cap<T0>(arg0, arg1);
        assert!(arg2 > 0, 10);
        arg0.min_tip = arg2;
    }

    fun settle<T0>(arg0: &mut CreatorVault<T0>, arg1: 0x2::coin::Coin<T0>, arg2: address, arg3: 0x1::option::Option<address>, arg4: u8, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        let (v1, v2, v3) = compute_split(v0, arg0.fee_bps_snapshot, arg0.referral_share_bps_snapshot, 0x1::option::is_some<address>(&arg3));
        let v4 = 0x2::coin::into_balance<T0>(arg1);
        if (v3 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v4, v3), arg5), *0x1::option::borrow<address>(&arg3));
        };
        0x2::balance::join<T0>(&mut arg0.platform_fees, 0x2::balance::split<T0>(&mut v4, v2));
        0x2::balance::join<T0>(&mut arg0.earnings, v4);
        arg0.gross_volume = arg0.gross_volume + v0;
        let v5 = PaymentSettled{
            vault        : 0x2::object::id<CreatorVault<T0>>(arg0),
            payer        : arg2,
            kind         : arg4,
            gross        : v0,
            creator_net  : v1,
            platform_net : v2,
            referral_cut : v3,
            referrer     : arg3,
        };
        0x2::event::emit<PaymentSettled>(v5);
    }

    public fun subscribe<T0>(arg0: &0xc5c833991ed1123d70b1001c0bcdb01ec5728b09f25dfc42a0edaf16005d404d::platform::Platform, arg1: &mut CreatorVault<T0>, arg2: &0xc5c833991ed1123d70b1001c0bcdb01ec5728b09f25dfc42a0edaf16005d404d::account::SocialAccount, arg3: u64, arg4: 0x2::coin::Coin<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = assert_payable<T0>(arg0, arg1, arg2, arg6);
        assert!(arg3 < 0x1::vector::length<Tier>(&arg1.tiers), 6);
        let v1 = *0x1::vector::borrow<Tier>(&arg1.tiers, arg3);
        assert!(v1.active, 7);
        let v2 = &mut arg4;
        let v3 = take_price<T0>(v2, v1.price, arg6);
        settle<T0>(arg1, v3, v0, 0xc5c833991ed1123d70b1001c0bcdb01ec5728b09f25dfc42a0edaf16005d404d::account::referrer(arg2), 1, arg6);
        arg1.subscriptions_sold = arg1.subscriptions_sold + 1;
        0xc5c833991ed1123d70b1001c0bcdb01ec5728b09f25dfc42a0edaf16005d404d::entitlement::new_subscription(0x2::object::id<CreatorVault<T0>>(arg1), v0, arg3, v1.price, v1.period_ms, arg5, arg6);
        arg4
    }

    public fun subscriptions_sold<T0>(arg0: &CreatorVault<T0>) : u64 {
        arg0.subscriptions_sold
    }

    fun take_price<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::coin::value<T0>(arg0) >= arg1, 5);
        0x2::coin::split<T0>(arg0, arg1, arg2)
    }

    public fun tier_active<T0>(arg0: &CreatorVault<T0>, arg1: u64) : bool {
        assert!(arg1 < 0x1::vector::length<Tier>(&arg0.tiers), 6);
        0x1::vector::borrow<Tier>(&arg0.tiers, arg1).active
    }

    public fun tier_count<T0>(arg0: &CreatorVault<T0>) : u64 {
        0x1::vector::length<Tier>(&arg0.tiers)
    }

    public fun tier_name<T0>(arg0: &CreatorVault<T0>, arg1: u64) : &0x1::string::String {
        assert!(arg1 < 0x1::vector::length<Tier>(&arg0.tiers), 6);
        &0x1::vector::borrow<Tier>(&arg0.tiers, arg1).name
    }

    public fun tier_period_ms<T0>(arg0: &CreatorVault<T0>, arg1: u64) : u64 {
        assert!(arg1 < 0x1::vector::length<Tier>(&arg0.tiers), 6);
        0x1::vector::borrow<Tier>(&arg0.tiers, arg1).period_ms
    }

    public fun tier_price<T0>(arg0: &CreatorVault<T0>, arg1: u64) : u64 {
        assert!(arg1 < 0x1::vector::length<Tier>(&arg0.tiers), 6);
        0x1::vector::borrow<Tier>(&arg0.tiers, arg1).price
    }

    public fun tip<T0>(arg0: &0xc5c833991ed1123d70b1001c0bcdb01ec5728b09f25dfc42a0edaf16005d404d::platform::Platform, arg1: &mut CreatorVault<T0>, arg2: &0xc5c833991ed1123d70b1001c0bcdb01ec5728b09f25dfc42a0edaf16005d404d::account::SocialAccount, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = assert_payable<T0>(arg0, arg1, arg2, arg4);
        assert!(0x2::coin::value<T0>(&arg3) >= arg1.min_tip, 11);
        settle<T0>(arg1, arg3, v0, 0xc5c833991ed1123d70b1001c0bcdb01ec5728b09f25dfc42a0edaf16005d404d::account::referrer(arg2), 3, arg4);
        arg1.tips_received = arg1.tips_received + 1;
    }

    public fun tips_received<T0>(arg0: &CreatorVault<T0>) : u64 {
        arg0.tips_received
    }

    public fun unlock<T0>(arg0: &0xc5c833991ed1123d70b1001c0bcdb01ec5728b09f25dfc42a0edaf16005d404d::platform::Platform, arg1: &mut CreatorVault<T0>, arg2: &0xc5c833991ed1123d70b1001c0bcdb01ec5728b09f25dfc42a0edaf16005d404d::account::SocialAccount, arg3: vector<u8>, arg4: 0x2::coin::Coin<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = assert_payable<T0>(arg0, arg1, arg2, arg6);
        assert!(0x2::table::contains<vector<u8>, u64>(&arg1.content_prices, arg3), 12);
        let v1 = *0x2::table::borrow<vector<u8>, u64>(&arg1.content_prices, arg3);
        let v2 = &mut arg4;
        let v3 = take_price<T0>(v2, v1, arg6);
        settle<T0>(arg1, v3, v0, 0xc5c833991ed1123d70b1001c0bcdb01ec5728b09f25dfc42a0edaf16005d404d::account::referrer(arg2), 4, arg6);
        arg1.unlocks_sold = arg1.unlocks_sold + 1;
        0xc5c833991ed1123d70b1001c0bcdb01ec5728b09f25dfc42a0edaf16005d404d::entitlement::new_unlock(0x2::object::id<CreatorVault<T0>>(arg1), v0, arg3, v1, arg5, arg6);
        arg4
    }

    public fun unlocks_sold<T0>(arg0: &CreatorVault<T0>) : u64 {
        arg0.unlocks_sold
    }

    public fun unprice_content<T0>(arg0: &mut CreatorVault<T0>, arg1: &CreatorCap, arg2: vector<u8>) {
        assert_version<T0>(arg0);
        assert_cap<T0>(arg0, arg1);
        assert!(0x2::table::contains<vector<u8>, u64>(&arg0.content_prices, arg2), 12);
        0x2::table::remove<vector<u8>, u64>(&mut arg0.content_prices, arg2);
        let v0 = ContentUnpriced{
            vault       : 0x2::object::id<CreatorVault<T0>>(arg0),
            content_key : arg2,
        };
        0x2::event::emit<ContentUnpriced>(v0);
    }

    public fun update_tier<T0>(arg0: &mut CreatorVault<T0>, arg1: &CreatorCap, arg2: u64, arg3: u64, arg4: u64, arg5: bool) {
        assert_version<T0>(arg0);
        assert_cap<T0>(arg0, arg1);
        assert!(arg2 < 0x1::vector::length<Tier>(&arg0.tiers), 6);
        assert!(arg3 > 0, 10);
        assert!(arg4 >= 2592000000 && arg4 <= 315360000000, 9);
        assert!(arg4 % 0xc5c833991ed1123d70b1001c0bcdb01ec5728b09f25dfc42a0edaf16005d404d::entitlement::seal_period_ms() == 0, 18);
        let v0 = 0x1::vector::borrow_mut<Tier>(&mut arg0.tiers, arg2);
        v0.price = arg3;
        v0.period_ms = arg4;
        v0.active = arg5;
        let v1 = TiersUpdated{
            vault      : 0x2::object::id<CreatorVault<T0>>(arg0),
            tier_count : 0x1::vector::length<Tier>(&arg0.tiers),
        };
        0x2::event::emit<TiersUpdated>(v1);
    }

    public fun vault_platform_id<T0>(arg0: &CreatorVault<T0>) : 0x2::object::ID {
        arg0.platform
    }

    public fun version<T0>(arg0: &CreatorVault<T0>) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v7
}

