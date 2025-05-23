module 0xc786a83346123f3660a4f4e653e53f4b5dea6cd7d9cefc41ff6b5574c72c47a::distribute {
    struct Rewards_Config has store, key {
        id: 0x2::object::UID,
        rewards_percent_list_gold: vector<u64>,
        rewards_percent_list_silver: vector<u64>,
        rewards_percent_list_bronze: vector<u64>,
    }

    struct DistributeCap has store, key {
        id: 0x2::object::UID,
    }

    entry fun distributeBonus(arg0: u64, arg1: 0xc786a83346123f3660a4f4e653e53f4b5dea6cd7d9cefc41ff6b5574c72c47a::Ticket::Ticket, arg2: &mut 0xc786a83346123f3660a4f4e653e53f4b5dea6cd7d9cefc41ff6b5574c72c47a::prizePool::PrizePool, arg3: &0x2::random::Random, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg4) - 0xc786a83346123f3660a4f4e653e53f4b5dea6cd7d9cefc41ff6b5574c72c47a::Ticket::getTicketTime(&arg1) < 259200000, 6);
        assert!(0xc786a83346123f3660a4f4e653e53f4b5dea6cd7d9cefc41ff6b5574c72c47a::Ticket::getTicketLevel(&arg1) == 0xc786a83346123f3660a4f4e653e53f4b5dea6cd7d9cefc41ff6b5574c72c47a::prizePool::getPoolLevel(arg2), 5);
        let v0 = 0xc786a83346123f3660a4f4e653e53f4b5dea6cd7d9cefc41ff6b5574c72c47a::Ticket::getTicketPrice(&arg1);
        let v1 = 0x2::random::new_generator(arg3, arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0xc786a83346123f3660a4f4e653e53f4b5dea6cd7d9cefc41ff6b5574c72c47a::prizePool::getBonus(arg2, 2 * v0 * 0x2::random::generate_u64_in_range(&mut v1, 10, 100) / 1000 + 3 * v0 * arg0 / 2000, arg5), 0x2::tx_context::sender(arg5));
        0xc786a83346123f3660a4f4e653e53f4b5dea6cd7d9cefc41ff6b5574c72c47a::Ticket::delTicket(arg1);
    }

    entry fun distributeLessThan10(arg0: &DistributeCap, arg1: vector<address>, arg2: vector<address>, arg3: vector<address>, arg4: &mut 0xc786a83346123f3660a4f4e653e53f4b5dea6cd7d9cefc41ff6b5574c72c47a::prizePool::PrizePool, arg5: &mut 0xc786a83346123f3660a4f4e653e53f4b5dea6cd7d9cefc41ff6b5574c72c47a::prizePool::PrizePool, arg6: &mut 0xc786a83346123f3660a4f4e653e53f4b5dea6cd7d9cefc41ff6b5574c72c47a::prizePool::PrizePool, arg7: &mut 0x2::tx_context::TxContext) {
        if (0x1::vector::length<address>(&arg1) > 0) {
            0xc786a83346123f3660a4f4e653e53f4b5dea6cd7d9cefc41ff6b5574c72c47a::prizePool::distributeEvery(arg1, arg4, arg7);
        };
        if (0x1::vector::length<address>(&arg2) > 0) {
            0xc786a83346123f3660a4f4e653e53f4b5dea6cd7d9cefc41ff6b5574c72c47a::prizePool::distributeEvery(arg2, arg5, arg7);
        };
        if (0x1::vector::length<address>(&arg3) > 0) {
            0xc786a83346123f3660a4f4e653e53f4b5dea6cd7d9cefc41ff6b5574c72c47a::prizePool::distributeEvery(arg3, arg6, arg7);
        };
    }

    entry fun distributeMoreThan10(arg0: &DistributeCap, arg1: &Rewards_Config, arg2: vector<address>, arg3: vector<address>, arg4: vector<address>, arg5: &mut 0xc786a83346123f3660a4f4e653e53f4b5dea6cd7d9cefc41ff6b5574c72c47a::prizePool::PrizePool, arg6: &mut 0xc786a83346123f3660a4f4e653e53f4b5dea6cd7d9cefc41ff6b5574c72c47a::prizePool::PrizePool, arg7: &mut 0xc786a83346123f3660a4f4e653e53f4b5dea6cd7d9cefc41ff6b5574c72c47a::prizePool::PrizePool, arg8: &mut 0x2::tx_context::TxContext) {
        if (0x1::vector::length<address>(&arg2) >= 10) {
            0xc786a83346123f3660a4f4e653e53f4b5dea6cd7d9cefc41ff6b5574c72c47a::prizePool::distributeRank(arg2, arg1.rewards_percent_list_gold, arg5, arg8);
        };
        if (0x1::vector::length<address>(&arg3) > 10) {
            0xc786a83346123f3660a4f4e653e53f4b5dea6cd7d9cefc41ff6b5574c72c47a::prizePool::distributeRank(arg3, arg1.rewards_percent_list_silver, arg6, arg8);
        };
        if (0x1::vector::length<address>(&arg4) > 10) {
            0xc786a83346123f3660a4f4e653e53f4b5dea6cd7d9cefc41ff6b5574c72c47a::prizePool::distributeRank(arg4, arg1.rewards_percent_list_bronze, arg7, arg8);
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Rewards_Config{
            id                          : 0x2::object::new(arg0),
            rewards_percent_list_gold   : vector[300, 200, 100, 75, 45, 36, 36, 36, 36, 36],
            rewards_percent_list_silver : vector[300, 200, 100, 75, 45, 36, 36, 36, 36, 36],
            rewards_percent_list_bronze : vector[300, 200, 100, 75, 45, 36, 36, 36, 36, 36],
        };
        0x2::transfer::public_share_object<Rewards_Config>(v0);
        let v1 = DistributeCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<DistributeCap>(v1, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

