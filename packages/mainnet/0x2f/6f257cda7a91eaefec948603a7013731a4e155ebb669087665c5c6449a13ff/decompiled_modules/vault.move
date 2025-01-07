module 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::vault {
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
        abort 999
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
            let v8 = 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::length<DepositShare>(v7);
            let v9 = 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::slice_size<DepositShare>(v7);
            let v10 = 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::borrow_slice_mut<DepositShare>(v7, 1);
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
                    v10 = 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::borrow_slice_mut<DepositShare>(v7, 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::slice_id<DepositShare>(v7, v11 + 1));
                };
                v11 = v11 + 1;
            };
        };
        arg0.has_next = arg1;
        v0
    }

    public fun active_balance<T0>(arg0: &DepositVault) : u64 {
        0x2::balance::value<T0>(get_deposit_vault_balance<T0>(arg0, 0))
    }

    public fun active_share_supply(arg0: &DepositVault) : u64 {
        arg0.active_share_supply
    }

    public fun active_share_tag() : u8 {
        0
    }

    fun add_deposit_share(arg0: &mut DepositVault, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: vector<u64>, arg8: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<TypusDepositReceipt> {
        if (arg1 != 0 || arg2 != 0 || arg3 != 0 || arg4 != 0 || arg5 != 0 || arg6 != 0) {
            let v0 = new_typus_deposit_receipt(arg0, arg8);
            let v1 = DepositShare{
                receipt            : 0x2::object::id_address<TypusDepositReceipt>(&v0),
                active_share       : arg1,
                deactivating_share : arg2,
                inactive_share     : arg3,
                warmup_share       : arg4,
                premium_share      : arg5,
                incentive_share    : arg6,
                u64_padding        : arg7,
            };
            0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::push_back<DepositShare>(get_mut_deposit_shares(arg0), v1);
            return 0x1::option::some<TypusDepositReceipt>(v0)
        };
        0x1::option::none<TypusDepositReceipt>()
    }

    public fun adjust_user_share_ratio<T0>(arg0: &mut DepositVault, arg1: u8) {
        let v0 = 0x2::balance::value<T0>(get_deposit_vault_balance<T0>(arg0, arg1));
        let v1 = v0;
        let v2 = get_mut_deposit_vault_share_supply(arg0, arg1);
        *v2 = v0;
        let v3 = 0;
        let v4 = get_deposit_shares(arg0);
        let v5 = 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::length<DepositShare>(v4);
        let v6 = 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::slice_size<DepositShare>(v4);
        let v7 = 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::borrow_slice<DepositShare>(v4, 1);
        let v8 = 0;
        while (v8 < v5) {
            v3 = v3 + get_deposit_share_inner(0x1::vector::borrow<DepositShare>(v7, v8 % v6), arg1);
            if (v8 + 1 < v5 && (v8 + 1) % v6 == 0) {
                v7 = 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::borrow_slice<DepositShare>(v4, 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::slice_id<DepositShare>(v4, v8 + 1));
            };
            v8 = v8 + 1;
        };
        let v9 = get_mut_deposit_shares(arg0);
        let v10 = 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::length<DepositShare>(v9);
        let v11 = 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::slice_size<DepositShare>(v9);
        let v12 = 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::borrow_slice_mut<DepositShare>(v9, 1);
        let v13 = 0;
        while (v13 < v10) {
            let v14 = 0x1::vector::borrow_mut<DepositShare>(v12, v13 % v11);
            let v15 = get_mut_deposit_share_inner(v14, arg1);
            if (*v15 > 0) {
                let v16 = (((v1 as u128) * (*v15 as u128) / (v3 as u128)) as u64);
                v1 = v1 - v16;
                v3 = v3 - *v15;
                *v15 = v16;
            };
            if (v13 + 1 < v10 && (v13 + 1) % v11 == 0) {
                v12 = 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::borrow_slice_mut<DepositShare>(v9, 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::slice_id<DepositShare>(v9, v13 + 1));
            };
            v13 = v13 + 1;
        };
        assert!(v1 == 0, 0);
        assert!(v3 == 0, 1);
        assert!(0x2::balance::value<T0>(get_deposit_vault_balance<T0>(arg0, arg1)) == get_deposit_vault_share_supply(arg0, arg1), 2);
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

    public fun calculate_exercise_value<T0>(arg0: &BidVault, arg1: &TypusBidReceipt) : u64 {
        assert!(0x1::type_name::get<T0>() == arg0.deposit_token, 1);
        assert!(0x1::option::is_none<0x1::type_name::TypeName>(&arg0.incentive_token), 1);
        let (_, _, v2) = get_bid_receipt_info(arg1);
        let v3 = v2;
        (((0x2::balance::value<T0>(get_bid_vault_balance<T0>(arg0)) as u128) * (*0x1::vector::borrow<u64>(&v3, 0) as u128) / (arg0.share_supply as u128)) as u64)
    }

    public fun calculate_exercise_value_for_receipts<T0>(arg0: &BidVault, arg1: &vector<TypusBidReceipt>) : u64 {
        assert!(0x1::type_name::get<T0>() == arg0.deposit_token, 1);
        assert!(0x1::option::is_none<0x1::type_name::TypeName>(&arg0.incentive_token), 1);
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<TypusBidReceipt>(arg1)) {
            let (_, _, v4) = get_bid_receipt_info(0x1::vector::borrow<TypusBidReceipt>(arg1, v1));
            let v5 = v4;
            v0 = v0 + *0x1::vector::borrow<u64>(&v5, 0);
            v1 = v1 + 1;
        };
        (((0x2::balance::value<T0>(get_bid_vault_balance<T0>(arg0)) as u128) * (v0 as u128) / (arg0.share_supply as u128)) as u64)
    }

    public fun charge_fee<T0>(arg0: &mut 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::balance_pool::BalancePool, arg1: &DepositVault, arg2: &mut 0x2::balance::Balance<T0>) : (u64, u64) {
        let v0 = (((0x2::balance::value<T0>(arg2) as u128) * (arg1.fee_bp as u128) / 10000) as u64);
        let v1 = 0x2::balance::split<T0>(arg2, v0);
        let v2 = (((0x2::balance::value<T0>(&v1) as u128) * (arg1.fee_share_bp as u128) / 10000) as u64);
        if (v2 > 0 && 0x1::option::is_some<vector<u8>>(&arg1.shared_fee_pool)) {
            0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::balance_pool::put_shared<T0>(arg0, *0x1::option::borrow<vector<u8>>(&arg1.shared_fee_pool), 0x2::balance::split<T0>(&mut v1, v2));
        };
        0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::balance_pool::put<T0>(arg0, v1);
        (v0 - v2, v2)
    }

    public fun close(arg0: &mut DepositVault) {
        arg0.has_next = false;
    }

    public fun compound<T0>(arg0: &mut 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::balance_pool::BalancePool, arg1: &mut DepositVault, arg2: vector<TypusDepositReceipt>, arg3: &mut 0x2::tx_context::TxContext) : u64 {
        abort 999
    }

    public fun compound_v2<T0>(arg0: &mut 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::balance_pool::BalancePool, arg1: &mut DepositVault, arg2: vector<TypusDepositReceipt>, arg3: &mut 0x2::tx_context::TxContext) : (u64, u64, u64, 0x1::option::Option<vector<u8>>) {
        abort 999
    }

    public fun deactivating_balance<T0>(arg0: &DepositVault) : u64 {
        0x2::balance::value<T0>(get_deposit_vault_balance<T0>(arg0, 1))
    }

    public fun deactivating_share_supply(arg0: &DepositVault) : u64 {
        arg0.deactivating_share_supply
    }

    public fun deactivating_share_tag() : u8 {
        1
    }

    public fun delegate_exercise<T0>(arg0: &mut BidVault, arg1: vector<TypusBidReceipt>) : (u64, u64, 0x2::balance::Balance<T0>) {
        let (v0, v1) = public_exercise<T0>(arg0, arg1);
        let v2 = v1;
        (*0x1::vector::borrow<u64>(&v2, 0), *0x1::vector::borrow<u64>(&v2, 1), v0)
    }

    public fun delegate_take_refund<T0>(arg0: &mut RefundVault, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        abort 999
    }

    public fun delivery<T0, T1>(arg0: &mut DepositVault, arg1: &mut BidVault, arg2: 0x2::balance::Balance<T1>) {
        assert!(0x1::type_name::get<T0>() == arg0.deposit_token, 1);
        assert!(0x1::type_name::get<T1>() == arg0.bid_token, 1);
        assert!(0x1::type_name::get<T0>() == arg1.deposit_token, 1);
        assert!(0x1::type_name::get<T1>() == arg1.bid_token, 1);
        let v0 = 0x2::balance::value<T1>(&arg2);
        let v1 = v0;
        let v2 = get_mut_deposit_vault_balance<T1>(arg0, 4);
        0x2::balance::join<T1>(v2, arg2);
        arg0.premium_share_supply = arg0.premium_share_supply + v0;
        let v3 = active_share_supply(arg0) + deactivating_share_supply(arg0);
        let v4 = get_mut_deposit_shares(arg0);
        let v5 = 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::length<DepositShare>(v4);
        let v6 = 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::slice_size<DepositShare>(v4);
        let v7 = 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::borrow_slice_mut<DepositShare>(v4, 1);
        let v8 = 0;
        while (v8 < v5) {
            let v9 = 0x1::vector::borrow_mut<DepositShare>(v7, v8 % v6);
            if (v9.active_share > 0) {
                let v10 = (((v1 as u128) * (v9.active_share as u128) / (v3 as u128)) as u64);
                v9.premium_share = v9.premium_share + v10;
                v1 = v1 - v10;
                v3 = v3 - v9.active_share;
            };
            if (v9.deactivating_share > 0) {
                let v11 = (((v1 as u128) * (v9.deactivating_share as u128) / (v3 as u128)) as u64);
                v9.premium_share = v9.premium_share + v11;
                v1 = v1 - v11;
                v3 = v3 - v9.deactivating_share;
            };
            if (v8 + 1 < v5 && (v8 + 1) % v6 == 0) {
                v7 = 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::borrow_slice_mut<DepositShare>(v4, 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::slice_id<DepositShare>(v4, v8 + 1));
            };
            v8 = v8 + 1;
        };
    }

    public fun delivery_b<T0, T1>(arg0: &mut DepositVault, arg1: &mut BidVault, arg2: 0x2::balance::Balance<T1>, arg3: 0x2::balance::Balance<T1>, arg4: &0x2::tx_context::TxContext) {
        assert!(0x1::type_name::get<T0>() == arg0.deposit_token, 1);
        assert!(0x1::type_name::get<T1>() == arg0.bid_token, 1);
        assert!(0x1::type_name::get<T0>() == arg1.deposit_token, 1);
        assert!(0x1::type_name::get<T1>() == arg1.bid_token, 1);
        0x2::balance::join<T1>(&mut arg2, arg3);
        let v0 = 0x2::balance::value<T1>(&arg2);
        let v1 = v0;
        let v2 = get_mut_deposit_vault_balance<T1>(arg0, 4);
        0x2::balance::join<T1>(v2, arg2);
        arg0.premium_share_supply = arg0.premium_share_supply + v0;
        let v3 = active_share_supply(arg0) + deactivating_share_supply(arg0);
        let v4 = get_mut_deposit_shares(arg0);
        let v5 = 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::length<DepositShare>(v4);
        let v6 = 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::slice_size<DepositShare>(v4);
        let v7 = 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::borrow_slice_mut<DepositShare>(v4, 1);
        let v8 = 0;
        while (v8 < v5) {
            let v9 = 0x1::vector::borrow_mut<DepositShare>(v7, v8 % v6);
            if (v9.active_share > 0) {
                let v10 = (((v1 as u128) * (v9.active_share as u128) / (v3 as u128)) as u64);
                v9.premium_share = v9.premium_share + v10;
                v1 = v1 - v10;
                v3 = v3 - v9.active_share;
            };
            if (v9.deactivating_share > 0) {
                let v11 = (((v1 as u128) * (v9.deactivating_share as u128) / (v3 as u128)) as u64);
                v9.premium_share = v9.premium_share + v11;
                v1 = v1 - v11;
                v3 = v3 - v9.deactivating_share;
            };
            if (v8 + 1 < v5 && (v8 + 1) % v6 == 0) {
                v7 = 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::borrow_slice_mut<DepositShare>(v4, 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::slice_id<DepositShare>(v4, v8 + 1));
            };
            v8 = v8 + 1;
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
        let v4 = get_mut_deposit_vault_balance<T1>(arg0, 4);
        0x2::balance::join<T1>(v4, arg2);
        arg0.premium_share_supply = arg0.premium_share_supply + v0;
        let v5 = get_mut_deposit_vault_balance<T0>(arg0, 3);
        0x2::balance::join<T0>(v5, arg3);
        arg0.warmup_share_supply = arg0.warmup_share_supply + v2;
        let v6 = active_share_supply(arg0) + deactivating_share_supply(arg0);
        let v7 = get_mut_deposit_shares(arg0);
        let v8 = 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::length<DepositShare>(v7);
        let v9 = 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::slice_size<DepositShare>(v7);
        let v10 = 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::borrow_slice_mut<DepositShare>(v7, 1);
        let v11 = 0;
        while (v11 < v8) {
            let v12 = 0x1::vector::borrow_mut<DepositShare>(v10, v11 % v9);
            if (v12.active_share > 0) {
                let v13 = (((v1 as u128) * (v12.active_share as u128) / (v6 as u128)) as u64);
                let v14 = (((v3 as u128) * (v12.active_share as u128) / (v6 as u128)) as u64);
                v12.premium_share = v12.premium_share + v13;
                v12.warmup_share = v12.warmup_share + v14;
                v1 = v1 - v13;
                v3 = v3 - v14;
                v6 = v6 - v12.active_share;
            };
            if (v12.deactivating_share > 0) {
                let v15 = (((v1 as u128) * (v12.deactivating_share as u128) / (v6 as u128)) as u64);
                let v16 = (((v3 as u128) * (v12.deactivating_share as u128) / (v6 as u128)) as u64);
                v12.premium_share = v12.premium_share + v15;
                v12.warmup_share = v12.warmup_share + v16;
                v1 = v1 - v15;
                v3 = v3 - v16;
                v6 = v6 - v12.deactivating_share;
            };
            if (v11 + 1 < v8 && (v11 + 1) % v9 == 0) {
                v10 = 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::borrow_slice_mut<DepositShare>(v7, 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::slice_id<DepositShare>(v7, v11 + 1));
            };
            v11 = v11 + 1;
        };
    }

    public fun delivery_i<T0, T1, T2>(arg0: &mut DepositVault, arg1: &mut BidVault, arg2: 0x2::balance::Balance<T1>, arg3: 0x2::balance::Balance<T2>, arg4: &0x2::tx_context::TxContext) {
        assert!(0x1::type_name::get<T0>() == arg0.deposit_token, 1);
        assert!(0x1::type_name::get<T1>() == arg0.bid_token, 1);
        assert!(0x1::option::some<0x1::type_name::TypeName>(0x1::type_name::get<T2>()) == arg0.incentive_token, 1);
        assert!(0x1::type_name::get<T0>() == arg1.deposit_token, 1);
        assert!(0x1::type_name::get<T1>() == arg1.bid_token, 1);
        let v0 = 0x2::balance::value<T1>(&arg2);
        let v1 = v0;
        let v2 = 0x2::balance::value<T2>(&arg3);
        let v3 = v2;
        let v4 = get_mut_deposit_vault_balance<T1>(arg0, 4);
        0x2::balance::join<T1>(v4, arg2);
        arg0.premium_share_supply = arg0.premium_share_supply + v0;
        let v5 = get_mut_deposit_vault_balance<T2>(arg0, 5);
        0x2::balance::join<T2>(v5, arg3);
        arg0.incentive_share_supply = arg0.incentive_share_supply + v2;
        let v6 = active_share_supply(arg0) + deactivating_share_supply(arg0);
        let v7 = get_mut_deposit_shares(arg0);
        let v8 = 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::length<DepositShare>(v7);
        let v9 = 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::slice_size<DepositShare>(v7);
        let v10 = 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::borrow_slice_mut<DepositShare>(v7, 1);
        let v11 = 0;
        while (v11 < v8) {
            let v12 = 0x1::vector::borrow_mut<DepositShare>(v10, v11 % v9);
            if (v12.active_share > 0) {
                let v13 = (((v1 as u128) * (v12.active_share as u128) / (v6 as u128)) as u64);
                let v14 = (((v3 as u128) * (v12.active_share as u128) / (v6 as u128)) as u64);
                v12.premium_share = v12.premium_share + v13;
                v12.incentive_share = v12.incentive_share + v14;
                v1 = v1 - v13;
                v3 = v3 - v14;
                v6 = v6 - v12.active_share;
            };
            if (v12.deactivating_share > 0) {
                let v15 = (((v1 as u128) * (v12.deactivating_share as u128) / (v6 as u128)) as u64);
                let v16 = (((v3 as u128) * (v12.deactivating_share as u128) / (v6 as u128)) as u64);
                v12.premium_share = v12.premium_share + v15;
                v12.incentive_share = v12.incentive_share + v16;
                v1 = v1 - v15;
                v3 = v3 - v16;
                v6 = v6 - v12.deactivating_share;
            };
            if (v11 + 1 < v8 && (v11 + 1) % v9 == 0) {
                v10 = 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::borrow_slice_mut<DepositShare>(v7, 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::slice_id<DepositShare>(v7, v11 + 1));
            };
            v11 = v11 + 1;
        };
    }

    public fun deposit<T0>(arg0: &mut DepositVault, arg1: vector<0x2::coin::Coin<T0>>, arg2: u64, arg3: vector<TypusDepositReceipt>, arg4: &mut 0x2::tx_context::TxContext) : u64 {
        abort 999
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
        0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::destroy_empty<BidShare>(0x2::dynamic_field::remove<vector<u8>, 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::BigVector<BidShare>>(&mut v9, b"bid_shares"));
        0x2::object::delete(v9);
    }

    public fun drop_deposit_vault<T0, T1>(arg0: DepositVault) {
        let DepositVault {
            id                        : v0,
            deposit_token             : _,
            bid_token                 : _,
            incentive_token           : _,
            index                     : _,
            fee_bp                    : _,
            fee_share_bp              : _,
            shared_fee_pool           : _,
            active_share_supply       : _,
            deactivating_share_supply : _,
            inactive_share_supply     : _,
            warmup_share_supply       : _,
            premium_share_supply      : _,
            incentive_share_supply    : _,
            has_next                  : _,
            metadata                  : _,
            u64_padding               : _,
            bcs_padding               : _,
        } = arg0;
        let v18 = v0;
        if (0x2::dynamic_field::exists_<vector<u8>>(&v18, b"active_balance")) {
            0x2::balance::destroy_zero<T0>(0x2::dynamic_field::remove<vector<u8>, 0x2::balance::Balance<T0>>(&mut v18, b"active_balance"));
        };
        if (0x2::dynamic_field::exists_<vector<u8>>(&v18, b"deactivating_balance")) {
            0x2::balance::destroy_zero<T0>(0x2::dynamic_field::remove<vector<u8>, 0x2::balance::Balance<T0>>(&mut v18, b"deactivating_balance"));
        };
        if (0x2::dynamic_field::exists_<vector<u8>>(&v18, b"inactive_balance")) {
            0x2::balance::destroy_zero<T0>(0x2::dynamic_field::remove<vector<u8>, 0x2::balance::Balance<T0>>(&mut v18, b"inactive_balance"));
        };
        if (0x2::dynamic_field::exists_<vector<u8>>(&v18, b"warmup_balance")) {
            0x2::balance::destroy_zero<T0>(0x2::dynamic_field::remove<vector<u8>, 0x2::balance::Balance<T0>>(&mut v18, b"warmup_balance"));
        };
        if (0x2::dynamic_field::exists_<vector<u8>>(&v18, b"premium_balance")) {
            0x2::balance::destroy_zero<T1>(0x2::dynamic_field::remove<vector<u8>, 0x2::balance::Balance<T1>>(&mut v18, b"premium_balance"));
        };
        0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::destroy_empty<DepositShare>(0x2::dynamic_field::remove<vector<u8>, 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::BigVector<DepositShare>>(&mut v18, b"deposit_shares"));
        0x2::object::delete(v18);
    }

    public fun exercise<T0>(arg0: &mut BidVault, arg1: vector<TypusBidReceipt>, arg2: &mut 0x2::tx_context::TxContext) : u64 {
        abort 999
    }

    public fun exercise_i<T0, T1>(arg0: &mut BidVault, arg1: vector<TypusBidReceipt>, arg2: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        abort 999
    }

    public fun exercise_v2<T0>(arg0: &mut BidVault, arg1: vector<TypusBidReceipt>, arg2: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        abort 999
    }

    public fun extract_bid_shares(arg0: &mut BidVault, arg1: vector<TypusBidReceipt>) : (u64, vector<u64>) {
        let v0 = 0;
        let v1 = 0x1::vector::empty<u64>();
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
            0x2::object::delete(v8);
            let v9 = get_mut_bid_shares(arg0);
            let v10 = 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::length<BidShare>(v9);
            let v11 = 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::slice_size<BidShare>(v9);
            let v12 = 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::borrow_slice<BidShare>(v9, 1);
            let v13 = 0;
            while (v13 < v10) {
                if (0x1::vector::borrow<BidShare>(v12, v13 % v11).receipt == 0x2::object::uid_to_address(&v8)) {
                    let BidShare {
                        receipt     : _,
                        share       : v15,
                        u64_padding : v16,
                    } = 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::swap_remove<BidShare>(v9, v13);
                    let v17 = v16;
                    v0 = v0 + v15;
                    if (0x1::vector::length<u64>(&v17) > 0) {
                        if (0x1::vector::is_empty<u64>(&v1)) {
                            v1 = v17;
                            break
                        };
                        let v18 = 0;
                        while (0x1::vector::length<u64>(&v17) > 0) {
                            let v19 = 0x1::vector::borrow_mut<u64>(&mut v1, v18);
                            *v19 = *v19 + 0x1::vector::pop_back<u64>(&mut v17);
                            v18 = v18 + 1;
                        };
                    } else {
                        break
                    };
                } else {
                    if (v13 + 1 < v10 && (v13 + 1) % v11 == 0) {
                        v12 = 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::borrow_slice<BidShare>(v9, 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::slice_id<BidShare>(v9, v13 + 1));
                    };
                    v13 = v13 + 1;
                };
            };
        };
        0x1::vector::destroy_empty<TypusBidReceipt>(arg1);
        (v0, v1)
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
            let v15 = 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::length<DepositShare>(v14);
            let v16 = 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::slice_size<DepositShare>(v14);
            let v17 = 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::borrow_slice<DepositShare>(v14, 1);
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
                    } = 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::swap_remove<DepositShare>(v14, v18);
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
                        v17 = 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::borrow_slice<DepositShare>(v14, 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::slice_id<DepositShare>(v14, v18 + 1));
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
        let v1 = 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::length<DepositShare>(v0);
        let v2 = 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::slice_size<DepositShare>(v0);
        let v3 = 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::borrow_slice<DepositShare>(v0, 1);
        let v4 = 0;
        while (v4 < v1) {
            let v5 = 0x1::vector::borrow<DepositShare>(v3, v4 % v2);
            if (v5.receipt == arg1) {
                return get_deposit_share_inner(v5, 0)
            };
            if (v4 + 1 < v1 && (v4 + 1) % v2 == 0) {
                v3 = 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::borrow_slice<DepositShare>(v0, 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::slice_id<DepositShare>(v0, v4 + 1));
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
        let v1 = 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::length<BidShare>(v0);
        let v2 = 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::slice_size<BidShare>(v0);
        let v3 = 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::borrow_slice<BidShare>(v0, 1);
        let v4 = 0;
        while (v4 < v1) {
            let v5 = 0x1::vector::borrow<BidShare>(v3, v4 % v2);
            if (v5.receipt == arg1) {
                return v5.share
            };
            if (v4 + 1 < v1 && (v4 + 1) % v2 == 0) {
                v3 = 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::borrow_slice<BidShare>(v0, 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::slice_id<BidShare>(v0, v4 + 1));
            };
            v4 = v4 + 1;
        };
        0
    }

    public fun get_bid_shares(arg0: &BidVault) : &0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::BigVector<BidShare> {
        0x2::dynamic_field::borrow<vector<u8>, 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::BigVector<BidShare>>(&arg0.id, b"bid_shares")
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
        0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::utils::get_u64_padding_value(&arg0.u64_padding, arg1)
    }

    public fun get_deactivating_deposit_share(arg0: &DepositVault, arg1: address) : u64 {
        let v0 = get_deposit_shares(arg0);
        let v1 = 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::length<DepositShare>(v0);
        let v2 = 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::slice_size<DepositShare>(v0);
        let v3 = 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::borrow_slice<DepositShare>(v0, 1);
        let v4 = 0;
        while (v4 < v1) {
            let v5 = 0x1::vector::borrow<DepositShare>(v3, v4 % v2);
            if (v5.receipt == arg1) {
                return get_deposit_share_inner(v5, 1)
            };
            if (v4 + 1 < v1 && (v4 + 1) % v2 == 0) {
                v3 = 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::borrow_slice<DepositShare>(v0, 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::slice_id<DepositShare>(v0, v4 + 1));
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
        0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::borrow<DepositShare>(get_deposit_shares(arg0), arg1)
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
            arg0.incentive_share
        }
    }

    public fun get_deposit_shares(arg0: &DepositVault) : &0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::BigVector<DepositShare> {
        0x2::dynamic_field::borrow<vector<u8>, 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::BigVector<DepositShare>>(&arg0.id, b"deposit_shares")
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

    public fun get_deposit_vault_share_supply(arg0: &DepositVault, arg1: u8) : u64 {
        if (arg1 == 0) {
            arg0.active_share_supply
        } else if (arg1 == 1) {
            arg0.deactivating_share_supply
        } else if (arg1 == 2) {
            arg0.inactive_share_supply
        } else if (arg1 == 3) {
            arg0.warmup_share_supply
        } else if (arg1 == 4) {
            arg0.premium_share_supply
        } else {
            assert!(arg1 == 5, 2);
            arg0.incentive_share_supply
        }
    }

    public fun get_deposit_vault_token_types(arg0: &DepositVault) : (0x1::type_name::TypeName, 0x1::type_name::TypeName) {
        (arg0.deposit_token, arg0.bid_token)
    }

    public fun get_inactive_deposit_share(arg0: &DepositVault, arg1: address) : u64 {
        let v0 = get_deposit_shares(arg0);
        let v1 = 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::length<DepositShare>(v0);
        let v2 = 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::slice_size<DepositShare>(v0);
        let v3 = 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::borrow_slice<DepositShare>(v0, 1);
        let v4 = 0;
        while (v4 < v1) {
            let v5 = 0x1::vector::borrow<DepositShare>(v3, v4 % v2);
            if (v5.receipt == arg1) {
                return get_deposit_share_inner(v5, 2)
            };
            if (v4 + 1 < v1 && (v4 + 1) % v2 == 0) {
                v3 = 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::borrow_slice<DepositShare>(v0, 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::slice_id<DepositShare>(v0, v4 + 1));
            };
            v4 = v4 + 1;
        };
        0
    }

    public fun get_mut_active_share_supply(arg0: &mut DepositVault) : &mut u64 {
        &mut arg0.active_share_supply
    }

    fun get_mut_bid_shares(arg0: &mut BidVault) : &mut 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::BigVector<BidShare> {
        0x2::dynamic_field::borrow_mut<vector<u8>, 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::BigVector<BidShare>>(&mut arg0.id, b"bid_shares")
    }

    fun get_mut_bid_vault_balance<T0>(arg0: &mut BidVault) : &mut 0x2::balance::Balance<T0> {
        0x2::dynamic_field::borrow_mut<vector<u8>, 0x2::balance::Balance<T0>>(&mut arg0.id, b"bid_balance")
    }

    public fun get_mut_deactivating_share_supply(arg0: &mut DepositVault) : &mut u64 {
        &mut arg0.deactivating_share_supply
    }

    public fun get_mut_deposit_share_inner(arg0: &mut DepositShare, arg1: u8) : &mut u64 {
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
            &mut arg0.incentive_share
        }
    }

    public fun get_mut_deposit_shares(arg0: &mut DepositVault) : &mut 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::BigVector<DepositShare> {
        0x2::dynamic_field::borrow_mut<vector<u8>, 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::BigVector<DepositShare>>(&mut arg0.id, b"deposit_shares")
    }

    public fun get_mut_deposit_vault_balance<T0>(arg0: &mut DepositVault, arg1: u8) : &mut 0x2::balance::Balance<T0> {
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

    public fun get_mut_deposit_vault_share_supply(arg0: &mut DepositVault, arg1: u8) : &mut u64 {
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
            &mut arg0.incentive_share_supply
        }
    }

    public fun get_mut_inactive_share_supply(arg0: &mut DepositVault) : &mut u64 {
        &mut arg0.inactive_share_supply
    }

    public fun get_mut_incentive_share_supply(arg0: &mut DepositVault) : &mut u64 {
        &mut arg0.incentive_share_supply
    }

    public fun get_mut_premium_share_supply(arg0: &mut DepositVault) : &mut u64 {
        &mut arg0.premium_share_supply
    }

    public fun get_mut_warmup_share_supply(arg0: &mut DepositVault) : &mut u64 {
        &mut arg0.warmup_share_supply
    }

    public fun get_premium_deposit_share(arg0: &DepositVault, arg1: address) : u64 {
        let v0 = get_deposit_shares(arg0);
        let v1 = 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::length<DepositShare>(v0);
        let v2 = 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::slice_size<DepositShare>(v0);
        let v3 = 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::borrow_slice<DepositShare>(v0, 1);
        let v4 = 0;
        while (v4 < v1) {
            let v5 = 0x1::vector::borrow<DepositShare>(v3, v4 % v2);
            if (v5.receipt == arg1) {
                return get_deposit_share_inner(v5, 4)
            };
            if (v4 + 1 < v1 && (v4 + 1) % v2 == 0) {
                v3 = 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::borrow_slice<DepositShare>(v0, 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::slice_id<DepositShare>(v0, v4 + 1));
            };
            v4 = v4 + 1;
        };
        0
    }

    public fun get_refund_share(arg0: &RefundVault, arg1: address) : u64 {
        let v0 = get_refund_shares(arg0);
        let v1 = 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::length<RefundShare>(v0);
        let v2 = 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::slice_size<RefundShare>(v0);
        let v3 = 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::borrow_slice<RefundShare>(v0, 1);
        let v4 = 0;
        while (v4 < v1) {
            let v5 = 0x1::vector::borrow<RefundShare>(v3, v4 % v2);
            if (v5.user == arg1) {
                return v5.share
            };
            if (v4 + 1 < v1 && (v4 + 1) % v2 == 0) {
                v3 = 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::borrow_slice<RefundShare>(v0, 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::slice_id<RefundShare>(v0, v4 + 1));
            };
            v4 = v4 + 1;
        };
        0
    }

    public fun get_refund_shares(arg0: &RefundVault) : &0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::BigVector<RefundShare> {
        0x2::dynamic_field::borrow<vector<u8>, 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::BigVector<RefundShare>>(&arg0.id, b"refund_shares")
    }

    public fun get_warmup_deposit_share(arg0: &DepositVault, arg1: address) : u64 {
        let v0 = get_deposit_shares(arg0);
        let v1 = 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::length<DepositShare>(v0);
        let v2 = 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::slice_size<DepositShare>(v0);
        let v3 = 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::borrow_slice<DepositShare>(v0, 1);
        let v4 = 0;
        while (v4 < v1) {
            let v5 = 0x1::vector::borrow<DepositShare>(v3, v4 % v2);
            if (v5.receipt == arg1) {
                return get_deposit_share_inner(v5, 3)
            };
            if (v4 + 1 < v1 && (v4 + 1) % v2 == 0) {
                v3 = 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::borrow_slice<DepositShare>(v0, 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::slice_id<DepositShare>(v0, v4 + 1));
            };
            v4 = v4 + 1;
        };
        0
    }

    public fun harvest<T0>(arg0: &mut 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::balance_pool::BalancePool, arg1: &mut DepositVault, arg2: vector<TypusDepositReceipt>, arg3: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        abort 999
    }

    public fun harvest_v2<T0>(arg0: &mut 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::balance_pool::BalancePool, arg1: &mut DepositVault, arg2: vector<TypusDepositReceipt>, arg3: &mut 0x2::tx_context::TxContext) : (u64, u64, u64, 0x1::option::Option<vector<u8>>) {
        abort 999
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

    public fun inactive_share_tag() : u8 {
        2
    }

    public fun incentive_balance<T0>(arg0: &DepositVault) : u64 {
        0x2::balance::value<T0>(get_deposit_vault_balance<T0>(arg0, 5))
    }

    public fun incentive_share_tag() : u8 {
        5
    }

    public fun incentivise_bidder<T0>(arg0: &mut BidVault, arg1: 0x2::balance::Balance<T0>, arg2: &0x2::tx_context::TxContext) {
        if (0x1::option::is_some<0x1::type_name::TypeName>(&arg0.incentive_token)) {
            assert!(*0x1::option::borrow<0x1::type_name::TypeName>(&arg0.incentive_token) == 0x1::type_name::get<T0>(), 1);
            0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<vector<u8>, 0x2::balance::Balance<T0>>(&mut arg0.id, b"incentive_balance"), arg1);
        } else {
            arg0.incentive_token = 0x1::option::some<0x1::type_name::TypeName>(0x1::type_name::get<T0>());
            0x2::dynamic_field::add<vector<u8>, 0x2::balance::Balance<T0>>(&mut arg0.id, b"incentive_balance", arg1);
        };
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
        let v1 = 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::length<DepositShare>(v0);
        let v2 = 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::slice_size<DepositShare>(v0);
        let v3 = 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::borrow_slice<DepositShare>(v0, 1);
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
                v3 = 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::borrow_slice<DepositShare>(v0, 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::slice_id<DepositShare>(v0, v4 + 1));
            };
            v4 = v4 + 1;
        };
        false
    }

    public fun is_deactivating_user(arg0: &DepositVault, arg1: address) : bool {
        let v0 = get_deposit_shares(arg0);
        let v1 = 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::length<DepositShare>(v0);
        let v2 = 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::slice_size<DepositShare>(v0);
        let v3 = 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::borrow_slice<DepositShare>(v0, 1);
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
                v3 = 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::borrow_slice<DepositShare>(v0, 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::slice_id<DepositShare>(v0, v4 + 1));
            };
            v4 = v4 + 1;
        };
        false
    }

    public fun is_inactive_user(arg0: &DepositVault, arg1: address) : bool {
        let v0 = get_deposit_shares(arg0);
        let v1 = 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::length<DepositShare>(v0);
        let v2 = 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::slice_size<DepositShare>(v0);
        let v3 = 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::borrow_slice<DepositShare>(v0, 1);
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
                v3 = 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::borrow_slice<DepositShare>(v0, 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::slice_id<DepositShare>(v0, v4 + 1));
            };
            v4 = v4 + 1;
        };
        false
    }

    public fun is_warmup_user(arg0: &DepositVault, arg1: address) : bool {
        let v0 = get_deposit_shares(arg0);
        let v1 = 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::length<DepositShare>(v0);
        let v2 = 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::slice_size<DepositShare>(v0);
        let v3 = 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::borrow_slice<DepositShare>(v0, 1);
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
                v3 = 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::borrow_slice<DepositShare>(v0, 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::slice_id<DepositShare>(v0, v4 + 1));
            };
            v4 = v4 + 1;
        };
        false
    }

    public fun merge_deposit_receipts(arg0: &mut DepositVault, arg1: vector<TypusDepositReceipt>, arg2: &mut 0x2::tx_context::TxContext) : (0x1::option::Option<TypusDepositReceipt>, vector<u64>) {
        let (v0, v1, v2, v3, v4, v5, v6) = extract_deposit_shares(arg0, arg1);
        let v7 = 0x1::vector::empty<u64>();
        let v8 = &mut v7;
        0x1::vector::push_back<u64>(v8, v0);
        0x1::vector::push_back<u64>(v8, v1);
        0x1::vector::push_back<u64>(v8, v2);
        0x1::vector::push_back<u64>(v8, v3);
        0x1::vector::push_back<u64>(v8, v4);
        0x1::vector::push_back<u64>(v8, v5);
        (add_deposit_share(arg0, v0, v1, v2, v3, v4, v5, v6, arg2), v7)
    }

    public fun new_bid(arg0: &mut BidVault, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        abort 999
    }

    public fun new_bid_vault<T0, T1>(arg0: u64, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) : BidVault {
        let v0 = 0x2::object::new(arg2);
        0x2::dynamic_field::add<vector<u8>, 0x2::balance::Balance<T0>>(&mut v0, b"bid_balance", 0x2::balance::zero<T0>());
        0x2::dynamic_field::add<vector<u8>, 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::BigVector<BidShare>>(&mut v0, b"bid_shares", 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::new<BidShare>(4500, arg2));
        BidVault{
            id              : v0,
            deposit_token   : 0x1::type_name::get<T0>(),
            bid_token       : 0x1::type_name::get<T1>(),
            incentive_token : 0x1::option::none<0x1::type_name::TypeName>(),
            index           : arg0,
            share_supply    : 0,
            metadata        : arg1,
            u64_padding     : 0x1::vector::empty<u64>(),
            bcs_padding     : 0x1::vector::empty<u8>(),
        }
    }

    public fun new_deposit_vault<T0, T1>(arg0: u64, arg1: u64, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) : DepositVault {
        let v0 = 0x2::object::new(arg3);
        0x2::dynamic_field::add<vector<u8>, 0x2::balance::Balance<T0>>(&mut v0, b"active_balance", 0x2::balance::zero<T0>());
        0x2::dynamic_field::add<vector<u8>, 0x2::balance::Balance<T0>>(&mut v0, b"deactivating_balance", 0x2::balance::zero<T0>());
        0x2::dynamic_field::add<vector<u8>, 0x2::balance::Balance<T0>>(&mut v0, b"inactive_balance", 0x2::balance::zero<T0>());
        0x2::dynamic_field::add<vector<u8>, 0x2::balance::Balance<T0>>(&mut v0, b"warmup_balance", 0x2::balance::zero<T0>());
        0x2::dynamic_field::add<vector<u8>, 0x2::balance::Balance<T1>>(&mut v0, b"premium_balance", 0x2::balance::zero<T1>());
        0x2::dynamic_field::add<vector<u8>, 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::BigVector<DepositShare>>(&mut v0, b"deposit_shares", 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::new<DepositShare>(1000, arg3));
        DepositVault{
            id                        : v0,
            deposit_token             : 0x1::type_name::get<T0>(),
            bid_token                 : 0x1::type_name::get<T1>(),
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
        }
    }

    public fun new_refund_vault<T0>(arg0: &mut 0x2::tx_context::TxContext) : RefundVault {
        let v0 = 0x2::object::new(arg0);
        0x2::dynamic_field::add<vector<u8>, 0x2::balance::Balance<T0>>(&mut v0, b"refund_balance", 0x2::balance::zero<T0>());
        0x2::dynamic_field::add<vector<u8>, 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::BigVector<RefundShare>>(&mut v0, b"refund_shares", 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::new<RefundShare>(4500, arg0));
        RefundVault{
            id           : v0,
            token        : 0x1::type_name::get<T0>(),
            share_supply : 0,
            u64_padding  : 0x1::vector::empty<u64>(),
            bcs_padding  : 0x1::vector::empty<u8>(),
        }
    }

    fun new_typus_bid_receipt(arg0: &BidVault, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : TypusBidReceipt {
        let v0 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v0, arg1);
        TypusBidReceipt{
            id          : 0x2::object::new(arg2),
            vid         : 0x2::object::id<BidVault>(arg0),
            index       : arg0.index,
            metadata    : arg0.metadata,
            u64_padding : v0,
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

    public fun premium_share_tag() : u8 {
        4
    }

    public fun public_claim<T0>(arg0: &mut DepositVault, arg1: vector<TypusDepositReceipt>, arg2: &mut 0x2::tx_context::TxContext) : (0x1::option::Option<0x2::balance::Balance<T0>>, 0x1::option::Option<TypusDepositReceipt>, vector<u64>) {
        assert!(0x1::type_name::get<T0>() == arg0.deposit_token, 1);
        let (v0, v1, v2, v3, v4, v5, v6) = extract_deposit_shares(arg0, arg1);
        let v7 = v2;
        let v8 = 0x1::option::none<0x2::balance::Balance<T0>>();
        if (v2 > 0) {
            let v9 = get_mut_deposit_vault_balance<T0>(arg0, 2);
            0x1::option::fill<0x2::balance::Balance<T0>>(&mut v8, 0x2::balance::split<T0>(v9, v2));
            v7 = v2 - v2;
            arg0.inactive_share_supply = arg0.inactive_share_supply - v2;
        };
        let v10 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v10, v7);
        (v8, add_deposit_share(arg0, v0, v1, v7, v3, v4, v5, v6, arg2), v10)
    }

    public fun public_compound<T0>(arg0: &mut 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::balance_pool::BalancePool, arg1: &mut DepositVault, arg2: vector<TypusDepositReceipt>, arg3: &mut 0x2::tx_context::TxContext) : (0x1::option::Option<TypusDepositReceipt>, vector<u64>) {
        assert!(arg1.has_next, 4);
        assert!(0x1::type_name::get<T0>() == arg1.deposit_token, 1);
        assert!(0x1::type_name::get<T0>() == arg1.bid_token, 1);
        let (v0, v1, v2, v3, v4, v5, v6) = extract_deposit_shares(arg1, arg2);
        let v7 = v4;
        let v8 = v3;
        let v9 = v4;
        let v10 = 0;
        let v11 = 0;
        if (v4 > 0) {
            let v12 = get_mut_deposit_vault_balance<T0>(arg1, 4);
            let v13 = 0x2::balance::split<T0>(v12, v4);
            v7 = v4 - v4;
            arg1.premium_share_supply = arg1.premium_share_supply - v4;
            let v14 = &mut v13;
            let (v15, v16) = charge_fee<T0>(arg0, arg1, v14);
            v10 = v15;
            v11 = v16;
            let v17 = 0x2::balance::value<T0>(&v13);
            v9 = v17;
            let v18 = get_mut_deposit_vault_balance<T0>(arg1, 3);
            0x2::balance::join<T0>(v18, v13);
            v8 = v3 + v17;
            arg1.warmup_share_supply = arg1.warmup_share_supply + v17;
        };
        let v19 = 0x1::vector::empty<u64>();
        let v20 = &mut v19;
        0x1::vector::push_back<u64>(v20, v9);
        0x1::vector::push_back<u64>(v20, v10);
        0x1::vector::push_back<u64>(v20, v11);
        (add_deposit_share(arg1, v0, v1, v2, v8, v7, v5, v6, arg3), v19)
    }

    public fun public_deposit<T0>(arg0: &mut DepositVault, arg1: vector<0x2::coin::Coin<T0>>, arg2: u64, arg3: vector<TypusDepositReceipt>, arg4: &mut 0x2::tx_context::TxContext) : (vector<0x2::coin::Coin<T0>>, 0x1::option::Option<TypusDepositReceipt>, vector<u64>) {
        assert!(arg0.has_next, 4);
        assert!(0x1::type_name::get<T0>() == arg0.deposit_token, 1);
        assert!(arg2 > 0, 0);
        assert!(18446744073709551615 - active_balance<T0>(arg0) - deactivating_balance<T0>(arg0) - inactive_balance<T0>(arg0) - warmup_balance<T0>(arg0) >= arg2, 5);
        let (v0, v1) = 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::utils::public_extract_balance<T0>(arg1, arg2);
        let v2 = get_mut_deposit_vault_balance<T0>(arg0, 3);
        0x2::balance::join<T0>(v2, v1);
        let (v3, v4, v5, v6, v7, v8, v9) = extract_deposit_shares(arg0, arg3);
        arg0.warmup_share_supply = arg0.warmup_share_supply + arg2;
        let v10 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v10, arg2);
        (v0, add_deposit_share(arg0, v3, v4, v5, v6 + arg2, v7, v8, v9, arg4), v10)
    }

    public fun public_exercise<T0>(arg0: &mut BidVault, arg1: vector<TypusBidReceipt>) : (0x2::balance::Balance<T0>, vector<u64>) {
        assert!(0x1::type_name::get<T0>() == arg0.deposit_token, 1);
        assert!(0x1::option::is_none<0x1::type_name::TypeName>(&arg0.incentive_token), 1);
        let (v0, _) = extract_bid_shares(arg0, arg1);
        let v2 = arg0.share_supply;
        arg0.share_supply = arg0.share_supply - v0;
        let v3 = get_mut_bid_vault_balance<T0>(arg0);
        let v4 = (((0x2::balance::value<T0>(v3) as u128) * (v0 as u128) / (v2 as u128)) as u64);
        let v5 = 0x1::vector::empty<u64>();
        let v6 = &mut v5;
        0x1::vector::push_back<u64>(v6, v4);
        0x1::vector::push_back<u64>(v6, v0);
        (0x2::balance::split<T0>(v3, v4), v5)
    }

    public fun public_harvest<T0>(arg0: &mut 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::balance_pool::BalancePool, arg1: &mut DepositVault, arg2: vector<TypusDepositReceipt>, arg3: &mut 0x2::tx_context::TxContext) : (0x1::option::Option<0x2::balance::Balance<T0>>, 0x1::option::Option<TypusDepositReceipt>, vector<u64>) {
        assert!(0x1::type_name::get<T0>() == arg1.bid_token, 1);
        let (v0, v1, v2, v3, v4, v5, v6) = extract_deposit_shares(arg1, arg2);
        let v7 = v4;
        let v8 = v4;
        let v9 = 0;
        let v10 = 0;
        let v11 = 0x1::option::none<0x2::balance::Balance<T0>>();
        if (v4 > 0) {
            let v12 = get_mut_deposit_vault_balance<T0>(arg1, 4);
            let v13 = 0x2::balance::split<T0>(v12, v4);
            v7 = v4 - v4;
            arg1.premium_share_supply = arg1.premium_share_supply - v4;
            let v14 = &mut v13;
            let (v15, v16) = charge_fee<T0>(arg0, arg1, v14);
            v9 = v15;
            v10 = v16;
            v8 = v4 - v15 - v16;
            0x1::option::fill<0x2::balance::Balance<T0>>(&mut v11, v13);
        };
        let v17 = 0x1::vector::empty<u64>();
        let v18 = &mut v17;
        0x1::vector::push_back<u64>(v18, v8);
        0x1::vector::push_back<u64>(v18, v9);
        0x1::vector::push_back<u64>(v18, v10);
        (v11, add_deposit_share(arg1, v0, v1, v2, v3, v7, v5, v6, arg3), v17)
    }

    public fun public_new_bid(arg0: &mut BidVault, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : TypusBidReceipt {
        arg0.share_supply = arg0.share_supply + arg1;
        let v0 = new_typus_bid_receipt(arg0, arg1, arg2);
        let v1 = BidShare{
            receipt     : 0x2::object::id_address<TypusBidReceipt>(&v0),
            share       : arg1,
            u64_padding : 0x1::vector::empty<u64>(),
        };
        0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::push_back<BidShare>(get_mut_bid_shares(arg0), v1);
        v0
    }

    public fun public_rebate<T0>(arg0: &mut RefundVault, arg1: address) : (0x1::option::Option<0x2::balance::Balance<T0>>, vector<u64>) {
        assert!(0x1::type_name::get<T0>() == arg0.token, 1);
        let v0 = 0x2::dynamic_field::borrow_mut<vector<u8>, 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::BigVector<RefundShare>>(&mut arg0.id, b"refund_shares");
        let v1 = 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::length<RefundShare>(v0);
        let v2 = 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::slice_size<RefundShare>(v0);
        let v3 = 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::borrow_slice<RefundShare>(v0, 1);
        let v4 = 0;
        while (v4 < v1) {
            if (0x1::vector::borrow<RefundShare>(v3, v4 % v2).user == arg1) {
                break
            };
            if (v4 + 1 < v1 && (v4 + 1) % v2 == 0) {
                v3 = 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::borrow_slice<RefundShare>(v0, 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::slice_id<RefundShare>(v0, v4 + 1));
            };
            v4 = v4 + 1;
        };
        if (v4 == v1) {
            return (0x1::option::none<0x2::balance::Balance<T0>>(), vector[0])
        };
        let v5 = 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::borrow_mut<RefundShare>(v0, v4);
        let v6 = v5.share;
        v5.share = 0;
        arg0.share_supply = arg0.share_supply - v6;
        let v7 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v7, v6);
        (0x1::option::some<0x2::balance::Balance<T0>>(0x2::balance::split<T0>(0x2::dynamic_field::borrow_mut<vector<u8>, 0x2::balance::Balance<T0>>(&mut arg0.id, b"refund_balance"), v6)), v7)
    }

    public fun public_redeem<T0>(arg0: &mut 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::balance_pool::BalancePool, arg1: &mut DepositVault, arg2: vector<TypusDepositReceipt>, arg3: &mut 0x2::tx_context::TxContext) : (0x1::option::Option<0x2::balance::Balance<T0>>, 0x1::option::Option<TypusDepositReceipt>, vector<u64>) {
        assert!(0x1::option::some<0x1::type_name::TypeName>(0x1::type_name::get<T0>()) == arg1.incentive_token, 1);
        let (v0, v1, v2, v3, v4, v5, v6) = extract_deposit_shares(arg1, arg2);
        let v7 = v5;
        let v8 = v5;
        let v9 = 0;
        let v10 = 0;
        let v11 = 0x1::option::none<0x2::balance::Balance<T0>>();
        if (v5 > 0) {
            let v12 = get_mut_deposit_vault_balance<T0>(arg1, 5);
            let v13 = 0x2::balance::split<T0>(v12, v5);
            v7 = v5 - v5;
            arg1.incentive_share_supply = arg1.incentive_share_supply - v5;
            let v14 = &mut v13;
            let (v15, v16) = charge_fee<T0>(arg0, arg1, v14);
            v9 = v15;
            v10 = v16;
            v8 = v5 - v15 - v16;
            0x1::option::fill<0x2::balance::Balance<T0>>(&mut v11, v13);
        };
        let v17 = 0x1::vector::empty<u64>();
        let v18 = &mut v17;
        0x1::vector::push_back<u64>(v18, v8);
        0x1::vector::push_back<u64>(v18, v9);
        0x1::vector::push_back<u64>(v18, v10);
        (v11, add_deposit_share(arg1, v0, v1, v2, v3, v4, v7, v6, arg3), v17)
    }

    public fun public_unsubscribe<T0>(arg0: &mut DepositVault, arg1: vector<TypusDepositReceipt>, arg2: 0x1::option::Option<u64>, arg3: &mut 0x2::tx_context::TxContext) : (0x1::option::Option<TypusDepositReceipt>, vector<u64>) {
        assert!(0x1::type_name::get<T0>() == arg0.deposit_token, 1);
        let (v0, v1, v2, v3, v4, v5, v6) = extract_deposit_shares(arg0, arg1);
        let v7 = v1;
        let v8 = v0;
        let v9 = v0;
        if (0x1::option::is_some<u64>(&arg2)) {
            let v10 = 0x1::option::destroy_some<u64>(arg2);
            if (v10 < v0) {
                v9 = v10;
            };
        };
        if (v9 > 0) {
            let v11 = get_mut_deposit_vault_balance<T0>(arg0, 0);
            let v12 = 0x2::balance::split<T0>(v11, v9);
            v8 = v0 - v9;
            arg0.active_share_supply = arg0.active_share_supply - v9;
            let v13 = get_mut_deposit_vault_balance<T0>(arg0, 1);
            0x2::balance::join<T0>(v13, v12);
            v7 = v1 + v9;
            arg0.deactivating_share_supply = arg0.deactivating_share_supply + v9;
        };
        let v14 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v14, v9);
        (add_deposit_share(arg0, v8, v7, v2, v3, v4, v5, v6, arg3), v14)
    }

    public fun public_unsubscribe_share(arg0: &mut DepositVault, arg1: vector<TypusDepositReceipt>, arg2: 0x1::option::Option<u64>, arg3: &mut 0x2::tx_context::TxContext) : (0x1::option::Option<TypusDepositReceipt>, vector<u64>) {
        let (v0, v1, v2, v3, v4, v5, v6) = extract_deposit_shares(arg0, arg1);
        let v7 = v1;
        let v8 = v0;
        let v9 = v0;
        if (0x1::option::is_some<u64>(&arg2)) {
            let v10 = 0x1::option::destroy_some<u64>(arg2);
            if (v10 < v0) {
                v9 = v10;
            };
        };
        if (v9 > 0) {
            v8 = v0 - v9;
            arg0.active_share_supply = arg0.active_share_supply - v9;
            v7 = v1 + v9;
            arg0.deactivating_share_supply = arg0.deactivating_share_supply + v9;
        };
        let v11 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v11, v9);
        (add_deposit_share(arg0, v8, v7, v2, v3, v4, v5, v6, arg3), v11)
    }

    public fun public_withdraw<T0>(arg0: &mut DepositVault, arg1: vector<TypusDepositReceipt>, arg2: 0x1::option::Option<u64>, arg3: &mut 0x2::tx_context::TxContext) : (0x1::option::Option<0x2::balance::Balance<T0>>, 0x1::option::Option<TypusDepositReceipt>, vector<u64>) {
        assert!(0x1::type_name::get<T0>() == arg0.deposit_token, 1);
        let (v0, v1, v2, v3, v4, v5, v6) = extract_deposit_shares(arg0, arg1);
        let v7 = v3;
        let v8 = v3;
        if (0x1::option::is_some<u64>(&arg2)) {
            let v9 = 0x1::option::destroy_some<u64>(arg2);
            if (v9 < v3) {
                v8 = v9;
            };
        };
        let v10 = 0x1::option::none<0x2::balance::Balance<T0>>();
        if (v8 > 0) {
            let v11 = get_mut_deposit_vault_balance<T0>(arg0, 3);
            0x1::option::fill<0x2::balance::Balance<T0>>(&mut v10, 0x2::balance::split<T0>(v11, v8));
            v7 = v3 - v8;
            arg0.warmup_share_supply = arg0.warmup_share_supply - v8;
        };
        let v12 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v12, v8);
        (v10, add_deposit_share(arg0, v0, v1, v2, v7, v4, v5, v6, arg3), v12)
    }

    public fun put_refund<T0>(arg0: &mut RefundVault, arg1: 0x2::balance::Balance<T0>, arg2: address) {
        assert!(0x1::type_name::get<T0>() == arg0.token, 1);
        let v0 = 0x2::balance::value<T0>(&arg1);
        arg0.share_supply = arg0.share_supply + v0;
        0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<vector<u8>, 0x2::balance::Balance<T0>>(&mut arg0.id, b"refund_balance"), arg1);
        let v1 = 0x2::dynamic_field::borrow_mut<vector<u8>, 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::BigVector<RefundShare>>(&mut arg0.id, b"refund_shares");
        let v2 = 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::length<RefundShare>(v1);
        let v3 = 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::slice_size<RefundShare>(v1);
        let v4 = 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::borrow_slice_mut<RefundShare>(v1, 1);
        let v5 = 0;
        while (v5 < v2) {
            let v6 = 0x1::vector::borrow_mut<RefundShare>(v4, v5 % v3);
            if (v6.user == arg2) {
                v6.share = v6.share + v0;
                return
            };
            if (v5 + 1 < v2 && (v5 + 1) % v3 == 0) {
                v4 = 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::borrow_slice_mut<RefundShare>(v1, 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::slice_id<RefundShare>(v1, v5 + 1));
            };
            v5 = v5 + 1;
        };
        let v7 = RefundShare{
            user        : arg2,
            share       : v0,
            u64_padding : 0x1::vector::empty<u64>(),
        };
        0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::push_back<RefundShare>(v1, v7);
    }

    public fun put_refunds<T0>(arg0: &mut RefundVault, arg1: 0x2::balance::Balance<T0>, arg2: vector<u64>, arg3: vector<u64>) {
        assert!(0x1::type_name::get<T0>() == arg0.token, 1);
        arg0.share_supply = arg0.share_supply + 0x2::balance::value<T0>(&arg1);
        0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<vector<u8>, 0x2::balance::Balance<T0>>(&mut arg0.id, b"refund_balance"), arg1);
        let v0 = 0x2::dynamic_field::borrow_mut<vector<u8>, 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::BigVector<RefundShare>>(&mut arg0.id, b"refund_shares");
        while (!0x1::vector::is_empty<u64>(&arg2) || !0x1::vector::is_empty<u64>(&arg3)) {
            let v1 = 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::borrow_mut<RefundShare>(v0, 0x1::vector::pop_back<u64>(&mut arg2));
            v1.share = v1.share + 0x1::vector::pop_back<u64>(&mut arg3);
        };
    }

    public fun recoup<T0>(arg0: &mut DepositVault, arg1: u64, arg2: &0x2::tx_context::TxContext) : (u64, u64) {
        assert!(0x1::type_name::get<T0>() == arg0.deposit_token, 1);
        let v0 = arg0.has_next;
        let v1 = 0;
        let v2 = 0;
        let v3 = active_balance<T0>(arg0) + deactivating_balance<T0>(arg0);
        if (v3 > 0 && arg1 > 0) {
            let v4 = get_mut_deposit_shares(arg0);
            let v5 = 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::length<DepositShare>(v4);
            let v6 = 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::slice_size<DepositShare>(v4);
            let v7 = 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::borrow_slice_mut<DepositShare>(v4, 1);
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
                    v7 = 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::borrow_slice_mut<DepositShare>(v4, 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::slice_id<DepositShare>(v4, v8 + 1));
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
        (v1, v2)
    }

    public fun redeem<T0>(arg0: &mut DepositVault, arg1: vector<TypusDepositReceipt>, arg2: &mut 0x2::tx_context::TxContext) : u64 {
        abort 999
    }

    public fun redeem_v2<T0>(arg0: &mut 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::balance_pool::BalancePool, arg1: &mut DepositVault, arg2: vector<TypusDepositReceipt>, arg3: &mut 0x2::tx_context::TxContext) : (u64, u64, u64, 0x1::option::Option<vector<u8>>) {
        abort 999
    }

    public fun refund_vault_balance<T0>(arg0: &RefundVault) : u64 {
        0x2::balance::value<T0>(0x2::dynamic_field::borrow<vector<u8>, 0x2::balance::Balance<T0>>(&arg0.id, b"refund_balance"))
    }

    public fun refund_vault_share_supply(arg0: &RefundVault) : u64 {
        arg0.share_supply
    }

    public fun register_refund<T0>(arg0: &mut RefundVault, arg1: address) : u64 {
        assert!(0x1::type_name::get<T0>() == arg0.token, 1);
        let v0 = 0x2::dynamic_field::borrow_mut<vector<u8>, 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::BigVector<RefundShare>>(&mut arg0.id, b"refund_shares");
        let v1 = 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::length<RefundShare>(v0);
        let v2 = 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::slice_size<RefundShare>(v0);
        let v3 = 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::borrow_slice_mut<RefundShare>(v0, 1);
        let v4 = 0;
        while (v4 < v1) {
            if (0x1::vector::borrow_mut<RefundShare>(v3, v4 % v2).user == arg1) {
                return v4
            };
            if (v4 + 1 < v1 && (v4 + 1) % v2 == 0) {
                v3 = 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::borrow_slice_mut<RefundShare>(v0, 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::slice_id<RefundShare>(v0, v4 + 1));
            };
            v4 = v4 + 1;
        };
        let v5 = RefundShare{
            user        : arg1,
            share       : 0,
            u64_padding : 0x1::vector::empty<u64>(),
        };
        0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::push_back<RefundShare>(v0, v5);
        v4
    }

    public fun set_bid_vault_u64_padding_value(arg0: &mut BidVault, arg1: u64, arg2: u64) {
        0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::utils::set_u64_padding_value(&mut arg0.u64_padding, arg1, arg2);
    }

    public fun settle<T0, T1>(arg0: &mut DepositVault, arg1: &mut BidVault, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 0);
        assert!(0x1::type_name::get<T0>() == arg0.deposit_token, 1);
        assert!(0x1::type_name::get<T1>() == arg0.bid_token, 1);
        assert!(0x1::type_name::get<T0>() == arg1.deposit_token, 1);
        assert!(0x1::type_name::get<T1>() == arg1.bid_token, 1);
        let v0 = 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::utils::multiplier(arg3);
        if (active_balance<T0>(arg0) + deactivating_balance<T0>(arg0) != 0 && arg1.share_supply != 0) {
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
            let v15 = 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::length<DepositShare>(v14);
            let v16 = 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::slice_size<DepositShare>(v14);
            let v17 = 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::borrow_slice_mut<DepositShare>(v14, 1);
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
                    v17 = 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::borrow_slice_mut<DepositShare>(v14, 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::slice_id<DepositShare>(v14, v18 + 1));
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
    }

    public fun split_bid_receipt(arg0: &mut BidVault, arg1: vector<TypusBidReceipt>, arg2: 0x1::option::Option<u64>, arg3: &mut 0x2::tx_context::TxContext) : (u64, 0x1::option::Option<TypusBidReceipt>, 0x1::option::Option<TypusBidReceipt>) {
        let (v0, _) = extract_bid_shares(arg0, arg1);
        let v2 = v0;
        let v3 = v0;
        if (0x1::option::is_some<u64>(&arg2)) {
            let v4 = 0x1::option::destroy_some<u64>(arg2);
            if (v4 < v0) {
                v3 = v4;
            };
        };
        let v5 = if (v3 > 0) {
            let v6 = new_typus_bid_receipt(arg0, v3, arg3);
            let v7 = get_mut_bid_shares(arg0);
            let v8 = BidShare{
                receipt     : 0x2::object::id_address<TypusBidReceipt>(&v6),
                share       : v3,
                u64_padding : 0x1::vector::empty<u64>(),
            };
            0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::push_back<BidShare>(v7, v8);
            v2 = v0 - v3;
            0x1::option::some<TypusBidReceipt>(v6)
        } else {
            0x1::option::none<TypusBidReceipt>()
        };
        let v9 = if (v2 > 0) {
            let v10 = new_typus_bid_receipt(arg0, v2, arg3);
            let v11 = BidShare{
                receipt     : 0x2::object::id_address<TypusBidReceipt>(&v10),
                share       : v2,
                u64_padding : 0x1::vector::empty<u64>(),
            };
            0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::push_back<BidShare>(get_mut_bid_shares(arg0), v11);
            0x1::option::some<TypusBidReceipt>(v10)
        } else {
            0x1::option::none<TypusBidReceipt>()
        };
        (v3, v5, v9)
    }

    public fun split_deposit_receipt(arg0: &mut DepositVault, arg1: TypusDepositReceipt, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (0x1::option::Option<TypusDepositReceipt>, 0x1::option::Option<TypusDepositReceipt>) {
        let v0 = 0x1::vector::empty<TypusDepositReceipt>();
        0x1::vector::push_back<TypusDepositReceipt>(&mut v0, arg1);
        let (v1, v2, v3, v4, v5, v6, v7) = extract_deposit_shares(arg0, v0);
        let v8 = add_deposit_share(arg0, v1 - arg2, v2, v3, v4 - arg3, v5, v6, v7, arg4);
        (v8, add_deposit_share(arg0, arg2, 0, 0, arg3, 0, 0, vector[], arg4))
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
            let v9 = 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::length<BidShare>(v8);
            let v10 = 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::slice_size<BidShare>(v8);
            let v11 = 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::borrow_slice<BidShare>(v8, 1);
            let v12 = 0;
            while (v12 < v9) {
                let v13 = 0x1::vector::borrow<BidShare>(v11, v12 % v10);
                if (v13.receipt == 0x2::object::uid_to_address(&v7)) {
                    v0 = v0 + v13.share;
                    break
                };
                if (v12 + 1 < v9 && (v12 + 1) % v10 == 0) {
                    v11 = 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::borrow_slice<BidShare>(v8, 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::slice_id<BidShare>(v8, v12 + 1));
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
            let v14 = 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::length<DepositShare>(v13);
            let v15 = 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::slice_size<DepositShare>(v13);
            let v16 = 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::borrow_slice<DepositShare>(v13, 1);
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
                    v16 = 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::borrow_slice<DepositShare>(v13, 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::slice_id<DepositShare>(v13, v17 + 1));
                };
                v17 = v17 + 1;
            };
        };
        0x1::vector::destroy_empty<TypusDepositReceipt>(arg1);
        (v0, v1, v2, v3, v4, v5)
    }

    public fun take_refund<T0>(arg0: &mut RefundVault, arg1: &mut 0x2::tx_context::TxContext) : u64 {
        abort 999
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
        let v7 = 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::length<DepositShare>(v6);
        let v8 = 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::slice_size<DepositShare>(v6);
        let v9 = 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::borrow_slice_mut<DepositShare>(v6, 1);
        let v10 = 0;
        while (v10 < v7) {
            let v11 = 0x1::vector::borrow_mut<DepositShare>(v9, v10 % v8);
            v11.inactive_share = v11.inactive_share + v11.active_share + v11.deactivating_share + v11.warmup_share;
            v11.active_share = 0;
            v11.deactivating_share = 0;
            v11.warmup_share = 0;
            if (v10 + 1 < v7 && (v10 + 1) % v8 == 0) {
                v9 = 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::borrow_slice_mut<DepositShare>(v6, 0x8e5146f87e9843be49c5e597032ba3470026f0a14f6d48956dc35498c0feea1f::big_vector::slice_id<DepositShare>(v6, v10 + 1));
            };
            v10 = v10 + 1;
        };
        arg0.has_next = false;
    }

    public fun transfer_bid_receipt(arg0: 0x1::option::Option<TypusBidReceipt>, arg1: address) {
        if (0x1::option::is_some<TypusBidReceipt>(&arg0)) {
            0x2::transfer::public_transfer<TypusBidReceipt>(0x1::option::destroy_some<TypusBidReceipt>(arg0), arg1);
        } else {
            0x1::option::destroy_none<TypusBidReceipt>(arg0);
        };
    }

    public fun transfer_deposit_receipt(arg0: 0x1::option::Option<TypusDepositReceipt>, arg1: address) {
        if (0x1::option::is_some<TypusDepositReceipt>(&arg0)) {
            0x2::transfer::public_transfer<TypusDepositReceipt>(0x1::option::destroy_some<TypusDepositReceipt>(arg0), arg1);
        } else {
            0x1::option::destroy_none<TypusDepositReceipt>(arg0);
        };
    }

    public fun unsubscribe<T0>(arg0: &mut DepositVault, arg1: vector<TypusDepositReceipt>, arg2: 0x1::option::Option<u64>, arg3: &mut 0x2::tx_context::TxContext) : u64 {
        abort 999
    }

    public fun unsubscribe_share(arg0: &mut DepositVault, arg1: vector<TypusDepositReceipt>, arg2: 0x1::option::Option<u64>, arg3: &mut 0x2::tx_context::TxContext) : u64 {
        abort 999
    }

    public fun update_bid_receipt_display(arg0: &mut BidVault, arg1: 0x1::string::String) {
        arg0.metadata = arg1;
    }

    public fun update_deposit_receipt_display(arg0: &mut DepositVault, arg1: 0x1::string::String) {
        arg0.metadata = arg1;
    }

    public fun update_deposit_vault_incentive_token<T0>(arg0: &mut DepositVault) {
        if (arg0.incentive_token != 0x1::option::some<0x1::type_name::TypeName>(0x1::type_name::get<T0>())) {
            0x1::option::fill<0x1::type_name::TypeName>(&mut arg0.incentive_token, 0x1::type_name::get<T0>());
            0x2::dynamic_field::add<vector<u8>, 0x2::balance::Balance<T0>>(&mut arg0.id, b"incentive_balance", 0x2::balance::zero<T0>());
        };
    }

    public fun update_fee(arg0: &mut DepositVault, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        arg0.fee_bp = arg1;
    }

    public fun update_fee_share(arg0: &mut DepositVault, arg1: u64, arg2: 0x1::option::Option<vector<u8>>, arg3: &0x2::tx_context::TxContext) {
        arg0.fee_share_bp = arg1;
        arg0.shared_fee_pool = arg2;
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

    public fun warmup_share_tag() : u8 {
        3
    }

    public fun withdraw<T0>(arg0: &mut DepositVault, arg1: vector<TypusDepositReceipt>, arg2: 0x1::option::Option<u64>, arg3: &mut 0x2::tx_context::TxContext) : u64 {
        abort 999
    }

    // decompiled from Move bytecode v6
}

