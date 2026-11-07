module 0xf02c2127356906e1fa184be1f065c71df0adfe693ecd9279cedcacc6aa66216::owner_proof {
    struct OwnerProof {
        package_witness: 0x1::type_name::TypeName,
        origin: 0x2::object::ID,
    }

    public fun origin(arg0: &OwnerProof) : 0x2::object::ID {
        arg0.origin
    }

    public fun package_witness(arg0: &OwnerProof) : 0x1::type_name::TypeName {
        arg0.package_witness
    }

    public fun assert_terms(arg0: OwnerProof, arg1: &0xf02c2127356906e1fa184be1f065c71df0adfe693ecd9279cedcacc6aa66216::migration::VaultTerms) {
        let OwnerProof {
            package_witness : v0,
            origin          : v1,
        } = arg0;
        assert!(v0 == 0xf02c2127356906e1fa184be1f065c71df0adfe693ecd9279cedcacc6aa66216::migration::package_witness(arg1) && v1 == 0xf02c2127356906e1fa184be1f065c71df0adfe693ecd9279cedcacc6aa66216::migration::origin(arg1), 9);
    }

    public fun new<T0: drop>(arg0: T0, arg1: &0x2::object::UID) : OwnerProof {
        OwnerProof{
            package_witness : 0x1::type_name::with_original_ids<T0>(),
            origin          : 0x2::object::uid_to_inner(arg1),
        }
    }

    // decompiled from Move bytecode v7
}

