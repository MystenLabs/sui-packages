module 0x2dafd0ae920ffa0644d640317bd9c56afb42bdf0f2f92807ce12a995a00f192e::liq_resize {
    public fun flagged(arg0: &mut 0xfbca715d01aa8698251ea1fd8452cb5a8a4d919f1733dc705acd57b53331193c::liq_book::LiqBook, arg1: u64, arg2: u128, arg3: u64) : bool {
        let v0 = 0xfbca715d01aa8698251ea1fd8452cb5a8a4d919f1733dc705acd57b53331193c::liq_book::liq_since(arg0, arg1);
        if (0x1::option::is_none<u64>(&v0)) {
            return false
        };
        0xfbca715d01aa8698251ea1fd8452cb5a8a4d919f1733dc705acd57b53331193c::liq_book::observe(arg0, arg2, arg3);
        0xfbca715d01aa8698251ea1fd8452cb5a8a4d919f1733dc705acd57b53331193c::liq_book::flag_live(arg0, arg1)
    }

    fun like(arg0: &0xfbca715d01aa8698251ea1fd8452cb5a8a4d919f1733dc705acd57b53331193c::liq_book::LiqRecord, arg1: u64, arg2: u64, arg3: u64) : 0xfbca715d01aa8698251ea1fd8452cb5a8a4d919f1733dc705acd57b53331193c::liq_book::LiqRecord {
        0xfbca715d01aa8698251ea1fd8452cb5a8a4d919f1733dc705acd57b53331193c::liq_book::record(0xfbca715d01aa8698251ea1fd8452cb5a8a4d919f1733dc705acd57b53331193c::liq_book::r_account_id(arg0), 0xfbca715d01aa8698251ea1fd8452cb5a8a4d919f1733dc705acd57b53331193c::liq_book::r_owner(arg0), 0xfbca715d01aa8698251ea1fd8452cb5a8a4d919f1733dc705acd57b53331193c::liq_book::r_is_long(arg0), arg1, arg2, arg3, 0xfbca715d01aa8698251ea1fd8452cb5a8a4d919f1733dc705acd57b53331193c::liq_book::r_entry(arg0), 0xfbca715d01aa8698251ea1fd8452cb5a8a4d919f1733dc705acd57b53331193c::liq_book::r_bust(arg0), 0xfbca715d01aa8698251ea1fd8452cb5a8a4d919f1733dc705acd57b53331193c::liq_book::r_oracle_ts(arg0), 0xfbca715d01aa8698251ea1fd8452cb5a8a4d919f1733dc705acd57b53331193c::liq_book::r_oracle_sequence(arg0), 0xfbca715d01aa8698251ea1fd8452cb5a8a4d919f1733dc705acd57b53331193c::liq_book::r_wash(arg0))
    }

    public fun resize(arg0: &mut 0xfbca715d01aa8698251ea1fd8452cb5a8a4d919f1733dc705acd57b53331193c::liq_book::LiqBook, arg1: u64, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = *0xfbca715d01aa8698251ea1fd8452cb5a8a4d919f1733dc705acd57b53331193c::liq_book::borrow_record(arg0, arg1);
        0xfbca715d01aa8698251ea1fd8452cb5a8a4d919f1733dc705acd57b53331193c::liq_book::insert(arg0, 18446744073709551615, like(&v0, 0, 1, 0));
        0xfbca715d01aa8698251ea1fd8452cb5a8a4d919f1733dc705acd57b53331193c::liq_book::remove(arg0, arg1);
        0xfbca715d01aa8698251ea1fd8452cb5a8a4d919f1733dc705acd57b53331193c::liq_book::insert(arg0, arg1, like(&v0, arg2, arg3, arg4));
        0xfbca715d01aa8698251ea1fd8452cb5a8a4d919f1733dc705acd57b53331193c::liq_book::remove(arg0, 18446744073709551615);
    }

    // decompiled from Move bytecode v7
}

