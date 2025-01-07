module 0xe409ad6279de5b613e71737f03e3abfc56143334e383676f404bee0d621f697::presale {
    struct PreSaleAdminCap has key {
        id: 0x2::object::UID,
    }

    struct PresaleStorage has key {
        id: 0x2::object::UID,
        balanceSUI: 0x2::balance::Balance<0x2::sui::SUI>,
        balanceToken: 0x2::balance::Balance<0x917c6a34b71bd375e44227bed71d84fc1a72c20cb410399c9efa4f52a7f5e32c::seatoken::SEATOKEN>,
        maxToken: u64,
        hardCap: u64,
        startTime: u64,
        endTime: u64,
        minBuy: u64,
        startClaim: u8,
        totalRaised: u64,
        balances: 0x2::table::Table<address, u64>,
        refunded: 0x2::table::Table<address, bool>,
        owner: address,
    }

    public entry fun caculator_claim(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : (u64, u64) {
        if (arg2 >= arg0) {
            (arg1 * arg3, 0)
        } else {
            let v2 = arg2 * arg1 * 100 / arg0 / 100;
            (v2 * arg3, arg1 - v2)
        }
    }

    public entry fun emergency_withdrawal_token(arg0: &PreSaleAdminCap, arg1: &mut PresaleStorage, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(is_owner(arg1, 0x2::tx_context::sender(arg2)) == true, 7);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x917c6a34b71bd375e44227bed71d84fc1a72c20cb410399c9efa4f52a7f5e32c::seatoken::SEATOKEN>>(0x2::coin::take<0x917c6a34b71bd375e44227bed71d84fc1a72c20cb410399c9efa4f52a7f5e32c::seatoken::SEATOKEN>(&mut arg1.balanceToken, 0x2::balance::value<0x917c6a34b71bd375e44227bed71d84fc1a72c20cb410399c9efa4f52a7f5e32c::seatoken::SEATOKEN>(&arg1.balanceToken), arg2), 0x2::tx_context::sender(arg2));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg1.balanceSUI, 0x2::balance::value<0x2::sui::SUI>(&arg1.balanceSUI), arg2), 0x2::tx_context::sender(arg2));
    }

    public fun get_info_address(arg0: &PresaleStorage, arg1: address) : (u64, u64, u64, u64, u64) {
        let (v0, v1, v2, v3, v4) = if (0x2::table::contains<address, u64>(&arg0.balances, arg1)) {
            let v5 = *0x2::table::borrow<address, u64>(&arg0.balances, arg1);
            let (v6, v7, v8, v9) = if (arg0.hardCap >= arg0.totalRaised) {
                let v10 = 0;
                (v5 / arg0.totalRaised, v5 * arg0.maxToken / arg0.hardCap, v5 - v10, v10)
            } else {
                let v11 = v5 * 100 / arg0.totalRaised;
                let v12 = arg0.hardCap * v11 / 100;
                let v13 = v5 - v12;
                (v11, v12 * arg0.maxToken / arg0.hardCap, v5 - v13, v13)
            };
            (v9, v5, v6, v7, v8)
        } else {
            (0, 0, 0, 0, 0)
        };
        (v1, v2, v3, v4, v0)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PreSaleAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<PreSaleAdminCap>(v0, @0x45af3b25576c9c40502316e854aa3b772205a97f56c0a067b7832687b7b5f4b3);
        let v1 = PresaleStorage{
            id           : 0x2::object::new(arg0),
            balanceSUI   : 0x2::balance::zero<0x2::sui::SUI>(),
            balanceToken : 0x2::balance::zero<0x917c6a34b71bd375e44227bed71d84fc1a72c20cb410399c9efa4f52a7f5e32c::seatoken::SEATOKEN>(),
            maxToken     : 15000000000,
            hardCap      : 9000000000,
            startTime    : 1684754343000,
            endTime      : 1684840743000,
            minBuy       : 100000000,
            startClaim   : 0,
            totalRaised  : 0,
            balances     : 0x2::table::new<address, u64>(arg0),
            refunded     : 0x2::table::new<address, bool>(arg0),
            owner        : @0x45af3b25576c9c40502316e854aa3b772205a97f56c0a067b7832687b7b5f4b3,
        };
        0x2::transfer::share_object<PresaleStorage>(v1);
    }

    public fun is_owner(arg0: &PresaleStorage, arg1: address) : bool {
        arg1 == arg0.owner
    }

    public entry fun purchase_token(arg0: &mut PresaleStorage, arg1: &0x2::clock::Clock, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 >= arg0.minBuy && 0x2::coin::value<0x2::sui::SUI>(arg2) >= arg3, 0);
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.startTime && 0x2::clock::timestamp_ms(arg1) <= arg0.endTime, 1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balanceSUI, 0x2::balance::split<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(arg2), arg3));
        arg0.totalRaised = arg0.totalRaised + arg3;
        if (0x2::table::contains<address, u64>(&arg0.balances, 0x2::tx_context::sender(arg4))) {
            arg3 = arg3 + *0x2::table::borrow<address, u64>(&arg0.balances, 0x2::tx_context::sender(arg4));
            0x2::table::remove<address, u64>(&mut arg0.balances, 0x2::tx_context::sender(arg4));
        };
        0x2::table::add<address, u64>(&mut arg0.balances, 0x2::tx_context::sender(arg4), arg3);
    }

    public entry fun set_claim(arg0: &PreSaleAdminCap, arg1: &mut PresaleStorage, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(is_owner(arg1, 0x2::tx_context::sender(arg3)) == true, 7);
        arg1.startClaim = arg2;
    }

    public entry fun set_end_time(arg0: &PreSaleAdminCap, arg1: &mut PresaleStorage, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(is_owner(arg1, 0x2::tx_context::sender(arg3)) == true, 7);
        arg1.endTime = arg2;
    }

    public entry fun set_hard_cap(arg0: &PreSaleAdminCap, arg1: &mut PresaleStorage, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(is_owner(arg1, 0x2::tx_context::sender(arg3)) == true, 7);
        arg1.hardCap = arg2;
    }

    public entry fun set_max_token(arg0: &PreSaleAdminCap, arg1: &mut PresaleStorage, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(is_owner(arg1, 0x2::tx_context::sender(arg3)) == true, 7);
        arg1.maxToken = arg2;
    }

    public entry fun set_min_buy(arg0: &PreSaleAdminCap, arg1: &mut PresaleStorage, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(is_owner(arg1, 0x2::tx_context::sender(arg3)) == true, 7);
        arg1.minBuy = arg2;
    }

    public entry fun set_start_time(arg0: &PreSaleAdminCap, arg1: &mut PresaleStorage, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(is_owner(arg1, 0x2::tx_context::sender(arg3)) == true, 7);
        arg1.startTime = arg2;
    }

    public entry fun transfer_admin(arg0: PreSaleAdminCap, arg1: &mut PresaleStorage, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(is_owner(arg1, 0x2::tx_context::sender(arg3)) == true, 7);
        assert!(arg2 != @0x0, 6);
        0x2::transfer::transfer<PreSaleAdminCap>(arg0, arg2);
        arg1.owner = arg2;
    }

    public entry fun transfer_token_to_contract(arg0: &PreSaleAdminCap, arg1: &mut PresaleStorage, arg2: &mut 0x2::coin::Coin<0x917c6a34b71bd375e44227bed71d84fc1a72c20cb410399c9efa4f52a7f5e32c::seatoken::SEATOKEN>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(is_owner(arg1, 0x2::tx_context::sender(arg4)) == true, 7);
        0x2::balance::join<0x917c6a34b71bd375e44227bed71d84fc1a72c20cb410399c9efa4f52a7f5e32c::seatoken::SEATOKEN>(&mut arg1.balanceToken, 0x2::balance::split<0x917c6a34b71bd375e44227bed71d84fc1a72c20cb410399c9efa4f52a7f5e32c::seatoken::SEATOKEN>(0x2::coin::balance_mut<0x917c6a34b71bd375e44227bed71d84fc1a72c20cb410399c9efa4f52a7f5e32c::seatoken::SEATOKEN>(arg2), arg3));
    }

    public entry fun withdraw(arg0: &mut PresaleStorage, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg1) > arg0.endTime, 2);
        assert!(arg0.startClaim == 1, 3);
        assert!(0x2::table::contains<address, u64>(&arg0.balances, 0x2::tx_context::sender(arg2)) && *0x2::table::borrow<address, u64>(&arg0.balances, 0x2::tx_context::sender(arg2)) > 0, 4);
        if (0x2::table::contains<address, bool>(&arg0.refunded, 0x2::tx_context::sender(arg2))) {
            assert!(*0x2::table::borrow<address, bool>(&arg0.refunded, 0x2::tx_context::sender(arg2)) == false, 5);
        };
        let (v0, v1) = caculator_claim(arg0.totalRaised, *0x2::table::borrow<address, u64>(&arg0.balances, 0x2::tx_context::sender(arg2)), arg0.hardCap, arg0.maxToken / arg0.hardCap);
        if (0x2::table::contains<address, u64>(&arg0.balances, 0x2::tx_context::sender(arg2))) {
            0x2::table::remove<address, u64>(&mut arg0.balances, 0x2::tx_context::sender(arg2));
            0x2::table::add<address, u64>(&mut arg0.balances, 0x2::tx_context::sender(arg2), 0);
        };
        if (0x2::table::contains<address, bool>(&arg0.refunded, 0x2::tx_context::sender(arg2))) {
            0x2::table::remove<address, bool>(&mut arg0.refunded, 0x2::tx_context::sender(arg2));
            0x2::table::add<address, bool>(&mut arg0.refunded, 0x2::tx_context::sender(arg2), true);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x917c6a34b71bd375e44227bed71d84fc1a72c20cb410399c9efa4f52a7f5e32c::seatoken::SEATOKEN>>(0x2::coin::take<0x917c6a34b71bd375e44227bed71d84fc1a72c20cb410399c9efa4f52a7f5e32c::seatoken::SEATOKEN>(&mut arg0.balanceToken, v0, arg2), 0x2::tx_context::sender(arg2));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.balanceSUI, v1, arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

