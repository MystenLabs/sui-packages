module 0x697807e89307c7124aeb5847e817fbb49c7701e4f5b03f1d38a91bdee3e3f66::wwal_rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    fun err_lst_amount_is_none() {
        abort 0
    }

    fun mul_and_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    public fun update_price(arg0: &mut 0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::BucketOracle, arg1: &mut 0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_protocol::BlizzardStaking<0xb1b0650a8862e30e3f604fd6c5838bc25464b8d3d827fbd58af7cb9685b832bf::wwal::WWAL>, arg2: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg3: &0x2::clock::Clock) {
        let (v0, v1) = 0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::get_price<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(arg0, arg3);
        let v2 = 0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_protocol::to_lst_at_epoch<0xb1b0650a8862e30e3f604fd6c5838bc25464b8d3d827fbd58af7cb9685b832bf::wwal::WWAL>(arg1, 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::epoch(arg2), 1000000000, false);
        if (0x1::option::is_none<u64>(&v2)) {
            err_lst_amount_is_none();
        };
        let v3 = 0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::borrow_single_oracle_mut<0xb1b0650a8862e30e3f604fd6c5838bc25464b8d3d827fbd58af7cb9685b832bf::wwal::WWAL>(arg0);
        let v4 = Rule{dummy_field: false};
        0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::single_oracle::update_oracle_price_with_rule<0xb1b0650a8862e30e3f604fd6c5838bc25464b8d3d827fbd58af7cb9685b832bf::wwal::WWAL, Rule>(v3, v4, arg3, mul_and_div(mul_and_div(v0, mul_and_div(1000000000, 1000000, 0x1::option::destroy_some<u64>(v2)), 1000000), 0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::single_oracle::precision<0xb1b0650a8862e30e3f604fd6c5838bc25464b8d3d827fbd58af7cb9685b832bf::wwal::WWAL>(v3), v1));
    }

    // decompiled from Move bytecode v6
}

