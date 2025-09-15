module 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::oapp_registry {
    struct OAppRegistry has store {
        oapps: 0x2::table::Table<address, OAppInfo>,
    }

    struct OAppInfo has store {
        messaging_channel: address,
        lz_receive_info: vector<u8>,
        delegate: address,
    }

    struct OAppRegisteredEvent has copy, drop {
        oapp: address,
        messaging_channel: address,
        lz_receive_info: vector<u8>,
    }

    struct LzReceiveInfoSetEvent has copy, drop {
        oapp: address,
        lz_receive_info: vector<u8>,
    }

    struct DelegateSetEvent has copy, drop {
        oapp: address,
        delegate: address,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : OAppRegistry {
        OAppRegistry{oapps: 0x2::table::new<address, OAppInfo>(arg0)}
    }

    public(friend) fun assert_registered(arg0: &OAppRegistry, arg1: address) {
        assert!(is_registered(arg0, arg1), 2);
    }

    public(friend) fun get_delegate(arg0: &OAppRegistry, arg1: address) : address {
        let v0 = &arg0.oapps;
        assert!(0x2::table::contains<address, OAppInfo>(v0, arg1), 2);
        0x2::table::borrow<address, OAppInfo>(v0, arg1).delegate
    }

    public(friend) fun get_lz_receive_info(arg0: &OAppRegistry, arg1: address) : &vector<u8> {
        let v0 = &arg0.oapps;
        assert!(0x2::table::contains<address, OAppInfo>(v0, arg1), 2);
        &0x2::table::borrow<address, OAppInfo>(v0, arg1).lz_receive_info
    }

    public(friend) fun get_messaging_channel(arg0: &OAppRegistry, arg1: address) : address {
        let v0 = &arg0.oapps;
        assert!(0x2::table::contains<address, OAppInfo>(v0, arg1), 2);
        0x2::table::borrow<address, OAppInfo>(v0, arg1).messaging_channel
    }

    public(friend) fun is_registered(arg0: &OAppRegistry, arg1: address) : bool {
        0x2::table::contains<address, OAppInfo>(&arg0.oapps, arg1)
    }

    public(friend) fun register_oapp(arg0: &mut OAppRegistry, arg1: address, arg2: address, arg3: vector<u8>) {
        assert!(!is_registered(arg0, arg1), 3);
        assert!(0x1::vector::length<u8>(&arg3) > 0, 1);
        let v0 = OAppInfo{
            messaging_channel : arg2,
            lz_receive_info   : arg3,
            delegate          : @0x0,
        };
        0x2::table::add<address, OAppInfo>(&mut arg0.oapps, arg1, v0);
        let v1 = OAppRegisteredEvent{
            oapp              : arg1,
            messaging_channel : arg2,
            lz_receive_info   : arg3,
        };
        0x2::event::emit<OAppRegisteredEvent>(v1);
    }

    public(friend) fun set_delegate(arg0: &mut OAppRegistry, arg1: address, arg2: address) {
        let v0 = &mut arg0.oapps;
        assert!(0x2::table::contains<address, OAppInfo>(v0, arg1), 2);
        0x2::table::borrow_mut<address, OAppInfo>(v0, arg1).delegate = arg2;
        let v1 = DelegateSetEvent{
            oapp     : arg1,
            delegate : arg2,
        };
        0x2::event::emit<DelegateSetEvent>(v1);
    }

    public(friend) fun set_lz_receive_info(arg0: &mut OAppRegistry, arg1: address, arg2: vector<u8>) {
        assert!(0x1::vector::length<u8>(&arg2) > 0, 1);
        let v0 = &mut arg0.oapps;
        assert!(0x2::table::contains<address, OAppInfo>(v0, arg1), 2);
        0x2::table::borrow_mut<address, OAppInfo>(v0, arg1).lz_receive_info = arg2;
        let v1 = LzReceiveInfoSetEvent{
            oapp            : arg1,
            lz_receive_info : arg2,
        };
        0x2::event::emit<LzReceiveInfoSetEvent>(v1);
    }

    // decompiled from Move bytecode v6
}

