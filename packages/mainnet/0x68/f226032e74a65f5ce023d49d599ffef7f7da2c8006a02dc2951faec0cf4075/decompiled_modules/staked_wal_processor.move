module 0x25645eb8a0f2abb999d0d3ac2d992048f88d97e65d37a33fdb7f14a46d2523e2::staked_wal_processor {
    struct FeeManager has key {
        id: 0x2::object::UID,
        fee_address: address,
        fee_rate: u64,
    }

    struct FeeManagerCap has store, key {
        id: 0x2::object::UID,
    }

    public fun get_fee_address(arg0: &FeeManager) : address {
        arg0.fee_address
    }

    public fun get_fee_rate(arg0: &FeeManager) : u64 {
        arg0.fee_rate
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = FeeManager{
            id          : 0x2::object::new(arg0),
            fee_address : @0x720f16c5ad1327a063b845a69673825109a95c100f6cf1208f002b521f176807,
            fee_rate    : 0,
        };
        let v1 = FeeManagerCap{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<FeeManager>(v0);
        0x2::transfer::transfer<FeeManagerCap>(v1, 0x2::tx_context::sender(arg0));
    }

    entry fun update_fee_address(arg0: &FeeManagerCap, arg1: &mut FeeManager, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.fee_address = arg2;
    }

    entry fun update_fee_rate(arg0: &FeeManagerCap, arg1: &mut FeeManager, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 <= 1000, 0);
        arg1.fee_rate = arg2;
    }

    public fun vector_transfer_staked_wal(arg0: &mut 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staking::Staking, arg1: vector<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::StakedWal>, arg2: address, arg3: &FeeManager, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL> {
        0x1::vector::reverse<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::StakedWal>(&mut arg1);
        let v0 = 0x2::coin::zero<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(arg4);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::StakedWal>(&arg1)) {
            let v2 = 0x1::vector::pop_back<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::StakedWal>(&mut arg1);
            if (0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staking::can_withdraw_staked_wal_early(arg0, &v2)) {
                0x2::coin::join<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&mut v0, 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staking::withdraw_stake(arg0, v2, arg4));
            } else {
                0x2::transfer::public_transfer<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::StakedWal>(v2, arg2);
            };
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staked_wal::StakedWal>(arg1);
        let v3 = 0x2::coin::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&v0);
        if (v3 > 0) {
            let v4 = v3 * arg3.fee_rate / 10000;
            if (v4 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>>(0x2::coin::split<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&mut v0, v4, arg4), arg3.fee_address);
            };
        };
        v0
    }

    // decompiled from Move bytecode v6
}

