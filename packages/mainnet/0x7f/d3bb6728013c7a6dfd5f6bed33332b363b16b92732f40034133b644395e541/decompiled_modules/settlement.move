module 0x7fd3bb6728013c7a6dfd5f6bed33332b363b16b92732f40034133b644395e541::settlement {
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

