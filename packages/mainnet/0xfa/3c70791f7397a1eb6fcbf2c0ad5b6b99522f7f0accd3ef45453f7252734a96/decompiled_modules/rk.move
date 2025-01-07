module 0xfa3c70791f7397a1eb6fcbf2c0ad5b6b99522f7f0accd3ef45453f7252734a96::rk {
    struct RK_NFT has store, key {
        id: 0x2::object::UID,
        tk_id: u64,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x2::url::Url,
    }

    struct RK has drop {
        dummy_field: bool,
    }

    struct TID has key {
        id: 0x2::object::UID,
        NextTID: u64,
    }

    struct NFTMinted has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    public entry fun transfer(arg0: RK_NFT, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<RK_NFT>(arg0, arg1);
    }

    public fun url(arg0: &RK_NFT) : &0x2::url::Url {
        &arg0.image_url
    }

    public entry fun burn(arg0: RK_NFT, arg1: &0x2::tx_context::TxContext) {
        let RK_NFT {
            id          : v0,
            tk_id       : _,
            name        : _,
            description : _,
            image_url   : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun description(arg0: &RK_NFT) : &0x1::string::String {
        &arg0.description
    }

    fun init(arg0: RK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"tk_id"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"TokenId #{tk_id}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{image_url}"));
        let v5 = 0x2::package::claim<RK>(arg0, arg1);
        let v6 = 0x2::display::new_with_fields<RK_NFT>(&v5, v1, v3, arg1);
        0x2::display::update_version<RK_NFT>(&mut v6);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v5, v0);
        0x2::transfer::public_transfer<0x2::display::Display<RK_NFT>>(v6, v0);
        let v7 = TID{
            id      : 0x2::object::new(arg1),
            NextTID : 0,
        };
        0x2::transfer::share_object<TID>(v7);
    }

    public entry fun mint(arg0: &mut TID, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        arg0.NextTID = arg0.NextTID + 1;
        let v1 = RK_NFT{
            id          : 0x2::object::new(arg4),
            tk_id       : arg0.NextTID,
            name        : 0x1::string::utf8(arg1),
            description : 0x1::string::utf8(arg2),
            image_url   : 0x2::url::new_unsafe_from_bytes(arg3),
        };
        let v2 = NFTMinted{
            object_id : 0x2::object::id<RK_NFT>(&v1),
            creator   : v0,
            name      : v1.name,
        };
        0x2::event::emit<NFTMinted>(v2);
        0x2::transfer::public_transfer<RK_NFT>(v1, v0);
    }

    public fun name(arg0: &RK_NFT) : &0x1::string::String {
        &arg0.name
    }

    public fun token_id(arg0: &RK_NFT) : &u64 {
        &arg0.tk_id
    }

    // decompiled from Move bytecode v6
}

