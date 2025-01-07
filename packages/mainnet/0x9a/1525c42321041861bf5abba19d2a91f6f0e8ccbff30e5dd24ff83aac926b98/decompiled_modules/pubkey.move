module 0x9a1525c42321041861bf5abba19d2a91f6f0e8ccbff30e5dd24ff83aac926b98::pubkey {
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

    public entry fun set_pubkey(arg0: &0x9a1525c42321041861bf5abba19d2a91f6f0e8ccbff30e5dd24ff83aac926b98::admin::AdminCap, arg1: &mut PublicKey, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.pk = arg2;
    }

    public fun verify(arg0: &vector<u8>, arg1: &PublicKey, arg2: &vector<u8>) : bool {
        0x2::ed25519::ed25519_verify(arg0, &arg1.pk, arg2)
    }

    // decompiled from Move bytecode v6
}

