module 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::message_lib_manager {
    struct MessageLibManager has store {
        registry: MessageLibRegistry,
        default_configs: 0x2::table::Table<u32, MessageLibConfig>,
        oapp_configs: 0x2::table::Table<OAppConfigKey, MessageLibConfig>,
    }

    struct MessageLibRegistry has store {
        libs: 0x2::table_vec::TableVec<address>,
        lib_to_type: 0x2::table::Table<address, 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::message_lib_type::MessageLibType>,
    }

    struct MessageLibConfig has copy, drop, store {
        send_lib: address,
        receive_lib: address,
        receive_lib_timeout: 0x1::option::Option<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::timeout::Timeout>,
    }

    struct OAppConfigKey has copy, drop, store {
        oapp: address,
        eid: u32,
    }

    struct LibraryRegisteredEvent has copy, drop {
        new_lib: address,
        lib_type: 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::message_lib_type::MessageLibType,
    }

    struct DefaultSendLibrarySetEvent has copy, drop {
        dst_eid: u32,
        new_lib: address,
    }

    struct DefaultReceiveLibrarySetEvent has copy, drop {
        src_eid: u32,
        new_lib: address,
    }

    struct DefaultReceiveLibraryTimeoutSetEvent has copy, drop {
        src_eid: u32,
        old_lib: address,
        expiry: u64,
    }

    struct SendLibrarySetEvent has copy, drop {
        sender: address,
        dst_eid: u32,
        new_lib: address,
    }

    struct ReceiveLibrarySetEvent has copy, drop {
        receiver: address,
        src_eid: u32,
        new_lib: address,
    }

    struct ReceiveLibraryTimeoutSetEvent has copy, drop {
        receiver: address,
        src_eid: u32,
        old_lib: address,
        expiry: u64,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : MessageLibManager {
        let v0 = MessageLibRegistry{
            libs        : 0x2::table_vec::empty<address>(arg0),
            lib_to_type : 0x2::table::new<address, 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::message_lib_type::MessageLibType>(arg0),
        };
        MessageLibManager{
            registry        : v0,
            default_configs : 0x2::table::new<u32, MessageLibConfig>(arg0),
            oapp_configs    : 0x2::table::new<OAppConfigKey, MessageLibConfig>(arg0),
        }
    }

    fun assert_default_receive_library_configured(arg0: &MessageLibManager, arg1: u32) {
        let v0 = &arg0.default_configs;
        let v1 = if (0x2::table::contains<u32, MessageLibConfig>(v0, arg1)) {
            0x2::table::borrow<u32, MessageLibConfig>(v0, arg1)
        } else {
            let v2 = MessageLibConfig{
                send_lib            : @0x0,
                receive_lib         : @0x0,
                receive_lib_timeout : 0x1::option::none<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::timeout::Timeout>(),
            };
            &v2
        };
        assert!(v1.receive_lib != @0x0, 2);
    }

    fun assert_default_send_library_configured(arg0: &MessageLibManager, arg1: u32) {
        let v0 = &arg0.default_configs;
        let v1 = if (0x2::table::contains<u32, MessageLibConfig>(v0, arg1)) {
            0x2::table::borrow<u32, MessageLibConfig>(v0, arg1)
        } else {
            let v2 = MessageLibConfig{
                send_lib            : @0x0,
                receive_lib         : @0x0,
                receive_lib_timeout : 0x1::option::none<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::timeout::Timeout>(),
            };
            &v2
        };
        assert!(v1.send_lib != @0x0, 3);
    }

    public(friend) fun assert_receive_library(arg0: &MessageLibManager, arg1: address, arg2: u32, arg3: address, arg4: &0x2::clock::Clock) {
        assert!(is_valid_receive_library(arg0, arg1, arg2, arg3, arg4), 7);
    }

    fun assert_receive_library_type(arg0: &MessageLibManager, arg1: address) {
        let v0 = get_library_type(arg0, arg1);
        assert!(v0 == 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::message_lib_type::receive() || v0 == 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::message_lib_type::send_and_receive(), 9);
    }

    fun assert_registered_library(arg0: &MessageLibManager, arg1: address) {
        assert!(0x2::table::contains<address, 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::message_lib_type::MessageLibType>(&arg0.registry.lib_to_type, arg1), 10);
    }

    fun assert_send_library_type(arg0: &MessageLibManager, arg1: address) {
        let v0 = get_library_type(arg0, arg1);
        assert!(v0 == 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::message_lib_type::send() || v0 == 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::message_lib_type::send_and_receive(), 11);
    }

    public(friend) fun get_default_receive_library(arg0: &MessageLibManager, arg1: u32) : address {
        assert_default_receive_library_configured(arg0, arg1);
        0x2::table::borrow<u32, MessageLibConfig>(&arg0.default_configs, arg1).receive_lib
    }

    public(friend) fun get_default_receive_library_timeout(arg0: &MessageLibManager, arg1: u32) : 0x1::option::Option<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::timeout::Timeout> {
        assert_default_receive_library_configured(arg0, arg1);
        0x2::table::borrow<u32, MessageLibConfig>(&arg0.default_configs, arg1).receive_lib_timeout
    }

    public(friend) fun get_default_send_library(arg0: &MessageLibManager, arg1: u32) : address {
        assert_default_send_library_configured(arg0, arg1);
        0x2::table::borrow<u32, MessageLibConfig>(&arg0.default_configs, arg1).send_lib
    }

    public(friend) fun get_library_type(arg0: &MessageLibManager, arg1: address) : 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::message_lib_type::MessageLibType {
        let v0 = &arg0.registry.lib_to_type;
        assert!(0x2::table::contains<address, 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::message_lib_type::MessageLibType>(v0, arg1), 10);
        *0x2::table::borrow<address, 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::message_lib_type::MessageLibType>(v0, arg1)
    }

    public(friend) fun get_receive_library(arg0: &MessageLibManager, arg1: address, arg2: u32) : (address, bool) {
        let v0 = &arg0.oapp_configs;
        let v1 = OAppConfigKey{
            oapp : arg1,
            eid  : arg2,
        };
        let v2 = if (0x2::table::contains<OAppConfigKey, MessageLibConfig>(v0, v1)) {
            let v3 = OAppConfigKey{
                oapp : arg1,
                eid  : arg2,
            };
            0x2::table::borrow<OAppConfigKey, MessageLibConfig>(v0, v3)
        } else {
            let v4 = MessageLibConfig{
                send_lib            : @0x0,
                receive_lib         : @0x0,
                receive_lib_timeout : 0x1::option::none<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::timeout::Timeout>(),
            };
            &v4
        };
        if (v2.receive_lib != @0x0) {
            (v2.receive_lib, false)
        } else {
            (get_default_receive_library(arg0, arg2), true)
        }
    }

    public(friend) fun get_receive_library_timeout(arg0: &MessageLibManager, arg1: address, arg2: u32) : 0x1::option::Option<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::timeout::Timeout> {
        let v0 = &arg0.oapp_configs;
        let v1 = OAppConfigKey{
            oapp : arg1,
            eid  : arg2,
        };
        let v2 = if (0x2::table::contains<OAppConfigKey, MessageLibConfig>(v0, v1)) {
            let v3 = OAppConfigKey{
                oapp : arg1,
                eid  : arg2,
            };
            0x2::table::borrow<OAppConfigKey, MessageLibConfig>(v0, v3)
        } else {
            let v4 = MessageLibConfig{
                send_lib            : @0x0,
                receive_lib         : @0x0,
                receive_lib_timeout : 0x1::option::none<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::timeout::Timeout>(),
            };
            &v4
        };
        v2.receive_lib_timeout
    }

    public(friend) fun get_send_library(arg0: &MessageLibManager, arg1: address, arg2: u32) : (address, bool) {
        let v0 = &arg0.oapp_configs;
        let v1 = OAppConfigKey{
            oapp : arg1,
            eid  : arg2,
        };
        let v2 = if (0x2::table::contains<OAppConfigKey, MessageLibConfig>(v0, v1)) {
            let v3 = OAppConfigKey{
                oapp : arg1,
                eid  : arg2,
            };
            0x2::table::borrow<OAppConfigKey, MessageLibConfig>(v0, v3)
        } else {
            let v4 = MessageLibConfig{
                send_lib            : @0x0,
                receive_lib         : @0x0,
                receive_lib_timeout : 0x1::option::none<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::timeout::Timeout>(),
            };
            &v4
        };
        if (v2.send_lib != @0x0) {
            (v2.send_lib, false)
        } else {
            (get_default_send_library(arg0, arg2), true)
        }
    }

    public(friend) fun is_registered_library(arg0: &MessageLibManager, arg1: address) : bool {
        0x2::table::contains<address, 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::message_lib_type::MessageLibType>(&arg0.registry.lib_to_type, arg1)
    }

    public(friend) fun is_supported_eid(arg0: &MessageLibManager, arg1: u32) : bool {
        if (0x2::table::contains<u32, MessageLibConfig>(&arg0.default_configs, arg1)) {
            if (0x2::table::borrow<u32, MessageLibConfig>(&arg0.default_configs, arg1).send_lib != @0x0) {
                0x2::table::borrow<u32, MessageLibConfig>(&arg0.default_configs, arg1).receive_lib != @0x0
            } else {
                false
            }
        } else {
            false
        }
    }

    public(friend) fun is_valid_receive_library(arg0: &MessageLibManager, arg1: address, arg2: u32, arg3: address, arg4: &0x2::clock::Clock) : bool {
        let (v0, v1) = get_receive_library(arg0, arg1, arg2);
        if (arg3 == v0) {
            return true
        };
        let v2 = if (v1) {
            0x2::table::borrow<u32, MessageLibConfig>(&arg0.default_configs, arg2).receive_lib_timeout
        } else {
            let v3 = OAppConfigKey{
                oapp : arg1,
                eid  : arg2,
            };
            0x2::table::borrow<OAppConfigKey, MessageLibConfig>(&arg0.oapp_configs, v3).receive_lib_timeout
        };
        let v4 = v2;
        if (0x1::option::is_none<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::timeout::Timeout>(&v4)) {
            false
        } else {
            let v6 = 0x1::option::destroy_some<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::timeout::Timeout>(v4);
            !0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::timeout::is_expired(&v6, arg4) && 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::timeout::fallback_lib(&v6) == arg3
        }
    }

    public(friend) fun register_library(arg0: &mut MessageLibManager, arg1: address, arg2: 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::message_lib_type::MessageLibType) {
        assert!(!0x2::table::contains<address, 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::message_lib_type::MessageLibType>(&arg0.registry.lib_to_type, arg1), 1);
        assert!(arg1 != @0x0, 4);
        0x2::table_vec::push_back<address>(&mut arg0.registry.libs, arg1);
        0x2::table::add<address, 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::message_lib_type::MessageLibType>(&mut arg0.registry.lib_to_type, arg1, arg2);
        let v0 = LibraryRegisteredEvent{
            new_lib  : arg1,
            lib_type : arg2,
        };
        0x2::event::emit<LibraryRegisteredEvent>(v0);
    }

    public(friend) fun registered_libraries(arg0: &MessageLibManager, arg1: u64, arg2: u64) : vector<address> {
        let v0 = 0x1::u64::min(arg1 + arg2, registered_libraries_count(arg0));
        assert!(arg1 <= v0, 5);
        let v1 = vector[];
        let v2 = 0;
        while (v2 < v0 - arg1) {
            0x1::vector::push_back<address>(&mut v1, *0x2::table_vec::borrow<address>(&arg0.registry.libs, arg1 + v2));
            v2 = v2 + 1;
        };
        v1
    }

    public(friend) fun registered_libraries_count(arg0: &MessageLibManager) : u64 {
        0x2::table_vec::length<address>(&arg0.registry.libs)
    }

    public(friend) fun set_config(arg0: &MessageLibManager, arg1: address, arg2: address, arg3: u32, arg4: u32, arg5: vector<u8>) : 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::message_lib_set_config::SetConfigParam {
        assert_registered_library(arg0, arg2);
        0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::message_lib_set_config::create_param(arg1, arg3, arg4, arg5)
    }

    public(friend) fun set_default_receive_library(arg0: &mut MessageLibManager, arg1: u32, arg2: address, arg3: u64, arg4: &0x2::clock::Clock) {
        assert_receive_library_type(arg0, arg2);
        let v0 = &mut arg0.default_configs;
        if (!0x2::table::contains<u32, MessageLibConfig>(v0, arg1)) {
            let v1 = MessageLibConfig{
                send_lib            : @0x0,
                receive_lib         : @0x0,
                receive_lib_timeout : 0x1::option::none<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::timeout::Timeout>(),
            };
            0x2::table::add<u32, MessageLibConfig>(v0, arg1, v1);
        };
        let v2 = 0x2::table::borrow_mut<u32, MessageLibConfig>(v0, arg1);
        let v3 = v2.receive_lib;
        assert!(v3 != arg2, 12);
        v2.receive_lib = arg2;
        let v4 = DefaultReceiveLibrarySetEvent{
            src_eid : arg1,
            new_lib : arg2,
        };
        0x2::event::emit<DefaultReceiveLibrarySetEvent>(v4);
        let v5 = if (arg3 > 0) {
            let v6 = 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::timeout::create_with_grace_period(arg3, v3, arg4);
            v2.receive_lib_timeout = 0x1::option::some<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::timeout::Timeout>(v6);
            0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::timeout::expiry(&v6)
        } else {
            v2.receive_lib_timeout = 0x1::option::none<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::timeout::Timeout>();
            0
        };
        let v7 = DefaultReceiveLibraryTimeoutSetEvent{
            src_eid : arg1,
            old_lib : v3,
            expiry  : v5,
        };
        0x2::event::emit<DefaultReceiveLibraryTimeoutSetEvent>(v7);
    }

    public(friend) fun set_default_receive_library_timeout(arg0: &mut MessageLibManager, arg1: u32, arg2: address, arg3: u64, arg4: &0x2::clock::Clock) {
        assert_receive_library_type(arg0, arg2);
        let v0 = 0x2::table::borrow_mut<u32, MessageLibConfig>(&mut arg0.default_configs, arg1);
        if (arg3 > 0) {
            let v1 = 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::timeout::create(arg3, arg2);
            assert!(!0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::timeout::is_expired(&v1, arg4), 6);
            v0.receive_lib_timeout = 0x1::option::some<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::timeout::Timeout>(v1);
        } else {
            v0.receive_lib_timeout = 0x1::option::none<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::timeout::Timeout>();
        };
        let v2 = DefaultReceiveLibraryTimeoutSetEvent{
            src_eid : arg1,
            old_lib : arg2,
            expiry  : arg3,
        };
        0x2::event::emit<DefaultReceiveLibraryTimeoutSetEvent>(v2);
    }

    public(friend) fun set_default_send_library(arg0: &mut MessageLibManager, arg1: u32, arg2: address) {
        assert_send_library_type(arg0, arg2);
        let v0 = &mut arg0.default_configs;
        if (!0x2::table::contains<u32, MessageLibConfig>(v0, arg1)) {
            let v1 = MessageLibConfig{
                send_lib            : @0x0,
                receive_lib         : @0x0,
                receive_lib_timeout : 0x1::option::none<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::timeout::Timeout>(),
            };
            0x2::table::add<u32, MessageLibConfig>(v0, arg1, v1);
        };
        let v2 = 0x2::table::borrow_mut<u32, MessageLibConfig>(v0, arg1);
        assert!(v2.send_lib != arg2, 12);
        v2.send_lib = arg2;
        let v3 = DefaultSendLibrarySetEvent{
            dst_eid : arg1,
            new_lib : arg2,
        };
        0x2::event::emit<DefaultSendLibrarySetEvent>(v3);
    }

    public(friend) fun set_receive_library(arg0: &mut MessageLibManager, arg1: address, arg2: u32, arg3: address, arg4: u64, arg5: &0x2::clock::Clock) {
        if (arg3 != @0x0) {
            assert_receive_library_type(arg0, arg3);
        };
        assert_default_receive_library_configured(arg0, arg2);
        let v0 = &mut arg0.oapp_configs;
        let v1 = OAppConfigKey{
            oapp : arg1,
            eid  : arg2,
        };
        if (!0x2::table::contains<OAppConfigKey, MessageLibConfig>(v0, v1)) {
            let v2 = OAppConfigKey{
                oapp : arg1,
                eid  : arg2,
            };
            let v3 = MessageLibConfig{
                send_lib            : @0x0,
                receive_lib         : @0x0,
                receive_lib_timeout : 0x1::option::none<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::timeout::Timeout>(),
            };
            0x2::table::add<OAppConfigKey, MessageLibConfig>(v0, v2, v3);
        };
        let v4 = OAppConfigKey{
            oapp : arg1,
            eid  : arg2,
        };
        let v5 = 0x2::table::borrow_mut<OAppConfigKey, MessageLibConfig>(v0, v4);
        let v6 = v5.receive_lib;
        assert!(v6 != arg3, 12);
        v5.receive_lib = arg3;
        let v7 = ReceiveLibrarySetEvent{
            receiver : arg1,
            src_eid  : arg2,
            new_lib  : arg3,
        };
        0x2::event::emit<ReceiveLibrarySetEvent>(v7);
        let v8 = if (arg4 > 0) {
            assert!(v6 != @0x0 && arg3 != @0x0, 8);
            let v9 = 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::timeout::create_with_grace_period(arg4, v6, arg5);
            v5.receive_lib_timeout = 0x1::option::some<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::timeout::Timeout>(v9);
            0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::timeout::expiry(&v9)
        } else {
            v5.receive_lib_timeout = 0x1::option::none<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::timeout::Timeout>();
            0
        };
        let v10 = ReceiveLibraryTimeoutSetEvent{
            receiver : arg1,
            src_eid  : arg2,
            old_lib  : v6,
            expiry   : v8,
        };
        0x2::event::emit<ReceiveLibraryTimeoutSetEvent>(v10);
    }

    public(friend) fun set_receive_library_timeout(arg0: &mut MessageLibManager, arg1: address, arg2: u32, arg3: address, arg4: u64, arg5: &0x2::clock::Clock) {
        assert_receive_library_type(arg0, arg3);
        assert_default_receive_library_configured(arg0, arg2);
        let (_, v1) = get_receive_library(arg0, arg1, arg2);
        assert!(!v1, 8);
        let v2 = OAppConfigKey{
            oapp : arg1,
            eid  : arg2,
        };
        let v3 = 0x2::table::borrow_mut<OAppConfigKey, MessageLibConfig>(&mut arg0.oapp_configs, v2);
        if (arg4 > 0) {
            let v4 = 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::timeout::create(arg4, arg3);
            assert!(!0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::timeout::is_expired(&v4, arg5), 6);
            v3.receive_lib_timeout = 0x1::option::some<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::timeout::Timeout>(v4);
        } else {
            v3.receive_lib_timeout = 0x1::option::none<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::timeout::Timeout>();
        };
        let v5 = ReceiveLibraryTimeoutSetEvent{
            receiver : arg1,
            src_eid  : arg2,
            old_lib  : arg3,
            expiry   : arg4,
        };
        0x2::event::emit<ReceiveLibraryTimeoutSetEvent>(v5);
    }

    public(friend) fun set_send_library(arg0: &mut MessageLibManager, arg1: address, arg2: u32, arg3: address) {
        if (arg3 != @0x0) {
            assert_send_library_type(arg0, arg3);
        };
        assert_default_send_library_configured(arg0, arg2);
        let v0 = &mut arg0.oapp_configs;
        let v1 = OAppConfigKey{
            oapp : arg1,
            eid  : arg2,
        };
        if (!0x2::table::contains<OAppConfigKey, MessageLibConfig>(v0, v1)) {
            let v2 = OAppConfigKey{
                oapp : arg1,
                eid  : arg2,
            };
            let v3 = MessageLibConfig{
                send_lib            : @0x0,
                receive_lib         : @0x0,
                receive_lib_timeout : 0x1::option::none<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::timeout::Timeout>(),
            };
            0x2::table::add<OAppConfigKey, MessageLibConfig>(v0, v2, v3);
        };
        let v4 = OAppConfigKey{
            oapp : arg1,
            eid  : arg2,
        };
        let v5 = 0x2::table::borrow_mut<OAppConfigKey, MessageLibConfig>(v0, v4);
        assert!(v5.send_lib != arg3, 12);
        v5.send_lib = arg3;
        let v6 = SendLibrarySetEvent{
            sender  : arg1,
            dst_eid : arg2,
            new_lib : arg3,
        };
        0x2::event::emit<SendLibrarySetEvent>(v6);
    }

    // decompiled from Move bytecode v6
}

