module 0xf1bec2d22ae14357851851a91de06aa975c6182fdb7c5e9c86cd22f5c53ab4f7::boardroom {
    struct VersionDfKey has copy, drop, store {
        dummy_field: bool,
    }

    struct Staked has copy, drop {
        epoch: u64,
        amount: u64,
        earned: u64,
        sender: address,
    }

    struct Unstaked has copy, drop {
        epoch: u64,
        amount: u64,
        earned: u64,
        sender: address,
    }

    struct Claimed has copy, drop {
        epoch: u64,
        amount: u64,
        sender: address,
    }

    struct Allocated has copy, drop {
        epoch: u64,
        amount: u64,
        sender: address,
    }

    struct PendingReward has copy, drop {
        epoch: u64,
        amount: u64,
        sender: address,
    }

    struct Boardseat has store {
        amount: u64,
        latest_settled_epoch: u64,
        last_claimed_epoch: u64,
    }

    struct Boardroom has store, key {
        id: 0x2::object::UID,
        num_locked_epochs: u64,
        boardseats: 0x2::table::Table<address, Boardseat>,
        total_checkpoints: 0xcc788d4408b0929af9a399de8303ee02c034aab284d98ca1984a4affdb63e134::checkpoint64::Trace64,
        allocations: vector<u64>,
        total_staked: 0x2::balance::Balance<0x3c1227010835ecf9cb8f2bf9993aa9378bb951f0b3a098de6f0ee20385e01c4a::psh::PSH>,
        available_reward: 0x2::balance::Balance<0x4fc3949a4a8fe3ad9c75cec9724ff2b2d8520506b6129c9d8f0fcc2a1e4a8880::pdo::PDO>,
    }

    public(friend) fun create(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Boardroom{
            id                : 0x2::object::new(arg1),
            num_locked_epochs : arg0,
            boardseats        : 0x2::table::new<address, Boardseat>(arg1),
            total_checkpoints : 0xcc788d4408b0929af9a399de8303ee02c034aab284d98ca1984a4affdb63e134::checkpoint64::create(),
            allocations       : 0x1::vector::empty<u64>(),
            total_staked      : 0x2::balance::zero<0x3c1227010835ecf9cb8f2bf9993aa9378bb951f0b3a098de6f0ee20385e01c4a::psh::PSH>(),
            available_reward  : 0x2::balance::zero<0x4fc3949a4a8fe3ad9c75cec9724ff2b2d8520506b6129c9d8f0fcc2a1e4a8880::pdo::PDO>(),
        };
        let v1 = VersionDfKey{dummy_field: false};
        0x2::dynamic_field::add<VersionDfKey, u64>(&mut v0.id, v1, 1);
        0x2::transfer::share_object<Boardroom>(v0);
    }

    public(friend) fun allocate(arg0: &mut Boardroom, arg1: 0x2::coin::Coin<0x4fc3949a4a8fe3ad9c75cec9724ff2b2d8520506b6129c9d8f0fcc2a1e4a8880::pdo::PDO>, arg2: &0xf1bec2d22ae14357851851a91de06aa975c6182fdb7c5e9c86cd22f5c53ab4f7::epoch::Epoch, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x4fc3949a4a8fe3ad9c75cec9724ff2b2d8520506b6129c9d8f0fcc2a1e4a8880::pdo::PDO>(&arg1);
        0x2::balance::join<0x4fc3949a4a8fe3ad9c75cec9724ff2b2d8520506b6129c9d8f0fcc2a1e4a8880::pdo::PDO>(&mut arg0.available_reward, 0x2::coin::into_balance<0x4fc3949a4a8fe3ad9c75cec9724ff2b2d8520506b6129c9d8f0fcc2a1e4a8880::pdo::PDO>(arg1));
        if (0x1::vector::length<u64>(&arg0.allocations) <= 0xf1bec2d22ae14357851851a91de06aa975c6182fdb7c5e9c86cd22f5c53ab4f7::epoch::epoch(arg2)) {
            0x1::vector::push_back<u64>(&mut arg0.allocations, 0);
        };
        let v1 = 0x1::vector::borrow_mut<u64>(&mut arg0.allocations, 0xf1bec2d22ae14357851851a91de06aa975c6182fdb7c5e9c86cd22f5c53ab4f7::epoch::epoch(arg2));
        *v1 = *v1 + v0;
        let v2 = Allocated{
            epoch  : 0xf1bec2d22ae14357851851a91de06aa975c6182fdb7c5e9c86cd22f5c53ab4f7::epoch::epoch(arg2),
            amount : v0,
            sender : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<Allocated>(v2);
    }

    public fun allocations_at(arg0: &Boardroom, arg1: u64) : u64 {
        *0x1::vector::borrow<u64>(&arg0.allocations, arg1)
    }

    fun assert_version(arg0: &0x2::object::UID) {
        let v0 = VersionDfKey{dummy_field: false};
        assert!(*0x2::dynamic_field::borrow<VersionDfKey, u64>(arg0, v0) == 1, 999);
    }

    fun assert_version_and_upgrade(arg0: &mut Boardroom) {
        let v0 = VersionDfKey{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow_mut<VersionDfKey, u64>(&mut arg0.id, v0);
        if (*v1 < 1) {
            *v1 = 1;
        };
        assert_version(&arg0.id);
    }

    public fun available_reward(arg0: &Boardroom) : u64 {
        0x2::balance::value<0x4fc3949a4a8fe3ad9c75cec9724ff2b2d8520506b6129c9d8f0fcc2a1e4a8880::pdo::PDO>(&arg0.available_reward)
    }

    public entry fun claim(arg0: &mut Boardroom, arg1: &0xf1bec2d22ae14357851851a91de06aa975c6182fdb7c5e9c86cd22f5c53ab4f7::epoch::Epoch, arg2: &mut 0x2::tx_context::TxContext) {
        assert_version_and_upgrade(arg0);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::table::contains<address, Boardseat>(&arg0.boardseats, v0), 2);
        let v1 = harvest(arg0, arg1, v0);
        if (v1 > 0) {
            let v2 = &mut arg0.available_reward;
            0x2::transfer::public_transfer<0x2::coin::Coin<0x4fc3949a4a8fe3ad9c75cec9724ff2b2d8520506b6129c9d8f0fcc2a1e4a8880::pdo::PDO>>(0x2::coin::from_balance<0x4fc3949a4a8fe3ad9c75cec9724ff2b2d8520506b6129c9d8f0fcc2a1e4a8880::pdo::PDO>(safe_split<0x4fc3949a4a8fe3ad9c75cec9724ff2b2d8520506b6129c9d8f0fcc2a1e4a8880::pdo::PDO>(v2, v1), arg2), 0x2::tx_context::sender(arg2));
            let v3 = Claimed{
                epoch  : 0xf1bec2d22ae14357851851a91de06aa975c6182fdb7c5e9c86cd22f5c53ab4f7::epoch::epoch(arg1),
                amount : v1,
                sender : v0,
            };
            0x2::event::emit<Claimed>(v3);
        };
        0x2::table::borrow_mut<address, Boardseat>(&mut arg0.boardseats, v0).last_claimed_epoch = 0xf1bec2d22ae14357851851a91de06aa975c6182fdb7c5e9c86cd22f5c53ab4f7::epoch::epoch(arg1);
    }

    fun harvest(arg0: &mut Boardroom, arg1: &0xf1bec2d22ae14357851851a91de06aa975c6182fdb7c5e9c86cd22f5c53ab4f7::epoch::Epoch, arg2: address) : u64 {
        let v0 = 0x2::table::borrow_mut<address, Boardseat>(&mut arg0.boardseats, arg2);
        if (v0.latest_settled_epoch == 0xf1bec2d22ae14357851851a91de06aa975c6182fdb7c5e9c86cd22f5c53ab4f7::epoch::epoch(arg1)) {
            return 0
        };
        let v1 = 0;
        while (v0.latest_settled_epoch < 0xf1bec2d22ae14357851851a91de06aa975c6182fdb7c5e9c86cd22f5c53ab4f7::epoch::epoch(arg1)) {
            let v2 = *0x1::vector::borrow<u64>(&arg0.allocations, v0.latest_settled_epoch);
            let (_, v4) = 0xcc788d4408b0929af9a399de8303ee02c034aab284d98ca1984a4affdb63e134::checkpoint64::upper_lockup_recent(&arg0.total_checkpoints, v0.latest_settled_epoch);
            if (v4 > 0 && v2 > 0) {
                v1 = v1 + (((v2 as u256) * (v0.amount as u256) / (v4 as u256)) as u64);
            };
            v0.latest_settled_epoch = v0.latest_settled_epoch + 1;
        };
        v1
    }

    public entry fun migrate(arg0: &mut 0xf1bec2d22ae14357851851a91de06aa975c6182fdb7c5e9c86cd22f5c53ab4f7::admin_cap::AdminCap, arg1: &mut Boardroom) {
        let v0 = VersionDfKey{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow_mut<VersionDfKey, u64>(&mut arg1.id, v0);
        assert!(*v1 < 1, 1000);
        *v1 = 1;
    }

    public entry fun pending_reward(arg0: &Boardroom, arg1: &0xf1bec2d22ae14357851851a91de06aa975c6182fdb7c5e9c86cd22f5c53ab4f7::epoch::Epoch, arg2: &mut 0x2::tx_context::TxContext) {
        assert_version(&arg0.id);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::table::contains<address, Boardseat>(&arg0.boardseats, v0), 2);
        let v1 = 0x2::table::borrow<address, Boardseat>(&arg0.boardseats, v0);
        let v2 = 0;
        let v3 = v1.latest_settled_epoch;
        while (v3 < 0xf1bec2d22ae14357851851a91de06aa975c6182fdb7c5e9c86cd22f5c53ab4f7::epoch::epoch(arg1)) {
            let v4 = *0x1::vector::borrow<u64>(&arg0.allocations, v3);
            let (_, v6) = 0xcc788d4408b0929af9a399de8303ee02c034aab284d98ca1984a4affdb63e134::checkpoint64::upper_lockup_recent(&arg0.total_checkpoints, v3);
            if (v6 > 0 && v4 > 0) {
                v2 = v2 + (((v4 as u256) * (v1.amount as u256) / (v6 as u256)) as u64);
            };
            v3 = v3 + 1;
        };
        let v7 = PendingReward{
            epoch  : 0xf1bec2d22ae14357851851a91de06aa975c6182fdb7c5e9c86cd22f5c53ab4f7::epoch::epoch(arg1),
            amount : v2,
            sender : v0,
        };
        0x2::event::emit<PendingReward>(v7);
    }

    fun safe_split<T0>(arg0: &mut 0x2::balance::Balance<T0>, arg1: u64) : 0x2::balance::Balance<T0> {
        let v0 = 0x2::balance::value<T0>(arg0);
        if (v0 < arg1) {
            0x2::balance::split<T0>(arg0, v0)
        } else {
            0x2::balance::split<T0>(arg0, arg1)
        }
    }

    public fun seat_info(arg0: &Boardroom, arg1: address) : (u64, u64, u64) {
        let v0 = 0x2::table::borrow<address, Boardseat>(&arg0.boardseats, arg1);
        (v0.amount, v0.latest_settled_epoch, v0.last_claimed_epoch)
    }

    public entry fun stake(arg0: &mut Boardroom, arg1: 0x2::coin::Coin<0x3c1227010835ecf9cb8f2bf9993aa9378bb951f0b3a098de6f0ee20385e01c4a::psh::PSH>, arg2: &0xf1bec2d22ae14357851851a91de06aa975c6182fdb7c5e9c86cd22f5c53ab4f7::epoch::Epoch, arg3: &mut 0x2::tx_context::TxContext) {
        assert_version_and_upgrade(arg0);
        assert!(0x2::coin::value<0x3c1227010835ecf9cb8f2bf9993aa9378bb951f0b3a098de6f0ee20385e01c4a::psh::PSH>(&arg1) > 0, 1);
        let v0 = 0x2::tx_context::sender(arg3);
        if (!0x2::table::contains<address, Boardseat>(&arg0.boardseats, v0)) {
            let v1 = Boardseat{
                amount               : 0,
                latest_settled_epoch : 0xf1bec2d22ae14357851851a91de06aa975c6182fdb7c5e9c86cd22f5c53ab4f7::epoch::epoch(arg2),
                last_claimed_epoch   : 0xf1bec2d22ae14357851851a91de06aa975c6182fdb7c5e9c86cd22f5c53ab4f7::epoch::epoch(arg2),
            };
            0x2::table::add<address, Boardseat>(&mut arg0.boardseats, v0, v1);
        };
        let v2 = harvest(arg0, arg2, v0);
        if (v2 > 0) {
            let v3 = &mut arg0.available_reward;
            0x2::transfer::public_transfer<0x2::coin::Coin<0x4fc3949a4a8fe3ad9c75cec9724ff2b2d8520506b6129c9d8f0fcc2a1e4a8880::pdo::PDO>>(0x2::coin::from_balance<0x4fc3949a4a8fe3ad9c75cec9724ff2b2d8520506b6129c9d8f0fcc2a1e4a8880::pdo::PDO>(safe_split<0x4fc3949a4a8fe3ad9c75cec9724ff2b2d8520506b6129c9d8f0fcc2a1e4a8880::pdo::PDO>(v3, v2), arg3), 0x2::tx_context::sender(arg3));
            let v4 = Claimed{
                epoch  : 0xf1bec2d22ae14357851851a91de06aa975c6182fdb7c5e9c86cd22f5c53ab4f7::epoch::epoch(arg2),
                amount : v2,
                sender : v0,
            };
            0x2::event::emit<Claimed>(v4);
        };
        let v5 = 0x2::table::borrow_mut<address, Boardseat>(&mut arg0.boardseats, v0);
        let v6 = 0x2::coin::value<0x3c1227010835ecf9cb8f2bf9993aa9378bb951f0b3a098de6f0ee20385e01c4a::psh::PSH>(&arg1);
        0x2::balance::join<0x3c1227010835ecf9cb8f2bf9993aa9378bb951f0b3a098de6f0ee20385e01c4a::psh::PSH>(&mut arg0.total_staked, 0x2::coin::into_balance<0x3c1227010835ecf9cb8f2bf9993aa9378bb951f0b3a098de6f0ee20385e01c4a::psh::PSH>(arg1));
        v5.amount = v5.amount + v6;
        v5.last_claimed_epoch = 0xf1bec2d22ae14357851851a91de06aa975c6182fdb7c5e9c86cd22f5c53ab4f7::epoch::epoch(arg2);
        let (_, _) = 0xcc788d4408b0929af9a399de8303ee02c034aab284d98ca1984a4affdb63e134::checkpoint64::push(&mut arg0.total_checkpoints, 0xf1bec2d22ae14357851851a91de06aa975c6182fdb7c5e9c86cd22f5c53ab4f7::epoch::epoch(arg2), 0xcc788d4408b0929af9a399de8303ee02c034aab284d98ca1984a4affdb63e134::checkpoint64::latest(&arg0.total_checkpoints) + v6);
        let v9 = Staked{
            epoch  : 0xf1bec2d22ae14357851851a91de06aa975c6182fdb7c5e9c86cd22f5c53ab4f7::epoch::epoch(arg2),
            amount : v6,
            earned : v2,
            sender : v0,
        };
        0x2::event::emit<Staked>(v9);
    }

    public fun total_staked(arg0: &Boardroom) : u64 {
        0x2::balance::value<0x3c1227010835ecf9cb8f2bf9993aa9378bb951f0b3a098de6f0ee20385e01c4a::psh::PSH>(&arg0.total_staked)
    }

    public fun total_staked_at(arg0: &Boardroom, arg1: u64) : u64 {
        let (_, v1) = 0xcc788d4408b0929af9a399de8303ee02c034aab284d98ca1984a4affdb63e134::checkpoint64::upper_lockup_recent(&arg0.total_checkpoints, arg1);
        v1
    }

    public entry fun unstake(arg0: &mut Boardroom, arg1: u64, arg2: &0xf1bec2d22ae14357851851a91de06aa975c6182fdb7c5e9c86cd22f5c53ab4f7::epoch::Epoch, arg3: &mut 0x2::tx_context::TxContext) {
        assert_version_and_upgrade(arg0);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(arg1 > 0, 1);
        assert!(0x2::table::contains<address, Boardseat>(&arg0.boardseats, v0), 2);
        assert!(0xf1bec2d22ae14357851851a91de06aa975c6182fdb7c5e9c86cd22f5c53ab4f7::epoch::epoch(arg2) >= 0x2::table::borrow<address, Boardseat>(&arg0.boardseats, v0).last_claimed_epoch + arg0.num_locked_epochs, 3);
        assert!(0x2::table::borrow<address, Boardseat>(&arg0.boardseats, v0).amount >= arg1, 0);
        let v1 = harvest(arg0, arg2, v0);
        if (v1 > 0) {
            let v2 = &mut arg0.available_reward;
            0x2::transfer::public_transfer<0x2::coin::Coin<0x4fc3949a4a8fe3ad9c75cec9724ff2b2d8520506b6129c9d8f0fcc2a1e4a8880::pdo::PDO>>(0x2::coin::from_balance<0x4fc3949a4a8fe3ad9c75cec9724ff2b2d8520506b6129c9d8f0fcc2a1e4a8880::pdo::PDO>(safe_split<0x4fc3949a4a8fe3ad9c75cec9724ff2b2d8520506b6129c9d8f0fcc2a1e4a8880::pdo::PDO>(v2, v1), arg3), 0x2::tx_context::sender(arg3));
            let v3 = Claimed{
                epoch  : 0xf1bec2d22ae14357851851a91de06aa975c6182fdb7c5e9c86cd22f5c53ab4f7::epoch::epoch(arg2),
                amount : v1,
                sender : v0,
            };
            0x2::event::emit<Claimed>(v3);
        };
        let v4 = 0x2::table::borrow_mut<address, Boardseat>(&mut arg0.boardseats, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x3c1227010835ecf9cb8f2bf9993aa9378bb951f0b3a098de6f0ee20385e01c4a::psh::PSH>>(0x2::coin::from_balance<0x3c1227010835ecf9cb8f2bf9993aa9378bb951f0b3a098de6f0ee20385e01c4a::psh::PSH>(0x2::balance::split<0x3c1227010835ecf9cb8f2bf9993aa9378bb951f0b3a098de6f0ee20385e01c4a::psh::PSH>(&mut arg0.total_staked, arg1), arg3), v0);
        v4.amount = v4.amount - arg1;
        v4.last_claimed_epoch = 0xf1bec2d22ae14357851851a91de06aa975c6182fdb7c5e9c86cd22f5c53ab4f7::epoch::epoch(arg2);
        let (_, _) = 0xcc788d4408b0929af9a399de8303ee02c034aab284d98ca1984a4affdb63e134::checkpoint64::push(&mut arg0.total_checkpoints, 0xf1bec2d22ae14357851851a91de06aa975c6182fdb7c5e9c86cd22f5c53ab4f7::epoch::epoch(arg2), 0xcc788d4408b0929af9a399de8303ee02c034aab284d98ca1984a4affdb63e134::checkpoint64::latest(&arg0.total_checkpoints) - arg1);
        let v7 = Unstaked{
            epoch  : 0xf1bec2d22ae14357851851a91de06aa975c6182fdb7c5e9c86cd22f5c53ab4f7::epoch::epoch(arg2),
            amount : arg1,
            earned : v1,
            sender : v0,
        };
        0x2::event::emit<Unstaked>(v7);
    }

    // decompiled from Move bytecode v6
}

