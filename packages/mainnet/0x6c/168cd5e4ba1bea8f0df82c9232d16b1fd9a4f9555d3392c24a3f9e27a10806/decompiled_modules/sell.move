module 0x6c168cd5e4ba1bea8f0df82c9232d16b1fd9a4f9555d3392c24a3f9e27a10806::sell {
    struct ManageCapAbility<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        ido_id: 0x2::object::ID,
    }

    struct Ido<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        raise: u64,
        start_time: u64,
        end_time: u64,
        min_amount: u64,
        max_amount: u64,
        selling_price: u64,
        funds: 0x2::coin::Coin<T1>,
        balance: 0x2::coin::Coin<T0>,
        members: 0x2::bag::Bag,
    }

    struct SaleEvent has copy, drop {
        address: address,
        amount: u64,
        give: u64,
    }

    public entry fun change_end_time<T0, T1>(arg0: &mut Ido<T0, T1>, arg1: &ManageCapAbility<T0, T1>, arg2: u64) {
        assert!(0x2::object::id<Ido<T0, T1>>(arg0) == arg1.ido_id, 1003);
        arg0.end_time = arg2;
    }

    public entry fun change_fund_amount<T0, T1>(arg0: &mut Ido<T0, T1>, arg1: &ManageCapAbility<T0, T1>, arg2: u64, arg3: u64) {
        assert!(0x2::object::id<Ido<T0, T1>>(arg0) == arg1.ido_id, 1003);
        arg0.min_amount = arg2;
        arg0.max_amount = arg3;
    }

    public entry fun change_raise<T0, T1>(arg0: &mut Ido<T0, T1>, arg1: &ManageCapAbility<T0, T1>, arg2: u64) {
        assert!(0x2::object::id<Ido<T0, T1>>(arg0) == arg1.ido_id, 1003);
        arg0.raise = arg2;
    }

    public entry fun change_start_time<T0, T1>(arg0: &mut Ido<T0, T1>, arg1: &ManageCapAbility<T0, T1>, arg2: u64) {
        assert!(0x2::object::id<Ido<T0, T1>>(arg0) == arg1.ido_id, 1003);
        arg0.start_time = arg2;
    }

    public entry fun create_presale<T0, T1>(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = Ido<T0, T1>{
            id            : 0x2::object::new(arg6),
            raise         : arg2,
            start_time    : arg0,
            end_time      : arg1,
            min_amount    : arg3,
            max_amount    : arg4,
            selling_price : arg5,
            funds         : 0x2::coin::zero<T1>(arg6),
            balance       : 0x2::coin::zero<T0>(arg6),
            members       : 0x2::bag::new(arg6),
        };
        let v1 = ManageCapAbility<T0, T1>{
            id     : 0x2::object::new(arg6),
            ido_id : 0x2::object::id<Ido<T0, T1>>(&v0),
        };
        0x2::transfer::public_transfer<ManageCapAbility<T0, T1>>(v1, 0x2::tx_context::sender(arg6));
        0x2::transfer::public_share_object<Ido<T0, T1>>(v0);
    }

    public entry fun deposit_balance<T0, T1>(arg0: &mut Ido<T0, T1>, arg1: &ManageCapAbility<T0, T1>, arg2: 0x2::coin::Coin<T0>) {
        assert!(0x2::object::id<Ido<T0, T1>>(arg0) == arg1.ido_id, 1003);
        0x2::coin::join<T0>(&mut arg0.balance, arg2);
    }

    public entry fun fund<T0, T1>(arg0: &mut Ido<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        assert!(v1 >= arg0.start_time && v1 <= arg0.end_time, 1001);
        let v2 = 0x2::coin::value<T1>(&arg1);
        assert!(0x2::coin::value<T1>(&arg0.funds) + v2 <= arg0.raise, 1002);
        assert!(v2 <= arg0.max_amount, 1004);
        assert!(v2 >= arg0.min_amount, 1005);
        0x2::coin::join<T1>(&mut arg0.funds, arg1);
        let v3 = (((v2 as u256) * (arg0.selling_price as u256) / (1000000000 as u256)) as u64);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg0.balance, v3, arg3), 0x2::tx_context::sender(arg3));
        let v4 = SaleEvent{
            address : v0,
            amount  : v2,
            give    : v3,
        };
        0x2::event::emit<SaleEvent>(v4);
        if (0x2::bag::contains<address>(&mut arg0.members, v0)) {
            let v5 = 0x2::bag::borrow_mut<address, u64>(&mut arg0.members, v0);
            assert!(*v5 + v2 <= arg0.max_amount, 1004);
            *v5 = *v5 + v2;
        } else {
            0x2::bag::add<address, u64>(&mut arg0.members, v0, v2);
        };
    }

    public entry fun transfer_funds<T0, T1>(arg0: &mut Ido<T0, T1>, arg1: &ManageCapAbility<T0, T1>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::id<Ido<T0, T1>>(arg0) == arg1.ido_id, 1003);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(&mut arg0.funds, 0x2::coin::value<T1>(&arg0.funds), arg3), arg2);
    }

    public entry fun transfer_funds_to_self<T0, T1>(arg0: &mut Ido<T0, T1>, arg1: &ManageCapAbility<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::id<Ido<T0, T1>>(arg0) == arg1.ido_id, 1003);
        let v0 = 0x2::tx_context::sender(arg2);
        transfer_funds<T0, T1>(arg0, arg1, v0, arg2);
    }

    public entry fun withdraw_balance<T0, T1>(arg0: &mut Ido<T0, T1>, arg1: &ManageCapAbility<T0, T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::id<Ido<T0, T1>>(arg0) == arg1.ido_id, 1003);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg0.balance, arg2, arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

