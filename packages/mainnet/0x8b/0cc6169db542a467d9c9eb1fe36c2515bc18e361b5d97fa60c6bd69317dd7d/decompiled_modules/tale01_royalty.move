module 0x8b0cc6169db542a467d9c9eb1fe36c2515bc18e361b5d97fa60c6bd69317dd7d::tale01_royalty {
    struct Rule has drop, store {
        dummy_field: bool,
    }

    struct Config has drop, store {
        amount_bp: u16,
        recipient: address,
        min_amount: u64,
    }

    public fun add<T0: store + key>(arg0: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg1: &0x2::transfer_policy::TransferPolicyCap<T0>, arg2: u16, arg3: address, arg4: u64) {
        assert!(arg2 <= 10000, 1);
        let v0 = Rule{dummy_field: false};
        let v1 = Config{
            amount_bp  : arg2,
            recipient  : arg3,
            min_amount : arg4,
        };
        0x2::transfer_policy::add_rule<T0, Rule, Config>(v0, arg0, arg1, v1);
    }

    public fun amount_bp(arg0: &Config) : u16 {
        arg0.amount_bp
    }

    public fun get_config<T0: store + key>(arg0: &0x2::transfer_policy::TransferPolicy<T0>) : &Config {
        let v0 = Rule{dummy_field: false};
        0x2::transfer_policy::get_rule<T0, Rule, Config>(v0, arg0)
    }

    public fun min_amount(arg0: &Config) : u64 {
        arg0.min_amount
    }

    public fun pay<T0: store + key>(arg0: &mut 0x2::tx_context::TxContext, arg1: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg2: &mut Config, arg3: &mut 0x2::balance::Balance<0x2::sui::SUI>, arg4: &mut 0x2::kiosk::Kiosk, arg5: &mut 0x2::kiosk::Kiosk) {
        if (0x2::balance::value<0x2::sui::SUI>(arg3) == 0) {
            return
        };
        let v0 = royalty_amount(0x2::balance::value<0x2::sui::SUI>(arg3), arg2.amount_bp, arg2.min_amount);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(arg3, v0), arg0), arg2.recipient);
        };
    }

    public fun recipient(arg0: &Config) : address {
        arg0.recipient
    }

    public fun royalty_amount(arg0: u64, arg1: u16, arg2: u64) : u64 {
        let v0 = arg0 * (arg1 as u64) / (10000 as u64);
        if (v0 < arg2) {
            arg2
        } else {
            v0
        }
    }

    public fun update<T0: store + key>(arg0: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg1: &0x2::transfer_policy::TransferPolicyCap<T0>, arg2: u16, arg3: address, arg4: u64) {
        assert!(arg2 <= 10000, 1);
        if (0x2::transfer_policy::has_rule<T0, Rule>(arg0)) {
            0x2::transfer_policy::remove_rule<T0, Rule, Config>(arg0, arg1);
        };
        let v0 = Rule{dummy_field: false};
        let v1 = Config{
            amount_bp  : arg2,
            recipient  : arg3,
            min_amount : arg4,
        };
        0x2::transfer_policy::add_rule<T0, Rule, Config>(v0, arg0, arg1, v1);
    }

    // decompiled from Move bytecode v7
}

