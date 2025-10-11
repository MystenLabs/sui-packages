module 0x2215f532ecc07668da4e335b514ed0dcd0c0bc117dcda9ef81b2048abb7260a4::HashVerifier {
    struct Proof has drop {
        hash: vector<u8>,
    }

    struct Error has drop {
        message: vector<u8>,
    }

    public fun create_error(arg0: vector<u8>) : Error {
        Error{message: arg0}
    }

    public fun create_proof(arg0: &vector<u8>, arg1: address) : Proof {
        Proof{hash: 0x2215f532ecc07668da4e335b514ed0dcd0c0bc117dcda9ef81b2048abb7260a4::Hash::hash_stamp_and_sender(arg0, arg1)}
    }

    public fun get_error_message(arg0: &Error) : vector<u8> {
        arg0.message
    }

    public fun get_hash(arg0: &Proof) : &vector<u8> {
        &arg0.hash
    }

    public fun verify_proof(arg0: &vector<u8>, arg1: &vector<u8>, arg2: address) : bool {
        *arg0 == 0x2215f532ecc07668da4e335b514ed0dcd0c0bc117dcda9ef81b2048abb7260a4::Hash::hash_stamp_and_sender(arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

