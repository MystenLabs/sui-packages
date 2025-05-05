module 0x1047470456f34f22a49ab7c0dd31512caa8cd7c4645345bc2c445473d50524d9::nft {
    struct PoorlaxNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
    }

    struct MintRegistry has key {
        id: 0x2::object::UID,
        minters: 0x2::table::Table<address, bool>,
    }

    struct NFT has drop {
        dummy_field: bool,
    }

    struct NFTMinted has copy, drop {
        nft_id: address,
        creator: address,
        recipient: address,
        name: 0x1::string::String,
    }

    public fun url(arg0: &PoorlaxNFT) : &0x2::url::Url {
        &arg0.url
    }

    public fun description(arg0: &PoorlaxNFT) : &0x1::string::String {
        &arg0.description
    }

    public fun has_minted(arg0: &MintRegistry, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.minters, arg1)
    }

    fun init(arg0: NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<NFT>(arg0, arg1);
        let v1 = 0x2::display::new<PoorlaxNFT>(&v0, arg1);
        0x2::display::add<PoorlaxNFT>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<PoorlaxNFT>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<PoorlaxNFT>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{url}"));
        let v2 = MintRegistry{
            id      : 0x2::object::new(arg1),
            minters : 0x2::table::new<address, bool>(arg1),
        };
        0x2::display::update_version<PoorlaxNFT>(&mut v1);
        0x2::transfer::public_transfer<0x2::display::Display<PoorlaxNFT>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<MintRegistry>(v2);
    }

    public entry fun mint(arg0: &mut MintRegistry, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!has_minted(arg0, arg4), 1);
        0x2::table::add<address, bool>(&mut arg0.minters, arg4, true);
        let v0 = PoorlaxNFT{
            id          : 0x2::object::new(arg5),
            name        : 0x1::string::utf8(arg1),
            description : 0x1::string::utf8(arg2),
            url         : 0x2::url::new_unsafe_from_bytes(arg3),
        };
        let v1 = NFTMinted{
            nft_id    : 0x2::object::uid_to_address(&v0.id),
            creator   : 0x2::tx_context::sender(arg5),
            recipient : arg4,
            name      : v0.name,
        };
        0x2::event::emit<NFTMinted>(v1);
        0x2::transfer::public_transfer<PoorlaxNFT>(v0, arg4);
    }

    public fun name(arg0: &PoorlaxNFT) : &0x1::string::String {
        &arg0.name
    }

    // decompiled from Move bytecode v6
}

