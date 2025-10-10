module 0x6c4d275d6200298d168e2fa174e1f5548eb47c64e709d19935ce5f9cf8e52ee1::pogi_presale {
    struct PresaleTreasury<phantom T0> has key {
        id: 0x2::object::UID,
        pogi_balance: 0x2::balance::Balance<T0>,
        payment_receiver: address,
        admin: address,
        is_active: bool,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    public fun buy_pogi<T0>(arg0: &mut PresaleTreasury<T0>, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg0.is_active, 3);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 > 0, 0);
        let v1 = v0 * 100;
        assert!(0x2::balance::value<T0>(&arg0.pogi_balance) >= v1, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, arg0.payment_receiver);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.pogi_balance, v1), arg2)
    }

    entry fun buy_pogi_and_transfer<T0>(arg0: &mut PresaleTreasury<T0>, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = buy_pogi<T0>(arg0, arg1, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg2));
    }

    public fun get_payment_receiver<T0>(arg0: &PresaleTreasury<T0>) : address {
        arg0.payment_receiver
    }

    public fun get_pogi_balance<T0>(arg0: &PresaleTreasury<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.pogi_balance)
    }

    public fun initialize<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = PresaleTreasury<T0>{
            id               : 0x2::object::new(arg2),
            pogi_balance     : 0x2::coin::into_balance<T0>(arg0),
            payment_receiver : arg1,
            admin            : v0,
            is_active        : true,
        };
        let v2 = AdminCap{id: 0x2::object::new(arg2)};
        0x2::transfer::share_object<PresaleTreasury<T0>>(v1);
        0x2::transfer::transfer<AdminCap>(v2, v0);
    }

    public fun is_active<T0>(arg0: &PresaleTreasury<T0>) : bool {
        arg0.is_active
    }

    public fun toggle_presale<T0>(arg0: &AdminCap, arg1: &mut PresaleTreasury<T0>, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg1.admin, 2);
        arg1.is_active = !arg1.is_active;
    }

    public fun update_payment_receiver<T0>(arg0: &AdminCap, arg1: &mut PresaleTreasury<T0>, arg2: address, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg1.admin, 2);
        arg1.payment_receiver = arg2;
    }

    public fun withdraw_pogi<T0>(arg0: &AdminCap, arg1: &mut PresaleTreasury<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::tx_context::sender(arg3) == arg1.admin, 2);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.pogi_balance, arg2), arg3)
    }

    entry fun withdraw_pogi_and_transfer<T0>(arg0: &AdminCap, arg1: &mut PresaleTreasury<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = withdraw_pogi<T0>(arg0, arg1, arg2, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, arg1.admin);
    }

    // decompiled from Move bytecode v6
}

