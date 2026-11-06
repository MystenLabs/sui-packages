module 0xb8146388d5098524e767a8708354e5390d69ebb2840835d4426cd180df898df4::blast_migrators {
    struct BLAST_MIGRATORS has drop {
        dummy_field: bool,
    }

    struct PackageWitness has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLAST_MIGRATORS, arg1: &mut 0x2::tx_context::TxContext) {
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::package_version::keep<BLAST_MIGRATORS>(0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::package_version::new_publication<BLAST_MIGRATORS, PackageWitness>(arg0, 0, arg1), arg1);
    }

    // decompiled from Move bytecode v7
}

