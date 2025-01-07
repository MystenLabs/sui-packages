module 0x3846dc55562cb04f10580e8e02ae2b532247994abb472b4faf47842079fbf437::ido {
    struct ManageCapAbility<phantom T0> has store, key {
        id: 0x2::object::UID,
        sale_id: 0x2::object::ID,
    }

    struct PreSale<phantom T0> has store, key {
        id: 0x2::object::UID,
        only_whitelist: bool,
        raise: u64,
        start_time: u64,
        end_time: u64,
        min_amount: u64,
        max_amount: u64,
        balance: 0x2::coin::Coin<T0>,
        white_listed: 0x2::bag::Bag,
        members: 0x2::bag::Bag,
        refunded: 0x2::bag::Bag,
        allow_overfunding: bool,
        total_raise: u64,
    }

    struct CreateSaleEvent has copy, drop {
        address: address,
        sale_id: 0x2::object::ID,
    }

    struct ChangeEndTimeEvent has copy, drop {
        sale_id: 0x2::object::ID,
        end_time: u64,
    }

    struct ChangeStartTimeEvent has copy, drop {
        sale_id: 0x2::object::ID,
        start_time: u64,
    }

    struct ChangeFundAmountEvent has copy, drop {
        sale_id: 0x2::object::ID,
        min_amount: u64,
        max_amount: u64,
    }

    struct ChangeRaiseEvent has copy, drop {
        sale_id: 0x2::object::ID,
        raise: u64,
    }

    struct TransferFundsEvent has copy, drop {
        address: address,
        recipient: address,
        amount: u64,
    }

    struct SaleEvent has copy, drop {
        address: address,
        amount: u64,
    }

    struct CheckWhitelistedEvent has copy, drop {
        sale_id: 0x2::object::ID,
        is_whitelisted: bool,
    }

    struct CheckFundedEvent has copy, drop {
        sale_id: 0x2::object::ID,
        is_funded: bool,
        total_amount: u64,
        refund_amount: u64,
        refunded_amount: u64,
    }

    struct ReFundedEvent has copy, drop {
        sale_id: 0x2::object::ID,
        address: address,
        amount: u64,
    }

    struct ChangeAllowOverfundingEvent has copy, drop {
        sale_id: 0x2::object::ID,
        allow_overfunding: bool,
    }

    public entry fun add_white_list<T0>(arg0: &mut PreSale<T0>, arg1: &ManageCapAbility<T0>, arg2: vector<address>) {
        assert!(0x2::object::id<PreSale<T0>>(arg0) == arg1.sale_id, 1003);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg2)) {
            let v1 = 0x1::vector::pop_back<address>(&mut arg2);
            if (!is_whitelisted<T0>(arg0, v1)) {
                0x2::bag::add<address, bool>(&mut arg0.white_listed, v1, true);
            };
            v0 = v0 + 1;
        };
    }

    public entry fun change_allow_overfunding<T0>(arg0: &mut PreSale<T0>, arg1: &ManageCapAbility<T0>, arg2: bool) {
        assert!(0x2::object::id<PreSale<T0>>(arg0) == arg1.sale_id, 1003);
        arg0.allow_overfunding = arg2;
        let v0 = ChangeAllowOverfundingEvent{
            sale_id           : 0x2::object::id<PreSale<T0>>(arg0),
            allow_overfunding : arg2,
        };
        0x2::event::emit<ChangeAllowOverfundingEvent>(v0);
    }

    public entry fun change_end_time<T0>(arg0: &mut PreSale<T0>, arg1: &ManageCapAbility<T0>, arg2: u64) {
        assert!(0x2::object::id<PreSale<T0>>(arg0) == arg1.sale_id, 1003);
        assert!(arg2 > arg0.start_time, 1006);
        arg0.end_time = arg2;
        let v0 = ChangeEndTimeEvent{
            sale_id  : 0x2::object::id<PreSale<T0>>(arg0),
            end_time : arg2,
        };
        0x2::event::emit<ChangeEndTimeEvent>(v0);
    }

    public entry fun change_fund_amount<T0>(arg0: &mut PreSale<T0>, arg1: &ManageCapAbility<T0>, arg2: u64, arg3: u64) {
        assert!(0x2::object::id<PreSale<T0>>(arg0) == arg1.sale_id, 1003);
        arg0.min_amount = arg2;
        arg0.max_amount = arg3;
        let v0 = ChangeFundAmountEvent{
            sale_id    : 0x2::object::id<PreSale<T0>>(arg0),
            min_amount : arg2,
            max_amount : arg3,
        };
        0x2::event::emit<ChangeFundAmountEvent>(v0);
    }

    public entry fun change_raise<T0>(arg0: &mut PreSale<T0>, arg1: &ManageCapAbility<T0>, arg2: u64) {
        assert!(0x2::object::id<PreSale<T0>>(arg0) == arg1.sale_id, 1003);
        arg0.raise = arg2;
        let v0 = ChangeRaiseEvent{
            sale_id : 0x2::object::id<PreSale<T0>>(arg0),
            raise   : arg2,
        };
        0x2::event::emit<ChangeRaiseEvent>(v0);
    }

    public entry fun change_start_time<T0>(arg0: &mut PreSale<T0>, arg1: &ManageCapAbility<T0>, arg2: u64) {
        assert!(0x2::object::id<PreSale<T0>>(arg0) == arg1.sale_id, 1003);
        assert!(arg0.end_time > arg2, 1006);
        arg0.start_time = arg2;
        let v0 = ChangeStartTimeEvent{
            sale_id    : 0x2::object::id<PreSale<T0>>(arg0),
            start_time : arg2,
        };
        0x2::event::emit<ChangeStartTimeEvent>(v0);
    }

    public entry fun check_funded<T0>(arg0: &PreSale<T0>, arg1: address) {
        let v0 = 0;
        let v1 = 0;
        let v2 = 0;
        let v3 = 0x2::bag::contains<address>(&arg0.members, arg1);
        if (v3) {
            let v4 = *0x2::bag::borrow<address, u64>(&arg0.members, arg1);
            v0 = v4;
            if (arg0.total_raise > arg0.raise) {
                let v5 = mul_div_floor(v4, arg0.total_raise - arg0.raise, arg0.total_raise);
                v1 = v5;
                if (v5 > 0 && 0x2::bag::contains<address>(&arg0.refunded, arg1)) {
                    v2 = *0x2::bag::borrow<address, u64>(&arg0.refunded, arg1);
                };
            };
        };
        let v6 = CheckFundedEvent{
            sale_id         : 0x2::object::id<PreSale<T0>>(arg0),
            is_funded       : v3,
            total_amount    : v0,
            refund_amount   : v1,
            refunded_amount : v2,
        };
        0x2::event::emit<CheckFundedEvent>(v6);
    }

    public entry fun check_whitelisted<T0>(arg0: &PreSale<T0>, arg1: address) {
        let v0 = CheckWhitelistedEvent{
            sale_id        : 0x2::object::id<PreSale<T0>>(arg0),
            is_whitelisted : 0x2::bag::contains<address>(&arg0.white_listed, arg1),
        };
        0x2::event::emit<CheckWhitelistedEvent>(v0);
    }

    public entry fun claim_refund<T0>(arg0: &mut PreSale<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.total_raise > arg0.raise, 1007);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::clock::timestamp_ms(arg1) / 1000 > arg0.end_time, 1001);
        let v1 = mul_div_floor(*0x2::bag::borrow<address, u64>(&arg0.members, v0), arg0.total_raise - arg0.raise, arg0.total_raise);
        assert!(v1 > 0, 1007);
        assert!(!0x2::bag::contains<address>(&arg0.refunded, v0), 1008);
        0x2::bag::add<address, u64>(&mut arg0.refunded, v0, v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg0.balance, v1, arg2), v0);
        let v2 = ReFundedEvent{
            sale_id : 0x2::object::id<PreSale<T0>>(arg0),
            address : v0,
            amount  : v1,
        };
        0x2::event::emit<ReFundedEvent>(v2);
    }

    public entry fun create_presale<T0>(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: bool, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > arg0, 1006);
        let v0 = PreSale<T0>{
            id                : 0x2::object::new(arg6),
            only_whitelist    : false,
            raise             : arg2,
            start_time        : arg0,
            end_time          : arg1,
            min_amount        : arg3,
            max_amount        : arg4,
            balance           : 0x2::coin::zero<T0>(arg6),
            white_listed      : 0x2::bag::new(arg6),
            members           : 0x2::bag::new(arg6),
            refunded          : 0x2::bag::new(arg6),
            allow_overfunding : arg5,
            total_raise       : 0,
        };
        let v1 = 0x2::object::id<PreSale<T0>>(&v0);
        let v2 = CreateSaleEvent{
            address : 0x2::tx_context::sender(arg6),
            sale_id : v1,
        };
        0x2::event::emit<CreateSaleEvent>(v2);
        let v3 = ManageCapAbility<T0>{
            id      : 0x2::object::new(arg6),
            sale_id : v1,
        };
        0x2::transfer::public_transfer<ManageCapAbility<T0>>(v3, 0x2::tx_context::sender(arg6));
        0x2::transfer::public_share_object<PreSale<T0>>(v0);
    }

    public entry fun delete_white_list<T0>(arg0: &mut PreSale<T0>, arg1: &ManageCapAbility<T0>, arg2: vector<address>) {
        assert!(0x2::object::id<PreSale<T0>>(arg0) == arg1.sale_id, 1003);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg2)) {
            let v1 = 0x1::vector::pop_back<address>(&mut arg2);
            if (is_whitelisted<T0>(arg0, v1)) {
                0x2::bag::remove<address, bool>(&mut arg0.white_listed, v1);
            };
            v0 = v0 + 1;
        };
    }

    public fun full_mul(arg0: u64, arg1: u64) : u128 {
        (arg0 as u128) * (arg1 as u128)
    }

    public entry fun fund<T0>(arg0: &mut PreSale<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        if (arg0.only_whitelist) {
            assert!(is_whitelisted<T0>(arg0, v0), 1000);
        };
        let v1 = 0x2::clock::timestamp_ms(arg2) / 1000;
        assert!(v1 >= arg0.start_time && v1 <= arg0.end_time, 1001);
        let v2 = 0x2::coin::value<T0>(&arg1);
        if (!arg0.allow_overfunding) {
            assert!(0x2::coin::value<T0>(&arg0.balance) + v2 <= arg0.raise, 1002);
        };
        assert!(v2 <= arg0.max_amount, 1004);
        assert!(v2 >= arg0.min_amount, 1005);
        0x2::coin::join<T0>(&mut arg0.balance, arg1);
        arg0.total_raise = arg0.total_raise + v2;
        let v3 = SaleEvent{
            address : v0,
            amount  : v2,
        };
        0x2::event::emit<SaleEvent>(v3);
        if (0x2::bag::contains<address>(&arg0.members, v0)) {
            let v4 = 0x2::bag::borrow_mut<address, u64>(&mut arg0.members, v0);
            assert!(*v4 + v2 <= arg0.max_amount, 1004);
            *v4 = *v4 + v2;
        } else {
            0x2::bag::add<address, u64>(&mut arg0.members, v0, v2);
        };
    }

    fun is_whitelisted<T0>(arg0: &PreSale<T0>, arg1: address) : bool {
        0x2::bag::contains<address>(&arg0.white_listed, arg1)
    }

    public fun mul_div_floor(arg0: u64, arg1: u64, arg2: u64) : u64 {
        ((full_mul(arg0, arg1) / (arg2 as u128)) as u64)
    }

    public entry fun set_pub_or_wihte_listed_only<T0>(arg0: &mut PreSale<T0>, arg1: &ManageCapAbility<T0>) {
        assert!(0x2::object::id<PreSale<T0>>(arg0) == arg1.sale_id, 1003);
        arg0.only_whitelist = !arg0.only_whitelist;
    }

    public entry fun transfer_funds<T0>(arg0: &mut PreSale<T0>, arg1: &ManageCapAbility<T0>, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg3) / 1000 > arg0.end_time, 1001);
        assert!(0x2::object::id<PreSale<T0>>(arg0) == arg1.sale_id, 1003);
        let v0 = 0x2::coin::value<T0>(&arg0.balance);
        let v1 = TransferFundsEvent{
            address   : 0x2::tx_context::sender(arg4),
            recipient : arg2,
            amount    : v0,
        };
        0x2::event::emit<TransferFundsEvent>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg0.balance, v0, arg4), arg2);
    }

    public entry fun transfer_funds_to_self<T0>(arg0: &mut PreSale<T0>, arg1: &ManageCapAbility<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::id<PreSale<T0>>(arg0) == arg1.sale_id, 1003);
        let v0 = 0x2::tx_context::sender(arg3);
        transfer_funds<T0>(arg0, arg1, v0, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

