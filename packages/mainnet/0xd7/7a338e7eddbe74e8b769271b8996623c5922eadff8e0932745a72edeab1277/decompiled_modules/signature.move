module 0xd77a338e7eddbe74e8b769271b8996623c5922eadff8e0932745a72edeab1277::signature {
    struct DAO has store, key {
        id: 0x2::object::UID,
        signatures: vector<vector<u8>>,
        admin_public_key: vector<u8>,
    }

    public fun createDao(arg0: vector<u8>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = DAO{
            id               : 0x2::object::new(arg1),
            signatures       : 0x1::vector::empty<vector<u8>>(),
            admin_public_key : arg0,
        };
        0x2::transfer::share_object<DAO>(v0);
    }

    public fun verifySignature(arg0: &mut DAO, arg1: &vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::contains<vector<u8>>(&arg0.signatures, &arg2), 0);
        assert!(0x2::bls12381::bls12381_min_pk_verify(&arg2, &arg0.admin_public_key, arg1) == true, 1);
        0x1::vector::push_back<vector<u8>>(&mut arg0.signatures, arg2);
    }

    // decompiled from Move bytecode v6
}

