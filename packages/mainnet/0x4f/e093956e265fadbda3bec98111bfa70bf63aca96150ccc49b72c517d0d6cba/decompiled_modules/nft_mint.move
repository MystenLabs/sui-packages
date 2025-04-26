module 0x4fe093956e265fadbda3bec98111bfa70bf63aca96150ccc49b72c517d0d6cba::nft_mint {
    struct Nft has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x1::string::String,
    }

    struct Dummy has store, key {
        id: 0x2::object::UID,
    }

    public entry fun create_dummy(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Dummy{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<Dummy>(v0, 0x2::tx_context::sender(arg0));
    }

    fun mint(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) : Nft {
        Nft{
            id          : 0x2::object::new(arg3),
            name        : arg0,
            description : arg1,
            url         : arg2,
        }
    }

    public entry fun mint_and_send(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<Nft>(mint(arg0, arg1, arg2, arg4), arg3);
    }

    public entry fun test_dummy_object(arg0: &Dummy, arg1: &mut 0x2::tx_context::TxContext) {
    }

    // decompiled from Move bytecode v6
}

