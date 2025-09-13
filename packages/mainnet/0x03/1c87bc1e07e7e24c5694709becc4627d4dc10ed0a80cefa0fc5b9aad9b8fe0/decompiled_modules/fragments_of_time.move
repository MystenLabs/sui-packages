module 0x31c87bc1e07e7e24c5694709becc4627d4dc10ed0a80cefa0fc5b9aad9b8fe0::fragments_of_time {
    struct FragmentOfTime has store, key {
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

    public fun transfer(arg0: FragmentOfTime, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<FragmentOfTime>(arg0, arg1);
    }

    public fun url(arg0: &FragmentOfTime) : &0x2::url::Url {
        &arg0.url
    }

    public fun burn(arg0: FragmentOfTime, arg1: &mut 0x2::tx_context::TxContext) {
        let FragmentOfTime {
            id          : v0,
            name        : _,
            description : _,
            url         : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun description(arg0: &FragmentOfTime) : &0x1::string::String {
        &arg0.description
    }

    public fun mint_to_sender(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = FragmentOfTime{
            id          : 0x2::object::new(arg3),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            url         : 0x2::url::new_unsafe_from_bytes(arg2),
        };
        let v2 = NFTMinted{
            object_id : 0x2::object::id<FragmentOfTime>(&v1),
            creator   : v0,
            name      : v1.name,
        };
        0x2::event::emit<NFTMinted>(v2);
        0x2::transfer::public_transfer<FragmentOfTime>(v1, v0);
    }

    public fun name(arg0: &FragmentOfTime) : &0x1::string::String {
        &arg0.name
    }

    // decompiled from Move bytecode v6
}

