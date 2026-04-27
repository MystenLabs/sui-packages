module 0x529e9c233a7f2f6cc5bcd8371735cba8e44d80a1d30c8bd0a29ea4b4be4d4b54::pool {
    struct Pool has key {
        id: 0x2::object::UID,
        name: vector<u8>,
        entry_fee: u64,
        balance: u64,
        dev_fee_percentage: u8,
        dev_wallet: address,
        players: vector<address>,
        is_active: bool,
    }

    public entry fun close_pool(arg0: &mut Pool) {
        arg0.is_active = false;
    }

    public entry fun create_pool(arg0: vector<u8>, arg1: u64, arg2: u8, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = Pool{
            id                 : 0x2::object::new(arg4),
            name               : arg0,
            entry_fee          : arg1,
            balance            : 0,
            dev_fee_percentage : arg2,
            dev_wallet         : arg3,
            players            : 0x1::vector::empty<address>(),
            is_active          : true,
        };
        0x2::transfer::share_object<Pool>(v0);
    }

    public fun get_balance(arg0: &Pool) : u64 {
        arg0.balance
    }

    public fun get_players(arg0: &Pool) : vector<address> {
        arg0.players
    }

    public fun get_pool_info(arg0: &Pool) : (vector<u8>, u64, u64, u8, address, bool, u64) {
        (arg0.name, arg0.entry_fee, arg0.balance, arg0.dev_fee_percentage, arg0.dev_wallet, arg0.is_active, 0x1::vector::length<address>(&arg0.players))
    }

    public entry fun join_pool(arg0: &mut Pool, arg1: address) {
        assert!(arg0.is_active, 0);
        if (!0x1::vector::contains<address>(&arg0.players, &arg1)) {
            0x1::vector::push_back<address>(&mut arg0.players, arg1);
        };
    }

    // decompiled from Move bytecode v7
}

