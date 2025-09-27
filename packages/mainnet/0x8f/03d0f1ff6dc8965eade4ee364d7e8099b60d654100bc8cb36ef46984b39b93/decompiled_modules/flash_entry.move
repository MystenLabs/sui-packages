module 0x8f03d0f1ff6dc8965eade4ee364d7e8099b60d654100bc8cb36ef46984b39b93::flash_entry {
    struct Ping has copy, drop {
        who: address,
        amount: u64,
    }

    public entry fun execute(arg0: address, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Ping{
            who    : arg0,
            amount : arg1,
        };
        0x2::event::emit<Ping>(v0);
    }

    // decompiled from Move bytecode v6
}

