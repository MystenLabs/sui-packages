module 0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::royalty {
    public fun marketplace_fee_bps() : u64 {
        250
    }

    fun distribute_lineage_royalty(arg0: &mut 0x2::coin::Coin<0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::wal::WAL>, arg1: 0x2::object::ID, arg2: u64, arg3: &0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::memory_ext::Lineage, arg4: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::memory_ext::lineage_ancestors(arg3);
        if (0x1::vector::is_empty<address>(&v0)) {
            return 0
        };
        let v1 = take_royalty(arg2, 0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::constants::lineage_pool_bps());
        if (v1 == 0) {
            return 0
        };
        let v2 = 0;
        let v3 = 0;
        while (v3 < 0x1::vector::length<address>(&v0)) {
            let v4 = v1 / (1 << ((v3 + 1) as u8));
            if (v4 > 0 && 0x2::coin::value<0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::wal::WAL>(arg0) >= v4) {
                let v5 = *0x1::vector::borrow<address>(&v0, v3);
                0x2::transfer::public_transfer<0x2::coin::Coin<0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::wal::WAL>>(0x2::coin::split<0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::wal::WAL>(arg0, v4, arg4), v5);
                0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::events::emit_lineage_royalty_paid(arg1, v5, v4, (v3 as u16));
                v2 = v2 + v4;
            };
            v3 = v3 + 1;
        };
        v2
    }

    public fun split_fee_and_royalties(arg0: &mut 0x2::coin::Coin<0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::wal::WAL>, arg1: u64, arg2: 0x2::object::ID, arg3: address, arg4: address, arg5: u16, arg6: 0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::memory_ext::Lineage, arg7: &0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::admin::Config, arg8: &mut 0x2::tx_context::TxContext) : (u64, u64, u64) {
        let v0 = take_fee_with_config(arg7, arg1);
        let v1 = take_royalty(arg1, arg5);
        assert!(0x2::coin::value<0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::wal::WAL>(arg0) >= arg1, 0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::constants::err_price_too_low());
        let v2 = 0x2::coin::split<0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::wal::WAL>(arg0, arg1, arg8);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::wal::WAL>>(0x2::coin::split<0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::wal::WAL>(&mut v2, v0, arg8), arg3);
        };
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::wal::WAL>>(0x2::coin::split<0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::wal::WAL>(&mut v2, v1, arg8), arg3);
        };
        let v3 = &mut v2;
        let v4 = distribute_lineage_royalty(v3, arg2, arg1, &arg6, arg8);
        assert!(v0 + v1 + v4 <= arg1, 0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::constants::err_split_overflow());
        0x2::transfer::public_transfer<0x2::coin::Coin<0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::wal::WAL>>(v2, arg4);
        (v0, v1, v4)
    }

    public fun take_fee(arg0: u64) : u64 {
        arg0 * 250 / 10000
    }

    public fun take_fee_with_config(arg0: &0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::admin::Config, arg1: u64) : u64 {
        arg1 * (0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::admin::marketplace_fee_bps(arg0) as u64) / 0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::constants::bps_denom()
    }

    public fun take_royalty(arg0: u64, arg1: u16) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (10000 as u128)) as u64)
    }

    // decompiled from Move bytecode v7
}

