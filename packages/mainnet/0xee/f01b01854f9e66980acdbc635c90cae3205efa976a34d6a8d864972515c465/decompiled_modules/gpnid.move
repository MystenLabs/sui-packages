module 0xeef01b01854f9e66980acdbc635c90cae3205efa976a34d6a8d864972515c465::gpnid {
    struct GID_NFT has key {
        id: 0x2::object::UID,
        gid: u64,
        name: 0x1::string::String,
        symbol: 0x1::string::String,
    }

    struct GID_Minted has store, key {
        id: 0x2::object::UID,
        minted: u64,
    }

    struct UserMinted has drop, store {
        minted: 0x2::object::ID,
    }

    struct GPNID has drop {
        dummy_field: bool,
    }

    struct NFTMinted has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    public entry fun burn(arg0: GID_NFT, arg1: &mut GID_Minted, arg2: &mut 0x2::tx_context::TxContext) {
        let GID_NFT {
            id     : v0,
            gid    : _,
            name   : _,
            symbol : _,
        } = arg0;
        0x2::object::delete(v0);
        0x2::dynamic_field::remove_if_exists<address, UserMinted>(&mut arg1.id, 0x2::tx_context::sender(arg2));
    }

    public entry fun exists_with_gid(arg0: &mut GID_Minted, arg1: address) : bool {
        0x2::dynamic_field::exists_with_type<address, UserMinted>(&arg0.id, arg1)
    }

    fun init(arg0: GPNID, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"GreenPowerN-GID #{gid}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://ipfs.greenpowern.com/gid/s/{gid}.json"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://ipfs.greenpowern.com/gid/s/GID-S{gid}.png"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"GreenPower ID (GID) is an unique decentralized identity for global users to participate in GreenPower Network. Users are granted access to Charge to Earn by GID and can earn green power points for helping to develop the green power ecosystem."));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://greenpowern.com/"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"GreenPowerN-ID"));
        let v4 = 0x2::package::claim<GPNID>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<GID_NFT>(&v4, v0, v2, arg1);
        0x2::display::update_version<GID_NFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<GID_NFT>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = GID_Minted{
            id     : 0x2::object::new(arg1),
            minted : 0,
        };
        0x2::transfer::share_object<GID_Minted>(v6);
    }

    public entry fun mint(arg0: &mut GID_Minted, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x2::dynamic_field::exists_with_type<address, UserMinted>(&arg0.id, v0) == false, 1);
        let v1 = arg0.minted + 1;
        arg0.minted = v1;
        let v2 = GID_NFT{
            id     : 0x2::object::new(arg1),
            gid    : v1,
            name   : 0x1::string::utf8(b"GreenPowerN-ID"),
            symbol : 0x1::string::utf8(b"GID"),
        };
        let v3 = 0x2::object::id<GID_NFT>(&v2);
        let v4 = NFTMinted{
            object_id : v3,
            creator   : v0,
            name      : v2.name,
        };
        0x2::event::emit<NFTMinted>(v4);
        0x2::transfer::transfer<GID_NFT>(v2, v0);
        let v5 = UserMinted{minted: v3};
        0x2::dynamic_field::add<address, UserMinted>(&mut arg0.id, v0, v5);
    }

    public entry fun token_uri(arg0: u64) : 0x1::string::String {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = &mut v0;
        while (arg0 != 0) {
            0x1::vector::push_back<u8>(v1, ((arg0 % 10 + 48) as u8));
            arg0 = arg0 / 10;
        };
        0x1::vector::reverse<u8>(v1);
        let v2 = 0x1::string::utf8(b"https://ipfs.greenpowern.com/gid/s/");
        let v3 = &mut v2;
        0x1::string::append(v3, 0x1::string::utf8(*v1));
        0x1::string::append(v3, 0x1::string::utf8(b".json"));
        *v3
    }

    // decompiled from Move bytecode v6
}

