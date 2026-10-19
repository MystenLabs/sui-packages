module 0x198be198c8aa7abd93aeb3819e729046f39f578ade5b4625c0b7ad18d8b1cd88::settlement {
    struct Settled has copy, drop {
        amount: u64,
    }

    public fun settle<T0>(arg0: 0x2::balance::Balance<T0>) {
        let v0 = Settled{amount: 0x2::balance::value<T0>(&arg0)};
        0x2::event::emit<Settled>(v0);
        0x2::balance::send_funds<T0>(arg0, @0x4a70df52c007f98faffc50cbad2fedc6c0eeb5374ccee91a04c9a74dcfd4f962);
    }

    // decompiled from Move bytecode v7
}

