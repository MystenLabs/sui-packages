module 0x46c87286892e4d0f5b59813d03d9c3e38d4d2eabbaea583cf5ab539a47baae9::round_seq {
    struct RoundSeq has store, key {
        id: 0x2::object::UID,
        round: 0x2::table::Table<0x1::type_name::TypeName, u64>,
    }

    public fun get_next_round(arg0: &mut RoundSeq, arg1: 0x1::type_name::TypeName) : u64 {
        if (!0x2::table::contains<0x1::type_name::TypeName, u64>(&arg0.round, arg1)) {
            0x2::table::add<0x1::type_name::TypeName, u64>(&mut arg0.round, arg1, 0);
        };
        let v0 = 0x2::table::borrow_mut<0x1::type_name::TypeName, u64>(&mut arg0.round, arg1);
        *v0 = *v0 + 1;
        *v0
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = RoundSeq{
            id    : 0x2::object::new(arg0),
            round : 0x2::table::new<0x1::type_name::TypeName, u64>(arg0),
        };
        0x2::transfer::transfer<RoundSeq>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

