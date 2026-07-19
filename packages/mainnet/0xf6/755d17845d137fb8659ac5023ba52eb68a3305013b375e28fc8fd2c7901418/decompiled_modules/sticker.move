module 0x606dce8a2bc240a7b2b5fd61c8f614cebb1f3f8dc60940d728cd758524ccfadd::sticker {
    struct STICKER has drop {
        dummy_field: bool,
    }

    struct Sticker has store, key {
        id: 0x2::object::UID,
        design_id: u64,
        name: 0x1::string::String,
        image_uri: 0x1::string::String,
        fragment: 0x1::string::String,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    struct StickerDesign has copy, drop, store {
        design_id: u64,
        name: 0x1::string::String,
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

    struct ChestFeeConfig has key {
        id: 0x2::object::UID,
        fee_mist: u64,
        recipient: address,
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

    struct StickerBurned has copy, drop {
        sticker_id: address,
        design_id: u64,
    }

    entry fun add_sticker_design(arg0: &AdminCap, arg1: &mut StickerCatalog, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: u64, arg6: u64) {
        let v0 = arg1.next_design_id;
        arg1.next_design_id = v0 + 1;
        let v1 = StickerDesign{
            design_id  : v0,
            name       : arg2,
            image_uri  : arg3,
            fragment   : arg4,
            weight     : arg5,
            max_supply : arg6,
            minted     : 0,
            active     : true,
        };
        0x1::vector::push_back<StickerDesign>(&mut arg1.designs, v1);
        let v2 = StickerDesignAdded{
            design_id  : v0,
            name       : arg2,
            weight     : arg5,
            max_supply : arg6,
        };
        0x2::event::emit<StickerDesignAdded>(v2);
    }

    entry fun admin_mint_sticker(arg0: &AdminCap, arg1: &mut StickerCatalog, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = find_design_mut(arg1, arg2);
        assert!(v0.max_supply == 0 || v0.minted < v0.max_supply, 2);
        v0.minted = v0.minted + 1;
        let v1 = Sticker{
            id         : 0x2::object::new(arg4),
            design_id  : v0.design_id,
            name       : v0.name,
            image_uri  : v0.image_uri,
            fragment   : v0.fragment,
            attributes : build_attributes(v0.name),
        };
        let v2 = StickerMinted{
            sticker_id : 0x2::object::uid_to_address(&v1.id),
            design_id  : v0.design_id,
            minter     : arg3,
        };
        0x2::event::emit<StickerMinted>(v2);
        0x2::transfer::public_transfer<Sticker>(v1, arg3);
    }

    fun build_attributes(arg0: 0x1::string::String) : 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String> {
        let v0 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"Type"), arg0);
        v0
    }

    entry fun burn_sticker(arg0: Sticker, arg1: &mut 0x2::tx_context::TxContext) {
        let Sticker {
            id         : v0,
            design_id  : v1,
            name       : _,
            image_uri  : _,
            fragment   : _,
            attributes : _,
        } = arg0;
        let v6 = v0;
        let v7 = StickerBurned{
            sticker_id : 0x2::object::uid_to_address(&v6),
            design_id  : v1,
        };
        0x2::event::emit<StickerBurned>(v7);
        0x2::object::delete(v6);
    }

    public fun chest_fee_mist(arg0: &ChestFeeConfig) : u64 {
        arg0.fee_mist
    }

    public fun chest_fee_recipient(arg0: &ChestFeeConfig) : address {
        arg0.recipient
    }

    entry fun create_chest_fee_config(arg0: &AdminCap, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = ChestFeeConfig{
            id        : 0x2::object::new(arg3),
            fee_mist  : arg1,
            recipient : arg2,
        };
        0x2::transfer::share_object<ChestFeeConfig>(v0);
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
        0x2::display::add<Sticker>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"SuiBoy Sticker - {name}"));
        0x2::display::add<Sticker>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"A collectible SuiBoy sticker - earn it by playing, then attach it to your console to make it your own."));
        0x2::display::add<Sticker>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_uri}"));
        0x2::display::add<Sticker>(&mut v1, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://suiboy.fun"));
        0x2::display::update_version<Sticker>(&mut v1);
        let v2 = 0x2::display::new<Chest>(&v0, arg1);
        0x2::display::add<Chest>(&mut v2, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"SuiBoy Chest"));
        0x2::display::add<Chest>(&mut v2, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"A SuiBoy treasure chest - open it to reveal a random sticker for your console. suiboy.fun."));
        0x2::display::add<Chest>(&mut v2, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"data:image/svg+xml;base64,PHN2ZyB2aWV3Qm94PScwIDAgMTAwIDEwMCcgeG1sbnM9J2h0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnJyByb2xlPSdpbWcnPjx0aXRsZT5TdWlCb3kgQ2hlc3Q8L3RpdGxlPjxyZWN0IHg9JzE1JyB5PSc1Micgd2lkdGg9JzcwJyBoZWlnaHQ9JzM0JyByeD0nNCcgZmlsbD0nIzZiNDQyMCcgc3Ryb2tlPScjM2YyNDEwJyBzdHJva2Utd2lkdGg9JzInLz48cGF0aCBkPSdNMTUsNTIgUTE1LDIwIDUwLDIwIFE4NSwyMCA4NSw1MiBaJyBmaWxsPScjN2E0ZjI4JyBzdHJva2U9JyMzZjI0MTAnIHN0cm9rZS13aWR0aD0nMicvPjxyZWN0IHg9JzEyJyB5PSc0OScgd2lkdGg9Jzc2JyBoZWlnaHQ9JzgnIHJ4PScyJyBmaWxsPScjYzlhMjRhJyBzdHJva2U9JyM4YTZhMWEnIHN0cm9rZS13aWR0aD0nMS41Jy8+PHJlY3QgeD0nMjAnIHk9JzIwJyB3aWR0aD0nOCcgaGVpZ2h0PSc2NicgZmlsbD0nI2M5YTI0YScgb3BhY2l0eT0nMC45Jy8+PHJlY3QgeD0nNzInIHk9JzIwJyB3aWR0aD0nOCcgaGVpZ2h0PSc2NicgZmlsbD0nI2M5YTI0YScgb3BhY2l0eT0nMC45Jy8+PHJlY3QgeD0nNDInIHk9JzQ0JyB3aWR0aD0nMTYnIGhlaWdodD0nMTgnIHJ4PSczJyBmaWxsPScjYzlhMjRhJyBzdHJva2U9JyM4YTZhMWEnIHN0cm9rZS13aWR0aD0nMS41Jy8+PGNpcmNsZSBjeD0nNTAnIGN5PSc1MCcgcj0nMycgZmlsbD0nIzJiMWEwNScvPjxwYXRoIGQ9J001MCw1MiBMNDcsNTggTDUzLDU4IFonIGZpbGw9JyMyYjFhMDUnLz48Y2lyY2xlIGN4PScyNCcgY3k9JzMwJyByPScxLjgnIGZpbGw9JyM4YTZhMWEnLz48Y2lyY2xlIGN4PSc3NicgY3k9JzMwJyByPScxLjgnIGZpbGw9JyM4YTZhMWEnLz48Y2lyY2xlIGN4PScyNCcgY3k9Jzc4JyByPScxLjgnIGZpbGw9JyM4YTZhMWEnLz48Y2lyY2xlIGN4PSc3NicgY3k9Jzc4JyByPScxLjgnIGZpbGw9JyM4YTZhMWEnLz48Y2lyY2xlIGN4PSc2NicgY3k9JzM0JyByPScxLjYnIGZpbGw9JyNmZmU5YTgnLz48cGF0aCBkPSdNNjYsMjkgTDY3LDMzIEw3MSwzNCBMNjcsMzUgTDY2LDM5IEw2NSwzNSBMNjEsMzQgTDY1LDMzIFonIGZpbGw9JyNmZmU5YTgnIG9wYWNpdHk9JzAuOScvPjwvc3ZnPg=="));
        0x2::display::add<Chest>(&mut v2, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://suiboy.fun"));
        0x2::display::update_version<Chest>(&mut v2);
        let (v3, v4) = 0x2::transfer_policy::new<Sticker>(&v0, arg1);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<Sticker>>(v3);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<Sticker>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Sticker>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Chest>>(v2, 0x2::tx_context::sender(arg1));
        let v5 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v5, 0x2::tx_context::sender(arg1));
        let v6 = StickerCatalog{
            id             : 0x2::object::new(arg1),
            designs        : 0x1::vector::empty<StickerDesign>(),
            next_design_id : 0,
        };
        0x2::transfer::share_object<StickerCatalog>(v6);
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

    entry fun open_chest(arg0: Chest, arg1: &mut StickerCatalog, arg2: &ChestFeeConfig, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0x2::random::Random, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) == arg2.fee_mist, 4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, arg2.recipient);
        let Chest { id: v0 } = arg0;
        0x2::object::delete(v0);
        let v1 = total_eligible_weight(arg1);
        assert!(v1 > 0, 1);
        let v2 = 0x2::random::new_generator(arg4, arg5);
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
            id         : 0x2::object::new(arg5),
            design_id  : v7.design_id,
            name       : v7.name,
            image_uri  : v7.image_uri,
            fragment   : v7.fragment,
            attributes : build_attributes(v7.name),
        };
        let v9 = StickerMinted{
            sticker_id : 0x2::object::uid_to_address(&v8.id),
            design_id  : v7.design_id,
            minter     : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<StickerMinted>(v9);
        0x2::transfer::public_transfer<Sticker>(v8, 0x2::tx_context::sender(arg5));
    }

    entry fun resync_sticker(arg0: &mut Sticker, arg1: &StickerCatalog) {
        let v0 = find_design(arg1, arg0.design_id);
        arg0.name = v0.name;
        arg0.image_uri = v0.image_uri;
        arg0.fragment = v0.fragment;
        arg0.attributes = build_attributes(v0.name);
    }

    entry fun set_chest_fee(arg0: &AdminCap, arg1: &mut ChestFeeConfig, arg2: u64) {
        arg1.fee_mist = arg2;
    }

    entry fun set_chest_fee_recipient(arg0: &AdminCap, arg1: &mut ChestFeeConfig, arg2: address) {
        arg1.recipient = arg2;
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

