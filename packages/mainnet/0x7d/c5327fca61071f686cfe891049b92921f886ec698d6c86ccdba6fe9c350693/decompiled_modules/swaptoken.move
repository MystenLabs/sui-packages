module 0x7dc5327fca61071f686cfe891049b92921f886ec698d6c86ccdba6fe9c350693::swaptoken {
    struct Pool_A_B has store, key {
        id: 0x2::object::UID,
        coin_A: 0x2::balance::Balance<0x7dc5327fca61071f686cfe891049b92921f886ec698d6c86ccdba6fe9c350693::swapFaucetA::SWAPFAUCETA>,
        coin_B: 0x2::balance::Balance<0x7dc5327fca61071f686cfe891049b92921f886ec698d6c86ccdba6fe9c350693::swapFaucetB::SWAPFAUCETB>,
        stakers: 0x2::linked_table::LinkedTable<address, u64>,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    public entry fun deposit(arg0: &mut Pool_A_B, arg1: 0x2::coin::Coin<0x7dc5327fca61071f686cfe891049b92921f886ec698d6c86ccdba6fe9c350693::swapFaucetA::SWAPFAUCETA>, arg2: 0x2::coin::Coin<0x7dc5327fca61071f686cfe891049b92921f886ec698d6c86ccdba6fe9c350693::swapFaucetB::SWAPFAUCETB>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::coin::value<0x7dc5327fca61071f686cfe891049b92921f886ec698d6c86ccdba6fe9c350693::swapFaucetA::SWAPFAUCETA>(&arg1);
        assert!(v1 == 0x2::coin::value<0x7dc5327fca61071f686cfe891049b92921f886ec698d6c86ccdba6fe9c350693::swapFaucetB::SWAPFAUCETB>(&arg2), 9223372212948434943);
        if (!0x2::linked_table::contains<address, u64>(&arg0.stakers, v0)) {
            0x2::linked_table::push_back<address, u64>(&mut arg0.stakers, v0, 0);
        };
        let v2 = 0x2::linked_table::borrow_mut<address, u64>(&mut arg0.stakers, v0);
        *v2 = *v2 + v1;
        0x2::balance::join<0x7dc5327fca61071f686cfe891049b92921f886ec698d6c86ccdba6fe9c350693::swapFaucetA::SWAPFAUCETA>(&mut arg0.coin_A, 0x2::coin::into_balance<0x7dc5327fca61071f686cfe891049b92921f886ec698d6c86ccdba6fe9c350693::swapFaucetA::SWAPFAUCETA>(arg1));
        0x2::balance::join<0x7dc5327fca61071f686cfe891049b92921f886ec698d6c86ccdba6fe9c350693::swapFaucetB::SWAPFAUCETB>(&mut arg0.coin_B, 0x2::coin::into_balance<0x7dc5327fca61071f686cfe891049b92921f886ec698d6c86ccdba6fe9c350693::swapFaucetB::SWAPFAUCETB>(arg2));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = Pool_A_B{
            id      : 0x2::object::new(arg0),
            coin_A  : 0x2::balance::zero<0x7dc5327fca61071f686cfe891049b92921f886ec698d6c86ccdba6fe9c350693::swapFaucetA::SWAPFAUCETA>(),
            coin_B  : 0x2::balance::zero<0x7dc5327fca61071f686cfe891049b92921f886ec698d6c86ccdba6fe9c350693::swapFaucetB::SWAPFAUCETB>(),
            stakers : 0x2::linked_table::new<address, u64>(arg0),
        };
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<Pool_A_B>(v1);
    }

    public entry fun swap_A_to_B(arg0: &mut Pool_A_B, arg1: 0x2::coin::Coin<0x7dc5327fca61071f686cfe891049b92921f886ec698d6c86ccdba6fe9c350693::swapFaucetA::SWAPFAUCETA>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x7dc5327fca61071f686cfe891049b92921f886ec698d6c86ccdba6fe9c350693::swapFaucetA::SWAPFAUCETA>(&arg1);
        assert!(0x2::balance::value<0x7dc5327fca61071f686cfe891049b92921f886ec698d6c86ccdba6fe9c350693::swapFaucetB::SWAPFAUCETB>(&arg0.coin_B) >= v0 && v0 > 100000, 9223372371862224895);
        0x2::balance::join<0x7dc5327fca61071f686cfe891049b92921f886ec698d6c86ccdba6fe9c350693::swapFaucetA::SWAPFAUCETA>(&mut arg0.coin_A, 0x2::coin::into_balance<0x7dc5327fca61071f686cfe891049b92921f886ec698d6c86ccdba6fe9c350693::swapFaucetA::SWAPFAUCETA>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x7dc5327fca61071f686cfe891049b92921f886ec698d6c86ccdba6fe9c350693::swapFaucetB::SWAPFAUCETB>>(0x2::coin::from_balance<0x7dc5327fca61071f686cfe891049b92921f886ec698d6c86ccdba6fe9c350693::swapFaucetB::SWAPFAUCETB>(0x2::balance::split<0x7dc5327fca61071f686cfe891049b92921f886ec698d6c86ccdba6fe9c350693::swapFaucetB::SWAPFAUCETB>(&mut arg0.coin_B, v0), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun swap_B_to_A(arg0: &mut Pool_A_B, arg1: 0x2::coin::Coin<0x7dc5327fca61071f686cfe891049b92921f886ec698d6c86ccdba6fe9c350693::swapFaucetB::SWAPFAUCETB>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x7dc5327fca61071f686cfe891049b92921f886ec698d6c86ccdba6fe9c350693::swapFaucetB::SWAPFAUCETB>(&arg1);
        assert!(0x2::balance::value<0x7dc5327fca61071f686cfe891049b92921f886ec698d6c86ccdba6fe9c350693::swapFaucetA::SWAPFAUCETA>(&arg0.coin_A) >= v0 && v0 > 100000, 9223372427696799743);
        0x2::balance::join<0x7dc5327fca61071f686cfe891049b92921f886ec698d6c86ccdba6fe9c350693::swapFaucetB::SWAPFAUCETB>(&mut arg0.coin_B, 0x2::coin::into_balance<0x7dc5327fca61071f686cfe891049b92921f886ec698d6c86ccdba6fe9c350693::swapFaucetB::SWAPFAUCETB>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x7dc5327fca61071f686cfe891049b92921f886ec698d6c86ccdba6fe9c350693::swapFaucetA::SWAPFAUCETA>>(0x2::coin::from_balance<0x7dc5327fca61071f686cfe891049b92921f886ec698d6c86ccdba6fe9c350693::swapFaucetA::SWAPFAUCETA>(0x2::balance::split<0x7dc5327fca61071f686cfe891049b92921f886ec698d6c86ccdba6fe9c350693::swapFaucetA::SWAPFAUCETA>(&mut arg0.coin_A, v0), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun withdraw(arg0: &mut Pool_A_B, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x2::linked_table::contains<address, u64>(&arg0.stakers, v0), 9223372294552813567);
        let v1 = *0x2::linked_table::borrow_mut<address, u64>(&mut arg0.stakers, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x7dc5327fca61071f686cfe891049b92921f886ec698d6c86ccdba6fe9c350693::swapFaucetA::SWAPFAUCETA>>(0x2::coin::from_balance<0x7dc5327fca61071f686cfe891049b92921f886ec698d6c86ccdba6fe9c350693::swapFaucetA::SWAPFAUCETA>(0x2::balance::split<0x7dc5327fca61071f686cfe891049b92921f886ec698d6c86ccdba6fe9c350693::swapFaucetA::SWAPFAUCETA>(&mut arg0.coin_A, v1), arg1), v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x7dc5327fca61071f686cfe891049b92921f886ec698d6c86ccdba6fe9c350693::swapFaucetB::SWAPFAUCETB>>(0x2::coin::from_balance<0x7dc5327fca61071f686cfe891049b92921f886ec698d6c86ccdba6fe9c350693::swapFaucetB::SWAPFAUCETB>(0x2::balance::split<0x7dc5327fca61071f686cfe891049b92921f886ec698d6c86ccdba6fe9c350693::swapFaucetB::SWAPFAUCETB>(&mut arg0.coin_B, v1), arg1), v0);
        0x2::linked_table::remove<address, u64>(&mut arg0.stakers, v0);
    }

    // decompiled from Move bytecode v6
}

