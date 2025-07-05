module 0x8663c4ded58fc1efd6dbe54cdad9cc1814a655f5d84c1dc48fbd7fddf047bc41::atomic_swap_coordinator {
    struct SwapCoordinator has key {
        id: 0x2::object::UID,
        initiator: address,
        sui_amount: u64,
        state: u8,
        timestamp: u64,
    }

    struct SwapInitiated has copy, drop {
        coordinator_id: address,
        initiator: address,
        sui_amount: u64,
        timestamp: u64,
    }

    struct SwapCompleted has copy, drop {
        coordinator_id: address,
        initiator: address,
        final_sui_amount: u64,
        timestamp: u64,
    }

    public entry fun complete_swap(arg0: &mut SwapCoordinator, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.state == 0, 0);
        assert!(0x2::tx_context::sender(arg3) == arg0.initiator, 1);
        arg0.state = 1;
        let v0 = SwapCompleted{
            coordinator_id   : 0x2::object::uid_to_address(&arg0.id),
            initiator        : arg0.initiator,
            final_sui_amount : 0x2::coin::value<0x2::sui::SUI>(&arg1),
            timestamp        : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<SwapCompleted>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, arg0.initiator);
    }

    public entry fun emergency_recovery(arg0: &mut SwapCoordinator, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.initiator, 1);
        arg0.state = 2;
    }

    public fun get_coordinator_amount(arg0: &SwapCoordinator) : u64 {
        arg0.sui_amount
    }

    public fun get_coordinator_initiator(arg0: &SwapCoordinator) : address {
        arg0.initiator
    }

    public fun get_coordinator_state(arg0: &SwapCoordinator) : u8 {
        arg0.state
    }

    public entry fun initialize_swap(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        let v1 = 0x2::tx_context::sender(arg2);
        let v2 = 0x2::clock::timestamp_ms(arg1);
        let v3 = SwapCoordinator{
            id         : 0x2::object::new(arg2),
            initiator  : v1,
            sui_amount : v0,
            state      : 0,
            timestamp  : v2,
        };
        let v4 = 0x2::object::uid_to_address(&v3.id);
        let v5 = SwapInitiated{
            coordinator_id : v4,
            initiator      : v1,
            sui_amount     : v0,
            timestamp      : v2,
        };
        0x2::event::emit<SwapInitiated>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, v4);
        0x2::transfer::share_object<SwapCoordinator>(v3);
    }

    public fun is_completed(arg0: &SwapCoordinator) : bool {
        arg0.state == 1
    }

    public fun is_pending(arg0: &SwapCoordinator) : bool {
        arg0.state == 0
    }

    public fun min_sui_amount() : u64 {
        0x8663c4ded58fc1efd6dbe54cdad9cc1814a655f5d84c1dc48fbd7fddf047bc41::constants::sui_input_amount()
    }

    // decompiled from Move bytecode v6
}

