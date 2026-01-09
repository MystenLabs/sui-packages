module 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::dna {
    struct Dna has copy, drop, store {
        unique_dna: vector<u8>,
        manifest_dna: vector<u8>,
    }

    struct DNA has drop {
        dummy_field: bool,
    }

    public fun get_dna_values(arg0: &Dna) : (vector<u8>, vector<u8>) {
        (arg0.unique_dna, arg0.manifest_dna)
    }

    public fun get_manifest_dna(arg0: &Dna) : vector<u8> {
        arg0.manifest_dna
    }

    public fun get_unique_dna(arg0: &Dna) : vector<u8> {
        arg0.unique_dna
    }

    public fun new(arg0: vector<u8>, arg1: vector<u8>) : Dna {
        assert!(0x1::vector::length<u8>(&arg0) == 64, 1);
        assert!(0x1::vector::length<u8>(&arg1) == 32, 2);
        Dna{
            unique_dna   : arg0,
            manifest_dna : arg1,
        }
    }

    // decompiled from Move bytecode v6
}

