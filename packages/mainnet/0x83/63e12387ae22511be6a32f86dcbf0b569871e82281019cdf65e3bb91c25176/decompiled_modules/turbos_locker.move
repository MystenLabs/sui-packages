module 0x3ce089d052c4b906aaf17d2b3ba97e5ad3d6a6d4c85bc53f74447d6d18bfb73e::turbos_locker {
    struct Locker has store, key {
        id: 0x2::object::UID,
        position_nft: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT,
        burned: u64,
        claimed: u64,
    }

    struct LockerCap has store, key {
        id: 0x2::object::UID,
        locker: 0x2::object::ID,
        pool: 0x2::object::ID,
    }

    public fun burned(arg0: &Locker) : u64 {
        arg0.burned
    }

    public fun claim_double_fees<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg2: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg3: &mut Locker, arg4: &LockerCap, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert!(0x2::object::id<Locker>(arg3) == arg4.locker, 9223372466351505407);
        let (v0, v1) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::collect_with_return_<T0, T1, T2>(arg0, arg1, &mut arg3.position_nft, 18446744073709551615, 18446744073709551615, 0x2::tx_context::sender(arg6), 18446744073709551615, arg5, arg2, arg6);
        let v2 = v1;
        arg3.claimed = arg3.claimed + 0x2::coin::value<T1>(&v2);
        (v0, v2)
    }

    public fun claim_fees<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg2: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg3: &mut Locker, arg4: &LockerCap, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(0x2::object::id<Locker>(arg3) == arg4.locker, 9223372328912551935);
        let (v0, v1) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::collect_with_return_<T0, T1, T2>(arg0, arg1, &mut arg3.position_nft, 18446744073709551615, 18446744073709551615, 0x2::tx_context::sender(arg6), 18446744073709551615, arg5, arg2, arg6);
        let v2 = v1;
        let v3 = v0;
        arg3.burned = arg3.burned + 0x2::coin::value<T0>(&v3);
        arg3.claimed = arg3.claimed + 0x2::coin::value<T1>(&v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, @0x0);
        v2
    }

    public fun claimed(arg0: &Locker) : u64 {
        arg0.claimed
    }

    public fun create_locker<T0, T1, T2>(arg0: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT, arg2: &mut 0x2::tx_context::TxContext) : LockerCap {
        assert!(0x1::type_name::get<T1>() == 0x1::type_name::get<0x2::sui::SUI>(), 9223372200063533055);
        assert!(0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(arg0) == 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::pool_id(&arg1), 9223372204358500351);
        let v0 = Locker{
            id           : 0x2::object::new(arg2),
            position_nft : arg1,
            burned       : 0,
            claimed      : 0,
        };
        let v1 = LockerCap{
            id     : 0x2::object::new(arg2),
            locker : 0x2::object::id<Locker>(&v0),
            pool   : 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(arg0),
        };
        0x2::transfer::public_share_object<Locker>(v0);
        v1
    }

    public fun position_nft(arg0: &Locker) : &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT {
        &arg0.position_nft
    }

    // decompiled from Move bytecode v6
}

