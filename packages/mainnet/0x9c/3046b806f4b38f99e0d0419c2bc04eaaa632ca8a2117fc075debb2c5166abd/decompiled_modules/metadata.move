module 0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::metadata {
    struct ExtensionMetadataV1 has store, key {
        id: 0x2::object::UID,
        vault: 0x2::object::ID,
        deposit_caps: vector<u64>,
    }

    public(friend) fun append_vector_fields_with_defaults(arg0: &mut ExtensionMetadataV1) {
        0x1::vector::push_back<u64>(&mut arg0.deposit_caps, 18446744073709551615);
    }

    public(friend) fun default_extension_metadata(arg0: 0x2::object::ID, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : ExtensionMetadataV1 {
        let v0 = vector[];
        let v1 = 0;
        while (v1 < arg1) {
            0x1::vector::push_back<u64>(&mut v0, 18446744073709551615);
            v1 = v1 + 1;
        };
        ExtensionMetadataV1{
            id           : 0x2::object::new(arg2),
            vault        : arg0,
            deposit_caps : v0,
        }
    }

    public(friend) fun destroy_extension_metadata(arg0: ExtensionMetadataV1) {
        let ExtensionMetadataV1 {
            id           : v0,
            vault        : _,
            deposit_caps : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    // decompiled from Move bytecode v6
}

