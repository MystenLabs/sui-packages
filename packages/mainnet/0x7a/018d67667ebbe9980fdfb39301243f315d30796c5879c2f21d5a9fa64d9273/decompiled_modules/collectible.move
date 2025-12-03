module 0x7a018d67667ebbe9980fdfb39301243f315d30796c5879c2f21d5a9fa64d9273::collectible {
    struct Collectible has key {
        id: 0x2::object::UID,
        id_number: u64,
        name: 0x1::string::String,
        description: 0x1::string::String,
        author: 0x1::string::String,
        image_url: 0x1::string::String,
        project_url: 0x1::string::String,
    }

    public(friend) fun new(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) : Collectible {
        let v0 = 0x1::string::utf8(0x7a018d67667ebbe9980fdfb39301243f315d30796c5879c2f21d5a9fa64d9273::constants::collection_name());
        0x1::string::append(&mut v0, 0x1::string::utf8(b" #"));
        0x1::string::append(&mut v0, 0x7a018d67667ebbe9980fdfb39301243f315d30796c5879c2f21d5a9fa64d9273::utils::u64_to_string(arg0));
        let v1 = 0x1::string::utf8(0x7a018d67667ebbe9980fdfb39301243f315d30796c5879c2f21d5a9fa64d9273::constants::image_base_url());
        0x1::string::append(&mut v1, 0x7a018d67667ebbe9980fdfb39301243f315d30796c5879c2f21d5a9fa64d9273::utils::u64_to_string(arg0));
        Collectible{
            id          : 0x2::object::new(arg1),
            id_number   : arg0,
            name        : v0,
            description : 0x1::string::utf8(0x7a018d67667ebbe9980fdfb39301243f315d30796c5879c2f21d5a9fa64d9273::constants::base_description()),
            author      : 0x1::string::utf8(0x7a018d67667ebbe9980fdfb39301243f315d30796c5879c2f21d5a9fa64d9273::constants::author()),
            image_url   : v1,
            project_url : 0x1::string::utf8(0x7a018d67667ebbe9980fdfb39301243f315d30796c5879c2f21d5a9fa64d9273::constants::project_url()),
        }
    }

    public(friend) fun new_custom(arg0: u64, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: &mut 0x2::tx_context::TxContext) : Collectible {
        Collectible{
            id          : 0x2::object::new(arg6),
            id_number   : arg0,
            name        : arg1,
            description : arg2,
            author      : arg3,
            image_url   : arg4,
            project_url : arg5,
        }
    }

    public(friend) fun transfer_to(arg0: Collectible, arg1: address) {
        0x2::transfer::transfer<Collectible>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

