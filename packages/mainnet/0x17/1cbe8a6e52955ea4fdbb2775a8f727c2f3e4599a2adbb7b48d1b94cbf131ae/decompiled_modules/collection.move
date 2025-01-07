module 0x171cbe8a6e52955ea4fdbb2775a8f727c2f3e4599a2adbb7b48d1b94cbf131ae::collection {
    struct COLLECTION has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct EyeNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x2::url::Url,
        collection: 0x1::string::String,
    }

    struct Collection has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        creator: address,
        total_supply: u64,
        minted: u64,
        image_bytes: vector<u8>,
        image_type: 0x1::string::String,
    }

    fun bytes_to_hex(arg0: vector<u8>) : vector<u8> {
        let v0 = b"0123456789abcdef";
        let v1 = b"";
        let v2 = 0;
        while (v2 < 0x1::vector::length<u8>(&arg0)) {
            let v3 = *0x1::vector::borrow<u8>(&arg0, v2);
            0x1::vector::push_back<u8>(&mut v1, *0x1::vector::borrow<u8>(&v0, ((v3 >> 4) as u64)));
            0x1::vector::push_back<u8>(&mut v1, *0x1::vector::borrow<u8>(&v0, ((v3 & 15) as u64)));
            v2 = v2 + 1;
        };
        v1
    }

    fun init(arg0: COLLECTION, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        let v1 = Collection{
            id           : 0x2::object::new(arg1),
            name         : 0x1::string::utf8(b"Eye NFT Collection"),
            description  : 0x1::string::utf8(b"A collection of mystical eye NFTs"),
            creator      : 0x2::tx_context::sender(arg1),
            total_supply : 1000,
            minted       : 0,
            image_bytes  : b"",
            image_type   : 0x1::string::utf8(b"png"),
        };
        let v2 = 0x2::package::claim<COLLECTION>(arg0, arg1);
        let v3 = 0x2::display::new<EyeNFT>(&v2, arg1);
        0x2::display::add<EyeNFT>(&mut v3, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<EyeNFT>(&mut v3, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<EyeNFT>(&mut v3, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::add<EyeNFT>(&mut v3, 0x1::string::utf8(b"collection"), 0x1::string::utf8(b"{collection}"));
        0x2::display::update_version<EyeNFT>(&mut v3);
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<EyeNFT>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<Collection>(v1);
    }

    public entry fun mint(arg0: &mut Collection, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.minted < arg0.total_supply, 1);
        assert!(0x2::coin::value<0x2::sui::SUI>(arg1) >= 100000000, 0);
        let v0 = b"ipfs://";
        0x1::vector::append<u8>(&mut v0, bytes_to_hex(0x2::hash::blake2b256(&arg0.image_bytes)));
        let v1 = EyeNFT{
            id          : 0x2::object::new(arg2),
            name        : 0x1::string::utf8(b"Mystic Eye #"),
            description : 0x1::string::utf8(b"A mystical eye that sees beyond reality"),
            image_url   : 0x2::url::new_unsafe_from_bytes(v0),
            collection  : 0x1::string::utf8(b"Eye NFT Collection"),
        };
        arg0.minted = arg0.minted + 1;
        0x2::transfer::transfer<EyeNFT>(v1, 0x2::tx_context::sender(arg2));
    }

    public entry fun set_image_data(arg0: &AdminCap, arg1: &mut Collection, arg2: vector<u8>) {
        arg1.image_bytes = arg2;
    }

    // decompiled from Move bytecode v6
}

