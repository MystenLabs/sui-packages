module 0xfaab38e9a642721ec8435b40b03792a5c25a400501a628e0a30d7ba20b081b99::pfp {
    struct MangaMirror has store, key {
        id: 0x2::object::UID,
        version: u64,
    }

    struct PFPCollection has store, key {
        id: 0x2::object::UID,
        version: u64,
        name: 0x1::string::String,
        description: 0x1::string::String,
    }

    struct PFP has drop {
        dummy_field: bool,
    }

    public fun delete(arg0: MangaMirror, arg1: &0x2::package::Publisher) {
        assert!(0x2::package::from_module<MangaMirror>(arg1), 0);
        let MangaMirror {
            id      : v0,
            version : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    fun init(arg0: PFP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<PFP>(arg0, arg1);
        let v1 = PFPCollection{
            id          : 0x2::object::new(arg1),
            version     : 1,
            name        : 0x1::string::utf8(b"Manga Mirror: AI-Generated Anime PFP Collection"),
            description : 0x1::string::utf8(b"Commemorative NFT collection from Sui Builder House: Kyoto, Japan 2023"),
        };
        0x2::transfer::share_object<PFPCollection>(v1);
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"thumbnail_url"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"creator"));
        let v4 = 0x1::vector::empty<0x1::string::String>();
        let v5 = &mut v4;
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"Unrevealed Manga Mirror PFP"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"Sui Builder House: Kyoto, Japan 2023"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"https://bh.sui.io"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"ipfs://bafybeibsuoyfybnxokbtpdnsbebt5faixbhi24z4v75uvp5t6v7szmlbae/unrevealed-full.jpg"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"ipfs://bafybeihalni6ldb7vixn5kksacfkgs3fpa4smmycgbaaerkwv24xrbso2y/unrevealed-thumbnail.jpg"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"https://sui.io"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"AkashaCoin"));
        let v6 = 0x2::display::new_with_fields<MangaMirror>(&v0, v2, v4, arg1);
        0x2::display::update_version<MangaMirror>(&mut v6);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<MangaMirror>>(v6, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) : MangaMirror {
        assert!(0x2::package::from_module<MangaMirror>(arg0), 0);
        MangaMirror{
            id      : 0x2::object::new(arg1),
            version : 1,
        }
    }

    public fun set_collection_info(arg0: &mut PFPCollection, arg1: &0x2::package::Publisher, arg2: 0x1::string::String, arg3: 0x1::string::String) {
        assert!(0x2::package::from_module<PFPCollection>(arg1), 0);
        arg0.name = arg2;
        arg0.description = arg3;
    }

    public fun update_display(arg0: &0x2::package::Publisher, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::package::from_module<MangaMirror>(arg0), 0);
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"thumbnail_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, arg1);
        0x1::vector::push_back<0x1::string::String>(v3, arg2);
        0x1::vector::push_back<0x1::string::String>(v3, arg3);
        0x1::vector::push_back<0x1::string::String>(v3, arg4);
        0x1::vector::push_back<0x1::string::String>(v3, arg5);
        0x1::vector::push_back<0x1::string::String>(v3, arg6);
        0x1::vector::push_back<0x1::string::String>(v3, arg7);
        let v4 = 0x2::display::new_with_fields<MangaMirror>(arg0, v0, v2, arg8);
        0x2::display::update_version<MangaMirror>(&mut v4);
        0x2::transfer::public_transfer<0x2::display::Display<MangaMirror>>(v4, 0x2::tx_context::sender(arg8));
    }

    // decompiled from Move bytecode v6
}

