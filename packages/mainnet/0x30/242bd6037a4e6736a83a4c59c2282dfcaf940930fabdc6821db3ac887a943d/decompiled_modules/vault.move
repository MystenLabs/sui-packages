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
        abort 999
    }

    public fun activate_share<T0, T1>(arg0: &T0, arg1: &mut UserShareRegistry, arg2: &mut DepositVault<T0, T1>, arg3: u64) : (u64, bool) {
        abort 999
    }

    public fun activate_vault<T0, T1>(arg0: &T0, arg1: &mut DepositVault<T0, T1>, arg2: u64, arg3: bool, arg4: &0x2::tx_context::TxContext) {
        abort 999
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
        abort 999
    }

    public fun close<T0, T1>(arg0: &T0, arg1: &mut DepositVault<T0, T1>) {
        abort 999
    }

    public fun close_bid_vault<T0, T1>(arg0: &T0, arg1: &mut UserShareRegistry, arg2: BidVault<T0, T1>, arg3: &mut 0x2::tx_context::TxContext) : (0x2::vec_map::VecMap<address, u64>, 0x2::vec_map::VecMap<address, u64>, 0x2::vec_map::VecMap<address, u64>) {
        abort 999
    }

    public fun close_deposit_vault<T0, T1>(arg0: &T0, arg1: &mut UserShareRegistry, arg2: DepositVault<T0, T1>, arg3: &mut 0x2::tx_context::TxContext) : (0x2::vec_map::VecMap<address, u64>, 0x2::vec_map::VecMap<address, u64>, 0x2::vec_map::VecMap<address, u64>, 0x2::vec_map::VecMap<address, u64>) {
        abort 999
    }

    public fun compound<T0, T1>(arg0: &mut UserShareRegistry, arg1: &mut UserShareRegistry, arg2: &mut DepositVault<T0, T1>, arg3: &mut BidVault<T0, T1>, arg4: u64, arg5: &0x2::tx_context::TxContext) : u64 {
        abort 999
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
        abort 999
    }

    public fun delivery_active<T0, T1, T2>(arg0: &T0, arg1: &mut UserShareRegistry, arg2: &mut UserShareRegistry, arg3: &mut DepositVault<T0, T1>, arg4: &mut BidVault<T0, T2>, arg5: u64, arg6: u64, arg7: u64, arg8: 0x1::option::Option<UserShareKey>, arg9: u64) : (u64, u64, u64, 0x1::option::Option<UserShareKey>) {
        abort 999
    }

    public fun delivery_bidder<T0, T1>(arg0: &T0, arg1: &mut UserShareRegistry, arg2: &mut BidVault<T0, T1>, arg3: 0x2::vec_map::VecMap<address, u64>, arg4: u64) : 0x2::vec_map::VecMap<address, u64> {
        abort 999
    }

    public fun delivery_deactivating<T0, T1, T2>(arg0: &T0, arg1: &mut UserShareRegistry, arg2: &mut UserShareRegistry, arg3: &mut DepositVault<T0, T1>, arg4: &mut BidVault<T0, T2>, arg5: u64, arg6: u64, arg7: u64, arg8: 0x1::option::Option<UserShareKey>, arg9: u64) : (u64, u64, u64, 0x1::option::Option<UserShareKey>) {
        abort 999
    }

    public fun delivery_multiple<T0, T1, T2, T3>(arg0: &T0, arg1: &mut UserShareRegistry, arg2: &mut UserShareRegistry, arg3: &mut UserShareRegistry, arg4: &mut DepositVault<T0, T1>, arg5: &mut DepositVault<T0, T2>, arg6: &mut BidVault<T0, T3>, arg7: u64, arg8: u64, arg9: 0x2::balance::Balance<T3>, arg10: 0x2::vec_map::VecMap<address, u64>, arg11: &0x2::tx_context::TxContext) {
        abort 999
    }

    public fun delivery_premium<T0, T1>(arg0: &T0, arg1: &mut BidVault<T0, T1>, arg2: 0x2::balance::Balance<T1>) : (u64, u64) {
        abort 999
    }

    public fun delivery_reward<T0, T1>(arg0: &T0, arg1: &mut BidVault<T0, T1>, arg2: 0x2::balance::Balance<T1>) : u64 {
        abort 999
    }

    public fun delivery_with_rewards<T0, T1, T2>(arg0: &T0, arg1: &mut UserShareRegistry, arg2: &mut UserShareRegistry, arg3: &mut DepositVault<T0, T1>, arg4: &mut BidVault<T0, T2>, arg5: u64, arg6: 0x2::balance::Balance<T2>, arg7: 0x2::vec_map::VecMap<address, u64>, arg8: 0x2::balance::Balance<T2>, arg9: &0x2::tx_context::TxContext) {
        abort 999
    }

    public fun deposit<T0, T1>(arg0: &mut UserShareRegistry, arg1: &mut DepositVault<T0, T1>, arg2: vector<0x2::coin::Coin<T1>>, arg3: u64, arg4: u64, arg5: &0x2::tx_context::TxContext) : u64 {
        abort 999
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
        abort 999
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
        abort 999
    }

    public fun has_next<T0, T1>(arg0: &DepositVault<T0, T1>) : bool {
        arg0.has_next
    }

    public fun hotfix_bid_vault<T0, T1>(arg0: &mut UserShareRegistry, arg1: &mut BidVault<T0, T1>, arg2: 0x1::option::Option<UserShareKey>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<UserShareKey> {
        abort 999
    }

    public fun hotfix_bid_vault_v2<T0, T1>(arg0: &mut UserShareRegistry, arg1: &mut BidVault<T0, T1>, arg2: u64, arg3: u64, arg4: 0x1::option::Option<UserShareKey>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : (0x1::option::Option<UserShareKey>, u64, u64) {
        abort 999
    }

    public fun hotfix_deposit_vault<T0, T1>(arg0: &mut UserShareRegistry, arg1: &mut DepositVault<T0, T1>, arg2: u64, arg3: u64, arg4: u64, arg5: 0x1::option::Option<UserShareKey>, arg6: u64) : (0x1::option::Option<UserShareKey>, u64, u64, u64) {
        abort 999
    }

    public fun hotfix_deposit_vault_balance<T0, T1>(arg0: &mut DepositVault<T0, T1>, arg1: 0x2::balance::Balance<T1>) {
        abort 999
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
        abort 999
    }

    public fun new_deposit_vault<T0, T1>(arg0: u64, arg1: &UserShareRegistry, arg2: &mut 0x2::tx_context::TxContext) : DepositVault<T0, T1> {
        abort 999
    }

    public fun new_user_share_key(arg0: u64, arg1: u8, arg2: address) : UserShareKey {
        abort 999
    }

    public fun new_user_share_registry(arg0: &mut 0x2::tx_context::TxContext) : UserShareRegistry {
        abort 999
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
        abort 999
    }

    public fun prepare_bid_vault_user_share_node(arg0: &mut UserShareRegistry, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        abort 999
    }

    public fun prepare_deposit_vault_user_share_node(arg0: &mut UserShareRegistry, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        abort 999
    }

    public fun rebalance_multiple<T0, T1, T2>(arg0: &T0, arg1: &mut UserShareRegistry, arg2: &mut UserShareRegistry, arg3: &mut DepositVault<T0, T1>, arg4: &mut DepositVault<T0, T2>, arg5: u64, arg6: u64, arg7: &0x2::tx_context::TxContext) {
        abort 999
    }

    public fun redeem<T0, T1, T2>(arg0: &mut UserShareRegistry, arg1: &mut DepositVault<T0, T1>, arg2: &mut UserShareRegistry, arg3: &mut BidVault<T0, T2>, arg4: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, 0x2::balance::Balance<T2>, vector<u64>) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = vector[];
        let v2 = 0x2::balance::zero<T1>();
        let v3 = 0x2::balance::zero<T2>();
        let v4 = &mut arg1.warmup_sub_vault;
        let (_, v6) = withdraw_<T1>(arg0, v4, 0x1::option::none<u64>(), v0);
        let v7 = v6;
        0x1::vector::push_back<u64>(&mut v1, 0x2::balance::value<T1>(&v7));
        0x2::balance::join<T1>(&mut v2, v7);
        let v8 = &mut arg1.inactive_sub_vault;
        let (_, v10) = withdraw_<T1>(arg0, v8, 0x1::option::none<u64>(), v0);
        let v11 = v10;
        0x1::vector::push_back<u64>(&mut v1, 0x2::balance::value<T1>(&v11));
        0x2::balance::join<T1>(&mut v2, v11);
        let v12 = &mut arg3.premium_sub_vault;
        let (_, v14) = withdraw_<T2>(arg2, v12, 0x1::option::none<u64>(), v0);
        let v15 = v14;
        0x1::vector::push_back<u64>(&mut v1, 0x2::balance::value<T2>(&v15));
        0x2::balance::join<T2>(&mut v3, v15);
        (v2, v3, v1)
    }

    public fun refund<T0, T1>(arg0: &T0, arg1: &mut UserShareRegistry, arg2: &mut DepositVault<T0, T1>, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        abort 999
    }

    public fun refund_active<T0, T1>(arg0: &T0, arg1: &mut UserShareRegistry, arg2: &mut DepositVault<T0, T1>, arg3: u64, arg4: u64, arg5: 0x1::option::Option<UserShareKey>, arg6: u64) : 0x1::option::Option<UserShareKey> {
        abort 999
    }

    public fun refund_deactivating<T0, T1>(arg0: &T0, arg1: &mut UserShareRegistry, arg2: &mut DepositVault<T0, T1>, arg3: u64, arg4: u64, arg5: 0x1::option::Option<UserShareKey>, arg6: u64) : 0x1::option::Option<UserShareKey> {
        abort 999
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

    public fun settle_adjust_active_user_share_ratio<T0, T1>(arg0: &T0, arg1: &mut UserShareRegistry, arg2: &mut DepositVault<T0, T1>, arg3: 0x1::option::Option<UserShareKey>, arg4: u64) : 0x1::option::Option<UserShareKey> {
        abort 999
    }

    public fun settle_adjust_active_user_share_ratio_v2<T0, T1>(arg0: &T0, arg1: &mut UserShareRegistry, arg2: &mut DepositVault<T0, T1>, arg3: u64, arg4: u64, arg5: 0x1::option::Option<UserShareKey>, arg6: u64) : (0x1::option::Option<UserShareKey>, u64, u64) {
        abort 999
    }

    public fun settle_adjust_deactivating_user_share_ratio<T0, T1>(arg0: &T0, arg1: &mut UserShareRegistry, arg2: &mut DepositVault<T0, T1>, arg3: 0x1::option::Option<UserShareKey>, arg4: u64) : 0x1::option::Option<UserShareKey> {
        abort 999
    }

    public fun settle_adjust_deactivating_user_share_ratio_v2<T0, T1>(arg0: &T0, arg1: &mut UserShareRegistry, arg2: &mut DepositVault<T0, T1>, arg3: u64, arg4: u64, arg5: 0x1::option::Option<UserShareKey>, arg6: u64) : (0x1::option::Option<UserShareKey>, u64, u64) {
        abort 999
    }

    public fun settle_bidder_balance<T0, T1, T2, T3>(arg0: &T0, arg1: &UserShareRegistry, arg2: &mut DepositVault<T0, T1>, arg3: &mut BidVault<T0, T2>, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: 0x1::option::Option<UserShareKey>, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<UserShareKey> {
        abort 999
    }

    public fun settle_bidder_balance_with_rewards<T0, T1, T2, T3>(arg0: &T0, arg1: &UserShareRegistry, arg2: &mut DepositVault<T0, T1>, arg3: &mut BidVault<T0, T2>, arg4: &mut 0x2::balance::Balance<T1>, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: 0x1::option::Option<UserShareKey>, arg11: u64, arg12: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<UserShareKey> {
        abort 999
    }

    public fun settle_fund<T0, T1, T2, T3>(arg0: &T0, arg1: &mut UserShareRegistry, arg2: &mut UserShareRegistry, arg3: &mut DepositVault<T0, T1>, arg4: &mut BidVault<T0, T2>, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) : u64 {
        abort 999
    }

    public fun settle_fund_multiple<T0, T1, T2, T3>(arg0: &T0, arg1: &mut UserShareRegistry, arg2: &mut UserShareRegistry, arg3: &mut UserShareRegistry, arg4: &mut DepositVault<T0, T1>, arg5: &mut DepositVault<T0, T2>, arg6: &mut BidVault<T0, T3>, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: &mut 0x2::tx_context::TxContext) : (0xd60bbb359c55e2c60c2360defa75a5e8446c36cc794ac55bb14cf339f5a62bf5::i64::I64, u64) {
        abort 999
    }

    public fun settle_fund_with_rewards<T0, T1, T2, T3>(arg0: &T0, arg1: &mut UserShareRegistry, arg2: &mut UserShareRegistry, arg3: &mut DepositVault<T0, T1>, arg4: &mut BidVault<T0, T2>, arg5: &mut 0x2::balance::Balance<T1>, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: &mut 0x2::tx_context::TxContext) : u64 {
        abort 999
    }

    public fun settle_performance_fee_balance<T0, T1, T2, T3>(arg0: &T0, arg1: &mut DepositVault<T0, T1>, arg2: &mut BidVault<T0, T2>, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) : (u64, u64, u64, u64) {
        abort 999
    }

    public fun settle_performance_fee_balance_with_rewards<T0, T1, T2, T3>(arg0: &T0, arg1: &mut DepositVault<T0, T1>, arg2: &mut BidVault<T0, T2>, arg3: &mut 0x2::balance::Balance<T1>, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) : (u64, u64, u64, u64) {
        abort 999
    }

    public fun settle_remained_performance_fee_combination<T0, T1>(arg0: &T0, arg1: &mut UserShareRegistry, arg2: &mut BidVault<T0, T1>, arg3: u64) {
        abort 999
    }

    public fun settle_reset_bidder_user_share<T0, T1>(arg0: &T0, arg1: &mut UserShareRegistry, arg2: &mut BidVault<T0, T1>, arg3: u64) {
        abort 999
    }

    public fun settle_rock_n_roll_active<T0, T1>(arg0: &T0, arg1: &mut UserShareRegistry, arg2: &mut DepositVault<T0, T1>, arg3: u64) {
        abort 999
    }

    public fun settle_rock_n_roll_deactivating<T0, T1>(arg0: &T0, arg1: &mut UserShareRegistry, arg2: &mut DepositVault<T0, T1>, arg3: u64) {
        abort 999
    }

    public fun unsubscribe<T0, T1>(arg0: &mut UserShareRegistry, arg1: &mut DepositVault<T0, T1>, arg2: 0x1::option::Option<u64>, arg3: &0x2::tx_context::TxContext) : u64 {
        abort 999
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
        abort 999
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

