module 0xd2197b1ce2096e96e726c29fa2c138c5c6748da169b81d34927c522b7499f1d7::ika_chan_key_wallet {
    struct IKA_CHAN_KEY_WALLET has drop {
        dummy_field: bool,
    }

    struct KeyWallet has store {
        balance: u64,
    }

    fun assert_amount_lte_balance(arg0: &KeyWallet, arg1: u64) {
        assert!(arg1 <= arg0.balance, 0);
    }

    public fun balance(arg0: &KeyWallet) : u64 {
        arg0.balance
    }

    public(friend) fun increase_key_balance(arg0: &mut KeyWallet, arg1: u64) {
        arg0.balance = arg0.balance + arg1;
    }

    public(friend) fun mint_keys_from_balance(arg0: &mut KeyWallet, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: &0x2::transfer_policy::TransferPolicy<0xd2197b1ce2096e96e726c29fa2c138c5c6748da169b81d34927c522b7499f1d7::squid_key::SquidKey>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert_amount_lte_balance(arg0, arg4);
        while (arg4 > 0) {
            0x2::kiosk::lock<0xd2197b1ce2096e96e726c29fa2c138c5c6748da169b81d34927c522b7499f1d7::squid_key::SquidKey>(arg1, arg2, arg3, 0xd2197b1ce2096e96e726c29fa2c138c5c6748da169b81d34927c522b7499f1d7::squid_key::new(arg5));
            arg4 = arg4 - 1;
        };
        arg0.balance = arg0.balance - arg4;
    }

    public(friend) fun new_key_wallet() : KeyWallet {
        KeyWallet{balance: 0}
    }

    // decompiled from Move bytecode v6
}

