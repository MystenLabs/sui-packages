module 0x2f73d65df28cdee5339d5d8327f68bde600048926771a88508c59dbe36eabf1e::a_degen_s_diary {
    struct A_DEGEN_S_DIARY has drop {
        dummy_field: bool,
    }

    struct Manager has store, key {
        id: 0x2::object::UID,
        version: u64,
        display: 0x2::display::Display<Nft>,
        transfer_policy_cap: 0x2::transfer_policy::TransferPolicyCap<Nft>,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        reserved_nft_ids: vector<0x2::object::ID>,
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
        collection_creator_wallet: address,
        manager_id: 0x2::object::ID,
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

    public entry fun add_nft_metadata(arg0: &0x2::package::Publisher, arg1: &mut 0x7112eaa13769bf331de6c8e42875021fb6ef72e4f5e52dd62f162cb06ef6f603::tradeport_launchpad::Store, arg2: 0x1::string::String, arg3: u64, arg4: u64, arg5: u64, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: vector<0x1::string::String>, arg10: vector<0x1::string::String>, arg11: vector<u8>, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::package::from_package<Nft>(arg0), 2);
        0x7112eaa13769bf331de6c8e42875021fb6ef72e4f5e52dd62f162cb06ef6f603::tradeport_launchpad::add_nft_metadata(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
        let v0 = AddNftMetadataEvent{
            group_id      : arg2,
            type          : arg3,
            index         : arg4,
            collection_id : 0x1::string::utf8(b"04a126af-f5e3-4e79-b596-8af0210fc303"),
        };
        0x2::event::emit<AddNftMetadataEvent>(v0);
    }

    fun assert_version(arg0: &Manager) {
        assert!(arg0.version == 1, 1);
    }

    fun assert_version_and_upgrade(arg0: &mut Manager) {
        if (arg0.version < 1) {
            arg0.version = 1;
        };
        assert_version(arg0);
    }

    public fun display_mut(arg0: &0x2::package::Publisher, arg1: &mut Manager) : &mut 0x2::display::Display<Nft> {
        assert!(0x2::package::from_package<Nft>(arg0), 2);
        &mut arg1.display
    }

    fun init(arg0: A_DEGEN_S_DIARY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<A_DEGEN_S_DIARY>(arg0, arg1);
        let v1 = 0x2::display::new<Nft>(&v0, arg1);
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"collection_name"), 0x1::string::utf8(x"4120446567656ee2809973204469617279"));
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"collection_description"), 0x1::string::utf8(x"536e617073686f74732066726f6d206120446567656ee2809973204469617279"));
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"collection_cover_url"), 0x1::string::utf8(b"ipfs://QmZeoDqsirHsiM3wGMrr5U7oDsjpJLWzD2F8FpzrBnQ7dj"));
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"group_id"), 0x1::string::utf8(b"{group_id}"));
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"media_url"), 0x1::string::utf8(b"{media_url}"));
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{media_url}"));
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
            reserved_nft_ids    : 0x1::vector::empty<0x2::object::ID>(),
        };
        let v7 = CreateCollectionEvent{
            publisher_id       : 0x2::object::id<0x2::package::Publisher>(&v0),
            manager_id         : 0x2::object::id<Manager>(&v6),
            transfer_policy_id : 0x2::object::id<0x2::transfer_policy::TransferPolicy<Nft>>(&v5),
            collection_id      : 0x1::string::utf8(b"04a126af-f5e3-4e79-b596-8af0210fc303"),
        };
        0x2::event::emit<CreateCollectionEvent>(v7);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<Nft>>(v5);
        0x2::transfer::public_share_object<Manager>(v6);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint_nft(arg0: &0x2::clock::Clock, arg1: &mut Manager, arg2: &mut 0x7112eaa13769bf331de6c8e42875021fb6ef72e4f5e52dd62f162cb06ef6f603::tradeport_launchpad::Store, arg3: 0x1::string::String, arg4: u64, arg5: 0x1::string::String, arg6: u64, arg7: 0x1::string::String, arg8: u64, arg9: u64, arg10: u64, arg11: vector<u8>, arg12: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg13: &mut 0x2::kiosk::Kiosk, arg14: &0x2::kiosk::KioskOwnerCap, arg15: &0x2::transfer_policy::TransferPolicy<Nft>, arg16: &mut 0x2::tx_context::TxContext) {
        assert_version_and_upgrade(arg1);
        let (v0, v1) = 0x7112eaa13769bf331de6c8e42875021fb6ef72e4f5e52dd62f162cb06ef6f603::tradeport_launchpad::get_nft_metadata(arg0, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg16);
        let v2 = v1;
        let v3 = to_nft(v0, arg16);
        let v4 = MintNftEvent{
            id                        : 0x2::object::id<Nft>(&v3),
            group_id                  : arg3,
            type                      : arg4,
            index                     : v3.index,
            order_id                  : arg5,
            stage_id                  : arg7,
            is_autoreserve            : false,
            price                     : arg9 + arg10,
            collection_id             : 0x1::string::utf8(b"04a126af-f5e3-4e79-b596-8af0210fc303"),
            collection_creator_wallet : @0x16e0a4cd88c51601f10df5599792dc20bee6cebaea4970fbc270579d39e711f8,
            manager_id                : 0x2::object::id<Manager>(arg1),
        };
        0x2::event::emit<MintNftEvent>(v4);
        0x2::kiosk::lock<Nft>(arg13, arg14, arg15, v3);
        if (0x1::option::is_some<0x2::bag::Bag>(&v2)) {
            let v5 = to_nft(0x1::option::destroy_some<0x2::bag::Bag>(v2), arg16);
            let v6 = MintNftEvent{
                id                        : 0x2::object::id<Nft>(&v5),
                group_id                  : arg3,
                type                      : arg4,
                index                     : v5.index,
                order_id                  : arg5,
                stage_id                  : arg7,
                is_autoreserve            : true,
                price                     : 0,
                collection_id             : 0x1::string::utf8(b"04a126af-f5e3-4e79-b596-8af0210fc303"),
                collection_creator_wallet : @0x16e0a4cd88c51601f10df5599792dc20bee6cebaea4970fbc270579d39e711f8,
                manager_id                : 0x2::object::id<Manager>(arg1),
            };
            0x2::event::emit<MintNftEvent>(v6);
            let v7 = 0x2::object::id<Nft>(&v5);
            0x2::dynamic_object_field::add<0x2::object::ID, Nft>(&mut arg1.id, v7, v5);
            0x1::vector::push_back<0x2::object::ID>(&mut arg1.reserved_nft_ids, v7);
        } else {
            0x1::option::destroy_none<0x2::bag::Bag>(v2);
        };
        0x2::coin::put<0x2::sui::SUI>(&mut arg1.balance, 0x2::coin::split<0x2::sui::SUI>(arg12, arg9, arg16));
    }

    public fun package_version() : u64 {
        1
    }

    public fun policy_cap(arg0: &0x2::package::Publisher, arg1: &Manager) : &0x2::transfer_policy::TransferPolicyCap<Nft> {
        assert!(0x2::package::from_package<Nft>(arg0), 2);
        &arg1.transfer_policy_cap
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

    public entry fun update_nft(arg0: &0x7112eaa13769bf331de6c8e42875021fb6ef72e4f5e52dd62f162cb06ef6f603::tradeport_launchpad::Store, arg1: vector<u8>, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: vector<0x1::string::String>, arg5: vector<0x1::string::String>, arg6: vector<u8>, arg7: &mut 0x2::kiosk::Kiosk, arg8: &0x2::kiosk::KioskOwnerCap, arg9: &mut 0x2::tx_context::TxContext) {
        0x7112eaa13769bf331de6c8e42875021fb6ef72e4f5e52dd62f162cb06ef6f603::tradeport_launchpad::verify_update_nft_request(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg9);
        let v0 = 0x2::kiosk::borrow_mut<Nft>(arg7, arg8, 0x2::object::id_from_bytes(arg1));
        v0.description = arg2;
        v0.media_url = arg3;
        v0.attributes = 0x7112eaa13769bf331de6c8e42875021fb6ef72e4f5e52dd62f162cb06ef6f603::tradeport_launchpad::format_attributes(arg4, arg5);
        let v1 = UpdateNftEvent{
            id            : 0x2::object::id<Nft>(v0),
            collection_id : 0x1::string::utf8(b"04a126af-f5e3-4e79-b596-8af0210fc303"),
        };
        0x2::event::emit<UpdateNftEvent>(v1);
    }

    public fun version(arg0: &Manager) : u64 {
        arg0.version
    }

    public entry fun withdraw_balance(arg0: &0x2::package::Publisher, arg1: &mut Manager, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::package::from_package<Nft>(arg0), 2);
        assert_version_and_upgrade(arg1);
        0x2::pay::keep<0x2::sui::SUI>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg1.balance), arg2), arg2);
    }

    public entry fun withdraw_reserved_nfts(arg0: &0x2::package::Publisher, arg1: &mut Manager, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: &0x2::transfer_policy::TransferPolicy<Nft>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::package::from_package<Nft>(arg0), 2);
        assert_version_and_upgrade(arg1);
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x2::object::ID>(&arg1.reserved_nft_ids)) {
            v0 = v0 + 1;
            0x2::kiosk::lock<Nft>(arg2, arg3, arg4, 0x2::dynamic_object_field::remove<0x2::object::ID, Nft>(&mut arg1.id, 0x1::vector::pop_back<0x2::object::ID>(&mut arg1.reserved_nft_ids)));
        };
    }

    public entry fun withdraw_royalties(arg0: &0x2::package::Publisher, arg1: &mut Manager, arg2: &mut 0x2::transfer_policy::TransferPolicy<Nft>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::package::from_package<Nft>(arg0), 2);
        assert_version_and_upgrade(arg1);
        0x2::pay::keep<0x2::sui::SUI>(0x2::transfer_policy::withdraw<Nft>(arg2, &arg1.transfer_policy_cap, 0x1::option::none<u64>(), arg3), arg3);
    }

    // decompiled from Move bytecode v6
}

