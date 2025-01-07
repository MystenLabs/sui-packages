module 0x656b17f55e5e711b8228fe06c7461a8376b97a8f1c0bb087fe7a5b9e7715803::TEST {
    struct TEST has drop {
        dummy_field: bool,
    }

    struct Lock has store, key {
        id: 0x2::object::UID,
        lock_start: u64,
        lock_end: u64,
        unlock_start: u64,
        unlocked_amount: u64,
        initial_locked_amount: u64,
        is_claimed: bool,
        claimed_time: u64,
        current_lock_balance: 0x2::balance::Balance<TEST>,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<TEST>, arg1: 0x2::coin::Coin<TEST>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<TEST>(&arg1) >= arg2, 2);
        0x2::coin::burn<TEST>(arg0, 0x2::coin::split<TEST>(&mut arg1, arg2, arg3));
        if (0x2::coin::value<TEST>(&arg1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<TEST>>(arg1, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<TEST>(arg1);
        };
    }

    public entry fun claim(arg0: &mut Lock, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        let v1 = v0 - arg0.unlock_start;
        let v2 = v1;
        assert!(v1 > 0, 4);
        assert!(0x2::balance::value<TEST>(&arg0.current_lock_balance) > 0, 7);
        if (arg0.is_claimed) {
            v2 = v0 - arg0.claimed_time;
        };
        let v3 = mul_div(arg0.initial_locked_amount, v2, arg0.lock_end - arg0.unlock_start);
        if (v0 >= arg0.lock_end) {
            v3 = 0x2::balance::value<TEST>(&arg0.current_lock_balance);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<TEST>>(0x2::coin::take<TEST>(&mut arg0.current_lock_balance, v3, arg2), 0x2::tx_context::sender(arg2));
        arg0.unlocked_amount = arg0.unlocked_amount + v3;
        arg0.is_claimed = true;
        arg0.claimed_time = v0;
    }

    fun init(arg0: TEST, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v0, 0x2::url::new_unsafe_from_bytes(b"https://bafybeigdes4m63gim4xcxh3mkisi5voegg4xnjco5recp7o2zr5zmbrofu.ipfs.cf-ipfs.com"));
        let (v1, v2) = 0x2::coin::create_currency<TEST>(arg0, 0, b"TEST", b"TEST", b"The leader of Sui Meme army!", v0, arg1);
        let v3 = v1;
        let v4 = 0x2::tx_context::sender(arg1);
        0x2::coin::mint_and_transfer<TEST>(&mut v3, 2100000000, v4, arg1);
        0x2::coin::mint_and_transfer<TEST>(&mut v3, 7350000000, @0x2e128a31ec578045684fda15a42b909785ac8f999e598b65371f4ba79aa2d964, arg1);
        0x2::coin::mint_and_transfer<TEST>(&mut v3, 10500000000, @0x9bc012bb305781b88907414c735e3db1b580fab9994a97b3cd8fea83d10554bc, arg1);
        0x2::coin::mint_and_transfer<TEST>(&mut v3, 1050000000, @0xc124401b295b1bb0bf23b601a8928ba9a35791c1b0e928f40de928194b59e22f, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TEST>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST>>(v3, v4);
    }

    public entry fun lock(arg0: 0x2::coin::Coin<TEST>, arg1: u64, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg4);
        let v1 = v0 + arg2;
        let v2 = v0 + arg3;
        assert!(v1 > v0, 0);
        assert!(arg1 > 0, 1);
        assert!(arg1 <= 0x2::coin::value<TEST>(&arg0), 2);
        assert!(v2 > v0, 3);
        assert!(v2 < v1, 3);
        let v3 = 0x2::tx_context::sender(arg5);
        let v4 = Lock{
            id                    : 0x2::object::new(arg5),
            lock_start            : v0,
            lock_end              : v1,
            unlock_start          : v2,
            unlocked_amount       : 0,
            initial_locked_amount : arg1,
            is_claimed            : false,
            claimed_time          : 0,
            current_lock_balance  : 0x2::balance::zero<TEST>(),
        };
        0x2::balance::join<TEST>(&mut v4.current_lock_balance, 0x2::coin::into_balance<TEST>(0x2::coin::split<TEST>(&mut arg0, arg1, arg5)));
        0x2::transfer::public_transfer<Lock>(v4, v3);
        if (0x2::coin::value<TEST>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<TEST>>(arg0, v3);
        } else {
            0x2::coin::destroy_zero<TEST>(arg0);
        };
    }

    fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg2 != 0, 5);
        let v0 = (arg0 as u128) * (arg1 as u128) / (arg2 as u128);
        assert!(!(v0 > (18446744073709551615 as u128)), 6);
        (v0 as u64)
    }

    // decompiled from Move bytecode v6
}

