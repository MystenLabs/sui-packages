module 0x8bed44837212598c38e9b0c91d6443dc85af895f05a075ac7f70360e5f697e63::market {
    struct MARKET has drop {
        dummy_field: bool,
    }

    struct OtcMarket has key {
        id: 0x2::object::UID,
        version: u64,
        paused: bool,
        fee_bps: u16,
        fee_recipient: address,
        issued_pause_caps: 0x2::table::Table<0x2::object::ID, bool>,
        revoked_pause_caps: 0x2::table::Table<0x2::object::ID, bool>,
        revoked_pause_cap_count: u64,
    }

    struct OtcAdminCap has store, key {
        id: 0x2::object::UID,
        market_id: 0x2::object::ID,
    }

    struct OtcPauseCap has store, key {
        id: 0x2::object::UID,
        market_id: 0x2::object::ID,
    }

    struct PTListing has key {
        id: 0x2::object::UID,
        version: u64,
        otc_market_id: 0x2::object::ID,
        seller: address,
        pt_id: 0x2::object::ID,
        market_core_id: 0x2::object::ID,
        escrow_id: 0x2::object::ID,
        notional: u64,
        maturity_ms: u64,
        initial_index: u128,
        price_mist: u64,
        fee_bps_snapshot: u16,
        fee_recipient_snapshot: address,
        cleanup_bond: 0x1::option::Option<0x2::coin::Coin<0x2::sui::SUI>>,
        pt: 0x1::option::Option<0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::pt_object::PTObject>,
        is_active: bool,
    }

    struct YTListing has key {
        id: 0x2::object::UID,
        version: u64,
        otc_market_id: 0x2::object::ID,
        seller: address,
        yt_id: 0x2::object::ID,
        market_core_id: 0x2::object::ID,
        escrow_id: 0x2::object::ID,
        notional: u64,
        maturity_ms: u64,
        yield_debt: u128,
        price_mist: u64,
        fee_bps_snapshot: u16,
        fee_recipient_snapshot: address,
        cleanup_bond: 0x1::option::Option<0x2::coin::Coin<0x2::sui::SUI>>,
        yt: 0x1::option::Option<0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_object::YTObject>,
        is_active: bool,
    }

    struct VaultShareListing<phantom T0> has key {
        id: 0x2::object::UID,
        version: u64,
        otc_market_id: 0x2::object::ID,
        seller: address,
        share_id: 0x2::object::ID,
        vault_id: 0x2::object::ID,
        yt_id: 0x2::object::ID,
        shares: u64,
        entry_epoch: u64,
        maturity_ms: u64,
        price_mist: u64,
        fee_bps_snapshot: u16,
        fee_recipient_snapshot: address,
        cleanup_bond: 0x1::option::Option<0x2::coin::Coin<0x2::sui::SUI>>,
        share: 0x1::option::Option<0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_vault::VaultShare<T0>>,
        is_active: bool,
    }

    struct PTListed has copy, drop {
        otc_market_id: 0x2::object::ID,
        listing_id: 0x2::object::ID,
        seller: address,
        pt_id: 0x2::object::ID,
        market_core_id: 0x2::object::ID,
        escrow_id: 0x2::object::ID,
        notional: u64,
        maturity_ms: u64,
        initial_index: u128,
        price_mist: u64,
        fee_bps_snapshot: u16,
        fee_recipient_snapshot: address,
        cleanup_bond_mist: u64,
    }

    struct YTListed has copy, drop {
        otc_market_id: 0x2::object::ID,
        listing_id: 0x2::object::ID,
        seller: address,
        yt_id: 0x2::object::ID,
        market_core_id: 0x2::object::ID,
        escrow_id: 0x2::object::ID,
        notional: u64,
        maturity_ms: u64,
        yield_debt: u128,
        price_mist: u64,
        fee_bps_snapshot: u16,
        fee_recipient_snapshot: address,
        cleanup_bond_mist: u64,
    }

    struct VaultShareListed has copy, drop {
        otc_market_id: 0x2::object::ID,
        listing_id: 0x2::object::ID,
        seller: address,
        share_id: 0x2::object::ID,
        vault_id: 0x2::object::ID,
        yt_id: 0x2::object::ID,
        shares: u64,
        entry_epoch: u64,
        maturity_ms: u64,
        price_mist: u64,
        fee_bps_snapshot: u16,
        fee_recipient_snapshot: address,
        cleanup_bond_mist: u64,
    }

    struct ListingPurchased has copy, drop {
        listing_id: 0x2::object::ID,
        seller: address,
        buyer: address,
        asset_id: 0x2::object::ID,
        price_mist: u64,
        fee_mist: u64,
        fee_recipient: address,
        kind: u8,
    }

    struct ListingCancelled has copy, drop {
        listing_id: 0x2::object::ID,
        seller: address,
        asset_id: 0x2::object::ID,
        kind: u8,
    }

    struct OtcMarketPaused has copy, drop {
        market_id: 0x2::object::ID,
        paused_by: address,
        reason: vector<u8>,
    }

    struct OtcMarketUnpaused has copy, drop {
        market_id: 0x2::object::ID,
        unpaused_by: address,
    }

    struct OtcPauseCapRevoked has copy, drop {
        market_id: 0x2::object::ID,
        pause_cap_id: 0x2::object::ID,
        revoked_by: address,
    }

    struct OtcPauseCapIssued has copy, drop {
        market_id: 0x2::object::ID,
        pause_cap_id: 0x2::object::ID,
        issued_by: address,
        recipient: address,
    }

    struct OtcFeeBpsUpdated has copy, drop {
        market_id: 0x2::object::ID,
        old_fee_bps: u16,
        new_fee_bps: u16,
    }

    struct OtcFeeRecipientUpdated has copy, drop {
        market_id: 0x2::object::ID,
        old_fee_recipient: address,
        new_fee_recipient: address,
    }

    struct ListingFrozen has copy, drop {
        listing_id: 0x2::object::ID,
        seller: address,
        asset_id: 0x2::object::ID,
        frozen_by: address,
        kind: u8,
    }

    struct ListingPriceUpdated has copy, drop {
        listing_id: 0x2::object::ID,
        seller: address,
        old_price_mist: u64,
        new_price_mist: u64,
        kind: u8,
    }

    struct ListingDeleted has copy, drop {
        listing_id: 0x2::object::ID,
        seller: address,
        asset_id: 0x2::object::ID,
        deleted_by: address,
        kind: u8,
    }

    struct ListingExpired has copy, drop {
        listing_id: 0x2::object::ID,
        seller: address,
        asset_id: 0x2::object::ID,
        expired_by: address,
        kind: u8,
    }

    public fun admin_cap_id(arg0: &OtcAdminCap) : 0x2::object::ID {
        0x2::object::id<OtcAdminCap>(arg0)
    }

    public fun admin_cap_market_id(arg0: &OtcAdminCap) : 0x2::object::ID {
        arg0.market_id
    }

    public fun admin_freeze_pt_listing(arg0: &mut PTListing, arg1: &OtcAdminCap, arg2: 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::timelock::TimelockReceipt, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert_admin_cap_id(arg1, arg0.otc_market_id);
        assert_active(arg0.is_active);
        let v0 = 0x2::object::id<PTListing>(arg0);
        0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::timelock::consume_receipt_with_payload(arg2, 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::timelock::action_otc_freeze_listing(), v0, freeze_listing_payload_hash(0, v0), arg3);
        let v1 = take_pt(arg0);
        let v2 = &mut arg0.cleanup_bond;
        refund_cleanup_bond(v2, arg0.seller);
        arg0.is_active = false;
        0x2::transfer::public_transfer<0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::pt_object::PTObject>(v1, arg0.seller);
        emit_frozen(v0, arg0.seller, arg0.pt_id, 0x2::tx_context::sender(arg4), 0);
    }

    public fun admin_freeze_vault_share_listing<T0>(arg0: &mut VaultShareListing<T0>, arg1: &OtcAdminCap, arg2: 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::timelock::TimelockReceipt, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert_admin_cap_id(arg1, arg0.otc_market_id);
        assert_active(arg0.is_active);
        let v0 = 0x2::object::id<VaultShareListing<T0>>(arg0);
        0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::timelock::consume_receipt_with_payload(arg2, 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::timelock::action_otc_freeze_listing(), v0, freeze_listing_payload_hash(2, v0), arg3);
        let v1 = take_vault_share<T0>(arg0);
        let v2 = &mut arg0.cleanup_bond;
        refund_cleanup_bond(v2, arg0.seller);
        arg0.is_active = false;
        0x2::transfer::public_transfer<0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_vault::VaultShare<T0>>(v1, arg0.seller);
        emit_frozen(v0, arg0.seller, arg0.share_id, 0x2::tx_context::sender(arg4), 2);
    }

    public fun admin_freeze_yt_listing(arg0: &mut YTListing, arg1: &OtcAdminCap, arg2: 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::timelock::TimelockReceipt, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert_admin_cap_id(arg1, arg0.otc_market_id);
        assert_active(arg0.is_active);
        let v0 = 0x2::object::id<YTListing>(arg0);
        0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::timelock::consume_receipt_with_payload(arg2, 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::timelock::action_otc_freeze_listing(), v0, freeze_listing_payload_hash(1, v0), arg3);
        let v1 = take_yt(arg0);
        let v2 = &mut arg0.cleanup_bond;
        refund_cleanup_bond(v2, arg0.seller);
        arg0.is_active = false;
        0x2::transfer::public_transfer<0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_object::YTObject>(v1, arg0.seller);
        emit_frozen(v0, arg0.seller, arg0.yt_id, 0x2::tx_context::sender(arg4), 1);
    }

    fun assert_active(arg0: bool) {
        assert!(arg0, 2);
    }

    fun assert_admin_cap(arg0: &OtcMarket, arg1: &OtcAdminCap) {
        assert_admin_cap_id(arg1, 0x2::object::id<OtcMarket>(arg0));
    }

    fun assert_admin_cap_id(arg0: &OtcAdminCap, arg1: 0x2::object::ID) {
        assert!(arg0.market_id == arg1, 12);
    }

    fun assert_cleanup_bond(arg0: &0x2::coin::Coin<0x2::sui::SUI>) {
        assert!(0x2::coin::value<0x2::sui::SUI>(arg0) == 100000000, 10);
    }

    fun assert_listing_market_id(arg0: 0x2::object::ID, arg1: 0x2::object::ID) {
        assert!(arg0 == arg1, 12);
    }

    fun assert_market_open(arg0: &OtcMarket) {
        assert_market_version(arg0);
        assert!(!arg0.paused, 0);
    }

    fun assert_market_version(arg0: &OtcMarket) {
        assert!(arg0.version == 1, 9);
    }

    fun assert_pause_cap_live(arg0: &OtcMarket, arg1: &OtcPauseCap) {
        assert!(arg1.market_id == 0x2::object::id<OtcMarket>(arg0), 12);
        assert!(!0x2::table::contains<0x2::object::ID, bool>(&arg0.revoked_pause_caps, 0x2::object::id<OtcPauseCap>(arg1)), 13);
    }

    fun assert_pt_listing_version(arg0: &PTListing) {
        assert!(arg0.version == 1, 9);
    }

    fun assert_seller(arg0: address, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0, 4);
    }

    fun assert_valid_price(arg0: u64) {
        assert!(arg0 > 0, 1);
        assert!(arg0 <= 10000000000000000000, 1);
    }

    fun assert_vault_share_listing_version<T0>(arg0: &VaultShareListing<T0>) {
        assert!(arg0.version == 1, 9);
    }

    fun assert_yt_listing_version(arg0: &YTListing) {
        assert!(arg0.version == 1, 9);
    }

    public fun buy_pt(arg0: &OtcMarket, arg1: &mut PTListing, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_market_open(arg0);
        assert_listing_market_id(arg1.otc_market_id, 0x2::object::id<OtcMarket>(arg0));
        assert_pt_listing_version(arg1);
        assert_active(arg1.is_active);
        assert!(arg1.maturity_ms > 0x2::clock::timestamp_ms(arg3), 11);
        pay_exact(arg1.seller, arg1.fee_recipient_snapshot, arg1.fee_bps_snapshot, arg1.price_mist, arg2, arg4);
        let v0 = take_pt(arg1);
        arg1.is_active = false;
        0x2::transfer::public_transfer<0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::pt_object::PTObject>(v0, 0x2::tx_context::sender(arg4));
        emit_purchase(0x2::object::id<PTListing>(arg1), arg1.seller, 0x2::tx_context::sender(arg4), arg1.pt_id, arg1.price_mist, arg1.fee_recipient_snapshot, arg1.fee_bps_snapshot, 0);
    }

    public fun buy_vault_share<T0>(arg0: &OtcMarket, arg1: &mut VaultShareListing<T0>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_market_open(arg0);
        assert_listing_market_id(arg1.otc_market_id, 0x2::object::id<OtcMarket>(arg0));
        assert_vault_share_listing_version<T0>(arg1);
        assert_active(arg1.is_active);
        assert!(arg1.maturity_ms > 0x2::clock::timestamp_ms(arg3), 11);
        pay_exact(arg1.seller, arg1.fee_recipient_snapshot, arg1.fee_bps_snapshot, arg1.price_mist, arg2, arg4);
        let v0 = take_vault_share<T0>(arg1);
        arg1.is_active = false;
        0x2::transfer::public_transfer<0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_vault::VaultShare<T0>>(v0, 0x2::tx_context::sender(arg4));
        emit_purchase(0x2::object::id<VaultShareListing<T0>>(arg1), arg1.seller, 0x2::tx_context::sender(arg4), arg1.share_id, arg1.price_mist, arg1.fee_recipient_snapshot, arg1.fee_bps_snapshot, 2);
    }

    public fun buy_yt(arg0: &OtcMarket, arg1: &mut YTListing, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_market_open(arg0);
        assert_listing_market_id(arg1.otc_market_id, 0x2::object::id<OtcMarket>(arg0));
        assert_yt_listing_version(arg1);
        assert_active(arg1.is_active);
        assert!(arg1.maturity_ms > 0x2::clock::timestamp_ms(arg3), 11);
        pay_exact(arg1.seller, arg1.fee_recipient_snapshot, arg1.fee_bps_snapshot, arg1.price_mist, arg2, arg4);
        let v0 = take_yt(arg1);
        arg1.is_active = false;
        0x2::transfer::public_transfer<0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_object::YTObject>(v0, 0x2::tx_context::sender(arg4));
        emit_purchase(0x2::object::id<YTListing>(arg1), arg1.seller, 0x2::tx_context::sender(arg4), arg1.yt_id, arg1.price_mist, arg1.fee_recipient_snapshot, arg1.fee_bps_snapshot, 1);
    }

    public fun cancel_pt_listing(arg0: &mut PTListing, arg1: &mut 0x2::tx_context::TxContext) {
        assert_seller(arg0.seller, arg1);
        assert_active(arg0.is_active);
        let v0 = take_pt(arg0);
        let v1 = &mut arg0.cleanup_bond;
        refund_cleanup_bond(v1, arg0.seller);
        arg0.is_active = false;
        0x2::transfer::public_transfer<0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::pt_object::PTObject>(v0, arg0.seller);
        emit_cancel(0x2::object::id<PTListing>(arg0), arg0.seller, arg0.pt_id, 0);
    }

    public fun cancel_vault_share_listing<T0>(arg0: &mut VaultShareListing<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert_seller(arg0.seller, arg1);
        assert_active(arg0.is_active);
        let v0 = take_vault_share<T0>(arg0);
        let v1 = &mut arg0.cleanup_bond;
        refund_cleanup_bond(v1, arg0.seller);
        arg0.is_active = false;
        0x2::transfer::public_transfer<0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_vault::VaultShare<T0>>(v0, arg0.seller);
        emit_cancel(0x2::object::id<VaultShareListing<T0>>(arg0), arg0.seller, arg0.share_id, 2);
    }

    public fun cancel_yt_listing(arg0: &mut YTListing, arg1: &mut 0x2::tx_context::TxContext) {
        assert_seller(arg0.seller, arg1);
        assert_active(arg0.is_active);
        let v0 = take_yt(arg0);
        let v1 = &mut arg0.cleanup_bond;
        refund_cleanup_bond(v1, arg0.seller);
        arg0.is_active = false;
        0x2::transfer::public_transfer<0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_object::YTObject>(v0, arg0.seller);
        emit_cancel(0x2::object::id<YTListing>(arg0), arg0.seller, arg0.yt_id, 1);
    }

    public fun cleanup_bond_mist() : u64 {
        100000000
    }

    public fun delete_pt_listing(arg0: PTListing, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.is_active, 3);
        let PTListing {
            id                     : v0,
            version                : _,
            otc_market_id          : _,
            seller                 : v3,
            pt_id                  : v4,
            market_core_id         : _,
            escrow_id              : _,
            notional               : _,
            maturity_ms            : _,
            initial_index          : _,
            price_mist             : _,
            fee_bps_snapshot       : _,
            fee_recipient_snapshot : _,
            cleanup_bond           : v13,
            pt                     : v14,
            is_active              : _,
        } = arg0;
        0x1::option::destroy_none<0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::pt_object::PTObject>(v14);
        pay_cleanup_bond_if_present(v13, 0x2::tx_context::sender(arg1));
        0x2::object::delete(v0);
        emit_deleted(0x2::object::id<PTListing>(&arg0), v3, v4, 0x2::tx_context::sender(arg1), 0);
    }

    public fun delete_vault_share_listing<T0>(arg0: VaultShareListing<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.is_active, 3);
        let VaultShareListing {
            id                     : v0,
            version                : _,
            otc_market_id          : _,
            seller                 : v3,
            share_id               : v4,
            vault_id               : _,
            yt_id                  : _,
            shares                 : _,
            entry_epoch            : _,
            maturity_ms            : _,
            price_mist             : _,
            fee_bps_snapshot       : _,
            fee_recipient_snapshot : _,
            cleanup_bond           : v13,
            share                  : v14,
            is_active              : _,
        } = arg0;
        0x1::option::destroy_none<0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_vault::VaultShare<T0>>(v14);
        pay_cleanup_bond_if_present(v13, 0x2::tx_context::sender(arg1));
        0x2::object::delete(v0);
        emit_deleted(0x2::object::id<VaultShareListing<T0>>(&arg0), v3, v4, 0x2::tx_context::sender(arg1), 2);
    }

    public fun delete_yt_listing(arg0: YTListing, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.is_active, 3);
        let YTListing {
            id                     : v0,
            version                : _,
            otc_market_id          : _,
            seller                 : v3,
            yt_id                  : v4,
            market_core_id         : _,
            escrow_id              : _,
            notional               : _,
            maturity_ms            : _,
            yield_debt             : _,
            price_mist             : _,
            fee_bps_snapshot       : _,
            fee_recipient_snapshot : _,
            cleanup_bond           : v13,
            yt                     : v14,
            is_active              : _,
        } = arg0;
        0x1::option::destroy_none<0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_object::YTObject>(v14);
        pay_cleanup_bond_if_present(v13, 0x2::tx_context::sender(arg1));
        0x2::object::delete(v0);
        emit_deleted(0x2::object::id<YTListing>(&arg0), v3, v4, 0x2::tx_context::sender(arg1), 1);
    }

    fun emit_cancel(arg0: 0x2::object::ID, arg1: address, arg2: 0x2::object::ID, arg3: u8) {
        let v0 = ListingCancelled{
            listing_id : arg0,
            seller     : arg1,
            asset_id   : arg2,
            kind       : arg3,
        };
        0x2::event::emit<ListingCancelled>(v0);
    }

    fun emit_deleted(arg0: 0x2::object::ID, arg1: address, arg2: 0x2::object::ID, arg3: address, arg4: u8) {
        let v0 = ListingDeleted{
            listing_id : arg0,
            seller     : arg1,
            asset_id   : arg2,
            deleted_by : arg3,
            kind       : arg4,
        };
        0x2::event::emit<ListingDeleted>(v0);
    }

    fun emit_expired(arg0: 0x2::object::ID, arg1: address, arg2: 0x2::object::ID, arg3: address, arg4: u8) {
        let v0 = ListingExpired{
            listing_id : arg0,
            seller     : arg1,
            asset_id   : arg2,
            expired_by : arg3,
            kind       : arg4,
        };
        0x2::event::emit<ListingExpired>(v0);
    }

    fun emit_frozen(arg0: 0x2::object::ID, arg1: address, arg2: 0x2::object::ID, arg3: address, arg4: u8) {
        let v0 = ListingFrozen{
            listing_id : arg0,
            seller     : arg1,
            asset_id   : arg2,
            frozen_by  : arg3,
            kind       : arg4,
        };
        0x2::event::emit<ListingFrozen>(v0);
    }

    fun emit_price_updated(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64, arg4: u8) {
        let v0 = ListingPriceUpdated{
            listing_id     : arg0,
            seller         : arg1,
            old_price_mist : arg2,
            new_price_mist : arg3,
            kind           : arg4,
        };
        0x2::event::emit<ListingPriceUpdated>(v0);
    }

    fun emit_purchase(arg0: 0x2::object::ID, arg1: address, arg2: address, arg3: 0x2::object::ID, arg4: u64, arg5: address, arg6: u16, arg7: u8) {
        let v0 = ListingPurchased{
            listing_id    : arg0,
            seller        : arg1,
            buyer         : arg2,
            asset_id      : arg3,
            price_mist    : arg4,
            fee_mist      : fee_amount(arg4, arg6),
            fee_recipient : arg5,
            kind          : arg7,
        };
        0x2::event::emit<ListingPurchased>(v0);
    }

    public fun expire_pt_listing(arg0: &mut PTListing, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert_active(arg0.is_active);
        assert!(arg0.maturity_ms <= 0x2::clock::timestamp_ms(arg1), 3);
        let v0 = take_pt(arg0);
        arg0.is_active = false;
        0x2::transfer::public_transfer<0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::pt_object::PTObject>(v0, arg0.seller);
        emit_expired(0x2::object::id<PTListing>(arg0), arg0.seller, arg0.pt_id, 0x2::tx_context::sender(arg2), 0);
    }

    public fun expire_vault_share_listing<T0>(arg0: &mut VaultShareListing<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert_active(arg0.is_active);
        assert!(arg0.maturity_ms <= 0x2::clock::timestamp_ms(arg1), 3);
        let v0 = take_vault_share<T0>(arg0);
        arg0.is_active = false;
        0x2::transfer::public_transfer<0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_vault::VaultShare<T0>>(v0, arg0.seller);
        emit_expired(0x2::object::id<VaultShareListing<T0>>(arg0), arg0.seller, arg0.share_id, 0x2::tx_context::sender(arg2), 2);
    }

    public fun expire_yt_listing(arg0: &mut YTListing, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert_active(arg0.is_active);
        assert!(arg0.maturity_ms <= 0x2::clock::timestamp_ms(arg1), 3);
        let v0 = take_yt(arg0);
        arg0.is_active = false;
        0x2::transfer::public_transfer<0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_object::YTObject>(v0, arg0.seller);
        emit_expired(0x2::object::id<YTListing>(arg0), arg0.seller, arg0.yt_id, 0x2::tx_context::sender(arg2), 1);
    }

    fun fee_amount(arg0: u64, arg1: u16) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (10000 as u128)) as u64)
    }

    public fun finalize_pt_listing(arg0: PTListing) {
        0x2::transfer::share_object<PTListing>(arg0);
    }

    public fun finalize_vault_share_listing<T0>(arg0: VaultShareListing<T0>) {
        0x2::transfer::share_object<VaultShareListing<T0>>(arg0);
    }

    public fun finalize_yt_listing(arg0: YTListing) {
        0x2::transfer::share_object<YTListing>(arg0);
    }

    public fun freeze_listing_payload_hash(arg0: u8, arg1: 0x2::object::ID) : vector<u8> {
        let v0 = b"nemo_otc:freeze_listing:v1";
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u8>(&arg0));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&arg1));
        0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::timelock::hash_payload(v0)
    }

    fun init(arg0: MARKET, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x2::object::new(arg1);
        let v2 = 0x2::object::uid_to_inner(&v1);
        let v3 = OtcPauseCap{
            id        : 0x2::object::new(arg1),
            market_id : v2,
        };
        let v4 = 0x2::table::new<0x2::object::ID, bool>(arg1);
        0x2::table::add<0x2::object::ID, bool>(&mut v4, 0x2::object::id<OtcPauseCap>(&v3), true);
        let v5 = OtcMarket{
            id                      : v1,
            version                 : 1,
            paused                  : false,
            fee_bps                 : 0,
            fee_recipient           : v0,
            issued_pause_caps       : v4,
            revoked_pause_caps      : 0x2::table::new<0x2::object::ID, bool>(arg1),
            revoked_pause_cap_count : 0,
        };
        0x2::transfer::share_object<OtcMarket>(v5);
        let v6 = OtcAdminCap{
            id        : 0x2::object::new(arg1),
            market_id : v2,
        };
        0x2::transfer::public_transfer<OtcAdminCap>(v6, v0);
        0x2::transfer::public_transfer<OtcPauseCap>(v3, v0);
    }

    public fun issue_pause_cap(arg0: &mut OtcMarket, arg1: &OtcAdminCap, arg2: 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::timelock::TimelockReceipt, arg3: address, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_market_version(arg0);
        assert_admin_cap(arg0, arg1);
        let v0 = 0x2::object::id<OtcMarket>(arg0);
        0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::timelock::consume_receipt_with_payload(arg2, 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::timelock::action_otc_issue_pause_cap(), v0, issue_pause_cap_payload_hash(arg3), arg4);
        let v1 = OtcPauseCap{
            id        : 0x2::object::new(arg5),
            market_id : v0,
        };
        let v2 = 0x2::object::id<OtcPauseCap>(&v1);
        0x2::table::add<0x2::object::ID, bool>(&mut arg0.issued_pause_caps, v2, true);
        0x2::transfer::public_transfer<OtcPauseCap>(v1, arg3);
        let v3 = OtcPauseCapIssued{
            market_id    : v0,
            pause_cap_id : v2,
            issued_by    : 0x2::tx_context::sender(arg5),
            recipient    : arg3,
        };
        0x2::event::emit<OtcPauseCapIssued>(v3);
    }

    public fun issue_pause_cap_payload_hash(arg0: address) : vector<u8> {
        let v0 = b"nemo_otc:issue_pause_cap:v1";
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<address>(&arg0));
        0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::timelock::hash_payload(v0)
    }

    public fun list_pt(arg0: &OtcMarket, arg1: 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::pt_object::PTObject, arg2: u64, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : PTListing {
        assert_market_open(arg0);
        assert_valid_price(arg2);
        assert_cleanup_bond(&arg3);
        assert!(0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::pt_object::maturity_ms(&arg1) > 0x2::clock::timestamp_ms(arg4), 11);
        let v0 = 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::pt_object::id(&arg1);
        let v1 = 0x2::object::id<OtcMarket>(arg0);
        let v2 = PTListing{
            id                     : 0x2::object::new(arg5),
            version                : 1,
            otc_market_id          : v1,
            seller                 : 0x2::tx_context::sender(arg5),
            pt_id                  : v0,
            market_core_id         : 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::pt_object::market_core_id(&arg1),
            escrow_id              : 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::pt_object::escrow_id(&arg1),
            notional               : 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::pt_object::notional(&arg1),
            maturity_ms            : 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::pt_object::maturity_ms(&arg1),
            initial_index          : 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::pt_object::initial_index(&arg1),
            price_mist             : arg2,
            fee_bps_snapshot       : arg0.fee_bps,
            fee_recipient_snapshot : arg0.fee_recipient,
            cleanup_bond           : 0x1::option::some<0x2::coin::Coin<0x2::sui::SUI>>(arg3),
            pt                     : 0x1::option::some<0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::pt_object::PTObject>(arg1),
            is_active              : true,
        };
        let v3 = PTListed{
            otc_market_id          : v1,
            listing_id             : 0x2::object::id<PTListing>(&v2),
            seller                 : v2.seller,
            pt_id                  : v0,
            market_core_id         : v2.market_core_id,
            escrow_id              : v2.escrow_id,
            notional               : v2.notional,
            maturity_ms            : v2.maturity_ms,
            initial_index          : v2.initial_index,
            price_mist             : arg2,
            fee_bps_snapshot       : v2.fee_bps_snapshot,
            fee_recipient_snapshot : v2.fee_recipient_snapshot,
            cleanup_bond_mist      : 100000000,
        };
        0x2::event::emit<PTListed>(v3);
        v2
    }

    public fun list_vault_share<T0, T1>(arg0: &OtcMarket, arg1: 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_vault::VaultShare<T1>, arg2: &0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_vault::YTVault<T0, T1>, arg3: u64, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : VaultShareListing<T1> {
        assert_market_open(arg0);
        assert_valid_price(arg3);
        assert_cleanup_bond(&arg4);
        assert!(0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_vault::maturity_ms<T0, T1>(arg2) > 0x2::clock::timestamp_ms(arg5), 11);
        let v0 = 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_vault::id<T0, T1>(arg2);
        assert!(0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_vault::share_vault_id<T1>(&arg1) == v0, 8);
        let v1 = 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_vault::share_id<T1>(&arg1);
        let v2 = 0x2::object::id<OtcMarket>(arg0);
        let v3 = VaultShareListing<T1>{
            id                     : 0x2::object::new(arg6),
            version                : 1,
            otc_market_id          : v2,
            seller                 : 0x2::tx_context::sender(arg6),
            share_id               : v1,
            vault_id               : v0,
            yt_id                  : 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_vault::share_yt_id<T1>(&arg1),
            shares                 : 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_vault::share_value<T1>(&arg1),
            entry_epoch            : 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_vault::share_entry_epoch<T1>(&arg1),
            maturity_ms            : 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_vault::maturity_ms<T0, T1>(arg2),
            price_mist             : arg3,
            fee_bps_snapshot       : arg0.fee_bps,
            fee_recipient_snapshot : arg0.fee_recipient,
            cleanup_bond           : 0x1::option::some<0x2::coin::Coin<0x2::sui::SUI>>(arg4),
            share                  : 0x1::option::some<0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_vault::VaultShare<T1>>(arg1),
            is_active              : true,
        };
        let v4 = VaultShareListed{
            otc_market_id          : v2,
            listing_id             : 0x2::object::id<VaultShareListing<T1>>(&v3),
            seller                 : v3.seller,
            share_id               : v1,
            vault_id               : v0,
            yt_id                  : v3.yt_id,
            shares                 : v3.shares,
            entry_epoch            : v3.entry_epoch,
            maturity_ms            : v3.maturity_ms,
            price_mist             : arg3,
            fee_bps_snapshot       : v3.fee_bps_snapshot,
            fee_recipient_snapshot : v3.fee_recipient_snapshot,
            cleanup_bond_mist      : 100000000,
        };
        0x2::event::emit<VaultShareListed>(v4);
        v3
    }

    public fun list_yt(arg0: &OtcMarket, arg1: 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_object::YTObject, arg2: u64, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : YTListing {
        assert_market_open(arg0);
        assert_valid_price(arg2);
        assert_cleanup_bond(&arg3);
        assert!(0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_object::maturity_ms(&arg1) > 0x2::clock::timestamp_ms(arg4), 11);
        let v0 = 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_object::id(&arg1);
        let v1 = 0x2::object::id<OtcMarket>(arg0);
        let v2 = YTListing{
            id                     : 0x2::object::new(arg5),
            version                : 1,
            otc_market_id          : v1,
            seller                 : 0x2::tx_context::sender(arg5),
            yt_id                  : v0,
            market_core_id         : 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_object::market_core_id(&arg1),
            escrow_id              : 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_object::escrow_id(&arg1),
            notional               : 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_object::notional(&arg1),
            maturity_ms            : 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_object::maturity_ms(&arg1),
            yield_debt             : 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_object::yield_debt(&arg1),
            price_mist             : arg2,
            fee_bps_snapshot       : arg0.fee_bps,
            fee_recipient_snapshot : arg0.fee_recipient,
            cleanup_bond           : 0x1::option::some<0x2::coin::Coin<0x2::sui::SUI>>(arg3),
            yt                     : 0x1::option::some<0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_object::YTObject>(arg1),
            is_active              : true,
        };
        let v3 = YTListed{
            otc_market_id          : v1,
            listing_id             : 0x2::object::id<YTListing>(&v2),
            seller                 : v2.seller,
            yt_id                  : v0,
            market_core_id         : v2.market_core_id,
            escrow_id              : v2.escrow_id,
            notional               : v2.notional,
            maturity_ms            : v2.maturity_ms,
            yield_debt             : v2.yield_debt,
            price_mist             : arg2,
            fee_bps_snapshot       : v2.fee_bps_snapshot,
            fee_recipient_snapshot : v2.fee_recipient_snapshot,
            cleanup_bond_mist      : 100000000,
        };
        0x2::event::emit<YTListed>(v3);
        v2
    }

    public fun market_fee_bps(arg0: &OtcMarket) : u16 {
        arg0.fee_bps
    }

    public fun market_fee_recipient(arg0: &OtcMarket) : address {
        arg0.fee_recipient
    }

    public fun market_id(arg0: &OtcMarket) : 0x2::object::ID {
        0x2::object::id<OtcMarket>(arg0)
    }

    public fun market_paused(arg0: &OtcMarket) : bool {
        arg0.paused
    }

    public fun market_revoked_pause_cap_count(arg0: &OtcMarket) : u64 {
        arg0.revoked_pause_cap_count
    }

    public fun market_version(arg0: &OtcMarket) : u64 {
        arg0.version
    }

    public fun max_price_mist() : u64 {
        10000000000000000000
    }

    public fun pause(arg0: &mut OtcMarket, arg1: &OtcPauseCap, arg2: vector<u8>, arg3: &0x2::tx_context::TxContext) {
        assert_market_version(arg0);
        assert_pause_cap_live(arg0, arg1);
        assert!(!arg0.paused, 14);
        arg0.paused = true;
        let v0 = OtcMarketPaused{
            market_id : 0x2::object::id<OtcMarket>(arg0),
            paused_by : 0x2::tx_context::sender(arg3),
            reason    : arg2,
        };
        0x2::event::emit<OtcMarketPaused>(v0);
    }

    public fun pause_cap_id(arg0: &OtcPauseCap) : 0x2::object::ID {
        0x2::object::id<OtcPauseCap>(arg0)
    }

    public fun pause_cap_market_id(arg0: &OtcPauseCap) : 0x2::object::ID {
        arg0.market_id
    }

    fun pay_cleanup_bond_if_present(arg0: 0x1::option::Option<0x2::coin::Coin<0x2::sui::SUI>>, arg1: address) {
        if (0x1::option::is_some<0x2::coin::Coin<0x2::sui::SUI>>(&arg0)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x1::option::destroy_some<0x2::coin::Coin<0x2::sui::SUI>>(arg0), arg1);
        } else {
            0x1::option::destroy_none<0x2::coin::Coin<0x2::sui::SUI>>(arg0);
        };
    }

    fun pay_exact(arg0: address, arg1: address, arg2: u16, arg3: u64, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg4) == arg3, 5);
        let v0 = fee_amount(arg3, arg2);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg4, v0, arg5), arg1);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg4, arg0);
    }

    public fun pt_listing_escrow_id(arg0: &PTListing) : 0x2::object::ID {
        arg0.escrow_id
    }

    public fun pt_listing_fee_bps_snapshot(arg0: &PTListing) : u16 {
        arg0.fee_bps_snapshot
    }

    public fun pt_listing_fee_recipient_snapshot(arg0: &PTListing) : address {
        arg0.fee_recipient_snapshot
    }

    public fun pt_listing_id(arg0: &PTListing) : 0x2::object::ID {
        0x2::object::id<PTListing>(arg0)
    }

    public fun pt_listing_initial_index(arg0: &PTListing) : u128 {
        arg0.initial_index
    }

    public fun pt_listing_is_active(arg0: &PTListing) : bool {
        arg0.is_active
    }

    public fun pt_listing_market_core_id(arg0: &PTListing) : 0x2::object::ID {
        arg0.market_core_id
    }

    public fun pt_listing_maturity_ms(arg0: &PTListing) : u64 {
        arg0.maturity_ms
    }

    public fun pt_listing_notional(arg0: &PTListing) : u64 {
        arg0.notional
    }

    public fun pt_listing_otc_market_id(arg0: &PTListing) : 0x2::object::ID {
        arg0.otc_market_id
    }

    public fun pt_listing_price_mist(arg0: &PTListing) : u64 {
        arg0.price_mist
    }

    public fun pt_listing_pt_id(arg0: &PTListing) : 0x2::object::ID {
        arg0.pt_id
    }

    public fun pt_listing_seller(arg0: &PTListing) : address {
        arg0.seller
    }

    fun refund_cleanup_bond(arg0: &mut 0x1::option::Option<0x2::coin::Coin<0x2::sui::SUI>>, arg1: address) {
        assert!(0x1::option::is_some<0x2::coin::Coin<0x2::sui::SUI>>(arg0), 10);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x1::option::extract<0x2::coin::Coin<0x2::sui::SUI>>(arg0), arg1);
    }

    public fun revoke_pause_cap(arg0: &mut OtcMarket, arg1: &OtcAdminCap, arg2: 0x2::object::ID, arg3: &0x2::tx_context::TxContext) {
        assert_market_version(arg0);
        assert_admin_cap(arg0, arg1);
        assert!(0x2::table::contains<0x2::object::ID, bool>(&arg0.issued_pause_caps, arg2), 18);
        assert!(!0x2::table::contains<0x2::object::ID, bool>(&arg0.revoked_pause_caps, arg2), 17);
        assert!(arg0.revoked_pause_cap_count < 256, 19);
        0x2::table::add<0x2::object::ID, bool>(&mut arg0.revoked_pause_caps, arg2, true);
        arg0.revoked_pause_cap_count = arg0.revoked_pause_cap_count + 1;
        let v0 = OtcPauseCapRevoked{
            market_id    : 0x2::object::id<OtcMarket>(arg0),
            pause_cap_id : arg2,
            revoked_by   : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<OtcPauseCapRevoked>(v0);
    }

    public fun set_fee_bps(arg0: &mut OtcMarket, arg1: &OtcAdminCap, arg2: u16, arg3: 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::timelock::TimelockReceipt, arg4: &0x2::clock::Clock) {
        assert_market_version(arg0);
        assert_admin_cap(arg0, arg1);
        assert!(arg2 <= 1000, 6);
        assert!(arg0.fee_bps != arg2, 16);
        let v0 = 0x2::object::id<OtcMarket>(arg0);
        0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::timelock::consume_receipt_with_payload(arg3, 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::timelock::action_otc_set_fee_bps(), v0, set_fee_bps_payload_hash(arg2), arg4);
        arg0.fee_bps = arg2;
        let v1 = OtcFeeBpsUpdated{
            market_id   : v0,
            old_fee_bps : arg0.fee_bps,
            new_fee_bps : arg2,
        };
        0x2::event::emit<OtcFeeBpsUpdated>(v1);
    }

    public fun set_fee_bps_payload_hash(arg0: u16) : vector<u8> {
        let v0 = b"nemo_otc:set_fee_bps:v1";
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u16>(&arg0));
        0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::timelock::hash_payload(v0)
    }

    public fun set_fee_recipient(arg0: &mut OtcMarket, arg1: &OtcAdminCap, arg2: address, arg3: 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::timelock::TimelockReceipt, arg4: &0x2::clock::Clock) {
        assert_market_version(arg0);
        assert_admin_cap(arg0, arg1);
        assert!(arg2 != @0x0, 20);
        assert!(arg0.fee_recipient != arg2, 16);
        let v0 = 0x2::object::id<OtcMarket>(arg0);
        0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::timelock::consume_receipt_with_payload(arg3, 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::timelock::action_otc_set_fee_recipient(), v0, set_fee_recipient_payload_hash(arg2), arg4);
        arg0.fee_recipient = arg2;
        let v1 = OtcFeeRecipientUpdated{
            market_id         : v0,
            old_fee_recipient : arg0.fee_recipient,
            new_fee_recipient : arg2,
        };
        0x2::event::emit<OtcFeeRecipientUpdated>(v1);
    }

    public fun set_fee_recipient_payload_hash(arg0: address) : vector<u8> {
        let v0 = b"nemo_otc:set_fee_recipient:v1";
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<address>(&arg0));
        0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::timelock::hash_payload(v0)
    }

    fun take_pt(arg0: &mut PTListing) : 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::pt_object::PTObject {
        assert!(0x1::option::is_some<0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::pt_object::PTObject>(&arg0.pt), 7);
        0x1::option::extract<0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::pt_object::PTObject>(&mut arg0.pt)
    }

    fun take_vault_share<T0>(arg0: &mut VaultShareListing<T0>) : 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_vault::VaultShare<T0> {
        assert!(0x1::option::is_some<0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_vault::VaultShare<T0>>(&arg0.share), 7);
        0x1::option::extract<0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_vault::VaultShare<T0>>(&mut arg0.share)
    }

    fun take_yt(arg0: &mut YTListing) : 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_object::YTObject {
        assert!(0x1::option::is_some<0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_object::YTObject>(&arg0.yt), 7);
        0x1::option::extract<0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_object::YTObject>(&mut arg0.yt)
    }

    public fun unpause(arg0: &mut OtcMarket, arg1: &OtcAdminCap, arg2: 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::timelock::TimelockReceipt, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert_market_version(arg0);
        assert_admin_cap(arg0, arg1);
        assert!(arg0.paused, 15);
        let v0 = 0x2::object::id<OtcMarket>(arg0);
        0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::timelock::consume_receipt_with_payload(arg2, 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::timelock::action_otc_unpause(), v0, unpause_payload_hash(), arg3);
        arg0.paused = false;
        let v1 = OtcMarketUnpaused{
            market_id   : v0,
            unpaused_by : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<OtcMarketUnpaused>(v1);
    }

    public fun unpause_payload_hash() : vector<u8> {
        0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::timelock::hash_payload(b"nemo_otc:unpause:v1")
    }

    public fun update_pt_price(arg0: &OtcMarket, arg1: &mut PTListing, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_market_open(arg0);
        assert_listing_market_id(arg1.otc_market_id, 0x2::object::id<OtcMarket>(arg0));
        assert_pt_listing_version(arg1);
        assert_seller(arg1.seller, arg4);
        assert_active(arg1.is_active);
        assert!(arg1.maturity_ms > 0x2::clock::timestamp_ms(arg3), 11);
        assert_valid_price(arg2);
        let v0 = arg1.price_mist;
        assert!(v0 != arg2, 16);
        arg1.price_mist = arg2;
        emit_price_updated(0x2::object::id<PTListing>(arg1), arg1.seller, v0, arg2, 0);
    }

    public fun update_vault_share_price<T0>(arg0: &OtcMarket, arg1: &mut VaultShareListing<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_market_open(arg0);
        assert_listing_market_id(arg1.otc_market_id, 0x2::object::id<OtcMarket>(arg0));
        assert_vault_share_listing_version<T0>(arg1);
        assert_seller(arg1.seller, arg4);
        assert_active(arg1.is_active);
        assert!(arg1.maturity_ms > 0x2::clock::timestamp_ms(arg3), 11);
        assert_valid_price(arg2);
        let v0 = arg1.price_mist;
        assert!(v0 != arg2, 16);
        arg1.price_mist = arg2;
        emit_price_updated(0x2::object::id<VaultShareListing<T0>>(arg1), arg1.seller, v0, arg2, 2);
    }

    public fun update_yt_price(arg0: &OtcMarket, arg1: &mut YTListing, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_market_open(arg0);
        assert_listing_market_id(arg1.otc_market_id, 0x2::object::id<OtcMarket>(arg0));
        assert_yt_listing_version(arg1);
        assert_seller(arg1.seller, arg4);
        assert_active(arg1.is_active);
        assert!(arg1.maturity_ms > 0x2::clock::timestamp_ms(arg3), 11);
        assert_valid_price(arg2);
        let v0 = arg1.price_mist;
        assert!(v0 != arg2, 16);
        arg1.price_mist = arg2;
        emit_price_updated(0x2::object::id<YTListing>(arg1), arg1.seller, v0, arg2, 1);
    }

    public fun vault_share_listing_entry_epoch<T0>(arg0: &VaultShareListing<T0>) : u64 {
        arg0.entry_epoch
    }

    public fun vault_share_listing_fee_bps_snapshot<T0>(arg0: &VaultShareListing<T0>) : u16 {
        arg0.fee_bps_snapshot
    }

    public fun vault_share_listing_fee_recipient_snapshot<T0>(arg0: &VaultShareListing<T0>) : address {
        arg0.fee_recipient_snapshot
    }

    public fun vault_share_listing_id<T0>(arg0: &VaultShareListing<T0>) : 0x2::object::ID {
        0x2::object::id<VaultShareListing<T0>>(arg0)
    }

    public fun vault_share_listing_is_active<T0>(arg0: &VaultShareListing<T0>) : bool {
        arg0.is_active
    }

    public fun vault_share_listing_maturity_ms<T0>(arg0: &VaultShareListing<T0>) : u64 {
        arg0.maturity_ms
    }

    public fun vault_share_listing_otc_market_id<T0>(arg0: &VaultShareListing<T0>) : 0x2::object::ID {
        arg0.otc_market_id
    }

    public fun vault_share_listing_price_mist<T0>(arg0: &VaultShareListing<T0>) : u64 {
        arg0.price_mist
    }

    public fun vault_share_listing_seller<T0>(arg0: &VaultShareListing<T0>) : address {
        arg0.seller
    }

    public fun vault_share_listing_share_id<T0>(arg0: &VaultShareListing<T0>) : 0x2::object::ID {
        arg0.share_id
    }

    public fun vault_share_listing_shares<T0>(arg0: &VaultShareListing<T0>) : u64 {
        arg0.shares
    }

    public fun vault_share_listing_vault_id<T0>(arg0: &VaultShareListing<T0>) : 0x2::object::ID {
        arg0.vault_id
    }

    public fun vault_share_listing_yt_id<T0>(arg0: &VaultShareListing<T0>) : 0x2::object::ID {
        arg0.yt_id
    }

    public fun yt_listing_escrow_id(arg0: &YTListing) : 0x2::object::ID {
        arg0.escrow_id
    }

    public fun yt_listing_fee_bps_snapshot(arg0: &YTListing) : u16 {
        arg0.fee_bps_snapshot
    }

    public fun yt_listing_fee_recipient_snapshot(arg0: &YTListing) : address {
        arg0.fee_recipient_snapshot
    }

    public fun yt_listing_id(arg0: &YTListing) : 0x2::object::ID {
        0x2::object::id<YTListing>(arg0)
    }

    public fun yt_listing_is_active(arg0: &YTListing) : bool {
        arg0.is_active
    }

    public fun yt_listing_market_core_id(arg0: &YTListing) : 0x2::object::ID {
        arg0.market_core_id
    }

    public fun yt_listing_maturity_ms(arg0: &YTListing) : u64 {
        arg0.maturity_ms
    }

    public fun yt_listing_notional(arg0: &YTListing) : u64 {
        arg0.notional
    }

    public fun yt_listing_otc_market_id(arg0: &YTListing) : 0x2::object::ID {
        arg0.otc_market_id
    }

    public fun yt_listing_price_mist(arg0: &YTListing) : u64 {
        arg0.price_mist
    }

    public fun yt_listing_seller(arg0: &YTListing) : address {
        arg0.seller
    }

    public fun yt_listing_yield_debt(arg0: &YTListing) : u128 {
        arg0.yield_debt
    }

    public fun yt_listing_yt_id(arg0: &YTListing) : 0x2::object::ID {
        arg0.yt_id
    }

    // decompiled from Move bytecode v7
}

