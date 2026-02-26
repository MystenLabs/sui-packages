module 0xf6f9cc7be9b82106a5a90da23acb2631acd39f2951f47da222565df0fa28fbe4::matchmaker {
    struct Queue has key {
        id: 0x2::object::UID,
        tier: u8,
        stake_amount: u64,
        player_addrs: vector<address>,
        ship_ids: vector<address>,
        stakes: vector<0x2::coin::Coin<0x2::sui::SUI>>,
    }

    struct MatchFound has copy, drop {
        queue_id: address,
        player1: address,
        player2: address,
        ship1: address,
        ship2: address,
        stake_amount: u64,
    }

    struct PlayerQueued has copy, drop {
        queue_id: address,
        player: address,
        ship_id: address,
        tier: u8,
    }

    struct PlayerCancelled has copy, drop {
        queue_id: address,
        player: address,
    }

    public entry fun cancel_queue(arg0: &mut Queue, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = false;
        let v2 = 0;
        let v3 = 0;
        while (v3 < 0x1::vector::length<address>(&arg0.player_addrs)) {
            if (*0x1::vector::borrow<address>(&arg0.player_addrs, v3) == v0) {
                v1 = true;
            };
            v3 = v3 + 1;
        };
        assert!(v1, 2);
        0x1::vector::remove<address>(&mut arg0.player_addrs, v2);
        0x1::vector::remove<address>(&mut arg0.ship_ids, v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x1::vector::remove<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg0.stakes, v2), v0);
        let v4 = PlayerCancelled{
            queue_id : 0x2::object::uid_to_address(&arg0.id),
            player   : v0,
        };
        0x2::event::emit<PlayerCancelled>(v4);
    }

    public fun get_stake_amount(arg0: &Queue) : u64 {
        arg0.stake_amount
    }

    public fun get_tier(arg0: &Queue) : u8 {
        arg0.tier
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Queue{
            id           : 0x2::object::new(arg0),
            tier         : 0,
            stake_amount : 100000000,
            player_addrs : 0x1::vector::empty<address>(),
            ship_ids     : 0x1::vector::empty<address>(),
            stakes       : 0x1::vector::empty<0x2::coin::Coin<0x2::sui::SUI>>(),
        };
        0x2::transfer::share_object<Queue>(v0);
        let v1 = Queue{
            id           : 0x2::object::new(arg0),
            tier         : 1,
            stake_amount : 1000000000,
            player_addrs : 0x1::vector::empty<address>(),
            ship_ids     : 0x1::vector::empty<address>(),
            stakes       : 0x1::vector::empty<0x2::coin::Coin<0x2::sui::SUI>>(),
        };
        0x2::transfer::share_object<Queue>(v1);
        let v2 = Queue{
            id           : 0x2::object::new(arg0),
            tier         : 2,
            stake_amount : 5000000000,
            player_addrs : 0x1::vector::empty<address>(),
            ship_ids     : 0x1::vector::empty<address>(),
            stakes       : 0x1::vector::empty<0x2::coin::Coin<0x2::sui::SUI>>(),
        };
        0x2::transfer::share_object<Queue>(v2);
        let v3 = Queue{
            id           : 0x2::object::new(arg0),
            tier         : 3,
            stake_amount : 10000000000,
            player_addrs : 0x1::vector::empty<address>(),
            ship_ids     : 0x1::vector::empty<address>(),
            stakes       : 0x1::vector::empty<0x2::coin::Coin<0x2::sui::SUI>>(),
        };
        0x2::transfer::share_object<Queue>(v3);
    }

    public entry fun join_queue(arg0: &mut Queue, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) == arg0.stake_amount, 3);
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(&arg0.player_addrs)) {
            assert!(*0x1::vector::borrow<address>(&arg0.player_addrs, v1) != v0, 1);
            v1 = v1 + 1;
        };
        0x1::vector::push_back<address>(&mut arg0.player_addrs, v0);
        0x1::vector::push_back<address>(&mut arg0.ship_ids, arg2);
        0x1::vector::push_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg0.stakes, arg1);
        let v2 = PlayerQueued{
            queue_id : 0x2::object::uid_to_address(&arg0.id),
            player   : v0,
            ship_id  : arg2,
            tier     : arg0.tier,
        };
        0x2::event::emit<PlayerQueued>(v2);
        if (0x1::vector::length<address>(&arg0.player_addrs) >= 2) {
            let v3 = MatchFound{
                queue_id     : 0x2::object::uid_to_address(&arg0.id),
                player1      : *0x1::vector::borrow<address>(&arg0.player_addrs, 0),
                player2      : *0x1::vector::borrow<address>(&arg0.player_addrs, 1),
                ship1        : *0x1::vector::borrow<address>(&arg0.ship_ids, 0),
                ship2        : *0x1::vector::borrow<address>(&arg0.ship_ids, 1),
                stake_amount : arg0.stake_amount,
            };
            0x2::event::emit<MatchFound>(v3);
        };
    }

    public fun queue_length(arg0: &Queue) : u64 {
        0x1::vector::length<address>(&arg0.player_addrs)
    }

    public entry fun resolve_from_queue(arg0: &mut Queue, arg1: &mut 0xf6f9cc7be9b82106a5a90da23acb2631acd39f2951f47da222565df0fa28fbe4::spaceship::Spaceship, arg2: &mut 0xf6f9cc7be9b82106a5a90da23acb2631acd39f2951f47da222565df0fa28fbe4::spaceship::Spaceship, arg3: vector<u8>, arg4: vector<u8>, arg5: address, arg6: &0x2::random::Random, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<address>(&arg0.player_addrs) >= 2, 4);
        0x1::vector::remove<address>(&mut arg0.ship_ids, 0);
        0x1::vector::remove<address>(&mut arg0.ship_ids, 0);
        0xf6f9cc7be9b82106a5a90da23acb2631acd39f2951f47da222565df0fa28fbe4::battle::resolve(arg1, arg2, 0x1::vector::remove<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg0.stakes, 0), 0x1::vector::remove<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg0.stakes, 0), 0x1::vector::remove<address>(&mut arg0.player_addrs, 0), 0x1::vector::remove<address>(&mut arg0.player_addrs, 0), arg3, arg4, arg5, arg6, arg7);
    }

    // decompiled from Move bytecode v6
}

