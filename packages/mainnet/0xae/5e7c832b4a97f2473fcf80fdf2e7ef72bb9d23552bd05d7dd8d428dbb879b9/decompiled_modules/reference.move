module 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::reference {
    struct Reference has copy, drop, store {
        ref: u64,
    }

    public fun decrease(arg0: &mut Reference) : u64 {
        arg0.ref = arg0.ref - 1;
        arg0.ref
    }

    public fun destroy(arg0: Reference) {
        assert!(is_zero(&arg0), 0);
        let Reference {  } = arg0;
    }

    public fun increase(arg0: &mut Reference) : u64 {
        arg0.ref = arg0.ref + 1;
        arg0.ref
    }

    public fun is_zero(arg0: &Reference) : bool {
        arg0.ref == 0
    }

    public fun new() : Reference {
        Reference{ref: 0}
    }

    public fun ref(arg0: &Reference) : u64 {
        arg0.ref
    }

    // decompiled from Move bytecode v6
}

