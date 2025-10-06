module 0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::alpha {
    struct Alpha has key {
        id: 0x2::object::UID,
        version: u256,
        admin: address,
        bag: 0x2::object_bag::ObjectBag,
    }

    public(friend) fun add_value<T0: store + key>(arg0: &mut Alpha, arg1: 0x1::string::String, arg2: T0) {
        0x2::object_bag::add<0x1::string::String, T0>(&mut arg0.bag, arg1, arg2);
    }

    public(friend) fun get_admin(arg0: &Alpha) : address {
        arg0.admin
    }

    public(friend) fun get_value<T0: store + key>(arg0: &mut Alpha, arg1: 0x1::string::String) : &mut T0 {
        0x2::object_bag::borrow_mut<0x1::string::String, T0>(&mut arg0.bag, arg1)
    }

    public(friend) fun has_value(arg0: &Alpha, arg1: 0x1::string::String) : bool {
        0x2::object_bag::contains<0x1::string::String>(&arg0.bag, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Alpha{
            id      : 0x2::object::new(arg0),
            version : 0,
            admin   : 0x2::tx_context::sender(arg0),
            bag     : 0x2::object_bag::new(arg0),
        };
        0x2::transfer::share_object<Alpha>(v0);
    }

    public(friend) fun to_timestamp(arg0: &0x2::clock::Clock) : u256 {
        (0x2::clock::timestamp_ms(arg0) as u256)
    }

    public(friend) fun to_u256(arg0: u64) : u256 {
        (arg0 as u256)
    }

    public(friend) fun to_u64(arg0: u256) : u64 {
        let v0 = 0x1::u256::try_as_u64(arg0);
        assert!(0x1::option::is_some<u64>(&v0), 13906834487875993599);
        *0x1::option::borrow<u64>(&v0)
    }

    entry fun upgrade(arg0: address, arg1: &mut Alpha, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0 == 0x2::tx_context::sender(arg2), 13906834324667236351);
        validate_admin(arg1, arg0);
        arg1.version = 1;
    }

    public(friend) fun validate_admin(arg0: &Alpha, arg1: address) {
        assert!(arg1 == arg0.admin, 13906834462106189823);
    }

    public(friend) fun validate_version(arg0: &Alpha) {
        assert!(arg0.version == 1, 13906834440631353343);
    }

    // decompiled from Move bytecode v6
}

