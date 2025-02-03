module 0x6c42b435f4963a617f25d2b4630f3c2162d910d6c2f14dd0f440f8ad83a2f52f::linear_vesting_airdrop {
    struct Airdrop<phantom T0> has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        root: vector<u8>,
        start: u64,
        duration: u64,
        map: 0x6c42b435f4963a617f25d2b4630f3c2162d910d6c2f14dd0f440f8ad83a2f52f::bitmap::Bitmap,
    }

    public fun balance<T0>(arg0: &Airdrop<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun destroy_zero<T0>(arg0: Airdrop<T0>) {
        let Airdrop {
            id       : v0,
            balance  : v1,
            root     : _,
            start    : _,
            duration : _,
            map      : v5,
        } = arg0;
        0x2::object::delete(v0);
        0x2::balance::destroy_zero<T0>(v1);
        0x6c42b435f4963a617f25d2b4630f3c2162d910d6c2f14dd0f440f8ad83a2f52f::bitmap::destroy(v5);
    }

    public fun new<T0>(arg0: 0x2::coin::Coin<T0>, arg1: vector<u8>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : Airdrop<T0> {
        assert!(!0x1::vector::is_empty<u8>(&arg1), 1);
        assert!(arg2 > 0x2::clock::timestamp_ms(arg4), 2);
        Airdrop<T0>{
            id       : 0x2::object::new(arg5),
            balance  : 0x2::coin::into_balance<T0>(arg0),
            root     : arg1,
            start    : arg2,
            duration : arg3,
            map      : 0x6c42b435f4963a617f25d2b4630f3c2162d910d6c2f14dd0f440f8ad83a2f52f::bitmap::new(arg5),
        }
    }

    public fun borrow_map<T0>(arg0: &Airdrop<T0>) : &0x6c42b435f4963a617f25d2b4630f3c2162d910d6c2f14dd0f440f8ad83a2f52f::bitmap::Bitmap {
        &arg0.map
    }

    public fun duration<T0>(arg0: &Airdrop<T0>) : u64 {
        arg0.start
    }

    public fun get_airdrop<T0>(arg0: &mut Airdrop<T0>, arg1: vector<vector<u8>>, arg2: &0x2::clock::Clock, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x6c42b435f4963a617f25d2b4630f3c2162d910d6c2f14dd0f440f8ad83a2f52f::linear_vesting_wallet::Wallet<T0> {
        assert!(!0x1::vector::is_empty<vector<u8>>(&arg1), 3);
        let v0 = 0x6c42b435f4963a617f25d2b4630f3c2162d910d6c2f14dd0f440f8ad83a2f52f::airdrop_utils::verify(arg0.root, arg1, arg3, 0x2::tx_context::sender(arg4));
        assert!(!0x6c42b435f4963a617f25d2b4630f3c2162d910d6c2f14dd0f440f8ad83a2f52f::bitmap::get(&arg0.map, v0), 0);
        0x6c42b435f4963a617f25d2b4630f3c2162d910d6c2f14dd0f440f8ad83a2f52f::bitmap::set(&mut arg0.map, v0);
        0x6c42b435f4963a617f25d2b4630f3c2162d910d6c2f14dd0f440f8ad83a2f52f::linear_vesting_wallet::new<T0>(0x2::coin::take<T0>(&mut arg0.balance, arg3, arg4), arg2, arg0.start, arg0.duration, arg4)
    }

    public fun has_account_claimed<T0>(arg0: &Airdrop<T0>, arg1: vector<vector<u8>>, arg2: u64, arg3: address) : bool {
        0x6c42b435f4963a617f25d2b4630f3c2162d910d6c2f14dd0f440f8ad83a2f52f::bitmap::get(&arg0.map, 0x6c42b435f4963a617f25d2b4630f3c2162d910d6c2f14dd0f440f8ad83a2f52f::airdrop_utils::verify(arg0.root, arg1, arg2, arg3))
    }

    public fun root<T0>(arg0: &Airdrop<T0>) : vector<u8> {
        arg0.root
    }

    public fun start<T0>(arg0: &Airdrop<T0>) : u64 {
        arg0.start
    }

    // decompiled from Move bytecode v6
}

