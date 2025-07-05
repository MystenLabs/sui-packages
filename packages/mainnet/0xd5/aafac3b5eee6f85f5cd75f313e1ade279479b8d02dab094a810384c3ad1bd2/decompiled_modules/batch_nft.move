module 0xd5aafac3b5eee6f85f5cd75f313e1ade279479b8d02dab094a810384c3ad1bd2::batch_nft {
    struct MicroNFT has store, key {
        id: 0x2::object::UID,
        number: u64,
    }

    struct Collection has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image: 0x1::string::String,
        supply: u64,
    }

    struct BATCH_NFT has drop {
        dummy_field: bool,
    }

    public entry fun bulk_mint_single(arg0: &mut Collection, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < arg2) {
            arg0.supply = arg0.supply + 1;
            let v1 = MicroNFT{
                id     : 0x2::object::new(arg3),
                number : arg0.supply,
            };
            0x2::transfer::transfer<MicroNFT>(v1, arg1);
            v0 = v0 + 1;
        };
    }

    public entry fun create_collection(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Collection{
            id     : 0x2::object::new(arg2),
            name   : arg0,
            image  : arg1,
            supply : 0,
        };
        0x2::transfer::share_object<Collection>(v0);
    }

    fun init(arg0: BATCH_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<BATCH_NFT>(arg0, arg1);
        let v1 = 0x2::display::new<MicroNFT>(&v0, arg1);
        0x2::display::add<MicroNFT>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"NFT #{number}"));
        0x2::display::add<MicroNFT>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"https://your-image.com"));
        0x2::display::update_version<MicroNFT>(&mut v1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<MicroNFT>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun ultra_cheap_mint(arg0: &mut Collection, arg1: vector<address>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg1)) {
            arg0.supply = arg0.supply + 1;
            let v1 = MicroNFT{
                id     : 0x2::object::new(arg2),
                number : arg0.supply,
            };
            0x2::transfer::transfer<MicroNFT>(v1, *0x1::vector::borrow<address>(&arg1, v0));
            v0 = v0 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

