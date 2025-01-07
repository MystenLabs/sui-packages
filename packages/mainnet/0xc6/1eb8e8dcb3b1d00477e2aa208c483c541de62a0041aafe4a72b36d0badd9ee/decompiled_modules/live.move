module 0xc61eb8e8dcb3b1d00477e2aa208c483c541de62a0041aafe4a72b36d0badd9ee::live {
    struct Hero has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
    }

    public fun new(arg0: 0x1::string::String, arg1: &mut 0x2::tx_context::TxContext) : Hero {
        Hero{
            id   : 0x2::object::new(arg1),
            name : arg0,
        }
    }

    public fun noop<T0>() {
    }

    public fun set_name(arg0: &mut Hero, arg1: 0x1::string::String) {
        arg0.name = arg1;
    }

    // decompiled from Move bytecode v6
}

