module 0x20d4f3afa5ffa0859f3ac26222f218be49a30a7362d880da4ea6208c6784170a::pubkey {
    struct PublicKey has key {
        id: 0x2::object::UID,
        pk: vector<u8>,
    }

    public entry fun getPublicKey(arg0: &PublicKey) : vector<u8> {
        arg0.pk
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PublicKey{
            id : 0x2::object::new(arg0),
            pk : b"0x",
        };
        0x2::transfer::share_object<PublicKey>(v0);
    }

    public entry fun set_pubkey(arg0: &0x20d4f3afa5ffa0859f3ac26222f218be49a30a7362d880da4ea6208c6784170a::admin::AdminCap, arg1: &mut PublicKey, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.pk = arg2;
    }

    public fun verify(arg0: &vector<u8>, arg1: &PublicKey, arg2: &vector<u8>) : bool {
        0x2::ed25519::ed25519_verify(arg0, &arg1.pk, arg2)
    }

    // decompiled from Move bytecode v6
}

