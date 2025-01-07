module 0xca7ba1c8700a67145c4b700c900cb9bb137ef2e2a9e59cb63b7a71136c57ab4b::coinflip {
    struct GamePool<phantom T0> has key {
        id: 0x2::object::UID,
        owner: address,
        balance: 0x2::balance::Balance<T0>,
        fee: u16,
        live: bool,
    }

    struct PlayerData has store, key {
        id: 0x2::object::UID,
        amount: u64,
        select: u8,
        result: u8,
    }

    struct GameEnded<phantom T0> has copy, drop {
        player: address,
        amount: u64,
        select: u8,
        result: u8,
    }

    struct RewardClaimed<phantom T0> has copy, drop {
        player: address,
        amount: u64,
    }

    entry fun claim<T0: drop>(arg0: &mut GamePool<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x2::dynamic_object_field::exists_<address>(&arg0.id, v0), 2);
        let v1 = 0x2::dynamic_object_field::borrow_mut<address, PlayerData>(&mut arg0.id, v0);
        assert!(v1.result == 1, 5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, v1.amount * 2), arg1), v0);
        let v2 = RewardClaimed<T0>{
            player : v0,
            amount : v1.amount,
        };
        0x2::event::emit<RewardClaimed<T0>>(v2);
        v1.amount = 0;
        v1.select = 0;
        v1.result = 0;
    }

    public entry fun create_game_pool<T0: drop>(arg0: u16, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = GamePool<T0>{
            id      : 0x2::object::new(arg1),
            owner   : 0x2::tx_context::sender(arg1),
            balance : 0x2::balance::zero<T0>(),
            fee     : arg0,
            live    : true,
        };
        0x2::transfer::share_object<GamePool<T0>>(v0);
    }

    entry fun deposit<T0: drop>(arg0: &mut GamePool<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u64) {
        assert!(arg2 == 0x2::coin::value<T0>(&arg1), 1);
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg1));
    }

    entry fun deposit_mut<T0: drop>(arg0: &mut GamePool<T0>, arg1: &mut 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        deposit<T0>(arg0, 0x2::coin::split<T0>(arg1, arg2, arg3), arg2);
    }

    entry fun live_game<T0: drop>(arg0: &mut GamePool<T0>, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 4);
        arg0.live = arg1;
    }

    entry fun play<T0: drop>(arg0: &mut GamePool<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: u8, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 + arg2 * (arg0.fee as u64) / 10000 == 0x2::coin::value<T0>(&arg1), 1);
        assert!(arg3 == 1 || arg3 == 2, 6);
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg1));
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = (((0x2::clock::timestamp_ms(arg4) + 1) % 2) as u8);
        if (0x2::dynamic_object_field::exists_<address>(&arg0.id, v0)) {
            let v2 = 0x2::dynamic_object_field::borrow_mut<address, PlayerData>(&mut arg0.id, v0);
            assert!(v2.result == 0, 5);
            v2.amount = arg2;
            v2.select = arg3;
            v2.result = v1;
        } else {
            let v3 = PlayerData{
                id     : 0x2::object::new(arg5),
                amount : arg2,
                select : arg3,
                result : v1,
            };
            0x2::dynamic_object_field::add<address, PlayerData>(&mut arg0.id, v0, v3);
        };
        let v4 = GameEnded<T0>{
            player : v0,
            amount : arg2,
            select : arg3,
            result : v1,
        };
        0x2::event::emit<GameEnded<T0>>(v4);
    }

    entry fun play_mut<T0: drop>(arg0: &mut GamePool<T0>, arg1: &mut 0x2::coin::Coin<T0>, arg2: u64, arg3: u8, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::split<T0>(arg1, arg2 + arg2 * (arg0.fee as u64) / 10000, arg5);
        play<T0>(arg0, v0, arg2, arg3, arg4, arg5);
    }

    entry fun transfer_ownership<T0: drop>(arg0: &mut GamePool<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 4);
        arg0.owner = arg1;
    }

    entry fun update_game_fee<T0: drop>(arg0: &mut GamePool<T0>, arg1: u16, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 4);
        arg0.fee = arg1;
    }

    entry fun withdraw<T0: drop>(arg0: &mut GamePool<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, arg1), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

