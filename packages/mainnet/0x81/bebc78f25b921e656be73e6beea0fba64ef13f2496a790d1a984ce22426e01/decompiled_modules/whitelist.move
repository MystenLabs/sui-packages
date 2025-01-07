module 0x81bebc78f25b921e656be73e6beea0fba64ef13f2496a790d1a984ce22426e01::whitelist {
    struct WHITELIST has drop {
        dummy_field: bool,
    }

    struct WhitelistControllerCap has store, key {
        id: 0x2::object::UID,
    }

    struct WhitelistUser has copy, drop, store {
        minted: bool,
        type: u8,
    }

    struct WhitelistRegistry has store, key {
        id: 0x2::object::UID,
        start_time: u64,
        end_time: u64,
        sprout_limit: u64,
        sprout_minted: u64,
        adepts_minted: u64,
        ancients_minted: u64,
        masters_minted: u64,
        whitelist: 0x2::table::Table<address, WhitelistUser>,
    }

    struct SproutWisp has store, key {
        id: 0x2::object::UID,
        image_url: 0x1::string::String,
        creator: address,
    }

    struct AdeptWisp has store, key {
        id: 0x2::object::UID,
        image_url: 0x1::string::String,
        creator: address,
    }

    struct AncientWisp has store, key {
        id: 0x2::object::UID,
        creator: address,
    }

    struct MasterWisp has store, key {
        id: 0x2::object::UID,
        image_url: 0x1::string::String,
        creator: address,
    }

    struct Minted has copy, drop {
        nft_id: 0x2::object::ID,
        user: address,
        type: u8,
    }

    fun whitelist(arg0: &mut 0x2::table::Table<address, WhitelistUser>, arg1: vector<address>, arg2: u8) {
        while (0x1::vector::length<address>(&arg1) > 0) {
            let v0 = 0x1::vector::pop_back<address>(&mut arg1);
            if (!0x2::table::contains<address, WhitelistUser>(arg0, v0)) {
                let v1 = WhitelistUser{
                    minted : false,
                    type   : arg2,
                };
                0x2::table::add<address, WhitelistUser>(arg0, v0, v1);
            };
        };
    }

    fun check_mint_time(arg0: &WhitelistRegistry, arg1: &0x2::clock::Clock) {
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.start_time && 0x2::clock::timestamp_ms(arg1) <= arg0.end_time, 0);
    }

    fun create_image_url(arg0: vector<u8>) : 0x1::string::String {
        let v0 = b"https://gateway.pinata.cloud/ipfs/";
        0x1::vector::append<u8>(&mut v0, arg0);
        0x1::string::utf8(v0)
    }

    fun init(arg0: WHITELIST, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<WHITELIST>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"creator"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"Sprout Wisp!"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://www.wispswap.io/"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"testdes"));
        0x1::vector::push_back<0x1::string::String>(v4, create_image_url(b"QmVe6JohckUDQv4DuCtiNG2aSJNpzPwpaSXU57wgsT49RS"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{creator}"));
        let v5 = 0x2::display::new_with_fields<SproutWisp>(&v0, v1, v3, arg1);
        0x2::display::update_version<SproutWisp>(&mut v5);
        0x2::transfer::public_transfer<0x2::display::Display<SproutWisp>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = 0x1::vector::empty<0x1::string::String>();
        let v7 = &mut v6;
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"Adept Wisp!"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"https://www.wispswap.io/"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"testdes"));
        0x1::vector::push_back<0x1::string::String>(v7, create_image_url(b"QmcyF6dENRa3A21A3nC94sxa3anVj19BxyYzYLGABuPQ1W"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"{creator}"));
        let v8 = 0x2::display::new_with_fields<AdeptWisp>(&v0, v1, v6, arg1);
        0x2::display::update_version<AdeptWisp>(&mut v8);
        0x2::transfer::public_transfer<0x2::display::Display<AdeptWisp>>(v8, 0x2::tx_context::sender(arg1));
        let v9 = 0x1::vector::empty<0x1::string::String>();
        let v10 = &mut v9;
        0x1::vector::push_back<0x1::string::String>(v10, 0x1::string::utf8(b"Ancient Wisp!"));
        0x1::vector::push_back<0x1::string::String>(v10, 0x1::string::utf8(b"https://www.wispswap.io/"));
        0x1::vector::push_back<0x1::string::String>(v10, 0x1::string::utf8(b"testdes"));
        0x1::vector::push_back<0x1::string::String>(v10, 0x1::string::utf8(b"https://alpha.wispswap.io/images/coins/wisp.png"));
        0x1::vector::push_back<0x1::string::String>(v10, 0x1::string::utf8(b"{creator}"));
        let v11 = 0x2::display::new_with_fields<AncientWisp>(&v0, v1, v9, arg1);
        0x2::display::update_version<AncientWisp>(&mut v11);
        0x2::transfer::public_transfer<0x2::display::Display<AncientWisp>>(v11, 0x2::tx_context::sender(arg1));
        let v12 = 0x1::vector::empty<0x1::string::String>();
        let v13 = &mut v12;
        0x1::vector::push_back<0x1::string::String>(v13, 0x1::string::utf8(b"Master Wisp!"));
        0x1::vector::push_back<0x1::string::String>(v13, 0x1::string::utf8(b"https://www.wispswap.io/"));
        0x1::vector::push_back<0x1::string::String>(v13, 0x1::string::utf8(b"testdes"));
        0x1::vector::push_back<0x1::string::String>(v13, create_image_url(b"QmWbXt9fggzVkFpuBWvjdg2TYBq7UfVx4SHtEq5YR5W1oG"));
        0x1::vector::push_back<0x1::string::String>(v13, 0x1::string::utf8(b"{creator}"));
        let v14 = 0x2::display::new_with_fields<MasterWisp>(&v0, v1, v12, arg1);
        0x2::display::update_version<MasterWisp>(&mut v14);
        0x2::transfer::public_transfer<0x2::display::Display<MasterWisp>>(v14, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        let v15 = WhitelistControllerCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<WhitelistControllerCap>(v15, 0x2::tx_context::sender(arg1));
        let v16 = WhitelistRegistry{
            id              : 0x2::object::new(arg1),
            start_time      : 0,
            end_time        : 0,
            sprout_limit    : 0,
            sprout_minted   : 0,
            adepts_minted   : 0,
            ancients_minted : 0,
            masters_minted  : 0,
            whitelist       : 0x2::table::new<address, WhitelistUser>(arg1),
        };
        0x2::transfer::share_object<WhitelistRegistry>(v16);
    }

    fun mint(arg0: &mut 0x2::table::Table<address, WhitelistUser>, arg1: address, arg2: 0x2::object::ID, arg3: u8) {
        assert!(0x2::table::contains<address, WhitelistUser>(arg0, arg1), 1);
        assert!(0x2::table::borrow<address, WhitelistUser>(arg0, arg1).type == arg3, 5);
        assert!(!0x2::table::borrow<address, WhitelistUser>(arg0, arg1).minted, 2);
        0x2::table::borrow_mut<address, WhitelistUser>(arg0, arg1).minted = true;
        let v0 = Minted{
            nft_id : arg2,
            user   : arg1,
            type   : arg3,
        };
        0x2::event::emit<Minted>(v0);
    }

    public entry fun mint_adept(arg0: &mut WhitelistRegistry, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        check_mint_time(arg0, arg1);
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::object::new(arg2);
        let v2 = &mut arg0.whitelist;
        mint(v2, v0, 0x2::object::uid_to_inner(&v1), 1);
        let v3 = AdeptWisp{
            id        : v1,
            image_url : create_image_url(b"QmcyF6dENRa3A21A3nC94sxa3anVj19BxyYzYLGABuPQ1W"),
            creator   : v0,
        };
        arg0.adepts_minted = arg0.adepts_minted + 1;
        0x2::transfer::transfer<AdeptWisp>(v3, v0);
    }

    public entry fun mint_ancient(arg0: &mut WhitelistRegistry, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        check_mint_time(arg0, arg1);
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::object::new(arg2);
        let v2 = &mut arg0.whitelist;
        mint(v2, v0, 0x2::object::uid_to_inner(&v1), 2);
        let v3 = AncientWisp{
            id      : v1,
            creator : v0,
        };
        arg0.ancients_minted = arg0.ancients_minted + 1;
        0x2::transfer::transfer<AncientWisp>(v3, v0);
    }

    public entry fun mint_master(arg0: &mut WhitelistRegistry, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        check_mint_time(arg0, arg1);
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::object::new(arg2);
        let v2 = &mut arg0.whitelist;
        mint(v2, v0, 0x2::object::uid_to_inner(&v1), 3);
        let v3 = MasterWisp{
            id        : v1,
            image_url : create_image_url(b"QmWbXt9fggzVkFpuBWvjdg2TYBq7UfVx4SHtEq5YR5W1oG"),
            creator   : v0,
        };
        arg0.masters_minted = arg0.masters_minted + 1;
        0x2::transfer::transfer<MasterWisp>(v3, v0);
    }

    public entry fun mint_sprout(arg0: &mut WhitelistRegistry, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        check_mint_time(arg0, arg1);
        assert!(arg0.sprout_minted < arg0.sprout_limit, 3);
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::object::new(arg2);
        let v2 = &mut arg0.whitelist;
        mint(v2, v0, 0x2::object::uid_to_inner(&v1), 0);
        let v3 = SproutWisp{
            id        : v1,
            image_url : create_image_url(b"QmVe6JohckUDQv4DuCtiNG2aSJNpzPwpaSXU57wgsT49RS"),
            creator   : v0,
        };
        arg0.sprout_minted = arg0.sprout_minted + 1;
        0x2::transfer::transfer<SproutWisp>(v3, v0);
    }

    fun revoke(arg0: &mut 0x2::table::Table<address, WhitelistUser>, arg1: vector<address>, arg2: u8) {
        while (0x1::vector::length<address>(&arg1) > 0) {
            let v0 = 0x1::vector::pop_back<address>(&mut arg1);
            if (0x2::table::contains<address, WhitelistUser>(arg0, v0)) {
                if (0x2::table::borrow<address, WhitelistUser>(arg0, v0).type == arg2 && !0x2::table::borrow<address, WhitelistUser>(arg0, v0).minted) {
                    0x2::table::remove<address, WhitelistUser>(arg0, v0);
                };
            };
        };
    }

    public entry fun revoke_adept(arg0: &WhitelistControllerCap, arg1: &mut WhitelistRegistry, arg2: vector<address>) {
        let v0 = &mut arg1.whitelist;
        revoke(v0, arg2, 1);
    }

    public entry fun revoke_ancient(arg0: &WhitelistControllerCap, arg1: &mut WhitelistRegistry, arg2: vector<address>) {
        let v0 = &mut arg1.whitelist;
        revoke(v0, arg2, 2);
    }

    public entry fun revoke_master(arg0: &WhitelistControllerCap, arg1: &mut WhitelistRegistry, arg2: vector<address>) {
        let v0 = &mut arg1.whitelist;
        revoke(v0, arg2, 3);
    }

    public entry fun revoke_sprout(arg0: &WhitelistControllerCap, arg1: &mut WhitelistRegistry, arg2: vector<address>) {
        let v0 = &mut arg1.whitelist;
        revoke(v0, arg2, 0);
    }

    public entry fun set(arg0: &WhitelistControllerCap, arg1: &mut WhitelistRegistry, arg2: u64, arg3: u64, arg4: u64) {
        assert!(arg2 < arg3, 0);
        arg1.start_time = arg2;
        arg1.end_time = arg3;
        arg1.sprout_limit = arg4;
    }

    public entry fun whitelist_adept(arg0: &WhitelistControllerCap, arg1: &mut WhitelistRegistry, arg2: vector<address>) {
        let v0 = &mut arg1.whitelist;
        whitelist(v0, arg2, 1);
    }

    public entry fun whitelist_ancient(arg0: &WhitelistControllerCap, arg1: &mut WhitelistRegistry, arg2: vector<address>) {
        let v0 = &mut arg1.whitelist;
        whitelist(v0, arg2, 2);
    }

    public entry fun whitelist_master(arg0: &WhitelistControllerCap, arg1: &mut WhitelistRegistry, arg2: vector<address>) {
        let v0 = &mut arg1.whitelist;
        whitelist(v0, arg2, 3);
    }

    public entry fun whitelist_sprout(arg0: &WhitelistControllerCap, arg1: &mut WhitelistRegistry, arg2: vector<address>) {
        let v0 = &mut arg1.whitelist;
        whitelist(v0, arg2, 0);
    }

    // decompiled from Move bytecode v6
}

