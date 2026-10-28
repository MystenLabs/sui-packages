module 0xe81e2d12a766b56a9dae5cb33afc4216bd4ef1fea05f2dd1983de9cd6efc4a65::device_pass {
    struct DEVICE_PASS has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Registry has key {
        id: 0x2::object::UID,
        version: u64,
        paused: bool,
        issuer_key: vector<u8>,
        devices: 0x2::table::Table<vector<u8>, Record>,
        count: u64,
    }

    struct Record has copy, drop, store {
        number: u64,
        model: 0x1::string::String,
        first_seen_ms: u64,
        holder: address,
        pass: 0x2::object::ID,
        seq: u64,
    }

    struct DevicePass has key {
        id: 0x2::object::UID,
        registry: 0x2::object::ID,
        number: u64,
        model: 0x1::string::String,
        first_seen_ms: u64,
        claimed_ms: u64,
        device: vector<u8>,
    }

    struct PassClaimed has copy, drop {
        registry: 0x2::object::ID,
        pass: 0x2::object::ID,
        number: u64,
        holder: address,
        device: vector<u8>,
        model: 0x1::string::String,
        first_seen_ms: u64,
        seq: u64,
        previous_holder: 0x1::option::Option<address>,
        previous_pass: 0x1::option::Option<0x2::object::ID>,
    }

    struct PassBurned has copy, drop {
        registry: 0x2::object::ID,
        pass: 0x2::object::ID,
        number: u64,
        holder: address,
        current: bool,
    }

    struct IssuerKeySet has copy, drop {
        registry: 0x2::object::ID,
        public_key: vector<u8>,
    }

    struct RegistryPaused has copy, drop {
        registry: 0x2::object::ID,
        paused: bool,
    }

    public fun claim(arg0: &mut Registry, arg1: vector<u8>, arg2: 0x1::string::String, arg3: u64, arg4: u64, arg5: u64, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert_open(arg0);
        assert!(0x2::clock::timestamp_ms(arg7) < arg5, 5);
        let v0 = claim_message(0x2::object::id<Registry>(arg0), 0x2::tx_context::sender(arg8), arg1, arg2, arg3, arg4, arg5);
        assert!(0x2::ed25519::ed25519_verify(&arg6, &arg0.issuer_key, &v0), 6);
        mint(arg0, arg1, arg2, arg3, arg4, 0x2::clock::timestamp_ms(arg7), arg8)
    }

    fun assert_current(arg0: &Registry) {
        assert!(arg0.version == 1, 1);
    }

    fun assert_open(arg0: &Registry) {
        assert_current(arg0);
        assert!(!arg0.paused, 2);
        assert!(!0x1::vector::is_empty<u8>(&arg0.issuer_key), 4);
    }

    public fun burn(arg0: &mut Registry, arg1: DevicePass, arg2: &0x2::tx_context::TxContext) {
        let DevicePass {
            id            : v0,
            registry      : _,
            number        : v2,
            model         : _,
            first_seen_ms : _,
            claimed_ms    : _,
            device        : v6,
        } = arg1;
        let v7 = v0;
        let v8 = 0x2::object::uid_to_inner(&v7);
        let v9 = false;
        if (0x2::table::contains<vector<u8>, Record>(&arg0.devices, v6)) {
            let v10 = 0x2::table::borrow_mut<vector<u8>, Record>(&mut arg0.devices, v6);
            if (v10.pass == v8) {
                v10.holder = @0x0;
                v9 = true;
            };
        };
        let v11 = PassBurned{
            registry : 0x2::object::id<Registry>(arg0),
            pass     : v8,
            number   : v2,
            holder   : 0x2::tx_context::sender(arg2),
            current  : v9,
        };
        0x2::event::emit<PassBurned>(v11);
        0x2::object::delete(v7);
    }

    public fun claim_message(arg0: 0x2::object::ID, arg1: address, arg2: vector<u8>, arg3: 0x1::string::String, arg4: u64, arg5: u64, arg6: u64) : vector<u8> {
        let v0 = b"RARE_DEVICE_V1";
        0x1::vector::append<u8>(&mut v0, 0x2::object::id_to_bytes(&arg0));
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg1));
        0x1::vector::append<u8>(&mut v0, arg2);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg5));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg4));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg6));
        0x1::vector::append<u8>(&mut v0, *0x1::string::as_bytes(&arg3));
        v0
    }

    public fun claimed_ms(arg0: &DevicePass) : u64 {
        arg0.claimed_ms
    }

    public fun count(arg0: &Registry) : u64 {
        arg0.count
    }

    public fun device(arg0: &DevicePass) : vector<u8> {
        arg0.device
    }

    public fun first_seen_ms(arg0: &DevicePass) : u64 {
        arg0.first_seen_ms
    }

    fun init(arg0: DEVICE_PASS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<DEVICE_PASS>(arg0, arg1);
        let v1 = 0x2::display::new<DevicePass>(&v0, arg1);
        0x2::display::add<DevicePass>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"Rare Device Pass #{number}"));
        0x2::display::add<DevicePass>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"One per device. This account claimed a verified {model} with Rare."));
        0x2::display::add<DevicePass>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"https://rare.market/device-pass.svg"));
        0x2::display::add<DevicePass>(&mut v1, 0x1::string::utf8(b"thumbnail_url"), 0x1::string::utf8(b"https://rare.market/device-pass.svg"));
        0x2::display::add<DevicePass>(&mut v1, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://rare.market"));
        0x2::display::add<DevicePass>(&mut v1, 0x1::string::utf8(b"creator"), 0x1::string::utf8(b"Rare"));
        0x2::display::add<DevicePass>(&mut v1, 0x1::string::utf8(b"model"), 0x1::string::utf8(b"{model}"));
        0x2::display::add<DevicePass>(&mut v1, 0x1::string::utf8(b"number"), 0x1::string::utf8(b"{number}"));
        0x2::display::add<DevicePass>(&mut v1, 0x1::string::utf8(b"first_seen_ms"), 0x1::string::utf8(b"{first_seen_ms}"));
        0x2::display::update_version<DevicePass>(&mut v1);
        let v2 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::display::Display<DevicePass>>(v1, v2);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, v2);
        0x2::transfer::public_transfer<AdminCap>(new_registry(arg1), v2);
    }

    public fun is_claimed(arg0: &Registry, arg1: vector<u8>) : bool {
        0x2::table::contains<vector<u8>, Record>(&arg0.devices, arg1)
    }

    public fun is_current(arg0: &Registry, arg1: &DevicePass) : bool {
        0x2::table::contains<vector<u8>, Record>(&arg0.devices, arg1.device) && 0x2::table::borrow<vector<u8>, Record>(&arg0.devices, arg1.device).pass == 0x2::object::id<DevicePass>(arg1)
    }

    public fun issuer_key(arg0: &Registry) : vector<u8> {
        arg0.issuer_key
    }

    public fun migrate(arg0: &AdminCap, arg1: &mut Registry) {
        assert!(arg1.version < 1, 12);
        arg1.version = 1;
    }

    fun mint(arg0: &mut Registry, arg1: vector<u8>, arg2: 0x1::string::String, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(0x1::vector::length<u8>(&arg1) == 32, 10);
        assert!(0x1::string::length(&arg2) <= 64, 11);
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x2::object::id<Registry>(arg0);
        let (v2, v3, v4, v5, v6) = if (!0x2::table::contains<vector<u8>, Record>(&arg0.devices, arg1)) {
            assert!(arg4 == 0, 8);
            arg0.count = arg0.count + 1;
            (arg0.count, arg2, arg3, 0x1::option::none<address>(), 0x1::option::none<0x2::object::ID>())
        } else {
            let v7 = 0x2::table::borrow<vector<u8>, Record>(&arg0.devices, arg1);
            assert!(arg4 != 0, 7);
            assert!(arg4 == v7.seq + 1, 8);
            assert!(v7.holder != v0, 9);
            (v7.number, v7.model, v7.first_seen_ms, 0x1::option::some<address>(v7.holder), 0x1::option::some<0x2::object::ID>(v7.pass))
        };
        let v8 = DevicePass{
            id            : 0x2::object::new(arg6),
            registry      : v1,
            number        : v2,
            model         : v3,
            first_seen_ms : v4,
            claimed_ms    : arg5,
            device        : arg1,
        };
        let v9 = 0x2::object::id<DevicePass>(&v8);
        let v10 = Record{
            number        : v2,
            model         : v3,
            first_seen_ms : v4,
            holder        : v0,
            pass          : v9,
            seq           : arg4,
        };
        if (0x2::table::contains<vector<u8>, Record>(&arg0.devices, arg1)) {
            *0x2::table::borrow_mut<vector<u8>, Record>(&mut arg0.devices, arg1) = v10;
        } else {
            0x2::table::add<vector<u8>, Record>(&mut arg0.devices, arg1, v10);
        };
        let v11 = PassClaimed{
            registry        : v1,
            pass            : v9,
            number          : v2,
            holder          : v0,
            device          : arg1,
            model           : v3,
            first_seen_ms   : v4,
            seq             : arg4,
            previous_holder : v5,
            previous_pass   : v6,
        };
        0x2::event::emit<PassClaimed>(v11);
        0x2::transfer::transfer<DevicePass>(v8, v0);
        v9
    }

    public fun model(arg0: &DevicePass) : 0x1::string::String {
        arg0.model
    }

    fun new_registry(arg0: &mut 0x2::tx_context::TxContext) : AdminCap {
        let v0 = Registry{
            id         : 0x2::object::new(arg0),
            version    : 1,
            paused     : false,
            issuer_key : b"",
            devices    : 0x2::table::new<vector<u8>, Record>(arg0),
            count      : 0,
        };
        0x2::transfer::share_object<Registry>(v0);
        AdminCap{id: 0x2::object::new(arg0)}
    }

    public fun number(arg0: &DevicePass) : u64 {
        arg0.number
    }

    public fun pass_registry(arg0: &DevicePass) : 0x2::object::ID {
        arg0.registry
    }

    public fun paused(arg0: &Registry) : bool {
        arg0.paused
    }

    public fun record(arg0: &Registry, arg1: vector<u8>) : Record {
        *0x2::table::borrow<vector<u8>, Record>(&arg0.devices, arg1)
    }

    public fun record_first_seen_ms(arg0: &Record) : u64 {
        arg0.first_seen_ms
    }

    public fun record_holder(arg0: &Record) : address {
        arg0.holder
    }

    public fun record_number(arg0: &Record) : u64 {
        arg0.number
    }

    public fun record_pass(arg0: &Record) : 0x2::object::ID {
        arg0.pass
    }

    public fun record_seq(arg0: &Record) : u64 {
        arg0.seq
    }

    public fun set_issuer_key(arg0: &AdminCap, arg1: &mut Registry, arg2: vector<u8>) {
        assert_current(arg1);
        assert!(0x1::vector::is_empty<u8>(&arg2) || 0x1::vector::length<u8>(&arg2) == 32, 3);
        arg1.issuer_key = arg2;
        let v0 = IssuerKeySet{
            registry   : 0x2::object::id<Registry>(arg1),
            public_key : arg2,
        };
        0x2::event::emit<IssuerKeySet>(v0);
    }

    public fun set_paused(arg0: &AdminCap, arg1: &mut Registry, arg2: bool) {
        arg1.paused = arg2;
        let v0 = RegistryPaused{
            registry : 0x2::object::id<Registry>(arg1),
            paused   : arg2,
        };
        0x2::event::emit<RegistryPaused>(v0);
    }

    // decompiled from Move bytecode v7
}

