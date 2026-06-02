module 0x611c33e5d9ed4c5b251b456a6b5a1c80be7595190e6e2e82180d63004ab0682d::admin {
    struct SuperAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct AdminRegistry has key {
        id: 0x2::object::UID,
        admins: vector<address>,
        mint_paused: bool,
        pause_reason: 0x1::string::String,
    }

    struct AdminAdded has copy, drop {
        added: address,
        by: address,
    }

    struct AdminRemoved has copy, drop {
        removed: address,
        by: address,
    }

    struct MintPaused has copy, drop {
        reason: 0x1::string::String,
        by: address,
    }

    struct MintUnpaused has copy, drop {
        by: address,
    }

    struct SuperAdminTransferred has copy, drop {
        to: address,
        by: address,
    }

    fun EMintPaused() : u64 {
        5
    }

    public fun add_admin(arg0: &SuperAdminCap, arg1: &mut AdminRegistry, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!0x1::vector::contains<address>(&arg1.admins, &arg2), 2);
        0x1::vector::push_back<address>(&mut arg1.admins, arg2);
        let v0 = AdminAdded{
            added : arg2,
            by    : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<AdminAdded>(v0);
    }

    public fun add_shop_tracking(arg0: &AdminRegistry, arg1: &mut 0x611c33e5d9ed4c5b251b456a6b5a1c80be7595190e6e2e82180d63004ab0682d::shop_receipt::ShopReceipt, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert_is_admin(arg0, 0x2::tx_context::sender(arg6));
        0x611c33e5d9ed4c5b251b456a6b5a1c80be7595190e6e2e82180d63004ab0682d::shop_receipt::set_tracking_info(arg1, arg2, arg3, arg4, arg5);
    }

    public fun add_tracking_information(arg0: &AdminRegistry, arg1: &mut 0x611c33e5d9ed4c5b251b456a6b5a1c80be7595190e6e2e82180d63004ab0682d::order_receipt::OrderReceipt, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert_is_admin(arg0, 0x2::tx_context::sender(arg6));
        0x611c33e5d9ed4c5b251b456a6b5a1c80be7595190e6e2e82180d63004ab0682d::order_receipt::add_tracking_info(arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public fun admin_count(arg0: &AdminRegistry) : u64 {
        0x1::vector::length<address>(&arg0.admins)
    }

    fun assert_is_admin(arg0: &AdminRegistry, arg1: address) {
        assert!(0x1::vector::contains<address>(&arg0.admins, &arg1), 1);
    }

    public(friend) fun assert_mint_active(arg0: &AdminRegistry) {
        assert!(!arg0.mint_paused, EMintPaused());
    }

    public fun burn_order_receipt(arg0: &AdminRegistry, arg1: 0x611c33e5d9ed4c5b251b456a6b5a1c80be7595190e6e2e82180d63004ab0682d::order_receipt::OrderReceipt, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert_is_admin(arg0, 0x2::tx_context::sender(arg3));
        0x611c33e5d9ed4c5b251b456a6b5a1c80be7595190e6e2e82180d63004ab0682d::order_receipt::burn_receipt(arg1, 0x2::tx_context::sender(arg3), arg2);
    }

    public fun burn_shop_item(arg0: &SuperAdminCap, arg1: &mut 0x611c33e5d9ed4c5b251b456a6b5a1c80be7595190e6e2e82180d63004ab0682d::shop_item::ShopRegistry, arg2: 0x611c33e5d9ed4c5b251b456a6b5a1c80be7595190e6e2e82180d63004ab0682d::shop_item::ShopItem, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x611c33e5d9ed4c5b251b456a6b5a1c80be7595190e6e2e82180d63004ab0682d::shop_item::burn_item(arg1, arg2, 0x2::tx_context::sender(arg4), arg3);
    }

    public fun burn_shop_receipt(arg0: &AdminRegistry, arg1: &mut 0x611c33e5d9ed4c5b251b456a6b5a1c80be7595190e6e2e82180d63004ab0682d::shop_receipt::ShopReceiptRegistry, arg2: 0x611c33e5d9ed4c5b251b456a6b5a1c80be7595190e6e2e82180d63004ab0682d::shop_receipt::ShopReceipt, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_is_admin(arg0, 0x2::tx_context::sender(arg4));
        0x611c33e5d9ed4c5b251b456a6b5a1c80be7595190e6e2e82180d63004ab0682d::shop_receipt::burn_receipt(arg1, arg2, 0x2::tx_context::sender(arg4), arg3);
    }

    public fun create_shop_item(arg0: &SuperAdminCap, arg1: &mut 0x611c33e5d9ed4c5b251b456a6b5a1c80be7595190e6e2e82180d63004ab0682d::shop_item::ShopRegistry, arg2: 0x1::string::String, arg3: u8, arg4: u64, arg5: u64, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: 0x1::string::String, arg11: 0x1::string::String, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        0x611c33e5d9ed4c5b251b456a6b5a1c80be7595190e6e2e82180d63004ab0682d::shop_item::create_item(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
    }

    public fun get_receipt_details(arg0: &AdminRegistry, arg1: &0x611c33e5d9ed4c5b251b456a6b5a1c80be7595190e6e2e82180d63004ab0682d::order_receipt::OrderReceipt, arg2: &0x2::tx_context::TxContext) : (0x2::object::ID, 0x2::object::ID, address, 0x1::string::String, u64, u8, u64, u64, 0x1::string::String, 0x1::string::String, u64, 0x1::string::String, 0x1::string::String) {
        assert_is_admin(arg0, 0x2::tx_context::sender(arg2));
        let (v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11) = 0x611c33e5d9ed4c5b251b456a6b5a1c80be7595190e6e2e82180d63004ab0682d::order_receipt::get_receipt_info_admin(arg1);
        (0x611c33e5d9ed4c5b251b456a6b5a1c80be7595190e6e2e82180d63004ab0682d::order_receipt::get_receipt_id(arg1), v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = SuperAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<SuperAdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = AdminRegistry{
            id           : 0x2::object::new(arg0),
            admins       : 0x1::vector::empty<address>(),
            mint_paused  : false,
            pause_reason : 0x1::string::utf8(b""),
        };
        0x2::transfer::share_object<AdminRegistry>(v1);
    }

    public fun is_admin(arg0: &AdminRegistry, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.admins, &arg1)
    }

    public fun is_mint_paused(arg0: &AdminRegistry) : bool {
        arg0.mint_paused
    }

    public fun mark_as_delivered(arg0: &AdminRegistry, arg1: &mut 0x611c33e5d9ed4c5b251b456a6b5a1c80be7595190e6e2e82180d63004ab0682d::order_receipt::OrderReceipt, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert_is_admin(arg0, 0x2::tx_context::sender(arg3));
        0x611c33e5d9ed4c5b251b456a6b5a1c80be7595190e6e2e82180d63004ab0682d::order_receipt::update_status(arg1, 2, arg2, arg3);
    }

    public fun mark_as_shipped(arg0: &AdminRegistry, arg1: &mut 0x611c33e5d9ed4c5b251b456a6b5a1c80be7595190e6e2e82180d63004ab0682d::order_receipt::OrderReceipt, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert_is_admin(arg0, 0x2::tx_context::sender(arg3));
        0x611c33e5d9ed4c5b251b456a6b5a1c80be7595190e6e2e82180d63004ab0682d::order_receipt::update_status(arg1, 1, arg2, arg3);
    }

    public fun mark_shop_order_delivered(arg0: &AdminRegistry, arg1: &mut 0x611c33e5d9ed4c5b251b456a6b5a1c80be7595190e6e2e82180d63004ab0682d::shop_receipt::ShopReceipt, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert_is_admin(arg0, 0x2::tx_context::sender(arg3));
        0x611c33e5d9ed4c5b251b456a6b5a1c80be7595190e6e2e82180d63004ab0682d::shop_receipt::update_status_delivered(arg1, 0x2::tx_context::sender(arg3), arg2);
    }

    public fun mark_shop_order_shipped(arg0: &AdminRegistry, arg1: &mut 0x611c33e5d9ed4c5b251b456a6b5a1c80be7595190e6e2e82180d63004ab0682d::shop_receipt::ShopReceipt, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert_is_admin(arg0, 0x2::tx_context::sender(arg3));
        0x611c33e5d9ed4c5b251b456a6b5a1c80be7595190e6e2e82180d63004ab0682d::shop_receipt::update_status_shipped(arg1, 0x2::tx_context::sender(arg3), arg2);
    }

    public fun pause_minting(arg0: &SuperAdminCap, arg1: &mut AdminRegistry, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.mint_paused = true;
        arg1.pause_reason = arg2;
        let v0 = MintPaused{
            reason : arg2,
            by     : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<MintPaused>(v0);
    }

    public fun pause_reason(arg0: &AdminRegistry) : 0x1::string::String {
        arg0.pause_reason
    }

    public fun pause_shop_item(arg0: &AdminRegistry, arg1: &mut 0x611c33e5d9ed4c5b251b456a6b5a1c80be7595190e6e2e82180d63004ab0682d::shop_item::ShopItem, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert_is_admin(arg0, 0x2::tx_context::sender(arg3));
        0x611c33e5d9ed4c5b251b456a6b5a1c80be7595190e6e2e82180d63004ab0682d::shop_item::pause_item(arg1, 0x2::tx_context::sender(arg3), arg2);
    }

    public fun remove_admin(arg0: &SuperAdminCap, arg1: &mut AdminRegistry, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) != arg2, 4);
        let (v0, v1) = 0x1::vector::index_of<address>(&arg1.admins, &arg2);
        assert!(v0, 3);
        0x1::vector::remove<address>(&mut arg1.admins, v1);
        let v2 = AdminRemoved{
            removed : arg2,
            by      : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<AdminRemoved>(v2);
    }

    public fun replenish_shop_stock(arg0: &AdminRegistry, arg1: &mut 0x611c33e5d9ed4c5b251b456a6b5a1c80be7595190e6e2e82180d63004ab0682d::shop_item::ShopItem, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_is_admin(arg0, 0x2::tx_context::sender(arg4));
        0x611c33e5d9ed4c5b251b456a6b5a1c80be7595190e6e2e82180d63004ab0682d::shop_item::replenish_stock(arg1, arg2, 0x2::tx_context::sender(arg4), arg3);
    }

    public fun transfer_super_admin(arg0: SuperAdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = SuperAdminTransferred{
            to : arg1,
            by : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<SuperAdminTransferred>(v0);
        0x2::transfer::transfer<SuperAdminCap>(arg0, arg1);
    }

    public fun unpause_minting(arg0: &SuperAdminCap, arg1: &mut AdminRegistry, arg2: &mut 0x2::tx_context::TxContext) {
        arg1.mint_paused = false;
        arg1.pause_reason = 0x1::string::utf8(b"");
        let v0 = MintUnpaused{by: 0x2::tx_context::sender(arg2)};
        0x2::event::emit<MintUnpaused>(v0);
    }

    public fun unpause_shop_item(arg0: &AdminRegistry, arg1: &mut 0x611c33e5d9ed4c5b251b456a6b5a1c80be7595190e6e2e82180d63004ab0682d::shop_item::ShopItem, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert_is_admin(arg0, 0x2::tx_context::sender(arg3));
        0x611c33e5d9ed4c5b251b456a6b5a1c80be7595190e6e2e82180d63004ab0682d::shop_item::unpause_item(arg1, 0x2::tx_context::sender(arg3), arg2);
    }

    public fun update_base_mint_price(arg0: &SuperAdminCap, arg1: &mut 0x611c33e5d9ed4c5b251b456a6b5a1c80be7595190e6e2e82180d63004ab0682d::treasury::TreasuryConfig, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x611c33e5d9ed4c5b251b456a6b5a1c80be7595190e6e2e82180d63004ab0682d::treasury::set_base_mint_price(arg1, arg2, arg3);
    }

    public fun update_bundle_upgrade_price(arg0: &SuperAdminCap, arg1: &mut 0x611c33e5d9ed4c5b251b456a6b5a1c80be7595190e6e2e82180d63004ab0682d::treasury::TreasuryConfig, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x611c33e5d9ed4c5b251b456a6b5a1c80be7595190e6e2e82180d63004ab0682d::treasury::set_bundle_upgrade_price(arg1, arg2, arg3);
    }

    public fun update_shop_item_display(arg0: &SuperAdminCap, arg1: &mut 0x611c33e5d9ed4c5b251b456a6b5a1c80be7595190e6e2e82180d63004ab0682d::shop_item::ShopItem, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        0x611c33e5d9ed4c5b251b456a6b5a1c80be7595190e6e2e82180d63004ab0682d::shop_item::update_item_display(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, 0x2::tx_context::sender(arg10), arg9);
    }

    public fun update_shop_item_price(arg0: &SuperAdminCap, arg1: &mut 0x611c33e5d9ed4c5b251b456a6b5a1c80be7595190e6e2e82180d63004ab0682d::shop_item::ShopItem, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x611c33e5d9ed4c5b251b456a6b5a1c80be7595190e6e2e82180d63004ab0682d::shop_item::update_item_price(arg1, arg2, 0x2::tx_context::sender(arg4), arg3);
    }

    public fun update_treasury_address(arg0: &SuperAdminCap, arg1: &mut 0x611c33e5d9ed4c5b251b456a6b5a1c80be7595190e6e2e82180d63004ab0682d::treasury::TreasuryConfig, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x611c33e5d9ed4c5b251b456a6b5a1c80be7595190e6e2e82180d63004ab0682d::treasury::set_treasury_address(arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v7
}

