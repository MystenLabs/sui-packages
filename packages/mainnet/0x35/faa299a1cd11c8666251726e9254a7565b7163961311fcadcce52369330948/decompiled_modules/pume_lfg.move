module 0x35faa299a1cd11c8666251726e9254a7565b7163961311fcadcce52369330948::pume_lfg {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct RootConfig has key {
        id: 0x2::object::UID,
        index: u64,
        max_supply: u64,
    }

    struct Nft has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
        description: 0x1::string::String,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
        pume_index: u64,
        group_id: 0x1::string::String,
    }

    struct PUME_LFG has drop {
        dummy_field: bool,
    }

    public fun get_config_index(arg0: &RootConfig) : u64 {
        arg0.index
    }

    public fun get_config_max_supply(arg0: &RootConfig) : u64 {
        arg0.max_supply
    }

    public fun get_mintable(arg0: &RootConfig) : bool {
        arg0.index < arg0.max_supply
    }

    fun init(arg0: PUME_LFG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://pume.zone/lfg/{id}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"PUME_FORCE"));
        let v4 = 0x2::package::claim<PUME_LFG>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<Nft>(&v4, v0, v2, arg1);
        let v6 = AdminCap{id: 0x2::object::new(arg1)};
        let v7 = RootConfig{
            id         : 0x2::object::new(arg1),
            index      : 0,
            max_supply : 100000,
        };
        0x2::display::update_version<Nft>(&mut v5);
        0x2::transfer::share_object<RootConfig>(v7);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Nft>>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<AdminCap>(v6, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint_lfg(arg0: &mut RootConfig, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.index < arg0.max_supply, 0);
        let v0 = Nft{
            id          : 0x2::object::new(arg1),
            name        : 0x1::string::utf8(b"PUME LFG"),
            image_url   : 0x1::string::utf8(b"ipfs://QmZq4LA7TjLxoBA4AsM8ehtiQnF2vJaAC2mBGwGK2zj5KQ"),
            description : 0x1::string::utf8(b"A symbol of courage and community, unlocking exclusive perks and rewards in the PUME ecosystem. LFG!"),
            attributes  : 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>(),
            pume_index  : arg0.index,
            group_id    : 0x1::string::utf8(b"EARLY_ACCESS"),
        };
        arg0.index = arg0.index + 1;
        0x2::transfer::public_transfer<Nft>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun update_max_suply(arg0: &mut AdminCap, arg1: &mut RootConfig, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.max_supply = arg2;
    }

    // decompiled from Move bytecode v6
}

