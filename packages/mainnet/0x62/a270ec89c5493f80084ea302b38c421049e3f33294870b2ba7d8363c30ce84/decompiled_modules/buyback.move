module 0x62a270ec89c5493f80084ea302b38c421049e3f33294870b2ba7d8363c30ce84::buyback {
    struct BuybackMarketplace<phantom T0> has key {
        id: 0x2::object::UID,
        platform_fee_bps: u64,
        fee_recipient: address,
        fee_balance: 0x2::balance::Balance<T0>,
        market_prices: 0x2::table::Table<0x1::string::String, u64>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct ProviderAccount<phantom T0> has key {
        id: 0x2::object::UID,
        owner: address,
        name: 0x1::string::String,
        escrow: 0x2::balance::Balance<T0>,
        offer_configs: 0x2::table::Table<0x1::string::String, OfferConfig>,
        is_active: bool,
    }

    struct OfferConfig has drop, store {
        adjustment_bps: u64,
        is_negative: bool,
        max_quantity: u64,
        remaining_quantity: u64,
        is_active: bool,
    }

    struct HeldPayment<phantom T0> has key {
        id: 0x2::object::UID,
        seller: address,
        amount: 0x2::balance::Balance<T0>,
        fee_amount: 0x2::balance::Balance<T0>,
        release_timestamp: u64,
        card_template_id: 0x1::string::String,
        provider_id: 0x2::object::ID,
    }

    struct MarketPriceSet has copy, drop {
        card_template_id: 0x1::string::String,
        price: u64,
    }

    struct ProviderRegistered has copy, drop {
        provider_id: 0x2::object::ID,
        owner: address,
        name: 0x1::string::String,
    }

    struct ProviderUpdated has copy, drop {
        provider_id: 0x2::object::ID,
        is_active: bool,
    }

    struct ProviderOwnerChanged has copy, drop {
        provider_id: 0x2::object::ID,
        old_owner: address,
        new_owner: address,
    }

    struct UsdcDeposited has copy, drop {
        provider_id: 0x2::object::ID,
        amount: u64,
    }

    struct UsdcWithdrawn has copy, drop {
        provider_id: 0x2::object::ID,
        amount: u64,
    }

    struct OfferConfigSet has copy, drop {
        provider_id: 0x2::object::ID,
        card_template_id: 0x1::string::String,
        adjustment_bps: u64,
        is_negative: bool,
        max_quantity: u64,
    }

    struct BuybackExecuted has copy, drop {
        provider_id: 0x2::object::ID,
        card_template_id: 0x1::string::String,
        seller: address,
        offer_price: u64,
        platform_fee: u64,
        seller_received: u64,
    }

    struct BuybackHeld has copy, drop {
        held_payment_id: 0x2::object::ID,
        provider_id: 0x2::object::ID,
        card_template_id: 0x1::string::String,
        seller: address,
        amount: u64,
        release_timestamp: u64,
    }

    struct HeldPaymentReleased has copy, drop {
        held_payment_id: 0x2::object::ID,
        seller: address,
        amount: u64,
    }

    struct HeldPaymentCancelled has copy, drop {
        held_payment_id: 0x2::object::ID,
        provider_id: 0x2::object::ID,
        refund_amount: u64,
    }

    struct FeesWithdrawn has copy, drop {
        amount: u64,
        recipient: address,
    }

    public entry fun admin_change_provider_owner<T0>(arg0: &AdminCap, arg1: &mut ProviderAccount<T0>, arg2: address) {
        arg1.owner = arg2;
        let v0 = ProviderOwnerChanged{
            provider_id : 0x2::object::id<ProviderAccount<T0>>(arg1),
            old_owner   : arg1.owner,
            new_owner   : arg2,
        };
        0x2::event::emit<ProviderOwnerChanged>(v0);
    }

    public entry fun admin_set_provider_active<T0>(arg0: &AdminCap, arg1: &mut ProviderAccount<T0>, arg2: bool) {
        arg1.is_active = arg2;
        let v0 = ProviderUpdated{
            provider_id : 0x2::object::id<ProviderAccount<T0>>(arg1),
            is_active   : arg2,
        };
        0x2::event::emit<ProviderUpdated>(v0);
    }

    public entry fun admin_update_provider_name<T0>(arg0: &AdminCap, arg1: &mut ProviderAccount<T0>, arg2: 0x1::string::String) {
        arg1.name = arg2;
    }

    fun calculate_prices<T0>(arg0: &BuybackMarketplace<T0>, arg1: &ProviderAccount<T0>, arg2: &0x1::string::String) : (u64, u64, u64) {
        assert!(0x2::table::contains<0x1::string::String, u64>(&arg0.market_prices, *arg2), 1);
        assert!(0x2::table::contains<0x1::string::String, OfferConfig>(&arg1.offer_configs, *arg2), 2);
        let v0 = 0x2::table::borrow<0x1::string::String, OfferConfig>(&arg1.offer_configs, *arg2);
        assert!(v0.is_active, 3);
        let v1 = if (v0.is_negative) {
            *0x2::table::borrow<0x1::string::String, u64>(&arg0.market_prices, *arg2) * (10000 - v0.adjustment_bps) / 10000
        } else {
            *0x2::table::borrow<0x1::string::String, u64>(&arg0.market_prices, *arg2) * (10000 + v0.adjustment_bps) / 10000
        };
        let v2 = v1 * arg0.platform_fee_bps / 10000;
        (v1, v2, v1 - v2)
    }

    public entry fun cancel_held_payment<T0>(arg0: &AdminCap, arg1: &mut ProviderAccount<T0>, arg2: HeldPayment<T0>) {
        let HeldPayment {
            id                : v0,
            seller            : _,
            amount            : v2,
            fee_amount        : v3,
            release_timestamp : _,
            card_template_id  : _,
            provider_id       : v6,
        } = arg2;
        let v7 = v3;
        let v8 = v2;
        let v9 = v0;
        assert!(0x2::object::id<ProviderAccount<T0>>(arg1) == v6, 0);
        0x2::balance::join<T0>(&mut arg1.escrow, v8);
        0x2::balance::join<T0>(&mut arg1.escrow, v7);
        let v10 = HeldPaymentCancelled{
            held_payment_id : 0x2::object::uid_to_inner(&v9),
            provider_id     : v6,
            refund_amount   : 0x2::balance::value<T0>(&v8) + 0x2::balance::value<T0>(&v7),
        };
        0x2::event::emit<HeldPaymentCancelled>(v10);
        0x2::object::delete(v9);
    }

    public entry fun create_marketplace<T0>(arg0: &AdminCap, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 <= 10000, 7);
        let v0 = BuybackMarketplace<T0>{
            id               : 0x2::object::new(arg3),
            platform_fee_bps : arg1,
            fee_recipient    : arg2,
            fee_balance      : 0x2::balance::zero<T0>(),
            market_prices    : 0x2::table::new<0x1::string::String, u64>(arg3),
        };
        0x2::transfer::share_object<BuybackMarketplace<T0>>(v0);
    }

    public entry fun deactivate_offer<T0>(arg0: &mut ProviderAccount<T0>, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 0);
        assert!(0x2::table::contains<0x1::string::String, OfferConfig>(&arg0.offer_configs, arg1), 2);
        0x2::table::borrow_mut<0x1::string::String, OfferConfig>(&mut arg0.offer_configs, arg1).is_active = false;
    }

    public entry fun deposit_usdc<T0>(arg0: &mut ProviderAccount<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 0);
        0x2::balance::join<T0>(&mut arg0.escrow, 0x2::coin::into_balance<T0>(arg1));
        let v0 = UsdcDeposited{
            provider_id : 0x2::object::id<ProviderAccount<T0>>(arg0),
            amount      : 0x2::coin::value<T0>(&arg1),
        };
        0x2::event::emit<UsdcDeposited>(v0);
    }

    public entry fun execute_buyback<T0, T1: store + key>(arg0: &mut BuybackMarketplace<T0>, arg1: &mut ProviderAccount<T0>, arg2: T1, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        abort 19
    }

    public entry fun execute_buyback_v2<T0, T1: store + key>(arg0: &mut BuybackMarketplace<T0>, arg1: &mut ProviderAccount<T0>, arg2: T1, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: u64, arg6: u64, arg7: vector<u8>, arg8: u64, arg9: vector<u8>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        verify_and_consume_auth<T0>(arg0, 0x2::object::id<ProviderAccount<T0>>(arg1), 0x2::object::id<T1>(&arg2), &arg3, 0x2::tx_context::sender(arg11), arg5, arg6, arg7, arg8, arg4, arg9, arg10);
        assert!(arg5 == 0, 17);
        execute_buyback_v2_body<T0, T1>(arg0, arg1, arg2, arg3, arg6, arg11);
    }

    fun execute_buyback_v2_body<T0, T1: store + key>(arg0: &mut BuybackMarketplace<T0>, arg1: &mut ProviderAccount<T0>, arg2: T1, arg3: 0x1::string::String, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.is_active, 8);
        let (v0, v1, v2) = calculate_prices<T0>(arg0, arg1, &arg3);
        assert!(v0 == arg4, 16);
        assert!(0x2::balance::value<T0>(&arg1.escrow) >= v0, 5);
        let v3 = 0x2::table::borrow_mut<0x1::string::String, OfferConfig>(&mut arg1.offer_configs, arg3);
        assert!(v3.remaining_quantity > 0, 4);
        v3.remaining_quantity = v3.remaining_quantity - 1;
        0x2::transfer::public_transfer<T1>(arg2, arg1.owner);
        0x2::balance::join<T0>(&mut arg0.fee_balance, 0x2::balance::split<T0>(&mut arg1.escrow, v1));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.escrow, v2), arg5), 0x2::tx_context::sender(arg5));
        let v4 = BuybackExecuted{
            provider_id      : 0x2::object::id<ProviderAccount<T0>>(arg1),
            card_template_id : arg3,
            seller           : 0x2::tx_context::sender(arg5),
            offer_price      : v0,
            platform_fee     : v1,
            seller_received  : v2,
        };
        0x2::event::emit<BuybackExecuted>(v4);
    }

    public entry fun execute_buyback_with_hold<T0, T1: store + key>(arg0: &mut BuybackMarketplace<T0>, arg1: &mut ProviderAccount<T0>, arg2: T1, arg3: 0x1::string::String, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        abort 19
    }

    public entry fun execute_buyback_with_hold_v2<T0, T1: store + key>(arg0: &mut BuybackMarketplace<T0>, arg1: &mut ProviderAccount<T0>, arg2: T1, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: u64, arg6: u64, arg7: vector<u8>, arg8: u64, arg9: vector<u8>, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        verify_and_consume_auth<T0>(arg0, 0x2::object::id<ProviderAccount<T0>>(arg1), 0x2::object::id<T1>(&arg2), &arg3, 0x2::tx_context::sender(arg12), arg5, arg6, arg7, arg8, arg4, arg9, arg11);
        assert!(arg5 > 0, 18);
        assert!(arg10 >= arg5, 6);
        execute_buyback_with_hold_v2_body<T0, T1>(arg0, arg1, arg2, arg3, arg10, arg6, arg12);
    }

    fun execute_buyback_with_hold_v2_body<T0, T1: store + key>(arg0: &BuybackMarketplace<T0>, arg1: &mut ProviderAccount<T0>, arg2: T1, arg3: 0x1::string::String, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.is_active, 8);
        let (v0, v1, v2) = calculate_prices<T0>(arg0, arg1, &arg3);
        assert!(v0 == arg5, 16);
        assert!(0x2::balance::value<T0>(&arg1.escrow) >= v0, 5);
        let v3 = 0x2::table::borrow_mut<0x1::string::String, OfferConfig>(&mut arg1.offer_configs, arg3);
        assert!(v3.remaining_quantity > 0, 4);
        v3.remaining_quantity = v3.remaining_quantity - 1;
        0x2::transfer::public_transfer<T1>(arg2, arg1.owner);
        let v4 = HeldPayment<T0>{
            id                : 0x2::object::new(arg6),
            seller            : 0x2::tx_context::sender(arg6),
            amount            : 0x2::balance::split<T0>(&mut arg1.escrow, v2),
            fee_amount        : 0x2::balance::split<T0>(&mut arg1.escrow, v1),
            release_timestamp : arg4,
            card_template_id  : arg3,
            provider_id       : 0x2::object::id<ProviderAccount<T0>>(arg1),
        };
        let v5 = BuybackHeld{
            held_payment_id   : 0x2::object::id<HeldPayment<T0>>(&v4),
            provider_id       : 0x2::object::id<ProviderAccount<T0>>(arg1),
            card_template_id  : v4.card_template_id,
            seller            : 0x2::tx_context::sender(arg6),
            amount            : v2,
            release_timestamp : arg4,
        };
        0x2::event::emit<BuybackHeld>(v5);
        0x2::transfer::share_object<HeldPayment<T0>>(v4);
    }

    public fun get_escrow_balance<T0>(arg0: &ProviderAccount<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.escrow)
    }

    public fun get_market_price<T0>(arg0: &BuybackMarketplace<T0>, arg1: &0x1::string::String) : u64 {
        assert!(0x2::table::contains<0x1::string::String, u64>(&arg0.market_prices, *arg1), 1);
        *0x2::table::borrow<0x1::string::String, u64>(&arg0.market_prices, *arg1)
    }

    public fun has_market_price<T0>(arg0: &BuybackMarketplace<T0>, arg1: &0x1::string::String) : bool {
        0x2::table::contains<0x1::string::String, u64>(&arg0.market_prices, *arg1)
    }

    public fun has_offer_config<T0>(arg0: &ProviderAccount<T0>, arg1: &0x1::string::String) : bool {
        0x2::table::contains<0x1::string::String, OfferConfig>(&arg0.offer_configs, *arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun init_admin_pubkey<T0>(arg0: &AdminCap, arg1: &mut BuybackMarketplace<T0>, arg2: vector<u8>, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!0x2::dynamic_field::exists_<vector<u8>>(&arg1.id, b"admin_pubkey"), 12);
        assert!(0x1::vector::length<u8>(&arg2) == 32, 21);
        0x2::dynamic_field::add<vector<u8>, vector<u8>>(&mut arg1.id, b"admin_pubkey", arg2);
        0x2::dynamic_field::add<vector<u8>, 0x1::string::String>(&mut arg1.id, b"chain_name", arg3);
        0x2::dynamic_field::add<vector<u8>, 0x2::table::Table<vector<u8>, bool>>(&mut arg1.id, b"used_nonces", 0x2::table::new<vector<u8>, bool>(arg4));
    }

    public entry fun register_provider<T0>(arg0: &AdminCap, arg1: 0x1::string::String, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = ProviderAccount<T0>{
            id            : 0x2::object::new(arg3),
            owner         : arg2,
            name          : arg1,
            escrow        : 0x2::balance::zero<T0>(),
            offer_configs : 0x2::table::new<0x1::string::String, OfferConfig>(arg3),
            is_active     : true,
        };
        let v1 = ProviderRegistered{
            provider_id : 0x2::object::id<ProviderAccount<T0>>(&v0),
            owner       : arg2,
            name        : v0.name,
        };
        0x2::event::emit<ProviderRegistered>(v1);
        0x2::transfer::share_object<ProviderAccount<T0>>(v0);
    }

    public entry fun release_held_payment<T0>(arg0: &mut BuybackMarketplace<T0>, arg1: HeldPayment<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg2) >= arg1.release_timestamp, 6);
        let HeldPayment {
            id                : v0,
            seller            : v1,
            amount            : v2,
            fee_amount        : v3,
            release_timestamp : _,
            card_template_id  : _,
            provider_id       : _,
        } = arg1;
        let v7 = v2;
        let v8 = v0;
        0x2::balance::join<T0>(&mut arg0.fee_balance, v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v7, arg3), v1);
        let v9 = HeldPaymentReleased{
            held_payment_id : 0x2::object::uid_to_inner(&v8),
            seller          : v1,
            amount          : 0x2::balance::value<T0>(&v7),
        };
        0x2::event::emit<HeldPaymentReleased>(v9);
        0x2::object::delete(v8);
    }

    public entry fun rotate_admin_pubkey<T0>(arg0: &AdminCap, arg1: &mut BuybackMarketplace<T0>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::dynamic_field::exists_<vector<u8>>(&arg1.id, b"admin_pubkey"), 11);
        assert!(0x1::vector::length<u8>(&arg2) == 32, 21);
        *0x2::dynamic_field::borrow_mut<vector<u8>, vector<u8>>(&mut arg1.id, b"admin_pubkey") = arg2;
    }

    public entry fun set_fee_recipient<T0>(arg0: &AdminCap, arg1: &mut BuybackMarketplace<T0>, arg2: address) {
        arg1.fee_recipient = arg2;
    }

    public entry fun set_market_price<T0>(arg0: &AdminCap, arg1: &mut BuybackMarketplace<T0>, arg2: 0x1::string::String, arg3: u64) {
        if (0x2::table::contains<0x1::string::String, u64>(&arg1.market_prices, arg2)) {
            *0x2::table::borrow_mut<0x1::string::String, u64>(&mut arg1.market_prices, arg2) = arg3;
        } else {
            0x2::table::add<0x1::string::String, u64>(&mut arg1.market_prices, arg2, arg3);
        };
        let v0 = MarketPriceSet{
            card_template_id : arg2,
            price            : arg3,
        };
        0x2::event::emit<MarketPriceSet>(v0);
    }

    public entry fun set_offer_config<T0>(arg0: &mut ProviderAccount<T0>, arg1: 0x1::string::String, arg2: u64, arg3: bool, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg5) == arg0.owner, 0);
        assert!(arg2 <= 5000, 9);
        let v0 = OfferConfig{
            adjustment_bps     : arg2,
            is_negative        : arg3,
            max_quantity       : arg4,
            remaining_quantity : arg4,
            is_active          : true,
        };
        if (0x2::table::contains<0x1::string::String, OfferConfig>(&arg0.offer_configs, arg1)) {
            *0x2::table::borrow_mut<0x1::string::String, OfferConfig>(&mut arg0.offer_configs, arg1) = v0;
        } else {
            0x2::table::add<0x1::string::String, OfferConfig>(&mut arg0.offer_configs, arg1, v0);
        };
        let v1 = OfferConfigSet{
            provider_id      : 0x2::object::id<ProviderAccount<T0>>(arg0),
            card_template_id : arg1,
            adjustment_bps   : arg2,
            is_negative      : arg3,
            max_quantity     : arg4,
        };
        0x2::event::emit<OfferConfigSet>(v1);
    }

    public entry fun set_platform_fee<T0>(arg0: &AdminCap, arg1: &mut BuybackMarketplace<T0>, arg2: u64) {
        assert!(arg2 <= 10000, 7);
        arg1.platform_fee_bps = arg2;
    }

    fun verify_and_consume_auth<T0>(arg0: &mut BuybackMarketplace<T0>, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: &0x1::string::String, arg4: address, arg5: u64, arg6: u64, arg7: vector<u8>, arg8: u64, arg9: 0x1::string::String, arg10: vector<u8>, arg11: &0x2::clock::Clock) {
        assert!(0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"admin_pubkey"), 11);
        assert!(*0x2::dynamic_field::borrow<vector<u8>, 0x1::string::String>(&arg0.id, b"chain_name") == arg9, 20);
        assert!(0x2::clock::timestamp_ms(arg11) < arg8, 15);
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, b"CARDIFY_BUYBACK_V1");
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x1::string::String>(&arg9));
        let v1 = 0x2::object::id<BuybackMarketplace<T0>>(arg0);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&v1));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&arg1));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&arg2));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x1::string::String>(arg3));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<address>(&arg4));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg5));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg6));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<vector<u8>>(&arg7));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg8));
        assert!(0x2::ed25519::ed25519_verify(&arg10, 0x2::dynamic_field::borrow<vector<u8>, vector<u8>>(&arg0.id, b"admin_pubkey"), &v0), 13);
        let v2 = 0x2::dynamic_field::borrow_mut<vector<u8>, 0x2::table::Table<vector<u8>, bool>>(&mut arg0.id, b"used_nonces");
        assert!(!0x2::table::contains<vector<u8>, bool>(v2, arg7), 14);
        0x2::table::add<vector<u8>, bool>(v2, arg7, true);
    }

    public entry fun withdraw_fees<T0>(arg0: &AdminCap, arg1: &mut BuybackMarketplace<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<T0>(&arg1.fee_balance);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.fee_balance, v0), arg2), arg1.fee_recipient);
            let v1 = FeesWithdrawn{
                amount    : v0,
                recipient : arg1.fee_recipient,
            };
            0x2::event::emit<FeesWithdrawn>(v1);
        };
    }

    public entry fun withdraw_usdc<T0>(arg0: &mut ProviderAccount<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.escrow, arg1), arg2), arg0.owner);
        let v0 = UsdcWithdrawn{
            provider_id : 0x2::object::id<ProviderAccount<T0>>(arg0),
            amount      : arg1,
        };
        0x2::event::emit<UsdcWithdrawn>(v0);
    }

    // decompiled from Move bytecode v7
}

