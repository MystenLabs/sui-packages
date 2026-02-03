module 0x588cce726960faf07bc06010a135249c8d1edcc79c6fc8bc1d3581a0630f8821::hashcase_module {
    struct HASHCASE_MODULE has drop {
        dummy_field: bool,
    }

    struct CollectionCreated has copy, drop {
        collection_id: 0x2::object::ID,
        name: 0x1::string::String,
        creator: address,
        mint_type: u8,
    }

    struct NFTMinted has copy, drop {
        nft_id: 0x2::object::ID,
        collection_id: 0x2::object::ID,
        creator: address,
        recipient: address,
        token_number: u64,
        mint_price: u64,
    }

    struct NFTClaimed has copy, drop {
        original_nft_id: 0x2::object::ID,
        claimed_nft_id: 0x2::object::ID,
        claimer: address,
    }

    struct NFTBurned has copy, drop {
        nft_id: 0x2::object::ID,
        burner: address,
    }

    struct NFTMetadataUpdated has copy, drop {
        nft_id: 0x2::object::ID,
        collection_id: 0x2::object::ID,
        updater: address,
        new_metadata_version: u64,
    }

    struct UpdateTicketCreated has copy, drop {
        ticket_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        recipient: address,
        admin: address,
    }

    struct UpdateTicketUsed has copy, drop {
        ticket_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        user: address,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct OwnerCap has store, key {
        id: 0x2::object::UID,
        creator: address,
    }

    struct UpdateTicket has store, key {
        id: 0x2::object::UID,
        nft_id: 0x2::object::ID,
        collection_id: 0x2::object::ID,
        recipient: address,
        new_name: 0x1::string::String,
        new_description: 0x1::string::String,
        new_image_url: vector<u8>,
        new_attributes: vector<0x1::string::String>,
        created_by: address,
        created_at: u64,
        is_used: bool,
    }

    struct Collection has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        creator: address,
        owner: address,
        mint_type: u8,
        base_mint_price: u64,
        collected_funds: 0x2::balance::Balance<0x2::sui::SUI>,
        is_open_edition: bool,
        max_supply: 0x1::option::Option<u64>,
        current_supply: u64,
        is_dynamic: bool,
        is_claimable: bool,
        base_image_url: 0x2::url::Url,
        base_attributes: vector<0x1::string::String>,
        current_token_number: u64,
        nft_prices: 0x2::table::Table<0x2::object::ID, u64>,
    }

    struct NFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x2::url::Url,
        collection_id: 0x2::object::ID,
        creator: address,
        attributes: vector<0x1::string::String>,
        token_number: u64,
        mint_price: u64,
        metadata_version: u64,
    }

    struct ClaimedNFT has store, key {
        id: 0x2::object::UID,
        original_nft_id: 0x2::object::ID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x2::url::Url,
        collection_id: 0x2::object::ID,
        claimer: address,
        claimed_date: u64,
        attributes: vector<0x1::string::String>,
    }

    public entry fun admin_dynamic_price_mint_nft(arg0: &AdminCap, arg1: &mut Collection, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: vector<u8>, arg6: vector<0x1::string::String>, arg7: u64, arg8: address, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.mint_type == 2, 11);
        assert!(0x2::coin::value<0x2::sui::SUI>(arg2) >= arg7, 6);
        0x2::coin::put<0x2::sui::SUI>(&mut arg1.collected_funds, 0x2::coin::split<0x2::sui::SUI>(arg2, arg7, arg9));
        0x2::transfer::public_transfer<NFT>(internal_mint_nft(arg1, arg3, arg4, arg5, arg6, arg7, arg8, arg9), arg8);
    }

    public entry fun admin_fixed_price_mint_nft(arg0: &AdminCap, arg1: &mut Collection, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: vector<u8>, arg6: vector<0x1::string::String>, arg7: address, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.mint_type == 1, 11);
        let v0 = arg1.base_mint_price;
        assert!(0x2::coin::value<0x2::sui::SUI>(arg2) == v0, 6);
        0x2::coin::put<0x2::sui::SUI>(&mut arg1.collected_funds, 0x2::coin::split<0x2::sui::SUI>(arg2, v0, arg8));
        0x2::transfer::public_transfer<NFT>(internal_mint_nft(arg1, arg3, arg4, arg5, arg6, v0, arg7, arg8), arg7);
    }

    public entry fun admin_free_mint_nft(arg0: &AdminCap, arg1: &mut Collection, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: vector<u8>, arg5: vector<0x1::string::String>, arg6: address, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.mint_type == 0, 11);
        0x2::transfer::public_transfer<NFT>(internal_mint_nft(arg1, arg2, arg3, arg4, arg5, 0, arg6, arg7), arg6);
    }

    public entry fun admin_set_nft_price(arg0: &AdminCap, arg1: &mut Collection, arg2: 0x2::object::ID, arg3: u64) {
        assert!(arg1.mint_type == 2, 11);
        if (0x2::table::contains<0x2::object::ID, u64>(&arg1.nft_prices, arg2)) {
            *0x2::table::borrow_mut<0x2::object::ID, u64>(&mut arg1.nft_prices, arg2) = arg3;
        };
    }

    public entry fun claim_nft(arg0: &mut Collection, arg1: NFT, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.is_claimable, 2);
        assert!(arg1.collection_id == 0x2::object::uid_to_inner(&arg0.id), 2);
        let v0 = ClaimedNFT{
            id              : 0x2::object::new(arg2),
            original_nft_id : 0x2::object::uid_to_inner(&arg1.id),
            name            : arg0.name,
            description     : arg0.description,
            image_url       : arg0.base_image_url,
            collection_id   : 0x2::object::uid_to_inner(&arg0.id),
            claimer         : 0x2::tx_context::sender(arg2),
            claimed_date    : 0x2::tx_context::epoch(arg2),
            attributes      : arg0.base_attributes,
        };
        let NFT {
            id               : v1,
            name             : _,
            description      : _,
            image_url        : _,
            collection_id    : _,
            creator          : _,
            attributes       : _,
            token_number     : _,
            mint_price       : _,
            metadata_version : _,
        } = arg1;
        0x2::object::delete(v1);
        let v11 = NFTClaimed{
            original_nft_id : 0x2::object::uid_to_inner(&arg1.id),
            claimed_nft_id  : 0x2::object::uid_to_inner(&v0.id),
            claimer         : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<NFTClaimed>(v11);
        0x2::transfer::public_transfer<ClaimedNFT>(v0, 0x2::tx_context::sender(arg2));
    }

    public entry fun create_collection(arg0: &AdminCap, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u8, arg4: u64, arg5: bool, arg6: u64, arg7: bool, arg8: bool, arg9: vector<u8>, arg10: vector<0x1::string::String>, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg11);
        let v1 = if (arg3 == 0) {
            0
        } else {
            arg4
        };
        let v2 = if (arg6 == 0) {
            0x1::option::none<u64>()
        } else {
            0x1::option::some<u64>(arg6)
        };
        let v3 = Collection{
            id                   : 0x2::object::new(arg11),
            name                 : arg1,
            description          : arg2,
            creator              : v0,
            owner                : v0,
            mint_type            : arg3,
            base_mint_price      : v1,
            collected_funds      : 0x2::balance::zero<0x2::sui::SUI>(),
            is_open_edition      : arg5,
            max_supply           : v2,
            current_supply       : 0,
            is_dynamic           : arg7,
            is_claimable         : arg8,
            base_image_url       : 0x2::url::new_unsafe_from_bytes(arg9),
            base_attributes      : arg10,
            current_token_number : 0,
            nft_prices           : 0x2::table::new<0x2::object::ID, u64>(arg11),
        };
        let v4 = CollectionCreated{
            collection_id : 0x2::object::uid_to_inner(&v3.id),
            name          : arg1,
            creator       : v0,
            mint_type     : arg3,
        };
        0x2::event::emit<CollectionCreated>(v4);
        0x2::transfer::share_object<Collection>(v3);
    }

    public entry fun create_owner_cap(arg0: &AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = OwnerCap{
            id      : 0x2::object::new(arg2),
            creator : arg1,
        };
        0x2::transfer::transfer<OwnerCap>(v0, arg1);
    }

    public entry fun create_update_ticket(arg0: &AdminCap, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: address, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: vector<u8>, arg7: vector<0x1::string::String>, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg8);
        let v1 = UpdateTicket{
            id              : 0x2::object::new(arg8),
            nft_id          : arg1,
            collection_id   : arg2,
            recipient       : arg3,
            new_name        : arg4,
            new_description : arg5,
            new_image_url   : arg6,
            new_attributes  : arg7,
            created_by      : v0,
            created_at      : 0x2::tx_context::epoch(arg8),
            is_used         : false,
        };
        let v2 = UpdateTicketCreated{
            ticket_id : 0x2::object::uid_to_inner(&v1.id),
            nft_id    : arg1,
            recipient : arg3,
            admin     : v0,
        };
        0x2::event::emit<UpdateTicketCreated>(v2);
        0x2::transfer::public_transfer<UpdateTicket>(v1, arg3);
    }

    public fun get_collection_nft_count(arg0: &Collection) : u64 {
        arg0.current_supply
    }

    public fun get_collection_total_funds(arg0: &Collection) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.collected_funds)
    }

    public fun get_ticket_nft_id(arg0: &UpdateTicket) : 0x2::object::ID {
        arg0.nft_id
    }

    public fun get_ticket_recipient(arg0: &UpdateTicket) : address {
        arg0.recipient
    }

    fun init(arg0: HASHCASE_MODULE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
        let v1 = 0x2::package::claim<HASHCASE_MODULE>(arg0, arg1);
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"creator"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"collection_id"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"token_number"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"attributes"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"mint_price"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"metadata_version"));
        let v4 = 0x1::vector::empty<0x1::string::String>();
        let v5 = &mut v4;
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{creator}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{collection_id}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"#{token_number}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{attributes}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{mint_price} SUI"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"v{metadata_version}"));
        let v6 = 0x2::display::new_with_fields<NFT>(&v1, v2, v4, arg1);
        0x2::display::update_version<NFT>(&mut v6);
        let v7 = 0x1::vector::empty<0x1::string::String>();
        let v8 = &mut v7;
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"claimer"));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"collection_id"));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"original_nft_id"));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"claimed_date"));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"attributes"));
        let v9 = 0x1::vector::empty<0x1::string::String>();
        let v10 = &mut v9;
        0x1::vector::push_back<0x1::string::String>(v10, 0x1::string::utf8(b"{name} (Claimed)"));
        0x1::vector::push_back<0x1::string::String>(v10, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v10, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v10, 0x1::string::utf8(b"{claimer}"));
        0x1::vector::push_back<0x1::string::String>(v10, 0x1::string::utf8(b"{collection_id}"));
        0x1::vector::push_back<0x1::string::String>(v10, 0x1::string::utf8(b"{original_nft_id}"));
        0x1::vector::push_back<0x1::string::String>(v10, 0x1::string::utf8(b"Claimed at epoch {claimed_date}"));
        0x1::vector::push_back<0x1::string::String>(v10, 0x1::string::utf8(b"{attributes}"));
        let v11 = 0x2::display::new_with_fields<ClaimedNFT>(&v1, v7, v9, arg1);
        0x2::display::update_version<ClaimedNFT>(&mut v11);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<NFT>>(v6, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<ClaimedNFT>>(v11, 0x2::tx_context::sender(arg1));
    }

    fun internal_mint_nft(arg0: &mut Collection, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: vector<u8>, arg4: vector<0x1::string::String>, arg5: u64, arg6: address, arg7: &mut 0x2::tx_context::TxContext) : NFT {
        if (!arg0.is_open_edition) {
            assert!(0x1::option::is_none<u64>(&arg0.max_supply) || arg0.current_supply < *0x1::option::borrow<u64>(&arg0.max_supply), 9);
        };
        arg0.current_token_number = arg0.current_token_number + 1;
        let v0 = arg0.current_token_number;
        let v1 = 0x2::object::new(arg7);
        let v2 = 0x2::object::uid_to_inner(&v1);
        let v3 = NFT{
            id               : v1,
            name             : arg1,
            description      : arg2,
            image_url        : 0x2::url::new_unsafe_from_bytes(arg3),
            collection_id    : 0x2::object::uid_to_inner(&arg0.id),
            creator          : 0x2::tx_context::sender(arg7),
            attributes       : arg4,
            token_number     : v0,
            mint_price       : arg5,
            metadata_version : 1,
        };
        if (arg0.mint_type == 2) {
            0x2::table::add<0x2::object::ID, u64>(&mut arg0.nft_prices, v2, arg5);
        };
        arg0.current_supply = arg0.current_supply + 1;
        let v4 = NFTMinted{
            nft_id        : v2,
            collection_id : 0x2::object::uid_to_inner(&arg0.id),
            creator       : 0x2::tx_context::sender(arg7),
            recipient     : arg6,
            token_number  : v0,
            mint_price    : arg5,
        };
        0x2::event::emit<NFTMinted>(v4);
        v3
    }

    public fun is_ticket_valid(arg0: &UpdateTicket) : bool {
        !arg0.is_used
    }

    public entry fun update_nft_metadata_with_ticket(arg0: &Collection, arg1: &mut NFT, arg2: UpdateTicket, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.collection_id == 0x2::object::uid_to_inner(&arg0.id), 2);
        assert!(arg0.is_dynamic, 5);
        assert!(arg2.nft_id == 0x2::object::uid_to_inner(&arg1.id), 14);
        assert!(arg2.collection_id == 0x2::object::uid_to_inner(&arg0.id), 14);
        assert!(arg2.recipient == 0x2::tx_context::sender(arg3), 2);
        assert!(!arg2.is_used, 13);
        arg1.name = arg2.new_name;
        arg1.description = arg2.new_description;
        arg1.image_url = 0x2::url::new_unsafe_from_bytes(arg2.new_image_url);
        arg1.attributes = arg2.new_attributes;
        arg1.metadata_version = arg1.metadata_version + 1;
        let v0 = NFTMetadataUpdated{
            nft_id               : 0x2::object::uid_to_inner(&arg1.id),
            collection_id        : 0x2::object::uid_to_inner(&arg0.id),
            updater              : 0x2::tx_context::sender(arg3),
            new_metadata_version : arg1.metadata_version,
        };
        0x2::event::emit<NFTMetadataUpdated>(v0);
        let v1 = UpdateTicketUsed{
            ticket_id : 0x2::object::uid_to_inner(&arg2.id),
            nft_id    : 0x2::object::uid_to_inner(&arg1.id),
            user      : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<UpdateTicketUsed>(v1);
        let UpdateTicket {
            id              : v2,
            nft_id          : _,
            collection_id   : _,
            recipient       : _,
            new_name        : _,
            new_description : _,
            new_image_url   : _,
            new_attributes  : _,
            created_by      : _,
            created_at      : _,
            is_used         : _,
        } = arg2;
        0x2::object::delete(v2);
    }

    public entry fun withdraw_collection_funds(arg0: &OwnerCap, arg1: &mut Collection, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.owner == 0x2::tx_context::sender(arg2), 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.collected_funds, 0x2::balance::value<0x2::sui::SUI>(&arg1.collected_funds)), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

