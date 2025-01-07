module 0x75a2c16938fba807c6e9ff14069bb55e3b7309d184e61e93f2cda22622a29b9::wl_num {
    struct WL has store, key {
        id: 0x2::object::UID,
        start_at: u64,
        end_at: u64,
        total_wl: u64,
        cur_index: u64,
        max_per_address: u64,
        user_record: 0x2::table::Table<address, Record>,
    }

    struct Record has store {
        wl_addr: 0x1::string::String,
        num: u64,
    }

    public fun claim(arg0: &mut WL, arg1: &0x75a2c16938fba807c6e9ff14069bb55e3b7309d184e61e93f2cda22622a29b9::port::Stake, arg2: 0x1::string::String, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::clock::timestamp_ms(arg4) / 1000;
        assert!(v1 > arg0.start_at, 1);
        assert!(v1 < arg0.end_at, 2);
        assert!(0x75a2c16938fba807c6e9ff14069bb55e3b7309d184e61e93f2cda22622a29b9::port::stake_status(arg1, v0), 3);
        assert!(arg0.cur_index + arg3 <= arg0.total_wl, 4);
        if (!0x2::table::contains<address, Record>(&arg0.user_record, v0)) {
            let v2 = Record{
                wl_addr : arg2,
                num     : 0,
            };
            0x2::table::add<address, Record>(&mut arg0.user_record, v0, v2);
        };
        let v3 = 0x2::table::borrow_mut<address, Record>(&mut arg0.user_record, v0);
        assert!(v3.num + arg3 <= arg0.max_per_address, 5);
        assert!(0x1::string::length(&arg2) == 42, 6);
        v3.num = v3.num + arg3;
        arg0.cur_index = arg0.cur_index + arg3;
    }

    public fun create_wl_record(arg0: &0x2::package::Publisher, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::package::from_package<0x75a2c16938fba807c6e9ff14069bb55e3b7309d184e61e93f2cda22622a29b9::port::Stake>(arg0), 1);
        let v0 = WL{
            id              : 0x2::object::new(arg5),
            start_at        : arg1,
            end_at          : arg2,
            total_wl        : arg3,
            cur_index       : 0,
            max_per_address : arg4,
            user_record     : 0x2::table::new<address, Record>(arg5),
        };
        0x2::transfer::public_share_object<WL>(v0);
    }

    public fun update(arg0: &mut WL, arg1: &0x75a2c16938fba807c6e9ff14069bb55e3b7309d184e61e93f2cda22622a29b9::port::Stake, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::clock::timestamp_ms(arg3) / 1000;
        assert!(v1 > arg0.start_at, 1);
        assert!(v1 < arg0.end_at, 2);
        assert!(0x75a2c16938fba807c6e9ff14069bb55e3b7309d184e61e93f2cda22622a29b9::port::stake_status(arg1, v0), 3);
        assert!(0x2::table::contains<address, Record>(&arg0.user_record, v0), 4);
        assert!(0x1::string::length(&arg2) == 42, 5);
        0x2::table::borrow_mut<address, Record>(&mut arg0.user_record, v0).wl_addr = arg2;
    }

    public fun update_wl_record(arg0: &0x2::package::Publisher, arg1: &mut WL, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::package::from_package<0x75a2c16938fba807c6e9ff14069bb55e3b7309d184e61e93f2cda22622a29b9::port::Stake>(arg0), 1);
        arg1.start_at = arg2;
        arg1.end_at = arg3;
        arg1.total_wl = arg4;
        arg1.max_per_address = arg5;
    }

    // decompiled from Move bytecode v6
}

