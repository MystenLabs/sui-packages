module 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::oapp_registry {
    struct OAppRegistry has store {
        oapps: 0x2::table::Table<address, OAppRegistration>,
    }

    struct OAppRegistration has store {
        messaging_channel: address,
        oapp_info: vector<u8>,
        delegate: address,
    }

    struct OAppRegisteredEvent has copy, drop {
        oapp: address,
        messaging_channel: address,
        oapp_info: vector<u8>,
    }

    struct OAppInfoSetEvent has copy, drop {
        oapp: address,
        oapp_info: vector<u8>,
    }

    struct DelegateSetEvent has copy, drop {
        oapp: address,
        delegate: address,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : OAppRegistry {
        OAppRegistry{oapps: 0x2::table::new<address, OAppRegistration>(arg0)}
    }

    public(friend) fun assert_registered(arg0: &OAppRegistry, arg1: address) {
        assert!(is_registered(arg0, arg1), 1);
    }

    public(friend) fun get_delegate(arg0: &OAppRegistry, arg1: address) : address {
        let v0 = &arg0.oapps;
        assert!(0x2::table::contains<address, OAppRegistration>(v0, arg1), 1);
        0x2::table::borrow<address, OAppRegistration>(v0, arg1).delegate
    }

    public(friend) fun get_messaging_channel(arg0: &OAppRegistry, arg1: address) : address {
        let v0 = &arg0.oapps;
        assert!(0x2::table::contains<address, OAppRegistration>(v0, arg1), 1);
        0x2::table::borrow<address, OAppRegistration>(v0, arg1).messaging_channel
    }

    public(friend) fun get_oapp_info(arg0: &OAppRegistry, arg1: address) : &vector<u8> {
        let v0 = &arg0.oapps;
        assert!(0x2::table::contains<address, OAppRegistration>(v0, arg1), 1);
        &0x2::table::borrow<address, OAppRegistration>(v0, arg1).oapp_info
    }

    public(friend) fun is_registered(arg0: &OAppRegistry, arg1: address) : bool {
        0x2::table::contains<address, OAppRegistration>(&arg0.oapps, arg1)
    }

    public(friend) fun register_oapp(arg0: &mut OAppRegistry, arg1: address, arg2: address, arg3: vector<u8>) {
        assert!(!is_registered(arg0, arg1), 2);
        let v0 = OAppRegistration{
            messaging_channel : arg2,
            oapp_info         : arg3,
            delegate          : @0x0,
        };
        0x2::table::add<address, OAppRegistration>(&mut arg0.oapps, arg1, v0);
        let v1 = OAppRegisteredEvent{
            oapp              : arg1,
            messaging_channel : arg2,
            oapp_info         : arg3,
        };
        0x2::event::emit<OAppRegisteredEvent>(v1);
    }

    public(friend) fun set_delegate(arg0: &mut OAppRegistry, arg1: address, arg2: address) {
        let v0 = &mut arg0.oapps;
        assert!(0x2::table::contains<address, OAppRegistration>(v0, arg1), 1);
        0x2::table::borrow_mut<address, OAppRegistration>(v0, arg1).delegate = arg2;
        let v1 = DelegateSetEvent{
            oapp     : arg1,
            delegate : arg2,
        };
        0x2::event::emit<DelegateSetEvent>(v1);
    }

    public(friend) fun set_oapp_info(arg0: &mut OAppRegistry, arg1: address, arg2: vector<u8>) {
        let v0 = &mut arg0.oapps;
        assert!(0x2::table::contains<address, OAppRegistration>(v0, arg1), 1);
        0x2::table::borrow_mut<address, OAppRegistration>(v0, arg1).oapp_info = arg2;
        let v1 = OAppInfoSetEvent{
            oapp      : arg1,
            oapp_info : arg2,
        };
        0x2::event::emit<OAppInfoSetEvent>(v1);
    }

    // decompiled from Move bytecode v6
}

