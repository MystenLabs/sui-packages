module 0x4a376d670f6b717167c1df4b46bd950dc416391b66b937aff0d1668a2d83076d::lendit {
    struct LENDIT has drop {
        dummy_field: bool,
    }

    struct TreasuryCapHolder<phantom T0> has store, key {
        id: 0x2::object::UID,
        treasury: 0x2::coin::TreasuryCap<LENDIT>,
    }

    struct AccountCapHolder has store, key {
        id: 0x2::object::UID,
        account_cap: 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap,
    }

    struct ObligationOwnerCapHolder<phantom T0> has store, key {
        id: 0x2::object::UID,
        obligation: 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0>,
    }

    struct Reserve<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        availible_balance: 0x2::coin::Coin<T1>,
    }

    fun convert_to_assets(arg0: &TreasuryCapHolder<LENDIT>, arg1: u64, arg2: u64) : u64 {
        let v0 = 0x2::coin::total_supply<LENDIT>(&arg0.treasury);
        if (v0 == 0) {
            return arg1
        };
        arg1 * arg2 / v0
    }

    fun convert_to_shares(arg0: &TreasuryCapHolder<LENDIT>, arg1: u64, arg2: u64) : u64 {
        if (arg2 == 0) {
            return arg1
        };
        arg1 * 0x2::coin::total_supply<LENDIT>(&arg0.treasury) / arg2
    }

    fun init(arg0: LENDIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LENDIT>(arg0, 6, b"LUSDC", b"LendItUSDC", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LENDIT>>(v1);
        let v2 = TreasuryCapHolder<LENDIT>{
            id       : 0x2::object::new(arg1),
            treasury : v0,
        };
        0x2::transfer::share_object<TreasuryCapHolder<LENDIT>>(v2);
    }

    public fun init_admin<T0>(arg0: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AccountCapHolder{
            id          : 0x2::object::new(arg1),
            account_cap : 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::create_account(arg1),
        };
        0x2::transfer::share_object<AccountCapHolder>(v0);
        let v1 = ObligationOwnerCapHolder<T0>{
            id         : 0x2::object::new(arg1),
            obligation : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::create_obligation<T0>(arg0, arg1),
        };
        0x2::transfer::share_object<ObligationOwnerCapHolder<T0>>(v1);
    }

    // decompiled from Move bytecode v6
}

