module 0x125657c89a11e8397e8456760686d2a36e927267d76639a7bfcc2f70a727052a::oracle {
    struct Oracle has key {
        id: 0x2::object::UID,
        data: 0x2::table::Table<0x1::string::String, DataEntry>,
        authorized_relayers: vector<address>,
    }

    struct DataEntry has store {
        value: vector<u8>,
        timestamp: u64,
        relayer: address,
    }

    struct DataUpdated has copy, drop {
        key: 0x1::string::String,
        relayer: address,
        timestamp: u64,
    }

    public entry fun add_authorized_relayer(arg0: &mut Oracle, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x1::vector::contains<address>(&arg0.authorized_relayers, &v0), 2);
        if (!0x1::vector::contains<address>(&arg0.authorized_relayers, &arg1)) {
            0x1::vector::push_back<address>(&mut arg0.authorized_relayers, arg1);
        };
    }

    public fun contains_key(arg0: &Oracle, arg1: 0x1::string::String) : bool {
        0x2::table::contains<0x1::string::String, DataEntry>(&arg0.data, arg1)
    }

    public fun get_relayer_count(arg0: &Oracle) : u64 {
        0x1::vector::length<address>(&arg0.authorized_relayers)
    }

    public entry fun initialize(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Oracle{
            id                  : 0x2::object::new(arg0),
            data                : 0x2::table::new<0x1::string::String, DataEntry>(arg0),
            authorized_relayers : 0x1::vector::empty<address>(),
        };
        0x1::vector::push_back<address>(&mut v0.authorized_relayers, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<Oracle>(v0);
    }

    public fun is_authorized_relayer(arg0: &Oracle, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.authorized_relayers, &arg1)
    }

    public fun read_as_bytes(arg0: &Oracle, arg1: 0x1::string::String) : (vector<u8>, u64) {
        assert!(0x2::table::contains<0x1::string::String, DataEntry>(&arg0.data, arg1), 1);
        let v0 = 0x2::table::borrow<0x1::string::String, DataEntry>(&arg0.data, arg1);
        (v0.value, v0.timestamp)
    }

    public fun read_as_u256(arg0: &Oracle, arg1: 0x1::string::String) : (u256, u64) {
        let (v0, v1) = read_as_bytes(arg0, arg1);
        let v2 = v0;
        let v3 = 0x1::vector::length<u8>(&v2);
        assert!(v3 > 0, 3);
        assert!(v3 <= 32, 4);
        let v4 = 0;
        let v5 = 0;
        while (v5 < v3) {
            let v6 = v4 * 256;
            v4 = v6 + (*0x1::vector::borrow<u8>(&v2, v5) as u256);
            v5 = v5 + 1;
        };
        (v4, v1)
    }

    public entry fun remove_authorized_relayer(arg0: &mut Oracle, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x1::vector::contains<address>(&arg0.authorized_relayers, &v0), 2);
        let (v1, v2) = 0x1::vector::index_of<address>(&arg0.authorized_relayers, &arg1);
        if (v1) {
            0x1::vector::remove<address>(&mut arg0.authorized_relayers, v2);
        };
    }

    public entry fun update_state_bulk(arg0: &mut Oracle, arg1: vector<0x1::string::String>, arg2: vector<vector<u8>>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x1::vector::contains<address>(&arg0.authorized_relayers, &v0), 2);
        let v1 = 0x1::vector::length<0x1::string::String>(&arg1);
        assert!(v1 == 0x1::vector::length<vector<u8>>(&arg2) && v1 > 0, 0);
        let v2 = 0x2::tx_context::epoch_timestamp_ms(arg3);
        let v3 = 0;
        while (v3 < v1) {
            let v4 = *0x1::vector::borrow<0x1::string::String>(&arg1, v3);
            let v5 = DataEntry{
                value     : *0x1::vector::borrow<vector<u8>>(&arg2, v3),
                timestamp : v2,
                relayer   : v0,
            };
            if (0x2::table::contains<0x1::string::String, DataEntry>(&arg0.data, v4)) {
                let DataEntry {
                    value     : _,
                    timestamp : _,
                    relayer   : _,
                } = 0x2::table::remove<0x1::string::String, DataEntry>(&mut arg0.data, v4);
            };
            0x2::table::add<0x1::string::String, DataEntry>(&mut arg0.data, v4, v5);
            let v9 = DataUpdated{
                key       : v4,
                relayer   : v0,
                timestamp : v2,
            };
            0x2::event::emit<DataUpdated>(v9);
            v3 = v3 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

