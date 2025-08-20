module 0x7438e8caf5c345fbd3772517380bf0ca432f53892dee65ee0dda3eb127993cd9::bfbtc {
    struct BFBTC has drop {
        dummy_field: bool,
    }

    struct BfbtcAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct BfbtcTreasury has key {
        id: 0x2::object::UID,
        version: u64,
        treasury_cap: 0x2::coin::TreasuryCap<BFBTC>,
        escrowed_balance: 0x2::balance::Balance<BFBTC>,
        fee_balance: 0x2::balance::Balance<BFBTC>,
        current_epoch: u64,
        withdraw_id_counter: u64,
        cooldown_epoches: u64,
        multisig: address,
        fee_receiver: address,
        min_withdraw_bfbtc_amount: u64,
        ratios: 0x2::table::Table<u64, u64>,
        withdrawals: 0x2::table::Table<u64, Withdrawal>,
        used_native_txs: 0x2::table::Table<vector<u8>, bool>,
        fee_configs: 0x2::table::Table<u8, FeeConfig>,
        fee_whitelist: 0x2::table::Table<address, bool>,
    }

    struct Withdrawal has store, key {
        id: 0x2::object::UID,
        version: u64,
        user: address,
        amount: u64,
        btc_address: vector<u8>,
        btc_address_type: u8,
        epoch: u64,
        settle_epoch: u64,
        native_tx: vector<u8>,
        status: u8,
    }

    struct FeeConfig has copy, drop, store {
        percentage_fee: u64,
        fixed_fee: u64,
    }

    struct DepositNative has copy, drop {
        user: address,
        epoch: u64,
        underlying_amount: u64,
        bfbtc_amount: u64,
        native_tx: vector<u8>,
    }

    struct WithdrawRequestNative has copy, drop {
        user: address,
        epoch: u64,
        withdraw_id: u64,
        bfbtc_amount: u64,
        btc_address_type: u8,
        btc_address: vector<u8>,
    }

    struct WithdrawNative has copy, drop {
        withdraw_id: u64,
        settle_epoch: u64,
        native_tx: vector<u8>,
    }

    struct EpochUpdated has copy, drop {
        epoch: u64,
        new_ratio: u64,
    }

    struct FeeCollected has copy, drop {
        user: address,
        fee_type: u8,
        withdraw_id: u64,
        amount: u64,
        percentage_fee: u64,
        fixed_fee: u64,
    }

    struct FeeWhitelistUpdated has copy, drop {
        account: address,
        status: bool,
    }

    struct FeeClaimed has copy, drop {
        amount: u64,
    }

    public fun calculate_fee(arg0: &BfbtcTreasury, arg1: address, arg2: u64) : (u64, u64) {
        if (0x2::table::contains<address, bool>(&arg0.fee_whitelist, arg1)) {
            return (0, 0)
        };
        if (0x2::table::contains<u8, FeeConfig>(&arg0.fee_configs, 1)) {
            let v2 = 0x2::table::borrow<u8, FeeConfig>(&arg0.fee_configs, 1);
            (arg2 * v2.percentage_fee / 100000, v2.fixed_fee)
        } else {
            (0, 0)
        }
    }

    public fun claim_fees(arg0: &mut BfbtcTreasury, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 14);
        let v0 = 0x2::balance::value<BFBTC>(&arg0.fee_balance);
        assert!(v0 > 0, 13);
        0x2::transfer::public_transfer<0x2::coin::Coin<BFBTC>>(0x2::coin::from_balance<BFBTC>(0x2::balance::withdraw_all<BFBTC>(&mut arg0.fee_balance), arg1), arg0.fee_receiver);
        let v1 = FeeClaimed{amount: v0};
        0x2::event::emit<FeeClaimed>(v1);
    }

    public fun current_ratio(arg0: &BfbtcTreasury) : u64 {
        *0x2::table::borrow<u64, u64>(&arg0.ratios, arg0.current_epoch - 1)
    }

    public fun deposit_native(arg0: &mut BfbtcTreasury, arg1: &0x2::deny_list::DenyList, arg2: vector<address>, arg3: vector<u64>, arg4: vector<vector<u8>>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 14);
        assert!(!0x2::coin::deny_list_v2_is_global_pause_enabled_next_epoch<BFBTC>(arg1), 16);
        assert!(0x2::tx_context::sender(arg5) == arg0.multisig, 5);
        assert!(arg0.current_epoch > 0, 3);
        assert!(0x1::vector::length<address>(&arg2) == 0x1::vector::length<u64>(&arg3), 8);
        assert!(0x1::vector::length<address>(&arg2) == 0x1::vector::length<vector<u8>>(&arg4), 8);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg2)) {
            let v1 = *0x1::vector::borrow<address>(&arg2, v0);
            let v2 = *0x1::vector::borrow<u64>(&arg3, v0);
            let v3 = *0x1::vector::borrow<vector<u8>>(&arg4, v0);
            assert!(v2 > 0, 11);
            assert!(0x1::vector::length<u8>(&v3) <= 32, 15);
            assert!(!0x2::table::contains<vector<u8>, bool>(&arg0.used_native_txs, v3), 9);
            0x2::table::add<vector<u8>, bool>(&mut arg0.used_native_txs, v3, true);
            let v4 = v2 * current_ratio(arg0) / 100000000;
            0x2::transfer::public_transfer<0x2::coin::Coin<BFBTC>>(0x2::coin::mint<BFBTC>(&mut arg0.treasury_cap, v4, arg5), v1);
            let v5 = DepositNative{
                user              : v1,
                epoch             : arg0.current_epoch,
                underlying_amount : v2,
                bfbtc_amount      : v4,
                native_tx         : v3,
            };
            0x2::event::emit<DepositNative>(v5);
            v0 = v0 + 1;
        };
    }

    fun init(arg0: BFBTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<BFBTC>(arg0, 8, b"bfBTC", b"BitFi Bitcoin", b"The Native Yield-Bearing Bitcoin Liquid Staking Token Issued by BitFi Labs", 0x1::option::none<0x2::url::Url>(), true, arg1);
        let v3 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BFBTC>>(v2, v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<BFBTC>>(v1, v3);
        let v4 = BfbtcAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<BfbtcAdminCap>(v4, v3);
        let v5 = 0x2::table::new<address, bool>(arg1);
        0x2::table::add<address, bool>(&mut v5, v3, true);
        let v6 = BfbtcTreasury{
            id                        : 0x2::object::new(arg1),
            version                   : 1,
            treasury_cap              : v0,
            escrowed_balance          : 0x2::balance::zero<BFBTC>(),
            fee_balance               : 0x2::balance::zero<BFBTC>(),
            current_epoch             : 0,
            withdraw_id_counter       : 0,
            cooldown_epoches          : 1,
            multisig                  : v3,
            fee_receiver              : v3,
            min_withdraw_bfbtc_amount : 10000,
            ratios                    : 0x2::table::new<u64, u64>(arg1),
            withdrawals               : 0x2::table::new<u64, Withdrawal>(arg1),
            used_native_txs           : 0x2::table::new<vector<u8>, bool>(arg1),
            fee_configs               : 0x2::table::new<u8, FeeConfig>(arg1),
            fee_whitelist             : v5,
        };
        0x2::transfer::share_object<BfbtcTreasury>(v6);
    }

    public fun native_withdraw(arg0: &mut BfbtcTreasury, arg1: &0x2::deny_list::DenyList, arg2: u64, arg3: vector<u64>, arg4: vector<vector<u8>>, arg5: &0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 14);
        assert!(!0x2::coin::deny_list_v2_is_global_pause_enabled_next_epoch<BFBTC>(arg1), 16);
        assert!(0x2::tx_context::sender(arg5) == arg0.multisig, 5);
        assert!(arg2 < arg0.current_epoch, 3);
        assert!(0x1::vector::length<u64>(&arg3) == 0x1::vector::length<vector<u8>>(&arg4), 8);
        let v0 = 0;
        let v1 = 0;
        while (v0 < 0x1::vector::length<u64>(&arg3)) {
            let v2 = *0x1::vector::borrow<u64>(&arg3, v0);
            let v3 = *0x1::vector::borrow<vector<u8>>(&arg4, v0);
            let v4 = 0x2::table::borrow_mut<u64, Withdrawal>(&mut arg0.withdrawals, v2);
            assert!(0x1::vector::length<u8>(&v3) <= 32, 15);
            assert!(v4.status == 1, 1);
            assert!(arg2 >= v4.epoch + arg0.cooldown_epoches, 2);
            v4.status = 2;
            v4.settle_epoch = arg2;
            v4.native_tx = v3;
            v1 = v1 + v4.amount;
            let v5 = WithdrawNative{
                withdraw_id  : v2,
                settle_epoch : arg2,
                native_tx    : v3,
            };
            0x2::event::emit<WithdrawNative>(v5);
            v0 = v0 + 1;
        };
        0x2::balance::decrease_supply<BFBTC>(0x2::coin::supply_mut<BFBTC>(&mut arg0.treasury_cap), 0x2::balance::split<BFBTC>(&mut arg0.escrowed_balance, v1));
    }

    public fun preview_deposit(arg0: &BfbtcTreasury, arg1: u64) : u64 {
        assert!(arg0.current_epoch > 0, 3);
        arg1 * current_ratio(arg0) / 100000000
    }

    public fun preview_withdraw(arg0: &BfbtcTreasury, arg1: address, arg2: u64) : (u64, u64) {
        let (v0, v1) = calculate_fee(arg0, arg1, arg2);
        let v2 = v0 + v1;
        if (v2 >= arg2) {
            return (0, v2)
        };
        ((arg2 - v2) * 100000000 / current_ratio(arg0), v2)
    }

    public fun request_withdraw_native(arg0: &mut BfbtcTreasury, arg1: &0x2::deny_list::DenyList, arg2: 0x2::coin::Coin<BFBTC>, arg3: u8, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 14);
        assert!(!0x2::coin::deny_list_v2_is_global_pause_enabled_next_epoch<BFBTC>(arg1), 16);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::coin::value<BFBTC>(&arg2);
        assert!(v1 >= arg0.min_withdraw_bfbtc_amount, 4);
        assert!(arg3 >= 1 && arg3 <= 4, 10);
        assert!(0x1::vector::length<u8>(&arg4) <= 32, 10);
        let v2 = arg0.withdraw_id_counter;
        let (v3, v4) = calculate_fee(arg0, v0, v1);
        let v5 = v3 + v4;
        assert!(v1 > v5, 13);
        let v6 = v1 - v5;
        0x2::balance::join<BFBTC>(&mut arg0.escrowed_balance, 0x2::coin::into_balance<BFBTC>(arg2));
        if (v5 > 0) {
            0x2::balance::join<BFBTC>(&mut arg0.fee_balance, 0x2::balance::split<BFBTC>(&mut arg0.escrowed_balance, v5));
            let v7 = FeeCollected{
                user           : v0,
                fee_type       : 1,
                withdraw_id    : v2,
                amount         : v1,
                percentage_fee : v3,
                fixed_fee      : v4,
            };
            0x2::event::emit<FeeCollected>(v7);
        };
        let v8 = Withdrawal{
            id               : 0x2::object::new(arg5),
            version          : 1,
            user             : v0,
            amount           : v6,
            btc_address      : arg4,
            btc_address_type : arg3,
            epoch            : arg0.current_epoch,
            settle_epoch     : 0,
            native_tx        : b"",
            status           : 1,
        };
        0x2::table::add<u64, Withdrawal>(&mut arg0.withdrawals, v2, v8);
        arg0.withdraw_id_counter = v2 + 1;
        let v9 = WithdrawRequestNative{
            user             : v0,
            epoch            : arg0.current_epoch,
            withdraw_id      : v2,
            bfbtc_amount     : v6,
            btc_address_type : arg3,
            btc_address      : arg4,
        };
        0x2::event::emit<WithdrawRequestNative>(v9);
    }

    public fun set_cooldown_epoches(arg0: &BfbtcAdminCap, arg1: &mut BfbtcTreasury, arg2: u64) {
        assert!(arg1.version == 1, 14);
        arg1.cooldown_epoches = arg2;
    }

    public fun set_fee(arg0: &BfbtcAdminCap, arg1: &mut BfbtcTreasury, arg2: u8, arg3: u64, arg4: u64) {
        assert!(arg1.version == 1, 14);
        assert!(arg3 <= 100000, 6);
        let v0 = FeeConfig{
            percentage_fee : arg3,
            fixed_fee      : arg4,
        };
        if (0x2::table::contains<u8, FeeConfig>(&arg1.fee_configs, arg2)) {
            0x2::table::remove<u8, FeeConfig>(&mut arg1.fee_configs, arg2);
        };
        0x2::table::add<u8, FeeConfig>(&mut arg1.fee_configs, arg2, v0);
    }

    public fun set_fee_receiver(arg0: &BfbtcAdminCap, arg1: &mut BfbtcTreasury, arg2: address) {
        assert!(arg1.version == 1, 14);
        assert!(arg2 != @0x0, 7);
        let v0 = arg1.fee_receiver;
        if (v0 != arg2) {
            if (0x2::table::contains<address, bool>(&arg1.fee_whitelist, v0)) {
                0x2::table::remove<address, bool>(&mut arg1.fee_whitelist, v0);
                let v1 = FeeWhitelistUpdated{
                    account : v0,
                    status  : false,
                };
                0x2::event::emit<FeeWhitelistUpdated>(v1);
            };
            arg1.fee_receiver = arg2;
            if (!0x2::table::contains<address, bool>(&arg1.fee_whitelist, arg2)) {
                0x2::table::add<address, bool>(&mut arg1.fee_whitelist, arg2, true);
            };
            let v2 = FeeWhitelistUpdated{
                account : arg2,
                status  : true,
            };
            0x2::event::emit<FeeWhitelistUpdated>(v2);
        };
    }

    public fun set_min_withdraw_bfbtc_amount(arg0: &BfbtcAdminCap, arg1: &mut BfbtcTreasury, arg2: u64) {
        assert!(arg1.version == 1, 14);
        arg1.min_withdraw_bfbtc_amount = arg2;
    }

    public fun set_multisig(arg0: &BfbtcAdminCap, arg1: &mut BfbtcTreasury, arg2: address) {
        assert!(arg1.version == 1, 14);
        assert!(arg2 != @0x0, 7);
        arg1.multisig = arg2;
    }

    public fun update_epoch(arg0: &mut BfbtcTreasury, arg1: &0x2::deny_list::DenyList, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 14);
        assert!(!0x2::coin::deny_list_v2_is_global_pause_enabled_next_epoch<BFBTC>(arg1), 16);
        assert!(0x2::tx_context::sender(arg3) == arg0.multisig, 5);
        assert!(arg2 > 0, 12);
        0x2::table::add<u64, u64>(&mut arg0.ratios, arg0.current_epoch, arg2);
        let v0 = EpochUpdated{
            epoch     : arg0.current_epoch,
            new_ratio : arg2,
        };
        0x2::event::emit<EpochUpdated>(v0);
        arg0.current_epoch = arg0.current_epoch + 1;
    }

    public fun update_fee_whitelist(arg0: &BfbtcAdminCap, arg1: &mut BfbtcTreasury, arg2: address, arg3: bool) {
        assert!(arg1.version == 1, 14);
        if (arg3) {
            0x2::table::add<address, bool>(&mut arg1.fee_whitelist, arg2, true);
        } else if (0x2::table::contains<address, bool>(&arg1.fee_whitelist, arg2)) {
            0x2::table::remove<address, bool>(&mut arg1.fee_whitelist, arg2);
        };
        let v0 = FeeWhitelistUpdated{
            account : arg2,
            status  : arg3,
        };
        0x2::event::emit<FeeWhitelistUpdated>(v0);
    }

    // decompiled from Move bytecode v6
}

