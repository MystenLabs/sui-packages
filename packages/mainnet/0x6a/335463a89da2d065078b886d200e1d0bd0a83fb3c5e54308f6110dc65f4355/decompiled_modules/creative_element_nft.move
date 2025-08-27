module 0x1f246b075220ec5f49435224ca862fa60c254b9c544c8961764b1bfe77bf8728::creative_element_nft {
    struct CREATIVE_ELEMENT_NFT has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct ElementCollection has key {
        id: 0x2::object::UID,
        minted_count: u64,
        treasury: 0x2::balance::Balance<0x2::sui::SUI>,
        config: CollectionConfig,
    }

    struct CollectionConfig has store {
        creator_fee_bps: u16,
    }

    struct CreativeElementNFT has store, key {
        id: 0x2::object::UID,
        element_name: 0x1::string::String,
        amount: u64,
        emoji: 0x1::string::String,
        item_id: 0x1::string::String,
        creator: address,
        created_at: u64,
        image_url: 0x1::string::String,
    }

    struct CreativeElementMinted has copy, drop {
        nft_id: 0x2::object::ID,
        element_name: 0x1::string::String,
        amount: u64,
        creator: address,
    }

    public fun add_treasury_funds(arg0: &AdminCap, arg1: &mut ElementCollection, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.treasury, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(arg2, arg3, arg4)));
    }

    public fun burn(arg0: CreativeElementNFT, arg1: &mut 0x2::tx_context::TxContext) {
        let CreativeElementNFT {
            id           : v0,
            element_name : _,
            amount       : _,
            emoji        : _,
            item_id      : _,
            creator      : _,
            created_at   : _,
            image_url    : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun get_amount(arg0: &CreativeElementNFT) : u64 {
        arg0.amount
    }

    public fun get_collection_stats(arg0: &ElementCollection) : (u64, u64) {
        (arg0.minted_count, 0x2::balance::value<0x2::sui::SUI>(&arg0.treasury))
    }

    public fun get_created_at(arg0: &CreativeElementNFT) : u64 {
        arg0.created_at
    }

    public fun get_creator(arg0: &CreativeElementNFT) : address {
        arg0.creator
    }

    public fun get_element_name(arg0: &CreativeElementNFT) : 0x1::string::String {
        arg0.element_name
    }

    public fun get_emoji(arg0: &CreativeElementNFT) : 0x1::string::String {
        arg0.emoji
    }

    public fun get_image_url(arg0: &CreativeElementNFT) : 0x1::string::String {
        arg0.image_url
    }

    public fun get_item_id(arg0: &CreativeElementNFT) : 0x1::string::String {
        arg0.item_id
    }

    fun init(arg0: CREATIVE_ELEMENT_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<CREATIVE_ELEMENT_NFT>(arg0, arg1);
        let (v1, v2) = 0x2::transfer_policy::new<CreativeElementNFT>(&v0, arg1);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<CreativeElementNFT>>(v1);
        let v3 = 0x2::display::new<CreativeElementNFT>(&v0, arg1);
        0x2::display::add<CreativeElementNFT>(&mut v3, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{element_name}"));
        0x2::display::add<CreativeElementNFT>(&mut v3, 0x1::string::utf8(b"element_name"), 0x1::string::utf8(b"{element_name}"));
        0x2::display::add<CreativeElementNFT>(&mut v3, 0x1::string::utf8(b"emoji"), 0x1::string::utf8(b"{emoji}"));
        0x2::display::add<CreativeElementNFT>(&mut v3, 0x1::string::utf8(b"amount"), 0x1::string::utf8(b"{amount}"));
        0x2::display::add<CreativeElementNFT>(&mut v3, 0x1::string::utf8(b"item_id"), 0x1::string::utf8(b"{item_id}"));
        0x2::display::add<CreativeElementNFT>(&mut v3, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::add<CreativeElementNFT>(&mut v3, 0x1::string::utf8(b"creator"), 0x1::string::utf8(b"{creator}"));
        0x2::display::update_version<CreativeElementNFT>(&mut v3);
        let v4 = AdminCap{id: 0x2::object::new(arg1)};
        let v5 = CollectionConfig{creator_fee_bps: 250};
        let v6 = ElementCollection{
            id           : 0x2::object::new(arg1),
            minted_count : 0,
            treasury     : 0x2::balance::zero<0x2::sui::SUI>(),
            config       : v5,
        };
        0x2::transfer::public_transfer<0x2::display::Display<CreativeElementNFT>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<CreativeElementNFT>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<AdminCap>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<ElementCollection>(v6);
    }

    public fun mint_creative_element(arg0: &mut ElementCollection, arg1: 0x1::string::String, arg2: u64, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: address, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<CreativeElementNFT>(mint_creative_element_nft(arg0, arg1, arg2, arg3, arg4, arg5, arg7, arg8), arg6);
    }

    public fun mint_creative_element_nft(arg0: &mut ElementCollection, arg1: 0x1::string::String, arg2: u64, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : CreativeElementNFT {
        let v0 = CreativeElementNFT{
            id           : 0x2::object::new(arg7),
            element_name : arg1,
            amount       : arg2,
            emoji        : arg3,
            item_id      : arg4,
            creator      : 0x2::tx_context::sender(arg7),
            created_at   : 0x2::clock::timestamp_ms(arg6),
            image_url    : arg5,
        };
        arg0.minted_count = arg0.minted_count + 1;
        let v1 = CreativeElementMinted{
            nft_id       : 0x2::object::id<CreativeElementNFT>(&v0),
            element_name : v0.element_name,
            amount       : v0.amount,
            creator      : v0.creator,
        };
        0x2::event::emit<CreativeElementMinted>(v1);
        v0
    }

    public fun mint_with_admin(arg0: &AdminCap, arg1: &mut ElementCollection, arg2: 0x1::string::String, arg3: u64, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: address, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        mint_creative_element(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
    }

    public fun update_creator_fee(arg0: &AdminCap, arg1: &mut ElementCollection, arg2: u16) {
        assert!(arg2 <= 10000, 1);
        arg1.config.creator_fee_bps = arg2;
    }

    // decompiled from Move bytecode v6
}

