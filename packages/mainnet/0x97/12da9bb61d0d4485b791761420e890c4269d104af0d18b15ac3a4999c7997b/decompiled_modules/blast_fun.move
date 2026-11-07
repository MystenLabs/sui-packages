module 0x9712da9bb61d0d4485b791761420e890c4269d104af0d18b15ac3a4999c7997b::blast_fun {
    struct BLAST_FUN has drop {
        dummy_field: bool,
    }

    struct PackageWitness has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLAST_FUN, arg1: &mut 0x2::tx_context::TxContext) {
        0xe22a044624d16ccc9096f36cb30d4607d66eee0a2633f28137e1193bc8fc9333::package_version::keep<BLAST_FUN>(0xe22a044624d16ccc9096f36cb30d4607d66eee0a2633f28137e1193bc8fc9333::package_version::new_publication<BLAST_FUN, PackageWitness>(arg0, 7, arg1), arg1);
    }

    public(friend) fun package_witness() : PackageWitness {
        PackageWitness{dummy_field: false}
    }

    // decompiled from Move bytecode v7
}

