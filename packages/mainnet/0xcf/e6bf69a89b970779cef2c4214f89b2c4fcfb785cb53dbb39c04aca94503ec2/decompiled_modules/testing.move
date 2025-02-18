module 0xcfe6bf69a89b970779cef2c4214f89b2c4fcfb785cb53dbb39c04aca94503ec2::testing {
    struct BigObject has key {
        id: 0x2::object::UID,
        data: vector<u8>,
    }

    struct Event has copy, drop {
        data: vector<u8>,
    }

    public fun emit_event(arg0: &BigObject) {
        let v0 = Event{data: arg0.data};
        0x2::event::emit<Event>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0;
        while (v1 < 100) {
            0x1::vector::push_back<u8>(&mut v0, (v1 as u8));
            v1 = v1 + 1;
        };
        let v2 = BigObject{
            id   : 0x2::object::new(arg0),
            data : v0,
        };
        0x2::transfer::share_object<BigObject>(v2);
    }

    public fun mutate(arg0: &mut BigObject) {
        0x1::vector::push_back<u8>(&mut arg0.data, 1);
    }

    public fun read(arg0: &BigObject) {
        assert!(0x1::vector::length<u8>(&arg0.data) >= 0, 0);
    }

    public fun resize(arg0: &mut BigObject, arg1: u64) {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0;
        while (v1 < arg1) {
            0x1::vector::push_back<u8>(&mut v0, ((v1 % 256) as u8));
            v1 = v1 + 1;
        };
        arg0.data = v0;
    }

    // decompiled from Move bytecode v6
}

