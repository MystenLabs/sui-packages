module 0xe97cc1689717a55a578f4956c01254d369afd9fa5b23e4f2affbd59e59deccc0::verification {
    struct Verifier has key {
        id: 0x2::object::UID,
        pub_key: vector<u8>,
        counter: 0x2::table::Table<address, u64>,
    }

    struct VerifierCap has store, key {
        id: 0x2::object::UID,
    }

    public fun counter_value(arg0: &Verifier, arg1: address) : u64 {
        if (!is_contained(arg0, arg1)) {
            0
        } else {
            *0x2::table::borrow<address, u64>(&arg0.counter, arg1)
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Verifier{
            id      : 0x2::object::new(arg0),
            pub_key : b"",
            counter : 0x2::table::new<address, u64>(arg0),
        };
        0x2::transfer::share_object<Verifier>(v0);
        let v1 = VerifierCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<VerifierCap>(v1, 0x2::tx_context::sender(arg0));
    }

    fun internal_verify_signature(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut vector<u8>) : bool {
        0x2::ecdsa_k1::secp256k1_verify(&arg1, &arg0, arg2, 1)
    }

    public fun is_contained(arg0: &Verifier, arg1: address) : bool {
        0x2::table::contains<address, u64>(&arg0.counter, arg1)
    }

    public fun overwrite_pub_key(arg0: &VerifierCap, arg1: &mut Verifier, arg2: vector<u8>) {
        arg1.pub_key = arg2;
    }

    public fun pub_key(arg0: &Verifier) : vector<u8> {
        arg0.pub_key
    }

    public(friend) fun verify_signature(arg0: &mut Verifier, arg1: address, arg2: vector<u8>, arg3: &mut vector<u8>) : bool {
        if (!is_contained(arg0, arg1)) {
            0x2::table::add<address, u64>(&mut arg0.counter, arg1, 0);
        };
        let v0 = 0x2::table::borrow_mut<address, u64>(&mut arg0.counter, arg1);
        0x1::vector::append<u8>(arg3, 0x1::bcs::to_bytes<u64>(v0));
        let v1 = internal_verify_signature(arg0.pub_key, arg2, arg3);
        assert!(v1, 0);
        *v0 = *v0 + 1;
        v1
    }

    // decompiled from Move bytecode v6
}

