module 0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::verifier {
    struct Signer has store, key {
        id: 0x2::object::UID,
        pub_key: vector<u8>,
        salt: 0x1::string::String,
    }

    public fun borrow_pub_key(arg0: &Signer) : vector<u8> {
        arg0.pub_key
    }

    public fun borrow_salt(arg0: &Signer) : &0x1::string::String {
        &arg0.salt
    }

    public(friend) fun create_signer(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = Signer{
            id      : 0x2::object::new(arg1),
            pub_key : 0x2::bcs::to_bytes<address>(&v0),
            salt    : 0x1::string::utf8(b"initial_salt"),
        };
        0x2::transfer::public_share_object<Signer>(v1);
    }

    public entry fun mutate_salt(arg0: &mut Signer, arg1: &0x2::package::Publisher, arg2: 0x1::string::String) {
        assert!(0x2::package::from_package<Signer>(arg1), 0);
        arg0.salt = arg2;
    }

    public entry fun mutate_signer(arg0: &mut Signer, arg1: &0x2::package::Publisher, arg2: vector<u8>) {
        assert!(0x2::package::from_package<Signer>(arg1), 0);
        arg0.pub_key = arg2;
    }

    // decompiled from Move bytecode v6
}

