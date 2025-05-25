module 0x6659250df892ed40662f4b25c45c3ebb2ac84a1ad93b74f055e96ec92c4b05aa::auctionhouse {
    struct AUCTIONHOUSE has drop {
        dummy_field: bool,
    }

    struct AuctionHouse has key {
        id: 0x2::object::UID,
        fee_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        owner: address,
        admins: vector<address>,
        name: 0x1::string::String,
        description: 0x1::string::String,
        app_link: 0x1::string::String,
        current_display_id: 0x1::option::Option<0x2::object::ID>,
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
        name: 0x1::string::String,
        description: 0x1::string::String,
        app_link: 0x1::string::String,
    }

    struct DisplayUpdated has copy, drop {
        auction_house_id: 0x2::object::ID,
        updater: address,
    }

    struct DisplayDeprecated has copy, drop {
        old_display_id: 0x2::object::ID,
        new_display_id: 0x2::object::ID,
        updater: address,
    }

    struct OwnerUpdated has copy, drop {
        old_owner: address,
        new_owner: address,
    }

    public entry fun add_admin(arg0: &mut AuctionHouse, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 1);
        assert!(0x1::vector::length<address>(&arg0.admins) < 10, 5);
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

    fun create_and_update_display(arg0: &mut AuctionHouse, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &0x2::package::Publisher, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"owner"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"app_link"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, arg0.name);
        0x1::vector::push_back<0x1::string::String>(v3, arg0.description);
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{owner}"));
        0x1::vector::push_back<0x1::string::String>(v3, arg1);
        0x1::vector::push_back<0x1::string::String>(v3, arg2);
        0x1::vector::push_back<0x1::string::String>(v3, arg0.app_link);
        let v4 = 0x2::display::new_with_fields<AuctionHouse>(arg3, v0, v2, arg4);
        let v5 = 0x2::object::id<0x2::display::Display<AuctionHouse>>(&v4);
        0x2::display::update_version<AuctionHouse>(&mut v4);
        0x2::transfer::public_transfer<0x2::display::Display<AuctionHouse>>(v4, 0x2::tx_context::sender(arg4));
        if (0x1::option::is_some<0x2::object::ID>(&arg0.current_display_id)) {
            let v6 = DisplayDeprecated{
                old_display_id : 0x1::option::extract<0x2::object::ID>(&mut arg0.current_display_id),
                new_display_id : v5,
                updater        : 0x2::tx_context::sender(arg4),
            };
            0x2::event::emit<DisplayDeprecated>(v6);
        };
        0x1::option::fill<0x2::object::ID>(&mut arg0.current_display_id, v5);
        let v7 = DisplayUpdated{
            auction_house_id : 0x2::object::id<AuctionHouse>(arg0),
            updater          : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<DisplayUpdated>(v7);
    }

    public fun get_admins(arg0: &AuctionHouse) : vector<address> {
        arg0.admins
    }

    public fun get_app_link(arg0: &AuctionHouse) : 0x1::string::String {
        arg0.app_link
    }

    fun get_base_url() : 0x1::string::String {
        0x1::string::utf8(b"suiverse.space")
    }

    public fun get_current_display_id(arg0: &AuctionHouse) : 0x1::option::Option<0x2::object::ID> {
        arg0.current_display_id
    }

    fun get_default_image_url() : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"https://suiverse.space");
        0x1::string::append(&mut v0, 0x1::string::utf8(b"/assets/bg/portal.png"));
        v0
    }

    public fun get_description(arg0: &AuctionHouse) : 0x1::string::String {
        arg0.description
    }

    public fun get_fee_balance(arg0: &AuctionHouse) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.fee_balance)
    }

    fun get_https_base_url() : 0x1::string::String {
        0x1::string::utf8(b"https://suiverse.space")
    }

    public fun get_name(arg0: &AuctionHouse) : 0x1::string::String {
        arg0.name
    }

    public fun get_owner(arg0: &AuctionHouse) : address {
        arg0.owner
    }

    fun init(arg0: AUCTIONHOUSE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v1, v0);
        let v2 = 0x1::string::utf8(b"SUIVERSE Auction House");
        let v3 = 0x1::string::utf8(b"Your Web3 World, All In One Place!");
        let v4 = get_base_url();
        let v5 = AuctionHouse{
            id                 : 0x2::object::new(arg1),
            fee_balance        : 0x2::balance::zero<0x2::sui::SUI>(),
            owner              : v0,
            admins             : v1,
            name               : v2,
            description        : v3,
            app_link           : v4,
            current_display_id : 0x1::option::none<0x2::object::ID>(),
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
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"owner"));
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"app_link"));
        let v10 = 0x1::vector::empty<0x1::string::String>();
        let v11 = &mut v10;
        0x1::vector::push_back<0x1::string::String>(v11, v2);
        0x1::vector::push_back<0x1::string::String>(v11, v3);
        0x1::vector::push_back<0x1::string::String>(v11, get_https_base_url());
        0x1::vector::push_back<0x1::string::String>(v11, 0x1::string::utf8(b"{owner}"));
        0x1::vector::push_back<0x1::string::String>(v11, get_default_image_url());
        0x1::vector::push_back<0x1::string::String>(v11, get_https_base_url());
        0x1::vector::push_back<0x1::string::String>(v11, get_https_base_url());
        let v12 = 0x2::display::new_with_fields<AuctionHouse>(&v7, v8, v10, arg1);
        0x2::display::update_version<AuctionHouse>(&mut v12);
        0x2::transfer::public_transfer<0x2::display::Display<AuctionHouse>>(v12, v0);
        0x1::option::fill<0x2::object::ID>(&mut v5.current_display_id, 0x2::object::id<0x2::display::Display<AuctionHouse>>(&v12));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v7, v0);
        0x2::transfer::share_object<AuctionHouse>(v5);
    }

    public fun is_admin(arg0: &AuctionHouse, arg1: address) : bool {
        let (v0, _) = 0x1::vector::index_of<address>(&arg0.admins, &arg1);
        v0
    }

    public entry fun remove_admin(arg0: &mut AuctionHouse, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 1);
        assert!(arg1 != arg0.owner, 3);
        assert!(0x1::vector::length<address>(&arg0.admins) > 1, 2);
        let (v0, v1) = 0x1::vector::index_of<address>(&arg0.admins, &arg1);
        if (v0) {
            0x1::vector::remove<address>(&mut arg0.admins, v1);
            let v2 = AdminRemoved{admin: arg1};
            0x2::event::emit<AdminRemoved>(v2);
        };
    }

    public entry fun update_display(arg0: &mut AuctionHouse, arg1: &0x2::package::Publisher, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 1);
        create_and_update_display(arg0, get_default_image_url(), get_https_base_url(), arg1, arg2);
    }

    public entry fun update_metadata(arg0: &mut AuctionHouse, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: &0x2::package::Publisher, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg7) == arg0.owner, 1);
        assert!(0x1::string::length(&arg1) <= 100, 4);
        assert!(0x1::string::length(&arg2) <= 1000, 4);
        assert!(validate_url(&arg3), 4);
        assert!(validate_url(&arg4), 4);
        assert!(validate_url(&arg5), 4);
        arg0.name = arg1;
        arg0.description = arg2;
        arg0.app_link = arg3;
        create_and_update_display(arg0, arg4, arg5, arg6, arg7);
    }

    public entry fun update_owner(arg0: &mut AuctionHouse, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 1);
        arg0.owner = arg1;
        let (v0, _) = 0x1::vector::index_of<address>(&arg0.admins, &arg1);
        if (!v0) {
            0x1::vector::push_back<address>(&mut arg0.admins, arg1);
        };
        let v2 = OwnerUpdated{
            old_owner : arg0.owner,
            new_owner : arg1,
        };
        0x2::event::emit<OwnerUpdated>(v2);
    }

    fun validate_url(arg0: &0x1::string::String) : bool {
        let v0 = 0x1::string::bytes(arg0);
        let v1 = b"suiverse.space";
        if (0x1::vector::length<u8>(v0) < 0x1::vector::length<u8>(&v1)) {
            return false
        };
        let v2 = 0;
        let v3 = false;
        while (v2 <= 0x1::vector::length<u8>(v0) - 0x1::vector::length<u8>(&v1)) {
            let v4 = 0;
            let v5 = true;
            while (v4 < 0x1::vector::length<u8>(&v1)) {
                if (*0x1::vector::borrow<u8>(v0, v2 + v4) != *0x1::vector::borrow<u8>(&v1, v4)) {
                    v5 = false;
                    break
                };
                v4 = v4 + 1;
            };
            if (v5) {
                v3 = true;
                break
            };
            v2 = v2 + 1;
        };
        v3
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

