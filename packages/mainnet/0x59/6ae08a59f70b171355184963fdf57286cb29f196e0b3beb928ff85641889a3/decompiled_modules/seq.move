module 0x596ae08a59f70b171355184963fdf57286cb29f196e0b3beb928ff85641889a3::seq {
    struct Seq has key {
        id: 0x2::object::UID,
        owner: address,
        value: u64,
    }

    public fun bump(arg0: &mut Seq, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 1);
        arg0.value = arg0.value + 1;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Seq{
            id    : 0x2::object::new(arg0),
            owner : 0x2::tx_context::sender(arg0),
            value : 0,
        };
        0x2::transfer::share_object<Seq>(v0);
    }

    public fun value(arg0: &Seq) : u64 {
        arg0.value
    }

    // decompiled from Move bytecode v7
}

