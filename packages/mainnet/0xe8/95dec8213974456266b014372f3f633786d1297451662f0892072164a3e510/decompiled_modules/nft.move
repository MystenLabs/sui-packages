module 0x6916b60ae826f14b3e2d7aa9c7eaf491a489379e2357c2819f48dde75a45ab58::nft {
    struct Wallet<phantom T0> has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
    }

    struct Ticket has copy, drop {
        owner: address,
        amount: u64,
    }

    struct Collection has store, key {
        id: 0x2::object::UID,
        publisher: 0x2::object::ID,
        mbox: bool,
        owner: address,
        name: 0x1::string::String,
        image_url: 0x1::ascii::String,
        description: 0x1::string::String,
        project_url: 0x1::string::String,
        link: 0x1::string::String,
        token_index: u64,
        total_supply: u64,
        balance: u64,
    }

    struct Phaser<phantom T0> has store, key {
        id: 0x2::object::UID,
        publisher: 0x2::object::ID,
        collection: 0x2::object::ID,
        price: u64,
        per_sender_limit: u64,
        total_sender_limit: u64,
        total_supply: u64,
        minted_amount: u64,
        start_time: u64,
        end_time: u64,
        status: u8,
        user_minted: 0x2::table::Table<address, u64>,
        whitelist_merkle_roots: 0x2::table::Table<address, address>,
    }

    struct CubicNft has store, key {
        id: 0x2::object::UID,
        collection: 0x2::object::ID,
        opened: bool,
        creator: address,
        token_id: u64,
        name: 0x1::string::String,
        image_url: 0x2::url::Url,
        description: 0x1::string::String,
        project_url: 0x1::string::String,
        link: 0x1::string::String,
        attributes: vector<Attribute>,
    }

    struct Attribute has copy, drop, store {
        name: 0x1::string::String,
        value: 0x1::string::String,
    }

    struct Bet has store, key {
        id: 0x2::object::UID,
        user_addr: address,
        nft_ids: 0x2::table::Table<0x2::object::ID, bool>,
        guild_num: u64,
        bet_time: u64,
    }

    struct BetRound has store, key {
        id: 0x2::object::UID,
        start_time: u64,
        end_time: u64,
        winner_guild_num: u64,
        user_addrs: 0x2::table::Table<address, bool>,
        bets: 0x2::table::Table<u64, Bet>,
        winners: 0x2::table::Table<address, bool>,
    }

    struct Registry has key {
        id: 0x2::object::UID,
        collection: 0x2::object::ID,
        status: bool,
        operators: vector<address>,
        bet_rounds: 0x2::table::Table<u64, BetRound>,
        betted_image_url: 0x2::url::Url,
    }

    struct CreateWalletEvent has copy, drop {
        wallet: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        publisher: 0x2::object::ID,
    }

    struct CreateCollectionEvent has copy, drop {
        collection: 0x2::object::ID,
        publisher: 0x2::object::ID,
        mbox: bool,
        owner: address,
        name: 0x1::string::String,
        image_url: 0x1::ascii::String,
        description: 0x1::string::String,
        project_url: 0x1::string::String,
        link: 0x1::string::String,
        total_supply: u64,
    }

    struct SetCollectionTotalSupplyEvent has copy, drop {
        collection: 0x2::object::ID,
        total_supply: u64,
    }

    struct CreatePhaserEvent has copy, drop {
        publisher: 0x2::object::ID,
        collection: 0x2::object::ID,
        phaser: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        price: u64,
        per_sender_limit: u64,
        total_sender_limit: u64,
        total_supply: u64,
        start_time: u64,
        end_time: u64,
        status: u8,
        whitelist_merkle_root: vector<u8>,
    }

    struct ModifyPhaserEvent has copy, drop {
        phaser: 0x2::object::ID,
        price: u64,
        per_sender_limit: u64,
        total_sender_limit: u64,
        total_supply: u64,
        start_time: u64,
        end_time: u64,
    }

    struct MintNftEvent has copy, drop {
        phaser: 0x2::object::ID,
        collection: 0x2::object::ID,
        opened: bool,
        creator: address,
        name: 0x1::string::String,
        price: u64,
        mint_count: u64,
        nft_ids: vector<0x2::object::ID>,
        token_ids: vector<u64>,
        nft_type: 0x1::type_name::TypeName,
        nft_image_urls: vector<0x1::ascii::String>,
    }

    struct OpenNftEvent has copy, drop {
        id: 0x2::object::ID,
        image_url: 0x1::ascii::String,
        attributes: vector<Attribute>,
    }

    struct SetPhaserStatusEvent has copy, drop {
        publisher: 0x2::object::ID,
        collection: 0x2::object::ID,
        phaser: 0x2::object::ID,
        status: u8,
    }

    struct AddWhitelistMerkleRootEvent has copy, drop {
        publisher: 0x2::object::ID,
        collection: 0x2::object::ID,
        phaser: 0x2::object::ID,
        root_hash: vector<vector<u8>>,
    }

    struct RemoveWhitelistMerkleRootEvent has copy, drop {
        publisher: 0x2::object::ID,
        collection: 0x2::object::ID,
        phaser: 0x2::object::ID,
        root_hash: vector<vector<u8>>,
    }

    struct WithdrawEvent has copy, drop {
        wallet: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        to: address,
        amount: u64,
    }

    struct CreateRegistryEvent has copy, drop {
        registry: 0x2::object::ID,
        status: bool,
    }

    struct SetRegistryEvent has copy, drop {
        registry: 0x2::object::ID,
        status: bool,
    }

    struct BetEvent has copy, drop {
        user_addr: address,
        nft_ids: vector<0x2::object::ID>,
        guild_num: u64,
        bet_time: u64,
        round_num: u64,
    }

    struct BetV2Event has copy, drop {
        register: 0x2::object::ID,
        user_addr: address,
        nft_ids: vector<0x2::object::ID>,
        guild_num: u64,
        bet_time: u64,
        round_num: u64,
    }

    struct NFT has drop {
        dummy_field: bool,
    }

    public entry fun transfer(arg0: CubicNft, arg1: address) {
        0x2::transfer::transfer<CubicNft>(arg0, arg1);
    }

    public entry fun public_transfer(arg0: CubicNft, arg1: address) {
        transfer(arg0, arg1);
    }

    public entry fun addPhaserWhitelistMerkleRoot<T0>(arg0: &0x2::package::Publisher, arg1: &mut Phaser<T0>, arg2: vector<vector<u8>>, arg3: &mut 0x2::tx_context::TxContext) {
        assert_publisher(arg0);
        let v0 = 0x1::vector::empty<vector<u8>>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<vector<u8>>(&arg2)) {
            let v2 = 0x1::vector::borrow<vector<u8>>(&arg2, v1);
            assert!(0x1::vector::length<u8>(v2) == 32, 8);
            let v3 = 0x2::address::from_bytes(*v2);
            if (!0x2::table::contains<address, address>(&arg1.whitelist_merkle_roots, v3)) {
                0x2::table::add<address, address>(&mut arg1.whitelist_merkle_roots, v3, v3);
                0x1::vector::push_back<vector<u8>>(&mut v0, *v2);
            };
            v1 = v1 + 1;
        };
        let v4 = AddWhitelistMerkleRootEvent{
            publisher  : 0x2::object::id<0x2::package::Publisher>(arg0),
            collection : arg1.collection,
            phaser     : 0x2::object::id<Phaser<T0>>(arg1),
            root_hash  : v0,
        };
        0x2::event::emit<AddWhitelistMerkleRootEvent>(v4);
    }

    fun add_attribute(arg0: &mut vector<Attribute>, arg1: vector<u8>, arg2: vector<u8>) {
        let v0 = Attribute{
            name  : 0x1::string::utf8(arg1),
            value : 0x1::string::utf8(arg2),
        };
        0x1::vector::push_back<Attribute>(arg0, v0);
    }

    public entry fun add_operator(arg0: &0x2::package::Publisher, arg1: &mut Registry, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert_publisher(arg0);
        0x1::vector::push_back<address>(&mut arg1.operators, arg2);
    }

    fun assert_publisher(arg0: &0x2::package::Publisher) {
        assert!(0x2::package::from_module<CubicNft>(arg0), 26);
    }

    public entry fun batch_burn(arg0: vector<CubicNft>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<CubicNft>(&arg0)) {
            burn_nft(0x1::vector::pop_back<CubicNft>(&mut arg0));
            v0 = v0 + 1;
        };
        0x1::vector::destroy_empty<CubicNft>(arg0);
    }

    public entry fun bet(arg0: &0x2::clock::Clock, arg1: &mut Registry, arg2: vector<CubicNft>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = current_bet_round_index(arg0, arg1);
        assert!(v0, 27);
        let v2 = 0x2::table::borrow_mut<u64, BetRound>(&mut arg1.bet_rounds, v1);
        assert!(v2.winner_guild_num == 0, 21);
        let v3 = 0x2::clock::timestamp_ms(arg0);
        assert!(v3 >= v2.start_time && v3 < v2.end_time, 21);
        let v4 = 0x2::tx_context::sender(arg4);
        let v5 = 0x2::table::new<0x2::object::ID, bool>(arg4);
        let v6 = 0x1::vector::empty<0x2::object::ID>();
        let v7 = 0;
        while (v7 < 0x1::vector::length<CubicNft>(&arg2)) {
            let v8 = 0x1::vector::pop_back<CubicNft>(&mut arg2);
            let v9 = Attribute{
                name  : 0x1::string::utf8(b"Witness"),
                value : 0x1::string::utf8(b"33X Token Reward"),
            };
            assert!(!0x1::vector::contains<Attribute>(&v8.attributes, &v9), 25);
            let v10 = 0x2::object::id<CubicNft>(&v8);
            0x2::table::add<0x2::object::ID, bool>(&mut v5, v10, true);
            0x1::vector::push_back<0x2::object::ID>(&mut v6, v10);
            v8.image_url = arg1.betted_image_url;
            v8.attributes = 0x1::vector::empty<Attribute>();
            let v11 = &mut v8.attributes;
            add_attribute(v11, b"Witness", b"33X Token Reward");
            v8.opened = true;
            0x2::transfer::public_transfer<CubicNft>(v8, v4);
            v7 = v7 + 1;
        };
        0x1::vector::destroy_empty<CubicNft>(arg2);
        let v12 = 0x2::dynamic_field::borrow_mut<bool, 0x2::table::Table<address, u64>>(&mut v2.id, true);
        if (0x2::table::contains<address, u64>(v12, v4)) {
            let v13 = 0x2::table::borrow_mut<u64, Bet>(&mut v2.bets, *0x2::table::borrow<address, u64>(v12, v4));
            if (0x2::dynamic_field::exists_<u64>(&mut v13.id, arg3)) {
                let v14 = 0x2::dynamic_field::borrow_mut<u64, 0x2::table::Table<0x2::object::ID, bool>>(&mut v13.id, arg3);
                let v15 = 0;
                while (v15 < 0x1::vector::length<0x2::object::ID>(&v6)) {
                    let v16 = 0x1::vector::borrow<0x2::object::ID>(&v6, v15);
                    0x2::table::remove<0x2::object::ID, bool>(&mut v5, *v16);
                    0x2::table::add<0x2::object::ID, bool>(v14, *v16, true);
                    v15 = v15 + 1;
                };
                0x2::table::destroy_empty<0x2::object::ID, bool>(v5);
            } else {
                0x2::dynamic_field::add<u64, 0x2::table::Table<0x2::object::ID, bool>>(&mut v13.id, arg3, v5);
            };
        } else {
            let v17 = Bet{
                id        : 0x2::object::new(arg4),
                user_addr : v4,
                nft_ids   : 0x2::table::new<0x2::object::ID, bool>(arg4),
                guild_num : 0,
                bet_time  : v3,
            };
            let v18 = 0x2::table::length<address, u64>(v12);
            0x2::dynamic_field::add<u64, 0x2::table::Table<0x2::object::ID, bool>>(&mut v17.id, arg3, v5);
            0x2::table::add<u64, Bet>(&mut v2.bets, v18, v17);
            0x2::table::add<address, u64>(v12, v4, v18);
        };
        let v19 = BetV2Event{
            register  : 0x2::object::id<Registry>(arg1),
            user_addr : v4,
            nft_ids   : v6,
            guild_num : arg3,
            bet_time  : v3,
            round_num : v1,
        };
        0x2::event::emit<BetV2Event>(v19);
    }

    public fun borrow_attributes(arg0: &CubicNft) : vector<Attribute> {
        arg0.attributes
    }

    public fun borrow_attributes_vec_map(arg0: &CubicNft) : 0x2::vec_map::VecMap<0x1::ascii::String, 0x1::ascii::String> {
        let v0 = 0x2::vec_map::empty<0x1::ascii::String, 0x1::ascii::String>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<Attribute>(&arg0.attributes)) {
            let Attribute {
                name  : v2,
                value : v3,
            } = *0x1::vector::borrow<Attribute>(&arg0.attributes, v1);
            0x2::vec_map::insert<0x1::ascii::String, 0x1::ascii::String>(&mut v0, 0x1::string::to_ascii(v2), 0x1::string::to_ascii(v3));
            v1 = v1 + 1;
        };
        v0
    }

    public fun borrow_opened(arg0: &CubicNft) : bool {
        arg0.opened
    }

    public fun borrow_token_id(arg0: &CubicNft) : u64 {
        arg0.token_id
    }

    fun burn_nft(arg0: CubicNft) {
        let CubicNft {
            id          : v0,
            collection  : _,
            opened      : _,
            creator     : _,
            token_id    : _,
            name        : _,
            image_url   : _,
            description : _,
            project_url : _,
            link        : _,
            attributes  : v10,
        } = arg0;
        let v11 = v10;
        let v12 = 0;
        while (v12 < 0x1::vector::length<Attribute>(&v11)) {
            let Attribute {
                name  : _,
                value : _,
            } = 0x1::vector::pop_back<Attribute>(&mut v11);
            v12 = v12 + 1;
        };
        0x1::vector::destroy_empty<Attribute>(v11);
        0x2::object::delete(v0);
    }

    public fun containsPhaserWhitelistMerkleRoot<T0>(arg0: &mut Phaser<T0>, arg1: vector<vector<u8>>) : vector<bool> {
        let v0 = 0x1::vector::empty<bool>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<vector<u8>>(&arg1)) {
            let v2 = 0x1::vector::borrow<vector<u8>>(&arg1, v1);
            assert!(0x1::vector::length<u8>(v2) == 32, 8);
            if (0x2::table::contains<address, address>(&arg0.whitelist_merkle_roots, 0x2::address::from_bytes(*v2))) {
                0x1::vector::push_back<bool>(&mut v0, true);
            } else {
                0x1::vector::push_back<bool>(&mut v0, false);
            };
            v1 = v1 + 1;
        };
        v0
    }

    public entry fun createCollection(arg0: &0x2::package::Publisher, arg1: bool, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        assert_publisher(arg0);
        let v0 = 0x2::tx_context::sender(arg8);
        let v1 = Collection{
            id           : 0x2::object::new(arg8),
            publisher    : 0x2::object::id<0x2::package::Publisher>(arg0),
            mbox         : arg1,
            owner        : v0,
            name         : 0x1::string::utf8(arg2),
            image_url    : 0x1::ascii::string(arg3),
            description  : 0x1::string::utf8(arg4),
            project_url  : 0x1::string::utf8(arg5),
            link         : 0x1::string::utf8(arg6),
            token_index  : 0,
            total_supply : arg7,
            balance      : 0,
        };
        let v2 = CreateCollectionEvent{
            collection   : 0x2::object::id<Collection>(&v1),
            publisher    : 0x2::object::id<0x2::package::Publisher>(arg0),
            mbox         : arg1,
            owner        : v1.owner,
            name         : v1.name,
            image_url    : v1.image_url,
            description  : v1.description,
            project_url  : v1.project_url,
            link         : v1.link,
            total_supply : v1.total_supply,
        };
        0x2::event::emit<CreateCollectionEvent>(v2);
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"creator"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"collection"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"token_id"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"link"));
        let v5 = 0x1::vector::empty<0x1::string::String>();
        let v6 = &mut v5;
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"{creator}"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"{collection}"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"{token_id}"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"{project_url}"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"{link}"));
        let v7 = 0x2::display::new_with_fields<CubicNft>(arg0, v3, v5, arg8);
        0x2::display::update_version<CubicNft>(&mut v7);
        0x2::transfer::public_transfer<0x2::display::Display<CubicNft>>(v7, v0);
        0x2::transfer::share_object<Collection>(v1);
    }

    public entry fun createPhaser<T0>(arg0: &0x2::package::Publisher, arg1: &Collection, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u8, arg9: vector<u8>, arg10: &mut 0x2::tx_context::TxContext) {
        assert_publisher(arg0);
        assert!(arg8 == 0 || arg8 == 1 || arg8 == 2, 7);
        assert!(0x1::vector::length<u8>(&arg9) == 32, 8);
        let v0 = 0x2::address::from_bytes(arg9);
        let v1 = 0x2::table::new<address, address>(arg10);
        0x2::table::add<address, address>(&mut v1, v0, v0);
        let v2 = Phaser<T0>{
            id                     : 0x2::object::new(arg10),
            publisher              : 0x2::object::id<0x2::package::Publisher>(arg0),
            collection             : 0x2::object::id<Collection>(arg1),
            price                  : arg2,
            per_sender_limit       : arg3,
            total_sender_limit     : arg4,
            total_supply           : arg5,
            minted_amount          : 0,
            start_time             : arg6,
            end_time               : arg7,
            status                 : arg8,
            user_minted            : 0x2::table::new<address, u64>(arg10),
            whitelist_merkle_roots : v1,
        };
        let v3 = CreatePhaserEvent{
            publisher             : v2.publisher,
            collection            : v2.collection,
            phaser                : 0x2::object::id<Phaser<T0>>(&v2),
            coin_type             : 0x1::type_name::get<T0>(),
            price                 : v2.price,
            per_sender_limit      : v2.per_sender_limit,
            total_sender_limit    : v2.total_sender_limit,
            total_supply          : v2.total_supply,
            start_time            : v2.start_time,
            end_time              : v2.end_time,
            status                : arg8,
            whitelist_merkle_root : arg9,
        };
        0x2::event::emit<CreatePhaserEvent>(v3);
        0x2::transfer::share_object<Phaser<T0>>(v2);
    }

    public entry fun createRegistry(arg0: &0x2::package::Publisher, arg1: &Collection, arg2: bool, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        assert_publisher(arg0);
        assert!(arg1.mbox, 17);
        let v0 = Registry{
            id               : 0x2::object::new(arg4),
            collection       : 0x2::object::id<Collection>(arg1),
            status           : arg2,
            operators        : 0x1::vector::empty<address>(),
            bet_rounds       : 0x2::table::new<u64, BetRound>(arg4),
            betted_image_url : 0x2::url::new_unsafe_from_bytes(arg3),
        };
        let v1 = CreateRegistryEvent{
            registry : 0x2::object::id<Registry>(&v0),
            status   : arg2,
        };
        0x2::event::emit<CreateRegistryEvent>(v1);
        0x2::transfer::share_object<Registry>(v0);
    }

    public entry fun createWallet<T0>(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) {
        assert_publisher(arg0);
        let v0 = Wallet<T0>{
            id      : 0x2::object::new(arg1),
            balance : 0x2::balance::zero<T0>(),
        };
        let v1 = CreateWalletEvent{
            wallet    : 0x2::object::id<Wallet<T0>>(&v0),
            coin_type : 0x1::type_name::get<T0>(),
            publisher : 0x2::object::id<0x2::package::Publisher>(arg0),
        };
        0x2::event::emit<CreateWalletEvent>(v1);
        0x2::transfer::public_share_object<Wallet<T0>>(v0);
    }

    public entry fun create_bet_round(arg0: &mut Registry, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x1::vector::contains<address>(&arg0.operators, &v0), 24);
        let v1 = BetRound{
            id               : 0x2::object::new(arg3),
            start_time       : arg1,
            end_time         : arg2,
            winner_guild_num : 0,
            user_addrs       : 0x2::table::new<address, bool>(arg3),
            bets             : 0x2::table::new<u64, Bet>(arg3),
            winners          : 0x2::table::new<address, bool>(arg3),
        };
        0x2::dynamic_field::add<bool, 0x2::table::Table<address, u64>>(&mut v1.id, true, 0x2::table::new<address, u64>(arg3));
        0x2::table::add<u64, BetRound>(&mut arg0.bet_rounds, 0x2::table::length<u64, BetRound>(&arg0.bet_rounds), v1);
    }

    public fun current_bet_round_index(arg0: &0x2::clock::Clock, arg1: &mut Registry) : (bool, u64) {
        let v0 = 0x2::clock::timestamp_ms(arg0);
        let v1 = 0x2::table::length<u64, BetRound>(&arg1.bet_rounds);
        let v2 = 0;
        while (v2 < v1) {
            let v3 = 0x2::table::borrow<u64, BetRound>(&arg1.bet_rounds, v2);
            if (v3.start_time <= v0 && v0 < v3.end_time && v3.winner_guild_num == 0) {
                return (true, v2)
            };
            v2 = v2 + 1;
        };
        (false, v1)
    }

    public entry fun freeMint<T0>(arg0: &0x2::clock::Clock, arg1: &mut Collection, arg2: &mut Phaser<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.status == 1, 7);
        assert!(arg2.price == 0, 10);
        mint<T0>(arg0, arg1, arg2, arg3, 0, arg4);
    }

    public fun getMintedCount<T0>(arg0: &Phaser<T0>, arg1: &0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::tx_context::sender(arg1);
        if (0x2::table::contains<address, u64>(&arg0.user_minted, v0)) {
            *0x2::table::borrow<address, u64>(&arg0.user_minted, v0)
        } else {
            0
        }
    }

    public fun getMintedCountByUser<T0>(arg0: &Phaser<T0>, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.user_minted, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.user_minted, arg1)
        } else {
            0
        }
    }

    fun init(arg0: NFT, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<NFT>(arg0, arg1);
    }

    fun isWhitelist<T0>(arg0: &mut Phaser<T0>, arg1: u64, arg2: vector<vector<u8>>, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) : bool {
        if (!0x2::table::contains<address, address>(&arg0.whitelist_merkle_roots, 0x2::address::from_bytes(arg3))) {
            return false
        };
        let v0 = Ticket{
            owner  : 0x2::tx_context::sender(arg4),
            amount : arg1,
        };
        0x6916b60ae826f14b3e2d7aa9c7eaf491a489379e2357c2819f48dde75a45ab58::merkle_proof::verify(&arg2, arg3, 0x1::hash::sha2_256(0x2::bcs::to_bytes<Ticket>(&v0)))
    }

    fun mint<T0>(arg0: &0x2::clock::Clock, arg1: &mut Collection, arg2: &mut Phaser<T0>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::clock::timestamp_ms(arg0);
        assert!(arg2.start_time <= v1 && v1 < arg2.end_time, 1);
        assert!(arg2.minted_amount + arg3 <= arg2.total_supply, 3);
        assert!(arg3 <= arg2.per_sender_limit, 4);
        let v2 = &mut arg2.user_minted;
        let v3 = 0;
        if (0x2::table::contains<address, u64>(v2, v0)) {
            let v4 = 0x2::table::borrow_mut<address, u64>(v2, v0);
            v3 = *v4;
            *v4 = *v4 + arg3;
        } else {
            0x2::table::add<address, u64>(v2, v0, arg3);
        };
        if (arg4 > 0) {
            assert!(v3 + arg3 <= arg4, 13);
        };
        assert!(v3 + arg3 <= arg2.total_sender_limit, 5);
        assert!(arg1.balance + arg3 <= arg1.total_supply, 2);
        let v5 = 0x1::vector::empty<u64>();
        let v6 = 0x1::vector::empty<0x2::object::ID>();
        let v7 = 0x1::vector::empty<0x1::ascii::String>();
        let v8 = 0;
        while (v8 < arg3) {
            let v9 = v8 + 1;
            v8 = v9;
            let v10 = arg1.token_index + v9;
            let v11 = 0x1::vector::empty<Attribute>();
            let v12 = &mut v11;
            add_attribute(v12, b"Not Witness", b"1X Token Reward");
            let v13 = CubicNft{
                id          : 0x2::object::new(arg5),
                collection  : arg2.collection,
                opened      : !arg1.mbox,
                creator     : v0,
                token_id    : v10,
                name        : arg1.name,
                image_url   : 0x2::url::new_unsafe(toUrl(arg1.image_url, v10)),
                description : arg1.description,
                project_url : arg1.project_url,
                link        : arg1.link,
                attributes  : v11,
            };
            0x1::vector::push_back<u64>(&mut v5, v10);
            0x1::vector::push_back<0x2::object::ID>(&mut v6, 0x2::object::id<CubicNft>(&v13));
            0x1::vector::push_back<0x1::ascii::String>(&mut v7, 0x2::url::inner_url(&v13.image_url));
            0x2::transfer::public_transfer<CubicNft>(v13, v0);
        };
        let v14 = MintNftEvent{
            phaser         : 0x2::object::id<Phaser<T0>>(arg2),
            collection     : arg2.collection,
            opened         : !arg1.mbox,
            creator        : v0,
            name           : arg1.name,
            price          : arg2.price,
            mint_count     : arg3,
            nft_ids        : v6,
            token_ids      : v5,
            nft_type       : 0x1::type_name::get<CubicNft>(),
            nft_image_urls : v7,
        };
        0x2::event::emit<MintNftEvent>(v14);
        arg1.token_index = arg1.token_index + arg3;
        arg1.balance = arg1.balance + arg3;
        arg2.minted_amount = arg2.minted_amount + arg3;
    }

    public entry fun modifyPhaserLimit<T0>(arg0: &0x2::package::Publisher, arg1: &mut Phaser<T0>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        assert_publisher(arg0);
        arg1.price = arg2;
        arg1.per_sender_limit = arg3;
        arg1.total_sender_limit = arg4;
        arg1.total_supply = arg5;
        arg1.start_time = arg6;
        arg1.end_time = arg7;
        let v0 = ModifyPhaserEvent{
            phaser             : 0x2::object::id<Phaser<T0>>(arg1),
            price              : arg1.price,
            per_sender_limit   : arg1.per_sender_limit,
            total_sender_limit : arg1.total_sender_limit,
            total_supply       : arg1.total_supply,
            start_time         : arg1.start_time,
            end_time           : arg1.end_time,
        };
        0x2::event::emit<ModifyPhaserEvent>(v0);
    }

    fun pay<T0>(arg0: &mut Wallet<T0>, arg1: &mut Phaser<T0>, arg2: u64, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg3);
        let v1 = arg1.price * arg2;
        assert!(v1 <= v0, 6);
        if (v1 == v0) {
            0x2::coin::put<T0>(&mut arg0.balance, arg3);
        } else {
            0x2::coin::put<T0>(&mut arg0.balance, 0x2::coin::split<T0>(&mut arg3, v1, arg4));
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg3, 0x2::tx_context::sender(arg4));
        };
    }

    public entry fun removePhaserWhitelistMerkleRoot<T0>(arg0: &0x2::package::Publisher, arg1: &mut Phaser<T0>, arg2: vector<vector<u8>>, arg3: &mut 0x2::tx_context::TxContext) {
        assert_publisher(arg0);
        let v0 = 0x1::vector::empty<vector<u8>>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<vector<u8>>(&arg2)) {
            let v2 = 0x1::vector::borrow<vector<u8>>(&arg2, v1);
            assert!(0x1::vector::length<u8>(v2) == 32, 8);
            if (0x2::table::contains<address, address>(&arg1.whitelist_merkle_roots, 0x2::address::from_bytes(*v2))) {
                0x2::table::remove<address, address>(&mut arg1.whitelist_merkle_roots, 0x2::address::from_bytes(*v2));
                0x1::vector::push_back<vector<u8>>(&mut v0, *v2);
            };
            v1 = v1 + 1;
        };
        let v3 = RemoveWhitelistMerkleRootEvent{
            publisher  : 0x2::object::id<0x2::package::Publisher>(arg0),
            collection : arg1.collection,
            phaser     : 0x2::object::id<Phaser<T0>>(arg1),
            root_hash  : v0,
        };
        0x2::event::emit<RemoveWhitelistMerkleRootEvent>(v3);
    }

    public entry fun remove_operator(arg0: &0x2::package::Publisher, arg1: &mut Registry, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert_publisher(arg0);
        let (v0, v1) = 0x1::vector::index_of<address>(&mut arg1.operators, &arg2);
        assert!(v0, 24);
        0x1::vector::remove<address>(&mut arg1.operators, v1);
    }

    public entry fun setCollectionTotalSupply(arg0: &0x2::package::Publisher, arg1: &mut Collection, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert_publisher(arg0);
        assert!(arg1.balance <= arg2, 14);
        arg1.total_supply = arg2;
        let v0 = SetCollectionTotalSupplyEvent{
            collection   : 0x2::object::id<Collection>(arg1),
            total_supply : arg2,
        };
        0x2::event::emit<SetCollectionTotalSupplyEvent>(v0);
    }

    public entry fun setPhaserStatus<T0>(arg0: &0x2::package::Publisher, arg1: &mut Phaser<T0>, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        assert_publisher(arg0);
        assert!(arg2 == 0 || arg2 == 1 || arg2 == 2, 7);
        if (arg1.status != arg2) {
            arg1.status = arg2;
        };
        let v0 = SetPhaserStatusEvent{
            publisher  : 0x2::object::id<0x2::package::Publisher>(arg0),
            collection : arg1.collection,
            phaser     : 0x2::object::id<Phaser<T0>>(arg1),
            status     : arg2,
        };
        0x2::event::emit<SetPhaserStatusEvent>(v0);
    }

    public entry fun setRegistryStatus(arg0: &0x2::package::Publisher, arg1: &mut Registry, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        assert_publisher(arg0);
        arg1.status = arg2;
        let v0 = SetRegistryEvent{
            registry : 0x2::object::id<Registry>(arg1),
            status   : arg2,
        };
        0x2::event::emit<SetRegistryEvent>(v0);
    }

    public entry fun set_winner(arg0: &mut Registry, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x1::vector::contains<address>(&arg0.operators, &v0), 24);
        assert!(0x2::table::contains<u64, BetRound>(&arg0.bet_rounds, arg1), 20);
        let v1 = 0x2::table::borrow_mut<u64, BetRound>(&mut arg0.bet_rounds, arg1);
        v1.winner_guild_num = arg2;
        let v2 = 0;
        while (v2 < 0x2::table::length<address, bool>(&v1.user_addrs)) {
            let v3 = 0x2::table::borrow_mut<u64, Bet>(&mut v1.bets, v2);
            if (v3.guild_num == arg2) {
                0x2::table::add<address, bool>(&mut v1.winners, v3.user_addr, true);
            };
            v2 = v2 + 1;
        };
    }

    public entry fun set_winner_upgrade(arg0: &mut Registry, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x1::vector::contains<address>(&arg0.operators, &v0), 24);
        assert!(0x2::table::contains<u64, BetRound>(&arg0.bet_rounds, arg1), 20);
        0x2::table::borrow_mut<u64, BetRound>(&mut arg0.bet_rounds, arg1).winner_guild_num = arg2;
    }

    public entry fun standardMint<T0>(arg0: &0x2::clock::Clock, arg1: &mut Wallet<T0>, arg2: &mut Collection, arg3: &mut Phaser<T0>, arg4: u64, arg5: 0x2::coin::Coin<T0>, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg3.status == 1, 7);
        assert!(arg3.price > 0, 10);
        pay<T0>(arg1, arg3, arg4, arg5, arg6);
        mint<T0>(arg0, arg2, arg3, arg4, 0, arg6);
    }

    public fun toUrl(arg0: 0x1::ascii::String, arg1: u64) : 0x1::ascii::String {
        let v0 = 0x1::string::from_ascii(arg0);
        let v1 = 0x1::string::utf8(b"");
        let v2 = &mut v1;
        let v3 = 0x1::string::length(&v0);
        let v4 = 0x1::string::utf8(b"{");
        let v5 = 0x1::string::utf8(b"}");
        let v6 = 0x1::string::index_of(&v0, &v5);
        if (v6 < v3) {
            0x1::string::append(v2, 0x1::string::sub_string(&v0, 0, 0x1::string::index_of(&v0, &v4)));
            0x1::string::append(v2, u64ToString(arg1));
            0x1::string::append(v2, 0x1::string::sub_string(&v0, v6 + 1, v3));
        } else {
            0x1::string::append(v2, v0);
        };
        0x1::string::to_ascii(*v2)
    }

    public fun u64ToString(arg0: u64) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"");
        let v1 = &mut v0;
        let v2 = arg0;
        loop {
            let v3 = v2 % 10;
            if (v3 == 0) {
                0x1::string::insert(v1, 0, 0x1::string::utf8(b"0"));
            } else if (v3 == 1) {
                0x1::string::insert(v1, 0, 0x1::string::utf8(b"1"));
            } else if (v3 == 2) {
                0x1::string::insert(v1, 0, 0x1::string::utf8(b"2"));
            } else if (v3 == 3) {
                0x1::string::insert(v1, 0, 0x1::string::utf8(b"3"));
            } else if (v3 == 4) {
                0x1::string::insert(v1, 0, 0x1::string::utf8(b"4"));
            } else if (v3 == 5) {
                0x1::string::insert(v1, 0, 0x1::string::utf8(b"5"));
            } else if (v3 == 6) {
                0x1::string::insert(v1, 0, 0x1::string::utf8(b"6"));
            } else if (v3 == 7) {
                0x1::string::insert(v1, 0, 0x1::string::utf8(b"7"));
            } else if (v3 == 8) {
                0x1::string::insert(v1, 0, 0x1::string::utf8(b"8"));
            } else if (v3 == 9) {
                0x1::string::insert(v1, 0, 0x1::string::utf8(b"9"));
            };
            v2 = v2 / 10;
            if (v2 == 0) {
                break
            };
        };
        *v1
    }

    public entry fun whitelistFreeMint<T0>(arg0: &0x2::clock::Clock, arg1: &mut Collection, arg2: &mut Phaser<T0>, arg3: u64, arg4: u64, arg5: vector<vector<u8>>, arg6: vector<u8>, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.status == 2, 7);
        assert!(arg2.price == 0, 10);
        assert!(arg3 <= arg4, 12);
        assert!(isWhitelist<T0>(arg2, arg4, arg5, arg6, arg7), 0);
        mint<T0>(arg0, arg1, arg2, arg3, arg4, arg7);
    }

    public entry fun whitelistMint<T0>(arg0: &0x2::clock::Clock, arg1: &mut Wallet<T0>, arg2: &mut Collection, arg3: &mut Phaser<T0>, arg4: u64, arg5: 0x2::coin::Coin<T0>, arg6: u64, arg7: vector<vector<u8>>, arg8: vector<u8>, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg3.status == 2, 7);
        assert!(arg3.price > 0, 10);
        assert!(arg4 <= arg6, 12);
        assert!(isWhitelist<T0>(arg3, arg6, arg7, arg8, arg9), 0);
        pay<T0>(arg1, arg3, arg4, arg5, arg9);
        mint<T0>(arg0, arg2, arg3, arg4, arg6, arg9);
    }

    public entry fun withdraw<T0>(arg0: &0x2::package::Publisher, arg1: &mut Wallet<T0>, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert_publisher(arg0);
        assert!(arg3 <= 0x2::balance::value<T0>(&arg1.balance), 9);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg1.balance, arg3, arg4), arg2);
        let v0 = WithdrawEvent{
            wallet    : 0x2::object::id<Wallet<T0>>(arg1),
            coin_type : 0x1::type_name::get<T0>(),
            to        : arg2,
            amount    : arg3,
        };
        0x2::event::emit<WithdrawEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

