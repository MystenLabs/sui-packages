module 0xf30d0c3374b6bbad80739650900abb4d553b256636ccd86e90e4a87d4e913ffb::kyuzotoken {
    struct Locker has store, key {
        id: 0x2::object::UID,
        cliff_date: u64,
        vesting_duration: u64,
        vesting_amount: u64,
        last_withdraw_date: u64,
        current_balance: 0x2::balance::Balance<KYUZOTOKEN>,
    }

    struct KYUZOTOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: KYUZOTOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KYUZOTOKEN>(arg0, 9, b"KYC", b"Kyuzo's Coin", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://home-page-cdn.kyuzosfriends.com/images/icon/KO_LOGO.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KYUZOTOKEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KYUZOTOKEN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun locked_mint(arg0: &mut 0x2::coin::TreasuryCap<KYUZOTOKEN>, arg1: address, arg2: address, arg3: address, arg4: address, arg5: address, arg6: address, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg8);
        let v1 = v0 + 6 * 120000;
        let v2 = Locker{
            id                 : 0x2::object::new(arg9),
            cliff_date         : v1,
            vesting_duration   : 36,
            vesting_amount     : 4166666,
            last_withdraw_date : v1,
            current_balance    : 0x2::coin::into_balance<KYUZOTOKEN>(0x2::coin::mint<KYUZOTOKEN>(arg0, arg7 * 15 / 100, arg9)),
        };
        0x2::transfer::public_transfer<Locker>(v2, arg1);
        let v3 = v0 + 6 * 120000;
        let v4 = Locker{
            id                 : 0x2::object::new(arg9),
            cliff_date         : v3,
            vesting_duration   : 20,
            vesting_amount     : 5000000,
            last_withdraw_date : v3,
            current_balance    : 0x2::coin::into_balance<KYUZOTOKEN>(0x2::coin::mint<KYUZOTOKEN>(arg0, arg7 * 10 / 100, arg9)),
        };
        0x2::transfer::public_transfer<Locker>(v4, arg2);
        let v5 = 0x2::coin::into_balance<KYUZOTOKEN>(0x2::coin::mint<KYUZOTOKEN>(arg0, arg7 * 30 / 100, arg9));
        0x2::transfer::public_transfer<0x2::coin::Coin<KYUZOTOKEN>>(0x2::coin::take<KYUZOTOKEN>(&mut v5, 45000000 * 1000000000, arg9), arg3);
        let v6 = Locker{
            id                 : 0x2::object::new(arg9),
            cliff_date         : v0,
            vesting_duration   : 36,
            vesting_amount     : 7083333,
            last_withdraw_date : v0,
            current_balance    : v5,
        };
        0x2::transfer::public_transfer<Locker>(v6, arg3);
        let v7 = 0x2::coin::into_balance<KYUZOTOKEN>(0x2::coin::mint<KYUZOTOKEN>(arg0, arg7 * 30 / 100, arg9));
        0x2::transfer::public_transfer<0x2::coin::Coin<KYUZOTOKEN>>(0x2::coin::take<KYUZOTOKEN>(&mut v7, 102500000 * 1000000000, arg9), arg4);
        let v8 = Locker{
            id                 : 0x2::object::new(arg9),
            cliff_date         : v0,
            vesting_duration   : 36,
            vesting_amount     : 5486111,
            last_withdraw_date : v0,
            current_balance    : v7,
        };
        0x2::transfer::public_transfer<Locker>(v8, arg4);
        0x2::coin::mint_and_transfer<KYUZOTOKEN>(arg0, arg7 * 5 / 100, arg5, arg9);
        let v9 = 0x2::coin::into_balance<KYUZOTOKEN>(0x2::coin::mint<KYUZOTOKEN>(arg0, arg7 * 10 / 100, arg9));
        0x2::transfer::public_transfer<0x2::coin::Coin<KYUZOTOKEN>>(0x2::coin::take<KYUZOTOKEN>(&mut v9, 20000000 * 1000000000, arg9), arg6);
        let v10 = Locker{
            id                 : 0x2::object::new(arg9),
            cliff_date         : v0,
            vesting_duration   : 36,
            vesting_amount     : 2222222,
            last_withdraw_date : v0,
            current_balance    : v9,
        };
        0x2::transfer::public_transfer<Locker>(v10, arg6);
        assert!(0x2::coin::total_supply<KYUZOTOKEN>(arg0) <= 1000000000000000, 5555);
    }

    public fun withdraw_vested(arg0: &mut Locker, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(v0 > arg0.cliff_date, 1);
        assert!(v0 > arg0.last_withdraw_date, 2);
        let v1 = if (0x2::balance::value<KYUZOTOKEN>(&arg0.current_balance) < arg0.vesting_amount * 2) {
            0x2::balance::value<KYUZOTOKEN>(&arg0.current_balance)
        } else {
            (v0 - arg0.last_withdraw_date) / 120000 * arg0.vesting_amount
        };
        assert!(v1 > 0, 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<KYUZOTOKEN>>(0x2::coin::take<KYUZOTOKEN>(&mut arg0.current_balance, v1, arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

