module 0xacec3d67a7a663c48094d4816ea6669d47c66987ffce69f1aee44362ebfc450d::ticket {
    struct DesuiTicket has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
    }

    struct NFTMinted has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    public entry fun transfer(arg0: DesuiTicket, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<DesuiTicket>(arg0, arg1);
    }

    public fun url(arg0: &DesuiTicket) : &0x2::url::Url {
        &arg0.url
    }

    public entry fun burn(arg0: DesuiTicket, arg1: &mut 0x2::tx_context::TxContext) {
        let DesuiTicket {
            id          : v0,
            name        : _,
            description : _,
            url         : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun description(arg0: &DesuiTicket) : &0x1::string::String {
        &arg0.description
    }

    public entry fun mint_to_sender(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(v0 == @0x14369c0c3eba649ae0d0f52546be19e5a191e0adf2d7c955507c1fc131c25738, 0);
        let v1 = DesuiTicket{
            id          : 0x2::object::new(arg4),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            url         : 0x2::url::new_unsafe_from_bytes(arg2),
        };
        let v2 = NFTMinted{
            object_id : 0x2::object::id<DesuiTicket>(&v1),
            creator   : v0,
            name      : v1.name,
        };
        0x2::event::emit<NFTMinted>(v2);
        0x2::transfer::public_transfer<DesuiTicket>(v1, arg3);
    }

    public fun name(arg0: &DesuiTicket) : &0x1::string::String {
        &arg0.name
    }

    public entry fun update_description(arg0: &mut DesuiTicket, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.description = 0x1::string::utf8(arg1);
    }

    // decompiled from Move bytecode v6
}

