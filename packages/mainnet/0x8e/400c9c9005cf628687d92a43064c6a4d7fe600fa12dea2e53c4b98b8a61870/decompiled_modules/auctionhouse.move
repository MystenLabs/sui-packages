module 0x8e400c9c9005cf628687d92a43064c6a4d7fe600fa12dea2e53c4b98b8a61870::auctionhouse {
    struct AUCTIONHOUSE has drop {
        dummy_field: bool,
    }

    struct AuctionHouse has key {
        id: 0x2::object::UID,
        fee_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        owner: address,
        admins: vector<address>,
        name: vector<u8>,
        description: vector<u8>,
        app_link: vector<u8>,
    }

    struct FeesWithdrawn has copy, drop {
        amount: u64,
        recipient: address,
    }

    struct AdminAdded has copy, drop {
        admin: address,
    }

    struct AdminRemoved has copy, drop {
        admin: address,
    }

    struct AuctionHouseCreated has copy, drop {
        owner: address,
        name: vector<u8>,
        description: vector<u8>,
        app_link: vector<u8>,
    }

    public entry fun add_admin(arg0: &mut AuctionHouse, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 1);
        let (v0, _) = 0x1::vector::index_of<address>(&arg0.admins, &arg1);
        if (!v0) {
            0x1::vector::push_back<address>(&mut arg0.admins, arg1);
            let v2 = AdminAdded{admin: arg1};
            0x2::event::emit<AdminAdded>(v2);
        };
    }

    public fun add_fee(arg0: &mut AuctionHouse, arg1: 0x2::balance::Balance<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.fee_balance, arg1);
    }

    public fun get_app_link(arg0: &AuctionHouse) : vector<u8> {
        arg0.app_link
    }

    public fun get_description(arg0: &AuctionHouse) : vector<u8> {
        arg0.description
    }

    public fun get_name(arg0: &AuctionHouse) : vector<u8> {
        arg0.name
    }

    public fun get_owner(arg0: &AuctionHouse) : address {
        arg0.owner
    }

    fun init(arg0: AUCTIONHOUSE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v1, v0);
        let v2 = b"Portal House";
        let v3 = b"A digital assets";
        let v4 = b"https://app.portal.example.com";
        let v5 = AuctionHouse{
            id          : 0x2::object::new(arg1),
            fee_balance : 0x2::balance::zero<0x2::sui::SUI>(),
            owner       : v0,
            admins      : v1,
            name        : v2,
            description : v3,
            app_link    : v4,
        };
        let v6 = AuctionHouseCreated{
            owner       : v0,
            name        : v2,
            description : v3,
            app_link    : v4,
        };
        0x2::event::emit<AuctionHouseCreated>(v6);
        let v7 = 0x2::package::claim<AUCTIONHOUSE>(arg0, arg1);
        let v8 = 0x1::vector::empty<0x1::string::String>();
        let v9 = &mut v8;
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"owner"));
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"app_link"));
        let v10 = 0x1::vector::empty<0x1::string::String>();
        let v11 = &mut v10;
        0x1::vector::push_back<0x1::string::String>(v11, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v11, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v11, 0x1::string::utf8(b"{owner}"));
        0x1::vector::push_back<0x1::string::String>(v11, 0x1::string::utf8(b"https://c4.wallpaperflare.com/wallpaper/698/492/43/world-of-warcraft-world-of-warcraft-the-war-within-hd-wallpaper-preview.jpg"));
        0x1::vector::push_back<0x1::string::String>(v11, 0x1::string::utf8(b"https://portal.example.com"));
        0x1::vector::push_back<0x1::string::String>(v11, 0x1::string::utf8(b"{app_link}"));
        let v12 = 0x2::display::new_with_fields<AuctionHouse>(&v7, v8, v10, arg1);
        0x2::display::update_version<AuctionHouse>(&mut v12);
        0x2::transfer::public_transfer<0x2::display::Display<AuctionHouse>>(v12, v0);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v7, v0);
        0x2::transfer::share_object<AuctionHouse>(v5);
    }

    public fun is_admin(arg0: &AuctionHouse, arg1: address) : bool {
        let (v0, _) = 0x1::vector::index_of<address>(&arg0.admins, &arg1);
        v0
    }

    public entry fun remove_admin(arg0: &mut AuctionHouse, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 1);
        let (v0, v1) = 0x1::vector::index_of<address>(&arg0.admins, &arg1);
        if (v0) {
            0x1::vector::remove<address>(&mut arg0.admins, v1);
            let v2 = AdminRemoved{admin: arg1};
            0x2::event::emit<AdminRemoved>(v2);
        };
    }

    public entry fun update_metadata(arg0: &mut AuctionHouse, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.owner, 1);
        arg0.name = arg1;
        arg0.description = arg2;
        arg0.app_link = arg3;
    }

    public entry fun update_owner(arg0: &mut AuctionHouse, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 1);
        arg0.owner = arg1;
    }

    public entry fun withdraw_fees(arg0: &mut AuctionHouse, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 1);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.fee_balance);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.fee_balance, v0), arg1), arg0.owner);
        let v1 = FeesWithdrawn{
            amount    : v0,
            recipient : arg0.owner,
        };
        0x2::event::emit<FeesWithdrawn>(v1);
    }

    // decompiled from Move bytecode v6
}

