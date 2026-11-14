module 0x49d525986b52160298166c58009937c1d63f361c298579cd061e8d778e410532::version_demo {
    struct Vault has store, key {
        id: 0x2::object::UID,
        version: u64,
        reserve: 0x2::balance::Balance<0x2::sui::SUI>,
        total_shares: u64,
    }

    public fun deposit_legacy_safe(arg0: &mut Vault, arg1: 0x2::coin::Coin<0x2::sui::SUI>) : u64 {
        assert!(arg0.version == 1, 1);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.reserve, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        arg0.total_shares = arg0.total_shares + v0;
        v0
    }

    public fun deposit_legacy_vuln(arg0: &mut Vault, arg1: 0x2::coin::Coin<0x2::sui::SUI>) : u64 {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.reserve, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        arg0.total_shares = arg0.total_shares + v0;
        v0
    }

    public fun new_vault(arg0: u64, arg1: 0x2::balance::Balance<0x2::sui::SUI>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : Vault {
        Vault{
            id           : 0x2::object::new(arg3),
            version      : arg0,
            reserve      : arg1,
            total_shares : arg2,
        }
    }

    public fun redeem(arg0: &mut Vault, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(arg0.version == 2, 1);
        arg0.total_shares = arg0.total_shares - arg1;
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.reserve, arg1 * 0x2::balance::value<0x2::sui::SUI>(&arg0.reserve) / arg0.total_shares), arg2)
    }

    public fun reserve_value(arg0: &Vault) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.reserve)
    }

    // decompiled from Move bytecode v7
}

