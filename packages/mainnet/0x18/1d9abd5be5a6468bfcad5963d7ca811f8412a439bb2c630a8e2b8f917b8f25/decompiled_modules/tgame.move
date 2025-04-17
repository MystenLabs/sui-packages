module 0x181d9abd5be5a6468bfcad5963d7ca811f8412a439bb2c630a8e2b8f917b8f25::tgame {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct GamePool has key {
        id: 0x2::object::UID,
        amount: 0x2::balance::Balance<0xa01e1513bc26c4bc087876be4e6d707fcdddbfaa197b3b8fe9304dabeefbdd61::tcoin_facuet::TCOIN_FACUET>,
    }

    public entry fun deposit(arg0: &AdminCap, arg1: &mut 0x2::coin::Coin<0xa01e1513bc26c4bc087876be4e6d707fcdddbfaa197b3b8fe9304dabeefbdd61::tcoin_facuet::TCOIN_FACUET>, arg2: &mut GamePool, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0xa01e1513bc26c4bc087876be4e6d707fcdddbfaa197b3b8fe9304dabeefbdd61::tcoin_facuet::TCOIN_FACUET>(arg1) > arg3, 2);
        0x2::balance::join<0xa01e1513bc26c4bc087876be4e6d707fcdddbfaa197b3b8fe9304dabeefbdd61::tcoin_facuet::TCOIN_FACUET>(&mut arg2.amount, 0x2::coin::into_balance<0xa01e1513bc26c4bc087876be4e6d707fcdddbfaa197b3b8fe9304dabeefbdd61::tcoin_facuet::TCOIN_FACUET>(0x2::coin::split<0xa01e1513bc26c4bc087876be4e6d707fcdddbfaa197b3b8fe9304dabeefbdd61::tcoin_facuet::TCOIN_FACUET>(arg1, arg3, arg4)));
    }

    public entry fun get_coin(arg0: &AdminCap, arg1: &mut GamePool, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 <= 0x2::balance::value<0xa01e1513bc26c4bc087876be4e6d707fcdddbfaa197b3b8fe9304dabeefbdd61::tcoin_facuet::TCOIN_FACUET>(&arg1.amount), 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xa01e1513bc26c4bc087876be4e6d707fcdddbfaa197b3b8fe9304dabeefbdd61::tcoin_facuet::TCOIN_FACUET>>(0x2::coin::from_balance<0xa01e1513bc26c4bc087876be4e6d707fcdddbfaa197b3b8fe9304dabeefbdd61::tcoin_facuet::TCOIN_FACUET>(0x2::balance::split<0xa01e1513bc26c4bc087876be4e6d707fcdddbfaa197b3b8fe9304dabeefbdd61::tcoin_facuet::TCOIN_FACUET>(&mut arg1.amount, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = GamePool{
            id     : 0x2::object::new(arg0),
            amount : 0x2::balance::zero<0xa01e1513bc26c4bc087876be4e6d707fcdddbfaa197b3b8fe9304dabeefbdd61::tcoin_facuet::TCOIN_FACUET>(),
        };
        0x2::transfer::share_object<GamePool>(v1);
    }

    public entry fun play(arg0: &mut 0x2::coin::Coin<0xa01e1513bc26c4bc087876be4e6d707fcdddbfaa197b3b8fe9304dabeefbdd61::tcoin_facuet::TCOIN_FACUET>, arg1: &mut GamePool, arg2: bool, arg3: &0x2::random::Random, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0xa01e1513bc26c4bc087876be4e6d707fcdddbfaa197b3b8fe9304dabeefbdd61::tcoin_facuet::TCOIN_FACUET>(arg0) > arg4, 2);
        assert!(arg4 <= 0x2::balance::value<0xa01e1513bc26c4bc087876be4e6d707fcdddbfaa197b3b8fe9304dabeefbdd61::tcoin_facuet::TCOIN_FACUET>(&arg1.amount), 1);
        let v0 = 0x2::random::new_generator(arg3, arg5);
        if (0x2::random::generate_bool(&mut v0) == arg2) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xa01e1513bc26c4bc087876be4e6d707fcdddbfaa197b3b8fe9304dabeefbdd61::tcoin_facuet::TCOIN_FACUET>>(0x2::coin::from_balance<0xa01e1513bc26c4bc087876be4e6d707fcdddbfaa197b3b8fe9304dabeefbdd61::tcoin_facuet::TCOIN_FACUET>(0x2::balance::split<0xa01e1513bc26c4bc087876be4e6d707fcdddbfaa197b3b8fe9304dabeefbdd61::tcoin_facuet::TCOIN_FACUET>(&mut arg1.amount, arg4), arg5), 0x2::tx_context::sender(arg5));
        } else {
            0x2::balance::join<0xa01e1513bc26c4bc087876be4e6d707fcdddbfaa197b3b8fe9304dabeefbdd61::tcoin_facuet::TCOIN_FACUET>(&mut arg1.amount, 0x2::coin::into_balance<0xa01e1513bc26c4bc087876be4e6d707fcdddbfaa197b3b8fe9304dabeefbdd61::tcoin_facuet::TCOIN_FACUET>(0x2::coin::split<0xa01e1513bc26c4bc087876be4e6d707fcdddbfaa197b3b8fe9304dabeefbdd61::tcoin_facuet::TCOIN_FACUET>(arg0, arg4, arg5)));
        };
    }

    // decompiled from Move bytecode v6
}

