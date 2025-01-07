module 0x3e34b667499adccce82cca907d2f5d2d3ba8cf8bc1384e0e86de359cda6e206f::nft {
    struct MintCap has key {
        id: 0x2::object::UID,
    }

    struct Token has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
    }

    struct MintEvent has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    public entry fun transfer(arg0: Token, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<Token>(arg0, arg1);
    }

    public fun url(arg0: &Token) : &0x2::url::Url {
        &arg0.url
    }

    public entry fun burn(arg0: Token, arg1: &mut 0x2::tx_context::TxContext) {
        let Token {
            id          : v0,
            name        : _,
            description : _,
            url         : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun description(arg0: &Token) : &0x1::string::String {
        &arg0.description
    }

    public entry fun edit(arg0: &mut Token, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.description = 0x1::string::utf8(arg1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MintCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<MintCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun mint(arg0: &MintCap, arg1: address, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = Token{
            id          : 0x2::object::new(arg5),
            name        : 0x1::string::utf8(arg2),
            description : 0x1::string::utf8(arg3),
            url         : 0x2::url::new_unsafe_from_bytes(arg4),
        };
        let v1 = MintEvent{
            object_id : 0x2::object::id<Token>(&v0),
            creator   : arg1,
            name      : v0.name,
        };
        0x2::event::emit<MintEvent>(v1);
        0x2::transfer::public_transfer<Token>(v0, arg1);
    }

    public fun name(arg0: &Token) : &0x1::string::String {
        &arg0.name
    }

    // decompiled from Move bytecode v6
}

