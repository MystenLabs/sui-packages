module 0x5220c7f5353598ea846f3aa1b1dde0766d2279bd603e7bdf9c13097a35369e56::fluidity_utility_mining {
    struct CoinReserve<phantom T0> has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
    }

    struct FLUIDITY_UTILITY_MINING has drop {
        dummy_field: bool,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct WorkerCap has key {
        id: 0x2::object::UID,
    }

    struct CreateCoinReserveEvent has copy, drop {
        coin_reserve_id: 0x2::object::ID,
    }

    struct DistributeEvent has copy, drop {
        coin_reserve_id: 0x2::object::ID,
        recipient: address,
        amount: u64,
    }

    struct AddToReserveEvent has copy, drop {
        coin_reserve_id: 0x2::object::ID,
        depositor: address,
        amount: u64,
    }

    entry fun add_to_reserve<T0>(arg0: &AdminCap, arg1: &mut CoinReserve<T0>, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::tx_context::TxContext) {
        0x2::balance::join<T0>(&mut arg1.balance, 0x2::coin::into_balance<T0>(arg2));
        let v0 = AddToReserveEvent{
            coin_reserve_id : 0x2::object::uid_to_inner(&arg1.id),
            depositor       : 0x2::tx_context::sender(arg3),
            amount          : 0x2::coin::value<T0>(&arg2),
        };
        0x2::event::emit<AddToReserveEvent>(v0);
    }

    entry fun create_coin_reserve<T0>(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = CoinReserve<T0>{
            id      : 0x2::object::new(arg1),
            balance : 0x2::balance::zero<T0>(),
        };
        let v1 = CreateCoinReserveEvent{coin_reserve_id: 0x2::object::uid_to_inner(&v0.id)};
        0x2::event::emit<CreateCoinReserveEvent>(v1);
        0x2::transfer::share_object<CoinReserve<T0>>(v0);
    }

    entry fun distribute_from_reserve<T0>(arg0: &WorkerCap, arg1: &mut CoinReserve<T0>, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<T0>(&arg1.balance) >= arg3, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.balance, arg3), arg4), arg2);
        let v0 = DistributeEvent{
            coin_reserve_id : 0x2::object::uid_to_inner(&arg1.id),
            recipient       : arg2,
            amount          : arg3,
        };
        0x2::event::emit<DistributeEvent>(v0);
    }

    fun init(arg0: FLUIDITY_UTILITY_MINING, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = WorkerCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<WorkerCap>(v0, 0x2::tx_context::sender(arg1));
        let v1 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg1));
    }

    entry fun transfer_admin_cap(arg0: AdminCap, arg1: address) {
        0x2::transfer::transfer<AdminCap>(arg0, arg1);
    }

    entry fun transfer_worker_cap(arg0: &AdminCap, arg1: WorkerCap, arg2: address) {
        0x2::transfer::transfer<WorkerCap>(arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

