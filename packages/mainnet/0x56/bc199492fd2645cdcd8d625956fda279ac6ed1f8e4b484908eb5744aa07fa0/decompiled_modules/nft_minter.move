module 0x56bc199492fd2645cdcd8d625956fda279ac6ed1f8e4b484908eb5744aa07fa0::nft_minter {
    struct NFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x2::url::Url,
        creator: address,
    }

    struct NFT_MINTER has drop {
        dummy_field: bool,
    }

    struct NFTMinted has copy, drop {
        id: address,
        name: 0x1::string::String,
        creator: address,
    }

    struct NFTPublisher has key {
        id: 0x2::object::UID,
        publisher: 0x2::package::Publisher,
    }

    public entry fun batch_mint(arg0: vector<vector<u8>>, arg1: vector<vector<u8>>, arg2: vector<vector<u8>>, arg3: vector<address>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<vector<u8>>(&arg0);
        let v1 = if (v0 == 0x1::vector::length<vector<u8>>(&arg1)) {
            if (v0 == 0x1::vector::length<vector<u8>>(&arg2)) {
                v0 == 0x1::vector::length<address>(&arg3)
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 0);
        let v2 = 0;
        while (v2 < v0) {
            mint(*0x1::vector::borrow<vector<u8>>(&arg0, v2), *0x1::vector::borrow<vector<u8>>(&arg1, v2), *0x1::vector::borrow<vector<u8>>(&arg2, v2), *0x1::vector::borrow<address>(&arg3, v2), arg4);
            v2 = v2 + 1;
        };
    }

    public entry fun burn(arg0: NFT) {
        let NFT {
            id          : v0,
            name        : _,
            description : _,
            image_url   : _,
            creator     : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun get_creator(arg0: &NFT) : address {
        arg0.creator
    }

    public fun get_description(arg0: &NFT) : 0x1::string::String {
        arg0.description
    }

    public fun get_image_url(arg0: &NFT) : 0x2::url::Url {
        arg0.image_url
    }

    public fun get_name(arg0: &NFT) : 0x1::string::String {
        arg0.name
    }

    fun init(arg0: NFT_MINTER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<NFT_MINTER>(arg0, arg1);
        let v1 = 0x2::display::new<NFT>(&v0, arg1);
        0x2::display::add<NFT>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<NFT>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<NFT>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::add<NFT>(&mut v1, 0x1::string::utf8(b"creator"), 0x1::string::utf8(b"{creator}"));
        0x2::display::add<NFT>(&mut v1, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://yourproject.com"));
        0x2::display::update_version<NFT>(&mut v1);
        0x2::transfer::public_transfer<0x2::display::Display<NFT>>(v1, 0x2::tx_context::sender(arg1));
        let v2 = NFTPublisher{
            id        : 0x2::object::new(arg1),
            publisher : v0,
        };
        0x2::transfer::share_object<NFTPublisher>(v2);
    }

    public entry fun mint(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = NFT{
            id          : 0x2::object::new(arg4),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            image_url   : 0x2::url::new_unsafe_from_bytes(arg2),
            creator     : v0,
        };
        let v2 = NFTMinted{
            id      : 0x2::object::uid_to_address(&v1.id),
            name    : v1.name,
            creator : v0,
        };
        0x2::event::emit<NFTMinted>(v2);
        0x2::transfer::public_transfer<NFT>(v1, arg3);
    }

    public entry fun mint_to_sender(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        mint(arg0, arg1, arg2, v0, arg3);
    }

    public entry fun transfer_nft(arg0: NFT, arg1: address) {
        0x2::transfer::public_transfer<NFT>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

