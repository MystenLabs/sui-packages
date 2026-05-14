module 0x552d78bbad89034eb90fd3e79ee3c1a89984d367ef7ddfd0d2baeaf2d031dc7b::oracle {
    struct OracleAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct OracleRegistry has key {
        id: 0x2::object::UID,
        writers: 0x2::vec_set::VecSet<address>,
        entries: 0x2::table::Table<0x2::object::ID, SlippageEntry>,
    }

    struct SlippageEntry has copy, drop, store {
        k_bps: u64,
        last_updated_ms: u64,
        sample_count: u64,
        last_size_atomic: u64,
        last_observed_loss_atomic: u64,
    }

    struct SampleRecorded has copy, drop {
        pool_id: 0x2::object::ID,
        k_bps_before: u64,
        k_bps_after: u64,
        sample_count: u64,
        size_atomic: u64,
        observed_loss_atomic: u64,
    }

    struct WriterAdded has copy, drop {
        writer: address,
    }

    struct WriterRemoved has copy, drop {
        writer: address,
    }

    public fun add_writer(arg0: &OracleAdminCap, arg1: &mut OracleRegistry, arg2: address) {
        if (!0x2::vec_set::contains<address>(&arg1.writers, &arg2)) {
            0x2::vec_set::insert<address>(&mut arg1.writers, arg2);
            let v0 = WriterAdded{writer: arg2};
            0x2::event::emit<WriterAdded>(v0);
        };
    }

    public fun has_pool(arg0: &OracleRegistry, arg1: 0x2::object::ID) : bool {
        0x2::table::contains<0x2::object::ID, SlippageEntry>(&arg0.entries, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = OracleAdminCap{id: 0x2::object::new(arg0)};
        let v1 = OracleRegistry{
            id      : 0x2::object::new(arg0),
            writers : 0x2::vec_set::empty<address>(),
            entries : 0x2::table::new<0x2::object::ID, SlippageEntry>(arg0),
        };
        0x2::transfer::transfer<OracleAdminCap>(v0, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<OracleRegistry>(v1);
    }

    public fun is_writer(arg0: &OracleRegistry, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.writers, &arg1)
    }

    public fun read(arg0: &OracleRegistry, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) : (u64, u64, u64) {
        if (!0x2::table::contains<0x2::object::ID, SlippageEntry>(&arg0.entries, arg1)) {
            return (0, 18446744073709551615, 0)
        };
        let v0 = 0x2::table::borrow<0x2::object::ID, SlippageEntry>(&arg0.entries, arg1);
        (v0.k_bps, (0x2::clock::timestamp_ms(arg2) - v0.last_updated_ms) / 1000, v0.sample_count)
    }

    public fun read_many(arg0: &OracleRegistry, arg1: vector<0x2::object::ID>, arg2: &0x2::clock::Clock) : vector<u64> {
        let v0 = 0x1::vector::empty<u64>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x2::object::ID>(&arg1)) {
            let v2 = *0x1::vector::borrow<0x2::object::ID>(&arg1, v1);
            if (0x2::table::contains<0x2::object::ID, SlippageEntry>(&arg0.entries, v2)) {
                let v3 = 0x2::table::borrow<0x2::object::ID, SlippageEntry>(&arg0.entries, v2);
                0x1::vector::push_back<u64>(&mut v0, v3.k_bps);
                0x1::vector::push_back<u64>(&mut v0, (0x2::clock::timestamp_ms(arg2) - v3.last_updated_ms) / 1000);
                0x1::vector::push_back<u64>(&mut v0, v3.sample_count);
            } else {
                0x1::vector::push_back<u64>(&mut v0, 0);
                0x1::vector::push_back<u64>(&mut v0, 18446744073709551615);
                0x1::vector::push_back<u64>(&mut v0, 0);
            };
            v1 = v1 + 1;
        };
        v0
    }

    public fun record_sample(arg0: &mut OracleRegistry, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        assert!(0x2::vec_set::contains<address>(&arg0.writers, &v0), 0);
        assert!(arg4 > 0, 2);
        let v1 = 0x2::clock::timestamp_ms(arg5);
        let v2 = if (arg3 >= arg4) {
            0
        } else {
            arg4 - arg3
        };
        let (v3, v4, v5) = if (0x2::table::contains<0x2::object::ID, SlippageEntry>(&arg0.entries, arg1)) {
            let v6 = 0x2::table::borrow<0x2::object::ID, SlippageEntry>(&arg0.entries, arg1);
            let (v4, v5) = if (v1 - v6.last_updated_ms > 3600000) {
                (v2 * 10000 / arg4, 1)
            } else {
                ((v6.k_bps * 9 + v2 * 10000 / arg4) / 10, v6.sample_count + 1)
            };
            (v6.k_bps, v4, v5)
        } else {
            (0, v2 * 10000 / arg4, 1)
        };
        let v7 = if (v4 < 5) {
            5
        } else if (v4 > 2000) {
            2000
        } else {
            v4
        };
        let v8 = SlippageEntry{
            k_bps                     : v7,
            last_updated_ms           : v1,
            sample_count              : v5,
            last_size_atomic          : arg2,
            last_observed_loss_atomic : v2,
        };
        if (0x2::table::contains<0x2::object::ID, SlippageEntry>(&arg0.entries, arg1)) {
            *0x2::table::borrow_mut<0x2::object::ID, SlippageEntry>(&mut arg0.entries, arg1) = v8;
        } else {
            0x2::table::add<0x2::object::ID, SlippageEntry>(&mut arg0.entries, arg1, v8);
        };
        let v9 = SampleRecorded{
            pool_id              : arg1,
            k_bps_before         : v3,
            k_bps_after          : v7,
            sample_count         : v5,
            size_atomic          : arg2,
            observed_loss_atomic : v2,
        };
        0x2::event::emit<SampleRecorded>(v9);
    }

    public fun remove_writer(arg0: &OracleAdminCap, arg1: &mut OracleRegistry, arg2: address) {
        if (0x2::vec_set::contains<address>(&arg1.writers, &arg2)) {
            0x2::vec_set::remove<address>(&mut arg1.writers, &arg2);
            let v0 = WriterRemoved{writer: arg2};
            0x2::event::emit<WriterRemoved>(v0);
        };
    }

    // decompiled from Move bytecode v6
}

