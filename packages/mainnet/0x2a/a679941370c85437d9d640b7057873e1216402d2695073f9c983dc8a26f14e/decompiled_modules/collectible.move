module 0x2aa679941370c85437d9d640b7057873e1216402d2695073f9c983dc8a26f14e::collectible {
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
        let v0 = 0x1::string::utf8(0x2aa679941370c85437d9d640b7057873e1216402d2695073f9c983dc8a26f14e::constants::collection_name());
        0x1::string::append(&mut v0, 0x1::string::utf8(b" #"));
        0x1::string::append(&mut v0, 0x2aa679941370c85437d9d640b7057873e1216402d2695073f9c983dc8a26f14e::utils::u64_to_string(arg0));
        let v1 = 0x1::string::utf8(0x2aa679941370c85437d9d640b7057873e1216402d2695073f9c983dc8a26f14e::constants::image_base_url());
        0x1::string::append(&mut v1, 0x2aa679941370c85437d9d640b7057873e1216402d2695073f9c983dc8a26f14e::utils::u64_to_string(arg0));
        Collectible{
            id          : 0x2::object::new(arg1),
            id_number   : arg0,
            name        : v0,
            description : 0x1::string::utf8(0x2aa679941370c85437d9d640b7057873e1216402d2695073f9c983dc8a26f14e::constants::base_description()),
            author      : 0x1::string::utf8(0x2aa679941370c85437d9d640b7057873e1216402d2695073f9c983dc8a26f14e::constants::author()),
            image_url   : v1,
            project_url : 0x1::string::utf8(0x2aa679941370c85437d9d640b7057873e1216402d2695073f9c983dc8a26f14e::constants::project_url()),
        }
    }

    public(friend) fun transfer_to(arg0: Collectible, arg1: address) {
        0x2::transfer::transfer<Collectible>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

