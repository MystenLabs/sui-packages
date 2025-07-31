module 0xdf87ec097d3791bf30f3cb529816963122a924ab008659458ee6d693ea51e4b8::zen_nft {
    struct ZEN_NFT has drop {
        dummy_field: bool,
    }

    struct KioskRegistry has store, key {
        id: 0x2::object::UID,
        nft_kiosks: 0x2::table::Table<0x2::object::ID, 0x2::object::ID>,
        kiosk_caps: 0x2::table::Table<0x2::object::ID, 0x2::object::ID>,
        caps: 0x2::object_bag::ObjectBag,
    }

    struct NFTMinted has copy, drop {
        nft_id: 0x2::object::ID,
        nft_number: u16,
        kiosk_id: 0x2::object::ID,
        creator: address,
    }

    struct NFTRevealed has copy, drop {
        nft_id: 0x2::object::ID,
        nft_number: u16,
        creator: address,
    }

    public entry fun admin_release_nft(arg0: &mut KioskRegistry, arg1: &0xdf87ec097d3791bf30f3cb529816963122a924ab008659458ee6d693ea51e4b8::options::OptionsStorage, arg2: &mut 0x2::kiosk::Kiosk, arg3: 0x2::object::ID, arg4: address, arg5: &0x2::transfer_policy::TransferPolicy<0xdf87ec097d3791bf30f3cb529816963122a924ab008659458ee6d693ea51e4b8::storage::ZenFrogs>, arg6: &mut 0x2::tx_context::TxContext) {
        0xdf87ec097d3791bf30f3cb529816963122a924ab008659458ee6d693ea51e4b8::options::assert_is_admin(arg1, arg6);
        let v0 = 0x2::object_bag::remove<0x2::object::ID, 0x2::kiosk::KioskOwnerCap>(&mut arg0.caps, *0x2::table::borrow<0x2::object::ID, 0x2::object::ID>(&arg0.kiosk_caps, 0x2::object::id<0x2::kiosk::Kiosk>(arg2)));
        let v1 = 0x2::kiosk::take<0xdf87ec097d3791bf30f3cb529816963122a924ab008659458ee6d693ea51e4b8::storage::ZenFrogs>(arg2, &v0, arg3);
        assert!(0xdf87ec097d3791bf30f3cb529816963122a924ab008659458ee6d693ea51e4b8::storage::is_revealed(&v1) == true, 4);
        0x2::kiosk::lock<0xdf87ec097d3791bf30f3cb529816963122a924ab008659458ee6d693ea51e4b8::storage::ZenFrogs>(arg2, &v0, arg5, v1);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v0, arg4);
    }

    public entry fun admin_reveal(arg0: &mut KioskRegistry, arg1: &0xdf87ec097d3791bf30f3cb529816963122a924ab008659458ee6d693ea51e4b8::options::OptionsStorage, arg2: &mut 0x2::kiosk::Kiosk, arg3: 0x2::object::ID, arg4: address, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: vector<u8>, arg9: vector<u8>, arg10: &mut 0x2::tx_context::TxContext) {
        0xdf87ec097d3791bf30f3cb529816963122a924ab008659458ee6d693ea51e4b8::options::assert_is_admin(arg1, arg10);
        let v0 = 0x2::kiosk::borrow_mut<0xdf87ec097d3791bf30f3cb529816963122a924ab008659458ee6d693ea51e4b8::storage::ZenFrogs>(arg2, 0x2::object_bag::borrow<0x2::object::ID, 0x2::kiosk::KioskOwnerCap>(&arg0.caps, *0x2::table::borrow<0x2::object::ID, 0x2::object::ID>(&arg0.kiosk_caps, 0x2::object::id<0x2::kiosk::Kiosk>(arg2))), arg3);
        0xdf87ec097d3791bf30f3cb529816963122a924ab008659458ee6d693ea51e4b8::storage::set_nft_data(v0, arg5, arg6, arg7, arg8, arg9);
        let v1 = NFTRevealed{
            nft_id     : 0xdf87ec097d3791bf30f3cb529816963122a924ab008659458ee6d693ea51e4b8::storage::id(v0),
            nft_number : 0xdf87ec097d3791bf30f3cb529816963122a924ab008659458ee6d693ea51e4b8::storage::number(v0),
            creator    : arg4,
        };
        0x2::event::emit<NFTRevealed>(v1);
    }

    public(friend) fun create_kiosk_registry(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = KioskRegistry{
            id         : 0x2::object::new(arg0),
            nft_kiosks : 0x2::table::new<0x2::object::ID, 0x2::object::ID>(arg0),
            kiosk_caps : 0x2::table::new<0x2::object::ID, 0x2::object::ID>(arg0),
            caps       : 0x2::object_bag::new(arg0),
        };
        0x2::transfer::public_share_object<KioskRegistry>(v0);
    }

    public fun get_nft_kiosk(arg0: &KioskRegistry, arg1: 0x2::object::ID) : 0x2::object::ID {
        *0x2::table::borrow<0x2::object::ID, 0x2::object::ID>(&arg0.nft_kiosks, arg1)
    }

    fun init(arg0: ZEN_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        create_kiosk_registry(arg1);
        0xdf87ec097d3791bf30f3cb529816963122a924ab008659458ee6d693ea51e4b8::storage::create_nft_storage(arg1);
        0xdf87ec097d3791bf30f3cb529816963122a924ab008659458ee6d693ea51e4b8::options::create_options_storage(arg1);
        0xdf87ec097d3791bf30f3cb529816963122a924ab008659458ee6d693ea51e4b8::profiles::create_profile_storage(arg1);
        let v0 = 0x2::package::claim<ZEN_NFT>(arg0, arg1);
        let v1 = 0x2::tx_context::sender(arg1);
        let v2 = 0x2::display::new<0xdf87ec097d3791bf30f3cb529816963122a924ab008659458ee6d693ea51e4b8::storage::ZenFrogs>(&v0, arg1);
        0x2::display::add<0xdf87ec097d3791bf30f3cb529816963122a924ab008659458ee6d693ea51e4b8::storage::ZenFrogs>(&mut v2, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"ZenFrogs #{nft_number}"));
        0x2::display::add<0xdf87ec097d3791bf30f3cb529816963122a924ab008659458ee6d693ea51e4b8::storage::ZenFrogs>(&mut v2, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<0xdf87ec097d3791bf30f3cb529816963122a924ab008659458ee6d693ea51e4b8::storage::ZenFrogs>(&mut v2, 0x1::string::utf8(b"link"), 0x1::string::utf8(b"https://zenfrogs.com/nft/{id}"));
        0x2::display::add<0xdf87ec097d3791bf30f3cb529816963122a924ab008659458ee6d693ea51e4b8::storage::ZenFrogs>(&mut v2, 0x1::string::utf8(b"hash"), 0x1::string::utf8(b"{hash}"));
        0x2::display::add<0xdf87ec097d3791bf30f3cb529816963122a924ab008659458ee6d693ea51e4b8::storage::ZenFrogs>(&mut v2, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::add<0xdf87ec097d3791bf30f3cb529816963122a924ab008659458ee6d693ea51e4b8::storage::ZenFrogs>(&mut v2, 0x1::string::utf8(b"url"), 0x1::string::utf8(b"{url}"));
        0x2::display::add<0xdf87ec097d3791bf30f3cb529816963122a924ab008659458ee6d693ea51e4b8::storage::ZenFrogs>(&mut v2, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://zenfrogs.com/"));
        0x2::display::add<0xdf87ec097d3791bf30f3cb529816963122a924ab008659458ee6d693ea51e4b8::storage::ZenFrogs>(&mut v2, 0x1::string::utf8(b"creator"), 0x1::string::utf8(b"{creator}"));
        0x2::display::update_version<0xdf87ec097d3791bf30f3cb529816963122a924ab008659458ee6d693ea51e4b8::storage::ZenFrogs>(&mut v2);
        let (v3, v4) = 0x2::transfer_policy::new<0xdf87ec097d3791bf30f3cb529816963122a924ab008659458ee6d693ea51e4b8::storage::ZenFrogs>(&v0, arg1);
        let v5 = v4;
        let v6 = v3;
        0xdf87ec097d3791bf30f3cb529816963122a924ab008659458ee6d693ea51e4b8::royalty::setup<0xdf87ec097d3791bf30f3cb529816963122a924ab008659458ee6d693ea51e4b8::storage::ZenFrogs>(&mut v6, &v5);
        0x2::transfer::public_transfer<0x2::display::Display<0xdf87ec097d3791bf30f3cb529816963122a924ab008659458ee6d693ea51e4b8::storage::ZenFrogs>>(v2, v1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, v1);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<0xdf87ec097d3791bf30f3cb529816963122a924ab008659458ee6d693ea51e4b8::storage::ZenFrogs>>(v5, v1);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<0xdf87ec097d3791bf30f3cb529816963122a924ab008659458ee6d693ea51e4b8::storage::ZenFrogs>>(v6);
    }

    public(friend) fun is_sui_coin<T0>() : bool {
        0x1::type_name::into_string(0x1::type_name::get<T0>()) == 0x1::ascii::string(b"0000000000000000000000000000000000000000000000000000000000000002::sui::SUI")
    }

    public fun mint<T0: drop, T1: drop>(arg0: &mut 0xdf87ec097d3791bf30f3cb529816963122a924ab008659458ee6d693ea51e4b8::storage::NFTStorage, arg1: &mut KioskRegistry, arg2: &0xdf87ec097d3791bf30f3cb529816963122a924ab008659458ee6d693ea51e4b8::options::OptionsStorage, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let (v1, v2, v3, v4, v5, v6, v7) = 0xdf87ec097d3791bf30f3cb529816963122a924ab008659458ee6d693ea51e4b8::options::get_mint_options(arg2);
        assert!(v6 == true, 1);
        if (is_sui_coin<T0>()) {
            assert!(0x2::coin::value<T0>(&arg3) >= v2, 3);
        } else {
            0xdf87ec097d3791bf30f3cb529816963122a924ab008659458ee6d693ea51e4b8::options::assert_is_zen_coin<T0>();
            assert!(0x2::coin::value<T0>(&arg3) >= v3, 3);
        };
        0xdf87ec097d3791bf30f3cb529816963122a924ab008659458ee6d693ea51e4b8::options::assert_is_zen_coin<T1>();
        if (v7) {
            0xdf87ec097d3791bf30f3cb529816963122a924ab008659458ee6d693ea51e4b8::options::assert_is_airdrop_eligible(v0, arg2);
        };
        let v8 = 0xdf87ec097d3791bf30f3cb529816963122a924ab008659458ee6d693ea51e4b8::storage::create_nft<T1>(arg0, arg4);
        if (v5) {
            assert!(0xdf87ec097d3791bf30f3cb529816963122a924ab008659458ee6d693ea51e4b8::storage::track_mint_owned_count(arg0, v0, 0xdf87ec097d3791bf30f3cb529816963122a924ab008659458ee6d693ea51e4b8::storage::id(&v8)) <= v4, 2);
        };
        let (v9, v10) = 0x2::kiosk::new(arg4);
        let v11 = v10;
        let v12 = v9;
        let v13 = 0x2::object::id<0x2::kiosk::Kiosk>(&v12);
        let v14 = 0x2::object::id<0x2::kiosk::KioskOwnerCap>(&v11);
        0x2::table::add<0x2::object::ID, 0x2::object::ID>(&mut arg1.nft_kiosks, 0xdf87ec097d3791bf30f3cb529816963122a924ab008659458ee6d693ea51e4b8::storage::id(&v8), v13);
        0x2::table::add<0x2::object::ID, 0x2::object::ID>(&mut arg1.kiosk_caps, v13, v14);
        let v15 = NFTMinted{
            nft_id     : 0xdf87ec097d3791bf30f3cb529816963122a924ab008659458ee6d693ea51e4b8::storage::id(&v8),
            nft_number : 0xdf87ec097d3791bf30f3cb529816963122a924ab008659458ee6d693ea51e4b8::storage::number(&v8),
            kiosk_id   : v13,
            creator    : v0,
        };
        0x2::event::emit<NFTMinted>(v15);
        0x2::kiosk::place<0xdf87ec097d3791bf30f3cb529816963122a924ab008659458ee6d693ea51e4b8::storage::ZenFrogs>(&mut v12, &v11, v8);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v12);
        0x2::object_bag::add<0x2::object::ID, 0x2::kiosk::KioskOwnerCap>(&mut arg1.caps, v14, v11);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg3, v1);
    }

    // decompiled from Move bytecode v6
}

