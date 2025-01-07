module 0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::default_config {
    struct DefaultConfig has key {
        id: 0x2::object::UID,
        uc_total_min: u64,
        uc_total_max: u64,
        uc_threshold: u64,
        uc_below_threshold_percent: u64,
        uc_above_threshold_percent: u64,
        stable_total_min: u64,
        stable_total_max: u64,
        stable_flat_percent: u64,
    }

    public fun fee(arg0: &DefaultConfig, arg1: bool, arg2: u64) : (u64, u64) {
        if (arg1) {
            assert!(arg2 <= arg0.stable_total_max && arg2 >= arg0.stable_total_min, 0);
            let v2 = 0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::safe_math::safe_mul_div_u64(arg0.stable_flat_percent, arg2, 0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::constants::fee_percent_scalling());
            (arg2 - v2, v2)
        } else {
            assert!(arg2 <= arg0.uc_total_max && arg2 >= arg0.uc_total_min, 0);
            let v3 = if (arg2 > arg0.uc_threshold) {
                arg0.uc_above_threshold_percent
            } else {
                arg0.uc_below_threshold_percent
            };
            let v4 = 0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::safe_math::safe_mul_div_u64(v3, arg2, 0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::constants::fee_percent_scalling());
            (arg2 - v4, v4)
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = DefaultConfig{
            id                         : 0x2::object::new(arg0),
            uc_total_min               : 3000,
            uc_total_max               : 100000,
            uc_threshold               : 50000,
            uc_below_threshold_percent : 330000,
            uc_above_threshold_percent : 100000,
            stable_total_min           : 200,
            stable_total_max           : 1000,
            stable_flat_percent        : 330000,
        };
        0x2::transfer::share_object<DefaultConfig>(v0);
    }

    public(friend) fun set_stable_fees(arg0: &mut DefaultConfig, arg1: u64, arg2: u64, arg3: u64, arg4: &0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::admin_access::AdminAccess) {
        assert!(arg1 <= (0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::constants::fee_scalling() as u64), 0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::error::feeInvalid());
        assert!(arg2 <= (0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::constants::fee_scalling() as u64), 0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::error::feeInvalid());
        assert!(arg3 <= (0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::constants::fee_percent_scalling() as u64), 0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::error::feeInvalid());
        arg0.stable_total_min = arg1;
        arg0.stable_total_max = arg2;
        arg0.stable_flat_percent = arg3;
    }

    public(friend) fun set_uc_fees(arg0: &mut DefaultConfig, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::admin_access::AdminAccess) {
        assert!(arg1 <= (0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::constants::fee_scalling() as u64), 0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::error::feeInvalid());
        assert!(arg2 <= (0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::constants::fee_scalling() as u64), 0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::error::feeInvalid());
        assert!(arg3 <= (0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::constants::fee_scalling() as u64), 0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::error::feeInvalid());
        assert!(arg4 <= (0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::constants::fee_percent_scalling() as u64), 0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::error::feeInvalid());
        assert!(arg5 <= (0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::constants::fee_percent_scalling() as u64), 0x38e00fa2bc03c512a695fc12d0593fde43ae316413a6b5499ab15deb22b7ad3a::error::feeInvalid());
        arg0.uc_total_min = arg1;
        arg0.uc_total_max = arg2;
        arg0.uc_threshold = arg3;
        arg0.uc_below_threshold_percent = arg4;
        arg0.uc_above_threshold_percent = arg5;
    }

    // decompiled from Move bytecode v6
}

