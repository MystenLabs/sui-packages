module 0x52c0cbbcf58ebe66bed387ee9bdb023b4145e93b17eccf016c05c266ff24c167::gravemint_edition_nft {
    struct GRAVEMINT_EDITION_NFT has drop {
        dummy_field: bool,
    }

    struct PublisherCap has store, key {
        id: 0x2::object::UID,
    }

    struct EditionCollection has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        symbol: 0x1::string::String,
        description: 0x1::string::String,
        base_uri: 0x1::string::String,
        image_uri: 0x1::string::String,
        max_masters: u64,
        total_masters: u64,
        total_editions_minted: u64,
        mint_price: u64,
        max_per_wallet: u64,
        minting_enabled: bool,
        mint_start_time: u64,
        mint_end_time: u64,
        creator: address,
        payment_recipient: address,
        platform_fee_recipient: address,
        platform_fee_bps: u64,
        royalty_recipient: address,
        royalty_bps: u64,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        is_mutable: bool,
        is_frozen: bool,
        is_revealed: bool,
        placeholder_uri: 0x1::string::String,
        is_soulbound: bool,
        burned_count: u64,
        treasury_reserve: u64,
        treasury_minted: u64,
        minted_master_token_ids: 0x2::vec_set::VecSet<u64>,
    }

    struct MasterEdition has key {
        id: 0x2::object::UID,
        collection_id: 0x2::object::ID,
        token_id: u64,
        uri: 0x1::string::String,
        image_uri: 0x1::string::String,
        max_supply: u64,
        current_supply: u64,
        is_frozen: bool,
        mints_per_wallet: 0x2::vec_map::VecMap<address, u64>,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    struct CollectionAdminCap has store, key {
        id: 0x2::object::UID,
        collection_id: 0x2::object::ID,
    }

    struct PlatformAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct PlatformMintCap has key {
        id: 0x2::object::UID,
        collection_id: 0x2::object::ID,
        platform_address: address,
    }

    struct EditionNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        token_id: u64,
        edition_number: u64,
        uri: 0x1::string::String,
        image_uri: 0x1::string::String,
        collection_id: 0x2::object::ID,
        master_id: 0x2::object::ID,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
        is_frozen: bool,
        is_soulbound: bool,
    }

    struct EditionCollectionCreated has copy, drop {
        collection_id: 0x2::object::ID,
        name: 0x1::string::String,
        symbol: 0x1::string::String,
        creator: address,
        max_masters: u64,
    }

    struct MasterEditionCreated has copy, drop {
        collection_id: 0x2::object::ID,
        master_id: 0x2::object::ID,
        token_id: u64,
        max_supply: u64,
        uri: 0x1::string::String,
    }

    struct EditionMinted has copy, drop {
        collection_id: 0x2::object::ID,
        master_id: 0x2::object::ID,
        edition_id: 0x2::object::ID,
        token_id: u64,
        edition_number: u64,
        minter: address,
        price_paid: u64,
    }

    struct MintingToggled has copy, drop {
        collection_id: 0x2::object::ID,
        enabled: bool,
    }

    struct MintPriceUpdated has copy, drop {
        collection_id: 0x2::object::ID,
        new_price: u64,
    }

    struct PaymentWithdrawn has copy, drop {
        collection_id: 0x2::object::ID,
        amount: u64,
        recipient: address,
    }

    struct EditionBurned has copy, drop {
        collection_id: 0x2::object::ID,
        master_id: 0x2::object::ID,
        edition_id: 0x2::object::ID,
        token_id: u64,
        edition_number: u64,
    }

    struct EditionFrozenEvent has copy, drop {
        edition_id: 0x2::object::ID,
        frozen: bool,
    }

    struct MasterFrozenEvent has copy, drop {
        master_id: 0x2::object::ID,
        frozen: bool,
    }

    struct CollectionRevealed has copy, drop {
        collection_id: 0x2::object::ID,
        new_base_uri: 0x1::string::String,
    }

    struct AdminCapTransferred has copy, drop {
        collection_id: 0x2::object::ID,
        from: address,
        to: address,
    }

    struct MasterURIUpdated has copy, drop {
        master_id: 0x2::object::ID,
        new_uri: 0x1::string::String,
    }

    struct EditionListedForRent has copy, drop {
        edition_id: 0x2::object::ID,
        owner: address,
        price_per_day: u64,
        min_duration: u64,
        max_duration: u64,
    }

    struct EditionRented has copy, drop {
        edition_id: 0x2::object::ID,
        owner: address,
        renter: address,
        rental_end: u64,
        total_price: u64,
    }

    struct EditionRentalEnded has copy, drop {
        edition_id: 0x2::object::ID,
        owner: address,
        renter: address,
    }

    struct EditionRentalCancelled has copy, drop {
        edition_id: 0x2::object::ID,
        owner: address,
    }

    struct EditionTransferred has copy, drop {
        edition_id: 0x2::object::ID,
        from: address,
        to: address,
        timestamp: u64,
    }

    struct EditionPlacedInKiosk has copy, drop {
        nft_id: 0x2::object::ID,
        kiosk_id: 0x2::object::ID,
        owner: address,
    }

    struct EditionMintedToKiosk has copy, drop {
        collection_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        token_id: u64,
        edition_number: u64,
        kiosk_id: 0x2::object::ID,
        recipient: address,
    }

    public entry fun add_dynamic_field_string(arg0: &EditionCollection, arg1: &mut EditionNFT, arg2: &CollectionAdminCap, arg3: vector<u8>, arg4: vector<u8>) {
        assert!(arg0.is_mutable, 10);
        let v0 = 0x1::string::utf8(arg3);
        assert!(!0x2::dynamic_field::exists_<0x1::string::String>(&arg1.id, v0), 23);
        0x2::dynamic_field::add<0x1::string::String, 0x1::string::String>(&mut arg1.id, v0, 0x1::string::utf8(arg4));
    }

    public entry fun add_dynamic_field_u64(arg0: &EditionCollection, arg1: &mut EditionNFT, arg2: &CollectionAdminCap, arg3: vector<u8>, arg4: u64) {
        assert!(arg0.is_mutable, 10);
        let v0 = 0x1::string::utf8(b"u64:");
        0x1::string::append(&mut v0, 0x1::string::utf8(arg3));
        assert!(!0x2::dynamic_field::exists_<0x1::string::String>(&arg1.id, v0), 23);
        0x2::dynamic_field::add<0x1::string::String, u64>(&mut arg1.id, v0, arg4);
    }

    public entry fun add_edition_attribute(arg0: &EditionCollection, arg1: &mut EditionNFT, arg2: &CollectionAdminCap, arg3: vector<u8>, arg4: vector<u8>) {
        assert!(arg0.is_mutable, 10);
        let v0 = 0x1::string::utf8(arg3);
        if (0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(&arg1.attributes, &v0)) {
            let (_, _) = 0x2::vec_map::remove<0x1::string::String, 0x1::string::String>(&mut arg1.attributes, &v0);
        };
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut arg1.attributes, v0, 0x1::string::utf8(arg4));
    }

    public entry fun add_master_attribute(arg0: &mut MasterEdition, arg1: &CollectionAdminCap, arg2: vector<u8>, arg3: vector<u8>) {
        let v0 = 0x1::string::utf8(arg2);
        if (0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(&arg0.attributes, &v0)) {
            let (_, _) = 0x2::vec_map::remove<0x1::string::String, 0x1::string::String>(&mut arg0.attributes, &v0);
        };
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut arg0.attributes, v0, 0x1::string::utf8(arg3));
    }

    fun build_edition_name(arg0: &0x1::string::String, arg1: u64, arg2: u64, arg3: u64) : 0x1::string::String {
        let v0 = *arg0;
        0x1::string::append_utf8(&mut v0, b" #");
        0x1::string::append(&mut v0, u64_to_string(arg1));
        0x1::string::append_utf8(&mut v0, b" - Edition ");
        0x1::string::append(&mut v0, u64_to_string(arg2));
        if (arg3 > 0) {
            0x1::string::append_utf8(&mut v0, b"/");
            0x1::string::append(&mut v0, u64_to_string(arg3));
        };
        v0
    }

    public entry fun burn_edition(arg0: &mut EditionCollection, arg1: EditionNFT) {
        let EditionNFT {
            id             : v0,
            name           : _,
            description    : _,
            token_id       : v3,
            edition_number : v4,
            uri            : _,
            image_uri      : _,
            collection_id  : v7,
            master_id      : v8,
            attributes     : _,
            is_frozen      : _,
            is_soulbound   : _,
        } = arg1;
        let v12 = v0;
        assert!(v7 == 0x2::object::uid_to_inner(&arg0.id), 0);
        arg0.burned_count = arg0.burned_count + 1;
        let v13 = EditionBurned{
            collection_id  : v7,
            master_id      : v8,
            edition_id     : 0x2::object::uid_to_inner(&v12),
            token_id       : v3,
            edition_number : v4,
        };
        0x2::event::emit<EditionBurned>(v13);
        0x2::object::delete(v12);
    }

    public entry fun cancel_edition_rental_listing(arg0: &mut EditionNFT, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x1::string::utf8(b"_rental_owner");
        assert!(0x2::dynamic_field::exists_<0x1::string::String>(&arg0.id, v0), 25);
        let v1 = *0x2::dynamic_field::borrow<0x1::string::String, address>(&arg0.id, v0);
        assert!(0x2::tx_context::sender(arg2) == v1, 0);
        let v2 = 0x1::string::utf8(b"_rental_end");
        if (0x2::dynamic_field::exists_<0x1::string::String>(&arg0.id, v2)) {
            assert!(0x2::clock::timestamp_ms(arg1) / 1000 >= *0x2::dynamic_field::borrow<0x1::string::String, u64>(&arg0.id, v2), 24);
        };
        let v3 = 0x1::string::utf8(b"_rental_info");
        let v4 = 0x1::string::utf8(b"_rental_price");
        let v5 = 0x1::string::utf8(b"_rental_renter");
        let v6 = 0x1::string::utf8(b"_rental_min_days");
        let v7 = 0x1::string::utf8(b"_rental_max_days");
        if (0x2::dynamic_field::exists_<0x1::string::String>(&arg0.id, v3)) {
            0x2::dynamic_field::remove<0x1::string::String, 0x1::string::String>(&mut arg0.id, v3);
        };
        if (0x2::dynamic_field::exists_<0x1::string::String>(&arg0.id, v0)) {
            0x2::dynamic_field::remove<0x1::string::String, address>(&mut arg0.id, v0);
        };
        if (0x2::dynamic_field::exists_<0x1::string::String>(&arg0.id, v4)) {
            0x2::dynamic_field::remove<0x1::string::String, u64>(&mut arg0.id, v4);
        };
        if (0x2::dynamic_field::exists_<0x1::string::String>(&arg0.id, v2)) {
            0x2::dynamic_field::remove<0x1::string::String, u64>(&mut arg0.id, v2);
        };
        if (0x2::dynamic_field::exists_<0x1::string::String>(&arg0.id, v5)) {
            0x2::dynamic_field::remove<0x1::string::String, address>(&mut arg0.id, v5);
        };
        if (0x2::dynamic_field::exists_<0x1::string::String>(&arg0.id, v6)) {
            0x2::dynamic_field::remove<0x1::string::String, u64>(&mut arg0.id, v6);
        };
        if (0x2::dynamic_field::exists_<0x1::string::String>(&arg0.id, v7)) {
            0x2::dynamic_field::remove<0x1::string::String, u64>(&mut arg0.id, v7);
        };
        let v8 = EditionRentalCancelled{
            edition_id : 0x2::object::uid_to_inner(&arg0.id),
            owner      : v1,
        };
        0x2::event::emit<EditionRentalCancelled>(v8);
    }

    public entry fun create_edition_collection(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: address, arg11: address, arg12: u64, arg13: address, arg14: u64, arg15: bool, arg16: bool, arg17: vector<u8>, arg18: u64, arg19: &mut 0x2::tx_context::TxContext) {
        assert!(arg12 <= 1000, 11);
        assert!(arg14 <= 10000, 11);
        let v0 = 0x2::tx_context::sender(arg19);
        let v1 = 0x2::object::new(arg19);
        let v2 = 0x2::object::uid_to_inner(&v1);
        let v3 = 0x1::string::utf8(arg17);
        let v4 = EditionCollection{
            id                      : v1,
            name                    : 0x1::string::utf8(arg0),
            symbol                  : 0x1::string::utf8(arg1),
            description             : 0x1::string::utf8(arg2),
            base_uri                : 0x1::string::utf8(arg3),
            image_uri               : 0x1::string::utf8(arg4),
            max_masters             : arg5,
            total_masters           : 0,
            total_editions_minted   : 0,
            mint_price              : arg6,
            max_per_wallet          : arg7,
            minting_enabled         : true,
            mint_start_time         : arg8,
            mint_end_time           : arg9,
            creator                 : v0,
            payment_recipient       : arg10,
            platform_fee_recipient  : arg11,
            platform_fee_bps        : arg12,
            royalty_recipient       : arg13,
            royalty_bps             : arg14,
            balance                 : 0x2::balance::zero<0x2::sui::SUI>(),
            is_mutable              : arg15,
            is_frozen               : false,
            is_revealed             : 0x1::string::length(&v3) == 0,
            placeholder_uri         : v3,
            is_soulbound            : arg16,
            burned_count            : 0,
            treasury_reserve        : arg18,
            treasury_minted         : 0,
            minted_master_token_ids : 0x2::vec_set::empty<u64>(),
        };
        let v5 = CollectionAdminCap{
            id            : 0x2::object::new(arg19),
            collection_id : v2,
        };
        let v6 = PlatformMintCap{
            id               : 0x2::object::new(arg19),
            collection_id    : v2,
            platform_address : arg11,
        };
        let v7 = EditionCollectionCreated{
            collection_id : v2,
            name          : 0x1::string::utf8(arg0),
            symbol        : 0x1::string::utf8(arg1),
            creator       : v0,
            max_masters   : arg5,
        };
        0x2::event::emit<EditionCollectionCreated>(v7);
        0x2::transfer::share_object<EditionCollection>(v4);
        0x2::transfer::transfer<CollectionAdminCap>(v5, v0);
        0x2::transfer::share_object<PlatformMintCap>(v6);
    }

    public entry fun create_master(arg0: &mut EditionCollection, arg1: &CollectionAdminCap, arg2: u64, arg3: u64, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<vector<u8>>, arg7: vector<vector<u8>>, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.is_frozen, 13);
        assert!(arg2 > 0, 32);
        assert!(!0x2::vec_set::contains<u64>(&arg0.minted_master_token_ids, &arg2), 17);
        if (arg0.max_masters > 0) {
            assert!(arg0.total_masters < arg0.max_masters, 4);
        };
        let v0 = 0x2::object::uid_to_inner(&arg0.id);
        let v1 = 0x2::object::new(arg8);
        let v2 = 0x1::string::utf8(arg4);
        let v3 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
        let v4 = 0;
        while (v4 < 0x1::vector::length<vector<u8>>(&arg6)) {
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v3, 0x1::string::utf8(*0x1::vector::borrow<vector<u8>>(&arg6, v4)), 0x1::string::utf8(*0x1::vector::borrow<vector<u8>>(&arg7, v4)));
            v4 = v4 + 1;
        };
        let v5 = MasterEdition{
            id               : v1,
            collection_id    : v0,
            token_id         : arg2,
            uri              : v2,
            image_uri        : 0x1::string::utf8(arg5),
            max_supply       : arg3,
            current_supply   : 0,
            is_frozen        : false,
            mints_per_wallet : 0x2::vec_map::empty<address, u64>(),
            attributes       : v3,
        };
        0x2::vec_set::insert<u64>(&mut arg0.minted_master_token_ids, arg2);
        arg0.total_masters = arg0.total_masters + 1;
        let v6 = MasterEditionCreated{
            collection_id : v0,
            master_id     : 0x2::object::uid_to_inner(&v1),
            token_id      : arg2,
            max_supply    : arg3,
            uri           : v2,
        };
        0x2::event::emit<MasterEditionCreated>(v6);
        0x2::transfer::share_object<MasterEdition>(v5);
    }

    public entry fun create_masters_batch(arg0: &mut EditionCollection, arg1: &CollectionAdminCap, arg2: vector<u64>, arg3: vector<u64>, arg4: vector<vector<u8>>, arg5: vector<vector<u8>>, arg6: vector<vector<vector<u8>>>, arg7: vector<vector<vector<u8>>>, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<u64>(&arg2);
        assert!(v0 == 0x1::vector::length<u64>(&arg3), 7);
        assert!(v0 == 0x1::vector::length<vector<u8>>(&arg4), 7);
        assert!(v0 == 0x1::vector::length<vector<u8>>(&arg5), 7);
        assert!(v0 == 0x1::vector::length<vector<vector<u8>>>(&arg6), 7);
        assert!(v0 == 0x1::vector::length<vector<vector<u8>>>(&arg7), 7);
        let v1 = 0;
        while (v1 < v0) {
            create_master(arg0, arg1, *0x1::vector::borrow<u64>(&arg2, v1), *0x1::vector::borrow<u64>(&arg3, v1), *0x1::vector::borrow<vector<u8>>(&arg4, v1), *0x1::vector::borrow<vector<u8>>(&arg5, v1), *0x1::vector::borrow<vector<vector<u8>>>(&arg6, v1), *0x1::vector::borrow<vector<vector<u8>>>(&arg7, v1), arg8);
            v1 = v1 + 1;
        };
    }

    public entry fun create_transfer_policy(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::transfer_policy::new<EditionNFT>(arg0, arg1);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<EditionNFT>>(v0);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<EditionNFT>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun create_user_kiosk(arg0: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::kiosk::new(arg0);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v0);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public entry fun delist_from_kiosk(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::kiosk::delist<EditionNFT>(arg0, arg1, arg2);
    }

    public entry fun end_edition_rental(arg0: &mut EditionNFT, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x1::string::utf8(b"_rental_end");
        assert!(0x2::dynamic_field::exists_<0x1::string::String>(&arg0.id, v0), 25);
        assert!(0x2::clock::timestamp_ms(arg1) / 1000 >= *0x2::dynamic_field::borrow<0x1::string::String, u64>(&arg0.id, v0), 26);
        let v1 = 0x1::string::utf8(b"_rental_owner");
        let v2 = 0x1::string::utf8(b"_rental_renter");
        let v3 = if (0x2::dynamic_field::exists_<0x1::string::String>(&arg0.id, v1)) {
            *0x2::dynamic_field::borrow<0x1::string::String, address>(&arg0.id, v1)
        } else {
            0x2::tx_context::sender(arg2)
        };
        let v4 = if (0x2::dynamic_field::exists_<0x1::string::String>(&arg0.id, v2)) {
            *0x2::dynamic_field::borrow<0x1::string::String, address>(&arg0.id, v2)
        } else {
            @0x0
        };
        *0x2::dynamic_field::borrow_mut<0x1::string::String, u64>(&mut arg0.id, v0) = 0;
        if (0x2::dynamic_field::exists_<0x1::string::String>(&arg0.id, v2)) {
            *0x2::dynamic_field::borrow_mut<0x1::string::String, address>(&mut arg0.id, v2) = @0x0;
        };
        let v5 = EditionRentalEnded{
            edition_id : 0x2::object::uid_to_inner(&arg0.id),
            owner      : v3,
            renter     : v4,
        };
        0x2::event::emit<EditionRentalEnded>(v5);
    }

    public entry fun freeze_collection(arg0: &mut EditionCollection, arg1: &CollectionAdminCap) {
        arg0.is_frozen = true;
        arg0.minting_enabled = false;
    }

    public entry fun freeze_master(arg0: &mut MasterEdition, arg1: &CollectionAdminCap) {
        arg0.is_frozen = true;
        let v0 = MasterFrozenEvent{
            master_id : 0x2::object::uid_to_inner(&arg0.id),
            frozen    : true,
        };
        0x2::event::emit<MasterFrozenEvent>(v0);
    }

    public fun get_balance(arg0: &EditionCollection) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.balance)
    }

    public fun get_burned_count(arg0: &EditionCollection) : u64 {
        arg0.burned_count
    }

    public fun get_collection_info(arg0: &EditionCollection) : (0x1::string::String, 0x1::string::String, u64, u64, u64, u64, bool, u64, u64, bool, bool) {
        (arg0.name, arg0.symbol, arg0.max_masters, arg0.total_masters, arg0.total_editions_minted, arg0.mint_price, arg0.minting_enabled, arg0.mint_start_time, arg0.mint_end_time, arg0.is_revealed, arg0.is_frozen)
    }

    public fun get_dynamic_field_string(arg0: &EditionNFT, arg1: vector<u8>) : 0x1::string::String {
        *0x2::dynamic_field::borrow<0x1::string::String, 0x1::string::String>(&arg0.id, 0x1::string::utf8(arg1))
    }

    public fun get_dynamic_field_u64(arg0: &EditionNFT, arg1: vector<u8>) : u64 {
        let v0 = 0x1::string::utf8(b"u64:");
        0x1::string::append(&mut v0, 0x1::string::utf8(arg1));
        *0x2::dynamic_field::borrow<0x1::string::String, u64>(&arg0.id, v0)
    }

    public fun get_edition_info(arg0: &EditionNFT) : (0x1::string::String, u64, u64, 0x1::string::String, 0x2::object::ID, 0x2::object::ID, bool, bool) {
        (arg0.name, arg0.token_id, arg0.edition_number, arg0.uri, arg0.collection_id, arg0.master_id, arg0.is_frozen, arg0.is_soulbound)
    }

    public fun get_master_info(arg0: &MasterEdition) : (0x2::object::ID, u64, 0x1::string::String, u64, u64, bool) {
        (arg0.collection_id, arg0.token_id, arg0.uri, arg0.max_supply, arg0.current_supply, arg0.is_frozen)
    }

    public fun get_master_remaining_supply(arg0: &MasterEdition) : u64 {
        if (arg0.max_supply == 0) {
            18446744073709551615
        } else {
            arg0.max_supply - arg0.current_supply
        }
    }

    public fun get_master_wallet_mints(arg0: &MasterEdition, arg1: address) : u64 {
        if (0x2::vec_map::contains<address, u64>(&arg0.mints_per_wallet, &arg1)) {
            *0x2::vec_map::get<address, u64>(&arg0.mints_per_wallet, &arg1)
        } else {
            0
        }
    }

    public fun get_treasury_info(arg0: &EditionCollection) : (u64, u64) {
        (arg0.treasury_reserve, arg0.treasury_minted)
    }

    public fun has_dynamic_field_string(arg0: &EditionNFT, arg1: vector<u8>) : bool {
        0x2::dynamic_field::exists_<0x1::string::String>(&arg0.id, 0x1::string::utf8(arg1))
    }

    public fun has_dynamic_field_u64(arg0: &EditionNFT, arg1: vector<u8>) : bool {
        let v0 = 0x1::string::utf8(b"u64:");
        0x1::string::append(&mut v0, 0x1::string::utf8(arg1));
        0x2::dynamic_field::exists_<0x1::string::String>(&arg0.id, v0)
    }

    fun init(arg0: GRAVEMINT_EDITION_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<GRAVEMINT_EDITION_NFT>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"creator"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{image_uri}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{uri}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://gravemint.io"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"GraveMint Launchpad"));
        let v5 = 0x2::display::new_with_fields<EditionNFT>(&v0, v1, v3, arg1);
        0x2::display::update_version<EditionNFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<EditionNFT>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = PublisherCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<PublisherCap>(v6, 0x2::tx_context::sender(arg1));
        let v7 = PlatformAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<PlatformAdminCap>(v7, 0x2::tx_context::sender(arg1));
    }

    public fun is_edition_rented(arg0: &EditionNFT, arg1: &0x2::clock::Clock) : bool {
        let v0 = 0x1::string::utf8(b"_rental_end");
        if (!0x2::dynamic_field::exists_<0x1::string::String>(&arg0.id, v0)) {
            return false
        };
        0x2::clock::timestamp_ms(arg1) / 1000 < *0x2::dynamic_field::borrow<0x1::string::String, u64>(&arg0.id, v0)
    }

    public entry fun list_edition_for_rent(arg0: &mut EditionNFT, arg1: u64, arg2: u64, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        assert!(!arg0.is_frozen, 10);
        assert!(!arg0.is_soulbound, 16);
        let v0 = 0x1::string::utf8(b"_rental_info");
        assert!(!0x2::dynamic_field::exists_<0x1::string::String>(&arg0.id, v0), 28);
        let v1 = 0x2::tx_context::sender(arg4);
        0x2::dynamic_field::add<0x1::string::String, 0x1::string::String>(&mut arg0.id, v0, 0x1::string::utf8(b"listed"));
        0x2::dynamic_field::add<0x1::string::String, address>(&mut arg0.id, 0x1::string::utf8(b"_rental_owner"), v1);
        0x2::dynamic_field::add<0x1::string::String, u64>(&mut arg0.id, 0x1::string::utf8(b"_rental_price"), arg1);
        0x2::dynamic_field::add<0x1::string::String, u64>(&mut arg0.id, 0x1::string::utf8(b"_rental_min_days"), arg2);
        0x2::dynamic_field::add<0x1::string::String, u64>(&mut arg0.id, 0x1::string::utf8(b"_rental_max_days"), arg3);
        let v2 = EditionListedForRent{
            edition_id    : 0x2::object::uid_to_inner(&arg0.id),
            owner         : v1,
            price_per_day : arg1,
            min_duration  : arg2,
            max_duration  : arg3,
        };
        0x2::event::emit<EditionListedForRent>(v2);
    }

    public entry fun list_in_kiosk(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::kiosk::list<EditionNFT>(arg0, arg1, arg2, arg3);
    }

    public entry fun mint_edition(arg0: &mut EditionCollection, arg1: &mut MasterEdition, arg2: &PlatformMintCap, arg3: address, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg5);
        assert!(arg2.collection_id == 0x2::object::uid_to_inner(&arg0.id), 0);
        assert!(arg1.collection_id == 0x2::object::uid_to_inner(&arg0.id), 0);
        let v1 = 0x2::tx_context::sponsor(arg6);
        assert!(0x1::option::is_some<address>(&v1), 0);
        assert!(*0x1::option::borrow<address>(&v1) == arg2.platform_address, 0);
        assert!(arg0.minting_enabled, 1);
        assert!(!arg0.is_frozen, 13);
        assert!(!arg1.is_frozen, 21);
        assert!(v0 >= arg0.mint_start_time, 2);
        assert!(v0 <= arg0.mint_end_time, 3);
        if (arg1.max_supply > 0) {
            assert!(arg1.current_supply < arg1.max_supply, 19);
        };
        if (arg0.max_per_wallet > 0) {
            assert!(get_master_wallet_mints(arg1, arg3) + 1 <= arg0.max_per_wallet, 5);
        };
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg4) >= arg0.mint_price, 6);
        let v2 = 0x2::coin::into_balance<0x2::sui::SUI>(arg4);
        if (arg0.mint_price > 0) {
            let v3 = 0x2::balance::split<0x2::sui::SUI>(&mut v2, arg0.mint_price);
            if (arg0.platform_fee_bps > 0) {
                let v4 = arg0.mint_price * arg0.platform_fee_bps / 10000;
                if (v4 > 0) {
                    0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v3, v4), arg6), arg0.platform_fee_recipient);
                };
            };
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, v3);
        };
        if (0x2::balance::value<0x2::sui::SUI>(&v2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v2, arg6), 0x2::tx_context::sender(arg6));
        } else {
            0x2::balance::destroy_zero<0x2::sui::SUI>(v2);
        };
        mint_edition_internal(arg0, arg1, arg3, arg6);
    }

    public entry fun mint_edition_batch(arg0: &mut EditionCollection, arg1: &mut MasterEdition, arg2: &PlatformMintCap, arg3: address, arg4: u64, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg6);
        assert!(arg4 > 0, 7);
        assert!(arg2.collection_id == 0x2::object::uid_to_inner(&arg0.id), 0);
        assert!(arg1.collection_id == 0x2::object::uid_to_inner(&arg0.id), 0);
        let v1 = 0x2::tx_context::sponsor(arg7);
        assert!(0x1::option::is_some<address>(&v1), 0);
        assert!(*0x1::option::borrow<address>(&v1) == arg2.platform_address, 0);
        assert!(arg0.minting_enabled, 1);
        assert!(!arg0.is_frozen, 13);
        assert!(!arg1.is_frozen, 21);
        assert!(v0 >= arg0.mint_start_time, 2);
        assert!(v0 <= arg0.mint_end_time, 3);
        if (arg1.max_supply > 0) {
            assert!(arg1.current_supply + arg4 <= arg1.max_supply, 19);
        };
        if (arg0.max_per_wallet > 0) {
            assert!(get_master_wallet_mints(arg1, arg3) + arg4 <= arg0.max_per_wallet, 5);
        };
        let v2 = arg0.mint_price * arg4;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg5) >= v2, 6);
        let v3 = 0x2::coin::into_balance<0x2::sui::SUI>(arg5);
        if (v2 > 0) {
            let v4 = 0x2::balance::split<0x2::sui::SUI>(&mut v3, v2);
            if (arg0.platform_fee_bps > 0) {
                let v5 = v2 * arg0.platform_fee_bps / 10000;
                if (v5 > 0) {
                    0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v4, v5), arg7), arg0.platform_fee_recipient);
                };
            };
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, v4);
        };
        if (0x2::balance::value<0x2::sui::SUI>(&v3) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v3, arg7), 0x2::tx_context::sender(arg7));
        } else {
            0x2::balance::destroy_zero<0x2::sui::SUI>(v3);
        };
        let v6 = 0;
        while (v6 < arg4) {
            mint_edition_internal(arg0, arg1, arg3, arg7);
            v6 = v6 + 1;
        };
    }

    fun mint_edition_internal(arg0: &mut EditionCollection, arg1: &mut MasterEdition, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.current_supply = arg1.current_supply + 1;
        let v0 = arg1.current_supply;
        update_master_wallet_mints(arg1, arg2, 1);
        arg0.total_editions_minted = arg0.total_editions_minted + 1;
        let v1 = 0x2::object::new(arg3);
        let v2 = 0x2::object::uid_to_inner(&arg0.id);
        let v3 = 0x2::object::uid_to_inner(&arg1.id);
        let v4 = EditionNFT{
            id             : v1,
            name           : build_edition_name(&arg0.name, arg1.token_id, v0, arg1.max_supply),
            description    : arg0.description,
            token_id       : arg1.token_id,
            edition_number : v0,
            uri            : arg1.uri,
            image_uri      : arg1.image_uri,
            collection_id  : v2,
            master_id      : v3,
            attributes     : arg1.attributes,
            is_frozen      : false,
            is_soulbound   : arg0.is_soulbound,
        };
        let v5 = EditionMinted{
            collection_id  : v2,
            master_id      : v3,
            edition_id     : 0x2::object::uid_to_inner(&v1),
            token_id       : arg1.token_id,
            edition_number : v0,
            minter         : arg2,
            price_paid     : arg0.mint_price,
        };
        0x2::event::emit<EditionMinted>(v5);
        0x2::transfer::public_transfer<EditionNFT>(v4, arg2);
    }

    public entry fun place_in_kiosk(arg0: EditionNFT, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: &0x2::transfer_policy::TransferPolicy<EditionNFT>, arg4: &0x2::tx_context::TxContext) {
        assert!(!arg0.is_frozen, 10);
        assert!(!arg0.is_soulbound, 16);
        0x2::kiosk::lock<EditionNFT>(arg1, arg2, arg3, arg0);
        let v0 = EditionPlacedInKiosk{
            nft_id   : 0x2::object::id<EditionNFT>(&arg0),
            kiosk_id : 0x2::object::id<0x2::kiosk::Kiosk>(arg1),
            owner    : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<EditionPlacedInKiosk>(v0);
    }

    public entry fun platform_add_dynamic_field_string(arg0: &EditionCollection, arg1: &mut EditionNFT, arg2: &PlatformAdminCap, arg3: vector<u8>, arg4: vector<u8>) {
        assert!(arg0.is_mutable, 10);
        let v0 = 0x1::string::utf8(arg3);
        assert!(!0x2::dynamic_field::exists_<0x1::string::String>(&arg1.id, v0), 23);
        0x2::dynamic_field::add<0x1::string::String, 0x1::string::String>(&mut arg1.id, v0, 0x1::string::utf8(arg4));
    }

    public entry fun platform_add_dynamic_field_u64(arg0: &EditionCollection, arg1: &mut EditionNFT, arg2: &PlatformAdminCap, arg3: vector<u8>, arg4: u64) {
        assert!(arg0.is_mutable, 10);
        let v0 = 0x1::string::utf8(b"u64:");
        0x1::string::append(&mut v0, 0x1::string::utf8(arg3));
        assert!(!0x2::dynamic_field::exists_<0x1::string::String>(&arg1.id, v0), 23);
        0x2::dynamic_field::add<0x1::string::String, u64>(&mut arg1.id, v0, arg4);
    }

    public entry fun platform_add_edition_attribute(arg0: &EditionCollection, arg1: &mut EditionNFT, arg2: &PlatformAdminCap, arg3: vector<u8>, arg4: vector<u8>) {
        assert!(arg0.is_mutable, 10);
        let v0 = 0x1::string::utf8(arg3);
        if (0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(&arg1.attributes, &v0)) {
            let (_, _) = 0x2::vec_map::remove<0x1::string::String, 0x1::string::String>(&mut arg1.attributes, &v0);
        };
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut arg1.attributes, v0, 0x1::string::utf8(arg4));
    }

    public entry fun platform_force_withdraw(arg0: &mut EditionCollection, arg1: &PlatformAdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.balance);
        assert!(v0 > 0, 6);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, v0), arg2), arg0.payment_recipient);
        let v1 = PaymentWithdrawn{
            collection_id : 0x2::object::uid_to_inner(&arg0.id),
            amount        : v0,
            recipient     : arg0.payment_recipient,
        };
        0x2::event::emit<PaymentWithdrawn>(v1);
    }

    public entry fun platform_mint_edition_to_kiosk(arg0: &PlatformAdminCap, arg1: &mut EditionCollection, arg2: &mut MasterEdition, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: &0x2::transfer_policy::TransferPolicy<EditionNFT>, arg6: address, arg7: vector<vector<u8>>, arg8: vector<vector<u8>>, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.is_frozen, 13);
        assert!(!arg2.is_frozen, 21);
        assert!(arg2.collection_id == 0x2::object::uid_to_inner(&arg1.id), 0);
        if (arg2.max_supply > 0) {
            assert!(arg2.current_supply < arg2.max_supply, 19);
        };
        if (arg1.max_per_wallet > 0) {
            assert!(get_master_wallet_mints(arg2, arg6) + 1 <= arg1.max_per_wallet, 5);
        };
        let v0 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<vector<u8>>(&arg7)) {
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(*0x1::vector::borrow<vector<u8>>(&arg7, v1)), 0x1::string::utf8(*0x1::vector::borrow<vector<u8>>(&arg8, v1)));
            v1 = v1 + 1;
        };
        arg2.current_supply = arg2.current_supply + 1;
        let v2 = arg2.current_supply;
        update_master_wallet_mints(arg2, arg6, 1);
        let v3 = if (arg1.is_revealed) {
            arg2.uri
        } else {
            arg1.placeholder_uri
        };
        let v4 = EditionNFT{
            id             : 0x2::object::new(arg9),
            name           : build_edition_name(&arg1.name, arg2.token_id, v2, arg2.max_supply),
            description    : arg1.description,
            token_id       : arg2.token_id,
            edition_number : v2,
            uri            : v3,
            image_uri      : arg2.image_uri,
            collection_id  : 0x2::object::uid_to_inner(&arg1.id),
            master_id      : 0x2::object::uid_to_inner(&arg2.id),
            attributes     : v0,
            is_frozen      : false,
            is_soulbound   : arg1.is_soulbound,
        };
        arg1.total_editions_minted = arg1.total_editions_minted + 1;
        0x2::kiosk::lock<EditionNFT>(arg3, arg4, arg5, v4);
        let v5 = EditionMintedToKiosk{
            collection_id  : 0x2::object::uid_to_inner(&arg1.id),
            nft_id         : 0x2::object::id<EditionNFT>(&v4),
            token_id       : arg2.token_id,
            edition_number : v2,
            kiosk_id       : 0x2::object::id<0x2::kiosk::Kiosk>(arg3),
            recipient      : arg6,
        };
        0x2::event::emit<EditionMintedToKiosk>(v5);
    }

    public entry fun platform_remove_dynamic_field_string(arg0: &EditionCollection, arg1: &mut EditionNFT, arg2: &PlatformAdminCap, arg3: vector<u8>) {
        assert!(arg0.is_mutable, 10);
        let v0 = 0x1::string::utf8(arg3);
        assert!(0x2::dynamic_field::exists_<0x1::string::String>(&arg1.id, v0), 22);
        0x2::dynamic_field::remove<0x1::string::String, 0x1::string::String>(&mut arg1.id, v0);
    }

    public entry fun platform_remove_dynamic_field_u64(arg0: &EditionCollection, arg1: &mut EditionNFT, arg2: &PlatformAdminCap, arg3: vector<u8>) {
        assert!(arg0.is_mutable, 10);
        let v0 = 0x1::string::utf8(b"u64:");
        0x1::string::append(&mut v0, 0x1::string::utf8(arg3));
        assert!(0x2::dynamic_field::exists_<0x1::string::String>(&arg1.id, v0), 22);
        0x2::dynamic_field::remove<0x1::string::String, u64>(&mut arg1.id, v0);
    }

    public entry fun platform_remove_edition_attribute(arg0: &EditionCollection, arg1: &mut EditionNFT, arg2: &PlatformAdminCap, arg3: vector<u8>) {
        assert!(arg0.is_mutable, 10);
        let v0 = 0x1::string::utf8(arg3);
        if (0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(&arg1.attributes, &v0)) {
            let (_, _) = 0x2::vec_map::remove<0x1::string::String, 0x1::string::String>(&mut arg1.attributes, &v0);
        };
    }

    public entry fun platform_set_payment_recipient(arg0: &mut EditionCollection, arg1: &PlatformAdminCap, arg2: address) {
        arg0.payment_recipient = arg2;
    }

    public entry fun platform_set_platform_fee(arg0: &mut EditionCollection, arg1: &PlatformAdminCap, arg2: address, arg3: u64) {
        assert!(arg3 <= 1000, 11);
        arg0.platform_fee_recipient = arg2;
        arg0.platform_fee_bps = arg3;
    }

    public entry fun platform_set_royalty(arg0: &mut EditionCollection, arg1: &PlatformAdminCap, arg2: address, arg3: u64) {
        assert!(arg3 <= 10000, 11);
        arg0.royalty_recipient = arg2;
        arg0.royalty_bps = arg3;
    }

    public entry fun platform_update_collection_base_uri(arg0: &mut EditionCollection, arg1: &PlatformAdminCap, arg2: vector<u8>) {
        assert!(arg0.is_mutable, 10);
        arg0.base_uri = 0x1::string::utf8(arg2);
    }

    public entry fun platform_update_collection_metadata(arg0: &mut EditionCollection, arg1: &PlatformAdminCap, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>) {
        assert!(arg0.is_mutable, 10);
        arg0.name = 0x1::string::utf8(arg2);
        arg0.description = 0x1::string::utf8(arg3);
        arg0.image_uri = 0x1::string::utf8(arg4);
    }

    public entry fun platform_update_dynamic_field_string(arg0: &EditionCollection, arg1: &mut EditionNFT, arg2: &PlatformAdminCap, arg3: vector<u8>, arg4: vector<u8>) {
        assert!(arg0.is_mutable, 10);
        let v0 = 0x1::string::utf8(arg3);
        assert!(0x2::dynamic_field::exists_<0x1::string::String>(&arg1.id, v0), 22);
        *0x2::dynamic_field::borrow_mut<0x1::string::String, 0x1::string::String>(&mut arg1.id, v0) = 0x1::string::utf8(arg4);
    }

    public entry fun platform_update_dynamic_field_u64(arg0: &EditionCollection, arg1: &mut EditionNFT, arg2: &PlatformAdminCap, arg3: vector<u8>, arg4: u64) {
        assert!(arg0.is_mutable, 10);
        let v0 = 0x1::string::utf8(b"u64:");
        0x1::string::append(&mut v0, 0x1::string::utf8(arg3));
        assert!(0x2::dynamic_field::exists_<0x1::string::String>(&arg1.id, v0), 22);
        *0x2::dynamic_field::borrow_mut<0x1::string::String, u64>(&mut arg1.id, v0) = arg4;
    }

    public entry fun platform_update_edition_metadata(arg0: &EditionCollection, arg1: &mut EditionNFT, arg2: &PlatformAdminCap, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>) {
        assert!(arg0.is_mutable, 10);
        arg1.name = 0x1::string::utf8(arg3);
        arg1.description = 0x1::string::utf8(arg4);
        arg1.uri = 0x1::string::utf8(arg5);
        arg1.image_uri = 0x1::string::utf8(arg6);
    }

    public fun purchase_from_kiosk(arg0: &mut 0x2::kiosk::Kiosk, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<0x2::sui::SUI>) : (EditionNFT, 0x2::transfer_policy::TransferRequest<EditionNFT>) {
        0x2::kiosk::purchase<EditionNFT>(arg0, arg1, arg2)
    }

    public entry fun remove_dynamic_field_string(arg0: &EditionCollection, arg1: &mut EditionNFT, arg2: &CollectionAdminCap, arg3: vector<u8>) {
        assert!(arg0.is_mutable, 10);
        let v0 = 0x1::string::utf8(arg3);
        assert!(0x2::dynamic_field::exists_<0x1::string::String>(&arg1.id, v0), 22);
        0x2::dynamic_field::remove<0x1::string::String, 0x1::string::String>(&mut arg1.id, v0);
    }

    public entry fun remove_dynamic_field_u64(arg0: &EditionCollection, arg1: &mut EditionNFT, arg2: &CollectionAdminCap, arg3: vector<u8>) {
        assert!(arg0.is_mutable, 10);
        let v0 = 0x1::string::utf8(b"u64:");
        0x1::string::append(&mut v0, 0x1::string::utf8(arg3));
        assert!(0x2::dynamic_field::exists_<0x1::string::String>(&arg1.id, v0), 22);
        0x2::dynamic_field::remove<0x1::string::String, u64>(&mut arg1.id, v0);
    }

    public entry fun remove_edition_attribute(arg0: &EditionCollection, arg1: &mut EditionNFT, arg2: &CollectionAdminCap, arg3: vector<u8>) {
        assert!(arg0.is_mutable, 10);
        let v0 = 0x1::string::utf8(arg3);
        if (0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(&arg1.attributes, &v0)) {
            let (_, _) = 0x2::vec_map::remove<0x1::string::String, 0x1::string::String>(&mut arg1.attributes, &v0);
        };
    }

    public entry fun remove_master_attribute(arg0: &mut MasterEdition, arg1: &CollectionAdminCap, arg2: vector<u8>) {
        let v0 = 0x1::string::utf8(arg2);
        if (0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(&arg0.attributes, &v0)) {
            let (_, _) = 0x2::vec_map::remove<0x1::string::String, 0x1::string::String>(&mut arg0.attributes, &v0);
        };
    }

    public entry fun rent_edition(arg0: &mut EditionNFT, arg1: u64, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::dynamic_field::exists_<0x1::string::String>(&arg0.id, 0x1::string::utf8(b"_rental_info")), 25);
        let v0 = 0x1::string::utf8(b"_rental_end");
        if (0x2::dynamic_field::exists_<0x1::string::String>(&arg0.id, v0)) {
            assert!(0x2::clock::timestamp_ms(arg3) / 1000 >= *0x2::dynamic_field::borrow<0x1::string::String, u64>(&arg0.id, v0), 24);
        };
        let v1 = 0x1::string::utf8(b"_rental_price");
        let v2 = if (0x2::dynamic_field::exists_<0x1::string::String>(&arg0.id, v1)) {
            *0x2::dynamic_field::borrow<0x1::string::String, u64>(&arg0.id, v1)
        } else {
            0
        };
        let v3 = 0x1::string::utf8(b"_rental_min_days");
        let v4 = 0x1::string::utf8(b"_rental_max_days");
        if (0x2::dynamic_field::exists_<0x1::string::String>(&arg0.id, v3)) {
            assert!(arg1 >= *0x2::dynamic_field::borrow<0x1::string::String, u64>(&arg0.id, v3), 7);
        };
        if (0x2::dynamic_field::exists_<0x1::string::String>(&arg0.id, v4)) {
            let v5 = *0x2::dynamic_field::borrow<0x1::string::String, u64>(&arg0.id, v4);
            if (v5 > 0) {
                assert!(arg1 <= v5, 7);
            };
        };
        let v6 = v2 * arg1;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= v6, 6);
        let v7 = 0x2::tx_context::sender(arg4);
        let v8 = 0x2::clock::timestamp_ms(arg3) / 1000 + arg1 * 86400;
        let v9 = 0x1::string::utf8(b"_rental_renter");
        if (0x2::dynamic_field::exists_<0x1::string::String>(&arg0.id, v9)) {
            *0x2::dynamic_field::borrow_mut<0x1::string::String, address>(&mut arg0.id, v9) = v7;
        } else {
            0x2::dynamic_field::add<0x1::string::String, address>(&mut arg0.id, v9, v7);
        };
        if (0x2::dynamic_field::exists_<0x1::string::String>(&arg0.id, v0)) {
            *0x2::dynamic_field::borrow_mut<0x1::string::String, u64>(&mut arg0.id, v0) = v8;
        } else {
            0x2::dynamic_field::add<0x1::string::String, u64>(&mut arg0.id, v0, v8);
        };
        let v10 = *0x2::dynamic_field::borrow<0x1::string::String, address>(&arg0.id, 0x1::string::utf8(b"_rental_owner"));
        let v11 = 0x2::coin::into_balance<0x2::sui::SUI>(arg2);
        if (v6 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v11, v6), arg4), v10);
        };
        if (0x2::balance::value<0x2::sui::SUI>(&v11) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v11, arg4), v7);
        } else {
            0x2::balance::destroy_zero<0x2::sui::SUI>(v11);
        };
        let v12 = EditionRented{
            edition_id  : 0x2::object::uid_to_inner(&arg0.id),
            owner       : v10,
            renter      : v7,
            rental_end  : v8,
            total_price : v6,
        };
        0x2::event::emit<EditionRented>(v12);
    }

    public entry fun reveal_collection(arg0: &mut EditionCollection, arg1: &CollectionAdminCap, arg2: vector<u8>) {
        assert!(arg0.is_mutable, 10);
        assert!(!arg0.is_revealed, 15);
        arg0.base_uri = 0x1::string::utf8(arg2);
        arg0.is_revealed = true;
        let v0 = CollectionRevealed{
            collection_id : 0x2::object::uid_to_inner(&arg0.id),
            new_base_uri  : 0x1::string::utf8(arg2),
        };
        0x2::event::emit<CollectionRevealed>(v0);
    }

    public entry fun set_base_uri(arg0: &mut EditionCollection, arg1: &CollectionAdminCap, arg2: vector<u8>) {
        assert!(arg0.is_mutable, 10);
        arg0.base_uri = 0x1::string::utf8(arg2);
    }

    public entry fun set_edition_frozen(arg0: &mut EditionNFT, arg1: &CollectionAdminCap, arg2: bool) {
        arg0.is_frozen = arg2;
        let v0 = EditionFrozenEvent{
            edition_id : 0x2::object::uid_to_inner(&arg0.id),
            frozen     : arg2,
        };
        0x2::event::emit<EditionFrozenEvent>(v0);
    }

    public entry fun set_master_uri(arg0: &mut MasterEdition, arg1: &CollectionAdminCap, arg2: vector<u8>, arg3: vector<u8>) {
        arg0.uri = 0x1::string::utf8(arg2);
        arg0.image_uri = 0x1::string::utf8(arg3);
        let v0 = MasterURIUpdated{
            master_id : 0x2::object::uid_to_inner(&arg0.id),
            new_uri   : 0x1::string::utf8(arg2),
        };
        0x2::event::emit<MasterURIUpdated>(v0);
    }

    public entry fun set_max_per_wallet(arg0: &mut EditionCollection, arg1: &CollectionAdminCap, arg2: u64) {
        arg0.max_per_wallet = arg2;
    }

    public entry fun set_mint_price(arg0: &mut EditionCollection, arg1: &CollectionAdminCap, arg2: u64) {
        arg0.mint_price = arg2;
        let v0 = MintPriceUpdated{
            collection_id : 0x2::object::uid_to_inner(&arg0.id),
            new_price     : arg2,
        };
        0x2::event::emit<MintPriceUpdated>(v0);
    }

    public entry fun set_mint_times(arg0: &mut EditionCollection, arg1: &CollectionAdminCap, arg2: u64, arg3: u64) {
        arg0.mint_start_time = arg2;
        arg0.mint_end_time = arg3;
    }

    public entry fun set_minting_enabled(arg0: &mut EditionCollection, arg1: &CollectionAdminCap, arg2: bool) {
        arg0.minting_enabled = arg2;
        let v0 = MintingToggled{
            collection_id : 0x2::object::uid_to_inner(&arg0.id),
            enabled       : arg2,
        };
        0x2::event::emit<MintingToggled>(v0);
    }

    public entry fun set_payment_recipient(arg0: &mut EditionCollection, arg1: &CollectionAdminCap, arg2: address) {
        arg0.payment_recipient = arg2;
    }

    public entry fun set_royalty(arg0: &mut EditionCollection, arg1: &CollectionAdminCap, arg2: address, arg3: u64) {
        assert!(arg3 <= 10000, 11);
        arg0.royalty_recipient = arg2;
        arg0.royalty_bps = arg3;
    }

    public entry fun transfer_admin_cap(arg0: CollectionAdminCap, arg1: address, arg2: &0x2::tx_context::TxContext) {
        let v0 = AdminCapTransferred{
            collection_id : arg0.collection_id,
            from          : 0x2::tx_context::sender(arg2),
            to            : arg1,
        };
        0x2::event::emit<AdminCapTransferred>(v0);
        0x2::transfer::transfer<CollectionAdminCap>(arg0, arg1);
    }

    public entry fun transfer_edition_with_provenance(arg0: EditionNFT, arg1: address, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(!arg0.is_frozen, 10);
        assert!(!arg0.is_soulbound, 16);
        let v0 = 0x1::string::utf8(b"_rental_end");
        if (0x2::dynamic_field::exists_<0x1::string::String>(&arg0.id, v0)) {
            assert!(0x2::clock::timestamp_ms(arg2) / 1000 >= *0x2::dynamic_field::borrow<0x1::string::String, u64>(&arg0.id, v0), 24);
        };
        let v1 = EditionTransferred{
            edition_id : 0x2::object::uid_to_inner(&arg0.id),
            from       : 0x2::tx_context::sender(arg3),
            to         : arg1,
            timestamp  : 0x2::clock::timestamp_ms(arg2) / 1000,
        };
        0x2::event::emit<EditionTransferred>(v1);
        0x2::transfer::public_transfer<EditionNFT>(arg0, arg1);
    }

    public entry fun treasury_mint_edition(arg0: &mut EditionCollection, arg1: &mut MasterEdition, arg2: &CollectionAdminCap, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.is_frozen, 13);
        assert!(!arg1.is_frozen, 21);
        assert!(arg0.treasury_minted < arg0.treasury_reserve, 20);
        if (arg1.max_supply > 0) {
            assert!(arg1.current_supply < arg1.max_supply, 19);
        };
        arg0.treasury_minted = arg0.treasury_minted + 1;
        mint_edition_internal(arg0, arg1, arg3, arg4);
    }

    public entry fun treasury_mint_edition_batch(arg0: &mut EditionCollection, arg1: &mut MasterEdition, arg2: &CollectionAdminCap, arg3: vector<address>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg3)) {
            treasury_mint_edition(arg0, arg1, arg2, *0x1::vector::borrow<address>(&arg3, v0), arg4);
            v0 = v0 + 1;
        };
    }

    fun u64_to_string(arg0: u64) : 0x1::string::String {
        if (arg0 == 0) {
            return 0x1::string::utf8(b"0")
        };
        let v0 = 0x1::vector::empty<u8>();
        while (arg0 > 0) {
            0x1::vector::push_back<u8>(&mut v0, ((arg0 % 10) as u8) + 48);
            arg0 = arg0 / 10;
        };
        0x1::vector::reverse<u8>(&mut v0);
        0x1::string::utf8(v0)
    }

    public entry fun unfreeze_master(arg0: &mut MasterEdition, arg1: &CollectionAdminCap) {
        arg0.is_frozen = false;
        let v0 = MasterFrozenEvent{
            master_id : 0x2::object::uid_to_inner(&arg0.id),
            frozen    : false,
        };
        0x2::event::emit<MasterFrozenEvent>(v0);
    }

    public entry fun update_dynamic_field_string(arg0: &EditionCollection, arg1: &mut EditionNFT, arg2: &CollectionAdminCap, arg3: vector<u8>, arg4: vector<u8>) {
        assert!(arg0.is_mutable, 10);
        let v0 = 0x1::string::utf8(arg3);
        assert!(0x2::dynamic_field::exists_<0x1::string::String>(&arg1.id, v0), 22);
        *0x2::dynamic_field::borrow_mut<0x1::string::String, 0x1::string::String>(&mut arg1.id, v0) = 0x1::string::utf8(arg4);
    }

    public entry fun update_dynamic_field_u64(arg0: &EditionCollection, arg1: &mut EditionNFT, arg2: &CollectionAdminCap, arg3: vector<u8>, arg4: u64) {
        assert!(arg0.is_mutable, 10);
        let v0 = 0x1::string::utf8(b"u64:");
        0x1::string::append(&mut v0, 0x1::string::utf8(arg3));
        assert!(0x2::dynamic_field::exists_<0x1::string::String>(&arg1.id, v0), 22);
        *0x2::dynamic_field::borrow_mut<0x1::string::String, u64>(&mut arg1.id, v0) = arg4;
    }

    public entry fun update_edition_metadata(arg0: &EditionCollection, arg1: &mut EditionNFT, arg2: &CollectionAdminCap, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>) {
        assert!(arg0.is_mutable, 10);
        arg1.name = 0x1::string::utf8(arg3);
        arg1.description = 0x1::string::utf8(arg4);
        arg1.uri = 0x1::string::utf8(arg5);
        arg1.image_uri = 0x1::string::utf8(arg6);
    }

    fun update_master_wallet_mints(arg0: &mut MasterEdition, arg1: address, arg2: u64) {
        if (0x2::vec_map::contains<address, u64>(&arg0.mints_per_wallet, &arg1)) {
            let v0 = 0x2::vec_map::get_mut<address, u64>(&mut arg0.mints_per_wallet, &arg1);
            *v0 = *v0 + arg2;
        } else {
            0x2::vec_map::insert<address, u64>(&mut arg0.mints_per_wallet, arg1, arg2);
        };
    }

    public entry fun withdraw_payments(arg0: &mut EditionCollection, arg1: &CollectionAdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.balance);
        assert!(v0 > 0, 6);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, v0), arg2), arg0.payment_recipient);
        let v1 = PaymentWithdrawn{
            collection_id : 0x2::object::uid_to_inner(&arg0.id),
            amount        : v0,
            recipient     : arg0.payment_recipient,
        };
        0x2::event::emit<PaymentWithdrawn>(v1);
    }

    // decompiled from Move bytecode v6
}

