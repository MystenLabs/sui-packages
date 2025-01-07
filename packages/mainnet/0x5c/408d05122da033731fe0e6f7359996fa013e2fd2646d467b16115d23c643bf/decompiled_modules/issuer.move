module 0x5c408d05122da033731fe0e6f7359996fa013e2fd2646d467b16115d23c643bf::issuer {
    struct VisitorList has store, key {
        id: 0x2::object::UID,
        visitors: vector<address>,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = VisitorList{
            id       : 0x2::object::new(arg0),
            visitors : 0x1::vector::empty<address>(),
        };
        0x2::transfer::public_share_object<VisitorList>(v0);
    }

    public entry fun mint(arg0: &mut VisitorList, arg1: &0x2::clock::Clock, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: &mut 0x2::tx_context::TxContext) {
        0x1::vector::push_back<address>(&mut arg0.visitors, 0x2::tx_context::sender(arg6));
        0x2::transfer::public_transfer<0x5c408d05122da033731fe0e6f7359996fa013e2fd2646d467b16115d23c643bf::nft::CoCoNFT>(0x5c408d05122da033731fe0e6f7359996fa013e2fd2646d467b16115d23c643bf::nft::new(arg2, arg3, arg4, arg1, arg6), 0x2::tx_context::sender(arg6));
    }

    // decompiled from Move bytecode v6
}

