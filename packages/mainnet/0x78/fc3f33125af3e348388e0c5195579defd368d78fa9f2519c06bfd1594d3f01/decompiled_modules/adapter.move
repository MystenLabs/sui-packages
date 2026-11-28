module 0x78fc3f33125af3e348388e0c5195579defd368d78fa9f2519c06bfd1594d3f01::adapter {
    struct AccordWalrus has drop {
        dummy_field: bool,
    }

    struct StorageBought has copy, drop {
        intent_id: 0x2::object::ID,
        owner: address,
        bytes: u64,
        epochs: u32,
        hold_micros: u64,
        paid_micros: u64,
        back_micros: u64,
        wal_charged: u64,
    }

    struct Reserved {
        storage: 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::Storage,
        charged: u64,
    }

    struct ReservedV2 {
        intent_id: 0x2::object::ID,
        storage: 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::Storage,
        charged: u64,
    }

    public fun version() : u64 {
        1
    }

    fun close<T0>(arg0: 0x1aeea29ac7913a6192e7dae0add7b9647811588ae1b4ceb60b7c2a04668fa3ae::ticket::Ticket<T0>, arg1: 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::Storage, arg2: u64, arg3: &0x1aeea29ac7913a6192e7dae0add7b9647811588ae1b4ceb60b7c2a04668fa3ae::registry::ConvertRegistry, arg4: &mut 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg5: u64, arg6: u64, arg7: 0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>, arg8: 0x2::coin::Coin<T0>) {
        0x1aeea29ac7913a6192e7dae0add7b9647811588ae1b4ceb60b7c2a04668fa3ae::registry::assert_adapter_version<AccordWalrus>(arg3, 1);
        assert!(0x2::object::id_address<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System>(arg4) == 0x1aeea29ac7913a6192e7dae0add7b9647811588ae1b4ceb60b7c2a04668fa3ae::ticket::recipient<T0>(&arg0), 1);
        let (v0, v1) = terms_of(0x1aeea29ac7913a6192e7dae0add7b9647811588ae1b4ceb60b7c2a04668fa3ae::ticket::terms<T0>(&arg0));
        assert!(0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::size(&arg1) == v0 && 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::end_epoch(&arg1) - 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::start_epoch(&arg1) == v1, 5);
        assert!(0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::start_epoch(&arg1) == 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::epoch(arg4), 5);
        assert!(arg6 <= arg5, 3);
        let v2 = 0x1aeea29ac7913a6192e7dae0add7b9647811588ae1b4ceb60b7c2a04668fa3ae::registry::dollar_entry<T0>(arg3);
        let v3 = 0x1aeea29ac7913a6192e7dae0add7b9647811588ae1b4ceb60b7c2a04668fa3ae::registry::route<T0, 0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(arg3);
        let v4 = 0x1aeea29ac7913a6192e7dae0add7b9647811588ae1b4ceb60b7c2a04668fa3ae::registry::dollar_micros(&v2, 0x1aeea29ac7913a6192e7dae0add7b9647811588ae1b4ceb60b7c2a04668fa3ae::ticket::hold<T0>(&arg0));
        let v5 = 0x1aeea29ac7913a6192e7dae0add7b9647811588ae1b4ceb60b7c2a04668fa3ae::registry::dollar_micros(&v2, 0x2::coin::value<T0>(&arg8));
        let v6 = if (v5 >= v4) {
            0
        } else {
            v4 - v5
        };
        assert!(v6 <= arg6 + 0x1aeea29ac7913a6192e7dae0add7b9647811588ae1b4ceb60b7c2a04668fa3ae::registry::allowance_micros(&v3, arg6), 4);
        let (v7, v8) = terms_of(0x1aeea29ac7913a6192e7dae0add7b9647811588ae1b4ceb60b7c2a04668fa3ae::ticket::terms<T0>(&arg0));
        let v9 = StorageBought{
            intent_id   : 0x1aeea29ac7913a6192e7dae0add7b9647811588ae1b4ceb60b7c2a04668fa3ae::ticket::intent_id<T0>(&arg0),
            owner       : 0x1aeea29ac7913a6192e7dae0add7b9647811588ae1b4ceb60b7c2a04668fa3ae::ticket::owner<T0>(&arg0),
            bytes       : v7,
            epochs      : v8,
            hold_micros : v4,
            paid_micros : v6,
            back_micros : v5,
            wal_charged : arg2,
        };
        0x2::event::emit<StorageBought>(v9);
        if (0x2::coin::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&arg7) == 0) {
            0x2::coin::destroy_zero<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(arg7);
        } else {
            0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::add_subsidy(arg4, arg7, v8);
        };
        0x2::transfer::public_transfer<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::Storage>(arg1, 0x1aeea29ac7913a6192e7dae0add7b9647811588ae1b4ceb60b7c2a04668fa3ae::ticket::owner<T0>(&arg0));
        0x1aeea29ac7913a6192e7dae0add7b9647811588ae1b4ceb60b7c2a04668fa3ae::ticket::refund<T0, T0>(&arg0, arg8);
        let v10 = AccordWalrus{dummy_field: false};
        0x1aeea29ac7913a6192e7dae0add7b9647811588ae1b4ceb60b7c2a04668fa3ae::ticket::close<T0, AccordWalrus>(v10, arg0);
    }

    public fun finish<T0>(arg0: 0x1aeea29ac7913a6192e7dae0add7b9647811588ae1b4ceb60b7c2a04668fa3ae::ticket::Ticket<T0>, arg1: &0x1aeea29ac7913a6192e7dae0add7b9647811588ae1b4ceb60b7c2a04668fa3ae::registry::ConvertRegistry, arg2: &mut 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg3: 0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>, arg4: 0x2::coin::Coin<T0>, arg5: &mut 0x2::tx_context::TxContext) {
        abort 6
    }

    public fun finish_priced<T0>(arg0: 0x1aeea29ac7913a6192e7dae0add7b9647811588ae1b4ceb60b7c2a04668fa3ae::ticket::Ticket<T0>, arg1: &0x1aeea29ac7913a6192e7dae0add7b9647811588ae1b4ceb60b7c2a04668fa3ae::registry::ConvertRegistry, arg2: &mut 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg3: 0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>, arg4: 0x2::coin::Coin<T0>, arg5: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        abort 6
    }

    fun number(arg0: &vector<u8>, arg1: u64) : (u64, u64) {
        let v0 = arg1;
        let v1 = 0;
        loop {
            let v2 = if (v0 < 0x1::vector::length<u8>(arg0)) {
                if (*0x1::vector::borrow<u8>(arg0, v0) >= 48) {
                    *0x1::vector::borrow<u8>(arg0, v0) <= 57
                } else {
                    false
                }
            } else {
                false
            };
            if (v2) {
                assert!(v0 - arg1 < 19, 2);
                let v3 = v0 == arg1 + 1 && *0x1::vector::borrow<u8>(arg0, arg1) == 48;
                assert!(!v3, 2);
                let v4 = v1 * 10;
                v1 = v4 + ((*0x1::vector::borrow<u8>(arg0, v0) - 48) as u64);
                v0 = v0 + 1;
            } else {
                break
            };
        };
        assert!(v0 > arg1, 2);
        (v1, v0)
    }

    public fun register_seller(arg0: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg1: &0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::version::Version, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) : 0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::seller::SellerCap {
        0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::seller::register_external_with_permit<AccordWalrus>(0x2::object::id_address<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System>(arg0), arg1, arg2, 0x1::internal::permit<AccordWalrus>(), arg3)
    }

    public fun reserve<T0>(arg0: &0x1aeea29ac7913a6192e7dae0add7b9647811588ae1b4ceb60b7c2a04668fa3ae::ticket::Ticket<T0>, arg1: &mut 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg2: 0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>, Reserved) {
        abort 7
    }

    public fun reserve_v2<T0>(arg0: &0x1aeea29ac7913a6192e7dae0add7b9647811588ae1b4ceb60b7c2a04668fa3ae::ticket::Ticket<T0>, arg1: &mut 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg2: 0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>, ReservedV2) {
        0x1aeea29ac7913a6192e7dae0add7b9647811588ae1b4ceb60b7c2a04668fa3ae::ticket::assert_adapter<T0, AccordWalrus>(arg0);
        assert!(0x2::object::id_address<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System>(arg1) == 0x1aeea29ac7913a6192e7dae0add7b9647811588ae1b4ceb60b7c2a04668fa3ae::ticket::recipient<T0>(arg0), 1);
        let (v0, v1) = terms_of(0x1aeea29ac7913a6192e7dae0add7b9647811588ae1b4ceb60b7c2a04668fa3ae::ticket::terms<T0>(arg0));
        let v2 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::reserve_space(arg1, v0, v1, &mut arg2, arg3);
        assert!(0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::size(&v2) == v0 && 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::end_epoch(&v2) - 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::start_epoch(&v2) == v1, 5);
        assert!(0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::start_epoch(&v2) == 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::epoch(arg1), 5);
        let v3 = ReservedV2{
            intent_id : 0x1aeea29ac7913a6192e7dae0add7b9647811588ae1b4ceb60b7c2a04668fa3ae::ticket::intent_id<T0>(arg0),
            storage   : v2,
            charged   : 0x2::coin::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&arg2) - 0x2::coin::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&arg2),
        };
        (arg2, v3)
    }

    public fun settle<T0>(arg0: 0x1aeea29ac7913a6192e7dae0add7b9647811588ae1b4ceb60b7c2a04668fa3ae::ticket::Ticket<T0>, arg1: Reserved, arg2: &0x1aeea29ac7913a6192e7dae0add7b9647811588ae1b4ceb60b7c2a04668fa3ae::registry::ConvertRegistry, arg3: &mut 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg4: 0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>, arg5: 0x2::coin::Coin<T0>) {
        abort 7
    }

    public fun settle_priced<T0>(arg0: 0x1aeea29ac7913a6192e7dae0add7b9647811588ae1b4ceb60b7c2a04668fa3ae::ticket::Ticket<T0>, arg1: Reserved, arg2: &0x1aeea29ac7913a6192e7dae0add7b9647811588ae1b4ceb60b7c2a04668fa3ae::registry::ConvertRegistry, arg3: &mut 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg4: 0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>, arg5: 0x2::coin::Coin<T0>, arg6: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg7: &0x2::clock::Clock) {
        abort 7
    }

    public fun settle_priced_v2<T0>(arg0: 0x1aeea29ac7913a6192e7dae0add7b9647811588ae1b4ceb60b7c2a04668fa3ae::ticket::Ticket<T0>, arg1: ReservedV2, arg2: &0x1aeea29ac7913a6192e7dae0add7b9647811588ae1b4ceb60b7c2a04668fa3ae::registry::ConvertRegistry, arg3: &mut 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg4: 0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>, arg5: 0x2::coin::Coin<T0>, arg6: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg7: &0x2::clock::Clock) {
        let v0 = 0x1aeea29ac7913a6192e7dae0add7b9647811588ae1b4ceb60b7c2a04668fa3ae::registry::enabled_entry<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(arg2);
        let v1 = 0xa4b03889b311bec2b3d664a5f3cd944ec28c995c493ad4eb7795a72a04d0a793::price::check_edges<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&v0, arg6, arg7);
        let ReservedV2 {
            intent_id : v2,
            storage   : v3,
            charged   : v4,
        } = arg1;
        assert!(v2 == 0x1aeea29ac7913a6192e7dae0add7b9647811588ae1b4ceb60b7c2a04668fa3ae::ticket::intent_id<T0>(&arg0), 8);
        close<T0>(arg0, v3, v4, arg2, arg3, 0x1aeea29ac7913a6192e7dae0add7b9647811588ae1b4ceb60b7c2a04668fa3ae::registry::cap_micros(&v0), 0xa4b03889b311bec2b3d664a5f3cd944ec28c995c493ad4eb7795a72a04d0a793::price::charged_micros<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&v1, arg1.charged), arg4, arg5);
    }

    public fun settle_v2<T0>(arg0: 0x1aeea29ac7913a6192e7dae0add7b9647811588ae1b4ceb60b7c2a04668fa3ae::ticket::Ticket<T0>, arg1: ReservedV2, arg2: &0x1aeea29ac7913a6192e7dae0add7b9647811588ae1b4ceb60b7c2a04668fa3ae::registry::ConvertRegistry, arg3: &mut 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg4: 0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>, arg5: 0x2::coin::Coin<T0>) {
        let v0 = 0x1aeea29ac7913a6192e7dae0add7b9647811588ae1b4ceb60b7c2a04668fa3ae::registry::dollar_entry<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(arg2);
        let ReservedV2 {
            intent_id : v1,
            storage   : v2,
            charged   : v3,
        } = arg1;
        assert!(v1 == 0x1aeea29ac7913a6192e7dae0add7b9647811588ae1b4ceb60b7c2a04668fa3ae::ticket::intent_id<T0>(&arg0), 8);
        close<T0>(arg0, v2, v3, arg2, arg3, 0x1aeea29ac7913a6192e7dae0add7b9647811588ae1b4ceb60b7c2a04668fa3ae::registry::cap_micros(&v0), 0x1aeea29ac7913a6192e7dae0add7b9647811588ae1b4ceb60b7c2a04668fa3ae::registry::dollar_micros(&v0, arg1.charged), arg4, arg5);
    }

    public fun start<T0>(arg0: &mut 0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::intent::ExternalPayouts<T0>, arg1: &0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::intent::Intent<T0>, arg2: &0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::version::Version, arg3: &0x1aeea29ac7913a6192e7dae0add7b9647811588ae1b4ceb60b7c2a04668fa3ae::registry::ConvertRegistry, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x1aeea29ac7913a6192e7dae0add7b9647811588ae1b4ceb60b7c2a04668fa3ae::ticket::Ticket<T0>) {
        0x1aeea29ac7913a6192e7dae0add7b9647811588ae1b4ceb60b7c2a04668fa3ae::registry::assert_adapter_version<AccordWalrus>(arg3, 1);
        let v0 = 0x1aeea29ac7913a6192e7dae0add7b9647811588ae1b4ceb60b7c2a04668fa3ae::registry::dollar_entry<T0>(arg3);
        let (v1, v2, v3, v4, _, v6) = 0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::intent::release_external_with_refund<T0, AccordWalrus>(arg0, arg1, arg2, 0x1::internal::permit<AccordWalrus>(), arg4);
        assert!(0x1aeea29ac7913a6192e7dae0add7b9647811588ae1b4ceb60b7c2a04668fa3ae::registry::dollar_micros(&v0, v4) <= 0x1aeea29ac7913a6192e7dae0add7b9647811588ae1b4ceb60b7c2a04668fa3ae::registry::cap_micros(&v0), 3);
        let (_, _) = terms_of(v3);
        let v9 = AccordWalrus{dummy_field: false};
        (v1, 0x1aeea29ac7913a6192e7dae0add7b9647811588ae1b4ceb60b7c2a04668fa3ae::ticket::open<T0, AccordWalrus>(v9, 0x2::object::id<0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::intent::Intent<T0>>(arg1), v6, v4, v2, v3))
    }

    public fun terms_of(arg0: vector<u8>) : (u64, u32) {
        let v0 = b"storage:";
        let v1 = 0x1::vector::length<u8>(&arg0);
        assert!(v1 > 0x1::vector::length<u8>(&v0), 2);
        let v2 = 0;
        while (v2 < 0x1::vector::length<u8>(&v0)) {
            assert!(*0x1::vector::borrow<u8>(&arg0, v2) == *0x1::vector::borrow<u8>(&v0, v2), 2);
            v2 = v2 + 1;
        };
        let (v3, v4) = number(&arg0, v2);
        assert!(v4 < v1 && *0x1::vector::borrow<u8>(&arg0, v4) == 58, 2);
        let (v5, v6) = number(&arg0, v4 + 1);
        assert!(v6 == v1, 2);
        let v7 = if (v3 > 0) {
            if (v5 > 0) {
                v5 <= 4294967295
            } else {
                false
            }
        } else {
            false
        };
        assert!(v7, 2);
        (v3, (v5 as u32))
    }

    // decompiled from Move bytecode v7
}

