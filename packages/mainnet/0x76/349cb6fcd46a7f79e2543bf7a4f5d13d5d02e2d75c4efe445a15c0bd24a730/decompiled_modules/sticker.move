module 0x664d58be00187e024697aae7b004990e4bb2f655955813b560ed2650a3c7f47a::sticker {
    struct STICKER has drop {
        dummy_field: bool,
    }

    struct Sticker has store, key {
        id: 0x2::object::UID,
        design_id: u64,
        name: 0x1::string::String,
        rarity: 0x1::string::String,
        image_uri: 0x1::string::String,
        fragment: 0x1::string::String,
    }

    struct StickerDesign has copy, drop, store {
        design_id: u64,
        name: 0x1::string::String,
        rarity: 0x1::string::String,
        image_uri: 0x1::string::String,
        fragment: 0x1::string::String,
        weight: u64,
        max_supply: u64,
        minted: u64,
        active: bool,
    }

    struct StickerCatalog has key {
        id: 0x2::object::UID,
        designs: vector<StickerDesign>,
        next_design_id: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Chest has store, key {
        id: 0x2::object::UID,
    }

    struct ChestMinterCap has store, key {
        id: 0x2::object::UID,
    }

    struct StickerDesignAdded has copy, drop {
        design_id: u64,
        name: 0x1::string::String,
        weight: u64,
        max_supply: u64,
    }

    struct StickerMinted has copy, drop {
        sticker_id: address,
        design_id: u64,
        minter: address,
    }

    struct ChestGranted has copy, drop {
        chest_id: address,
        recipient: address,
    }

    entry fun add_sticker_design(arg0: &AdminCap, arg1: &mut StickerCatalog, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: u64, arg7: u64) {
        let v0 = arg1.next_design_id;
        arg1.next_design_id = v0 + 1;
        let v1 = StickerDesign{
            design_id  : v0,
            name       : arg2,
            rarity     : arg3,
            image_uri  : arg4,
            fragment   : arg5,
            weight     : arg6,
            max_supply : arg7,
            minted     : 0,
            active     : true,
        };
        0x1::vector::push_back<StickerDesign>(&mut arg1.designs, v1);
        let v2 = StickerDesignAdded{
            design_id  : v0,
            name       : arg2,
            weight     : arg6,
            max_supply : arg7,
        };
        0x2::event::emit<StickerDesignAdded>(v2);
    }

    public fun design_id(arg0: &Sticker) : u64 {
        arg0.design_id
    }

    fun design_is_eligible(arg0: &StickerDesign) : bool {
        arg0.active && (arg0.max_supply == 0 || arg0.minted < arg0.max_supply)
    }

    fun find_design(arg0: &StickerCatalog, arg1: u64) : &StickerDesign {
        let v0 = 0x1::vector::length<StickerDesign>(&arg0.designs);
        let v1 = 0;
        while (v1 < v0) {
            if (v0 == v0) {
            };
            v1 = v1 + 1;
        };
        assert!(v0 < v0, 0);
        0x1::vector::borrow<StickerDesign>(&arg0.designs, v0)
    }

    fun find_design_mut(arg0: &mut StickerCatalog, arg1: u64) : &mut StickerDesign {
        let v0 = 0x1::vector::length<StickerDesign>(&arg0.designs);
        let v1 = 0;
        while (v1 < v0) {
            if (v0 == v0) {
            };
            v1 = v1 + 1;
        };
        assert!(v0 < v0, 0);
        0x1::vector::borrow_mut<StickerDesign>(&mut arg0.designs, v0)
    }

    public fun fragment(arg0: &Sticker) : 0x1::string::String {
        arg0.fragment
    }

    public fun image_uri(arg0: &Sticker) : 0x1::string::String {
        arg0.image_uri
    }

    fun init(arg0: STICKER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<STICKER>(arg0, arg1);
        let v1 = 0x2::display::new<Sticker>(&v0, arg1);
        0x2::display::add<Sticker>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<Sticker>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"A SuiBoy sticker ({rarity}). Attach it to a SuiBoy Console at suiboy.fun."));
        0x2::display::add<Sticker>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_uri}"));
        0x2::display::add<Sticker>(&mut v1, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://suiboy.fun"));
        0x2::display::update_version<Sticker>(&mut v1);
        let (v2, v3) = 0x2::transfer_policy::new<Sticker>(&v0, arg1);
        let v4 = v3;
        let v5 = v2;
        0x664d58be00187e024697aae7b004990e4bb2f655955813b560ed2650a3c7f47a::royalty_rule::add<Sticker>(&mut v5, &v4, 200, 0);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<Sticker>>(v5);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<Sticker>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Sticker>>(v1, 0x2::tx_context::sender(arg1));
        let v6 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v6, 0x2::tx_context::sender(arg1));
        let v7 = StickerCatalog{
            id             : 0x2::object::new(arg1),
            designs        : 0x1::vector::empty<StickerDesign>(),
            next_design_id : 0,
        };
        0x2::transfer::share_object<StickerCatalog>(v7);
    }

    entry fun issue_chest_minter_cap(arg0: &AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = ChestMinterCap{id: 0x2::object::new(arg2)};
        0x2::transfer::public_transfer<ChestMinterCap>(v0, arg1);
    }

    entry fun mint_chest(arg0: &ChestMinterCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Chest{id: 0x2::object::new(arg2)};
        let v1 = ChestGranted{
            chest_id  : 0x2::object::uid_to_address(&v0.id),
            recipient : arg1,
        };
        0x2::event::emit<ChestGranted>(v1);
        0x2::transfer::public_transfer<Chest>(v0, arg1);
    }

    public fun name(arg0: &Sticker) : 0x1::string::String {
        arg0.name
    }

    entry fun open_chest(arg0: Chest, arg1: &mut StickerCatalog, arg2: &0x2::random::Random, arg3: &mut 0x2::tx_context::TxContext) {
        let Chest { id: v0 } = arg0;
        0x2::object::delete(v0);
        let v1 = total_eligible_weight(arg1);
        assert!(v1 > 0, 1);
        let v2 = 0x2::random::new_generator(arg2, arg3);
        let v3 = 0x2::random::generate_u64_in_range(&mut v2, 0, v1 - 1);
        let v4 = 0x1::vector::length<StickerDesign>(&arg1.designs);
        let v5 = 0;
        while (v5 < v4) {
            if (v4 == v4) {
                let v6 = 0x1::vector::borrow<StickerDesign>(&arg1.designs, v5);
                if (design_is_eligible(v6)) {
                    if (v3 < v6.weight) {
                    } else {
                        v3 = v3 - v6.weight;
                    };
                };
            };
            v5 = v5 + 1;
        };
        assert!(v4 < v4, 1);
        let v7 = 0x1::vector::borrow_mut<StickerDesign>(&mut arg1.designs, v4);
        v7.minted = v7.minted + 1;
        let v8 = Sticker{
            id        : 0x2::object::new(arg3),
            design_id : v7.design_id,
            name      : v7.name,
            rarity    : v7.rarity,
            image_uri : v7.image_uri,
            fragment  : v7.fragment,
        };
        let v9 = StickerMinted{
            sticker_id : 0x2::object::uid_to_address(&v8.id),
            design_id  : v7.design_id,
            minter     : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<StickerMinted>(v9);
        0x2::transfer::public_transfer<Sticker>(v8, 0x2::tx_context::sender(arg3));
    }

    public fun rarity(arg0: &Sticker) : 0x1::string::String {
        arg0.rarity
    }

    entry fun resync_sticker(arg0: &mut Sticker, arg1: &StickerCatalog) {
        let v0 = find_design(arg1, arg0.design_id);
        arg0.name = v0.name;
        arg0.rarity = v0.rarity;
        arg0.image_uri = v0.image_uri;
        arg0.fragment = v0.fragment;
    }

    entry fun set_design_active(arg0: &AdminCap, arg1: &mut StickerCatalog, arg2: u64, arg3: bool) {
        find_design_mut(arg1, arg2).active = arg3;
    }

    entry fun set_design_content(arg0: &AdminCap, arg1: &mut StickerCatalog, arg2: u64, arg3: 0x1::string::String, arg4: 0x1::string::String) {
        let v0 = find_design_mut(arg1, arg2);
        v0.image_uri = arg3;
        v0.fragment = arg4;
    }

    entry fun set_design_max_supply(arg0: &AdminCap, arg1: &mut StickerCatalog, arg2: u64, arg3: u64) {
        let v0 = find_design_mut(arg1, arg2);
        assert!(arg3 == 0 || arg3 >= v0.minted, 2);
        v0.max_supply = arg3;
    }

    entry fun set_design_weight(arg0: &AdminCap, arg1: &mut StickerCatalog, arg2: u64, arg3: u64) {
        find_design_mut(arg1, arg2).weight = arg3;
    }

    fun total_eligible_weight(arg0: &StickerCatalog) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v0 < 0x1::vector::length<StickerDesign>(&arg0.designs)) {
            let v2 = 0x1::vector::borrow<StickerDesign>(&arg0.designs, v0);
            if (design_is_eligible(v2)) {
                v1 = v1 + v2.weight;
            };
            v0 = v0 + 1;
        };
        v1
    }

    // decompiled from Move bytecode v7
}

