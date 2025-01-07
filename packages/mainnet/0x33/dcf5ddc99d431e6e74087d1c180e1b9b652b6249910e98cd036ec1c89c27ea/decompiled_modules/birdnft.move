module 0x33dcf5ddc99d431e6e74087d1c180e1b9b652b6249910e98cd036ec1c89c27ea::birdnft {
    struct BIRDNFT has drop {
        dummy_field: bool,
    }

    struct NumCount has key {
        id: 0x2::object::UID,
        current_number: u64,
    }

    struct NFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        collection: 0x1::string::String,
        number: u64,
    }

    fun init(arg0: BIRDNFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<BIRDNFT>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTd-p8dBZvujdcP3R_snd8LH5z9nmYybs12zA&s"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"Collection of Red Birds!"));
        let v5 = 0x2::display::new_with_fields<NFT>(&v0, v1, v3, arg1);
        0x2::display::update_version<NFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<NFT>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = NumCount{
            id             : 0x2::object::new(arg1),
            current_number : 0,
        };
        0x2::transfer::share_object<NumCount>(v6);
    }

    public entry fun mint_nft(arg0: 0x1::string::String, arg1: &mut NumCount, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = &mut arg1.current_number;
        *v0 = *v0 + 1;
        let v1 = NFT{
            id         : 0x2::object::new(arg2),
            name       : arg0,
            collection : 0x1::string::utf8(b"RedBirds"),
            number     : *v0,
        };
        0x2::transfer::public_transfer<NFT>(v1, 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

