module 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault {
    struct VAULT has drop {
        dummy_field: bool,
    }

    struct DepositVault has store, key {
        id: 0x2::object::UID,
        deposit_token: 0x1::type_name::TypeName,
        bid_token: 0x1::type_name::TypeName,
        incentive_token: 0x1::option::Option<0x1::type_name::TypeName>,
        index: u64,
        fee_bp: u64,
        fee_share_bp: u64,
        shared_fee_pool: 0x1::option::Option<vector<u8>>,
        active_share_supply: u64,
        deactivating_share_supply: u64,
        inactive_share_supply: u64,
        warmup_share_supply: u64,
        premium_share_supply: u64,
        incentive_share_supply: u64,
        has_next: bool,
        metadata: 0x1::string::String,
        u64_padding: vector<u64>,
        bcs_padding: vector<u8>,
    }

    struct BidVault has store, key {
        id: 0x2::object::UID,
        deposit_token: 0x1::type_name::TypeName,
        bid_token: 0x1::type_name::TypeName,
        incentive_token: 0x1::option::Option<0x1::type_name::TypeName>,
        index: u64,
        share_supply: u64,
        metadata: 0x1::string::String,
        u64_padding: vector<u64>,
        bcs_padding: vector<u8>,
    }

    struct RefundVault has store, key {
        id: 0x2::object::UID,
        token: 0x1::type_name::TypeName,
        share_supply: u64,
        u64_padding: vector<u64>,
        bcs_padding: vector<u8>,
    }

    struct DepositShare has copy, store {
        receipt: address,
        active_share: u64,
        deactivating_share: u64,
        inactive_share: u64,
        warmup_share: u64,
        premium_share: u64,
        incentive_share: u64,
        u64_padding: vector<u64>,
    }

    struct TypusDepositReceipt has store, key {
        id: 0x2::object::UID,
        vid: 0x2::object::ID,
        index: u64,
        metadata: 0x1::string::String,
        u64_padding: vector<u64>,
    }

    struct BidShare has copy, store {
        receipt: address,
        share: u64,
        u64_padding: vector<u64>,
    }

    struct TypusBidReceipt has store, key {
        id: 0x2::object::UID,
        vid: 0x2::object::ID,
        index: u64,
        metadata: 0x1::string::String,
        u64_padding: vector<u64>,
    }

    struct RefundShare has copy, store {
        user: address,
        share: u64,
        u64_padding: vector<u64>,
    }

    struct NewDepositVault has copy, drop {
        signer: address,
        index: u64,
        deposit_token: 0x1::type_name::TypeName,
        bid_token: 0x1::type_name::TypeName,
    }

    struct NewBidVault has copy, drop {
        signer: address,
        index: u64,
        bid_token: 0x1::type_name::TypeName,
    }

    struct NewRefundVault has copy, drop {
        signer: address,
        token: 0x1::type_name::TypeName,
    }

    struct UpdateFeeConfig has copy, drop {
        signer: address,
        index: u64,
        prev_fee_bp: u64,
        fee_bp: u64,
    }

    struct UpdateFeeShareConfig has copy, drop {
        signer: address,
        index: u64,
        prev_fee_bp: u64,
        prev_shared_fee_pool: 0x1::option::Option<vector<u8>>,
        fee_bp: u64,
        shared_fee_pool: 0x1::option::Option<vector<u8>>,
    }

    struct Deposit has copy, drop {
        signer: address,
        index: u64,
        token: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct Withdraw has copy, drop {
        signer: address,
        index: u64,
        token: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct Unsubscribe has copy, drop {
        signer: address,
        index: u64,
        token: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct Claim has copy, drop {
        signer: address,
        index: u64,
        token: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct Harvest has copy, drop {
        signer: address,
        index: u64,
        token: 0x1::type_name::TypeName,
        amount: u64,
        fee_amount: u64,
        fee_share_amount: u64,
        shared_fee_pool: 0x1::option::Option<vector<u8>>,
    }

    struct Compound has copy, drop {
        signer: address,
        index: u64,
        token: 0x1::type_name::TypeName,
        amount: u64,
        fee_amount: u64,
        fee_share_amount: u64,
        shared_fee_pool: 0x1::option::Option<vector<u8>>,
    }

    struct Redeem has copy, drop {
        signer: address,
        index: u64,
        token: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct Exercise has copy, drop {
        signer: address,
        index: u64,
        deposit_token: 0x1::type_name::TypeName,
        incentive_token: 0x1::option::Option<0x1::type_name::TypeName>,
        amount: u64,
    }

    struct Activate has copy, drop {
        signer: address,
        index: u64,
        token: 0x1::type_name::TypeName,
        amount: u64,
        has_next: bool,
    }

    struct Delivery has copy, drop {
        signer: address,
        index: u64,
        premium_token: 0x1::type_name::TypeName,
        incentive_token: 0x1::type_name::TypeName,
        premium: u64,
        incentive: u64,
    }

    struct Recoup has copy, drop {
        signer: address,
        index: u64,
        token: 0x1::type_name::TypeName,
        active: u64,
        deactivating: u64,
    }

    struct Settle has copy, drop {
        signer: address,
        index: u64,
        deposit_token: 0x1::type_name::TypeName,
        bid_token: 0x1::type_name::TypeName,
        share_price: u64,
        share_price_decimal: u64,
    }

    struct Terminate has copy, drop {
        signer: address,
        index: u64,
        token: 0x1::type_name::TypeName,
    }

    struct IncentiviseBidder has copy, drop {
        signer: address,
        index: u64,
        token: 0x1::type_name::TypeName,
        amount: u64,
    }

    public fun claim<T0>(arg0: &mut DepositVault, arg1: vector<TypusDepositReceipt>, arg2: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(0x1::type_name::get<T0>() == arg0.deposit_token, 1);
        let v0 = 0x2::tx_context::sender(arg2);
        let (v1, v2, v3, v4, v5, v6, v7) = extract_deposit_shares(arg0, arg1);
        let v8 = v3;
        if (v3 > 0) {
            let v9 = get_mut_deposit_vault_balance<T0>(arg0, 2);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v9, v3), arg2), v0);
            v8 = v3 - v3;
            arg0.inactive_share_supply = arg0.inactive_share_supply - v3;
        };
        add_deposit_share(arg0, v1, v2, v8, v4, v5, v6, v7, arg2);
        let v10 = Claim{
            signer : v0,
            index  : arg0.index,
            token  : 0x1::type_name::get<T0>(),
            amount : v8,
        };
        0x2::event::emit<Claim>(v10);
        v8
    }

    public fun activate<T0>(arg0: &mut DepositVault, arg1: bool, arg2: &0x2::tx_context::TxContext) : u64 {
        assert!(0x1::type_name::get<T0>() == arg0.deposit_token, 1);
        let v0 = 0x2::balance::value<T0>(get_deposit_vault_balance<T0>(arg0, 3));
        if (v0 > 0) {
            let v1 = get_mut_deposit_vault_share_supply(arg0, 3);
            let v2 = *v1;
            *v1 = 0;
            let v3 = get_mut_deposit_vault_share_supply(arg0, 0);
            *v3 = *v3 + v2;
            let v4 = get_mut_deposit_vault_balance<T0>(arg0, 3);
            let v5 = 0x2::balance::split<T0>(v4, v0);
            let v6 = get_mut_deposit_vault_balance<T0>(arg0, 0);
            0x2::balance::join<T0>(v6, v5);
            let v7 = get_mut_deposit_shares(arg0);
            let v8 = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::length<DepositShare>(v7);
            let v9 = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::slice_size<DepositShare>(v7);
            let v10 = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::borrow_slice_mut<DepositShare>(v7, 1);
            let v11 = 0;
            while (v11 < v8) {
                let v12 = 0x1::vector::borrow_mut<DepositShare>(v10, v11 % v9);
                let v13 = get_mut_deposit_share_inner(v12, 3);
                if (*v13 > 0) {
                    let v14 = *v13;
                    *v13 = 0;
                    let v15 = get_mut_deposit_share_inner(v12, 0);
                    *v15 = *v15 + v14;
                };
                if (v11 + 1 < v8 && (v11 + 1) % v9 == 0) {
                    v10 = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::borrow_slice_mut<DepositShare>(v7, 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::slice_id<DepositShare>(v7, v11 + 1));
                };
                v11 = v11 + 1;
            };
        };
        arg0.has_next = arg1;
        let v16 = Activate{
            signer   : 0x2::tx_context::sender(arg2),
            index    : arg0.index,
            token    : 0x1::type_name::get<T0>(),
            amount   : v0,
            has_next : arg1,
        };
        0x2::event::emit<Activate>(v16);
        v0
    }

    public fun active_balance<T0>(arg0: &DepositVault) : u64 {
        0x2::balance::value<T0>(get_deposit_vault_balance<T0>(arg0, 0))
    }

    public fun active_share_supply(arg0: &DepositVault) : u64 {
        arg0.active_share_supply
    }

    fun add_deposit_share(arg0: &mut DepositVault, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: vector<u64>, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg8);
        if (arg1 != 0 || arg2 != 0 || arg3 != 0 || arg4 != 0 || arg5 != 0 || arg6 != 0) {
            let v1 = new_typus_deposit_receipt(arg0, arg8);
            let v2 = DepositShare{
                receipt            : 0x2::object::id_address<TypusDepositReceipt>(&v1),
                active_share       : arg1,
                deactivating_share : arg2,
                inactive_share     : arg3,
                warmup_share       : arg4,
                premium_share      : arg5,
                incentive_share    : arg6,
                u64_padding        : arg7,
            };
            0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::push_back<DepositShare>(get_mut_deposit_shares(arg0), v2);
            0x2::transfer::public_transfer<TypusDepositReceipt>(v1, v0);
        };
    }

    public fun bid_share_supply(arg0: &BidVault) : u64 {
        arg0.share_supply
    }

    public fun bid_vault_balance<T0>(arg0: &BidVault) : u64 {
        0x2::balance::value<T0>(get_bid_vault_balance<T0>(arg0))
    }

    public fun bid_vault_incentive_balance<T0>(arg0: &BidVault) : u64 {
        0x2::balance::value<T0>(get_bid_vault_incentive_balance<T0>(arg0))
    }

    fun charge_premium_fee<T0>(arg0: &mut 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::balance_pool::BalancePool, arg1: &DepositVault, arg2: 0x2::balance::Balance<T0>) : (u64, u64, 0x2::balance::Balance<T0>) {
        let v0 = (((0x2::balance::value<T0>(&arg2) as u128) * (arg1.fee_bp as u128) / 10000) as u64);
        let v1 = 0x2::balance::split<T0>(&mut arg2, v0);
        let v2 = (((0x2::balance::value<T0>(&v1) as u128) * (arg1.fee_share_bp as u128) / 10000) as u64);
        if (v2 > 0 && 0x1::option::is_some<vector<u8>>(&arg1.shared_fee_pool)) {
            0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::balance_pool::put_shared<T0>(arg0, *0x1::option::borrow<vector<u8>>(&arg1.shared_fee_pool), 0x2::balance::split<T0>(&mut v1, v2));
        };
        0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::balance_pool::put<T0>(arg0, v1);
        (v0 - v2, v2, arg2)
    }

    public fun compound<T0>(arg0: &mut 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::balance_pool::BalancePool, arg1: &mut DepositVault, arg2: vector<TypusDepositReceipt>, arg3: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(arg1.has_next, 4);
        assert!(0x1::type_name::get<T0>() == arg1.deposit_token, 1);
        assert!(0x1::type_name::get<T0>() == arg1.bid_token, 1);
        let v0 = 0x2::tx_context::sender(arg3);
        let (v1, v2, v3, v4, v5, v6, v7) = extract_deposit_shares(arg1, arg2);
        let v8 = v5;
        let v9 = v4;
        let v10 = v5;
        let v11 = 0;
        let v12 = 0;
        if (v5 > 0) {
            let v13 = get_mut_deposit_vault_balance<T0>(arg1, 4);
            v8 = v5 - v5;
            arg1.premium_share_supply = arg1.premium_share_supply - v5;
            let (v14, v15, v16) = charge_premium_fee<T0>(arg0, arg1, 0x2::balance::split<T0>(v13, v5));
            v11 = v14;
            v12 = v15;
            let v17 = v5 - v14;
            v10 = v17;
            let v18 = get_mut_deposit_vault_balance<T0>(arg1, 3);
            0x2::balance::join<T0>(v18, v16);
            v9 = v4 + v17;
            arg1.warmup_share_supply = arg1.warmup_share_supply + v17;
        };
        add_deposit_share(arg1, v1, v2, v3, v9, v8, v6, v7, arg3);
        let v19 = Compound{
            signer           : v0,
            index            : arg1.index,
            token            : 0x1::type_name::get<T0>(),
            amount           : v10,
            fee_amount       : v11,
            fee_share_amount : v12,
            shared_fee_pool  : arg1.shared_fee_pool,
        };
        0x2::event::emit<Compound>(v19);
        v10
    }

    public fun deactivating_balance<T0>(arg0: &DepositVault) : u64 {
        0x2::balance::value<T0>(get_deposit_vault_balance<T0>(arg0, 1))
    }

    public fun deactivating_share_supply(arg0: &DepositVault) : u64 {
        arg0.deactivating_share_supply
    }

    public fun delivery_b<T0, T1>(arg0: &mut DepositVault, arg1: &mut BidVault, arg2: 0x2::balance::Balance<T1>, arg3: 0x2::balance::Balance<T1>, arg4: &0x2::tx_context::TxContext) {
        assert!(0x1::type_name::get<T0>() == arg0.deposit_token, 1);
        assert!(0x1::type_name::get<T1>() == arg0.bid_token, 1);
        assert!(0x1::type_name::get<T0>() == arg1.deposit_token, 1);
        assert!(0x1::type_name::get<T1>() == arg1.bid_token, 1);
        let v0 = Delivery{
            signer          : 0x2::tx_context::sender(arg4),
            index           : arg0.index,
            premium_token   : 0x1::type_name::get<T1>(),
            incentive_token : 0x1::type_name::get<T1>(),
            premium         : 0x2::balance::value<T1>(&arg2),
            incentive       : 0x2::balance::value<T1>(&arg3),
        };
        0x2::event::emit<Delivery>(v0);
        0x2::balance::join<T1>(&mut arg2, arg3);
        let v1 = 0x2::balance::value<T1>(&arg2);
        let v2 = v1;
        let v3 = get_mut_deposit_vault_balance<T1>(arg0, 4);
        0x2::balance::join<T1>(v3, arg2);
        arg0.premium_share_supply = arg0.premium_share_supply + v1;
        let v4 = active_balance<T0>(arg0) + deactivating_balance<T0>(arg0);
        let v5 = get_mut_deposit_shares(arg0);
        let v6 = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::length<DepositShare>(v5);
        let v7 = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::slice_size<DepositShare>(v5);
        let v8 = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::borrow_slice_mut<DepositShare>(v5, 1);
        let v9 = 0;
        while (v9 < v6) {
            let v10 = 0x1::vector::borrow_mut<DepositShare>(v8, v9 % v7);
            if (v10.active_share > 0) {
                let v11 = (((v2 as u128) * (v10.active_share as u128) / (v4 as u128)) as u64);
                v10.premium_share = v10.premium_share + v11;
                v2 = v2 - v11;
                v4 = v4 - v10.active_share;
            };
            if (v10.deactivating_share > 0) {
                let v12 = (((v2 as u128) * (v10.deactivating_share as u128) / (v4 as u128)) as u64);
                v10.premium_share = v10.premium_share + v12;
                v2 = v2 - v12;
                v4 = v4 - v10.deactivating_share;
            };
            if (v9 + 1 < v6 && (v9 + 1) % v7 == 0) {
                v8 = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::borrow_slice_mut<DepositShare>(v5, 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::slice_id<DepositShare>(v5, v9 + 1));
            };
            v9 = v9 + 1;
        };
    }

    public fun delivery_d<T0, T1>(arg0: &mut DepositVault, arg1: &mut BidVault, arg2: 0x2::balance::Balance<T1>, arg3: 0x2::balance::Balance<T0>, arg4: &0x2::tx_context::TxContext) {
        assert!(0x1::type_name::get<T0>() == arg0.deposit_token, 1);
        assert!(0x1::type_name::get<T1>() == arg0.bid_token, 1);
        assert!(0x1::type_name::get<T0>() == arg1.deposit_token, 1);
        assert!(0x1::type_name::get<T1>() == arg1.bid_token, 1);
        let v0 = 0x2::balance::value<T1>(&arg2);
        let v1 = v0;
        let v2 = 0x2::balance::value<T0>(&arg3);
        let v3 = v2;
        let v4 = Delivery{
            signer          : 0x2::tx_context::sender(arg4),
            index           : arg0.index,
            premium_token   : 0x1::type_name::get<T1>(),
            incentive_token : 0x1::type_name::get<T0>(),
            premium         : v0,
            incentive       : v2,
        };
        0x2::event::emit<Delivery>(v4);
        let v5 = get_mut_deposit_vault_balance<T1>(arg0, 4);
        0x2::balance::join<T1>(v5, arg2);
        arg0.premium_share_supply = arg0.premium_share_supply + v0;
        let v6 = get_mut_deposit_vault_balance<T0>(arg0, 3);
        0x2::balance::join<T0>(v6, arg3);
        arg0.warmup_share_supply = arg0.warmup_share_supply + v2;
        let v7 = active_balance<T0>(arg0) + deactivating_balance<T0>(arg0);
        let v8 = get_mut_deposit_shares(arg0);
        let v9 = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::length<DepositShare>(v8);
        let v10 = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::slice_size<DepositShare>(v8);
        let v11 = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::borrow_slice_mut<DepositShare>(v8, 1);
        let v12 = 0;
        while (v12 < v9) {
            let v13 = 0x1::vector::borrow_mut<DepositShare>(v11, v12 % v10);
            if (v13.active_share > 0) {
                let v14 = (((v1 as u128) * (v13.active_share as u128) / (v7 as u128)) as u64);
                let v15 = (((v3 as u128) * (v13.active_share as u128) / (v7 as u128)) as u64);
                v13.premium_share = v13.premium_share + v14;
                v13.warmup_share = v13.warmup_share + v15;
                v1 = v1 - v14;
                v3 = v3 - v15;
                v7 = v7 - v13.active_share;
            };
            if (v13.deactivating_share > 0) {
                let v16 = (((v1 as u128) * (v13.deactivating_share as u128) / (v7 as u128)) as u64);
                let v17 = (((v3 as u128) * (v13.deactivating_share as u128) / (v7 as u128)) as u64);
                v13.premium_share = v13.premium_share + v16;
                v13.warmup_share = v13.warmup_share + v17;
                v1 = v1 - v16;
                v3 = v3 - v17;
                v7 = v7 - v13.deactivating_share;
            };
            if (v12 + 1 < v9 && (v12 + 1) % v10 == 0) {
                v11 = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::borrow_slice_mut<DepositShare>(v8, 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::slice_id<DepositShare>(v8, v12 + 1));
            };
            v12 = v12 + 1;
        };
    }

    public fun delivery_i<T0, T1, T2>(arg0: &mut DepositVault, arg1: &mut BidVault, arg2: 0x2::balance::Balance<T1>, arg3: 0x2::balance::Balance<T2>, arg4: &0x2::tx_context::TxContext) {
        assert!(0x1::type_name::get<T0>() == arg0.deposit_token, 1);
        assert!(0x1::type_name::get<T1>() == arg0.bid_token, 1);
        assert!(0x1::type_name::get<T0>() == arg1.deposit_token, 1);
        assert!(0x1::type_name::get<T1>() == arg1.bid_token, 1);
        let v0 = 0x2::balance::value<T1>(&arg2);
        let v1 = v0;
        let v2 = 0x2::balance::value<T2>(&arg3);
        let v3 = v2;
        let v4 = Delivery{
            signer          : 0x2::tx_context::sender(arg4),
            index           : arg0.index,
            premium_token   : 0x1::type_name::get<T1>(),
            incentive_token : 0x1::type_name::get<T2>(),
            premium         : v0,
            incentive       : v2,
        };
        0x2::event::emit<Delivery>(v4);
        let v5 = get_mut_deposit_vault_balance<T1>(arg0, 4);
        0x2::balance::join<T1>(v5, arg2);
        arg0.premium_share_supply = arg0.premium_share_supply + v0;
        let v6 = get_mut_deposit_vault_balance<T2>(arg0, 5);
        0x2::balance::join<T2>(v6, arg3);
        arg0.incentive_share_supply = arg0.incentive_share_supply + v2;
        let v7 = active_balance<T0>(arg0) + deactivating_balance<T0>(arg0);
        let v8 = get_mut_deposit_shares(arg0);
        let v9 = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::length<DepositShare>(v8);
        let v10 = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::slice_size<DepositShare>(v8);
        let v11 = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::borrow_slice_mut<DepositShare>(v8, 1);
        let v12 = 0;
        while (v12 < v9) {
            let v13 = 0x1::vector::borrow_mut<DepositShare>(v11, v12 % v10);
            if (v13.active_share > 0) {
                let v14 = (((v1 as u128) * (v13.active_share as u128) / (v7 as u128)) as u64);
                let v15 = (((v3 as u128) * (v13.active_share as u128) / (v7 as u128)) as u64);
                v13.premium_share = v13.premium_share + v14;
                v13.incentive_share = v13.incentive_share + v15;
                v1 = v1 - v14;
                v3 = v3 - v15;
                v7 = v7 - v13.active_share;
            };
            if (v13.deactivating_share > 0) {
                let v16 = (((v1 as u128) * (v13.deactivating_share as u128) / (v7 as u128)) as u64);
                let v17 = (((v3 as u128) * (v13.deactivating_share as u128) / (v7 as u128)) as u64);
                v13.premium_share = v13.premium_share + v16;
                v13.incentive_share = v13.incentive_share + v17;
                v1 = v1 - v16;
                v3 = v3 - v17;
                v7 = v7 - v13.deactivating_share;
            };
            if (v12 + 1 < v9 && (v12 + 1) % v10 == 0) {
                v11 = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::borrow_slice_mut<DepositShare>(v8, 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::slice_id<DepositShare>(v8, v12 + 1));
            };
            v12 = v12 + 1;
        };
    }

    public fun deposit<T0>(arg0: &mut DepositVault, arg1: vector<0x2::coin::Coin<T0>>, arg2: u64, arg3: vector<TypusDepositReceipt>, arg4: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(arg0.has_next, 4);
        assert!(0x1::type_name::get<T0>() == arg0.deposit_token, 1);
        assert!(arg2 > 0, 0);
        assert!(18446744073709551615 - active_balance<T0>(arg0) - deactivating_balance<T0>(arg0) - inactive_balance<T0>(arg0) - warmup_balance<T0>(arg0) >= arg2, 5);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = get_mut_deposit_vault_balance<T0>(arg0, 3);
        0x2::balance::join<T0>(v1, 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::utils::extract_balance<T0>(arg1, arg2, arg4));
        let (v2, v3, v4, v5, v6, v7, v8) = extract_deposit_shares(arg0, arg3);
        arg0.warmup_share_supply = arg0.warmup_share_supply + arg2;
        add_deposit_share(arg0, v2, v3, v4, v5 + arg2, v6, v7, v8, arg4);
        let v9 = Deposit{
            signer : v0,
            index  : arg0.index,
            token  : 0x1::type_name::get<T0>(),
            amount : arg2,
        };
        0x2::event::emit<Deposit>(v9);
        arg2
    }

    public fun drop_bid_vault<T0>(arg0: BidVault) {
        let BidVault {
            id              : v0,
            deposit_token   : _,
            bid_token       : _,
            incentive_token : _,
            index           : _,
            share_supply    : _,
            metadata        : _,
            u64_padding     : _,
            bcs_padding     : _,
        } = arg0;
        let v9 = v0;
        0x2::balance::destroy_zero<T0>(0x2::dynamic_field::remove<vector<u8>, 0x2::balance::Balance<T0>>(&mut v9, b"bid_balance"));
        0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::destroy_empty<BidShare>(0x2::dynamic_field::remove<vector<u8>, 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::BigVector<BidShare>>(&mut v9, b"bid_shares"));
        0x2::object::delete(v9);
    }

    public fun exercise<T0>(arg0: &mut BidVault, arg1: vector<TypusBidReceipt>, arg2: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(0x1::type_name::get<T0>() == arg0.deposit_token, 1);
        assert!(0x1::option::is_none<0x1::type_name::TypeName>(&arg0.incentive_token), 1);
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::balance::zero<T0>();
        while (!0x1::vector::is_empty<TypusBidReceipt>(&arg1)) {
            let v2 = 0x1::vector::pop_back<TypusBidReceipt>(&mut arg1);
            verify_bid_receipt(arg0, &v2);
            let TypusBidReceipt {
                id          : v3,
                vid         : _,
                index       : _,
                metadata    : _,
                u64_padding : _,
            } = v2;
            let v8 = v3;
            let v9 = remove_bid_share(arg0, 0x2::object::uid_to_address(&v8));
            let BidShare {
                receipt     : _,
                share       : v11,
                u64_padding : _,
            } = v9;
            let v13 = (((0x2::balance::value<T0>(get_bid_vault_balance<T0>(arg0)) as u128) * (v11 as u128) / ((v11 + arg0.share_supply) as u128)) as u64);
            0x2::object::delete(v8);
            let v14 = get_mut_bid_vault_balance<T0>(arg0);
            0x2::balance::join<T0>(&mut v1, 0x2::balance::split<T0>(v14, v13));
        };
        let v15 = 0x2::balance::value<T0>(&v1);
        0x1::vector::destroy_empty<TypusBidReceipt>(arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v1, arg2), v0);
        let v16 = Exercise{
            signer          : v0,
            index           : arg0.index,
            deposit_token   : arg0.deposit_token,
            incentive_token : arg0.incentive_token,
            amount          : v15,
        };
        0x2::event::emit<Exercise>(v16);
        v15
    }

    public fun exercise_i<T0, T1>(arg0: &mut BidVault, arg1: vector<TypusBidReceipt>, arg2: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        assert!(0x1::type_name::get<T0>() == arg0.deposit_token, 1);
        assert!(0x1::type_name::get<T1>() == *0x1::option::borrow<0x1::type_name::TypeName>(&arg0.incentive_token), 1);
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::balance::zero<T0>();
        let v2 = 0x2::balance::zero<T1>();
        while (!0x1::vector::is_empty<TypusBidReceipt>(&arg1)) {
            let v3 = 0x1::vector::pop_back<TypusBidReceipt>(&mut arg1);
            verify_bid_receipt(arg0, &v3);
            let TypusBidReceipt {
                id          : v4,
                vid         : _,
                index       : _,
                metadata    : _,
                u64_padding : _,
            } = v3;
            let v9 = v4;
            let v10 = remove_bid_share(arg0, 0x2::object::uid_to_address(&v9));
            let BidShare {
                receipt     : _,
                share       : v12,
                u64_padding : _,
            } = v10;
            let v14 = (((bid_vault_balance<T0>(arg0) as u128) * (v12 as u128) / ((v12 + arg0.share_supply) as u128)) as u64);
            let v15 = (((bid_vault_incentive_balance<T1>(arg0) as u128) * (v12 as u128) / ((v12 + arg0.share_supply) as u128)) as u64);
            0x2::object::delete(v9);
            let v16 = get_mut_bid_vault_balance<T0>(arg0);
            0x2::balance::join<T0>(&mut v1, 0x2::balance::split<T0>(v16, v14));
            let v17 = get_mut_bid_vault_incentive_balance<T1>(arg0);
            0x2::balance::join<T1>(&mut v2, 0x2::balance::split<T1>(v17, v15));
        };
        let v18 = 0x2::balance::value<T0>(&v1);
        0x1::vector::destroy_empty<TypusBidReceipt>(arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v1, arg2), v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v2, arg2), v0);
        let v19 = Exercise{
            signer          : v0,
            index           : arg0.index,
            deposit_token   : arg0.deposit_token,
            incentive_token : arg0.incentive_token,
            amount          : v18,
        };
        0x2::event::emit<Exercise>(v19);
        (v18, 0x2::balance::value<T1>(&v2))
    }

    fun extract_deposit_shares(arg0: &mut DepositVault, arg1: vector<TypusDepositReceipt>) : (u64, u64, u64, u64, u64, u64, vector<u64>) {
        let v0 = 0;
        let v1 = 0;
        let v2 = 0;
        let v3 = 0;
        let v4 = 0;
        let v5 = 0;
        let v6 = 0x1::vector::empty<u64>();
        while (!0x1::vector::is_empty<TypusDepositReceipt>(&arg1)) {
            let v7 = 0x1::vector::pop_back<TypusDepositReceipt>(&mut arg1);
            verify_deposit_receipt(arg0, &v7);
            let TypusDepositReceipt {
                id          : v8,
                vid         : _,
                index       : _,
                metadata    : _,
                u64_padding : _,
            } = v7;
            let v13 = v8;
            0x2::object::delete(v13);
            let v14 = get_mut_deposit_shares(arg0);
            let v15 = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::length<DepositShare>(v14);
            let v16 = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::slice_size<DepositShare>(v14);
            let v17 = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::borrow_slice<DepositShare>(v14, 1);
            let v18 = 0;
            while (v18 < v15) {
                if (0x1::vector::borrow<DepositShare>(v17, v18 % v16).receipt == 0x2::object::uid_to_address(&v13)) {
                    let DepositShare {
                        receipt            : _,
                        active_share       : v20,
                        deactivating_share : v21,
                        inactive_share     : v22,
                        warmup_share       : v23,
                        premium_share      : v24,
                        incentive_share    : v25,
                        u64_padding        : v26,
                    } = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::swap_remove<DepositShare>(v14, v18);
                    let v27 = v26;
                    v0 = v0 + v20;
                    v1 = v1 + v21;
                    v2 = v2 + v22;
                    v3 = v3 + v23;
                    v4 = v4 + v24;
                    v5 = v5 + v25;
                    if (0x1::vector::length<u64>(&v27) > 0) {
                        if (0x1::vector::is_empty<u64>(&v6)) {
                            v6 = v27;
                            break
                        };
                        let v28 = 0;
                        while (0x1::vector::length<u64>(&v27) > 0) {
                            let v29 = 0x1::vector::borrow_mut<u64>(&mut v6, v28);
                            *v29 = *v29 + 0x1::vector::pop_back<u64>(&mut v27);
                            v28 = v28 + 1;
                        };
                    } else {
                        break
                    };
                } else {
                    if (v18 + 1 < v15 && (v18 + 1) % v16 == 0) {
                        v17 = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::borrow_slice<DepositShare>(v14, 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::slice_id<DepositShare>(v14, v18 + 1));
                    };
                    v18 = v18 + 1;
                };
            };
        };
        0x1::vector::destroy_empty<TypusDepositReceipt>(arg1);
        (v0, v1, v2, v3, v4, v5, v6)
    }

    public fun fee_bp(arg0: &DepositVault) : u64 {
        arg0.fee_bp
    }

    public fun fee_share_bp(arg0: &DepositVault) : u64 {
        arg0.fee_share_bp
    }

    public fun get_active_deposit_share(arg0: &DepositVault, arg1: address) : u64 {
        let v0 = get_deposit_shares(arg0);
        let v1 = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::length<DepositShare>(v0);
        let v2 = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::slice_size<DepositShare>(v0);
        let v3 = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::borrow_slice<DepositShare>(v0, 1);
        let v4 = 0;
        while (v4 < v1) {
            let v5 = 0x1::vector::borrow<DepositShare>(v3, v4 % v2);
            if (v5.receipt == arg1) {
                return get_deposit_share_inner(v5, 0)
            };
            if (v4 + 1 < v1 && (v4 + 1) % v2 == 0) {
                v3 = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::borrow_slice<DepositShare>(v0, 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::slice_id<DepositShare>(v0, v4 + 1));
            };
            v4 = v4 + 1;
        };
        0
    }

    public fun get_bid_receipt_index(arg0: &TypusBidReceipt) : u64 {
        arg0.index
    }

    public fun get_bid_receipt_info(arg0: &TypusBidReceipt) : (0x2::object::ID, u64, vector<u64>) {
        (arg0.vid, arg0.index, arg0.u64_padding)
    }

    public fun get_bid_receipt_vid(arg0: &TypusBidReceipt) : 0x2::object::ID {
        arg0.vid
    }

    public fun get_bid_share(arg0: &BidVault, arg1: address) : u64 {
        let v0 = get_bid_shares(arg0);
        let v1 = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::length<BidShare>(v0);
        let v2 = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::slice_size<BidShare>(v0);
        let v3 = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::borrow_slice<BidShare>(v0, 1);
        let v4 = 0;
        while (v4 < v1) {
            let v5 = 0x1::vector::borrow<BidShare>(v3, v4 % v2);
            if (v5.receipt == arg1) {
                return v5.share
            };
            if (v4 + 1 < v1 && (v4 + 1) % v2 == 0) {
                v3 = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::borrow_slice<BidShare>(v0, 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::slice_id<BidShare>(v0, v4 + 1));
            };
            v4 = v4 + 1;
        };
        0
    }

    public fun get_bid_shares(arg0: &BidVault) : &0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::BigVector<BidShare> {
        0x2::dynamic_field::borrow<vector<u8>, 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::BigVector<BidShare>>(&arg0.id, b"bid_shares")
    }

    public fun get_bid_vault_balance<T0>(arg0: &BidVault) : &0x2::balance::Balance<T0> {
        0x2::dynamic_field::borrow<vector<u8>, 0x2::balance::Balance<T0>>(&arg0.id, b"bid_balance")
    }

    public fun get_bid_vault_incentive_balance<T0>(arg0: &BidVault) : &0x2::balance::Balance<T0> {
        0x2::dynamic_field::borrow<vector<u8>, 0x2::balance::Balance<T0>>(&arg0.id, b"inactive_balance")
    }

    public fun get_bid_vault_token_types(arg0: &BidVault) : (0x1::type_name::TypeName, 0x1::type_name::TypeName) {
        (arg0.bid_token, arg0.bid_token)
    }

    public fun get_bid_vault_u64_padding_value(arg0: &BidVault, arg1: u64) : u64 {
        0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::utils::get_u64_padding_value(&arg0.u64_padding, arg1)
    }

    public fun get_deactivating_deposit_share(arg0: &DepositVault, arg1: address) : u64 {
        let v0 = get_deposit_shares(arg0);
        let v1 = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::length<DepositShare>(v0);
        let v2 = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::slice_size<DepositShare>(v0);
        let v3 = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::borrow_slice<DepositShare>(v0, 1);
        let v4 = 0;
        while (v4 < v1) {
            let v5 = 0x1::vector::borrow<DepositShare>(v3, v4 % v2);
            if (v5.receipt == arg1) {
                return get_deposit_share_inner(v5, 1)
            };
            if (v4 + 1 < v1 && (v4 + 1) % v2 == 0) {
                v3 = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::borrow_slice<DepositShare>(v0, 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::slice_id<DepositShare>(v0, v4 + 1));
            };
            v4 = v4 + 1;
        };
        0
    }

    public fun get_deposit_receipt_index(arg0: &TypusDepositReceipt) : u64 {
        arg0.index
    }

    public fun get_deposit_receipt_vid(arg0: &TypusDepositReceipt) : 0x2::object::ID {
        arg0.vid
    }

    public fun get_deposit_share(arg0: &DepositVault, arg1: u64) : &DepositShare {
        0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::borrow<DepositShare>(get_deposit_shares(arg0), arg1)
    }

    public fun get_deposit_share_inner(arg0: &DepositShare, arg1: u8) : u64 {
        if (arg1 == 0) {
            arg0.active_share
        } else if (arg1 == 1) {
            arg0.deactivating_share
        } else if (arg1 == 2) {
            arg0.inactive_share
        } else if (arg1 == 3) {
            arg0.warmup_share
        } else if (arg1 == 4) {
            arg0.premium_share
        } else {
            assert!(arg1 == 5, 2);
            arg0.premium_share
        }
    }

    public fun get_deposit_shares(arg0: &DepositVault) : &0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::BigVector<DepositShare> {
        0x2::dynamic_field::borrow<vector<u8>, 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::BigVector<DepositShare>>(&arg0.id, b"deposit_shares")
    }

    public fun get_deposit_vault_balance<T0>(arg0: &DepositVault, arg1: u8) : &0x2::balance::Balance<T0> {
        if (arg1 == 0) {
            0x2::dynamic_field::borrow<vector<u8>, 0x2::balance::Balance<T0>>(&arg0.id, b"active_balance")
        } else if (arg1 == 1) {
            0x2::dynamic_field::borrow<vector<u8>, 0x2::balance::Balance<T0>>(&arg0.id, b"deactivating_balance")
        } else if (arg1 == 2) {
            0x2::dynamic_field::borrow<vector<u8>, 0x2::balance::Balance<T0>>(&arg0.id, b"inactive_balance")
        } else if (arg1 == 3) {
            0x2::dynamic_field::borrow<vector<u8>, 0x2::balance::Balance<T0>>(&arg0.id, b"warmup_balance")
        } else if (arg1 == 4) {
            0x2::dynamic_field::borrow<vector<u8>, 0x2::balance::Balance<T0>>(&arg0.id, b"premium_balance")
        } else {
            assert!(arg1 == 5, 2);
            0x2::dynamic_field::borrow<vector<u8>, 0x2::balance::Balance<T0>>(&arg0.id, b"incentive_balance")
        }
    }

    public fun get_deposit_vault_token_types(arg0: &DepositVault) : (0x1::type_name::TypeName, 0x1::type_name::TypeName) {
        (arg0.deposit_token, arg0.bid_token)
    }

    public fun get_inactive_deposit_share(arg0: &DepositVault, arg1: address) : u64 {
        let v0 = get_deposit_shares(arg0);
        let v1 = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::length<DepositShare>(v0);
        let v2 = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::slice_size<DepositShare>(v0);
        let v3 = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::borrow_slice<DepositShare>(v0, 1);
        let v4 = 0;
        while (v4 < v1) {
            let v5 = 0x1::vector::borrow<DepositShare>(v3, v4 % v2);
            if (v5.receipt == arg1) {
                return get_deposit_share_inner(v5, 2)
            };
            if (v4 + 1 < v1 && (v4 + 1) % v2 == 0) {
                v3 = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::borrow_slice<DepositShare>(v0, 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::slice_id<DepositShare>(v0, v4 + 1));
            };
            v4 = v4 + 1;
        };
        0
    }

    fun get_mut_bid_shares(arg0: &mut BidVault) : &mut 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::BigVector<BidShare> {
        0x2::dynamic_field::borrow_mut<vector<u8>, 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::BigVector<BidShare>>(&mut arg0.id, b"bid_shares")
    }

    fun get_mut_bid_vault_balance<T0>(arg0: &mut BidVault) : &mut 0x2::balance::Balance<T0> {
        0x2::dynamic_field::borrow_mut<vector<u8>, 0x2::balance::Balance<T0>>(&mut arg0.id, b"bid_balance")
    }

    fun get_mut_bid_vault_incentive_balance<T0>(arg0: &mut BidVault) : &mut 0x2::balance::Balance<T0> {
        0x2::dynamic_field::borrow_mut<vector<u8>, 0x2::balance::Balance<T0>>(&mut arg0.id, b"incentive_balance")
    }

    fun get_mut_deposit_share_inner(arg0: &mut DepositShare, arg1: u8) : &mut u64 {
        if (arg1 == 0) {
            &mut arg0.active_share
        } else if (arg1 == 1) {
            &mut arg0.deactivating_share
        } else if (arg1 == 2) {
            &mut arg0.inactive_share
        } else if (arg1 == 3) {
            &mut arg0.warmup_share
        } else if (arg1 == 4) {
            &mut arg0.premium_share
        } else {
            assert!(arg1 == 5, 2);
            &mut arg0.premium_share
        }
    }

    fun get_mut_deposit_shares(arg0: &mut DepositVault) : &mut 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::BigVector<DepositShare> {
        0x2::dynamic_field::borrow_mut<vector<u8>, 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::BigVector<DepositShare>>(&mut arg0.id, b"deposit_shares")
    }

    fun get_mut_deposit_vault_balance<T0>(arg0: &mut DepositVault, arg1: u8) : &mut 0x2::balance::Balance<T0> {
        if (arg1 == 0) {
            0x2::dynamic_field::borrow_mut<vector<u8>, 0x2::balance::Balance<T0>>(&mut arg0.id, b"active_balance")
        } else if (arg1 == 1) {
            0x2::dynamic_field::borrow_mut<vector<u8>, 0x2::balance::Balance<T0>>(&mut arg0.id, b"deactivating_balance")
        } else if (arg1 == 2) {
            0x2::dynamic_field::borrow_mut<vector<u8>, 0x2::balance::Balance<T0>>(&mut arg0.id, b"inactive_balance")
        } else if (arg1 == 3) {
            0x2::dynamic_field::borrow_mut<vector<u8>, 0x2::balance::Balance<T0>>(&mut arg0.id, b"warmup_balance")
        } else if (arg1 == 4) {
            0x2::dynamic_field::borrow_mut<vector<u8>, 0x2::balance::Balance<T0>>(&mut arg0.id, b"premium_balance")
        } else {
            assert!(arg1 == 5, 2);
            0x2::dynamic_field::borrow_mut<vector<u8>, 0x2::balance::Balance<T0>>(&mut arg0.id, b"incentive_balance")
        }
    }

    fun get_mut_deposit_vault_share_supply(arg0: &mut DepositVault, arg1: u8) : &mut u64 {
        if (arg1 == 0) {
            &mut arg0.active_share_supply
        } else if (arg1 == 1) {
            &mut arg0.deactivating_share_supply
        } else if (arg1 == 2) {
            &mut arg0.inactive_share_supply
        } else if (arg1 == 3) {
            &mut arg0.warmup_share_supply
        } else if (arg1 == 4) {
            &mut arg0.premium_share_supply
        } else {
            assert!(arg1 == 5, 2);
            &mut arg0.premium_share_supply
        }
    }

    public fun get_premium_deposit_share(arg0: &DepositVault, arg1: address) : u64 {
        let v0 = get_deposit_shares(arg0);
        let v1 = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::length<DepositShare>(v0);
        let v2 = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::slice_size<DepositShare>(v0);
        let v3 = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::borrow_slice<DepositShare>(v0, 1);
        let v4 = 0;
        while (v4 < v1) {
            let v5 = 0x1::vector::borrow<DepositShare>(v3, v4 % v2);
            if (v5.receipt == arg1) {
                return get_deposit_share_inner(v5, 4)
            };
            if (v4 + 1 < v1 && (v4 + 1) % v2 == 0) {
                v3 = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::borrow_slice<DepositShare>(v0, 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::slice_id<DepositShare>(v0, v4 + 1));
            };
            v4 = v4 + 1;
        };
        0
    }

    public fun get_refund_share(arg0: &RefundVault, arg1: address) : u64 {
        let v0 = get_refund_shares(arg0);
        let v1 = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::length<RefundShare>(v0);
        let v2 = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::slice_size<RefundShare>(v0);
        let v3 = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::borrow_slice<RefundShare>(v0, 1);
        let v4 = 0;
        while (v4 < v1) {
            let v5 = 0x1::vector::borrow<RefundShare>(v3, v4 % v2);
            if (v5.user == arg1) {
                return v5.share
            };
            if (v4 + 1 < v1 && (v4 + 1) % v2 == 0) {
                v3 = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::borrow_slice<RefundShare>(v0, 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::slice_id<RefundShare>(v0, v4 + 1));
            };
            v4 = v4 + 1;
        };
        0
    }

    public fun get_refund_shares(arg0: &RefundVault) : &0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::BigVector<RefundShare> {
        0x2::dynamic_field::borrow<vector<u8>, 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::BigVector<RefundShare>>(&arg0.id, b"refund_shares")
    }

    public fun get_warmup_deposit_share(arg0: &DepositVault, arg1: address) : u64 {
        let v0 = get_deposit_shares(arg0);
        let v1 = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::length<DepositShare>(v0);
        let v2 = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::slice_size<DepositShare>(v0);
        let v3 = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::borrow_slice<DepositShare>(v0, 1);
        let v4 = 0;
        while (v4 < v1) {
            let v5 = 0x1::vector::borrow<DepositShare>(v3, v4 % v2);
            if (v5.receipt == arg1) {
                return get_deposit_share_inner(v5, 3)
            };
            if (v4 + 1 < v1 && (v4 + 1) % v2 == 0) {
                v3 = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::borrow_slice<DepositShare>(v0, 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::slice_id<DepositShare>(v0, v4 + 1));
            };
            v4 = v4 + 1;
        };
        0
    }

    public fun harvest<T0>(arg0: &mut 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::balance_pool::BalancePool, arg1: &mut DepositVault, arg2: vector<TypusDepositReceipt>, arg3: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        assert!(0x1::type_name::get<T0>() == arg1.bid_token, 1);
        let v0 = 0x2::tx_context::sender(arg3);
        let (v1, v2, v3, v4, v5, v6, v7) = extract_deposit_shares(arg1, arg2);
        let v8 = v5;
        let v9 = v5;
        let v10 = 0;
        let v11 = 0;
        if (v5 > 0) {
            let v12 = get_mut_deposit_vault_balance<T0>(arg1, 4);
            v8 = v5 - v5;
            arg1.premium_share_supply = arg1.premium_share_supply - v5;
            let (v13, v14, v15) = charge_premium_fee<T0>(arg0, arg1, 0x2::balance::split<T0>(v12, v5));
            v10 = v13;
            v11 = v14;
            v9 = v5 - v13;
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v15, arg3), v0);
        };
        add_deposit_share(arg1, v1, v2, v3, v4, v8, v6, v7, arg3);
        let v16 = Harvest{
            signer           : v0,
            index            : arg1.index,
            token            : 0x1::type_name::get<T0>(),
            amount           : v9,
            fee_amount       : v10,
            fee_share_amount : v11,
            shared_fee_pool  : arg1.shared_fee_pool,
        };
        0x2::event::emit<Harvest>(v16);
        (v9, v10)
    }

    public fun has_next(arg0: &DepositVault) : bool {
        arg0.has_next
    }

    public fun inactive_balance<T0>(arg0: &DepositVault) : u64 {
        0x2::balance::value<T0>(get_deposit_vault_balance<T0>(arg0, 2))
    }

    public fun inactive_share_supply(arg0: &DepositVault) : u64 {
        arg0.inactive_share_supply
    }

    public fun incentivise_bidder<T0>(arg0: &mut BidVault, arg1: 0x2::balance::Balance<T0>, arg2: &0x2::tx_context::TxContext) {
        if (0x1::option::is_some<0x1::type_name::TypeName>(&arg0.incentive_token)) {
            assert!(*0x1::option::borrow<0x1::type_name::TypeName>(&arg0.incentive_token) == 0x1::type_name::get<T0>(), 1);
            0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<vector<u8>, 0x2::balance::Balance<T0>>(&mut arg0.id, b"incentive_balance"), arg1);
        } else {
            arg0.incentive_token = 0x1::option::some<0x1::type_name::TypeName>(0x1::type_name::get<T0>());
            0x2::dynamic_field::add<vector<u8>, 0x2::balance::Balance<T0>>(&mut arg0.id, b"incentive_balance", arg1);
        };
        let v0 = IncentiviseBidder{
            signer : 0x2::tx_context::sender(arg2),
            index  : arg0.index,
            token  : 0x1::type_name::get<T0>(),
            amount : 0x2::balance::value<T0>(&arg1),
        };
        0x2::event::emit<IncentiviseBidder>(v0);
    }

    fun init(arg0: VAULT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<VAULT>(arg0, arg1);
        let v1 = 0x2::display::new<TypusDepositReceipt>(&v0, arg1);
        0x2::display::add<TypusDepositReceipt>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"Typus Deposit Receipt | {metadata}"));
        0x2::display::add<TypusDepositReceipt>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"Typus Option Position"));
        0x2::display::add<TypusDepositReceipt>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"https://raw.githubusercontent.com/Typus-Lab/typus-asset/main/receipt/deposit/{index}.jpg"));
        0x2::display::update_version<TypusDepositReceipt>(&mut v1);
        let v2 = 0x2::display::new<TypusBidReceipt>(&v0, arg1);
        0x2::display::add<TypusBidReceipt>(&mut v2, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"Typus Bid Receipt | {metadata}"));
        0x2::display::add<TypusBidReceipt>(&mut v2, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"Typus Option Position"));
        0x2::display::add<TypusBidReceipt>(&mut v2, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"https://raw.githubusercontent.com/Typus-Lab/typus-asset/main/receipt/bid/{index}.jpg"));
        0x2::display::update_version<TypusBidReceipt>(&mut v2);
        let v3 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, v3);
        0x2::transfer::public_transfer<0x2::display::Display<TypusDepositReceipt>>(v1, v3);
        0x2::transfer::public_transfer<0x2::display::Display<TypusBidReceipt>>(v2, v3);
    }

    public fun is_active_user(arg0: &DepositVault, arg1: address) : bool {
        let v0 = get_deposit_shares(arg0);
        let v1 = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::length<DepositShare>(v0);
        let v2 = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::slice_size<DepositShare>(v0);
        let v3 = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::borrow_slice<DepositShare>(v0, 1);
        let v4 = 0;
        while (v4 < v1) {
            let v5 = 0x1::vector::borrow<DepositShare>(v3, v4 % v2);
            if (v5.receipt == arg1) {
                if (get_deposit_share_inner(v5, 0) > 0) {
                    return true
                } else {
                    break
                };
            };
            if (v4 + 1 < v1 && (v4 + 1) % v2 == 0) {
                v3 = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::borrow_slice<DepositShare>(v0, 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::slice_id<DepositShare>(v0, v4 + 1));
            };
            v4 = v4 + 1;
        };
        false
    }

    public fun is_deactivating_user(arg0: &DepositVault, arg1: address) : bool {
        let v0 = get_deposit_shares(arg0);
        let v1 = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::length<DepositShare>(v0);
        let v2 = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::slice_size<DepositShare>(v0);
        let v3 = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::borrow_slice<DepositShare>(v0, 1);
        let v4 = 0;
        while (v4 < v1) {
            let v5 = 0x1::vector::borrow<DepositShare>(v3, v4 % v2);
            if (v5.receipt == arg1) {
                if (get_deposit_share_inner(v5, 1) > 0) {
                    return true
                } else {
                    break
                };
            };
            if (v4 + 1 < v1 && (v4 + 1) % v2 == 0) {
                v3 = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::borrow_slice<DepositShare>(v0, 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::slice_id<DepositShare>(v0, v4 + 1));
            };
            v4 = v4 + 1;
        };
        false
    }

    public fun is_inactive_user(arg0: &DepositVault, arg1: address) : bool {
        let v0 = get_deposit_shares(arg0);
        let v1 = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::length<DepositShare>(v0);
        let v2 = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::slice_size<DepositShare>(v0);
        let v3 = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::borrow_slice<DepositShare>(v0, 1);
        let v4 = 0;
        while (v4 < v1) {
            let v5 = 0x1::vector::borrow<DepositShare>(v3, v4 % v2);
            if (v5.receipt == arg1) {
                if (get_deposit_share_inner(v5, 2) > 0) {
                    return true
                } else {
                    break
                };
            };
            if (v4 + 1 < v1 && (v4 + 1) % v2 == 0) {
                v3 = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::borrow_slice<DepositShare>(v0, 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::slice_id<DepositShare>(v0, v4 + 1));
            };
            v4 = v4 + 1;
        };
        false
    }

    public fun is_warmup_user(arg0: &DepositVault, arg1: address) : bool {
        let v0 = get_deposit_shares(arg0);
        let v1 = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::length<DepositShare>(v0);
        let v2 = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::slice_size<DepositShare>(v0);
        let v3 = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::borrow_slice<DepositShare>(v0, 1);
        let v4 = 0;
        while (v4 < v1) {
            let v5 = 0x1::vector::borrow<DepositShare>(v3, v4 % v2);
            if (v5.receipt == arg1) {
                if (get_deposit_share_inner(v5, 3) > 0) {
                    return true
                } else {
                    break
                };
            };
            if (v4 + 1 < v1 && (v4 + 1) % v2 == 0) {
                v3 = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::borrow_slice<DepositShare>(v0, 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::slice_id<DepositShare>(v0, v4 + 1));
            };
            v4 = v4 + 1;
        };
        false
    }

    public fun new_bid(arg0: &mut BidVault, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        arg0.share_supply = arg0.share_supply + arg1;
        let v1 = new_typus_bid_receipt(arg0, arg2);
        let v2 = BidShare{
            receipt     : 0x2::object::id_address<TypusBidReceipt>(&v1),
            share       : arg1,
            u64_padding : 0x1::vector::empty<u64>(),
        };
        0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::push_back<BidShare>(get_mut_bid_shares(arg0), v2);
        0x2::transfer::public_transfer<TypusBidReceipt>(v1, v0);
    }

    public fun new_bid_vault<T0, T1>(arg0: u64, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) : BidVault {
        let v0 = 0x2::object::new(arg2);
        let v1 = 0x1::type_name::get<T1>();
        0x2::dynamic_field::add<vector<u8>, 0x2::balance::Balance<T0>>(&mut v0, b"bid_balance", 0x2::balance::zero<T0>());
        0x2::dynamic_field::add<vector<u8>, 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::BigVector<BidShare>>(&mut v0, b"bid_shares", 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::new<BidShare>(4500, arg2));
        let v2 = BidVault{
            id              : v0,
            deposit_token   : 0x1::type_name::get<T0>(),
            bid_token       : v1,
            incentive_token : 0x1::option::none<0x1::type_name::TypeName>(),
            index           : arg0,
            share_supply    : 0,
            metadata        : arg1,
            u64_padding     : 0x1::vector::empty<u64>(),
            bcs_padding     : 0x1::vector::empty<u8>(),
        };
        let v3 = NewBidVault{
            signer    : 0x2::tx_context::sender(arg2),
            index     : arg0,
            bid_token : v1,
        };
        0x2::event::emit<NewBidVault>(v3);
        v2
    }

    public fun new_deposit_vault<T0, T1>(arg0: u64, arg1: u64, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) : DepositVault {
        let v0 = 0x2::object::new(arg3);
        let v1 = 0x1::type_name::get<T0>();
        let v2 = 0x1::type_name::get<T1>();
        0x2::dynamic_field::add<vector<u8>, 0x2::balance::Balance<T0>>(&mut v0, b"active_balance", 0x2::balance::zero<T0>());
        0x2::dynamic_field::add<vector<u8>, 0x2::balance::Balance<T0>>(&mut v0, b"deactivating_balance", 0x2::balance::zero<T0>());
        0x2::dynamic_field::add<vector<u8>, 0x2::balance::Balance<T0>>(&mut v0, b"inactive_balance", 0x2::balance::zero<T0>());
        0x2::dynamic_field::add<vector<u8>, 0x2::balance::Balance<T0>>(&mut v0, b"warmup_balance", 0x2::balance::zero<T0>());
        0x2::dynamic_field::add<vector<u8>, 0x2::balance::Balance<T1>>(&mut v0, b"premium_balance", 0x2::balance::zero<T1>());
        0x2::dynamic_field::add<vector<u8>, 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::BigVector<DepositShare>>(&mut v0, b"deposit_shares", 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::new<DepositShare>(1000, arg3));
        let v3 = DepositVault{
            id                        : v0,
            deposit_token             : v1,
            bid_token                 : v2,
            incentive_token           : 0x1::option::none<0x1::type_name::TypeName>(),
            index                     : arg0,
            fee_bp                    : arg1,
            fee_share_bp              : 0,
            shared_fee_pool           : 0x1::option::none<vector<u8>>(),
            active_share_supply       : 0,
            deactivating_share_supply : 0,
            inactive_share_supply     : 0,
            warmup_share_supply       : 0,
            premium_share_supply      : 0,
            incentive_share_supply    : 0,
            has_next                  : true,
            metadata                  : arg2,
            u64_padding               : 0x1::vector::empty<u64>(),
            bcs_padding               : 0x1::vector::empty<u8>(),
        };
        let v4 = NewDepositVault{
            signer        : 0x2::tx_context::sender(arg3),
            index         : arg0,
            deposit_token : v1,
            bid_token     : v2,
        };
        0x2::event::emit<NewDepositVault>(v4);
        v3
    }

    public fun new_refund_vault<T0>(arg0: &mut 0x2::tx_context::TxContext) : RefundVault {
        let v0 = 0x2::object::new(arg0);
        let v1 = 0x1::type_name::get<T0>();
        0x2::dynamic_field::add<vector<u8>, 0x2::balance::Balance<T0>>(&mut v0, b"refund_balance", 0x2::balance::zero<T0>());
        0x2::dynamic_field::add<vector<u8>, 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::BigVector<RefundShare>>(&mut v0, b"refund_shares", 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::new<RefundShare>(4500, arg0));
        let v2 = RefundVault{
            id           : v0,
            token        : v1,
            share_supply : 0,
            u64_padding  : 0x1::vector::empty<u64>(),
            bcs_padding  : 0x1::vector::empty<u8>(),
        };
        let v3 = NewRefundVault{
            signer : 0x2::tx_context::sender(arg0),
            token  : v1,
        };
        0x2::event::emit<NewRefundVault>(v3);
        v2
    }

    fun new_typus_bid_receipt(arg0: &BidVault, arg1: &mut 0x2::tx_context::TxContext) : TypusBidReceipt {
        TypusBidReceipt{
            id          : 0x2::object::new(arg1),
            vid         : 0x2::object::id<BidVault>(arg0),
            index       : arg0.index,
            metadata    : arg0.metadata,
            u64_padding : 0x1::vector::empty<u64>(),
        }
    }

    public fun new_typus_deposit_receipt(arg0: &DepositVault, arg1: &mut 0x2::tx_context::TxContext) : TypusDepositReceipt {
        TypusDepositReceipt{
            id          : 0x2::object::new(arg1),
            vid         : 0x2::object::id<DepositVault>(arg0),
            index       : arg0.index,
            metadata    : arg0.metadata,
            u64_padding : 0x1::vector::empty<u64>(),
        }
    }

    public fun premium_balance<T0>(arg0: &DepositVault) : u64 {
        0x2::balance::value<T0>(get_deposit_vault_balance<T0>(arg0, 4))
    }

    public fun premium_share_supply(arg0: &DepositVault) : u64 {
        arg0.premium_share_supply
    }

    public fun put_refund<T0>(arg0: &mut RefundVault, arg1: 0x2::balance::Balance<T0>, arg2: address) {
        assert!(0x1::type_name::get<T0>() == arg0.token, 1);
        let v0 = 0x2::balance::value<T0>(&arg1);
        arg0.share_supply = arg0.share_supply + v0;
        0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<vector<u8>, 0x2::balance::Balance<T0>>(&mut arg0.id, b"refund_balance"), arg1);
        let v1 = 0x2::dynamic_field::borrow_mut<vector<u8>, 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::BigVector<RefundShare>>(&mut arg0.id, b"refund_shares");
        let v2 = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::length<RefundShare>(v1);
        let v3 = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::slice_size<RefundShare>(v1);
        let v4 = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::borrow_slice_mut<RefundShare>(v1, 1);
        let v5 = 0;
        while (v5 < v2) {
            let v6 = 0x1::vector::borrow_mut<RefundShare>(v4, v5 % v3);
            if (v6.user == arg2) {
                v6.share = v6.share + v0;
                return
            };
            if (v5 + 1 < v2 && (v5 + 1) % v3 == 0) {
                v4 = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::borrow_slice_mut<RefundShare>(v1, 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::slice_id<RefundShare>(v1, v5 + 1));
            };
            v5 = v5 + 1;
        };
        let v7 = RefundShare{
            user        : arg2,
            share       : v0,
            u64_padding : 0x1::vector::empty<u64>(),
        };
        0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::push_back<RefundShare>(v1, v7);
    }

    public fun recoup<T0>(arg0: &mut DepositVault, arg1: u64, arg2: &0x2::tx_context::TxContext) : (u64, u64) {
        assert!(0x1::type_name::get<T0>() == arg0.deposit_token, 1);
        let v0 = arg0.has_next;
        let v1 = 0;
        let v2 = 0;
        let v3 = active_balance<T0>(arg0) + deactivating_balance<T0>(arg0);
        if (v3 > 0 && arg1 > 0) {
            let v4 = get_mut_deposit_shares(arg0);
            let v5 = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::length<DepositShare>(v4);
            let v6 = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::slice_size<DepositShare>(v4);
            let v7 = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::borrow_slice_mut<DepositShare>(v4, 1);
            let v8 = 0;
            while (v8 < v5) {
                let v9 = 0x1::vector::borrow_mut<DepositShare>(v7, v8 % v6);
                let v10 = v9.active_share + v9.deactivating_share;
                if (v10 > 0) {
                    let v11 = (((v10 as u128) * (arg1 as u128) / (v3 as u128)) as u64);
                    if (v9.deactivating_share >= v11) {
                        v9.deactivating_share = v9.deactivating_share - v11;
                        v9.inactive_share = v9.inactive_share + v11;
                        v2 = v2 + v11;
                    } else {
                        v9.active_share = v9.active_share - v11 - v9.deactivating_share;
                        if (v0) {
                            v9.warmup_share = v9.warmup_share + v11 - v9.deactivating_share;
                        } else {
                            v9.inactive_share = v9.inactive_share + v11 - v9.deactivating_share;
                        };
                        v1 = v1 + v11 - v9.deactivating_share;
                        v9.inactive_share = v9.inactive_share + v9.deactivating_share;
                        v2 = v2 + v9.deactivating_share;
                        v9.deactivating_share = 0;
                    };
                    arg1 = arg1 - v11;
                    v3 = v3 - v10;
                };
                if (v8 + 1 < v5 && (v8 + 1) % v6 == 0) {
                    v7 = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::borrow_slice_mut<DepositShare>(v4, 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::slice_id<DepositShare>(v4, v8 + 1));
                };
                v8 = v8 + 1;
            };
        };
        let v12 = get_mut_deposit_vault_balance<T0>(arg0, 0);
        let v13 = 0x2::balance::split<T0>(v12, v1);
        if (v0) {
            let v14 = get_mut_deposit_vault_balance<T0>(arg0, 3);
            0x2::balance::join<T0>(v14, v13);
        } else {
            let v15 = get_mut_deposit_vault_balance<T0>(arg0, 2);
            0x2::balance::join<T0>(v15, v13);
        };
        let v16 = get_mut_deposit_vault_balance<T0>(arg0, 1);
        let v17 = 0x2::balance::split<T0>(v16, v2);
        let v18 = get_mut_deposit_vault_balance<T0>(arg0, 2);
        0x2::balance::join<T0>(v18, v17);
        arg0.active_share_supply = arg0.active_share_supply - v1;
        if (v0) {
            arg0.warmup_share_supply = arg0.warmup_share_supply + v1;
        } else {
            arg0.inactive_share_supply = arg0.inactive_share_supply + v1;
        };
        arg0.deactivating_share_supply = arg0.deactivating_share_supply - v2;
        arg0.inactive_share_supply = arg0.inactive_share_supply + v2;
        let v19 = Recoup{
            signer       : 0x2::tx_context::sender(arg2),
            index        : arg0.index,
            token        : 0x1::type_name::get<T0>(),
            active       : v1,
            deactivating : v2,
        };
        0x2::event::emit<Recoup>(v19);
        (v1, v2)
    }

    public fun redeem<T0>(arg0: &mut DepositVault, arg1: vector<TypusDepositReceipt>, arg2: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(0x1::type_name::get<T0>() == arg0.deposit_token, 1);
        let v0 = 0x2::tx_context::sender(arg2);
        let (v1, v2, v3, v4, v5, v6, v7) = extract_deposit_shares(arg0, arg1);
        let v8 = v6;
        if (v6 > 0) {
            let v9 = get_mut_deposit_vault_balance<T0>(arg0, 5);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v9, v6), arg2), v0);
            v8 = v6 - v6;
            arg0.incentive_share_supply = arg0.incentive_share_supply - v6;
        };
        add_deposit_share(arg0, v1, v2, v3, v4, v5, v8, v7, arg2);
        let v10 = Redeem{
            signer : v0,
            index  : arg0.index,
            token  : 0x1::type_name::get<T0>(),
            amount : v8,
        };
        0x2::event::emit<Redeem>(v10);
        v8
    }

    public fun refund_vault_balance<T0>(arg0: &RefundVault) : u64 {
        0x2::balance::value<T0>(0x2::dynamic_field::borrow<vector<u8>, 0x2::balance::Balance<T0>>(&arg0.id, b"refund_balance"))
    }

    public fun refund_vault_share_supply(arg0: &RefundVault) : u64 {
        arg0.share_supply
    }

    fun remove_bid_share(arg0: &mut BidVault, arg1: address) : BidShare {
        let v0 = get_mut_bid_shares(arg0);
        let v1 = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::length<BidShare>(v0);
        let v2 = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::slice_size<BidShare>(v0);
        let v3 = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::borrow_slice_mut<BidShare>(v0, 1);
        let v4 = 0;
        while (v4 < v1) {
            if (0x1::vector::borrow_mut<BidShare>(v3, v4 % v2).receipt == arg1) {
                break
            };
            if (v4 + 1 < v1 && (v4 + 1) % v2 == 0) {
                v3 = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::borrow_slice_mut<BidShare>(v0, 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::slice_id<BidShare>(v0, v4 + 1));
            };
            v4 = v4 + 1;
        };
        let v5 = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::swap_remove<BidShare>(v0, v4);
        arg0.share_supply = arg0.share_supply - v5.share;
        v5
    }

    public fun set_bid_vault_u64_padding_value(arg0: &mut BidVault, arg1: u64, arg2: u64) {
        0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::utils::set_u64_padding_value(&mut arg0.u64_padding, arg1, arg2);
    }

    public fun settle<T0, T1>(arg0: &mut DepositVault, arg1: &mut BidVault, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 0);
        assert!(0x1::type_name::get<T0>() == arg0.deposit_token, 1);
        assert!(0x1::type_name::get<T1>() == arg0.bid_token, 1);
        assert!(0x1::type_name::get<T0>() == arg1.deposit_token, 1);
        assert!(0x1::type_name::get<T1>() == arg1.bid_token, 1);
        let v0 = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::utils::multiplier(arg3);
        if (active_balance<T0>(arg0) + deactivating_balance<T0>(arg0) != 0) {
            if (arg2 < v0) {
                let v1 = active_share_supply(arg0) + deactivating_share_supply(arg0);
                let v2 = (v1 as u256) * ((v0 - arg2) as u256) / (v0 as u256);
                let v3 = ((v2 * (arg0.active_share_supply as u256) / (v1 as u256)) as u64);
                let v4 = get_mut_deposit_vault_balance<T0>(arg0, 0);
                let v5 = 0x2::balance::split<T0>(v4, v3);
                let v6 = ((v2 * (arg0.deactivating_share_supply as u256) / (v1 as u256)) as u64);
                let v7 = get_mut_deposit_vault_balance<T0>(arg0, 1);
                let v8 = get_mut_bid_vault_balance<T0>(arg1);
                0x2::balance::join<T0>(v8, v5);
                0x2::balance::join<T0>(get_mut_bid_vault_balance<T0>(arg1), 0x2::balance::split<T0>(v7, v6));
            };
            let v9 = active_balance<T0>(arg0);
            let v10 = arg0.active_share_supply;
            let v11 = deactivating_balance<T0>(arg0);
            let v12 = arg0.deactivating_share_supply;
            let v13 = arg0.has_next;
            let v14 = get_mut_deposit_shares(arg0);
            let v15 = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::length<DepositShare>(v14);
            let v16 = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::slice_size<DepositShare>(v14);
            let v17 = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::borrow_slice_mut<DepositShare>(v14, 1);
            let v18 = 0;
            while (v18 < v15) {
                let v19 = 0x1::vector::borrow_mut<DepositShare>(v17, v18 % v16);
                if (v19.active_share > 0) {
                    let v20 = (((v9 as u128) * (v19.active_share as u128) / (v10 as u128)) as u64);
                    v9 = v9 - v20;
                    v10 = v10 - v19.active_share;
                    if (!v13) {
                        v19.inactive_share = v19.inactive_share + v20;
                        v19.active_share = 0;
                    } else {
                        v19.active_share = v20;
                    };
                };
                if (v19.deactivating_share > 0) {
                    let v21 = (((v11 as u128) * (v19.deactivating_share as u128) / (v12 as u128)) as u64);
                    v11 = v11 - v21;
                    v12 = v12 - v19.deactivating_share;
                    v19.inactive_share = v19.inactive_share + v21;
                    v19.deactivating_share = 0;
                };
                if (v18 + 1 < v15 && (v18 + 1) % v16 == 0) {
                    v17 = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::borrow_slice_mut<DepositShare>(v14, 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::slice_id<DepositShare>(v14, v18 + 1));
                };
                v18 = v18 + 1;
            };
            if (!v13) {
                let v22 = active_balance<T0>(arg0);
                if (v22 > 0) {
                    let v23 = get_mut_deposit_vault_balance<T0>(arg0, 0);
                    let v24 = 0x2::balance::split<T0>(v23, v22);
                    let v25 = get_mut_deposit_vault_balance<T0>(arg0, 2);
                    0x2::balance::join<T0>(v25, v24);
                };
            };
            let v26 = deactivating_balance<T0>(arg0);
            if (v26 > 0) {
                let v27 = get_mut_deposit_vault_balance<T0>(arg0, 1);
                let v28 = 0x2::balance::split<T0>(v27, v26);
                let v29 = get_mut_deposit_vault_balance<T0>(arg0, 2);
                0x2::balance::join<T0>(v29, v28);
            };
            arg0.active_share_supply = active_balance<T0>(arg0);
            arg0.deactivating_share_supply = 0;
            arg0.inactive_share_supply = inactive_balance<T0>(arg0);
        };
        let v30 = Settle{
            signer              : 0x2::tx_context::sender(arg4),
            index               : arg0.index,
            deposit_token       : 0x1::type_name::get<T0>(),
            bid_token           : 0x1::type_name::get<T1>(),
            share_price         : arg2,
            share_price_decimal : arg3,
        };
        0x2::event::emit<Settle>(v30);
    }

    public fun summarize_bid_shares(arg0: &BidVault, arg1: vector<TypusBidReceipt>) : u64 {
        let v0 = 0;
        while (!0x1::vector::is_empty<TypusBidReceipt>(&arg1)) {
            let v1 = 0x1::vector::pop_back<TypusBidReceipt>(&mut arg1);
            verify_bid_receipt(arg0, &v1);
            let TypusBidReceipt {
                id          : v2,
                vid         : _,
                index       : _,
                metadata    : _,
                u64_padding : _,
            } = v1;
            let v7 = v2;
            0x2::object::delete(v7);
            let v8 = get_bid_shares(arg0);
            let v9 = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::length<BidShare>(v8);
            let v10 = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::slice_size<BidShare>(v8);
            let v11 = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::borrow_slice<BidShare>(v8, 1);
            let v12 = 0;
            while (v12 < v9) {
                let v13 = 0x1::vector::borrow<BidShare>(v11, v12 % v10);
                if (v13.receipt == 0x2::object::uid_to_address(&v7)) {
                    v0 = v0 + v13.share;
                    break
                };
                if (v12 + 1 < v9 && (v12 + 1) % v10 == 0) {
                    v11 = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::borrow_slice<BidShare>(v8, 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::slice_id<BidShare>(v8, v12 + 1));
                };
                v12 = v12 + 1;
            };
        };
        0x1::vector::destroy_empty<TypusBidReceipt>(arg1);
        v0
    }

    public fun summarize_deposit_shares(arg0: &DepositVault, arg1: vector<TypusDepositReceipt>) : (u64, u64, u64, u64, u64, u64) {
        let v0 = 0;
        let v1 = 0;
        let v2 = 0;
        let v3 = 0;
        let v4 = 0;
        let v5 = 0;
        while (!0x1::vector::is_empty<TypusDepositReceipt>(&arg1)) {
            let v6 = 0x1::vector::pop_back<TypusDepositReceipt>(&mut arg1);
            verify_deposit_receipt(arg0, &v6);
            let TypusDepositReceipt {
                id          : v7,
                vid         : _,
                index       : _,
                metadata    : _,
                u64_padding : _,
            } = v6;
            let v12 = v7;
            0x2::object::delete(v12);
            let v13 = get_deposit_shares(arg0);
            let v14 = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::length<DepositShare>(v13);
            let v15 = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::slice_size<DepositShare>(v13);
            let v16 = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::borrow_slice<DepositShare>(v13, 1);
            let v17 = 0;
            while (v17 < v14) {
                let v18 = 0x1::vector::borrow<DepositShare>(v16, v17 % v15);
                if (v18.receipt == 0x2::object::uid_to_address(&v12)) {
                    v0 = v0 + v18.active_share;
                    v1 = v1 + v18.deactivating_share;
                    v2 = v2 + v18.inactive_share;
                    v3 = v3 + v18.warmup_share;
                    v4 = v4 + v18.premium_share;
                    v5 = v5 + v18.incentive_share;
                    break
                };
                if (v17 + 1 < v14 && (v17 + 1) % v15 == 0) {
                    v16 = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::borrow_slice<DepositShare>(v13, 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::slice_id<DepositShare>(v13, v17 + 1));
                };
                v17 = v17 + 1;
            };
        };
        0x1::vector::destroy_empty<TypusDepositReceipt>(arg1);
        (v0, v1, v2, v3, v4, v5)
    }

    public fun take_refund<T0>(arg0: &mut RefundVault, arg1: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(0x1::type_name::get<T0>() == arg0.token, 1);
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x2::dynamic_field::borrow_mut<vector<u8>, 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::BigVector<RefundShare>>(&mut arg0.id, b"refund_shares");
        let v2 = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::length<RefundShare>(v1);
        let v3 = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::slice_size<RefundShare>(v1);
        let v4 = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::borrow_slice<RefundShare>(v1, 1);
        let v5 = 0;
        while (v5 < v2) {
            if (0x1::vector::borrow<RefundShare>(v4, v5 % v3).user == v0) {
                break
            };
            if (v5 + 1 < v2 && (v5 + 1) % v3 == 0) {
                v4 = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::borrow_slice<RefundShare>(v1, 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::slice_id<RefundShare>(v1, v5 + 1));
            };
            v5 = v5 + 1;
        };
        if (v5 == v2) {
            return 0
        };
        let RefundShare {
            user        : _,
            share       : v7,
            u64_padding : _,
        } = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::swap_remove<RefundShare>(v1, v5);
        arg0.share_supply = arg0.share_supply - v7;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(0x2::dynamic_field::borrow_mut<vector<u8>, 0x2::balance::Balance<T0>>(&mut arg0.id, b"refund_balance"), v7), arg1), v0);
        v7
    }

    public fun terminate<T0>(arg0: &mut DepositVault, arg1: &0x2::tx_context::TxContext) {
        assert!(0x1::type_name::get<T0>() == arg0.deposit_token, 1);
        let v0 = 0x2::dynamic_field::remove<vector<u8>, 0x2::balance::Balance<T0>>(&mut arg0.id, b"active_balance");
        let v1 = 0x2::dynamic_field::remove<vector<u8>, 0x2::balance::Balance<T0>>(&mut arg0.id, b"deactivating_balance");
        let v2 = 0x2::dynamic_field::remove<vector<u8>, 0x2::balance::Balance<T0>>(&mut arg0.id, b"warmup_balance");
        let v3 = get_mut_deposit_vault_balance<T0>(arg0, 2);
        0x2::balance::join<T0>(v3, v0);
        let v4 = get_mut_deposit_vault_balance<T0>(arg0, 2);
        0x2::balance::join<T0>(v4, v1);
        let v5 = get_mut_deposit_vault_balance<T0>(arg0, 2);
        0x2::balance::join<T0>(v5, v2);
        arg0.inactive_share_supply = arg0.inactive_share_supply + arg0.active_share_supply + arg0.deactivating_share_supply + arg0.warmup_share_supply;
        arg0.active_share_supply = 0;
        arg0.deactivating_share_supply = 0;
        arg0.warmup_share_supply = 0;
        let v6 = get_mut_deposit_shares(arg0);
        let v7 = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::length<DepositShare>(v6);
        let v8 = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::slice_size<DepositShare>(v6);
        let v9 = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::borrow_slice_mut<DepositShare>(v6, 1);
        let v10 = 0;
        while (v10 < v7) {
            let v11 = 0x1::vector::borrow_mut<DepositShare>(v9, v10 % v8);
            v11.inactive_share = v11.inactive_share + v11.active_share + v11.deactivating_share + v11.warmup_share;
            v11.active_share = 0;
            v11.deactivating_share = 0;
            v11.warmup_share = 0;
            if (v10 + 1 < v7 && (v10 + 1) % v8 == 0) {
                v9 = 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::borrow_slice_mut<DepositShare>(v6, 0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::big_vector::slice_id<DepositShare>(v6, v10 + 1));
            };
            v10 = v10 + 1;
        };
        arg0.has_next = false;
        let v12 = Terminate{
            signer : 0x2::tx_context::sender(arg1),
            index  : arg0.index,
            token  : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<Terminate>(v12);
    }

    public fun unsubscribe<T0>(arg0: &mut DepositVault, arg1: vector<TypusDepositReceipt>, arg2: 0x1::option::Option<u64>, arg3: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(0x1::type_name::get<T0>() == arg0.deposit_token, 1);
        let v0 = 0x2::tx_context::sender(arg3);
        let (v1, v2, v3, v4, v5, v6, v7) = extract_deposit_shares(arg0, arg1);
        let v8 = v2;
        let v9 = v1;
        let v10 = v1;
        if (0x1::option::is_some<u64>(&arg2)) {
            let v11 = 0x1::option::destroy_some<u64>(arg2);
            if (v11 < v1) {
                v10 = v11;
            };
        };
        if (v10 > 0) {
            let v12 = get_mut_deposit_vault_balance<T0>(arg0, 0);
            let v13 = 0x2::balance::split<T0>(v12, v10);
            v9 = v1 - v10;
            arg0.active_share_supply = arg0.active_share_supply - v10;
            let v14 = get_mut_deposit_vault_balance<T0>(arg0, 1);
            0x2::balance::join<T0>(v14, v13);
            v8 = v2 + v10;
            arg0.deactivating_share_supply = arg0.deactivating_share_supply + v10;
        };
        add_deposit_share(arg0, v9, v8, v3, v4, v5, v6, v7, arg3);
        let v15 = Unsubscribe{
            signer : v0,
            index  : arg0.index,
            token  : 0x1::type_name::get<T0>(),
            amount : v10,
        };
        0x2::event::emit<Unsubscribe>(v15);
        v10
    }

    public fun update_deposit_receipt_display(arg0: &mut DepositVault, arg1: 0x1::string::String) {
        arg0.metadata = arg1;
    }

    public fun update_deposit_vault_incentive_token<T0>(arg0: &mut DepositVault) {
        0x1::option::swap_or_fill<0x1::type_name::TypeName>(&mut arg0.incentive_token, 0x1::type_name::get<T0>());
        0x2::dynamic_field::add<vector<u8>, 0x2::balance::Balance<T0>>(&mut arg0.id, b"incentive_balance", 0x2::balance::zero<T0>());
    }

    public fun update_fee(arg0: &mut DepositVault, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        arg0.fee_bp = arg1;
        let v0 = UpdateFeeConfig{
            signer      : 0x2::tx_context::sender(arg2),
            index       : arg0.index,
            prev_fee_bp : arg0.fee_bp,
            fee_bp      : arg0.fee_bp,
        };
        0x2::event::emit<UpdateFeeConfig>(v0);
    }

    public fun update_fee_share(arg0: &mut DepositVault, arg1: u64, arg2: 0x1::option::Option<vector<u8>>, arg3: &0x2::tx_context::TxContext) {
        arg0.fee_share_bp = arg1;
        arg0.shared_fee_pool = arg2;
        let v0 = UpdateFeeShareConfig{
            signer               : 0x2::tx_context::sender(arg3),
            index                : arg0.index,
            prev_fee_bp          : arg0.fee_share_bp,
            prev_shared_fee_pool : arg0.shared_fee_pool,
            fee_bp               : arg0.fee_share_bp,
            shared_fee_pool      : arg0.shared_fee_pool,
        };
        0x2::event::emit<UpdateFeeShareConfig>(v0);
    }

    fun verify_bid_receipt(arg0: &BidVault, arg1: &TypusBidReceipt) {
        assert!(0x2::object::id<BidVault>(arg0) == arg1.vid && arg0.index == arg1.index, 3);
    }

    fun verify_deposit_receipt(arg0: &DepositVault, arg1: &TypusDepositReceipt) {
        assert!(0x2::object::id<DepositVault>(arg0) == arg1.vid && arg0.index == arg1.index, 3);
    }

    public fun warmup_balance<T0>(arg0: &DepositVault) : u64 {
        0x2::balance::value<T0>(get_deposit_vault_balance<T0>(arg0, 3))
    }

    public fun warmup_share_supply(arg0: &DepositVault) : u64 {
        arg0.warmup_share_supply
    }

    public fun withdraw<T0>(arg0: &mut DepositVault, arg1: vector<TypusDepositReceipt>, arg2: 0x1::option::Option<u64>, arg3: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(0x1::type_name::get<T0>() == arg0.deposit_token, 1);
        let v0 = 0x2::tx_context::sender(arg3);
        let (v1, v2, v3, v4, v5, v6, v7) = extract_deposit_shares(arg0, arg1);
        let v8 = v4;
        let v9 = v4;
        if (0x1::option::is_some<u64>(&arg2)) {
            let v10 = 0x1::option::destroy_some<u64>(arg2);
            if (v10 < v4) {
                v9 = v10;
            };
        };
        if (v9 > 0) {
            let v11 = get_mut_deposit_vault_balance<T0>(arg0, 3);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v11, v9), arg3), v0);
            v8 = v4 - v9;
            arg0.warmup_share_supply = arg0.warmup_share_supply - v9;
        };
        add_deposit_share(arg0, v1, v2, v3, v8, v5, v6, v7, arg3);
        let v12 = Withdraw{
            signer : v0,
            index  : arg0.index,
            token  : 0x1::type_name::get<T0>(),
            amount : v9,
        };
        0x2::event::emit<Withdraw>(v12);
        v9
    }

    // decompiled from Move bytecode v6
}

