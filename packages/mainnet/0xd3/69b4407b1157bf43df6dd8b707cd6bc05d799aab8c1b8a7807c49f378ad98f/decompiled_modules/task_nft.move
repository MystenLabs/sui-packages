module 0xd369b4407b1157bf43df6dd8b707cd6bc05d799aab8c1b8a7807c49f378ad98f::task_nft {
    struct TaskNft has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
    }

    struct NFTMinted has copy, drop {
        obj_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    public fun transfer(arg0: TaskNft, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<TaskNft>(arg0, arg1);
    }

    public fun url(arg0: &TaskNft) : &0x2::url::Url {
        &arg0.url
    }

    public fun burn(arg0: TaskNft, arg1: &mut 0x2::tx_context::TxContext) {
        let TaskNft {
            id          : v0,
            name        : _,
            description : _,
            url         : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun description(arg0: &TaskNft) : &0x1::string::String {
        &arg0.description
    }

    public fun mint_to_sender(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = TaskNft{
            id          : 0x2::object::new(arg3),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            url         : 0x2::url::new_unsafe_from_bytes(arg2),
        };
        let v2 = NFTMinted{
            obj_id  : 0x2::object::id<TaskNft>(&v1),
            creator : v0,
            name    : v1.name,
        };
        0x2::event::emit<NFTMinted>(v2);
        0x2::transfer::public_transfer<TaskNft>(v1, v0);
    }

    public fun name(arg0: &TaskNft) : &0x1::string::String {
        &arg0.name
    }

    public fun update_description(arg0: &mut TaskNft, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.description = 0x1::string::utf8(arg1);
    }

    // decompiled from Move bytecode v6
}

