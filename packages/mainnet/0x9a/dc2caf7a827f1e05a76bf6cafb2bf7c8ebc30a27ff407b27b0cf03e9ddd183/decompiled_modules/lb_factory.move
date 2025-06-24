module 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::lb_factory {
    struct LBPairCreated has copy, drop {
        token_x: 0x1::type_name::TypeName,
        token_y: 0x1::type_name::TypeName,
        bin_step: u16,
        pair: 0x2::object::ID,
        pid: u64,
    }

    struct PresetSet has copy, drop {
        bin_step: u16,
        base_factor: u16,
        filter_period: u16,
        decay_period: u16,
        reduction_factor: u16,
        variable_fee_control: u32,
        protocol_share: u16,
        max_volatility_accumulator: u32,
    }

    struct PresetOpenStateChanged has copy, drop {
        bin_step: u16,
        is_open: bool,
    }

    struct PresetRemoved has copy, drop {
        bin_step: u16,
    }

    struct FeeRecipientSet has copy, drop {
        old_recipient: address,
        new_recipient: address,
    }

    struct FlashLoanFeeSet has copy, drop {
        old_flash_loan_fee: u256,
        new_flash_loan_fee: u256,
    }

    struct QuoteAssetAdded has copy, drop {
        quote_asset: 0x1::type_name::TypeName,
    }

    struct QuoteAssetRemoved has copy, drop {
        quote_asset: 0x1::type_name::TypeName,
    }

    struct LBPairIgnoredStateChanged has copy, drop {
        pair: 0x2::object::ID,
        ignored: bool,
    }

    struct LBPairInformation has copy, drop, store {
        bin_step: u16,
        pair_id: 0x2::object::ID,
        created_by_owner: bool,
        ignored_for_routing: bool,
    }

    struct Preset has copy, drop, store {
        base_factor: u16,
        filter_period: u16,
        decay_period: u16,
        reduction_factor: u16,
        variable_fee_control: u32,
        protocol_share: u16,
        max_volatility_accumulator: u32,
        is_open: bool,
    }

    struct PairKey has copy, drop, store {
        token_x: 0x1::type_name::TypeName,
        token_y: 0x1::type_name::TypeName,
        bin_step: u16,
    }

    struct LBPairWrapper<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        pair: 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::lb_pair::LBPair<T0, T1>,
    }

    struct LBFactory has key {
        id: 0x2::object::UID,
        owner: address,
        fee_recipient: address,
        flash_loan_fee: u256,
        all_lb_pairs: vector<0x2::object::ID>,
        lb_pairs_info: 0x2::table::Table<PairKey, LBPairInformation>,
        available_bin_steps: 0x2::table::Table<PairKey, vector<u16>>,
        presets: 0x2::table::Table<u16, Preset>,
        all_bin_steps: vector<u16>,
        quote_asset_whitelist: vector<0x1::type_name::TypeName>,
    }

    public fun new(arg0: address, arg1: address, arg2: u256, arg3: &mut 0x2::tx_context::TxContext) : LBFactory {
        assert!(arg2 <= 100000000000000000, 3007);
        assert!(arg1 != @0x0, 3003);
        let v0 = LBFactory{
            id                    : 0x2::object::new(arg3),
            owner                 : arg0,
            fee_recipient         : arg1,
            flash_loan_fee        : arg2,
            all_lb_pairs          : 0x1::vector::empty<0x2::object::ID>(),
            lb_pairs_info         : 0x2::table::new<PairKey, LBPairInformation>(arg3),
            available_bin_steps   : 0x2::table::new<PairKey, vector<u16>>(arg3),
            presets               : 0x2::table::new<u16, Preset>(arg3),
            all_bin_steps         : 0x1::vector::empty<u16>(),
            quote_asset_whitelist : 0x1::vector::empty<0x1::type_name::TypeName>(),
        };
        let v1 = FeeRecipientSet{
            old_recipient : @0x0,
            new_recipient : arg1,
        };
        0x2::event::emit<FeeRecipientSet>(v1);
        let v2 = FlashLoanFeeSet{
            old_flash_loan_fee : 0,
            new_flash_loan_fee : arg2,
        };
        0x2::event::emit<FlashLoanFeeSet>(v2);
        v0
    }

    public fun add_quote_asset<T0>(arg0: &mut LBFactory, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 3021);
        let v0 = 0x1::type_name::get<T0>();
        assert!(!0x1::vector::contains<0x1::type_name::TypeName>(&arg0.quote_asset_whitelist, &v0), 3002);
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg0.quote_asset_whitelist, v0);
        let v1 = QuoteAssetAdded{quote_asset: v0};
        0x2::event::emit<QuoteAssetAdded>(v1);
    }

    fun compare_type_names(arg0: &0x1::type_name::TypeName, arg1: &0x1::type_name::TypeName) : bool {
        let v0 = 0x1::type_name::into_string(*arg0);
        let v1 = 0x1::type_name::into_string(*arg1);
        let v2 = 0x1::ascii::as_bytes(&v0);
        let v3 = 0x1::ascii::as_bytes(&v1);
        let v4 = 0x1::vector::length<u8>(v2);
        let v5 = 0x1::vector::length<u8>(v3);
        let v6 = if (v4 < v5) {
            v4
        } else {
            v5
        };
        let v7 = 0;
        while (v7 < v6) {
            let v8 = *0x1::vector::borrow<u8>(v2, v7);
            let v9 = *0x1::vector::borrow<u8>(v3, v7);
            if (v8 < v9) {
                return true
            };
            if (v8 > v9) {
                return false
            };
            v7 = v7 + 1;
        };
        v4 < v5
    }

    public fun create_lb_pair<T0, T1>(arg0: &mut LBFactory, arg1: u32, arg2: u16, arg3: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x1::type_name::get<T1>();
        assert!(v0 != v1, 3000);
        assert!(is_quote_asset(arg0, v1), 3001);
        assert!(0x2::table::contains<u16, Preset>(&arg0.presets, arg2), 3011);
        let v2 = 0x2::table::borrow<u16, Preset>(&arg0.presets, arg2);
        let v3 = 0x2::tx_context::sender(arg3) == arg0.owner;
        if (!v2.is_open && !v3) {
            abort 3009
        };
        0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::price_helper::get_price_from_id(arg1, arg2);
        let v4 = create_pair_key(v0, v1, arg2);
        assert!(!0x2::table::contains<PairKey, LBPairInformation>(&arg0.lb_pairs_info, v4), 3004);
        let v5 = 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::lb_pair::create_pair<T0, T1>(type_name_to_bytes(v0), type_name_to_bytes(v1), arg2, arg3);
        0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::lb_pair::initialize<T0, T1>(&mut v5, v2.base_factor, v2.filter_period, v2.decay_period, v2.reduction_factor, v2.variable_fee_control, v2.protocol_share, v2.max_volatility_accumulator, arg1, arg3);
        let v6 = LBPairWrapper<T0, T1>{
            id   : 0x2::object::new(arg3),
            pair : v5,
        };
        let v7 = 0x2::object::id<LBPairWrapper<T0, T1>>(&v6);
        let v8 = LBPairInformation{
            bin_step            : arg2,
            pair_id             : v7,
            created_by_owner    : v3,
            ignored_for_routing : false,
        };
        0x2::table::add<PairKey, LBPairInformation>(&mut arg0.lb_pairs_info, v4, v8);
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.all_lb_pairs, v7);
        update_available_bin_steps(arg0, v0, v1, arg2);
        let v9 = LBPairCreated{
            token_x  : v0,
            token_y  : v1,
            bin_step : arg2,
            pair     : v7,
            pid      : 0x1::vector::length<0x2::object::ID>(&arg0.all_lb_pairs) - 1,
        };
        0x2::event::emit<LBPairCreated>(v9);
        0x2::transfer::public_share_object<LBPairWrapper<T0, T1>>(v6);
        v7
    }

    fun create_pair_key(arg0: 0x1::type_name::TypeName, arg1: 0x1::type_name::TypeName, arg2: u16) : PairKey {
        let (v0, v1) = if (compare_type_names(&arg0, &arg1)) {
            (arg0, arg1)
        } else {
            (arg1, arg0)
        };
        PairKey{
            token_x  : v0,
            token_y  : v1,
            bin_step : arg2,
        }
    }

    fun create_pair_key_no_bin_step(arg0: 0x1::type_name::TypeName, arg1: 0x1::type_name::TypeName) : PairKey {
        create_pair_key(arg0, arg1, 0)
    }

    public fun get_all_bin_steps(arg0: &LBFactory) : vector<u16> {
        arg0.all_bin_steps
    }

    public fun get_all_lb_pairs<T0, T1>(arg0: &LBFactory) : vector<LBPairInformation> {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x1::type_name::get<T1>();
        let v2 = 0x1::vector::empty<LBPairInformation>();
        let v3 = create_pair_key_no_bin_step(v0, v1);
        if (0x2::table::contains<PairKey, vector<u16>>(&arg0.available_bin_steps, v3)) {
            let v4 = 0x2::table::borrow<PairKey, vector<u16>>(&arg0.available_bin_steps, v3);
            let v5 = 0;
            while (v5 < 0x1::vector::length<u16>(v4)) {
                let v6 = create_pair_key(v0, v1, *0x1::vector::borrow<u16>(v4, v5));
                if (0x2::table::contains<PairKey, LBPairInformation>(&arg0.lb_pairs_info, v6)) {
                    0x1::vector::push_back<LBPairInformation>(&mut v2, *0x2::table::borrow<PairKey, LBPairInformation>(&arg0.lb_pairs_info, v6));
                };
                v5 = v5 + 1;
            };
        };
        v2
    }

    public fun get_available_lb_pair_bin_steps<T0, T1>(arg0: &LBFactory) : vector<u16> {
        let v0 = create_pair_key_no_bin_step(0x1::type_name::get<T0>(), 0x1::type_name::get<T1>());
        if (0x2::table::contains<PairKey, vector<u16>>(&arg0.available_bin_steps, v0)) {
            *0x2::table::borrow<PairKey, vector<u16>>(&arg0.available_bin_steps, v0)
        } else {
            0x1::vector::empty<u16>()
        }
    }

    public fun get_fee_recipient(arg0: &LBFactory) : address {
        arg0.fee_recipient
    }

    public fun get_flash_loan_fee(arg0: &LBFactory) : u256 {
        arg0.flash_loan_fee
    }

    public fun get_lb_pair<T0, T1>(arg0: &LBPairWrapper<T0, T1>) : &0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::lb_pair::LBPair<T0, T1> {
        &arg0.pair
    }

    public fun get_lb_pair_id_at_index(arg0: &LBFactory, arg1: u64) : 0x2::object::ID {
        *0x1::vector::borrow<0x2::object::ID>(&arg0.all_lb_pairs, arg1)
    }

    public fun get_lb_pair_information<T0, T1>(arg0: &LBFactory, arg1: u16) : LBPairInformation {
        let v0 = create_pair_key(0x1::type_name::get<T0>(), 0x1::type_name::get<T1>(), arg1);
        if (0x2::table::contains<PairKey, LBPairInformation>(&arg0.lb_pairs_info, v0)) {
            *0x2::table::borrow<PairKey, LBPairInformation>(&arg0.lb_pairs_info, v0)
        } else {
            LBPairInformation{bin_step: 0, pair_id: 0x2::object::id_from_address(@0x0), created_by_owner: false, ignored_for_routing: false}
        }
    }

    public fun get_lb_pair_mut<T0, T1>(arg0: &mut LBPairWrapper<T0, T1>) : &mut 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::lb_pair::LBPair<T0, T1> {
        &mut arg0.pair
    }

    public fun get_max_flash_loan_fee() : u256 {
        100000000000000000
    }

    public fun get_min_bin_step() : u16 {
        1
    }

    public fun get_number_of_lb_pairs(arg0: &LBFactory) : u64 {
        0x1::vector::length<0x2::object::ID>(&arg0.all_lb_pairs)
    }

    public fun get_number_of_quote_assets(arg0: &LBFactory) : u64 {
        0x1::vector::length<0x1::type_name::TypeName>(&arg0.quote_asset_whitelist)
    }

    public fun get_open_bin_steps(arg0: &LBFactory) : vector<u16> {
        let v0 = 0x1::vector::empty<u16>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<u16>(&arg0.all_bin_steps)) {
            let v2 = *0x1::vector::borrow<u16>(&arg0.all_bin_steps, v1);
            if (0x2::table::contains<u16, Preset>(&arg0.presets, v2)) {
                if (0x2::table::borrow<u16, Preset>(&arg0.presets, v2).is_open) {
                    0x1::vector::push_back<u16>(&mut v0, v2);
                };
            };
            v1 = v1 + 1;
        };
        v0
    }

    public fun get_owner(arg0: &LBFactory) : address {
        arg0.owner
    }

    public fun get_pair_info_bin_step(arg0: &LBPairInformation) : u16 {
        arg0.bin_step
    }

    public fun get_pair_info_id(arg0: &LBPairInformation) : 0x2::object::ID {
        arg0.pair_id
    }

    public fun get_preset(arg0: &LBFactory, arg1: u16) : (u16, u16, u16, u16, u32, u16, u32, bool) {
        assert!(0x2::table::contains<u16, Preset>(&arg0.presets, arg1), 3011);
        let v0 = 0x2::table::borrow<u16, Preset>(&arg0.presets, arg1);
        (v0.base_factor, v0.filter_period, v0.decay_period, v0.reduction_factor, v0.variable_fee_control, v0.protocol_share, v0.max_volatility_accumulator, v0.is_open)
    }

    public fun get_quote_asset_at_index(arg0: &LBFactory, arg1: u64) : 0x1::type_name::TypeName {
        *0x1::vector::borrow<0x1::type_name::TypeName>(&arg0.quote_asset_whitelist, arg1)
    }

    public fun is_pair_created_by_owner(arg0: &LBPairInformation) : bool {
        arg0.created_by_owner
    }

    public fun is_pair_ignored(arg0: &LBPairInformation) : bool {
        arg0.ignored_for_routing
    }

    public fun is_quote_asset(arg0: &LBFactory, arg1: 0x1::type_name::TypeName) : bool {
        0x1::vector::contains<0x1::type_name::TypeName>(&arg0.quote_asset_whitelist, &arg1)
    }

    public fun remove_preset(arg0: &mut LBFactory, arg1: u16, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 3021);
        assert!(0x2::table::contains<u16, Preset>(&arg0.presets, arg1), 3011);
        0x2::table::remove<u16, Preset>(&mut arg0.presets, arg1);
        let (v0, v1) = 0x1::vector::index_of<u16>(&arg0.all_bin_steps, &arg1);
        if (v0) {
            0x1::vector::remove<u16>(&mut arg0.all_bin_steps, v1);
        };
        let v2 = PresetRemoved{bin_step: arg1};
        0x2::event::emit<PresetRemoved>(v2);
    }

    public fun remove_quote_asset<T0>(arg0: &mut LBFactory, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 3021);
        let v0 = 0x1::type_name::get<T0>();
        let (v1, v2) = 0x1::vector::index_of<0x1::type_name::TypeName>(&arg0.quote_asset_whitelist, &v0);
        assert!(v1, 3001);
        0x1::vector::remove<0x1::type_name::TypeName>(&mut arg0.quote_asset_whitelist, v2);
        let v3 = QuoteAssetRemoved{quote_asset: v0};
        0x2::event::emit<QuoteAssetRemoved>(v3);
    }

    public fun set_fee_recipient(arg0: &mut LBFactory, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 3021);
        assert!(arg1 != @0x0, 3003);
        assert!(arg1 != arg0.fee_recipient, 3013);
        arg0.fee_recipient = arg1;
        let v0 = FeeRecipientSet{
            old_recipient : arg0.fee_recipient,
            new_recipient : arg1,
        };
        0x2::event::emit<FeeRecipientSet>(v0);
    }

    public fun set_flash_loan_fee(arg0: &mut LBFactory, arg1: u256, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 3021);
        assert!(arg1 != arg0.flash_loan_fee, 3014);
        assert!(arg1 <= 100000000000000000, 3007);
        arg0.flash_loan_fee = arg1;
        let v0 = FlashLoanFeeSet{
            old_flash_loan_fee : arg0.flash_loan_fee,
            new_flash_loan_fee : arg1,
        };
        0x2::event::emit<FlashLoanFeeSet>(v0);
    }

    public fun set_lb_pair_ignored<T0, T1>(arg0: &mut LBFactory, arg1: u16, arg2: bool, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 3021);
        let v0 = create_pair_key(0x1::type_name::get<T0>(), 0x1::type_name::get<T1>(), arg1);
        assert!(0x2::table::contains<PairKey, LBPairInformation>(&arg0.lb_pairs_info, v0), 3005);
        let v1 = 0x2::table::borrow_mut<PairKey, LBPairInformation>(&mut arg0.lb_pairs_info, v0);
        assert!(v1.ignored_for_routing != arg2, 3010);
        v1.ignored_for_routing = arg2;
        let v2 = LBPairIgnoredStateChanged{
            pair    : v1.pair_id,
            ignored : arg2,
        };
        0x2::event::emit<LBPairIgnoredStateChanged>(v2);
    }

    public fun set_preset(arg0: &mut LBFactory, arg1: u16, arg2: u16, arg3: u16, arg4: u16, arg5: u16, arg6: u32, arg7: u16, arg8: u32, arg9: bool, arg10: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg10) == arg0.owner, 3021);
        assert!(arg1 >= 1, 3008);
        let v0 = Preset{
            base_factor                : arg2,
            filter_period              : arg3,
            decay_period               : arg4,
            reduction_factor           : arg5,
            variable_fee_control       : arg6,
            protocol_share             : arg7,
            max_volatility_accumulator : arg8,
            is_open                    : arg9,
        };
        if (0x2::table::contains<u16, Preset>(&arg0.presets, arg1)) {
            *0x2::table::borrow_mut<u16, Preset>(&mut arg0.presets, arg1) = v0;
        } else {
            0x2::table::add<u16, Preset>(&mut arg0.presets, arg1, v0);
            0x1::vector::push_back<u16>(&mut arg0.all_bin_steps, arg1);
        };
        let v1 = PresetSet{
            bin_step                   : arg1,
            base_factor                : arg2,
            filter_period              : arg3,
            decay_period               : arg4,
            reduction_factor           : arg5,
            variable_fee_control       : arg6,
            protocol_share             : arg7,
            max_volatility_accumulator : arg8,
        };
        0x2::event::emit<PresetSet>(v1);
        let v2 = PresetOpenStateChanged{
            bin_step : arg1,
            is_open  : arg9,
        };
        0x2::event::emit<PresetOpenStateChanged>(v2);
    }

    public fun set_preset_open_state(arg0: &mut LBFactory, arg1: u16, arg2: bool, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 3021);
        assert!(0x2::table::contains<u16, Preset>(&arg0.presets, arg1), 3011);
        let v0 = 0x2::table::borrow_mut<u16, Preset>(&mut arg0.presets, arg1);
        assert!(v0.is_open != arg2, 3012);
        v0.is_open = arg2;
        let v1 = PresetOpenStateChanged{
            bin_step : arg1,
            is_open  : arg2,
        };
        0x2::event::emit<PresetOpenStateChanged>(v1);
    }

    public fun share(arg0: LBFactory) {
        0x2::transfer::share_object<LBFactory>(arg0);
    }

    fun type_name_to_bytes(arg0: 0x1::type_name::TypeName) : vector<u8> {
        0x1::ascii::into_bytes(0x1::type_name::into_string(arg0))
    }

    fun update_available_bin_steps(arg0: &mut LBFactory, arg1: 0x1::type_name::TypeName, arg2: 0x1::type_name::TypeName, arg3: u16) {
        let v0 = create_pair_key_no_bin_step(arg1, arg2);
        if (!0x2::table::contains<PairKey, vector<u16>>(&arg0.available_bin_steps, v0)) {
            0x2::table::add<PairKey, vector<u16>>(&mut arg0.available_bin_steps, v0, 0x1::vector::empty<u16>());
        };
        let v1 = 0x2::table::borrow_mut<PairKey, vector<u16>>(&mut arg0.available_bin_steps, v0);
        if (!0x1::vector::contains<u16>(v1, &arg3)) {
            0x1::vector::push_back<u16>(v1, arg3);
        };
    }

    // decompiled from Move bytecode v6
}

