module 0x22ef99c6b2630e85bdcd600909a531874417123eec41abfbce2086a58467513e::nft {
    struct NFT has drop {
        dummy_field: bool,
    }

    struct BirdNFT has store, key {
        id: 0x2::object::UID,
        value: u128,
    }

    struct NFTMint has copy, drop {
        id: 0x2::object::ID,
        owner: address,
        value: u128,
    }

    struct NFTBurn has copy, drop {
        id: 0x2::object::ID,
        owner: address,
        value: u128,
    }

    public entry fun burn(arg0: BirdNFT, arg1: &0x2::tx_context::TxContext) {
        let v0 = NFTBurn{
            id    : 0x2::object::id<BirdNFT>(&arg0),
            owner : 0x2::tx_context::sender(arg1),
            value : arg0.value,
        };
        0x2::event::emit<NFTBurn>(v0);
        let BirdNFT {
            id    : v1,
            value : _,
        } = arg0;
        0x2::object::delete(v1);
    }

    fun init(arg0: NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<NFT>(arg0, arg1);
        let v1 = setupNft(&v0, arg1);
        let v2 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, v2);
        0x2::transfer::public_transfer<0x2::display::Display<BirdNFT>>(v1, v2);
    }

    public entry fun mint(arg0: &mut 0x9b7409d4ff148b6f728edfc7beeb424e904d7dbde7054602c7ac98d3d87feecc::archieve::UserArchieve, arg1: &mut 0x2::tx_context::TxContext) {
        0x9b7409d4ff148b6f728edfc7beeb424e904d7dbde7054602c7ac98d3d87feecc::archieve::verify(arg0);
        let v0 = BirdNFT{
            id    : 0x2::object::new(arg1),
            value : 1000,
        };
        let v1 = NFTMint{
            id    : 0x2::object::id<BirdNFT>(&v0),
            owner : 0x2::tx_context::sender(arg1),
            value : v0.value,
        };
        0x2::event::emit<NFTMint>(v1);
        0x2::transfer::public_transfer<BirdNFT>(v0, 0x2::tx_context::sender(arg1));
    }

    fun setupNft(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) : 0x2::display::Display<BirdNFT> {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"WORM - BIRDS GameFi Asset"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"The leading memecoin & GameFi Telegram mini-app on the SuiNetwork"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://x.com/TheBirdsDogs"));
        let v4 = 0x2::display::new_with_fields<BirdNFT>(arg0, v0, v2, arg1);
        0x2::display::update_version<BirdNFT>(&mut v4);
        v4
    }

    // decompiled from Move bytecode v6
}

