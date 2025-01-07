module 0xb32dc6b71d2c13bb220957d0664b20b9b822c1deb48c930e6d112de9303f946a::wave_genesis_nft {
    struct NFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x2::url::Url,
        nft_type: u16,
    }

    struct NftOwnerCap has key {
        id: 0x2::object::UID,
    }

    struct AppKey has copy, drop, store {
        dummy_field: bool,
    }

    struct AppCap has drop, store {
        minting_limit: u64,
        minting_counter: u64,
    }

    struct WAVE_GENESIS_NFT has drop {
        dummy_field: bool,
    }

    fun app_cap_mut(arg0: &mut 0x2::object::UID) : &mut AppCap {
        let v0 = AppKey{dummy_field: false};
        0x2::dynamic_field::borrow_mut<AppKey, AppCap>(arg0, v0)
    }

    public fun authorize_app(arg0: &NftOwnerCap, arg1: &mut 0x2::object::UID, arg2: u64) {
        let v0 = AppKey{dummy_field: false};
        let v1 = AppCap{
            minting_limit   : arg2,
            minting_counter : 0,
        };
        0x2::dynamic_field::add<AppKey, AppCap>(arg1, v0, v1);
    }

    public fun burn(arg0: &mut 0x2::object::UID, arg1: NFT) : 0x2::object::UID {
        assert!(is_authorized(arg0), 0);
        let NFT {
            id          : v0,
            name        : _,
            description : _,
            image_url   : _,
            nft_type    : _,
        } = arg1;
        v0
    }

    public entry fun correct_metadata(arg0: &mut NFT) {
        arg0.name = 0x1::string::utf8(b"Wave Genesis NFT");
        arg0.description = 0x1::string::utf8(b"The Wave Genesis NFT provides access to future Launchpad events on WavePad. It facilitates whitelisting and maximizes allocation for upcoming rounds");
        arg0.image_url = 0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/nfts/genesis.png");
    }

    public fun get_id(arg0: &NFT) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    fun init(arg0: WAVE_GENESIS_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"type"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"type"));
        let v4 = 0x2::package::claim<WAVE_GENESIS_NFT>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<NFT>(&v4, v0, v2, arg1);
        0x2::display::update_version<NFT>(&mut v5);
        let v6 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, v6);
        0x2::transfer::public_transfer<0x2::display::Display<NFT>>(v5, v6);
        let v7 = NftOwnerCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<NftOwnerCap>(v7, v6);
    }

    public fun is_authorized(arg0: &0x2::object::UID) : bool {
        let v0 = AppKey{dummy_field: false};
        0x2::dynamic_field::exists_<AppKey>(arg0, v0)
    }

    public fun mint(arg0: &mut 0x2::object::UID, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: u16, arg5: &mut 0x2::tx_context::TxContext) : NFT {
        assert!(is_authorized(arg0), 0);
        let v0 = app_cap_mut(arg0);
        assert!(v0.minting_limit == 0 || v0.minting_counter < v0.minting_limit, 1);
        v0.minting_counter = v0.minting_counter + 1;
        NFT{
            id          : 0x2::object::new(arg5),
            name        : 0x1::string::utf8(arg1),
            description : 0x1::string::utf8(arg2),
            image_url   : 0x2::url::new_unsafe_from_bytes(arg3),
            nft_type    : arg4,
        }
    }

    public fun revoke_auth(arg0: &NftOwnerCap, arg1: &mut 0x2::object::UID) {
        let v0 = AppKey{dummy_field: false};
        let AppCap {
            minting_limit   : _,
            minting_counter : _,
        } = 0x2::dynamic_field::remove<AppKey, AppCap>(arg1, v0);
    }

    // decompiled from Move bytecode v6
}

