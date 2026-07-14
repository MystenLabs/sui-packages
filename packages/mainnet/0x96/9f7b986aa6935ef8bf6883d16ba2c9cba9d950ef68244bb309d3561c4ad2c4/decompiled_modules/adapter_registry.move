module 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::adapter_registry {
    struct AdapterRegistry has key {
        id: 0x2::object::UID,
        adapters: 0x2::table::Table<vector<u8>, AdapterMeta>,
        count: u64,
    }

    struct AdapterMeta has copy, drop, store {
        adapter_id: vector<u8>,
        chain: vector<u8>,
        active: bool,
        label: vector<u8>,
    }

    struct AdapterRegistered has copy, drop {
        adapter_id: vector<u8>,
        chain: vector<u8>,
    }

    struct AdapterSetActive has copy, drop {
        adapter_id: vector<u8>,
        active: bool,
    }

    public fun assert_active(arg0: &AdapterRegistry, arg1: vector<u8>) {
        assert!(0x2::table::contains<vector<u8>, AdapterMeta>(&arg0.adapters, arg1), 1);
        assert!(0x2::table::borrow<vector<u8>, AdapterMeta>(&arg0.adapters, arg1).active, 1);
    }

    public fun count(arg0: &AdapterRegistry) : u64 {
        arg0.count
    }

    public fun create(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdapterRegistry{
            id       : 0x2::object::new(arg0),
            adapters : 0x2::table::new<vector<u8>, AdapterMeta>(arg0),
            count    : 0,
        };
        0x2::transfer::share_object<AdapterRegistry>(v0);
    }

    public fun is_active(arg0: &AdapterRegistry, arg1: vector<u8>) : bool {
        if (!0x2::table::contains<vector<u8>, AdapterMeta>(&arg0.adapters, arg1)) {
            return false
        };
        0x2::table::borrow<vector<u8>, AdapterMeta>(&arg0.adapters, arg1).active
    }

    public fun label_as_string(arg0: &AdapterMeta) : 0x1::string::String {
        0x1::string::utf8(arg0.label)
    }

    public fun register(arg0: &mut AdapterRegistry, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>) {
        assert!(!0x2::table::contains<vector<u8>, AdapterMeta>(&arg0.adapters, arg1), 2);
        let v0 = AdapterMeta{
            adapter_id : arg1,
            chain      : arg2,
            active     : true,
            label      : arg3,
        };
        0x2::table::add<vector<u8>, AdapterMeta>(&mut arg0.adapters, arg1, v0);
        arg0.count = arg0.count + 1;
        let v1 = AdapterRegistered{
            adapter_id : arg1,
            chain      : arg2,
        };
        0x2::event::emit<AdapterRegistered>(v1);
    }

    public fun set_active(arg0: &mut AdapterRegistry, arg1: vector<u8>, arg2: bool) {
        assert!(0x2::table::contains<vector<u8>, AdapterMeta>(&arg0.adapters, arg1), 1);
        0x2::table::borrow_mut<vector<u8>, AdapterMeta>(&mut arg0.adapters, arg1).active = arg2;
        let v0 = AdapterSetActive{
            adapter_id : arg1,
            active     : arg2,
        };
        0x2::event::emit<AdapterSetActive>(v0);
    }

    // decompiled from Move bytecode v7
}

