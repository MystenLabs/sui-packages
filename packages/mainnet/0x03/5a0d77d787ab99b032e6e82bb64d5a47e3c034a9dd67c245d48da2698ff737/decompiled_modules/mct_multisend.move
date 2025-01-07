module 0x35a0d77d787ab99b032e6e82bb64d5a47e3c034a9dd67c245d48da2698ff737::mct_multisend {
    struct Config has store, key {
        id: 0x2::object::UID,
        tips: u64,
        receiver: address,
    }

    struct MctOwner has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MctOwner{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<MctOwner>(v0, 0x2::tx_context::sender(arg0));
        let v1 = Config{
            id       : 0x2::object::new(arg0),
            tips     : 1,
            receiver : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<Config>(v1);
    }

    entry fun multisendWithSamePrice<T0>(arg0: &Config, arg1: u64, arg2: 0x2::coin::Coin<T0>, arg3: vector<address>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<address>(&mut arg3);
        assert!(v0 >= 1, 1);
        assert!(0x2::coin::value<T0>(&mut arg2) == v0 * arg1 + arg0.tips, 0);
        let v1 = 0;
        while (v1 < v0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg2, arg1, arg4), 0x1::vector::pop_back<address>(&mut arg3));
            v1 = v1 + 1;
        };
        if (arg0.tips > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg2, arg0.tips, arg4), arg0.receiver);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, 0x2::tx_context::sender(arg4));
        0x1::vector::destroy_empty<address>(arg3);
    }

    entry fun send<T0>(arg0: &Config, arg1: 0x2::coin::Coin<T0>, arg2: vector<address>, arg3: vector<u64>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<address>(&mut arg2);
        assert!(0x1::vector::length<u64>(&mut arg3) == v0, 3);
        let v1 = 0;
        let v2 = 0;
        while (v2 < v0) {
            v1 = v1 + *0x1::vector::borrow<u64>(&mut arg3, v2);
            v2 = v2 + 1;
        };
        assert!(v0 >= 1, 1);
        assert!(0x2::coin::value<T0>(&mut arg1) == v1 + arg0.tips, 0);
        let v3 = 0;
        while (v3 < v0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg1, 0x1::vector::pop_back<u64>(&mut arg3), arg4), 0x1::vector::pop_back<address>(&mut arg2));
            v3 = v3 + 1;
        };
        if (arg0.tips > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg1, arg0.tips, arg4), arg0.receiver);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, 0x2::tx_context::sender(arg4));
        0x1::vector::destroy_empty<address>(arg2);
        0x1::vector::destroy_empty<u64>(arg3);
    }

    entry fun setTips(arg0: &MctOwner, arg1: &mut Config, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.tips = arg2;
    }

    entry fun setTipsReceiver(arg0: &MctOwner, arg1: &mut Config, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.receiver = arg2;
    }

    entry fun transferOwnerShip(arg0: MctOwner, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::transfer<MctOwner>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

