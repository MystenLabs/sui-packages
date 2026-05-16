module 0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::payment_core_asset_lanes {
    struct PaymentCoreAssetLaneKey has copy, drop, store {
        asset_type_bytes: vector<u8>,
    }

    struct PaymentCoreAssetLaneConfig has store {
        listing_currency: bool,
        bid_currency: bool,
        order_currency: bool,
    }

    struct PaymentCoreAssetLanesChanged has copy, drop {
        host_config_id: address,
        actor: address,
        asset_type_bytes: vector<u8>,
        lane_mask: u8,
    }

    fun assert_has_enabled_lane(arg0: bool, arg1: bool, arg2: bool) {
        assert!(lane_mask(arg0, arg1, arg2) > 0, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_invalid_state());
    }

    fun assert_supported_non_sui_order_asset<T0>() {
        assert!(0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::onchain_asset_lane_manager::is_supported_order_typed_non_sui_asset<T0>(), 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_invalid_state());
    }

    fun asset_lane_key<T0>() : PaymentCoreAssetLaneKey {
        PaymentCoreAssetLaneKey{asset_type_bytes: 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::onchain_asset_lane_manager::exact_type_bytes_for<T0>()}
    }

    public fun bid_currency_enabled<T0>(arg0: &0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::escrow::FeeConfig) : bool {
        if (!has_asset_lane_config<T0>(arg0)) {
            return false
        };
        borrow_asset_lane_config<T0>(arg0).bid_currency
    }

    fun borrow_asset_lane_config<T0>(arg0: &0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::escrow::FeeConfig) : &PaymentCoreAssetLaneConfig {
        0x2::dynamic_field::borrow<PaymentCoreAssetLaneKey, PaymentCoreAssetLaneConfig>(0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::escrow::fee_config_uid(arg0), asset_lane_key<T0>())
    }

    fun borrow_asset_lane_config_mut<T0>(arg0: &mut 0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::escrow::FeeConfig) : &mut PaymentCoreAssetLaneConfig {
        0x2::dynamic_field::borrow_mut<PaymentCoreAssetLaneKey, PaymentCoreAssetLaneConfig>(0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::escrow::fee_config_uid_mut(arg0), asset_lane_key<T0>())
    }

    fun disable_asset_lane_config<T0>(arg0: &mut 0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::escrow::FeeConfig) {
        assert_supported_non_sui_order_asset<T0>();
        assert!(has_asset_lane_config<T0>(arg0), 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_invalid_state());
        let v0 = borrow_asset_lane_config_mut<T0>(arg0);
        v0.listing_currency = false;
        v0.bid_currency = false;
        v0.order_currency = false;
    }

    public fun disable_payment_core_asset_lanes<T0>(arg0: &0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::AdminCap, arg1: &0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::GovernanceConfig, arg2: &mut 0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::escrow::FeeConfig, arg3: &mut 0x2::tx_context::TxContext) {
        0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::assert_incident_not_frozen(arg1);
        disable_asset_lane_config<T0>(arg2);
        emit_changed<T0>(arg2, arg3);
    }

    fun emit_changed<T0>(arg0: &0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::escrow::FeeConfig, arg1: &0x2::tx_context::TxContext) {
        let v0 = borrow_asset_lane_config<T0>(arg0);
        let v1 = 0x2::object::id<0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::escrow::FeeConfig>(arg0);
        let v2 = PaymentCoreAssetLanesChanged{
            host_config_id   : 0x2::object::id_to_address(&v1),
            actor            : 0x2::tx_context::sender(arg1),
            asset_type_bytes : 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::onchain_asset_lane_manager::exact_type_bytes_for<T0>(),
            lane_mask        : lane_mask(v0.listing_currency, v0.bid_currency, v0.order_currency),
        };
        0x2::event::emit<PaymentCoreAssetLanesChanged>(v2);
    }

    fun has_asset_lane_config<T0>(arg0: &0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::escrow::FeeConfig) : bool {
        0x2::dynamic_field::exists_<PaymentCoreAssetLaneKey>(0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::escrow::fee_config_uid(arg0), asset_lane_key<T0>())
    }

    public fun has_payment_core_asset_lanes<T0>(arg0: &0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::escrow::FeeConfig) : bool {
        has_asset_lane_config<T0>(arg0)
    }

    fun lane_mask(arg0: bool, arg1: bool, arg2: bool) : u8 {
        let v0 = 0;
        let v1 = v0;
        if (arg0) {
            v1 = v0 + 1;
        };
        if (arg1) {
            v1 = v1 + 2;
        };
        if (arg2) {
            v1 = v1 + 4;
        };
        v1
    }

    public fun listing_currency_enabled<T0>(arg0: &0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::escrow::FeeConfig) : bool {
        if (!has_asset_lane_config<T0>(arg0)) {
            return false
        };
        borrow_asset_lane_config<T0>(arg0).listing_currency
    }

    public fun order_currency_enabled<T0>(arg0: &0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::escrow::FeeConfig) : bool {
        if (!has_asset_lane_config<T0>(arg0)) {
            return false
        };
        borrow_asset_lane_config<T0>(arg0).order_currency
    }

    fun seed_asset_lane_config<T0>(arg0: &mut 0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::escrow::FeeConfig, arg1: bool, arg2: bool, arg3: bool) {
        assert_supported_non_sui_order_asset<T0>();
        assert_has_enabled_lane(arg1, arg2, arg3);
        assert!(!has_asset_lane_config<T0>(arg0), 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_invalid_state());
        let v0 = PaymentCoreAssetLaneConfig{
            listing_currency : arg1,
            bid_currency     : arg2,
            order_currency   : arg3,
        };
        0x2::dynamic_field::add<PaymentCoreAssetLaneKey, PaymentCoreAssetLaneConfig>(0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::escrow::fee_config_uid_mut(arg0), asset_lane_key<T0>(), v0);
    }

    public fun seed_payment_core_asset_lanes<T0>(arg0: &0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::AdminCap, arg1: &0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::GovernanceConfig, arg2: &mut 0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::escrow::FeeConfig, arg3: bool, arg4: bool, arg5: bool, arg6: &mut 0x2::tx_context::TxContext) {
        0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::assert_incident_not_frozen(arg1);
        seed_asset_lane_config<T0>(arg2, arg3, arg4, arg5);
        emit_changed<T0>(arg2, arg6);
    }

    fun set_asset_lane_config<T0>(arg0: &mut 0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::escrow::FeeConfig, arg1: bool, arg2: bool, arg3: bool) {
        assert_supported_non_sui_order_asset<T0>();
        assert_has_enabled_lane(arg1, arg2, arg3);
        assert!(has_asset_lane_config<T0>(arg0), 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_invalid_state());
        let v0 = borrow_asset_lane_config_mut<T0>(arg0);
        v0.listing_currency = arg1;
        v0.bid_currency = arg2;
        v0.order_currency = arg3;
    }

    public fun set_payment_core_asset_lanes<T0>(arg0: &0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::AdminCap, arg1: &0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::GovernanceConfig, arg2: &mut 0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::escrow::FeeConfig, arg3: bool, arg4: bool, arg5: bool, arg6: &mut 0x2::tx_context::TxContext) {
        0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::assert_incident_not_frozen(arg1);
        set_asset_lane_config<T0>(arg2, arg3, arg4, arg5);
        emit_changed<T0>(arg2, arg6);
    }

    public fun typed_order_escrow_create_enabled<T0>(arg0: &0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::escrow::FeeConfig) : bool {
        order_currency_enabled<T0>(arg0)
    }

    // decompiled from Move bytecode v7
}

