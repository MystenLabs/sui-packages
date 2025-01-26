module 0x4315ce9a3694eb800da3a9ac46ae56741565e1cf7003fa065fefdc25249d9f15::attend {
    struct Attend has key {
        id: 0x2::object::UID,
        student: address,
        count: u64,
    }

    public entry fun attend(arg0: &mut Attend) {
        arg0.count = arg0.count + 1;
    }

    public entry fun create(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Attend{
            id      : 0x2::object::new(arg0),
            student : 0x2::tx_context::sender(arg0),
            count   : 0,
        };
        0x2::transfer::share_object<Attend>(v0);
    }

    // decompiled from Move bytecode v6
}

