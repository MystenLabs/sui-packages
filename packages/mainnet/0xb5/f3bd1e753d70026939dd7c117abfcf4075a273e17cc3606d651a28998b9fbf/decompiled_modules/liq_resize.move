module 0xde3c36d56dab5b3f030dd39e4210d5db14a4858858825a5cded1707cf8aaea3::liq_resize {
    public fun flagged(arg0: &mut 0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::liq_book::LiqBook, arg1: u64, arg2: u128, arg3: u64) : bool {
        let v0 = 0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::liq_book::liq_since(arg0, arg1);
        if (0x1::option::is_none<u64>(&v0)) {
            return false
        };
        0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::liq_book::observe(arg0, arg2, arg3);
        0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::liq_book::flag_live(arg0, arg1)
    }

    fun like(arg0: &0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::liq_book::LiqRecord, arg1: u64, arg2: u64, arg3: u64) : 0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::liq_book::LiqRecord {
        0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::liq_book::record(0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::liq_book::r_account_id(arg0), 0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::liq_book::r_owner(arg0), 0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::liq_book::r_is_long(arg0), arg1, arg2, arg3, 0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::liq_book::r_entry(arg0), 0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::liq_book::r_bust(arg0), 0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::liq_book::r_oracle_ts(arg0), 0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::liq_book::r_oracle_sequence(arg0), 0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::liq_book::r_wash(arg0))
    }

    public fun resize(arg0: &mut 0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::liq_book::LiqBook, arg1: u64, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = *0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::liq_book::borrow_record(arg0, arg1);
        0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::liq_book::insert(arg0, 18446744073709551615, like(&v0, 0, 1, 0));
        0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::liq_book::remove(arg0, arg1);
        0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::liq_book::insert(arg0, arg1, like(&v0, arg2, arg3, arg4));
        0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::liq_book::remove(arg0, 18446744073709551615);
    }

    // decompiled from Move bytecode v7
}

