module 0x425b9ea4a9d02465f804d05a2560e5dc206d20138e5c0bf3b413c4c7b3ca1efe::settlement {
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

