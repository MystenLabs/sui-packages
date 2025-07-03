module 0xbb02bf90317dde57955ee317b5fe119f2167c1a3d8055cc317f9e1cac4e73539::authorized {
    struct ValidWitness has drop {
        dummy_field: bool,
    }

    struct Authorization has store, key {
        id: 0x2::object::UID,
        witness_type: vector<u8>,
        authorized_by: address,
        is_valid: bool,
    }

    struct WitnessMetadata has store, key {
        id: 0x2::object::UID,
        name: vector<u8>,
        description: vector<u8>,
        version: u64,
        created_by: address,
    }

    public fun create_authorization(arg0: &mut 0x2::tx_context::TxContext) : Authorization {
        Authorization{
            id            : 0x2::object::new(arg0),
            witness_type  : b"ValidWitness",
            authorized_by : 0x2::tx_context::sender(arg0),
            is_valid      : true,
        }
    }

    public fun create_witness() : ValidWitness {
        ValidWitness{dummy_field: false}
    }

    public fun create_witness_metadata(arg0: &mut 0x2::tx_context::TxContext) : WitnessMetadata {
        WitnessMetadata{
            id          : 0x2::object::new(arg0),
            name        : b"ValidWitness",
            description : b"Authorized witness for protocol operations",
            version     : 1,
            created_by  : 0x2::tx_context::sender(arg0),
        }
    }

    public fun get_witness_type_name() : vector<u8> {
        b"ValidWitness"
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = create_authorization(arg0);
        let v1 = create_witness_metadata(arg0);
        let v2 = 0x2::tx_context::sender(arg0);
        0x2::transfer::transfer<Authorization>(v0, v2);
        0x2::transfer::transfer<WitnessMetadata>(v1, v2);
    }

    public fun transfer_authorization(arg0: Authorization, arg1: address) {
        0x2::transfer::transfer<Authorization>(arg0, arg1);
    }

    public fun verify_witness(arg0: &ValidWitness) : bool {
        true
    }

    // decompiled from Move bytecode v6
}

