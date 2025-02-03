module 0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::vault {
    struct Vault<phantom T0: store + key, phantom T1> has store {
        ft_balance: 0x2::balance::Balance<T1>,
        kiosk: 0x2::kiosk::Kiosk,
        kiosk_cap: 0x2::kiosk::KioskOwnerCap,
    }

    public fun balance<T0: store + key, T1>(arg0: &Vault<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.ft_balance)
    }

    public fun has_item<T0: store + key, T1>(arg0: &Vault<T0, T1>, arg1: 0x2::object::ID) : bool {
        0x2::kiosk::has_item(&arg0.kiosk, arg1)
    }

    public fun new<T0: store + key, T1>(arg0: &mut 0x2::tx_context::TxContext) : Vault<T0, T1> {
        let (v0, v1) = 0x2::kiosk::new(arg0);
        Vault<T0, T1>{
            ft_balance : 0x2::balance::zero<T1>(),
            kiosk      : v0,
            kiosk_cap  : v1,
        }
    }

    public(friend) fun deposit_ft<T0: store + key, T1>(arg0: &mut Vault<T0, T1>, arg1: 0x2::balance::Balance<T1>) {
        0x2::balance::join<T1>(&mut arg0.ft_balance, arg1);
    }

    public(friend) fun deposit_nft<T0: store + key, T1>(arg0: &mut Vault<T0, T1>, arg1: T0) {
        0x2::kiosk::place<T0>(&mut arg0.kiosk, &arg0.kiosk_cap, arg1);
    }

    public(friend) fun withdraw_ft<T0: store + key, T1>(arg0: &mut Vault<T0, T1>, arg1: u64) : 0x2::balance::Balance<T1> {
        if (0x2::balance::value<T1>(&arg0.ft_balance) < arg1) {
            abort 0
        };
        0x2::balance::split<T1>(&mut arg0.ft_balance, arg1)
    }

    public(friend) fun withdraw_nft<T0: store + key, T1>(arg0: &mut Vault<T0, T1>, arg1: 0x2::object::ID) : T0 {
        0x2::kiosk::take<T0>(&mut arg0.kiosk, &arg0.kiosk_cap, arg1)
    }

    // decompiled from Move bytecode v6
}

