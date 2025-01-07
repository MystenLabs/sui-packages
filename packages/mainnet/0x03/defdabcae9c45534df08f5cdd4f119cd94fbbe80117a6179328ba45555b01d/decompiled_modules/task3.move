module 0x3defdabcae9c45534df08f5cdd4f119cd94fbbe80117a6179328ba45555b01d::task3 {
    struct Miai has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
    }

    struct Burned has copy, drop {
        object_id: 0x2::object::ID,
        destroyer: address,
        name: 0x1::string::String,
    }

    struct Minted has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    public fun transfer(arg0: Miai, arg1: address) {
        0x2::transfer::public_transfer<Miai>(arg0, arg1);
    }

    public fun burn(arg0: Miai, arg1: &mut 0x2::tx_context::TxContext) {
        let Miai {
            id          : v0,
            name        : v1,
            description : _,
            url         : _,
        } = arg0;
        let v4 = v0;
        let v5 = Burned{
            object_id : 0x2::object::uid_to_inner(&v4),
            destroyer : 0x2::tx_context::sender(arg1),
            name      : v1,
        };
        0x2::event::emit<Burned>(v5);
        0x2::object::delete(v4);
    }

    public fun get_description(arg0: &Miai) : &0x1::string::String {
        &arg0.description
    }

    public fun get_name(arg0: &Miai) : &0x1::string::String {
        &arg0.name
    }

    public fun get_url(arg0: &Miai) : &0x2::url::Url {
        &arg0.url
    }

    public fun mint(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = Miai{
            id          : 0x2::object::new(arg3),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            url         : 0x2::url::new_unsafe_from_bytes(arg2),
        };
        let v2 = Minted{
            object_id : 0x2::object::id<Miai>(&v1),
            creator   : v0,
            name      : v1.name,
        };
        0x2::event::emit<Minted>(v2);
        0x2::transfer::public_transfer<Miai>(v1, v0);
    }

    public fun update_description(arg0: &mut Miai, arg1: vector<u8>) {
        arg0.description = 0x1::string::utf8(arg1);
    }

    // decompiled from Move bytecode v6
}

