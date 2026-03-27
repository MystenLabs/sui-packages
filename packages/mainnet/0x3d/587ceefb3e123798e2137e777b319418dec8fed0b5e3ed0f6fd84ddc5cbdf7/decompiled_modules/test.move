module 0x3d587ceefb3e123798e2137e777b319418dec8fed0b5e3ed0f6fd84ddc5cbdf7::test {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct PopResult has store {
        total_bublz: u64,
        total_sui: u64,
        total_bubbles: u64,
        participants: vector<address>,
        bubble_counts: vector<u64>,
        claimed_sui: vector<address>,
        claimed_bublz: vector<address>,
        timestamp: u64,
    }

    struct BubbleDraw<phantom T0> has key {
        id: 0x2::object::UID,
        admin: address,
        round: u64,
        pot: 0x2::balance::Balance<0x2::sui::SUI>,
        pop_bublz: 0x2::balance::Balance<T0>,
        participation_pool: 0x2::balance::Balance<T0>,
        pop_claims: 0x2::table::Table<u64, PopResult>,
        participation_rewards: 0x2::table::Table<address, u64>,
        paused: bool,
    }

    entry fun create_draw<T0>(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = BubbleDraw<T0>{
            id                    : 0x2::object::new(arg1),
            admin                 : 0x2::tx_context::sender(arg1),
            round                 : 1,
            pot                   : 0x2::balance::zero<0x2::sui::SUI>(),
            pop_bublz             : 0x2::balance::zero<T0>(),
            participation_pool    : 0x2::balance::zero<T0>(),
            pop_claims            : 0x2::table::new<u64, PopResult>(arg1),
            participation_rewards : 0x2::table::new<address, u64>(arg1),
            paused                : false,
        };
        0x2::transfer::share_object<BubbleDraw<T0>>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

