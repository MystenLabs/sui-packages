module 0xaf3d85e9c64eea7b2d482c57b2ff5889e5570d593eb7d01d933ad43e69ed6a3e::ido {
    struct ManageCapAbility<phantom T0> has store, key {
        id: 0x2::object::UID,
        sale_id: 0x2::object::ID,
    }

    struct PreSale<phantom T0> has store, key {
        id: 0x2::object::UID,
        status: u8,
        only_whitelist: bool,
        raise: u64,
        start_time: u64,
        end_time: u64,
        min_amount: u64,
        max_amount: u64,
        balance: 0x2::coin::Coin<T0>,
        white_listed: 0x2::bag::Bag,
        members: 0x2::bag::Bag,
    }

    struct SaleEvent has copy, drop {
        address: address,
        amount: u64,
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

    public entry fun change_fund_amount<T0>(arg0: &mut PreSale<T0>, arg1: &ManageCapAbility<T0>, arg2: u64, arg3: u64) {
        assert!(0x2::object::id<PreSale<T0>>(arg0) == arg1.sale_id, 1003);
        arg0.min_amount = arg2;
        arg0.max_amount = arg3;
    }

    public entry fun change_raise<T0>(arg0: &mut PreSale<T0>, arg1: &ManageCapAbility<T0>, arg2: u64) {
        assert!(0x2::object::id<PreSale<T0>>(arg0) == arg1.sale_id, 1003);
        arg0.raise = arg2;
    }

    public entry fun change_time<T0>(arg0: &mut PreSale<T0>, arg1: &ManageCapAbility<T0>, arg2: u64, arg3: u64) {
        assert!(0x2::object::id<PreSale<T0>>(arg0) == arg1.sale_id, 1003);
        arg0.start_time = arg2;
        arg0.end_time = arg3;
    }

    public entry fun create_presale<T0>(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = PreSale<T0>{
            id             : 0x2::object::new(arg5),
            status         : 0,
            only_whitelist : false,
            raise          : arg2,
            start_time     : arg0,
            end_time       : arg1,
            min_amount     : arg3,
            max_amount     : arg4,
            balance        : 0x2::coin::zero<T0>(arg5),
            white_listed   : 0x2::bag::new(arg5),
            members        : 0x2::bag::new(arg5),
        };
        let v1 = ManageCapAbility<T0>{
            id      : 0x2::object::new(arg5),
            sale_id : 0x2::object::id<PreSale<T0>>(&v0),
        };
        0x2::transfer::public_transfer<ManageCapAbility<T0>>(v1, 0x2::tx_context::sender(arg5));
        0x2::transfer::public_share_object<PreSale<T0>>(v0);
    }

    public entry fun fund<T0>(arg0: &mut PreSale<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        if (arg0.only_whitelist) {
            assert!(is_whitelisted<T0>(arg0, v0), 1000);
        };
        let v1 = 0x2::clock::timestamp_ms(arg2);
        assert!(v1 >= arg0.start_time && v1 <= arg0.end_time, 1001);
        let v2 = 0x2::coin::value<T0>(&arg1);
        assert!(0x2::coin::value<T0>(&arg0.balance) + v2 <= arg0.raise, 1002);
        assert!(v2 <= arg0.max_amount, 1004);
        assert!(v2 >= arg0.min_amount, 1004);
        0x2::coin::join<T0>(&mut arg0.balance, arg1);
        let v3 = SaleEvent{
            address : v0,
            amount  : v2,
        };
        0x2::event::emit<SaleEvent>(v3);
        if (0x2::bag::contains<address>(&mut arg0.members, v0)) {
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

    public entry fun set_pub_or_wihte_listed_only<T0>(arg0: &mut PreSale<T0>, arg1: &ManageCapAbility<T0>) {
        assert!(0x2::object::id<PreSale<T0>>(arg0) == arg1.sale_id, 1003);
        arg0.only_whitelist = !arg0.only_whitelist;
    }

    public entry fun transfer_funds<T0>(arg0: &mut PreSale<T0>, arg1: &ManageCapAbility<T0>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::id<PreSale<T0>>(arg0) == arg1.sale_id, 1003);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg0.balance, 0x2::coin::value<T0>(&arg0.balance), arg3), arg2);
    }

    public entry fun transfer_funds_to_self<T0>(arg0: &mut PreSale<T0>, arg1: &ManageCapAbility<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::id<PreSale<T0>>(arg0) == arg1.sale_id, 1003);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg0.balance, 0x2::coin::value<T0>(&arg0.balance), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

