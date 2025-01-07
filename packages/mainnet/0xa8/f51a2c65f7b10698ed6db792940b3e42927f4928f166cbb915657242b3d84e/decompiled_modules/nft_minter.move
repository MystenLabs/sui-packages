module 0x89c23be637500077ae43cacaf11a7ce6def85e39a4391c3525c3ef770caf188f::nft_minter {
    struct NFTMetaData has drop, store {
        image_url: 0x1::string::String,
        description: 0x1::string::String,
        name: 0x1::string::String,
    }

    struct NFT has store, key {
        id: 0x2::object::UID,
        image_url: 0x1::string::String,
        description: 0x1::string::String,
        name: 0x1::string::String,
        special: bool,
    }

    struct NFT_MINTER has drop {
        dummy_field: bool,
    }

    struct InvitationCardList has key {
        id: 0x2::object::UID,
        token_id: u64,
        invitation_card_list: 0x2::table::Table<vector<u8>, NFTMetaData>,
        has_minted: 0x2::table::Table<address, bool>,
    }

    struct NFTEvent has copy, drop {
        object_id: 0x2::object::ID,
        owner: address,
    }

    public fun claim_special_nft(arg0: &mut InvitationCardList, arg1: vector<u8>, arg2: &0x89c23be637500077ae43cacaf11a7ce6def85e39a4391c3525c3ef770caf188f::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0x89c23be637500077ae43cacaf11a7ce6def85e39a4391c3525c3ef770caf188f::version::checkVersion(arg2, 2);
        let v0 = 0x1::hash::sha2_256(arg1);
        assert!(0x2::table::contains<vector<u8>, NFTMetaData>(&arg0.invitation_card_list, v0), 1);
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = 0x2::table::borrow_mut<vector<u8>, NFTMetaData>(&mut arg0.invitation_card_list, v0);
        arg0.token_id = arg0.token_id + 1;
        let v3 = NFT{
            id          : 0x2::object::new(arg3),
            image_url   : v2.image_url,
            description : v2.description,
            name        : v2.name,
            special     : true,
        };
        0x2::table::remove<vector<u8>, NFTMetaData>(&mut arg0.invitation_card_list, v0);
        let v4 = NFTEvent{
            object_id : 0x2::object::uid_to_inner(&v3.id),
            owner     : v1,
        };
        0x2::event::emit<NFTEvent>(v4);
        0x2::transfer::transfer<NFT>(v3, v1);
    }

    public(friend) fun create_invitation_list(arg0: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = InvitationCardList{
            id                   : 0x2::object::new(arg0),
            token_id             : 0,
            invitation_card_list : 0x2::table::new<vector<u8>, NFTMetaData>(arg0),
            has_minted           : 0x2::table::new<address, bool>(arg0),
        };
        0x2::transfer::share_object<InvitationCardList>(v0);
        0x2::object::uid_to_inner(&v0.id)
    }

    public(friend) fun create_special_nft(arg0: &mut InvitationCardList, arg1: vector<u8>, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String) {
        let v0 = NFTMetaData{
            image_url   : arg3,
            description : arg2,
            name        : arg4,
        };
        0x2::table::add<vector<u8>, NFTMetaData>(&mut arg0.invitation_card_list, arg1, v0);
    }

    fun init(arg0: NFT_MINTER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        let v4 = 0x2::package::claim<NFT_MINTER>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<NFT>(&v4, v0, v2, arg1);
        0x2::display::update_version<NFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<NFT>>(v5, 0x2::tx_context::sender(arg1));
    }

    public fun lucky_claim<T0: store + key>(arg0: vector<u8>, arg1: vector<vector<u8>>, arg2: vector<vector<u8>>, arg3: &NFT, arg4: &mut InvitationCardList, arg5: &mut 0x89c23be637500077ae43cacaf11a7ce6def85e39a4391c3525c3ef770caf188f::goodie_bag::GoodieBagList, arg6: &mut 0x89c23be637500077ae43cacaf11a7ce6def85e39a4391c3525c3ef770caf188f::bumper_prize::BumperPrizeList, arg7: &mut 0x89c23be637500077ae43cacaf11a7ce6def85e39a4391c3525c3ef770caf188f::event_bumper_prize::Event_BumperPrizeList, arg8: 0x89c23be637500077ae43cacaf11a7ce6def85e39a4391c3525c3ef770caf188f::goodie_bag::Participation_NFT, arg9: &mut 0x89c23be637500077ae43cacaf11a7ce6def85e39a4391c3525c3ef770caf188f::goodie_bag::PopList, arg10: u64, arg11: 0x2::object::ID, arg12: &0x89c23be637500077ae43cacaf11a7ce6def85e39a4391c3525c3ef770caf188f::version::Version, arg13: &mut 0x2::tx_context::TxContext) {
        0x89c23be637500077ae43cacaf11a7ce6def85e39a4391c3525c3ef770caf188f::version::checkVersion(arg12, 2);
        let v0 = 0x2::tx_context::sender(arg13);
        if (!arg3.special) {
            assert!(0x2::table::contains<address, bool>(&arg4.has_minted, v0), 3);
        };
        0x89c23be637500077ae43cacaf11a7ce6def85e39a4391c3525c3ef770caf188f::bumper_prize::set_wallet_address(arg6, v0);
        0x89c23be637500077ae43cacaf11a7ce6def85e39a4391c3525c3ef770caf188f::goodie_bag::claim_goodie_bag<T0>(arg0, arg1, arg2, arg5, arg8, arg9, arg10, arg11, arg13);
        0x89c23be637500077ae43cacaf11a7ce6def85e39a4391c3525c3ef770caf188f::event_bumper_prize::set_wallet_address_in_event_bumper(arg7, v0);
    }

    public(friend) fun mint_normal_nft(arg0: &mut InvitationCardList, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(!0x2::table::contains<address, bool>(&arg0.has_minted, v0), 2);
        arg0.token_id = arg0.token_id + 1;
        let v1 = NFT{
            id          : 0x2::object::new(arg4),
            image_url   : arg2,
            description : arg1,
            name        : arg3,
            special     : false,
        };
        0x2::table::add<address, bool>(&mut arg0.has_minted, v0, true);
        let v2 = NFTEvent{
            object_id : 0x2::object::uid_to_inner(&v1.id),
            owner     : v0,
        };
        0x2::event::emit<NFTEvent>(v2);
        0x2::transfer::transfer<NFT>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

