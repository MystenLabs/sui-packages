module 0x1f44a8e9fab4380228fe9c1bcc27d99b7f6ea76a8e18b5c178ca18cd46fb33c4::blast_presale_package {
    struct BLAST_PRESALE_PACKAGE has drop {
        dummy_field: bool,
    }

    struct PackageWitness has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLAST_PRESALE_PACKAGE, arg1: &mut 0x2::tx_context::TxContext) {
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::package_version::keep<BLAST_PRESALE_PACKAGE>(0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::package_version::new_publication<BLAST_PRESALE_PACKAGE, PackageWitness>(arg0, 7, arg1), arg1);
    }

    public(friend) fun package_witness() : PackageWitness {
        PackageWitness{dummy_field: false}
    }

    // decompiled from Move bytecode v7
}

