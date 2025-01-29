module 0xfcf33f6367c6217c118cffc4105eddf5797b3d012ef27ea0cf3ee06844f250cf::nft_airdrop {
    struct Nft has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x2::url::Url,
    }

    struct Admin has store {
        admin_address: address,
    }

    struct MintingControl has store, key {
        id: 0x2::object::UID,
        paused: bool,
        admin: Admin,
    }

    struct NFT_AIRDROP has drop {
        dummy_field: bool,
    }

    struct NFTMinted has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    public fun transfer(arg0: Nft, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<Nft>(arg0, arg1);
    }

    public fun burn(arg0: Nft, arg1: &mut 0x2::tx_context::TxContext) {
        let Nft {
            id          : v0,
            name        : _,
            description : _,
            image_url   : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun description(arg0: &Nft) : &0x1::string::String {
        &arg0.description
    }

    public fun image_url(arg0: &Nft) : &0x2::url::Url {
        &arg0.image_url
    }

    fun init(arg0: NFT_AIRDROP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"ipfs://{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://coinfever.app"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"CoinFever"));
        let v4 = 0x2::package::claim<NFT_AIRDROP>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<Nft>(&v4, v0, v2, arg1);
        0x2::display::update_version<Nft>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Nft>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = Admin{admin_address: 0x2::tx_context::sender(arg1)};
        let v7 = MintingControl{
            id     : 0x2::object::new(arg1),
            paused : false,
            admin  : v6,
        };
        0x2::transfer::share_object<MintingControl>(v7);
    }

    fun is_admin(arg0: &MintingControl, arg1: address) : bool {
        arg0.admin.admin_address == arg1
    }

    public fun mint_to_address(arg0: &mut MintingControl, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(is_admin(arg0, v0), 0);
        let v1 = Nft{
            id          : 0x2::object::new(arg2),
            name        : 0x1::string::utf8(b"El Patron"),
            description : 0x1::string::utf8(b""),
            image_url   : 0x2::url::new_unsafe_from_bytes(b"Qma5ViYp3nxwHiJp22GB3R7SNZjHRjSY9xKpL8oqF2cS1Z"),
        };
        let v2 = NFTMinted{
            object_id : 0x2::object::id<Nft>(&v1),
            creator   : v0,
            name      : v1.name,
        };
        0x2::event::emit<NFTMinted>(v2);
        0x2::transfer::public_transfer<Nft>(v1, arg1);
    }

    public fun mint_to_sender(arg0: &mut MintingControl, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.paused == false, 1);
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = Nft{
            id          : 0x2::object::new(arg1),
            name        : 0x1::string::utf8(b"El Patron"),
            description : 0x1::string::utf8(b""),
            image_url   : 0x2::url::new_unsafe_from_bytes(b"Qma5ViYp3nxwHiJp22GB3R7SNZjHRjSY9xKpL8oqF2cS1Z"),
        };
        let v2 = NFTMinted{
            object_id : 0x2::object::id<Nft>(&v1),
            creator   : v0,
            name      : v1.name,
        };
        0x2::event::emit<NFTMinted>(v2);
        0x2::transfer::public_transfer<Nft>(v1, v0);
    }

    public fun name(arg0: &Nft) : &0x1::string::String {
        &arg0.name
    }

    public fun pause(arg0: &mut MintingControl, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(is_admin(arg0, 0x2::tx_context::sender(arg1)), 0);
        arg0.paused = true;
    }

    public fun unpause(arg0: &mut MintingControl, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(is_admin(arg0, 0x2::tx_context::sender(arg1)), 0);
        arg0.paused = false;
    }

    // decompiled from Move bytecode v6
}

