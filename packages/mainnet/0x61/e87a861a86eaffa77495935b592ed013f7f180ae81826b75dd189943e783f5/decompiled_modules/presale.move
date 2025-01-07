module 0x61e87a861a86eaffa77495935b592ed013f7f180ae81826b75dd189943e783f5::presale {
    struct PreSaleAdminCap has key {
        id: 0x2::object::UID,
    }

    struct PresaleStorage has key {
        id: 0x2::object::UID,
        balanceSUI: 0x2::balance::Balance<0x2::sui::SUI>,
        balanceToken: 0x2::balance::Balance<0x1f1e215c5afa4edc9e7f6add3da07d4cdc4a9c8f8b352b75159f3b413e94f72c::seatoken::SEATOKEN>,
        maxToken: u64,
        hardCap: u64,
        startTime: u64,
        endTime: u64,
        minBuy: u64,
        startClaim: bool,
        totalRaised: u64,
        balances: 0x2::vec_map::VecMap<address, u64>,
        refunded: 0x2::vec_map::VecMap<address, bool>,
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
        0x2::transfer::public_transfer<0x2::coin::Coin<0x1f1e215c5afa4edc9e7f6add3da07d4cdc4a9c8f8b352b75159f3b413e94f72c::seatoken::SEATOKEN>>(0x2::coin::take<0x1f1e215c5afa4edc9e7f6add3da07d4cdc4a9c8f8b352b75159f3b413e94f72c::seatoken::SEATOKEN>(&mut arg1.balanceToken, 0x2::balance::value<0x1f1e215c5afa4edc9e7f6add3da07d4cdc4a9c8f8b352b75159f3b413e94f72c::seatoken::SEATOKEN>(&arg1.balanceToken), arg2), 0x2::tx_context::sender(arg2));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg1.balanceSUI, 0x2::balance::value<0x2::sui::SUI>(&arg1.balanceSUI), arg2), 0x2::tx_context::sender(arg2));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PreSaleAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<PreSaleAdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = PresaleStorage{
            id           : 0x2::object::new(arg0),
            balanceSUI   : 0x2::balance::zero<0x2::sui::SUI>(),
            balanceToken : 0x2::balance::zero<0x1f1e215c5afa4edc9e7f6add3da07d4cdc4a9c8f8b352b75159f3b413e94f72c::seatoken::SEATOKEN>(),
            maxToken     : 1000,
            hardCap      : 100,
            startTime    : 1684166430000,
            endTime      : 1684252830000,
            minBuy       : 1,
            startClaim   : false,
            totalRaised  : 0,
            balances     : 0x2::vec_map::empty<address, u64>(),
            refunded     : 0x2::vec_map::empty<address, bool>(),
            owner        : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<PresaleStorage>(v1);
    }

    public fun is_owner(arg0: &PresaleStorage, arg1: address) : bool {
        arg1 == arg0.owner
    }

    public entry fun purchase_token(arg0: &mut PresaleStorage, arg1: &0x2::clock::Clock, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(arg2);
        let v1 = v0;
        assert!(v0 >= arg0.minBuy, 0);
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.startTime && 0x2::clock::timestamp_ms(arg1) <= arg0.endTime, 1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balanceSUI, 0x2::balance::split<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(arg2), v0));
        let v2 = 0x2::tx_context::sender(arg3);
        if (0x2::vec_map::contains<address, u64>(&arg0.balances, &v2)) {
            let v3 = 0x2::tx_context::sender(arg3);
            v1 = v0 + *0x2::vec_map::get<address, u64>(&arg0.balances, &v3);
        };
        0x2::vec_map::insert<address, u64>(&mut arg0.balances, 0x2::tx_context::sender(arg3), v1);
        arg0.totalRaised = arg0.totalRaised + v1;
    }

    public entry fun set_claim(arg0: &PreSaleAdminCap, arg1: &mut PresaleStorage, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
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

    public entry fun transfer_token_to_contract(arg0: &PreSaleAdminCap, arg1: &mut PresaleStorage, arg2: &mut 0x2::coin::Coin<0x1f1e215c5afa4edc9e7f6add3da07d4cdc4a9c8f8b352b75159f3b413e94f72c::seatoken::SEATOKEN>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(is_owner(arg1, 0x2::tx_context::sender(arg3)) == true, 7);
        0x2::balance::join<0x1f1e215c5afa4edc9e7f6add3da07d4cdc4a9c8f8b352b75159f3b413e94f72c::seatoken::SEATOKEN>(&mut arg1.balanceToken, 0x2::balance::split<0x1f1e215c5afa4edc9e7f6add3da07d4cdc4a9c8f8b352b75159f3b413e94f72c::seatoken::SEATOKEN>(0x2::coin::balance_mut<0x1f1e215c5afa4edc9e7f6add3da07d4cdc4a9c8f8b352b75159f3b413e94f72c::seatoken::SEATOKEN>(arg2), 0x2::coin::value<0x1f1e215c5afa4edc9e7f6add3da07d4cdc4a9c8f8b352b75159f3b413e94f72c::seatoken::SEATOKEN>(arg2)));
    }

    public entry fun withdraw(arg0: &mut PresaleStorage, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg1) > arg0.endTime, 2);
        assert!(arg0.startClaim == true, 3);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(*0x2::vec_map::get<address, u64>(&arg0.balances, &v0) > 0, 4);
        let v1 = 0x2::tx_context::sender(arg2);
        assert!(*0x2::vec_map::get<address, bool>(&arg0.refunded, &v1) == false, 5);
        let v2 = 0x2::tx_context::sender(arg2);
        let (v3, v4) = caculator_claim(arg0.totalRaised, *0x2::vec_map::get<address, u64>(&arg0.balances, &v2), arg0.hardCap, arg0.maxToken / arg0.hardCap);
        0x2::vec_map::insert<address, u64>(&mut arg0.balances, 0x2::tx_context::sender(arg2), 0);
        0x2::vec_map::insert<address, bool>(&mut arg0.refunded, 0x2::tx_context::sender(arg2), true);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x1f1e215c5afa4edc9e7f6add3da07d4cdc4a9c8f8b352b75159f3b413e94f72c::seatoken::SEATOKEN>>(0x2::coin::take<0x1f1e215c5afa4edc9e7f6add3da07d4cdc4a9c8f8b352b75159f3b413e94f72c::seatoken::SEATOKEN>(&mut arg0.balanceToken, v3, arg2), 0x2::tx_context::sender(arg2));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.balanceSUI, v4, arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

