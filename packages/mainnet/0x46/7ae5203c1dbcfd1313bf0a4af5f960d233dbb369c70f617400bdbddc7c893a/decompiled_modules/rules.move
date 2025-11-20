module 0x467ae5203c1dbcfd1313bf0a4af5f960d233dbb369c70f617400bdbddc7c893a::rules {
    struct RULES has drop {
        dummy_field: bool,
    }

    struct RoyaltyConfig has drop, store {
        basis_points: u16,
        min_amount: u64,
    }

    public fun add_kiosk_lock_rule<T0: store + key>(arg0: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg1: &0x2::transfer_policy::TransferPolicyCap<T0>) {
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::add<T0>(arg0, arg1);
    }

    public fun add_personal_kiosk_rule<T0: store + key>(arg0: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg1: &0x2::transfer_policy::TransferPolicyCap<T0>) {
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk_rule::add<T0>(arg0, arg1);
    }

    public fun add_royalty_rule<T0: store + key>(arg0: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg1: &0x2::transfer_policy::TransferPolicyCap<T0>, arg2: RoyaltyConfig) {
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::add<T0>(arg0, arg1, arg2.basis_points, arg2.min_amount);
    }

    public fun get_royalty_fee_amount<T0: store + key>(arg0: &0x2::transfer_policy::TransferPolicy<T0>, arg1: u64) : u64 {
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::fee_amount<T0>(arg0, arg1)
    }

    public fun new_royalty_config(arg0: u16, arg1: u64) : RoyaltyConfig {
        RoyaltyConfig{
            basis_points : arg0,
            min_amount   : arg1,
        }
    }

    public fun pay_royalty_rule<T0: store + key>(arg0: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg1: &mut 0x2::transfer_policy::TransferRequest<T0>, arg2: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::pay<T0>(arg0, arg1, arg2);
    }

    public fun prove_kiosk_lock_rule<T0: store + key>(arg0: &mut 0x2::transfer_policy::TransferRequest<T0>, arg1: &0x2::kiosk::Kiosk) {
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::prove<T0>(arg0, arg1);
    }

    public fun prove_personal_kiosk_rule<T0: store + key>(arg0: &0x2::kiosk::Kiosk, arg1: &mut 0x2::transfer_policy::TransferRequest<T0>) {
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk_rule::prove<T0>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

