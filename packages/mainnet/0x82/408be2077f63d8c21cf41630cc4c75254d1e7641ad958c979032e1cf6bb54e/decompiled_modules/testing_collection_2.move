module 0x82408be2077f63d8c21cf41630cc4c75254d1e7641ad958c979032e1cf6bb54e::testing_collection_2 {
    struct TESTING_COLLECTION_2 has drop {
        dummy_field: bool,
    }

    struct Manager has store, key {
        id: 0x2::object::UID,
        version: u64,
        display: 0x2::display::Display<Nft>,
        transfer_policy_cap: 0x2::transfer_policy::TransferPolicyCap<Nft>,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        reserved_nfts: vector<Nft>,
    }

    struct Nft has store, key {
        id: 0x2::object::UID,
        group_id: 0x1::string::String,
        type: u64,
        name: 0x1::string::String,
        index: u64,
        description: 0x1::string::String,
        media_url: 0x1::string::String,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    struct MintNftEvent has copy, drop {
        id: 0x2::object::ID,
        group_id: 0x1::string::String,
        type: u64,
        index: u64,
        order_id: 0x1::string::String,
        stage_id: 0x1::string::String,
        is_autoreserve: bool,
        price: u64,
        collection_id: 0x1::string::String,
    }

    struct AddNftMetadataEvent has copy, drop {
        group_id: 0x1::string::String,
        type: u64,
        index: u64,
        collection_id: 0x1::string::String,
    }

    struct CreateCollectionEvent has copy, drop {
        publisher_id: 0x2::object::ID,
        manager_id: 0x2::object::ID,
        transfer_policy_id: 0x2::object::ID,
        collection_id: 0x1::string::String,
    }

    struct UpdateNftEvent has copy, drop {
        id: 0x2::object::ID,
        collection_id: 0x1::string::String,
    }

    public entry fun add_nft_metadata(arg0: &0x2::package::Publisher, arg1: &mut 0x2f8d60f4b08729c5cc9f4322eb18eca94e209ab8d72f4b398452118390f96fe7::tradeport_launchpad::Store, arg2: 0x1::string::String, arg3: u64, arg4: u64, arg5: u64, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: vector<0x1::string::String>, arg10: vector<0x1::string::String>, arg11: vector<u8>, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::package::from_package<Nft>(arg0), 2);
        0x2f8d60f4b08729c5cc9f4322eb18eca94e209ab8d72f4b398452118390f96fe7::tradeport_launchpad::add_nft_metadata(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
        let v0 = AddNftMetadataEvent{
            group_id      : arg2,
            type          : arg3,
            index         : arg4,
            collection_id : 0x1::string::utf8(b"d03deaf4-1bd9-4ff0-9ca1-d9c341ddaa20"),
        };
        0x2::event::emit<AddNftMetadataEvent>(v0);
    }

    fun init(arg0: TESTING_COLLECTION_2, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<TESTING_COLLECTION_2>(arg0, arg1);
        let v1 = 0x2::display::new<Nft>(&v0, arg1);
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"collection_name"), 0x1::string::utf8(b"Testing Collection 2"));
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"collection_description"), 0x1::string::utf8(b"asdf"));
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"collection_cover_url"), 0x1::string::utf8(b"https://byzantion.mypinata.cloud/ipfs/QmPneiS4iERX211E1aeNxSVxrM2KY9airK3cgVxHHCKK32"));
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"group_id"), 0x1::string::utf8(b"{group_id}"));
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"media_url"), 0x1::string::utf8(b"{media_url}"));
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"attributes"), 0x1::string::utf8(b"{attributes}"));
        0x2::display::update_version<Nft>(&mut v1);
        let (v2, v3) = 0x2::transfer_policy::new<Nft>(&v0, arg1);
        let v4 = v3;
        let v5 = v2;
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::add<Nft>(&mut v5, &v4);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::add<Nft>(&mut v5, &v4, 500, 0);
        let v6 = Manager{
            id                  : 0x2::object::new(arg1),
            version             : 0,
            display             : v1,
            transfer_policy_cap : v4,
            balance             : 0x2::balance::zero<0x2::sui::SUI>(),
            reserved_nfts       : 0x1::vector::empty<Nft>(),
        };
        let v7 = CreateCollectionEvent{
            publisher_id       : 0x2::object::id<0x2::package::Publisher>(&v0),
            manager_id         : 0x2::object::id<Manager>(&v6),
            transfer_policy_id : 0x2::object::id<0x2::transfer_policy::TransferPolicy<Nft>>(&v5),
            collection_id      : 0x1::string::utf8(b"d03deaf4-1bd9-4ff0-9ca1-d9c341ddaa20"),
        };
        0x2::event::emit<CreateCollectionEvent>(v7);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<Nft>>(v5);
        0x2::transfer::public_share_object<Manager>(v6);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint_nft(arg0: &0x2::clock::Clock, arg1: &mut Manager, arg2: &mut 0x2f8d60f4b08729c5cc9f4322eb18eca94e209ab8d72f4b398452118390f96fe7::tradeport_launchpad::Store, arg3: 0x1::string::String, arg4: u64, arg5: 0x1::string::String, arg6: u64, arg7: 0x1::string::String, arg8: u64, arg9: u64, arg10: u64, arg11: vector<u8>, arg12: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg13: &mut 0x2::kiosk::Kiosk, arg14: &0x2::kiosk::KioskOwnerCap, arg15: &0x2::transfer_policy::TransferPolicy<Nft>, arg16: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2f8d60f4b08729c5cc9f4322eb18eca94e209ab8d72f4b398452118390f96fe7::tradeport_launchpad::get_nft_metadata(arg0, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg16);
        let v2 = v1;
        let v3 = to_nft(v0, arg16);
        let v4 = MintNftEvent{
            id             : 0x2::object::id<Nft>(&v3),
            group_id       : arg3,
            type           : arg4,
            index          : v3.index,
            order_id       : arg5,
            stage_id       : arg7,
            is_autoreserve : false,
            price          : arg9 + arg10,
            collection_id  : 0x1::string::utf8(b"d03deaf4-1bd9-4ff0-9ca1-d9c341ddaa20"),
        };
        0x2::event::emit<MintNftEvent>(v4);
        0x2::kiosk::lock<Nft>(arg13, arg14, arg15, v3);
        if (0x1::option::is_some<0x2::bag::Bag>(&v2)) {
            let v5 = to_nft(0x1::option::destroy_some<0x2::bag::Bag>(v2), arg16);
            let v6 = MintNftEvent{
                id             : 0x2::object::id<Nft>(&v5),
                group_id       : arg3,
                type           : arg4,
                index          : v5.index,
                order_id       : arg5,
                stage_id       : arg7,
                is_autoreserve : true,
                price          : 0,
                collection_id  : 0x1::string::utf8(b"d03deaf4-1bd9-4ff0-9ca1-d9c341ddaa20"),
            };
            0x2::event::emit<MintNftEvent>(v6);
            0x1::vector::push_back<Nft>(&mut arg1.reserved_nfts, v5);
        } else {
            0x1::option::destroy_none<0x2::bag::Bag>(v2);
        };
        0x2::coin::put<0x2::sui::SUI>(&mut arg1.balance, 0x2::coin::split<0x2::sui::SUI>(arg12, arg9, arg16));
    }

    fun to_nft(arg0: 0x2::bag::Bag, arg1: &mut 0x2::tx_context::TxContext) : Nft {
        let v0 = Nft{
            id          : 0x2::object::new(arg1),
            group_id    : 0x2::bag::remove<0x1::string::String, 0x1::string::String>(&mut arg0, 0x1::string::utf8(b"group_id")),
            type        : 0x2::bag::remove<0x1::string::String, u64>(&mut arg0, 0x1::string::utf8(b"type")),
            name        : 0x2::bag::remove<0x1::string::String, 0x1::string::String>(&mut arg0, 0x1::string::utf8(b"name")),
            index       : 0x2::bag::remove<0x1::string::String, u64>(&mut arg0, 0x1::string::utf8(b"index")),
            description : 0x2::bag::remove<0x1::string::String, 0x1::string::String>(&mut arg0, 0x1::string::utf8(b"description")),
            media_url   : 0x2::bag::remove<0x1::string::String, 0x1::string::String>(&mut arg0, 0x1::string::utf8(b"media_url")),
            attributes  : 0x2::bag::remove<0x1::string::String, 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>(&mut arg0, 0x1::string::utf8(b"attributes")),
        };
        0x2::bag::destroy_empty(arg0);
        v0
    }

    public entry fun update_nft(arg0: &0x2f8d60f4b08729c5cc9f4322eb18eca94e209ab8d72f4b398452118390f96fe7::tradeport_launchpad::Store, arg1: vector<u8>, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: vector<0x1::string::String>, arg5: vector<0x1::string::String>, arg6: vector<u8>, arg7: &mut 0x2::kiosk::Kiosk, arg8: &0x2::kiosk::KioskOwnerCap, arg9: &mut 0x2::tx_context::TxContext) {
        0x2f8d60f4b08729c5cc9f4322eb18eca94e209ab8d72f4b398452118390f96fe7::tradeport_launchpad::verify_update_nft_request(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg9);
        let v0 = 0x2::kiosk::borrow_mut<Nft>(arg7, arg8, 0x2::object::id_from_bytes(arg1));
        v0.description = arg2;
        v0.media_url = arg3;
        v0.attributes = 0x2f8d60f4b08729c5cc9f4322eb18eca94e209ab8d72f4b398452118390f96fe7::tradeport_launchpad::format_attributes(arg4, arg5);
        let v1 = UpdateNftEvent{
            id            : 0x2::object::id<Nft>(v0),
            collection_id : 0x1::string::utf8(b"d03deaf4-1bd9-4ff0-9ca1-d9c341ddaa20"),
        };
        0x2::event::emit<UpdateNftEvent>(v1);
    }

    fun verify_version(arg0: &Manager) {
        assert!(arg0.version == 0, 1);
    }

    public entry fun withdraw_balance(arg0: &0x2::package::Publisher, arg1: &mut Manager, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::package::from_package<Nft>(arg0), 2);
        0x2::pay::keep<0x2::sui::SUI>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg1.balance), arg2), arg2);
    }

    public entry fun withdraw_reserved_nfts(arg0: &0x2::package::Publisher, arg1: &mut Manager, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: &0x2::transfer_policy::TransferPolicy<Nft>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::package::from_package<Nft>(arg0), 2);
        let v0 = 0;
        while (v0 < 0x1::vector::length<Nft>(&arg1.reserved_nfts)) {
            v0 = v0 + 1;
            0x2::kiosk::lock<Nft>(arg2, arg3, arg4, 0x1::vector::pop_back<Nft>(&mut arg1.reserved_nfts));
        };
    }

    // decompiled from Move bytecode v6
}

