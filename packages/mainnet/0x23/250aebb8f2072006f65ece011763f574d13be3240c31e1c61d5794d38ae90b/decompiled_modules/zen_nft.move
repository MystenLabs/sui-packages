module 0x23250aebb8f2072006f65ece011763f574d13be3240c31e1c61d5794d38ae90b::zen_nft {
    struct ZEN_NFT has drop {
        dummy_field: bool,
    }

    struct NFTMinted has copy, drop {
        nft_object_id: 0x2::object::ID,
        nft_id: u64,
        creator: address,
    }

    struct NFTVoted has copy, drop {
        nft_object_id: 0x2::object::ID,
        nft_id: u64,
        voter: address,
        amount: u64,
    }

    struct NFTVoteWithdrawn has copy, drop {
        nft_object_id: 0x2::object::ID,
        nft_id: u64,
        voter: address,
        amount: u64,
    }

    struct NFTTransferred has copy, drop {
        nft_object_id: 0x2::object::ID,
        nft_id: u64,
        from: address,
        to: address,
    }

    struct NFTStorage has store, key {
        id: 0x2::object::UID,
        nfts: 0x2::linked_table::LinkedTable<0x2::object::ID, 0x2::object::ID>,
        owners: 0x2::table::Table<address, u64>,
        airdrop: 0x2::table::Table<address, bool>,
    }

    struct NFT has store, key {
        id: 0x2::object::UID,
        nft_id: u64,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        url: 0x1::string::String,
        walrus_id: 0x1::string::String,
        metadata_uri: 0x1::string::String,
        hash: 0x1::string::String,
        creator: address,
        treasury: 0x2::object::ID,
        is_revealed: bool,
    }

    struct NFTTreasury<phantom T0: drop> has store, key {
        id: 0x2::object::UID,
        nft_id: u64,
        nft_object_id: 0x2::object::ID,
        stakers: 0x2::table::Table<address, 0x2::balance::Balance<T0>>,
    }

    struct OptionsStorage has store, key {
        id: 0x2::object::UID,
        admin: address,
        escrow_address: address,
        escrow_fee: u64,
        max_amount: u64,
        stage_name: 0x1::string::String,
        stage_price: u64,
        stage_quantity_per_wallet: u64,
        mint_enabled: bool,
        voting_enabled: bool,
        only_airdrop_mint: bool,
    }

    struct ProfileStorage has key {
        id: 0x2::object::UID,
        profiles: 0x2::table::Table<address, Profile>,
    }

    struct Profile has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image: 0x1::string::String,
        address: address,
    }

    fun assert_is_zen_coin<T0>() {
        assert!(0x1::type_name::into_string(0x1::type_name::get<T0>()) == 0x1::ascii::string(b"0x2::coin::Coin<0x2665dc784c7ff17fddba2442b36cb8b2bbc8adfa9fe08794fd941d80ef2758ec::zen::ZEN>"), 4);
    }

    public fun bulk_add_to_airdrop(arg0: &mut NFTStorage, arg1: vector<address>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg1)) {
            let v1 = *0x1::vector::borrow<address>(&arg1, v0);
            if (!0x2::table::contains<address, bool>(&arg0.airdrop, v1)) {
                0x2::table::add<address, bool>(&mut arg0.airdrop, v1, true);
            };
            v0 = v0 + 1;
        };
    }

    public fun bulk_remove_from_airdrop(arg0: &mut NFTStorage, arg1: vector<address>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg1)) {
            let v1 = *0x1::vector::borrow<address>(&arg1, v0);
            if (0x2::table::contains<address, bool>(&arg0.airdrop, v1)) {
                0x2::table::remove<address, bool>(&mut arg0.airdrop, v1);
            };
            v0 = v0 + 1;
        };
    }

    fun create_config(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = OptionsStorage{
            id                        : 0x2::object::new(arg0),
            admin                     : 0x2::tx_context::sender(arg0),
            escrow_address            : @0x323cc3aa9021e44210877e67639456da0c4cce72ebf14c3f185caf33197f0e10,
            escrow_fee                : 25,
            max_amount                : 3333,
            stage_name                : 0x1::string::utf8(b"Initial Stage"),
            stage_price               : 5,
            stage_quantity_per_wallet : 1,
            mint_enabled              : false,
            voting_enabled            : false,
            only_airdrop_mint         : true,
        };
        0x2::transfer::share_object<OptionsStorage>(v0);
    }

    fun create_nft_storage(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = NFTStorage{
            id      : 0x2::object::new(arg0),
            nfts    : 0x2::linked_table::new<0x2::object::ID, 0x2::object::ID>(arg0),
            owners  : 0x2::table::new<address, u64>(arg0),
            airdrop : 0x2::table::new<address, bool>(arg0),
        };
        0x2::transfer::share_object<NFTStorage>(v0);
    }

    fun create_profile_storage(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ProfileStorage{
            id       : 0x2::object::new(arg0),
            profiles : 0x2::table::new<address, Profile>(arg0),
        };
        0x2::transfer::share_object<ProfileStorage>(v0);
    }

    public fun get_minted_count(arg0: &NFTStorage) : u64 {
        0x2::linked_table::length<0x2::object::ID, 0x2::object::ID>(&arg0.nfts)
    }

    public fun get_options(arg0: &OptionsStorage) : (address, u64, u64, u64, 0x1::string::String, u64, bool, bool, bool) {
        (arg0.escrow_address, arg0.escrow_fee, arg0.max_amount, arg0.stage_price, arg0.stage_name, arg0.stage_quantity_per_wallet, arg0.mint_enabled, arg0.voting_enabled, arg0.only_airdrop_mint)
    }

    public fun get_profile(arg0: &ProfileStorage, arg1: address) : (0x1::string::String, 0x1::string::String, 0x1::string::String, address) {
        let v0 = 0x2::table::borrow<address, Profile>(&arg0.profiles, arg1);
        (v0.name, v0.description, v0.image, v0.address)
    }

    fun init(arg0: ZEN_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        create_config(arg1);
        create_nft_storage(arg1);
        create_profile_storage(arg1);
        let v0 = 0x2::package::claim<ZEN_NFT>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"hash"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"creator"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://zenfrogs.com/nft/{id}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{hash}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{url}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://zenfrogs.com/"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{creator}"));
        let v5 = 0x2::display::new_with_fields<NFT>(&v0, v1, v3, arg1);
        0x2::display::update_version<NFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::display::Display<NFT>>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun is_revealed(arg0: &NFT) : bool {
        arg0.is_revealed
    }

    public fun mint_nft<T0: drop>(arg0: &mut NFTStorage, arg1: &OptionsStorage, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        assert_is_zen_coin<T0>();
        let v0 = 0x2::tx_context::sender(arg3);
        if (arg1.only_airdrop_mint) {
            assert!(0x2::table::contains<address, bool>(&arg0.airdrop, v0), 1);
        };
        assert!(arg1.mint_enabled == true, 1);
        assert!(0x2::coin::value<T0>(&arg2) >= arg1.stage_price, 5);
        assert!(0x2::linked_table::length<0x2::object::ID, 0x2::object::ID>(&arg0.nfts) + 1 <= arg1.max_amount, 3);
        if (0x2::table::contains<address, u64>(&arg0.owners, v0)) {
            let v1 = 0x2::table::borrow_mut<address, u64>(&mut arg0.owners, v0);
            assert!(*v1 + 1 <= arg1.stage_quantity_per_wallet, 3);
            *v1 = *v1 + 1;
        } else {
            0x2::table::add<address, u64>(&mut arg0.owners, v0, 1);
        };
        let v2 = 0x2::linked_table::length<0x2::object::ID, 0x2::object::ID>(&arg0.nfts) + 1;
        assert!(v2 <= arg1.max_amount, 3);
        let v3 = NFTTreasury<T0>{
            id            : 0x2::object::new(arg3),
            nft_id        : v2,
            nft_object_id : 0x2::object::id<NFTStorage>(arg0),
            stakers       : 0x2::table::new<address, 0x2::balance::Balance<T0>>(arg3),
        };
        let v4 = 0x2::object::uid_to_inner(&v3.id);
        let v5 = NFT{
            id           : 0x2::object::new(arg3),
            nft_id       : v2,
            name         : 0x1::string::utf8(b"Unrevealed ZEN..."),
            description  : 0x1::string::utf8(b"..."),
            image_url    : 0x1::string::utf8(b"https://zenfrogs.com/zen-unrevealed.png"),
            url          : 0x1::string::utf8(b"https://zenfrogs.com/zen-unrevealed.png"),
            walrus_id    : 0x1::string::utf8(b"..."),
            metadata_uri : 0x1::string::utf8(b"..."),
            hash         : 0x1::string::utf8(b"..."),
            creator      : v0,
            treasury     : v4,
            is_revealed  : false,
        };
        let v6 = 0x2::object::uid_to_inner(&v5.id);
        v3.nft_object_id = v6;
        0x2::linked_table::push_back<0x2::object::ID, 0x2::object::ID>(&mut arg0.nfts, v6, v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, arg1.escrow_address);
        0x2::transfer::public_transfer<NFT>(v5, v0);
        0x2::transfer::public_share_object<NFTTreasury<T0>>(v3);
        let v7 = NFTMinted{
            nft_object_id : v6,
            nft_id        : v2,
            creator       : v0,
        };
        0x2::event::emit<NFTMinted>(v7);
    }

    public entry fun reveal(arg0: &mut NFT, arg1: &mut OptionsStorage, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg8) == arg1.admin, 1);
        arg0.name = 0x1::string::utf8(arg2);
        arg0.description = 0x1::string::utf8(arg3);
        arg0.hash = 0x1::string::utf8(arg4);
        arg0.image_url = 0x1::string::utf8(arg5);
        arg0.url = 0x1::string::utf8(arg5);
        arg0.walrus_id = 0x1::string::utf8(arg6);
        arg0.metadata_uri = 0x1::string::utf8(arg7);
        arg0.is_revealed = true;
    }

    public entry fun toggle_mint_enabled(arg0: &mut OptionsStorage, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 1);
        arg0.mint_enabled = !arg0.mint_enabled;
    }

    public entry fun toggle_voting_enabled(arg0: &mut OptionsStorage, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 1);
        arg0.voting_enabled = !arg0.voting_enabled;
    }

    public entry fun transfer_nft(arg0: NFT, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = NFTTransferred{
            nft_object_id : 0x2::object::uid_to_inner(&arg0.id),
            nft_id        : arg0.nft_id,
            from          : 0x2::tx_context::sender(arg2),
            to            : arg1,
        };
        0x2::event::emit<NFTTransferred>(v0);
        0x2::transfer::public_transfer<NFT>(arg0, arg1);
    }

    public entry fun update_nft_description(arg0: &mut NFT, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.description = 0x1::string::utf8(arg1);
    }

    entry fun update_options(arg0: &mut OptionsStorage, arg1: address, arg2: u64, arg3: u64, arg4: u64, arg5: vector<u8>, arg6: u64, arg7: bool, arg8: bool, arg9: bool, arg10: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg10) == arg0.admin, 1);
        arg0.escrow_address = arg1;
        arg0.escrow_fee = arg2;
        arg0.max_amount = arg3;
        arg0.stage_price = arg4;
        arg0.stage_name = 0x1::string::utf8(arg5);
        arg0.stage_quantity_per_wallet = arg6;
        arg0.mint_enabled = arg7;
        arg0.voting_enabled = arg8;
        arg0.only_airdrop_mint = arg9;
    }

    public entry fun update_profile(arg0: &mut ProfileStorage, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        if (0x2::table::contains<address, Profile>(&arg0.profiles, v0)) {
            let v1 = 0x2::table::borrow_mut<address, Profile>(&mut arg0.profiles, v0);
            v1.name = 0x1::string::utf8(arg1);
            v1.description = 0x1::string::utf8(arg2);
            v1.image = 0x1::string::utf8(arg3);
        } else {
            let v2 = Profile{
                id          : 0x2::object::new(arg4),
                name        : 0x1::string::utf8(arg1),
                description : 0x1::string::utf8(arg2),
                image       : 0x1::string::utf8(arg3),
                address     : v0,
            };
            0x2::table::add<address, Profile>(&mut arg0.profiles, v0, v2);
        };
    }

    public fun vote<T0: drop + store>(arg0: &mut NFTTreasury<T0>, arg1: &OptionsStorage, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        assert_is_zen_coin<T0>();
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(arg1.voting_enabled == true, 2);
        let v1 = 0x2::coin::into_balance<T0>(arg2);
        let v2 = 0x2::balance::value<T0>(&v1);
        assert!(v2 > 0, 6);
        if (0x2::table::contains<address, 0x2::balance::Balance<T0>>(&arg0.stakers, v0)) {
            0x2::balance::join<T0>(0x2::table::borrow_mut<address, 0x2::balance::Balance<T0>>(&mut arg0.stakers, v0), v1);
        } else {
            0x2::table::add<address, 0x2::balance::Balance<T0>>(&mut arg0.stakers, v0, v1);
        };
        let v3 = NFTVoted{
            nft_object_id : arg0.nft_object_id,
            nft_id        : arg0.nft_id,
            voter         : v0,
            amount        : v2,
        };
        0x2::event::emit<NFTVoted>(v3);
    }

    public fun withdraw_vote<T0: drop + store>(arg0: &mut NFTTreasury<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::table::contains<address, 0x2::balance::Balance<T0>>(&arg0.stakers, v0), 7);
        let v1 = 0x2::table::borrow_mut<address, 0x2::balance::Balance<T0>>(&mut arg0.stakers, v0);
        assert!(0x2::balance::value<T0>(v1) >= arg1, 6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v1, arg1), arg2), v0);
        if (0x2::balance::value<T0>(v1) == 0) {
            0x2::balance::destroy_zero<T0>(0x2::table::remove<address, 0x2::balance::Balance<T0>>(&mut arg0.stakers, v0));
        };
        let v2 = NFTVoteWithdrawn{
            nft_object_id : arg0.nft_object_id,
            nft_id        : arg0.nft_id,
            voter         : v0,
            amount        : arg1,
        };
        0x2::event::emit<NFTVoteWithdrawn>(v2);
    }

    // decompiled from Move bytecode v6
}

