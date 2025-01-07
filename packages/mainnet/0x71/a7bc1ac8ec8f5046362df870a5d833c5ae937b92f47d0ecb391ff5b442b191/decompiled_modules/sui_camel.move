module 0x71a7bc1ac8ec8f5046362df870a5d833c5ae937b92f47d0ecb391ff5b442b191::sui_camel {
    struct SuiCamel has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        traits: vector<0x1::string::String>,
        url: 0x1::string::String,
    }

    struct SuiCamelMinted has copy, drop {
        camel_id: 0x2::object::ID,
        minted_by: address,
    }

    public entry fun transfer(arg0: SuiCamel, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<SuiCamel>(arg0, arg1);
    }

    public fun add_trait(arg0: &mut SuiCamel, arg1: 0x1::string::String) {
        0x1::vector::push_back<0x1::string::String>(&mut arg0.traits, arg1);
    }

    public fun destroy(arg0: SuiCamel) {
        let SuiCamel {
            id     : v0,
            name   : _,
            traits : _,
            url    : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun mint_to_sender(arg0: 0x1::string::String, arg1: vector<0x1::string::String>, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg3);
        let v1 = SuiCamelMinted{
            camel_id  : 0x2::object::uid_to_inner(&v0),
            minted_by : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<SuiCamelMinted>(v1);
        let v2 = SuiCamel{
            id     : v0,
            name   : arg0,
            traits : arg1,
            url    : arg2,
        };
        0x2::transfer::public_transfer<SuiCamel>(v2, 0x2::tx_context::sender(arg3));
    }

    public fun name(arg0: &SuiCamel) : 0x1::string::String {
        arg0.name
    }

    public fun set_url(arg0: &mut SuiCamel, arg1: 0x1::string::String) {
        arg0.url = arg1;
    }

    public fun traits(arg0: &SuiCamel) : &vector<0x1::string::String> {
        &arg0.traits
    }

    public fun url(arg0: &SuiCamel) : 0x1::string::String {
        arg0.url
    }

    // decompiled from Move bytecode v6
}

