module 0x35cd5b4bd816efcb55a9705e6b28d15cf6d51e01267690dce7919fa18b726b4c::blast_fun {
    struct BLAST_FUN has drop {
        dummy_field: bool,
    }

    struct PackageWitness has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLAST_FUN, arg1: &mut 0x2::tx_context::TxContext) {
        0xde7a411dcc38f03fef78877747cc1027abe9009c054c831540e7f8a4128ad9b::package_version::keep<BLAST_FUN>(0xde7a411dcc38f03fef78877747cc1027abe9009c054c831540e7f8a4128ad9b::package_version::new_publication<BLAST_FUN, PackageWitness>(arg0, 7, arg1), arg1);
    }

    public(friend) fun package_witness() : PackageWitness {
        PackageWitness{dummy_field: false}
    }

    // decompiled from Move bytecode v7
}

