module 0x8939f0b2d43a66890ee4f0676c5ba5207f5daecc8c96d8d1166bbb72c549d885::c {
    struct C has store, key {
        id: 0x2::object::UID,
        t: u64,
        a: address,
    }

    public(friend) fun a(arg0: &C) : address {
        arg0.a
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = C{
            id : 0x2::object::new(arg0),
            t  : 30000000,
            a  : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::public_share_object<C>(v0);
    }

    public fun set_a(arg0: &mut C, arg1: &0x8939f0b2d43a66890ee4f0676c5ba5207f5daecc8c96d8d1166bbb72c549d885::a::AC, arg2: address) {
        arg0.a = arg2;
    }

    public fun set_t(arg0: &mut C, arg1: &0x8939f0b2d43a66890ee4f0676c5ba5207f5daecc8c96d8d1166bbb72c549d885::a::AC, arg2: u64) {
        arg0.t = arg2;
    }

    public(friend) fun t(arg0: &C) : u64 {
        arg0.t
    }

    // decompiled from Move bytecode v6
}

