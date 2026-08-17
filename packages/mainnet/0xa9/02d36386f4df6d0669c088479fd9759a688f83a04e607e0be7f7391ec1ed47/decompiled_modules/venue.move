module 0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::venue {
    struct VenueControl has copy, drop, store {
        enabled: bool,
        max_deployed_quote: u64,
        max_notional_per_cycle: u64,
        max_slippage_bps: u64,
        deployed_quote: u64,
        cycles: u64,
    }

    struct VenueControls<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        config_id: 0x2::object::ID,
        vault_id: 0x2::object::ID,
        controls: vector<VenueControl>,
        total_deployed_quote: u64,
        max_total_deployed_quote: u64,
        frozen: bool,
    }

    public fun all_venues_mask() : u32 {
        let v0 = 0;
        let v1 = 1;
        while (v1 <= 5) {
            v0 = v0 | venue_mask(v1);
            v1 = v1 + 1;
        };
        v0
    }

    public fun assert_catalog_venue(arg0: u8) {
        assert!(is_catalog_venue(arg0), 0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::errors::venue_unknown());
    }

    public fun assert_controls<T0, T1>(arg0: &VenueControls<T0, T1>, arg1: &0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::vault::Vault<T1>, arg2: &0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::config::LotusConfig) {
        assert!(arg0.vault_id == 0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::vault::id<T1>(arg1), 0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::errors::venue_book_mismatch());
        assert!(arg0.config_id == 0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::config::id(arg2), 0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::errors::venue_book_mismatch());
    }

    public(friend) fun close_position<T0, T1>(arg0: &mut VenueControls<T0, T1>, arg1: u8, arg2: u64) {
        assert_catalog_venue(arg1);
        let v0 = 0x1::vector::borrow_mut<VenueControl>(&mut arg0.controls, ((arg1 - 1) as u64));
        v0.deployed_quote = 0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::math::sub(v0.deployed_quote, 0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::math::min(arg2, v0.deployed_quote));
        v0.cycles = 0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::math::add(v0.cycles, 1);
        arg0.total_deployed_quote = 0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::math::sub(arg0.total_deployed_quote, 0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::math::min(arg2, arg0.total_deployed_quote));
    }

    public fun configure_venue<T0, T1>(arg0: &mut VenueControls<T0, T1>, arg1: &0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::vault::Vault<T1>, arg2: &0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::vault::VaultAdminCap<T1>, arg3: &0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::config::LotusConfig, arg4: u64, arg5: u8, arg6: bool, arg7: u64, arg8: u64, arg9: u64) {
        0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::config::assert_governance_active(arg3, arg4);
        0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::vault::assert_admin<T1>(arg1, arg2);
        assert_controls<T0, T1>(arg0, arg1, arg3);
        assert_catalog_venue(arg5);
        assert!(0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::config::is_venue_allowed(arg3, arg5), 0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::errors::venue_not_allowed());
        if (arg6) {
            assert!(arg7 > 0, 0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::errors::venue_bad_param());
            assert!(arg8 > 0, 0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::errors::venue_bad_param());
        };
        assert!(arg9 <= 0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::config::guard_max_slippage_bps_ceiling(0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::config::price_guard_config(arg3)), 0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::errors::venue_bad_param());
        let v0 = 0x1::vector::borrow_mut<VenueControl>(&mut arg0.controls, ((arg5 - 1) as u64));
        v0.enabled = arg6;
        v0.max_deployed_quote = arg7;
        v0.max_notional_per_cycle = arg8;
        v0.max_slippage_bps = arg9;
        0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::events::emit_venue_configured(arg0.vault_id, arg5, kind_of(arg5), arg6, arg7, arg8, arg9);
    }

    public fun control<T0, T1>(arg0: &VenueControls<T0, T1>, arg1: u8) : VenueControl {
        assert_catalog_venue(arg1);
        *0x1::vector::borrow<VenueControl>(&arg0.controls, ((arg1 - 1) as u64))
    }

    public fun controls_config_id<T0, T1>(arg0: &VenueControls<T0, T1>) : 0x2::object::ID {
        arg0.config_id
    }

    public fun controls_id<T0, T1>(arg0: &VenueControls<T0, T1>) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun controls_vault_id<T0, T1>(arg0: &VenueControls<T0, T1>) : 0x2::object::ID {
        arg0.vault_id
    }

    public fun create_controls<T0, T1>(arg0: &0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::vault::Vault<T1>, arg1: &0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::vault::VaultAdminCap<T1>, arg2: &0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::config::LotusConfig, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        share_controls<T0, T1>(new_controls<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5));
    }

    public fun ctl_cycles(arg0: &VenueControl) : u64 {
        arg0.cycles
    }

    public fun ctl_deployed_quote(arg0: &VenueControl) : u64 {
        arg0.deployed_quote
    }

    public fun ctl_enabled(arg0: &VenueControl) : bool {
        arg0.enabled
    }

    public fun ctl_max_deployed_quote(arg0: &VenueControl) : u64 {
        arg0.max_deployed_quote
    }

    public fun ctl_max_notional_per_cycle(arg0: &VenueControl) : u64 {
        arg0.max_notional_per_cycle
    }

    public fun ctl_max_slippage_bps(arg0: &VenueControl) : u64 {
        arg0.max_slippage_bps
    }

    fun empty_control() : VenueControl {
        VenueControl{
            enabled                : false,
            max_deployed_quote     : 0,
            max_notional_per_cycle : 0,
            max_slippage_bps       : 0,
            deployed_quote         : 0,
            cycles                 : 0,
        }
    }

    public fun is_catalog_venue(arg0: u8) : bool {
        arg0 >= 1 && arg0 <= 5
    }

    public fun is_frozen<T0, T1>(arg0: &VenueControls<T0, T1>) : bool {
        arg0.frozen
    }

    public fun kind_amm() : u8 {
        3
    }

    public fun kind_clmm() : u8 {
        2
    }

    public fun kind_of(arg0: u8) : u8 {
        assert_catalog_venue(arg0);
        if (arg0 == 1) {
            1
        } else if (arg0 == 5) {
            3
        } else {
            2
        }
    }

    public fun kind_orderbook() : u8 {
        1
    }

    public fun max_total_deployed_quote<T0, T1>(arg0: &VenueControls<T0, T1>) : u64 {
        arg0.max_total_deployed_quote
    }

    public fun name_of(arg0: u8) : vector<u8> {
        assert_catalog_venue(arg0);
        if (arg0 == 1) {
            b"deepbook"
        } else if (arg0 == 2) {
            b"cetus"
        } else if (arg0 == 3) {
            b"bluefin"
        } else if (arg0 == 4) {
            b"momentum"
        } else {
            b"aftermath"
        }
    }

    public fun new_controls<T0, T1>(arg0: &0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::vault::Vault<T1>, arg1: &0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::vault::VaultAdminCap<T1>, arg2: &0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::config::LotusConfig, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : VenueControls<T0, T1> {
        0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::config::assert_governance_active(arg2, arg3);
        0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::vault::assert_admin<T1>(arg0, arg1);
        assert!(0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::vault::config_id<T1>(arg0) == 0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::config::id(arg2), 0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::errors::vault_mismatch());
        let v0 = 0x1::vector::empty<VenueControl>();
        let v1 = 0;
        while (v1 < 5) {
            0x1::vector::push_back<VenueControl>(&mut v0, empty_control());
            v1 = v1 + 1;
        };
        VenueControls<T0, T1>{
            id                       : 0x2::object::new(arg5),
            config_id                : 0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::config::id(arg2),
            vault_id                 : 0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::vault::id<T1>(arg0),
            controls                 : v0,
            total_deployed_quote     : 0,
            max_total_deployed_quote : arg4,
            frozen                   : false,
        }
    }

    public(friend) fun open_position<T0, T1>(arg0: &mut VenueControls<T0, T1>, arg1: &0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::config::LotusConfig, arg2: u8, arg3: u64) : (u8, u64) {
        assert!(!arg0.frozen, 0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::errors::venue_book_frozen());
        assert_catalog_venue(arg2);
        assert!(0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::config::is_venue_allowed(arg1, arg2), 0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::errors::venue_not_allowed());
        let v0 = 0x1::vector::borrow_mut<VenueControl>(&mut arg0.controls, ((arg2 - 1) as u64));
        assert!(v0.enabled, 0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::errors::venue_disabled());
        assert!(arg3 <= v0.max_notional_per_cycle, 0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::errors::venue_cap_exceeded());
        let v1 = 0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::math::add(v0.deployed_quote, arg3);
        assert!(v1 <= v0.max_deployed_quote, 0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::errors::venue_cap_exceeded());
        v0.deployed_quote = v1;
        let v2 = v0.max_slippage_bps;
        let v3 = 0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::math::add(arg0.total_deployed_quote, arg3);
        assert!(v3 <= arg0.max_total_deployed_quote, 0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::errors::venue_cap_exceeded());
        arg0.total_deployed_quote = v3;
        (kind_of(arg2), v2)
    }

    public fun set_frozen<T0, T1>(arg0: &mut VenueControls<T0, T1>, arg1: &0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::vault::Vault<T1>, arg2: &0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::vault::VaultAdminCap<T1>, arg3: bool) {
        0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::vault::assert_admin<T1>(arg1, arg2);
        assert!(arg0.vault_id == 0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::vault::id<T1>(arg1), 0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::errors::venue_book_mismatch());
        arg0.frozen = arg3;
        0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::events::emit_venue_book_frozen(arg0.vault_id, 0x2::object::uid_to_inner(&arg0.id), arg3);
    }

    public fun set_max_total_deployed_quote<T0, T1>(arg0: &mut VenueControls<T0, T1>, arg1: &0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::vault::Vault<T1>, arg2: &0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::vault::VaultAdminCap<T1>, arg3: u64) {
        0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::vault::assert_admin<T1>(arg1, arg2);
        assert!(arg0.vault_id == 0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::vault::id<T1>(arg1), 0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::errors::venue_book_mismatch());
        arg0.max_total_deployed_quote = arg3;
    }

    public fun set_venue_enabled<T0, T1>(arg0: &mut VenueControls<T0, T1>, arg1: &0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::vault::Vault<T1>, arg2: &0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::vault::VaultAdminCap<T1>, arg3: u8, arg4: bool) {
        0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::vault::assert_admin<T1>(arg1, arg2);
        assert!(arg0.vault_id == 0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::vault::id<T1>(arg1), 0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::errors::venue_book_mismatch());
        assert_catalog_venue(arg3);
        let v0 = 0x1::vector::borrow_mut<VenueControl>(&mut arg0.controls, ((arg3 - 1) as u64));
        v0.enabled = arg4;
        0xa902d36386f4df6d0669c088479fd9759a688f83a04e607e0be7f7391ec1ed47::events::emit_venue_configured(arg0.vault_id, arg3, kind_of(arg3), arg4, v0.max_deployed_quote, v0.max_notional_per_cycle, v0.max_slippage_bps);
    }

    public fun share_controls<T0, T1>(arg0: VenueControls<T0, T1>) {
        0x2::transfer::share_object<VenueControls<T0, T1>>(arg0);
    }

    public fun total_deployed_quote<T0, T1>(arg0: &VenueControls<T0, T1>) : u64 {
        arg0.total_deployed_quote
    }

    public fun venue_aftermath() : u8 {
        5
    }

    public fun venue_bluefin() : u8 {
        3
    }

    public fun venue_cetus() : u8 {
        2
    }

    public fun venue_count() : u8 {
        5
    }

    public fun venue_deepbook() : u8 {
        1
    }

    public fun venue_mask(arg0: u8) : u32 {
        assert_catalog_venue(arg0);
        1 << arg0 - 1
    }

    public fun venue_momentum() : u8 {
        4
    }

    // decompiled from Move bytecode v7
}

