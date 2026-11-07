module 0xeb2962af03fa9ea824522e91b9a2130f1b2bef6841c92e33127dd7fdab768c64::blast_migrators {
    struct BLAST_MIGRATORS has drop {
        dummy_field: bool,
    }

    struct PackageWitness has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLAST_MIGRATORS, arg1: &mut 0x2::tx_context::TxContext) {
        0x7c323cdc962a2875a255ac79cd2fc595dc0a491beed896652fd5182b1820662b::package_version::keep<BLAST_MIGRATORS>(0x7c323cdc962a2875a255ac79cd2fc595dc0a491beed896652fd5182b1820662b::package_version::new_publication<BLAST_MIGRATORS, PackageWitness>(arg0, 0, arg1), arg1);
    }

    // decompiled from Move bytecode v7
}

