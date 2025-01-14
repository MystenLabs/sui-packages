module 0xb075419b71713d839b7c9ff4ccd7e2c31999174411f93e9b6f017e4594b7f044::maniac_wl {
    struct WlNft has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
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

    struct MANIAC_WL has drop {
        dummy_field: bool,
    }

    public fun transfer(arg0: WlNft, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<WlNft>(arg0, arg1);
    }

    public fun burn(arg0: WlNft, arg1: &mut 0x2::tx_context::TxContext) {
        let WlNft {
            id        : v0,
            name      : _,
            image_url : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun image_url(arg0: &WlNft) : &0x2::url::Url {
        &arg0.image_url
    }

    fun init(arg0: MANIAC_WL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"ipfs://{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"WL spot for the Fever Maniac NFT collection of coinfever.app"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://coinfever.app"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"CoinFever"));
        let v4 = 0x2::package::claim<MANIAC_WL>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<WlNft>(&v4, v0, v2, arg1);
        0x2::display::update_version<WlNft>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<WlNft>>(v5, 0x2::tx_context::sender(arg1));
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

    public fun mint_to_address_list(arg0: &mut MintingControl, arg1: vector<address>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(is_admin(arg0, 0x2::tx_context::sender(arg2)), 0);
        assert!(0x1::vector::length<address>(&arg1) >= 1, 2);
        while (!0x1::vector::is_empty<address>(&arg1)) {
            let v0 = WlNft{
                id        : 0x2::object::new(arg2),
                name      : 0x1::string::utf8(b"Fever Maniac WL"),
                image_url : 0x2::url::new_unsafe_from_bytes(b"QmUM4tZjjSff3DAEyjgBgSmDQXTuRHR9E5fhzkMBwxhR7A"),
            };
            0x2::transfer::public_transfer<WlNft>(v0, 0x1::vector::pop_back<address>(&mut arg1));
        };
        0x1::vector::destroy_empty<address>(arg1);
    }

    public fun name(arg0: &WlNft) : &0x1::string::String {
        &arg0.name
    }

    // decompiled from Move bytecode v6
}

