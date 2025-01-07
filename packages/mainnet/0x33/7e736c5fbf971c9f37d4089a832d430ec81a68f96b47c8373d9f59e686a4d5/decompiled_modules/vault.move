module 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::vault {
    struct DepositVault<phantom T0, phantom T1> has store {
        active_sub_vault: SubVault<T1>,
        deactivating_sub_vault: SubVault<T1>,
        inactive_sub_vault: SubVault<T1>,
        warmup_sub_vault: SubVault<T1>,
        has_next: bool,
    }

    struct BidVault<phantom T0, phantom T1> has store {
        bidder_sub_vault: SubVault<T1>,
        premium_sub_vault: SubVault<T1>,
        performance_fee_sub_vault: SubVault<T1>,
    }

    struct SubVault<phantom T0> has store {
        index: u64,
        tag: u8,
        balance: 0x2::balance::Balance<T0>,
        share_supply: u64,
        user_shares: 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::linked_list::LinkedList<UserShareKey, u64>,
    }

    struct UserShareRegistry has store, key {
        id: 0x2::object::UID,
    }

    struct UserShareKey has copy, drop, store {
        index: u64,
        tag: u8,
        user: address,
    }

    struct NewDepositVault<phantom T0, phantom T1> has copy, drop {
        signer: address,
    }

    struct NewBidVault<phantom T0, phantom T1> has copy, drop {
        signer: address,
    }

    struct Deposit<phantom T0, phantom T1> has copy, drop {
        signer: address,
        amount: u64,
    }

    struct Withdraw<phantom T0, phantom T1> has copy, drop {
        signer: address,
        amount: u64,
    }

    struct Unsubscribe<phantom T0, phantom T1> has copy, drop {
        signer: address,
        amount: u64,
    }

    struct Claim<phantom T0, phantom T1> has copy, drop {
        signer: address,
        user_amount: u64,
        claim_fee_amount: u64,
    }

    struct Harvest<phantom T0, phantom T1> has copy, drop {
        signer: address,
        share: u64,
        amount: u64,
    }

    struct Compound<phantom T0, phantom T1> has copy, drop {
        signer: address,
        amount: u64,
    }

    struct Activate<phantom T0, phantom T1> has copy, drop {
        signer: address,
        amount: u64,
        has_next: bool,
    }

    struct Delivery<phantom T0, phantom T1> has copy, drop {
        signer: address,
        premium: u64,
        performance_fee: u64,
    }

    struct DeliveryMultiple<phantom T0, phantom T1, phantom T2, phantom T3> has copy, drop {
        signer: address,
        premium: u64,
        performance_fee: u64,
    }

    struct Refund<phantom T0, phantom T1> has copy, drop {
        signer: address,
        amount: u64,
        deactivating: u64,
        active: u64,
    }

    struct RebalanceMultiple<phantom T0, phantom T1> has copy, drop {
        signer: address,
        amount: u64,
    }

    struct Settle<phantom T0, phantom T1> has copy, drop {
        signer: address,
        settled_share_price: u64,
        share_price_decimal: u64,
        spot_price: u64,
        spot_price_decimal: u64,
    }

    struct SettleMultiple<phantom T0, phantom T1, phantom T2, phantom T3> has copy, drop {
        signer: address,
        settled_share_price_token: u64,
        settled_share_price_usd: u64,
        share_price_decimal: u64,
        spot_price: u64,
        spot_price_decimal: u64,
    }

    struct CloseDepositVault<phantom T0, phantom T1> has copy, drop {
        signer: address,
        active_sub_vault_receipt: 0x2::vec_map::VecMap<address, u64>,
        deactivating_sub_vault_receipt: 0x2::vec_map::VecMap<address, u64>,
        inactive_sub_vault_receipt: 0x2::vec_map::VecMap<address, u64>,
        warmup_sub_vault_receipt: 0x2::vec_map::VecMap<address, u64>,
    }

    struct CloseBidVault<phantom T0, phantom T1> has copy, drop {
        signer: address,
        bidder_sub_vault_receipt: 0x2::vec_map::VecMap<address, u64>,
        premium_sub_vault_receipt: 0x2::vec_map::VecMap<address, u64>,
        performance_fee_sub_vault_receipt: 0x2::vec_map::VecMap<address, u64>,
    }

    public fun activate<T0, T1>(arg0: &T0, arg1: &mut UserShareRegistry, arg2: &mut DepositVault<T0, T1>, arg3: bool, arg4: &0x2::tx_context::TxContext) {
        let v0 = &mut arg2.active_sub_vault;
        let v1 = &mut arg2.warmup_sub_vault;
        let v2 = 0x2::balance::value<T1>(&v1.balance);
        rock_n_roll<T1>(arg1, v1, v0);
        arg2.has_next = arg3;
        let v3 = Activate<T0, T1>{
            signer   : 0x2::tx_context::sender(arg4),
            amount   : v2,
            has_next : arg3,
        };
        0x2::event::emit<Activate<T0, T1>>(v3);
    }

    public fun activate_share<T0, T1>(arg0: &T0, arg1: &mut UserShareRegistry, arg2: &mut DepositVault<T0, T1>, arg3: u64) : (u64, bool) {
        let v0 = &mut arg2.active_sub_vault;
        let v1 = &mut arg2.warmup_sub_vault;
        rock_n_roll_limited<T1>(arg1, v1, v0, arg3)
    }

    public fun activate_vault<T0, T1>(arg0: &T0, arg1: &mut DepositVault<T0, T1>, arg2: u64, arg3: bool, arg4: &0x2::tx_context::TxContext) {
        arg1.has_next = arg3;
        let v0 = Activate<T0, T1>{
            signer   : 0x2::tx_context::sender(arg4),
            amount   : arg2,
            has_next : arg3,
        };
        0x2::event::emit<Activate<T0, T1>>(v0);
    }

    public fun active_balance<T0, T1>(arg0: &DepositVault<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.active_sub_vault.balance)
    }

    public fun active_share_supply<T0, T1>(arg0: &DepositVault<T0, T1>) : u64 {
        arg0.active_sub_vault.share_supply
    }

    public fun active_user_shares<T0, T1>(arg0: &DepositVault<T0, T1>) : &0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::linked_list::LinkedList<UserShareKey, u64> {
        &arg0.active_sub_vault.user_shares
    }

    fun add_share<T0>(arg0: &mut UserShareRegistry, arg1: &mut SubVault<T0>, arg2: address, arg3: u64) {
        arg1.share_supply = arg1.share_supply + arg3;
        let v0 = UserShareKey{
            index : arg1.index,
            tag   : arg1.tag,
            user  : arg2,
        };
        if (0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::linked_list::contains<UserShareKey, u64>(&arg0.id, &arg1.user_shares, v0)) {
            let v1 = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::linked_list::borrow_mut<UserShareKey, u64>(&mut arg0.id, &mut arg1.user_shares, v0);
            *v1 = *v1 + arg3;
        } else {
            0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::linked_list::push_back<UserShareKey, u64>(&mut arg0.id, &mut arg1.user_shares, v0, arg3);
        };
    }

    fun add_share_front<T0>(arg0: &mut UserShareRegistry, arg1: &mut SubVault<T0>, arg2: address, arg3: u64) {
        arg1.share_supply = arg1.share_supply + arg3;
        let v0 = UserShareKey{
            index : arg1.index,
            tag   : arg1.tag,
            user  : arg2,
        };
        if (0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::linked_list::contains<UserShareKey, u64>(&arg0.id, &arg1.user_shares, v0)) {
            arg3 = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::linked_list::remove<UserShareKey, u64>(&mut arg0.id, &mut arg1.user_shares, v0) + arg3;
        };
        0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::linked_list::push_front<UserShareKey, u64>(&mut arg0.id, &mut arg1.user_shares, v0, arg3);
    }

    fun adjust_user_share_limited<T0>(arg0: &mut UserShareRegistry, arg1: &mut SubVault<T0>, arg2: 0x1::option::Option<UserShareKey>, arg3: u64) : 0x1::option::Option<UserShareKey> {
        let v0 = 0x2::balance::value<T0>(&arg1.balance);
        let v1 = arg1.share_supply;
        let v2 = if (0x1::option::is_some<UserShareKey>(&arg2)) {
            arg2
        } else {
            0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::linked_list::first<UserShareKey, u64>(&arg1.user_shares)
        };
        let v3 = v2;
        if (v1 > 0 && v0 > 0) {
            while (0x1::option::is_some<UserShareKey>(&v3) && arg3 > 0) {
                let v4 = *0x1::option::borrow<UserShareKey>(&v3);
                let v5 = *0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::linked_list::borrow<UserShareKey, u64>(&mut arg0.id, &arg1.user_shares, v4);
                let v6 = (((v0 as u128) * (v5 as u128) / (v1 as u128)) as u64);
                v0 = v0 - v6;
                v1 = v1 - v5;
                v3 = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::linked_list::next<UserShareKey, u64>(&mut arg0.id, &arg1.user_shares, v4);
                if (v5 >= v6) {
                    remove_share<T0>(arg0, arg1, v4.user, 0x1::option::some<u64>(v5 - v6));
                } else {
                    add_share<T0>(arg0, arg1, v4.user, v6 - v5);
                };
                arg3 = arg3 - 1;
            };
        };
        v3
    }

    fun adjust_user_share_ratio<T0>(arg0: &mut UserShareRegistry, arg1: &mut SubVault<T0>) {
        let v0 = 0x2::balance::value<T0>(&arg1.balance);
        let v1 = arg1.share_supply;
        if (v1 > 0 && v0 > 0) {
            let v2 = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::linked_list::first<UserShareKey, u64>(&arg1.user_shares);
            while (0x1::option::is_some<UserShareKey>(&v2)) {
                let v3 = *0x1::option::borrow<UserShareKey>(&v2);
                let v4 = *0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::linked_list::borrow<UserShareKey, u64>(&mut arg0.id, &arg1.user_shares, v3);
                let v5 = (((v0 as u128) * (v4 as u128) / (v1 as u128)) as u64);
                v0 = v0 - v5;
                v1 = v1 - v4;
                v2 = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::linked_list::next<UserShareKey, u64>(&mut arg0.id, &arg1.user_shares, v3);
                if (v4 >= v5) {
                    remove_share<T0>(arg0, arg1, v3.user, 0x1::option::some<u64>(v4 - v5));
                    continue
                };
                add_share<T0>(arg0, arg1, v3.user, v5 - v4);
            };
        };
    }

    public fun bidder_balance<T0, T1>(arg0: &BidVault<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.bidder_sub_vault.balance)
    }

    public fun bidder_share_supply<T0, T1>(arg0: &BidVault<T0, T1>) : u64 {
        arg0.bidder_sub_vault.share_supply
    }

    public fun bidder_shares<T0, T1>(arg0: &BidVault<T0, T1>) : &0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::linked_list::LinkedList<UserShareKey, u64> {
        &arg0.bidder_sub_vault.user_shares
    }

    public fun claim<T0, T1>(arg0: &mut UserShareRegistry, arg1: &mut DepositVault<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = &mut arg1.inactive_sub_vault;
        let (v2, v3) = withdraw_<T1>(arg0, v1, 0x1::option::none<u64>(), v0);
        let v4 = v3;
        if (v2 == 0) {
            0x2::balance::destroy_zero<T1>(v4);
            return (0, 0)
        };
        let v5 = 0x2::balance::split<T1>(&mut v4, (((0x2::balance::value<T1>(&v4) as u128) * (10 as u128) / (0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::multiplier(4) as u128)) as u64));
        let v6 = 0x2::balance::value<T1>(&v4);
        let v7 = 0x2::balance::value<T1>(&v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v4, arg2), v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v5, arg2), @0xb90d6bddf3df46fc5590d412d062c00145dfae1d31446c0f206c61edf02ef5ba);
        let v8 = Claim<T0, T1>{
            signer           : v0,
            user_amount      : v6,
            claim_fee_amount : v7,
        };
        0x2::event::emit<Claim<T0, T1>>(v8);
        (v6, v7)
    }

    public fun close_bid_vault<T0, T1>(arg0: &T0, arg1: &mut UserShareRegistry, arg2: BidVault<T0, T1>, arg3: &mut 0x2::tx_context::TxContext) : (0x2::vec_map::VecMap<address, u64>, 0x2::vec_map::VecMap<address, u64>, 0x2::vec_map::VecMap<address, u64>) {
        let BidVault {
            bidder_sub_vault          : v0,
            premium_sub_vault         : v1,
            performance_fee_sub_vault : v2,
        } = arg2;
        let v3 = close_sub_vault<T1>(arg1, v0, arg3);
        let v4 = close_sub_vault<T1>(arg1, v1, arg3);
        let v5 = close_sub_vault<T1>(arg1, v2, arg3);
        let v6 = CloseBidVault<T0, T1>{
            signer                            : 0x2::tx_context::sender(arg3),
            bidder_sub_vault_receipt          : v3,
            premium_sub_vault_receipt         : v4,
            performance_fee_sub_vault_receipt : v5,
        };
        0x2::event::emit<CloseBidVault<T0, T1>>(v6);
        (v3, v4, v5)
    }

    public fun close_deposit_vault<T0, T1>(arg0: &T0, arg1: &mut UserShareRegistry, arg2: DepositVault<T0, T1>, arg3: &mut 0x2::tx_context::TxContext) : (0x2::vec_map::VecMap<address, u64>, 0x2::vec_map::VecMap<address, u64>, 0x2::vec_map::VecMap<address, u64>, 0x2::vec_map::VecMap<address, u64>) {
        let DepositVault {
            active_sub_vault       : v0,
            deactivating_sub_vault : v1,
            inactive_sub_vault     : v2,
            warmup_sub_vault       : v3,
            has_next               : _,
        } = arg2;
        let v5 = close_sub_vault<T1>(arg1, v0, arg3);
        let v6 = close_sub_vault<T1>(arg1, v1, arg3);
        let v7 = close_sub_vault<T1>(arg1, v2, arg3);
        let v8 = close_sub_vault<T1>(arg1, v3, arg3);
        let v9 = CloseDepositVault<T0, T1>{
            signer                         : 0x2::tx_context::sender(arg3),
            active_sub_vault_receipt       : v5,
            deactivating_sub_vault_receipt : v6,
            inactive_sub_vault_receipt     : v7,
            warmup_sub_vault_receipt       : v8,
        };
        0x2::event::emit<CloseDepositVault<T0, T1>>(v9);
        (v5, v6, v7, v8)
    }

    fun close_sub_vault<T0>(arg0: &mut UserShareRegistry, arg1: SubVault<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::vec_map::VecMap<address, u64> {
        let v0 = 0x2::vec_map::empty<address, u64>();
        let v1 = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::linked_list::first<UserShareKey, u64>(&arg1.user_shares);
        while (0x1::option::is_some<UserShareKey>(&v1)) {
            let v2 = *0x1::option::borrow<UserShareKey>(&v1);
            v1 = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::linked_list::next<UserShareKey, u64>(&mut arg0.id, &arg1.user_shares, v2);
            let v3 = &mut arg1;
            let (_, v5) = withdraw_<T0>(arg0, v3, 0x1::option::none<u64>(), v2.user);
            let v6 = v5;
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v6, arg2), v2.user);
            0x2::vec_map::insert<address, u64>(&mut v0, v2.user, 0x2::balance::value<T0>(&v6));
            0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::linked_list::remove_node<UserShareKey, u64>(&mut arg0.id, v2);
        };
        let SubVault {
            index        : _,
            tag          : _,
            balance      : v9,
            share_supply : _,
            user_shares  : _,
        } = arg1;
        0x2::balance::destroy_zero<T0>(v9);
        v0
    }

    public fun compound<T0, T1>(arg0: &mut UserShareRegistry, arg1: &mut UserShareRegistry, arg2: &mut DepositVault<T0, T1>, arg3: &mut BidVault<T0, T1>, arg4: u64, arg5: &0x2::tx_context::TxContext) : u64 {
        assert!(arg2.has_next, 2);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = get_premium_user_share<T0, T1>(arg1, arg3, v0) / arg4 * arg4;
        if (v1 == 0) {
            return 0
        };
        let v2 = &mut arg3.premium_sub_vault;
        let (_, v4) = withdraw_<T1>(arg1, v2, 0x1::option::some<u64>(v1), v0);
        let v5 = v4;
        let v6 = 0x2::balance::value<T1>(&v5);
        let v7 = &mut arg2.warmup_sub_vault;
        deposit_<T1>(arg0, v7, v5, v0);
        let v8 = Compound<T0, T1>{
            signer : v0,
            amount : v6,
        };
        0x2::event::emit<Compound<T0, T1>>(v8);
        v6
    }

    public fun deactivating_balance<T0, T1>(arg0: &DepositVault<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.deactivating_sub_vault.balance)
    }

    public fun deactivating_share_supply<T0, T1>(arg0: &DepositVault<T0, T1>) : u64 {
        arg0.deactivating_sub_vault.share_supply
    }

    public fun deactivating_user_shares<T0, T1>(arg0: &DepositVault<T0, T1>) : &0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::linked_list::LinkedList<UserShareKey, u64> {
        &arg0.deactivating_sub_vault.user_shares
    }

    public fun delivery<T0, T1, T2>(arg0: &T0, arg1: &mut UserShareRegistry, arg2: &mut UserShareRegistry, arg3: &mut DepositVault<T0, T1>, arg4: &mut BidVault<T0, T2>, arg5: u64, arg6: 0x2::balance::Balance<T2>, arg7: 0x2::vec_map::VecMap<address, u64>, arg8: &0x2::tx_context::TxContext) {
        refund<T0, T1>(arg0, arg1, arg3, arg5, arg8);
        let v0 = 0x2::balance::value<T2>(&arg6);
        let v1 = v0 * 1000 / 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::multiplier(4);
        0x2::balance::join<T2>(&mut arg4.performance_fee_sub_vault.balance, 0x2::balance::split<T2>(&mut arg6, v1));
        0x2::balance::join<T2>(&mut arg4.premium_sub_vault.balance, arg6);
        let v2 = v0 - v1;
        let v3 = v1;
        let v4 = arg3.active_sub_vault.share_supply + arg3.deactivating_sub_vault.share_supply;
        let v5 = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::linked_list::first<UserShareKey, u64>(&arg3.active_sub_vault.user_shares);
        while (0x1::option::is_some<UserShareKey>(&v5)) {
            let v6 = *0x1::option::borrow<UserShareKey>(&v5);
            let v7 = *0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::linked_list::borrow<UserShareKey, u64>(&arg1.id, &arg3.active_sub_vault.user_shares, v6);
            let v8 = (((v2 as u128) * (v7 as u128) / (v4 as u128)) as u64);
            let v9 = (((v3 as u128) * (v7 as u128) / (v4 as u128)) as u64);
            let v10 = &mut arg4.premium_sub_vault;
            add_share<T2>(arg2, v10, v6.user, v8);
            let v11 = &mut arg4.performance_fee_sub_vault;
            add_share<T2>(arg2, v11, v6.user, v9);
            v2 = v2 - v8;
            v3 = v3 - v9;
            v4 = v4 - v7;
            v5 = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::linked_list::next<UserShareKey, u64>(&arg1.id, &arg3.active_sub_vault.user_shares, v6);
        };
        let v12 = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::linked_list::first<UserShareKey, u64>(&arg3.deactivating_sub_vault.user_shares);
        while (0x1::option::is_some<UserShareKey>(&v12)) {
            let v13 = *0x1::option::borrow<UserShareKey>(&v12);
            let v14 = *0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::linked_list::borrow<UserShareKey, u64>(&arg1.id, &arg3.deactivating_sub_vault.user_shares, v13);
            let v15 = (((v2 as u128) * (v14 as u128) / (v4 as u128)) as u64);
            let v16 = (((v3 as u128) * (v14 as u128) / (v4 as u128)) as u64);
            let v17 = &mut arg4.premium_sub_vault;
            add_share<T2>(arg2, v17, v13.user, v15);
            let v18 = &mut arg4.performance_fee_sub_vault;
            add_share<T2>(arg2, v18, v13.user, v16);
            v2 = v2 - v15;
            v3 = v3 - v16;
            v4 = v4 - v14;
            v12 = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::linked_list::next<UserShareKey, u64>(&arg1.id, &arg3.deactivating_sub_vault.user_shares, v13);
        };
        while (!0x2::vec_map::is_empty<address, u64>(&arg7)) {
            let (v19, v20) = 0x2::vec_map::pop<address, u64>(&mut arg7);
            let v21 = &mut arg4.bidder_sub_vault;
            add_share<T2>(arg2, v21, v19, v20);
        };
        let v22 = Delivery<T0, T2>{
            signer          : 0x2::tx_context::sender(arg8),
            premium         : v0,
            performance_fee : v1,
        };
        0x2::event::emit<Delivery<T0, T2>>(v22);
    }

    public fun delivery_active<T0, T1, T2>(arg0: &T0, arg1: &mut UserShareRegistry, arg2: &mut UserShareRegistry, arg3: &mut DepositVault<T0, T1>, arg4: &mut BidVault<T0, T2>, arg5: u64, arg6: u64, arg7: u64, arg8: 0x1::option::Option<UserShareKey>, arg9: u64) : (u64, u64, u64, 0x1::option::Option<UserShareKey>) {
        let v0 = if (0x1::option::is_some<UserShareKey>(&arg8)) {
            arg8
        } else {
            0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::linked_list::first<UserShareKey, u64>(&arg3.active_sub_vault.user_shares)
        };
        let v1 = v0;
        while (0x1::option::is_some<UserShareKey>(&v1) && arg9 > 0) {
            let v2 = *0x1::option::borrow<UserShareKey>(&v1);
            let v3 = *0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::linked_list::borrow<UserShareKey, u64>(&arg1.id, &arg3.active_sub_vault.user_shares, v2);
            let v4 = (((arg6 as u128) * (v3 as u128) / (arg5 as u128)) as u64);
            let v5 = (((arg7 as u128) * (v3 as u128) / (arg5 as u128)) as u64);
            let v6 = &mut arg4.premium_sub_vault;
            add_share<T2>(arg2, v6, v2.user, v4);
            let v7 = &mut arg4.performance_fee_sub_vault;
            add_share<T2>(arg2, v7, v2.user, v5);
            arg6 = arg6 - v4;
            arg7 = arg7 - v5;
            arg5 = arg5 - v3;
            v1 = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::linked_list::next<UserShareKey, u64>(&arg1.id, &arg3.active_sub_vault.user_shares, v2);
            arg9 = arg9 - 1;
        };
        (arg5, arg6, arg7, v1)
    }

    public fun delivery_bidder<T0, T1>(arg0: &T0, arg1: &mut UserShareRegistry, arg2: &mut BidVault<T0, T1>, arg3: 0x2::vec_map::VecMap<address, u64>, arg4: u64) : 0x2::vec_map::VecMap<address, u64> {
        while (!0x2::vec_map::is_empty<address, u64>(&arg3) && arg4 > 0) {
            let (v0, v1) = 0x2::vec_map::pop<address, u64>(&mut arg3);
            let v2 = &mut arg2.bidder_sub_vault;
            add_share<T1>(arg1, v2, v0, v1);
            arg4 = arg4 - 1;
        };
        arg3
    }

    public fun delivery_deactivating<T0, T1, T2>(arg0: &T0, arg1: &mut UserShareRegistry, arg2: &mut UserShareRegistry, arg3: &mut DepositVault<T0, T1>, arg4: &mut BidVault<T0, T2>, arg5: u64, arg6: u64, arg7: u64, arg8: 0x1::option::Option<UserShareKey>, arg9: u64) : (u64, u64, u64, 0x1::option::Option<UserShareKey>) {
        let v0 = if (0x1::option::is_some<UserShareKey>(&arg8)) {
            arg8
        } else {
            0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::linked_list::first<UserShareKey, u64>(&arg3.deactivating_sub_vault.user_shares)
        };
        let v1 = v0;
        while (0x1::option::is_some<UserShareKey>(&v1) && arg9 > 0) {
            let v2 = *0x1::option::borrow<UserShareKey>(&v1);
            let v3 = *0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::linked_list::borrow<UserShareKey, u64>(&arg1.id, &arg3.deactivating_sub_vault.user_shares, v2);
            let v4 = (((arg6 as u128) * (v3 as u128) / (arg5 as u128)) as u64);
            let v5 = (((arg7 as u128) * (v3 as u128) / (arg5 as u128)) as u64);
            let v6 = &mut arg4.premium_sub_vault;
            add_share<T2>(arg2, v6, v2.user, v4);
            let v7 = &mut arg4.performance_fee_sub_vault;
            add_share<T2>(arg2, v7, v2.user, v5);
            arg6 = arg6 - v4;
            arg7 = arg7 - v5;
            arg5 = arg5 - v3;
            v1 = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::linked_list::next<UserShareKey, u64>(&arg1.id, &arg3.deactivating_sub_vault.user_shares, v2);
            arg9 = arg9 - 1;
        };
        (arg5, arg6, arg7, v1)
    }

    public fun delivery_multiple<T0, T1, T2, T3>(arg0: &T0, arg1: &mut UserShareRegistry, arg2: &mut UserShareRegistry, arg3: &mut UserShareRegistry, arg4: &mut DepositVault<T0, T1>, arg5: &mut DepositVault<T0, T2>, arg6: &mut BidVault<T0, T3>, arg7: u64, arg8: u64, arg9: 0x2::balance::Balance<T3>, arg10: 0x2::vec_map::VecMap<address, u64>, arg11: &0x2::tx_context::TxContext) {
        refund<T0, T1>(arg0, arg1, arg4, arg7, arg11);
        refund<T0, T2>(arg0, arg2, arg5, arg8, arg11);
        let v0 = 0x2::balance::value<T3>(&arg9);
        let v1 = v0 * 1000 / 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::multiplier(4);
        0x2::balance::join<T3>(&mut arg6.performance_fee_sub_vault.balance, 0x2::balance::split<T3>(&mut arg9, v1));
        0x2::balance::join<T3>(&mut arg6.premium_sub_vault.balance, arg9);
        let v2 = v0 - v1;
        let v3 = v1;
        let v4 = arg4.active_sub_vault.share_supply + arg4.deactivating_sub_vault.share_supply;
        let v5 = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::linked_list::first<UserShareKey, u64>(&arg4.active_sub_vault.user_shares);
        while (0x1::option::is_some<UserShareKey>(&v5)) {
            let v6 = *0x1::option::borrow<UserShareKey>(&v5);
            let v7 = *0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::linked_list::borrow<UserShareKey, u64>(&arg1.id, &arg4.active_sub_vault.user_shares, v6);
            let v8 = (((v2 as u128) * (v7 as u128) / (v4 as u128)) as u64);
            let v9 = (((v3 as u128) * (v7 as u128) / (v4 as u128)) as u64);
            let v10 = &mut arg6.premium_sub_vault;
            add_share<T3>(arg3, v10, v6.user, v8);
            let v11 = &mut arg6.performance_fee_sub_vault;
            add_share<T3>(arg3, v11, v6.user, v9);
            v2 = v2 - v8;
            v3 = v3 - v9;
            v4 = v4 - v7;
            v5 = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::linked_list::next<UserShareKey, u64>(&arg1.id, &arg4.active_sub_vault.user_shares, v6);
        };
        let v12 = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::linked_list::first<UserShareKey, u64>(&arg4.deactivating_sub_vault.user_shares);
        while (0x1::option::is_some<UserShareKey>(&v12)) {
            let v13 = *0x1::option::borrow<UserShareKey>(&v12);
            let v14 = *0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::linked_list::borrow<UserShareKey, u64>(&arg1.id, &arg4.deactivating_sub_vault.user_shares, v13);
            let v15 = (((v2 as u128) * (v14 as u128) / (v4 as u128)) as u64);
            let v16 = (((v3 as u128) * (v14 as u128) / (v4 as u128)) as u64);
            let v17 = &mut arg6.premium_sub_vault;
            add_share<T3>(arg3, v17, v13.user, v15);
            let v18 = &mut arg6.performance_fee_sub_vault;
            add_share<T3>(arg3, v18, v13.user, v16);
            v2 = v2 - v15;
            v3 = v3 - v16;
            v4 = v4 - v14;
            v12 = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::linked_list::next<UserShareKey, u64>(&arg1.id, &arg4.deactivating_sub_vault.user_shares, v13);
        };
        while (!0x2::vec_map::is_empty<address, u64>(&arg10)) {
            let (v19, v20) = 0x2::vec_map::pop<address, u64>(&mut arg10);
            let v21 = &mut arg6.bidder_sub_vault;
            add_share<T3>(arg3, v21, v19, v20);
        };
        let v22 = DeliveryMultiple<T0, T2, T3, T1>{
            signer          : 0x2::tx_context::sender(arg11),
            premium         : v0,
            performance_fee : v1,
        };
        0x2::event::emit<DeliveryMultiple<T0, T2, T3, T1>>(v22);
    }

    public fun delivery_premium<T0, T1>(arg0: &T0, arg1: &mut BidVault<T0, T1>, arg2: 0x2::balance::Balance<T1>) : (u64, u64) {
        let v0 = 0x2::balance::value<T1>(&arg2);
        let v1 = v0 * 1000 / 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::multiplier(4);
        0x2::balance::join<T1>(&mut arg1.performance_fee_sub_vault.balance, 0x2::balance::split<T1>(&mut arg2, v1));
        0x2::balance::join<T1>(&mut arg1.premium_sub_vault.balance, arg2);
        (v0 - v1, v1)
    }

    public fun deposit<T0, T1>(arg0: &mut UserShareRegistry, arg1: &mut DepositVault<T0, T1>, arg2: vector<0x2::coin::Coin<T1>>, arg3: u64, arg4: u64, arg5: &0x2::tx_context::TxContext) : u64 {
        assert!(arg1.has_next, 2);
        assert!(arg3 > 0, 0);
        assert!(arg3 / arg4 > 0 && arg3 % arg4 == 0, 1);
        assert!(18446744073709551615 - 0x2::balance::value<T1>(&arg1.active_sub_vault.balance) - 0x2::balance::value<T1>(&arg1.deactivating_sub_vault.balance) >= arg3, 11);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = &mut arg1.warmup_sub_vault;
        let v2 = deposit_<T1>(arg0, v1, 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::extract_balance<T1>(arg2, arg3, arg5), v0);
        let v3 = Deposit<T0, T1>{
            signer : v0,
            amount : v2,
        };
        0x2::event::emit<Deposit<T0, T1>>(v3);
        v2
    }

    fun deposit_<T0>(arg0: &mut UserShareRegistry, arg1: &mut SubVault<T0>, arg2: 0x2::balance::Balance<T0>, arg3: address) : u64 {
        assert!(arg1.share_supply == 0x2::balance::value<T0>(&arg1.balance), 13);
        let v0 = 0x2::balance::value<T0>(&arg2);
        0x2::balance::join<T0>(&mut arg1.balance, arg2);
        add_share<T0>(arg0, arg1, arg3, v0);
        v0
    }

    fun deposit_front_<T0>(arg0: &mut UserShareRegistry, arg1: &mut SubVault<T0>, arg2: 0x2::balance::Balance<T0>, arg3: address) {
        assert!(arg1.share_supply == 0x2::balance::value<T0>(&arg1.balance), 13);
        0x2::balance::join<T0>(&mut arg1.balance, arg2);
        add_share_front<T0>(arg0, arg1, arg3, 0x2::balance::value<T0>(&arg2));
    }

    public fun get_active_user_share<T0, T1>(arg0: &UserShareRegistry, arg1: &DepositVault<T0, T1>, arg2: address) : u64 {
        let v0 = UserShareKey{
            index : arg1.active_sub_vault.index,
            tag   : 0,
            user  : arg2,
        };
        if (0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::linked_list::contains<UserShareKey, u64>(&arg0.id, &arg1.active_sub_vault.user_shares, v0)) {
            *0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::linked_list::borrow<UserShareKey, u64>(&arg0.id, &arg1.active_sub_vault.user_shares, v0)
        } else {
            0
        }
    }

    public fun get_bid_vault_balance<T0, T1>(arg0: &BidVault<T0, T1>) : (u64, u64) {
        (0x2::balance::value<T1>(&arg0.premium_sub_vault.balance), 0x2::balance::value<T1>(&arg0.performance_fee_sub_vault.balance))
    }

    public fun get_bid_vault_share_supply<T0, T1>(arg0: &BidVault<T0, T1>) : (u64, u64) {
        (arg0.premium_sub_vault.share_supply, arg0.performance_fee_sub_vault.share_supply)
    }

    public fun get_bidder_user_share<T0, T1>(arg0: &UserShareRegistry, arg1: &BidVault<T0, T1>, arg2: address) : u64 {
        let v0 = UserShareKey{
            index : arg1.bidder_sub_vault.index,
            tag   : 4,
            user  : arg2,
        };
        if (0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::linked_list::contains<UserShareKey, u64>(&arg0.id, &arg1.bidder_sub_vault.user_shares, v0)) {
            *0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::linked_list::borrow<UserShareKey, u64>(&arg0.id, &arg1.bidder_sub_vault.user_shares, v0)
        } else {
            0
        }
    }

    public fun get_deactivating_user_share<T0, T1>(arg0: &UserShareRegistry, arg1: &DepositVault<T0, T1>, arg2: address) : u64 {
        let v0 = UserShareKey{
            index : arg1.deactivating_sub_vault.index,
            tag   : 1,
            user  : arg2,
        };
        if (0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::linked_list::contains<UserShareKey, u64>(&arg0.id, &arg1.deactivating_sub_vault.user_shares, v0)) {
            *0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::linked_list::borrow<UserShareKey, u64>(&arg0.id, &arg1.deactivating_sub_vault.user_shares, v0)
        } else {
            0
        }
    }

    public fun get_deposit_vault_balance<T0, T1>(arg0: &DepositVault<T0, T1>) : (u64, u64, u64, u64) {
        (0x2::balance::value<T1>(&arg0.active_sub_vault.balance), 0x2::balance::value<T1>(&arg0.deactivating_sub_vault.balance), 0x2::balance::value<T1>(&arg0.inactive_sub_vault.balance), 0x2::balance::value<T1>(&arg0.warmup_sub_vault.balance))
    }

    public fun get_deposit_vault_share_supply<T0, T1>(arg0: &DepositVault<T0, T1>) : (u64, u64, u64, u64) {
        (arg0.active_sub_vault.share_supply, arg0.deactivating_sub_vault.share_supply, arg0.inactive_sub_vault.share_supply, arg0.warmup_sub_vault.share_supply)
    }

    public fun get_inactive_user_share<T0, T1>(arg0: &UserShareRegistry, arg1: &DepositVault<T0, T1>, arg2: address) : u64 {
        let v0 = UserShareKey{
            index : arg1.inactive_sub_vault.index,
            tag   : 2,
            user  : arg2,
        };
        if (0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::linked_list::contains<UserShareKey, u64>(&arg0.id, &arg1.inactive_sub_vault.user_shares, v0)) {
            *0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::linked_list::borrow<UserShareKey, u64>(&arg0.id, &arg1.inactive_sub_vault.user_shares, v0)
        } else {
            0
        }
    }

    public fun get_performance_fee_user_share<T0, T1>(arg0: &UserShareRegistry, arg1: &BidVault<T0, T1>, arg2: address) : u64 {
        let v0 = UserShareKey{
            index : arg1.performance_fee_sub_vault.index,
            tag   : 6,
            user  : arg2,
        };
        if (0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::linked_list::contains<UserShareKey, u64>(&arg0.id, &arg1.performance_fee_sub_vault.user_shares, v0)) {
            *0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::linked_list::borrow<UserShareKey, u64>(&arg0.id, &arg1.performance_fee_sub_vault.user_shares, v0)
        } else {
            0
        }
    }

    public fun get_premium_user_share<T0, T1>(arg0: &UserShareRegistry, arg1: &BidVault<T0, T1>, arg2: address) : u64 {
        let v0 = UserShareKey{
            index : arg1.premium_sub_vault.index,
            tag   : 5,
            user  : arg2,
        };
        if (0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::linked_list::contains<UserShareKey, u64>(&arg0.id, &arg1.premium_sub_vault.user_shares, v0)) {
            *0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::linked_list::borrow<UserShareKey, u64>(&arg0.id, &arg1.premium_sub_vault.user_shares, v0)
        } else {
            0
        }
    }

    public fun get_user_share_key_info(arg0: &UserShareKey) : (u64, u8, address) {
        (arg0.index, arg0.tag, arg0.user)
    }

    public fun get_user_share_registry_uid(arg0: &UserShareRegistry) : &0x2::object::UID {
        &arg0.id
    }

    public fun get_warmup_user_share<T0, T1>(arg0: &UserShareRegistry, arg1: &DepositVault<T0, T1>, arg2: address) : u64 {
        let v0 = UserShareKey{
            index : arg1.warmup_sub_vault.index,
            tag   : 3,
            user  : arg2,
        };
        if (0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::linked_list::contains<UserShareKey, u64>(&arg0.id, &arg1.warmup_sub_vault.user_shares, v0)) {
            *0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::linked_list::borrow<UserShareKey, u64>(&arg0.id, &arg1.warmup_sub_vault.user_shares, v0)
        } else {
            0
        }
    }

    public fun harvest<T0, T1>(arg0: &mut UserShareRegistry, arg1: &mut BidVault<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = &mut arg1.premium_sub_vault;
        let (v2, v3) = withdraw_<T1>(arg0, v1, 0x1::option::none<u64>(), v0);
        let v4 = v3;
        if (v2 == 0) {
            0x2::balance::destroy_zero<T1>(v4);
            return (0, 0)
        };
        let v5 = 0x2::balance::value<T1>(&v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v4, arg2), v0);
        let v6 = Harvest<T0, T1>{
            signer : v0,
            share  : v2,
            amount : v5,
        };
        0x2::event::emit<Harvest<T0, T1>>(v6);
        (v2, v5)
    }

    public fun has_next<T0, T1>(arg0: &DepositVault<T0, T1>) : bool {
        arg0.has_next
    }

    public fun hotfix_bid_vault<T0, T1>(arg0: &mut UserShareRegistry, arg1: &mut BidVault<T0, T1>, arg2: 0x1::option::Option<UserShareKey>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<UserShareKey> {
        if (0x2::balance::value<T1>(&arg1.premium_sub_vault.balance) != arg1.premium_sub_vault.share_supply) {
            let v1 = &mut arg1.premium_sub_vault;
            adjust_user_share_limited<T1>(arg0, v1, arg2, arg3)
        } else if (0x2::balance::value<T1>(&arg1.performance_fee_sub_vault.balance) != 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg1.performance_fee_sub_vault.balance, 0x2::balance::value<T1>(&arg1.performance_fee_sub_vault.balance)), arg4), @0xb90d6bddf3df46fc5590d412d062c00145dfae1d31446c0f206c61edf02ef5ba);
            0x1::option::none<UserShareKey>()
        } else if (0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::linked_list::length<UserShareKey, u64>(&mut arg1.performance_fee_sub_vault.user_shares) != 0) {
            while (arg3 > 0) {
                let (_, v3) = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::linked_list::pop_front<UserShareKey, u64>(&mut arg0.id, &mut arg1.performance_fee_sub_vault.user_shares);
                arg1.performance_fee_sub_vault.share_supply = arg1.performance_fee_sub_vault.share_supply - v3;
                arg3 = arg3 - 1;
            };
            0x1::option::none<UserShareKey>()
        } else {
            0x1::option::none<UserShareKey>()
        }
    }

    public fun inactive_balance<T0, T1>(arg0: &DepositVault<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.inactive_sub_vault.balance)
    }

    public fun inactive_share_supply<T0, T1>(arg0: &DepositVault<T0, T1>) : u64 {
        arg0.inactive_sub_vault.share_supply
    }

    public fun inactive_user_shares<T0, T1>(arg0: &DepositVault<T0, T1>) : &0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::linked_list::LinkedList<UserShareKey, u64> {
        &arg0.inactive_sub_vault.user_shares
    }

    public fun is_active_user<T0, T1>(arg0: &UserShareRegistry, arg1: &DepositVault<T0, T1>, arg2: address) : bool {
        let v0 = UserShareKey{
            index : arg1.active_sub_vault.index,
            tag   : 0,
            user  : arg2,
        };
        0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::linked_list::contains<UserShareKey, u64>(&arg0.id, &arg1.active_sub_vault.user_shares, v0)
    }

    public fun is_deactivating_user<T0, T1>(arg0: &UserShareRegistry, arg1: &DepositVault<T0, T1>, arg2: address) : bool {
        let v0 = UserShareKey{
            index : arg1.deactivating_sub_vault.index,
            tag   : 1,
            user  : arg2,
        };
        0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::linked_list::contains<UserShareKey, u64>(&arg0.id, &arg1.deactivating_sub_vault.user_shares, v0)
    }

    public fun is_inactive_user<T0, T1>(arg0: &UserShareRegistry, arg1: &DepositVault<T0, T1>, arg2: address) : bool {
        let v0 = UserShareKey{
            index : arg1.inactive_sub_vault.index,
            tag   : 2,
            user  : arg2,
        };
        0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::linked_list::contains<UserShareKey, u64>(&arg0.id, &arg1.inactive_sub_vault.user_shares, v0)
    }

    public fun is_warmup_user<T0, T1>(arg0: &UserShareRegistry, arg1: &DepositVault<T0, T1>, arg2: address) : bool {
        let v0 = UserShareKey{
            index : arg1.warmup_sub_vault.index,
            tag   : 3,
            user  : arg2,
        };
        0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::linked_list::contains<UserShareKey, u64>(&arg0.id, &arg1.warmup_sub_vault.user_shares, v0)
    }

    public fun new_bid_vault<T0, T1>(arg0: u64, arg1: &UserShareRegistry, arg2: &mut 0x2::tx_context::TxContext) : BidVault<T0, T1> {
        let v0 = SubVault<T1>{
            index        : arg0,
            tag          : 4,
            balance      : 0x2::balance::zero<T1>(),
            share_supply : 0,
            user_shares  : 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::linked_list::new<UserShareKey, u64>(0x2::object::uid_to_inner(&arg1.id)),
        };
        let v1 = SubVault<T1>{
            index        : arg0,
            tag          : 5,
            balance      : 0x2::balance::zero<T1>(),
            share_supply : 0,
            user_shares  : 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::linked_list::new<UserShareKey, u64>(0x2::object::uid_to_inner(&arg1.id)),
        };
        let v2 = SubVault<T1>{
            index        : arg0,
            tag          : 6,
            balance      : 0x2::balance::zero<T1>(),
            share_supply : 0,
            user_shares  : 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::linked_list::new<UserShareKey, u64>(0x2::object::uid_to_inner(&arg1.id)),
        };
        let v3 = BidVault<T0, T1>{
            bidder_sub_vault          : v0,
            premium_sub_vault         : v1,
            performance_fee_sub_vault : v2,
        };
        let v4 = NewBidVault<T0, T1>{signer: 0x2::tx_context::sender(arg2)};
        0x2::event::emit<NewBidVault<T0, T1>>(v4);
        v3
    }

    public fun new_deposit_vault<T0, T1>(arg0: u64, arg1: &UserShareRegistry, arg2: &mut 0x2::tx_context::TxContext) : DepositVault<T0, T1> {
        let v0 = SubVault<T1>{
            index        : arg0,
            tag          : 0,
            balance      : 0x2::balance::zero<T1>(),
            share_supply : 0,
            user_shares  : 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::linked_list::new<UserShareKey, u64>(0x2::object::uid_to_inner(&arg1.id)),
        };
        let v1 = SubVault<T1>{
            index        : arg0,
            tag          : 1,
            balance      : 0x2::balance::zero<T1>(),
            share_supply : 0,
            user_shares  : 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::linked_list::new<UserShareKey, u64>(0x2::object::uid_to_inner(&arg1.id)),
        };
        let v2 = SubVault<T1>{
            index        : arg0,
            tag          : 2,
            balance      : 0x2::balance::zero<T1>(),
            share_supply : 0,
            user_shares  : 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::linked_list::new<UserShareKey, u64>(0x2::object::uid_to_inner(&arg1.id)),
        };
        let v3 = SubVault<T1>{
            index        : arg0,
            tag          : 3,
            balance      : 0x2::balance::zero<T1>(),
            share_supply : 0,
            user_shares  : 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::linked_list::new<UserShareKey, u64>(0x2::object::uid_to_inner(&arg1.id)),
        };
        let v4 = DepositVault<T0, T1>{
            active_sub_vault       : v0,
            deactivating_sub_vault : v1,
            inactive_sub_vault     : v2,
            warmup_sub_vault       : v3,
            has_next               : true,
        };
        let v5 = NewDepositVault<T0, T1>{signer: 0x2::tx_context::sender(arg2)};
        0x2::event::emit<NewDepositVault<T0, T1>>(v5);
        v4
    }

    public fun new_user_share_key(arg0: u64, arg1: u8, arg2: address) : UserShareKey {
        UserShareKey{
            index : arg0,
            tag   : arg1,
            user  : arg2,
        }
    }

    public fun new_user_share_registry(arg0: &mut 0x2::tx_context::TxContext) : UserShareRegistry {
        UserShareRegistry{id: 0x2::object::new(arg0)}
    }

    public fun performance_fee_balance<T0, T1>(arg0: &BidVault<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.performance_fee_sub_vault.balance)
    }

    public fun performance_fee_share_supply<T0, T1>(arg0: &BidVault<T0, T1>) : u64 {
        arg0.performance_fee_sub_vault.share_supply
    }

    public fun performance_fee_shares<T0, T1>(arg0: &BidVault<T0, T1>) : &0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::linked_list::LinkedList<UserShareKey, u64> {
        &arg0.performance_fee_sub_vault.user_shares
    }

    public fun premium_balance<T0, T1>(arg0: &BidVault<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.premium_sub_vault.balance)
    }

    public fun premium_share_supply<T0, T1>(arg0: &BidVault<T0, T1>) : u64 {
        arg0.premium_sub_vault.share_supply
    }

    public fun premium_shares<T0, T1>(arg0: &BidVault<T0, T1>) : &0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::linked_list::LinkedList<UserShareKey, u64> {
        &arg0.premium_sub_vault.user_shares
    }

    public fun prepare_bid_vault_bidder_share_node(arg0: &mut UserShareRegistry, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        let v0 = UserShareKey{
            index : arg1,
            tag   : 4,
            user  : 0x2::tx_context::sender(arg2),
        };
        0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::linked_list::prepare_node<UserShareKey, u64>(&mut arg0.id, v0, 0);
    }

    public fun prepare_bid_vault_user_share_node(arg0: &mut UserShareRegistry, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = UserShareKey{
            index : arg1,
            tag   : 5,
            user  : v0,
        };
        0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::linked_list::prepare_node<UserShareKey, u64>(&mut arg0.id, v1, 0);
        let v2 = UserShareKey{
            index : arg1,
            tag   : 6,
            user  : v0,
        };
        0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::linked_list::prepare_node<UserShareKey, u64>(&mut arg0.id, v2, 0);
    }

    public fun prepare_deposit_vault_user_share_node(arg0: &mut UserShareRegistry, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = UserShareKey{
            index : arg1,
            tag   : 3,
            user  : v0,
        };
        0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::linked_list::prepare_node<UserShareKey, u64>(&mut arg0.id, v1, 0);
        let v2 = UserShareKey{
            index : arg1,
            tag   : 0,
            user  : v0,
        };
        0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::linked_list::prepare_node<UserShareKey, u64>(&mut arg0.id, v2, 0);
        let v3 = UserShareKey{
            index : arg1,
            tag   : 1,
            user  : v0,
        };
        0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::linked_list::prepare_node<UserShareKey, u64>(&mut arg0.id, v3, 0);
        let v4 = UserShareKey{
            index : arg1,
            tag   : 2,
            user  : v0,
        };
        0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::linked_list::prepare_node<UserShareKey, u64>(&mut arg0.id, v4, 0);
    }

    public fun rebalance_multiple<T0, T1, T2>(arg0: &T0, arg1: &mut UserShareRegistry, arg2: &mut UserShareRegistry, arg3: &mut DepositVault<T0, T1>, arg4: &mut DepositVault<T0, T2>, arg5: u64, arg6: u64, arg7: &0x2::tx_context::TxContext) {
        let v0 = active_balance<T0, T1>(arg3);
        let v1 = active_balance<T0, T2>(arg4);
        if (v0 > 0 && v1 > 0) {
            if ((v0 as u128) * (arg6 as u128) > (v1 as u128) * (arg5 as u128)) {
                let v2 = (((v0 as u128) - (arg5 as u128) * (v1 as u128) / (arg6 as u128)) as u64);
                let v3 = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::linked_list::first<UserShareKey, u64>(&arg3.active_sub_vault.user_shares);
                while (0x1::option::is_some<UserShareKey>(&v3)) {
                    let v4 = *0x1::option::borrow<UserShareKey>(&v3);
                    v3 = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::linked_list::next<UserShareKey, u64>(&arg1.id, &arg3.active_sub_vault.user_shares, v4);
                    let v5 = &mut arg3.active_sub_vault;
                    let v6 = 0x1::option::some<u64>((((*0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::linked_list::borrow<UserShareKey, u64>(&arg1.id, &arg3.active_sub_vault.user_shares, v4) as u128) * (v2 as u128) / (v1 as u128)) as u64));
                    let (_, v8) = withdraw_<T1>(arg1, v5, v6, v4.user);
                    let v9 = &mut arg3.inactive_sub_vault;
                    deposit_<T1>(arg1, v9, v8, v4.user);
                };
                let v10 = RebalanceMultiple<T0, T1>{
                    signer : 0x2::tx_context::sender(arg7),
                    amount : v2,
                };
                0x2::event::emit<RebalanceMultiple<T0, T1>>(v10);
            } else if ((v0 as u128) * (arg6 as u128) < (v1 as u128) * (arg5 as u128)) {
                let v11 = (((v1 as u128) - (arg6 as u128) * (v0 as u128) / (arg5 as u128)) as u64);
                let v12 = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::linked_list::first<UserShareKey, u64>(&arg4.active_sub_vault.user_shares);
                while (0x1::option::is_some<UserShareKey>(&v12)) {
                    let v13 = *0x1::option::borrow<UserShareKey>(&v12);
                    v12 = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::linked_list::next<UserShareKey, u64>(&arg2.id, &arg4.active_sub_vault.user_shares, v13);
                    let v14 = &mut arg4.active_sub_vault;
                    let v15 = 0x1::option::some<u64>((((*0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::linked_list::borrow<UserShareKey, u64>(&arg2.id, &arg4.active_sub_vault.user_shares, v13) as u128) * (v11 as u128) / (v1 as u128)) as u64));
                    let (_, v17) = withdraw_<T2>(arg2, v14, v15, v13.user);
                    let v18 = &mut arg4.inactive_sub_vault;
                    deposit_<T2>(arg2, v18, v17, v13.user);
                };
                let v19 = RebalanceMultiple<T0, T2>{
                    signer : 0x2::tx_context::sender(arg7),
                    amount : v11,
                };
                0x2::event::emit<RebalanceMultiple<T0, T2>>(v19);
            };
        };
    }

    public fun refund<T0, T1>(arg0: &T0, arg1: &mut UserShareRegistry, arg2: &mut DepositVault<T0, T1>, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        let v0 = active_share_supply<T0, T1>(arg2) + deactivating_share_supply<T0, T1>(arg2);
        let v1 = 0;
        let v2 = 0;
        if (v0 > 0) {
            let v3 = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::linked_list::last<UserShareKey, u64>(&arg2.deactivating_sub_vault.user_shares);
            while (0x1::option::is_some<UserShareKey>(&v3)) {
                let v4 = *0x1::option::borrow<UserShareKey>(&v3);
                v3 = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::linked_list::prev<UserShareKey, u64>(&arg1.id, &arg2.deactivating_sub_vault.user_shares, v4);
                let v5 = &mut arg2.deactivating_sub_vault;
                let v6 = 0x1::option::some<u64>((((*0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::linked_list::borrow<UserShareKey, u64>(&arg1.id, &arg2.deactivating_sub_vault.user_shares, v4) as u128) * (arg3 as u128) / (v0 as u128)) as u64));
                let (_, v8) = withdraw_<T1>(arg1, v5, v6, v4.user);
                let v9 = v8;
                v1 = v1 + 0x2::balance::value<T1>(&v9);
                let v10 = &mut arg2.inactive_sub_vault;
                deposit_<T1>(arg1, v10, v9, v4.user);
            };
            let v11 = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::linked_list::last<UserShareKey, u64>(&arg2.active_sub_vault.user_shares);
            while (0x1::option::is_some<UserShareKey>(&v11)) {
                let v12 = *0x1::option::borrow<UserShareKey>(&v11);
                v11 = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::linked_list::prev<UserShareKey, u64>(&arg1.id, &arg2.active_sub_vault.user_shares, v12);
                let v13 = &mut arg2.active_sub_vault;
                let v14 = 0x1::option::some<u64>((((*0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::linked_list::borrow<UserShareKey, u64>(&arg1.id, &arg2.active_sub_vault.user_shares, v12) as u128) * (arg3 as u128) / (v0 as u128)) as u64));
                let (_, v16) = withdraw_<T1>(arg1, v13, v14, v12.user);
                let v17 = v16;
                v2 = v2 + 0x2::balance::value<T1>(&v17);
                if (arg2.has_next) {
                    let v18 = &mut arg2.warmup_sub_vault;
                    deposit_front_<T1>(arg1, v18, v17, v12.user);
                    continue
                };
                let v19 = &mut arg2.inactive_sub_vault;
                deposit_<T1>(arg1, v19, v17, v12.user);
            };
        };
        let v20 = Refund<T0, T1>{
            signer       : 0x2::tx_context::sender(arg4),
            amount       : arg3,
            deactivating : v1,
            active       : v2,
        };
        0x2::event::emit<Refund<T0, T1>>(v20);
    }

    public fun refund_active<T0, T1>(arg0: &T0, arg1: &mut UserShareRegistry, arg2: &mut DepositVault<T0, T1>, arg3: u64, arg4: u64, arg5: 0x1::option::Option<UserShareKey>, arg6: u64) : 0x1::option::Option<UserShareKey> {
        if (arg3 == 0) {
            return 0x1::option::none<UserShareKey>()
        };
        let v0 = if (0x1::option::is_some<UserShareKey>(&arg5)) {
            arg5
        } else {
            0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::linked_list::first<UserShareKey, u64>(&arg2.active_sub_vault.user_shares)
        };
        let v1 = v0;
        while (0x1::option::is_some<UserShareKey>(&v1) && arg6 > 0) {
            let v2 = *0x1::option::borrow<UserShareKey>(&v1);
            v1 = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::linked_list::next<UserShareKey, u64>(&arg1.id, &arg2.active_sub_vault.user_shares, v2);
            let v3 = &mut arg2.active_sub_vault;
            let v4 = 0x1::option::some<u64>((((*0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::linked_list::borrow<UserShareKey, u64>(&arg1.id, &arg2.active_sub_vault.user_shares, v2) as u128) * (arg4 as u128) / (arg3 as u128)) as u64));
            let (_, v6) = withdraw_<T1>(arg1, v3, v4, v2.user);
            if (arg2.has_next) {
                let v7 = &mut arg2.warmup_sub_vault;
                deposit_front_<T1>(arg1, v7, v6, v2.user);
            } else {
                let v8 = &mut arg2.inactive_sub_vault;
                deposit_<T1>(arg1, v8, v6, v2.user);
            };
            arg6 = arg6 - 1;
        };
        v1
    }

    public fun refund_deactivating<T0, T1>(arg0: &T0, arg1: &mut UserShareRegistry, arg2: &mut DepositVault<T0, T1>, arg3: u64, arg4: u64, arg5: 0x1::option::Option<UserShareKey>, arg6: u64) : 0x1::option::Option<UserShareKey> {
        if (arg3 == 0) {
            return 0x1::option::none<UserShareKey>()
        };
        let v0 = if (0x1::option::is_some<UserShareKey>(&arg5)) {
            arg5
        } else {
            0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::linked_list::first<UserShareKey, u64>(&arg2.deactivating_sub_vault.user_shares)
        };
        let v1 = v0;
        while (0x1::option::is_some<UserShareKey>(&v1) && arg6 > 0) {
            let v2 = *0x1::option::borrow<UserShareKey>(&v1);
            v1 = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::linked_list::next<UserShareKey, u64>(&arg1.id, &arg2.deactivating_sub_vault.user_shares, v2);
            let v3 = &mut arg2.deactivating_sub_vault;
            let v4 = 0x1::option::some<u64>((((*0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::linked_list::borrow<UserShareKey, u64>(&arg1.id, &arg2.deactivating_sub_vault.user_shares, v2) as u128) * (arg4 as u128) / (arg3 as u128)) as u64));
            let (_, v6) = withdraw_<T1>(arg1, v3, v4, v2.user);
            let v7 = &mut arg2.inactive_sub_vault;
            deposit_<T1>(arg1, v7, v6, v2.user);
            arg6 = arg6 - 1;
        };
        v1
    }

    fun remove_share<T0>(arg0: &mut UserShareRegistry, arg1: &mut SubVault<T0>, arg2: address, arg3: 0x1::option::Option<u64>) : u64 {
        let v0 = UserShareKey{
            index : arg1.index,
            tag   : arg1.tag,
            user  : arg2,
        };
        if (0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::linked_list::contains<UserShareKey, u64>(&arg0.id, &arg1.user_shares, v0)) {
            if (0x1::option::is_some<u64>(&arg3)) {
                let v2 = 0x1::option::extract<u64>(&mut arg3);
                if (v2 < *0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::linked_list::borrow<UserShareKey, u64>(&arg0.id, &arg1.user_shares, v0)) {
                    let v3 = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::linked_list::borrow_mut<UserShareKey, u64>(&mut arg0.id, &mut arg1.user_shares, v0);
                    *v3 = *v3 - v2;
                    arg1.share_supply = arg1.share_supply - v2;
                    v2
                } else {
                    let v4 = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::linked_list::remove<UserShareKey, u64>(&mut arg0.id, &mut arg1.user_shares, v0);
                    arg1.share_supply = arg1.share_supply - v4;
                    v4
                }
            } else {
                let v5 = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::linked_list::remove<UserShareKey, u64>(&mut arg0.id, &mut arg1.user_shares, v0);
                arg1.share_supply = arg1.share_supply - v5;
                v5
            }
        } else {
            0
        }
    }

    fun rock_n_roll<T0>(arg0: &mut UserShareRegistry, arg1: &mut SubVault<T0>, arg2: &mut SubVault<T0>) {
        0x2::balance::join<T0>(&mut arg2.balance, 0x2::balance::split<T0>(&mut arg1.balance, 0x2::balance::value<T0>(&arg1.balance)));
        while (!0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::linked_list::is_empty<UserShareKey, u64>(&arg1.user_shares)) {
            let (v0, v1) = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::linked_list::pop_front<UserShareKey, u64>(&mut arg0.id, &mut arg1.user_shares);
            let v2 = v0;
            arg1.share_supply = arg1.share_supply - v1;
            add_share<T0>(arg0, arg2, v2.user, v1);
        };
    }

    fun rock_n_roll_limited<T0>(arg0: &mut UserShareRegistry, arg1: &mut SubVault<T0>, arg2: &mut SubVault<T0>, arg3: u64) : (u64, bool) {
        let v0 = 0;
        while (!0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::linked_list::is_empty<UserShareKey, u64>(&arg1.user_shares) && arg3 > 0) {
            let (v1, v2) = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::linked_list::pop_front<UserShareKey, u64>(&mut arg0.id, &mut arg1.user_shares);
            let v3 = v1;
            arg1.share_supply = arg1.share_supply - v2;
            v0 = v0 + v2;
            add_share<T0>(arg0, arg2, v3.user, v2);
            arg3 = arg3 - 1;
        };
        0x2::balance::join<T0>(&mut arg2.balance, 0x2::balance::split<T0>(&mut arg1.balance, v0));
        (v0, 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::linked_list::is_empty<UserShareKey, u64>(&arg1.user_shares))
    }

    public fun settle_fund<T0, T1, T2, T3>(arg0: &T0, arg1: &mut UserShareRegistry, arg2: &mut UserShareRegistry, arg3: &mut DepositVault<T0, T1>, arg4: &mut BidVault<T0, T2>, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(arg7 > 0, 0);
        let v0 = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::multiplier(arg8);
        let v1 = active_balance<T0, T1>(arg3) + deactivating_balance<T0, T1>(arg3);
        let v2 = 0;
        if (v1 != 0) {
            let v3 = if (0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::match_types<T1, T2>()) {
                (((0x2::balance::value<T2>(&arg4.performance_fee_sub_vault.balance) as u128) * (0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::multiplier(4) as u128) / (1000 as u128)) as u64)
            } else if (0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::match_types<T2, T3>()) {
                ((((((0x2::balance::value<T2>(&arg4.performance_fee_sub_vault.balance) as u128) * (0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::multiplier(4) as u128) / (1000 as u128)) as u64) as u128) * (arg9 as u128) / (0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::multiplier(arg10) as u128) * (0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::multiplier(arg5) as u128) / (0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::multiplier(arg6) as u128)) as u64)
            } else {
                ((((((0x2::balance::value<T2>(&arg4.performance_fee_sub_vault.balance) as u128) * (0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::multiplier(4) as u128) / (1000 as u128)) as u64) as u128) * (0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::multiplier(arg10) as u128) / (arg9 as u128) * (0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::multiplier(arg5) as u128) / (0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::multiplier(arg6) as u128)) as u64)
            };
            let v4 = arg7 - (((v0 as u128) * (v3 as u128) / (v1 as u128)) as u64);
            if (arg7 > v0) {
                let v5 = if (0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::match_types<T1, T2>()) {
                    (((v1 as u128) * ((arg7 - v0) as u128) / (v0 as u128)) as u64)
                } else if (0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::match_types<T1, T3>()) {
                    (((arg9 as u128) * ((((v1 as u128) * ((arg7 - v0) as u128) / (v0 as u128)) as u64) as u128) / (0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::multiplier(arg10) as u128) * (0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::multiplier(arg6) as u128) / (0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::multiplier(arg5) as u128)) as u64)
                } else {
                    (((0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::multiplier(arg10) as u128) * ((((v1 as u128) * ((arg7 - v0) as u128) / (v0 as u128)) as u64) as u128) / (arg9 as u128) * (0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::multiplier(arg6) as u128) / (0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::multiplier(arg5) as u128)) as u64)
                };
                let v6 = v5 * 1000 / 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::multiplier(4);
                v2 = v6;
                if (v6 != 0) {
                    0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(0x2::balance::split<T2>(&mut arg4.performance_fee_sub_vault.balance, v6), arg11), @0xb90d6bddf3df46fc5590d412d062c00145dfae1d31446c0f206c61edf02ef5ba);
                };
            };
            if (v4 < v0) {
                let v7 = active_share_supply<T0, T1>(arg3) + deactivating_share_supply<T0, T1>(arg3);
                let v8 = (v1 as u256) * ((v0 - v4) as u256) / (v0 as u256);
                let v9 = 0x2::balance::split<T1>(&mut arg3.active_sub_vault.balance, ((v8 * (arg3.active_sub_vault.share_supply as u256) / (v7 as u256)) as u64));
                let v10 = &mut arg3.active_sub_vault;
                adjust_user_share_ratio<T1>(arg1, v10);
                let v11 = &mut arg3.deactivating_sub_vault;
                adjust_user_share_ratio<T1>(arg1, v11);
                0x2::balance::join<T1>(&mut v9, 0x2::balance::split<T1>(&mut arg3.deactivating_sub_vault.balance, ((v8 * (arg3.deactivating_sub_vault.share_supply as u256) / (v7 as u256)) as u64)));
                while (!0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::linked_list::is_empty<UserShareKey, u64>(&arg4.bidder_sub_vault.user_shares)) {
                    let (v12, v13) = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::linked_list::pop_front<UserShareKey, u64>(&mut arg2.id, &mut arg4.bidder_sub_vault.user_shares);
                    let v14 = v12;
                    0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v9, (((0x2::balance::value<T1>(&v9) as u128) * (v13 as u128) / (arg4.bidder_sub_vault.share_supply as u128)) as u64)), arg11), v14.user);
                    arg4.bidder_sub_vault.share_supply = arg4.bidder_sub_vault.share_supply - v13;
                };
                0x2::balance::destroy_zero<T1>(v9);
            };
            if (0x2::balance::value<T2>(&arg4.performance_fee_sub_vault.balance) > 0) {
                let v15 = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::linked_list::first<UserShareKey, u64>(&arg4.performance_fee_sub_vault.user_shares);
                while (0x1::option::is_some<UserShareKey>(&v15)) {
                    let v16 = *0x1::option::borrow<UserShareKey>(&v15);
                    v15 = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::linked_list::next<UserShareKey, u64>(&arg2.id, &arg4.performance_fee_sub_vault.user_shares, v16);
                    let v17 = &mut arg4.performance_fee_sub_vault;
                    let (_, v19) = withdraw_<T2>(arg2, v17, 0x1::option::none<u64>(), v16.user);
                    let v20 = &mut arg4.premium_sub_vault;
                    deposit_<T2>(arg2, v20, v19, v16.user);
                };
            };
            let v21 = &mut arg3.deactivating_sub_vault;
            let v22 = &mut arg3.inactive_sub_vault;
            rock_n_roll<T1>(arg1, v21, v22);
            arg4.bidder_sub_vault.share_supply = 0;
            while (!0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::linked_list::is_empty<UserShareKey, u64>(&arg4.bidder_sub_vault.user_shares)) {
                let (_, _) = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::linked_list::pop_front<UserShareKey, u64>(&mut arg2.id, &mut arg4.bidder_sub_vault.user_shares);
            };
        };
        if (!arg3.has_next) {
            let v25 = &mut arg3.active_sub_vault;
            let v26 = &mut arg3.inactive_sub_vault;
            rock_n_roll<T1>(arg1, v25, v26);
        };
        let v27 = Settle<T0, T2>{
            signer              : 0x2::tx_context::sender(arg11),
            settled_share_price : arg7,
            share_price_decimal : arg8,
            spot_price          : arg9,
            spot_price_decimal  : arg10,
        };
        0x2::event::emit<Settle<T0, T2>>(v27);
        v2
    }

    public fun settle_fund_multiple<T0, T1, T2, T3>(arg0: &T0, arg1: &mut UserShareRegistry, arg2: &mut UserShareRegistry, arg3: &mut UserShareRegistry, arg4: &mut DepositVault<T0, T1>, arg5: &mut DepositVault<T0, T2>, arg6: &mut BidVault<T0, T3>, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: &mut 0x2::tx_context::TxContext) : (0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::i64::I64, u64) {
        assert!(arg10 > 0, 0);
        assert!(arg11 > 0, 0);
        let v0 = active_balance<T0, T1>(arg4) + deactivating_balance<T0, T1>(arg4);
        let v1 = active_balance<T0, T2>(arg5) + deactivating_balance<T0, T2>(arg5);
        let v2 = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::multiplier(arg12);
        let v3 = if (arg10 > v2) {
            0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::i64::from((((v0 as u128) * ((arg10 - v2) as u128) / (v2 as u128) * (arg14 as u128) / (0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::multiplier(arg15) as u128) * (0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::multiplier(arg8) as u128) / (0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::multiplier(arg7) as u128)) as u64))
        } else {
            0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::i64::neg_from((((v0 as u128) * ((v2 - arg10) as u128) / (v2 as u128) * (arg14 as u128) / (0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::multiplier(arg15) as u128) * (0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::multiplier(arg8) as u128) / (0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::multiplier(arg7) as u128)) as u64))
        };
        let v4 = v3;
        let v5 = if (arg11 > v2) {
            0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::i64::from((((v1 as u128) * ((arg11 - v2) as u128) / (v2 as u128)) as u64))
        } else {
            0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::i64::neg_from((((v1 as u128) * ((v2 - arg11) as u128) / (v2 as u128)) as u64))
        };
        let v6 = v5;
        let v7 = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::i64::add(&v4, &v6);
        let v8 = if (0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::match_types<T2, T3>()) {
            arg13
        } else {
            (((arg13 as u128) * (arg14 as u128) / (0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::multiplier(arg15) as u128) * (0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::multiplier(arg8) as u128) / (0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::multiplier(arg9) as u128)) as u64)
        };
        let v9 = &v7;
        let v10 = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::i64::from(v8);
        v7 = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::i64::add(v9, &v10);
        let v11 = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::i64::zero();
        let v12 = if (0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::i64::compare(&v7, &v11) == 2) {
            if (0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::match_types<T2, T3>()) {
                (((0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::i64::as_u64(&v7) as u128) * (1000 as u128) / (0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::multiplier(4) as u128)) as u64)
            } else {
                ((((((0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::i64::as_u64(&v7) as u128) * (1000 as u128) / (0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::multiplier(4) as u128)) as u64) as u128) * (0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::multiplier(arg15) as u128) / (arg14 as u128) * (0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::multiplier(arg9) as u128) / (0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::utils::multiplier(arg8) as u128)) as u64)
            }
        } else {
            0
        };
        if (v12 != 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(0x2::coin::from_balance<T3>(0x2::balance::split<T3>(&mut arg6.performance_fee_sub_vault.balance, v12), arg16), @0xb90d6bddf3df46fc5590d412d062c00145dfae1d31446c0f206c61edf02ef5ba);
        };
        if (v0 != 0 && v1 != 0) {
            if (arg10 < v2) {
                let v13 = active_share_supply<T0, T1>(arg4) + deactivating_share_supply<T0, T1>(arg4);
                let v14 = (((v0 as u128) * ((v2 - arg10) as u128) / (v2 as u128)) as u64);
                let v15 = 0x2::balance::split<T1>(&mut arg4.active_sub_vault.balance, (((v14 as u128) * (arg4.active_sub_vault.share_supply as u128) / (v13 as u128)) as u64));
                let v16 = &mut arg4.active_sub_vault;
                adjust_user_share_ratio<T1>(arg1, v16);
                let v17 = &mut arg4.deactivating_sub_vault;
                adjust_user_share_ratio<T1>(arg1, v17);
                0x2::balance::join<T1>(&mut v15, 0x2::balance::split<T1>(&mut arg4.deactivating_sub_vault.balance, (((v14 as u128) * (arg4.deactivating_sub_vault.share_supply as u128) / (v13 as u128)) as u64)));
                let v18 = arg6.bidder_sub_vault.share_supply;
                let v19 = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::linked_list::last<UserShareKey, u64>(bidder_shares<T0, T3>(arg6));
                while (0x1::option::is_some<UserShareKey>(&v19)) {
                    let v20 = *0x1::option::borrow<UserShareKey>(&v19);
                    let v21 = *0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::linked_list::borrow<UserShareKey, u64>(&arg3.id, &arg6.bidder_sub_vault.user_shares, v20);
                    0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v15, (((0x2::balance::value<T1>(&v15) as u128) * (v21 as u128) / (v18 as u128)) as u64)), arg16), v20.user);
                    v18 = v18 - v21;
                    v19 = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::linked_list::prev<UserShareKey, u64>(&arg3.id, &arg6.bidder_sub_vault.user_shares, v20);
                };
                0x2::balance::destroy_zero<T1>(v15);
            };
            if (arg11 < v2) {
                let v22 = active_share_supply<T0, T2>(arg5) + deactivating_share_supply<T0, T2>(arg5);
                let v23 = (((v1 as u128) * ((v2 - arg11) as u128) / (v2 as u128)) as u64);
                let v24 = 0x2::balance::split<T2>(&mut arg5.active_sub_vault.balance, (((v23 as u128) * (arg5.active_sub_vault.share_supply as u128) / (v22 as u128)) as u64));
                let v25 = &mut arg5.active_sub_vault;
                adjust_user_share_ratio<T2>(arg2, v25);
                let v26 = &mut arg5.deactivating_sub_vault;
                adjust_user_share_ratio<T2>(arg2, v26);
                0x2::balance::join<T2>(&mut v24, 0x2::balance::split<T2>(&mut arg5.deactivating_sub_vault.balance, (((v23 as u128) * (arg5.deactivating_sub_vault.share_supply as u128) / (v22 as u128)) as u64)));
                while (!0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::linked_list::is_empty<UserShareKey, u64>(&arg6.bidder_sub_vault.user_shares)) {
                    let (v27, v28) = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::linked_list::pop_front<UserShareKey, u64>(&mut arg3.id, &mut arg6.bidder_sub_vault.user_shares);
                    let v29 = v27;
                    0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(0x2::balance::split<T2>(&mut v24, (((0x2::balance::value<T2>(&v24) as u128) * (v28 as u128) / (arg6.bidder_sub_vault.share_supply as u128)) as u64)), arg16), v29.user);
                    arg6.bidder_sub_vault.share_supply = arg6.bidder_sub_vault.share_supply - v28;
                };
                0x2::balance::destroy_zero<T2>(v24);
            };
            if (0x2::balance::value<T3>(&arg6.performance_fee_sub_vault.balance) > 0) {
                let v30 = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::linked_list::first<UserShareKey, u64>(&arg6.performance_fee_sub_vault.user_shares);
                while (0x1::option::is_some<UserShareKey>(&v30)) {
                    let v31 = *0x1::option::borrow<UserShareKey>(&v30);
                    v30 = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::linked_list::next<UserShareKey, u64>(&arg3.id, &arg6.performance_fee_sub_vault.user_shares, v31);
                    let v32 = &mut arg6.performance_fee_sub_vault;
                    let (_, v34) = withdraw_<T3>(arg3, v32, 0x1::option::none<u64>(), v31.user);
                    let v35 = &mut arg6.premium_sub_vault;
                    deposit_<T3>(arg3, v35, v34, v31.user);
                };
            };
            let v36 = &mut arg4.deactivating_sub_vault;
            let v37 = &mut arg4.inactive_sub_vault;
            rock_n_roll<T1>(arg1, v36, v37);
            let v38 = &mut arg5.deactivating_sub_vault;
            let v39 = &mut arg5.inactive_sub_vault;
            rock_n_roll<T2>(arg2, v38, v39);
            arg6.bidder_sub_vault.share_supply = 0;
            while (!0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::linked_list::is_empty<UserShareKey, u64>(&arg6.bidder_sub_vault.user_shares)) {
                let (_, _) = 0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::linked_list::pop_front<UserShareKey, u64>(&mut arg3.id, &mut arg6.bidder_sub_vault.user_shares);
            };
            let v42 = SettleMultiple<T0, T2, T3, T1>{
                signer                    : 0x2::tx_context::sender(arg16),
                settled_share_price_token : arg10,
                settled_share_price_usd   : arg11,
                share_price_decimal       : arg12,
                spot_price                : arg14,
                spot_price_decimal        : arg15,
            };
            0x2::event::emit<SettleMultiple<T0, T2, T3, T1>>(v42);
        };
        if (!arg4.has_next) {
            let v43 = &mut arg4.active_sub_vault;
            let v44 = &mut arg4.inactive_sub_vault;
            rock_n_roll<T1>(arg1, v43, v44);
            let v45 = &mut arg5.active_sub_vault;
            let v46 = &mut arg5.inactive_sub_vault;
            rock_n_roll<T2>(arg2, v45, v46);
        };
        (v7, v12)
    }

    public fun unsubscribe<T0, T1>(arg0: &mut UserShareRegistry, arg1: &mut DepositVault<T0, T1>, arg2: 0x1::option::Option<u64>, arg3: &0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = &mut arg1.active_sub_vault;
        let (v2, v3) = withdraw_<T1>(arg0, v1, arg2, v0);
        if (v2 == 0) {
            0x2::balance::destroy_zero<T1>(v3);
            return 0
        };
        let v4 = &mut arg1.deactivating_sub_vault;
        deposit_<T1>(arg0, v4, v3, v0);
        let v5 = Unsubscribe<T0, T1>{
            signer : v0,
            amount : v2,
        };
        0x2::event::emit<Unsubscribe<T0, T1>>(v5);
        v2
    }

    public fun user_share_registry_uid(arg0: &UserShareRegistry) : &0x2::object::UID {
        &arg0.id
    }

    public fun warmup_balance<T0, T1>(arg0: &DepositVault<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.warmup_sub_vault.balance)
    }

    public fun warmup_share_supply<T0, T1>(arg0: &DepositVault<T0, T1>) : u64 {
        arg0.warmup_sub_vault.share_supply
    }

    public fun warmup_user_shares<T0, T1>(arg0: &DepositVault<T0, T1>) : &0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::linked_list::LinkedList<UserShareKey, u64> {
        &arg0.warmup_sub_vault.user_shares
    }

    public fun withdraw<T0, T1>(arg0: &mut UserShareRegistry, arg1: &mut DepositVault<T0, T1>, arg2: 0x1::option::Option<u64>, arg3: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = &mut arg1.warmup_sub_vault;
        let (v2, v3) = withdraw_<T1>(arg0, v1, arg2, v0);
        if (v2 == 0) {
            0x2::balance::destroy_zero<T1>(v3);
            return 0
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v3, arg3), v0);
        let v4 = Withdraw<T0, T1>{
            signer : v0,
            amount : v2,
        };
        0x2::event::emit<Withdraw<T0, T1>>(v4);
        v2
    }

    fun withdraw_<T0>(arg0: &mut UserShareRegistry, arg1: &mut SubVault<T0>, arg2: 0x1::option::Option<u64>, arg3: address) : (u64, 0x2::balance::Balance<T0>) {
        let v0 = remove_share<T0>(arg0, arg1, arg3, arg2);
        if (v0 == 0) {
            return (0, 0x2::balance::zero<T0>())
        };
        (v0, 0x2::balance::split<T0>(&mut arg1.balance, (((0x2::balance::value<T0>(&arg1.balance) as u128) * (v0 as u128) / ((v0 + arg1.share_supply) as u128)) as u64)))
    }

    // decompiled from Move bytecode v6
}

