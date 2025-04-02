module 0x59fd45fc62f04c52a9110423f036fa1c6b604f85580d89a81852a6e795443ce6::faucet {
    struct FaucetPool has store, key {
        id: 0x2::object::UID,
        coin: 0x2::balance::Balance<0x2::sui::SUI>,
        amount: u64,
        claim: 0x2::table::Table<address, u64>,
        admin: address,
        passcode_hash: vector<u8>,
    }

    struct ClaimEvent has copy, drop {
        recipient: address,
        amount: u64,
        timestamp: u64,
    }

    public entry fun add_funds(arg0: &mut FaucetPool, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.coin, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
    }

    public fun can_claim(arg0: &FaucetPool, arg1: address, arg2: &0x2::clock::Clock) : bool {
        if (!0x2::table::contains<address, u64>(&arg0.claim, arg1)) {
            return true
        };
        0x2::clock::timestamp_ms(arg2) >= *0x2::table::borrow<address, u64>(&arg0.claim, arg1) + 86400000
    }

    public entry fun create_faucet(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > 0, 4);
        let v0 = FaucetPool{
            id            : 0x2::object::new(arg3),
            coin          : 0x2::coin::into_balance<0x2::sui::SUI>(arg0),
            amount        : arg1,
            claim         : 0x2::table::new<address, u64>(arg3),
            admin         : 0x2::tx_context::sender(arg3),
            passcode_hash : 0x2::hash::keccak256(&arg2),
        };
        0x2::transfer::share_object<FaucetPool>(v0);
    }

    public entry fun deposit_sui(arg0: &mut FaucetPool, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) > 0, 4);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.coin, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
    }

    public entry fun request_sui(arg0: address, arg1: &mut FaucetPool, arg2: &0x2::clock::Clock, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::hash::keccak256(&arg3) == arg1.passcode_hash, 5);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        if (0x2::table::contains<address, u64>(&arg1.claim, arg0)) {
            assert!(v0 >= *0x2::table::borrow<address, u64>(&arg1.claim, arg0) + 86400000, 2);
        };
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg1.coin) >= arg1.amount, 3);
        if (0x2::table::contains<address, u64>(&arg1.claim, arg0)) {
            *0x2::table::borrow_mut<address, u64>(&mut arg1.claim, arg0) = v0;
        } else {
            0x2::table::add<address, u64>(&mut arg1.claim, arg0, v0);
        };
        let v1 = ClaimEvent{
            recipient : arg0,
            amount    : arg1.amount,
            timestamp : v0,
        };
        0x2::event::emit<ClaimEvent>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.coin, arg1.amount), arg4), arg0);
    }

    public entry fun set_amount(arg0: &mut FaucetPool, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 1);
        assert!(arg1 > 0, 4);
        arg0.amount = arg1;
    }

    public entry fun withdraw(arg0: &mut FaucetPool, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 1);
        assert!(arg1 > 0, 4);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.coin) >= arg1, 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.coin, arg1), arg2), arg0.admin);
    }

    // decompiled from Move bytecode v6
}

