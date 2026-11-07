module 0x6bd1fc51b3fac2ab3d890c005e5de49c7574175e5e3f6ecb44e01555712b0c85::passport {
    struct Registry has key {
        id: 0x2::object::UID,
        serials: 0x2::table::Table<vector<u8>, 0x2::object::ID>,
        count: u64,
    }

    struct DevicePassport has key {
        id: 0x2::object::UID,
        category: 0x1::string::String,
        make: 0x1::string::String,
        model: 0x1::string::String,
        serial_hash: vector<u8>,
        creator: address,
        created_at_ms: u64,
    }

    struct PassportMinted has copy, drop {
        passport_id: 0x2::object::ID,
        owner: address,
        category: 0x1::string::String,
        make: 0x1::string::String,
        model: 0x1::string::String,
    }

    struct PassportTransferred has copy, drop {
        passport_id: 0x2::object::ID,
        from: address,
        to: address,
    }

    public fun category(arg0: &DevicePassport) : 0x1::string::String {
        arg0.category
    }

    public fun count(arg0: &Registry) : u64 {
        arg0.count
    }

    public fun created_at_ms(arg0: &DevicePassport) : u64 {
        arg0.created_at_ms
    }

    public fun creator(arg0: &DevicePassport) : address {
        arg0.creator
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Registry{
            id      : 0x2::object::new(arg0),
            serials : 0x2::table::new<vector<u8>, 0x2::object::ID>(arg0),
            count   : 0,
        };
        0x2::transfer::share_object<Registry>(v0);
    }

    public fun is_registered(arg0: &Registry, arg1: &vector<u8>) : bool {
        0x2::table::contains<vector<u8>, 0x2::object::ID>(&arg0.serials, *arg1)
    }

    public fun make(arg0: &DevicePassport) : 0x1::string::String {
        arg0.make
    }

    entry fun mint(arg0: &mut Registry, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(&arg4) == 32, 2);
        let v0 = if (0x1::string::length(&arg1) <= 120) {
            if (0x1::string::length(&arg2) <= 120) {
                0x1::string::length(&arg3) <= 120
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 3);
        assert!(!0x2::table::contains<vector<u8>, 0x2::object::ID>(&arg0.serials, arg4), 1);
        let v1 = 0x2::tx_context::sender(arg6);
        let v2 = DevicePassport{
            id            : 0x2::object::new(arg6),
            category      : arg1,
            make          : arg2,
            model         : arg3,
            serial_hash   : arg4,
            creator       : v1,
            created_at_ms : 0x2::clock::timestamp_ms(arg5),
        };
        let v3 = 0x2::object::id<DevicePassport>(&v2);
        0x2::table::add<vector<u8>, 0x2::object::ID>(&mut arg0.serials, v2.serial_hash, v3);
        arg0.count = arg0.count + 1;
        let v4 = PassportMinted{
            passport_id : v3,
            owner       : v1,
            category    : v2.category,
            make        : v2.make,
            model       : v2.model,
        };
        0x2::event::emit<PassportMinted>(v4);
        0x2::transfer::transfer<DevicePassport>(v2, v1);
    }

    public fun model(arg0: &DevicePassport) : 0x1::string::String {
        arg0.model
    }

    public fun passport_for(arg0: &Registry, arg1: &vector<u8>) : 0x2::object::ID {
        *0x2::table::borrow<vector<u8>, 0x2::object::ID>(&arg0.serials, *arg1)
    }

    public fun serial_hash(arg0: &DevicePassport) : vector<u8> {
        arg0.serial_hash
    }

    entry fun transfer_passport(arg0: DevicePassport, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(arg1 != 0x2::tx_context::sender(arg2), 4);
        let v0 = PassportTransferred{
            passport_id : 0x2::object::id<DevicePassport>(&arg0),
            from        : 0x2::tx_context::sender(arg2),
            to          : arg1,
        };
        0x2::event::emit<PassportTransferred>(v0);
        0x2::transfer::transfer<DevicePassport>(arg0, arg1);
    }

    // decompiled from Move bytecode v7
}

