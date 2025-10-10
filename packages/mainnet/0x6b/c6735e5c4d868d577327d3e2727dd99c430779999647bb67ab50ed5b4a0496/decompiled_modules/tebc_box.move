module 0x6bc6735e5c4d868d577327d3e2727dd99c430779999647bb67ab50ed5b4a0496::tebc_box {
    struct TEBC_BOX has drop {
        dummy_field: bool,
    }

    struct Box has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        img_url: 0x2::url::Url,
        is_opened: bool,
    }

    struct BoxManager has store, key {
        id: 0x2::object::UID,
        owner: address,
        admin: 0x2::object::ID,
        counter: u64,
        max_supply: u64,
        version: u64,
        paused: bool,
        whitelist: vector<address>,
    }

    struct BoxMinted has copy, drop {
        id: 0x2::object::ID,
        owner: address,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    entry fun add_to_whitelist(arg0: &mut BoxManager, arg1: &AdminCap, arg2: address) {
        only_admin(arg0, arg1);
        assert!(!is_whitelisted(arg0, arg2), 0);
        assert!(arg0.version == 3, 5);
        0x1::vector::push_back<address>(&mut arg0.whitelist, arg2);
    }

    public fun get_mint_price(arg0: &BoxManager, arg1: address) : u64 {
        if (is_whitelisted(arg0, arg1)) {
            500000000
        } else {
            1000000000
        }
    }

    fun init(arg0: TEBC_BOX, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        let v1 = BoxManager{
            id         : 0x2::object::new(arg1),
            owner      : 0x2::tx_context::sender(arg1),
            admin      : 0x2::object::id<AdminCap>(&v0),
            counter    : 0,
            max_supply : 12000,
            version    : 3,
            paused     : false,
            whitelist  : 0x1::vector::empty<address>(),
        };
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"img_url"));
        let v4 = 0x1::vector::empty<0x1::string::String>();
        let v5 = &mut v4;
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{img_url}"));
        let v6 = 0x2::package::claim<TEBC_BOX>(arg0, arg1);
        let v7 = 0x2::display::new_with_fields<Box>(&v6, v2, v4, arg1);
        0x2::display::update_version<Box>(&mut v7);
        0x2::transfer::share_object<BoxManager>(v1);
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v6, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Box>>(v7, 0x2::tx_context::sender(arg1));
    }

    fun is_whitelisted(arg0: &BoxManager, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.whitelist, &arg1)
    }

    entry fun migrate(arg0: &mut BoxManager, arg1: &AdminCap) {
        only_admin(arg0, arg1);
        assert!(arg0.version < 3, 4);
        arg0.version = 3;
    }

    public fun mint_box(arg0: &mut BoxManager, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = if (is_whitelisted(arg0, 0x2::tx_context::sender(arg2))) {
            500000000
        } else {
            1000000000
        };
        assert!(arg0.paused == false, 6);
        assert!(arg0.version == 3, 5);
        assert!(arg0.counter + 1 <= arg0.max_supply, 2);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= v0, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, arg0.owner);
        arg0.counter = arg0.counter + 1;
        let v1 = Box{
            id          : 0x2::object::new(arg2),
            name        : 0x1::string::utf8(b"TEBC BOX"),
            description : 0x1::string::utf8(b"TEBC Just test"),
            img_url     : 0x2::url::new_unsafe_from_bytes(b"https://aggregator.walrus-testnet.walrus.space/v1/blobs/Tq5jAY9Sc7CQC8mTuuENQmWpgMuCp4iMQaWhZsJQ5lw"),
            is_opened   : false,
        };
        let v2 = BoxMinted{
            id    : 0x2::object::uid_to_inner(&v1.id),
            owner : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<BoxMinted>(v2);
        0x2::transfer::transfer<Box>(v1, 0x2::tx_context::sender(arg2));
    }

    fun only_admin(arg0: &BoxManager, arg1: &AdminCap) {
        assert!(arg0.admin == 0x2::object::id<AdminCap>(arg1), 3);
    }

    entry fun pause_minting(arg0: &mut BoxManager, arg1: &AdminCap) {
        only_admin(arg0, arg1);
        arg0.paused = true;
    }

    entry fun remove_from_whitelist(arg0: &mut BoxManager, arg1: &AdminCap, arg2: address) {
        only_admin(arg0, arg1);
        assert!(arg0.version == 3, 5);
        let (v0, v1) = 0x1::vector::index_of<address>(&arg0.whitelist, &arg2);
        if (v0) {
            0x1::vector::remove<address>(&mut arg0.whitelist, v1);
        };
    }

    entry fun unpause_minting(arg0: &mut BoxManager, arg1: &AdminCap) {
        only_admin(arg0, arg1);
        arg0.paused = false;
    }

    // decompiled from Move bytecode v6
}

