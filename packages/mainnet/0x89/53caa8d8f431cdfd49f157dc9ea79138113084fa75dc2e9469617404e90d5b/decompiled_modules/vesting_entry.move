module 0x8953caa8d8f431cdfd49f157dc9ea79138113084fa75dc2e9469617404e90d5b::vesting_entry {
    public entry fun claim_vested_tokens<T0>(arg0: &mut 0x8953caa8d8f431cdfd49f157dc9ea79138113084fa75dc2e9469617404e90d5b::vesting::VestingSchedule<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x8953caa8d8f431cdfd49f157dc9ea79138113084fa75dc2e9469617404e90d5b::vesting::claim_vested_tokens<T0>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun cancel_vesting<T0>(arg0: 0x8953caa8d8f431cdfd49f157dc9ea79138113084fa75dc2e9469617404e90d5b::vesting::VestingSchedule<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x8953caa8d8f431cdfd49f157dc9ea79138113084fa75dc2e9469617404e90d5b::vesting::claimed_amount<T0>(&arg0) < 0x8953caa8d8f431cdfd49f157dc9ea79138113084fa75dc2e9469617404e90d5b::vesting::total_amount<T0>(&arg0), 0);
        0x2::transfer::public_transfer<0x8953caa8d8f431cdfd49f157dc9ea79138113084fa75dc2e9469617404e90d5b::vesting::VestingSchedule<T0>>(arg0, 0x2::tx_context::sender(arg2));
    }

    public entry fun create_vesting_schedule<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address, arg2: u64, arg3: u8, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x8953caa8d8f431cdfd49f157dc9ea79138113084fa75dc2e9469617404e90d5b::vesting::VestingSchedule<T0>>(0x8953caa8d8f431cdfd49f157dc9ea79138113084fa75dc2e9469617404e90d5b::vesting::create_vesting<T0>(arg0, arg1, arg2, arg3, arg4, arg5), arg1);
    }

    // decompiled from Move bytecode v6
}

