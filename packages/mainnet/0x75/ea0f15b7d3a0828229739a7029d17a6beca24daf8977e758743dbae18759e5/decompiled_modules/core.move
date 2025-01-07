module 0x75ea0f15b7d3a0828229739a7029d17a6beca24daf8977e758743dbae18759e5::core {
    struct Amount has store {
        value: u64,
    }

    struct Presale<phantom T0> has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        soft_cap: u64,
        hard_cap: u64,
        min_amount_per_user: u64,
        max_amount_per_user: u64,
        start_time: u64,
        end_time: u64,
        first_release_amount: u64,
        cycle_length: u64,
        last_cycle_timestamp: u64,
        cycle_release_amount: u64,
        owner: address,
        buyers: 0x2::vec_map::VecMap<address, Amount>,
        first_claim_done: bool,
        total_raised_amount: u64,
    }

    struct PresaleAdminCap has key {
        id: 0x2::object::UID,
    }

    struct Storage has key {
        id: 0x2::object::UID,
        sales: 0x2::object_bag::ObjectBag,
        fee_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        fee_amount: u64,
        treasury: address,
    }

    struct PresaleCreated<phantom T0> has copy, drop {
        owner: address,
        id: 0x2::object::ID,
        start_time: u64,
        hard_cap: u64,
    }

    struct FeeValueUpdated has copy, drop {
        new_value: u64,
    }

    struct TreasuryUpdated has copy, drop {
        new_treasury: address,
    }

    struct BuyPresale<phantom T0> has copy, drop {
        id: 0x2::object::ID,
        buyer: address,
        amount: u64,
    }

    struct NewAdmin has copy, drop {
        new_admin: address,
    }

    struct OwnerWithdraw<phantom T0> has copy, drop {
        id: 0x2::object::ID,
        owner: address,
        amount: u64,
    }

    struct WithdrawFee has copy, drop {
        treasury: address,
        amount: u64,
    }

    struct RedeemCoin<phantom T0> has copy, drop {
        id: 0x2::object::ID,
        user: address,
        amount: u64,
    }

    fun borrow_mut_buyer<T0>(arg0: &mut Presale<T0>, arg1: address) : &mut Amount {
        if (!0x2::vec_map::contains<address, Amount>(&arg0.buyers, &arg1)) {
            let v0 = Amount{value: 0};
            0x2::vec_map::insert<address, Amount>(&mut arg0.buyers, arg1, v0);
        };
        0x2::vec_map::get_mut<address, Amount>(&mut arg0.buyers, &arg1)
    }

    fun borrow_mut_presale<T0>(arg0: &mut Storage, arg1: address) : &mut Presale<T0> {
        0x2::object_bag::borrow_mut<address, Presale<T0>>(&mut arg0.sales, arg1)
    }

    public fun buy_presale<T0>(arg0: &mut Storage, arg1: &0x2::clock::Clock, arg2: address, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        let v1 = borrow_mut_presale<T0>(arg0, arg2);
        let v2 = v1.max_amount_per_user;
        assert!(v0 >= v1.start_time, 7);
        assert!(v1.end_time > v0, 8);
        let v3 = 0x2::tx_context::sender(arg4);
        let v4 = 0x2::coin::value<T0>(&arg3);
        assert!(v4 >= v1.min_amount_per_user, 11);
        let v5 = borrow_mut_buyer<T0>(v1, v3);
        v5.value = v5.value + v4;
        assert!(v2 >= v5.value, 10);
        v1.total_raised_amount = v1.total_raised_amount + v4;
        assert!(v1.hard_cap >= v1.total_raised_amount, 14);
        0x2::balance::join<T0>(&mut v1.balance, 0x2::coin::into_balance<T0>(arg3));
        let v6 = BuyPresale<T0>{
            id     : 0x2::object::uid_to_inner(&v1.id),
            buyer  : v3,
            amount : v4,
        };
        0x2::event::emit<BuyPresale<T0>>(v6);
    }

    public fun create_presale<T0>(arg0: &mut Storage, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= arg0.fee_amount, 1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.fee_balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
        assert!(arg7 >= 0x2::clock::timestamp_ms(arg1) + 3600000, 2);
        assert!(arg8 >= arg7 + 3600000, 3);
        assert!(arg3 * 2 >= arg4, 4);
        assert!(arg6 > arg5, 5);
        let v0 = 0x2::tx_context::sender(arg13);
        assert!(!0x2::object_bag::contains<address>(&arg0.sales, v0), 0);
        let v1 = 0x2::object::new(arg13);
        let v2 = PresaleCreated<T0>{
            owner      : v0,
            id         : 0x2::object::uid_to_inner(&v1),
            start_time : arg7,
            hard_cap   : arg4,
        };
        0x2::event::emit<PresaleCreated<T0>>(v2);
        let v3 = Presale<T0>{
            id                   : v1,
            balance              : 0x2::balance::zero<T0>(),
            soft_cap             : arg3,
            hard_cap             : arg4,
            min_amount_per_user  : arg5,
            max_amount_per_user  : arg6,
            start_time           : arg7,
            end_time             : arg8,
            first_release_amount : arg9,
            cycle_length         : arg10,
            last_cycle_timestamp : arg11,
            cycle_release_amount : arg12,
            owner                : v0,
            buyers               : 0x2::vec_map::empty<address, Amount>(),
            first_claim_done     : false,
            total_raised_amount  : 0,
        };
        0x2::object_bag::add<address, Presale<T0>>(&mut arg0.sales, v0, v3);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Storage{
            id          : 0x2::object::new(arg0),
            sales       : 0x2::object_bag::new(arg0),
            fee_balance : 0x2::balance::zero<0x2::sui::SUI>(),
            fee_amount  : 0,
            treasury    : @0x943172a130f572fb98444a7b496bc0dbc998e23ea1c484b0649f8eb2c4334649,
        };
        0x2::transfer::share_object<Storage>(v0);
        let v1 = PresaleAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<PresaleAdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun owner_withdraw<T0>(arg0: &mut Storage, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = borrow_mut_presale<T0>(arg0, v0);
        let v2 = 0x2::clock::timestamp_ms(arg1);
        let v3 = 0x2::balance::value<T0>(&v1.balance);
        assert!(v2 > v1.end_time, 12);
        assert!(v1.total_raised_amount >= v1.soft_cap, 13);
        if (!v1.first_claim_done) {
            v1.first_claim_done = true;
            v1.last_cycle_timestamp = v2;
            let v5 = OwnerWithdraw<T0>{
                id     : 0x2::object::uid_to_inner(&v1.id),
                owner  : v0,
                amount : v1.first_release_amount,
            };
            0x2::event::emit<OwnerWithdraw<T0>>(v5);
            0x2::coin::take<T0>(&mut v1.balance, v1.first_release_amount, arg2)
        } else {
            let v6 = v2 - v1.last_cycle_timestamp;
            if (v1.cycle_length > v6) {
                0x2::coin::zero<T0>(arg2)
            } else {
                let v7 = v1.cycle_release_amount * v6 / v1.cycle_length;
                let v8 = if (v7 > v3) {
                    v3
                } else {
                    v7
                };
                let v9 = OwnerWithdraw<T0>{
                    id     : 0x2::object::uid_to_inner(&v1.id),
                    owner  : v0,
                    amount : v8,
                };
                0x2::event::emit<OwnerWithdraw<T0>>(v9);
                0x2::coin::take<T0>(&mut v1.balance, v8, arg2)
            }
        }
    }

    public fun redeem_coins<T0>(arg0: &mut Storage, arg1: &0x2::clock::Clock, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = borrow_mut_presale<T0>(arg0, arg2);
        assert!(0x2::clock::timestamp_ms(arg1) > v0.end_time, 12);
        assert!(v0.total_raised_amount < v0.soft_cap, 15);
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = borrow_mut_buyer<T0>(v0, v1);
        let v3 = v2.value;
        assert!(v3 != 0, 16);
        v2.value = 0;
        let v4 = RedeemCoin<T0>{
            id     : 0x2::object::uid_to_inner(&v0.id),
            user   : v1,
            amount : v3,
        };
        0x2::event::emit<RedeemCoin<T0>>(v4);
        0x2::coin::take<T0>(&mut v0.balance, v3, arg3)
    }

    public entry fun transfer_admin(arg0: PresaleAdminCap, arg1: address) {
        assert!(arg1 != @0x0, 6);
        0x2::transfer::transfer<PresaleAdminCap>(arg0, arg1);
        let v0 = NewAdmin{new_admin: arg1};
        0x2::event::emit<NewAdmin>(v0);
    }

    public entry fun update_fee_value(arg0: &PresaleAdminCap, arg1: &mut Storage, arg2: u64) {
        arg1.fee_amount = arg2;
        let v0 = FeeValueUpdated{new_value: arg2};
        0x2::event::emit<FeeValueUpdated>(v0);
    }

    public entry fun update_treasury(arg0: &PresaleAdminCap, arg1: &mut Storage, arg2: address) {
        arg1.treasury = arg2;
        let v0 = TreasuryUpdated{new_treasury: arg2};
        0x2::event::emit<TreasuryUpdated>(v0);
    }

    entry fun withdraw_fee(arg0: &mut Storage, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.fee_balance);
        let v1 = arg0.treasury;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.fee_balance, v0, arg1), v1);
        let v2 = WithdrawFee{
            treasury : v1,
            amount   : v0,
        };
        0x2::event::emit<WithdrawFee>(v2);
    }

    // decompiled from Move bytecode v6
}

