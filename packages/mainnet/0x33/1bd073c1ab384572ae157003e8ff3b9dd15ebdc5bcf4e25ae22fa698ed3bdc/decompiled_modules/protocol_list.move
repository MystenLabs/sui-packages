module 0x331bd073c1ab384572ae157003e8ff3b9dd15ebdc5bcf4e25ae22fa698ed3bdc::protocol_list {
    struct PROTOCOL_LIST has drop {
        dummy_field: bool,
    }

    struct Protocol<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct ProtocolList has store, key {
        id: 0x2::object::UID,
        list: 0x2::bag::Bag,
    }

    fun init(arg0: PROTOCOL_LIST, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = ProtocolList{
            id   : 0x2::object::new(arg1),
            list : 0x2::bag::new(arg1),
        };
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<PROTOCOL_LIST>(arg0, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<ProtocolList>(v0);
    }

    public(friend) fun proove<T0>(arg0: &ProtocolList) {
        let v0 = Protocol<T0>{dummy_field: false};
        assert!(0x2::bag::contains<Protocol<T0>>(&arg0.list, v0), 1);
    }

    public entry fun register_protocol<T0>(arg0: &0x2::package::Publisher, arg1: &mut ProtocolList) {
        assert!(0x2::package::from_package<PROTOCOL_LIST>(arg0), 0);
        let v0 = Protocol<T0>{dummy_field: false};
        0x2::bag::add<Protocol<T0>, bool>(&mut arg1.list, v0, true);
    }

    // decompiled from Move bytecode v6
}

