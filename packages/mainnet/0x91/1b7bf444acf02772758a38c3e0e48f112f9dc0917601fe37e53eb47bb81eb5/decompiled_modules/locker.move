module 0x911b7bf444acf02772758a38c3e0e48f112f9dc0917601fe37e53eb47bb81eb5::locker {
    struct Locker has key {
        id: 0x2::object::UID,
        position_nft: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT,
        pool_id: 0x2::object::ID,
        dev_recipient: address,
        team_recipient: address,
        dev_bps: u64,
        team_bps: u64,
    }

    struct LockerCreated has copy, drop {
        locker_id: 0x2::object::ID,
        position_nft_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        dev_recipient: address,
        team_recipient: address,
        dev_bps: u64,
        team_bps: u64,
    }

    struct FeesSplit has copy, drop {
        locker_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        dev_recipient: address,
        team_recipient: address,
        amount_a: u64,
        amount_b: u64,
        dev_amount_a: u64,
        dev_amount_b: u64,
        team_amount_a: u64,
        team_amount_b: u64,
    }

    public fun collect_and_split<T0, T1, T2>(arg0: &mut Locker, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(arg1) == arg0.pool_id, 2);
        let (v0, v1) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::collect_with_return_<T0, T1, T2>(arg1, arg2, &mut arg0.position_nft, arg3, arg4, 0x2::tx_context::sender(arg8), arg5, arg6, arg7, arg8);
        let v2 = v1;
        let v3 = v0;
        let v4 = 0x2::coin::value<T0>(&v3);
        let v5 = 0x2::coin::value<T1>(&v2);
        let v6 = dev_share(v4, arg0.dev_bps);
        let v7 = dev_share(v5, arg0.dev_bps);
        split_and_transfer<T0>(v3, arg0.dev_recipient, arg0.team_recipient, v6, arg8);
        split_and_transfer<T1>(v2, arg0.dev_recipient, arg0.team_recipient, v7, arg8);
        let v8 = FeesSplit{
            locker_id      : 0x2::object::id<Locker>(arg0),
            pool_id        : arg0.pool_id,
            dev_recipient  : arg0.dev_recipient,
            team_recipient : arg0.team_recipient,
            amount_a       : v4,
            amount_b       : v5,
            dev_amount_a   : v6,
            dev_amount_b   : v7,
            team_amount_a  : v4 - v6,
            team_amount_b  : v5 - v7,
        };
        0x2::event::emit<FeesSplit>(v8);
    }

    public fun create_and_share_locker(arg0: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT, arg1: address, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 <= 10000, 1);
        let v0 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::pool_id(&arg0);
        let v1 = 10000 - arg3;
        let v2 = Locker{
            id             : 0x2::object::new(arg4),
            position_nft   : arg0,
            pool_id        : v0,
            dev_recipient  : arg1,
            team_recipient : arg2,
            dev_bps        : arg3,
            team_bps       : v1,
        };
        let v3 = LockerCreated{
            locker_id       : 0x2::object::id<Locker>(&v2),
            position_nft_id : 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(&arg0),
            pool_id         : v0,
            dev_recipient   : arg1,
            team_recipient  : arg2,
            dev_bps         : arg3,
            team_bps        : v1,
        };
        0x2::event::emit<LockerCreated>(v3);
        0x2::transfer::share_object<Locker>(v2);
    }

    public fun dev_bps(arg0: &Locker) : u64 {
        arg0.dev_bps
    }

    public fun dev_recipient(arg0: &Locker) : address {
        arg0.dev_recipient
    }

    fun dev_share(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (10000 as u128)) as u64)
    }

    public fun pool_id(arg0: &Locker) : 0x2::object::ID {
        arg0.pool_id
    }

    public fun position_nft_id(arg0: &Locker) : 0x2::object::ID {
        0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(&arg0.position_nft)
    }

    fun split_and_transfer<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg0);
        if (v0 == 0) {
            0x2::coin::destroy_zero<T0>(arg0);
        } else if (arg3 == 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg2);
        } else if (arg3 == v0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg1);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg0, arg3, arg4), arg1);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg2);
        };
    }

    public fun team_bps(arg0: &Locker) : u64 {
        arg0.team_bps
    }

    public fun team_recipient(arg0: &Locker) : address {
        arg0.team_recipient
    }

    // decompiled from Move bytecode v7
}

