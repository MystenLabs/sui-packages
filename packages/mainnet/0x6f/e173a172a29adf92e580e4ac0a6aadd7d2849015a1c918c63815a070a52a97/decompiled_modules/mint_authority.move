module 0x6fe173a172a29adf92e580e4ac0a6aadd7d2849015a1c918c63815a070a52a97::mint_authority {
    struct MintAuthorityCreated has copy, drop {
        id: 0x2::object::ID,
        public_key: vector<u8>,
    }

    struct MintAuthorityPublicKeyUpdated has copy, drop {
        id: 0x2::object::ID,
        new_public_key: vector<u8>,
    }

    struct MintAuthority has key {
        id: 0x2::object::UID,
        public_key: vector<u8>,
    }

    public fun create_mint_authority(arg0: &0x6fe173a172a29adf92e580e4ac0a6aadd7d2849015a1c918c63815a070a52a97::admin::AdminCap, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        validate_public_key(&arg1);
        let v0 = MintAuthority{
            id         : 0x2::object::new(arg2),
            public_key : arg1,
        };
        0x2::transfer::share_object<MintAuthority>(v0);
        let v1 = MintAuthorityCreated{
            id         : 0x2::object::id<MintAuthority>(&v0),
            public_key : arg1,
        };
        0x2::event::emit<MintAuthorityCreated>(v1);
    }

    public(friend) fun get_public_key(arg0: &MintAuthority) : &vector<u8> {
        &arg0.public_key
    }

    public fun update_public_key(arg0: &0x6fe173a172a29adf92e580e4ac0a6aadd7d2849015a1c918c63815a070a52a97::admin::AdminCap, arg1: &mut MintAuthority, arg2: vector<u8>) {
        validate_public_key(&arg2);
        arg1.public_key = arg2;
        let v0 = MintAuthorityPublicKeyUpdated{
            id             : 0x2::object::id<MintAuthority>(arg1),
            new_public_key : arg2,
        };
        0x2::event::emit<MintAuthorityPublicKeyUpdated>(v0);
    }

    fun validate_public_key(arg0: &vector<u8>) {
        assert!(0x1::vector::length<u8>(arg0) == 32, 0);
    }

    public(friend) fun verify_ed25519_signature<T0: drop>(arg0: &T0, arg1: &vector<u8>, arg2: &MintAuthority) : bool {
        let v0 = 0x2::bcs::to_bytes<T0>(arg0);
        0x2::ed25519::ed25519_verify(arg1, get_public_key(arg2), &v0)
    }

    // decompiled from Move bytecode v7
}

