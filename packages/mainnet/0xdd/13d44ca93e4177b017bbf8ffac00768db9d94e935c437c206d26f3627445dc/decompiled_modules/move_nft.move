module 0xdd13d44ca93e4177b017bbf8ffac00768db9d94e935c437c206d26f3627445dc::move_nft {
    struct MOVE_NFT has drop {
        dummy_field: bool,
    }

    struct JiuCaiNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        traits: 0x1::string::String,
        url: 0x2::url::Url,
    }

    struct JiuCaiMinted has copy, drop {
        jiuCai_id: 0x2::object::ID,
        minted_by: address,
    }

    public entry fun transfer(arg0: JiuCaiNFT, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<JiuCaiNFT>(arg0, arg1);
    }

    public fun url(arg0: &JiuCaiNFT) : &0x2::url::Url {
        &arg0.url
    }

    fun init(arg0: MOVE_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<MOVE_NFT>(arg0, arg1);
        let v1 = 0x2::display::new<JiuCaiNFT>(&v0, arg1);
        0x2::display::add<JiuCaiNFT>(&mut v1, 0x1::string::utf8(b"id"), 0x1::string::utf8(b"{id}"));
        0x2::display::add<JiuCaiNFT>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<JiuCaiNFT>(&mut v1, 0x1::string::utf8(b"traits"), 0x1::string::utf8(b"{traits}"));
        0x2::display::add<JiuCaiNFT>(&mut v1, 0x1::string::utf8(b"url"), 0x1::string::utf8(b"{url}"));
        0x2::package::burn_publisher(v0);
        0x1::debug::print<0x2::display::Display<JiuCaiNFT>>(&v1);
        0x2::transfer::public_transfer<0x2::display::Display<JiuCaiNFT>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg3);
        let v1 = JiuCaiMinted{
            jiuCai_id : 0x2::object::uid_to_inner(&v0),
            minted_by : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<JiuCaiMinted>(v1);
        let v2 = JiuCaiNFT{
            id     : v0,
            name   : arg0,
            traits : arg1,
            url    : 0x2::url::new_unsafe_from_bytes(arg2),
        };
        0x2::transfer::public_transfer<JiuCaiNFT>(v2, 0x2::tx_context::sender(arg3));
    }

    public fun name(arg0: &JiuCaiNFT) : &0x1::string::String {
        &arg0.name
    }

    public fun traits(arg0: &JiuCaiNFT) : &0x1::string::String {
        &arg0.traits
    }

    // decompiled from Move bytecode v6
}

