module 0x4a130387250b613d3c0d379070eee36a80e7d9bf720ab94ffa72089fa78b36a4::whitelist {
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

    struct WispCard has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        creator: address,
        rare: u8,
        image_url: 0x1::string::String,
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

    public fun borrow_whitelist(arg0: &WhitelistRegistry) : &0x2::table::Table<address, WhitelistUser> {
        &arg0.whitelist
    }

    fun check_mint_time(arg0: &WhitelistRegistry, arg1: &0x2::clock::Clock) {
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.start_time && 0x2::clock::timestamp_ms(arg1) <= arg0.end_time, 0);
    }

    fun create_image_url(arg0: vector<u8>) : 0x1::string::String {
        let v0 = b"https://www.wispswap.io/";
        0x1::vector::append<u8>(&mut v0, arg0);
        0x1::string::utf8(v0)
    }

    public fun get_card_info(arg0: &WispCard) : (0x1::string::String, address, u8, 0x1::string::String) {
        (arg0.name, arg0.creator, arg0.rare, arg0.image_url)
    }

    public fun get_whitelist_data(arg0: &WhitelistUser) : (u8, bool) {
        (arg0.type, arg0.minted)
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
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://www.wispswap.io/"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"A tribute to those who reached the {name} role on Wisp"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{creator}"));
        let v5 = 0x2::display::new_with_fields<WispCard>(&v0, v1, v3, arg1);
        0x2::display::update_version<WispCard>(&mut v5);
        0x2::transfer::public_transfer<0x2::display::Display<WispCard>>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        let v6 = WhitelistControllerCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<WhitelistControllerCap>(v6, 0x2::tx_context::sender(arg1));
        let v7 = WhitelistRegistry{
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
        0x2::transfer::share_object<WhitelistRegistry>(v7);
    }

    public fun is_adept_card(arg0: &WispCard) : bool {
        arg0.rare == 2
    }

    public fun is_adept_whitelist(arg0: &WhitelistUser) : bool {
        arg0.type == 2
    }

    public fun is_ancient_card(arg0: &WispCard) : bool {
        arg0.rare == 4
    }

    public fun is_ancient_whitelist(arg0: &WhitelistUser) : bool {
        arg0.type == 4
    }

    public fun is_master_card(arg0: &WispCard) : bool {
        arg0.rare == 3
    }

    public fun is_master_whitelist(arg0: &WhitelistUser) : bool {
        arg0.type == 3
    }

    public fun is_sprout_card(arg0: &WispCard) : bool {
        arg0.rare == 1
    }

    public fun is_sprout_whitelist(arg0: &WhitelistUser) : bool {
        arg0.type == 1
    }

    fun mint(arg0: &mut 0x2::table::Table<address, WhitelistUser>, arg1: address, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u8, arg5: &mut 0x2::tx_context::TxContext) : WispCard {
        assert!(0x2::table::contains<address, WhitelistUser>(arg0, arg1), 1);
        assert!(0x2::table::borrow<address, WhitelistUser>(arg0, arg1).type == arg4, 5);
        assert!(!0x2::table::borrow<address, WhitelistUser>(arg0, arg1).minted, 2);
        0x2::table::borrow_mut<address, WhitelistUser>(arg0, arg1).minted = true;
        let v0 = 0x2::object::new(arg5);
        let v1 = Minted{
            nft_id : 0x2::object::uid_to_inner(&v0),
            user   : arg1,
            type   : arg4,
        };
        0x2::event::emit<Minted>(v1);
        WispCard{
            id        : v0,
            name      : arg2,
            creator   : arg1,
            rare      : arg4,
            image_url : arg3,
        }
    }

    public entry fun mint_adept(arg0: &mut WhitelistRegistry, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        check_mint_time(arg0, arg1);
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = &mut arg0.whitelist;
        arg0.adepts_minted = arg0.adepts_minted + 1;
        0x2::transfer::transfer<WispCard>(mint(v1, v0, 0x1::string::utf8(b"Adept Wisp!"), create_image_url(b"Adept-Wisp.png"), 2, arg2), v0);
    }

    public entry fun mint_ancient(arg0: &mut WhitelistRegistry, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        check_mint_time(arg0, arg1);
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = &mut arg0.whitelist;
        arg0.ancients_minted = arg0.ancients_minted + 1;
        0x2::transfer::transfer<WispCard>(mint(v1, v0, 0x1::string::utf8(b"Ancient Wisp!"), create_image_url(b"Ancient-Wisp.png"), 4, arg2), v0);
    }

    public entry fun mint_master(arg0: &mut WhitelistRegistry, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        check_mint_time(arg0, arg1);
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = &mut arg0.whitelist;
        arg0.masters_minted = arg0.masters_minted + 1;
        0x2::transfer::transfer<WispCard>(mint(v1, v0, 0x1::string::utf8(b"Master Wisp!"), create_image_url(b"Master-Wisp.png"), 3, arg2), v0);
    }

    public entry fun mint_sprout(arg0: &mut WhitelistRegistry, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        check_mint_time(arg0, arg1);
        assert!(arg0.sprout_minted < arg0.sprout_limit, 3);
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = &mut arg0.whitelist;
        arg0.sprout_minted = arg0.sprout_minted + 1;
        0x2::transfer::transfer<WispCard>(mint(v1, v0, 0x1::string::utf8(b"Sprout Wisp!"), create_image_url(b"Sprout-Wisp.png"), 1, arg2), v0);
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
        revoke(v0, arg2, 2);
    }

    public entry fun revoke_ancient(arg0: &WhitelistControllerCap, arg1: &mut WhitelistRegistry, arg2: vector<address>) {
        let v0 = &mut arg1.whitelist;
        revoke(v0, arg2, 4);
    }

    public entry fun revoke_master(arg0: &WhitelistControllerCap, arg1: &mut WhitelistRegistry, arg2: vector<address>) {
        let v0 = &mut arg1.whitelist;
        revoke(v0, arg2, 3);
    }

    public entry fun revoke_sprout(arg0: &WhitelistControllerCap, arg1: &mut WhitelistRegistry, arg2: vector<address>) {
        let v0 = &mut arg1.whitelist;
        revoke(v0, arg2, 1);
    }

    public entry fun set(arg0: &WhitelistControllerCap, arg1: &mut WhitelistRegistry, arg2: u64, arg3: u64, arg4: u64) {
        assert!(arg2 < arg3, 0);
        arg1.start_time = arg2;
        arg1.end_time = arg3;
        arg1.sprout_limit = arg4;
    }

    public entry fun whitelist_adept(arg0: &WhitelistControllerCap, arg1: &mut WhitelistRegistry, arg2: vector<address>) {
        let v0 = &mut arg1.whitelist;
        whitelist(v0, arg2, 2);
    }

    public entry fun whitelist_ancient(arg0: &WhitelistControllerCap, arg1: &mut WhitelistRegistry, arg2: vector<address>) {
        let v0 = &mut arg1.whitelist;
        whitelist(v0, arg2, 4);
    }

    public entry fun whitelist_master(arg0: &WhitelistControllerCap, arg1: &mut WhitelistRegistry, arg2: vector<address>) {
        let v0 = &mut arg1.whitelist;
        whitelist(v0, arg2, 3);
    }

    public entry fun whitelist_sprout(arg0: &WhitelistControllerCap, arg1: &mut WhitelistRegistry, arg2: vector<address>) {
        let v0 = &mut arg1.whitelist;
        whitelist(v0, arg2, 1);
    }

    // decompiled from Move bytecode v6
}

