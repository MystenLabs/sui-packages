module 0xadcca84883bd8df41013bc3978b1d7915820eb881a52a327c16b8dc26ee4aca9::nft {
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
        whitelist_merkle_root: vector<u8>,
        user_minted: 0x2::table::Table<address, u64>,
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

    struct Registry has key {
        id: 0x2::object::UID,
        collection: 0x2::object::ID,
        pool: vector<u64>,
        traits: vector<vector<u8>>,
        levels: vector<vector<u8>>,
        outlooks: vector<vector<u8>>,
        images: vector<vector<u8>>,
        r_img_count: u8,
        n_img_count: u8,
        status: bool,
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

    struct SetWhitelistMerkleRootEvent has copy, drop {
        publisher: 0x2::object::ID,
        collection: 0x2::object::ID,
        phaser: 0x2::object::ID,
        root_hash: vector<u8>,
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

    struct NFT has drop {
        dummy_field: bool,
    }

    public entry fun transfer(arg0: CubicNft, arg1: address) {
        0x2::transfer::transfer<CubicNft>(arg0, arg1);
    }

    public entry fun public_transfer(arg0: CubicNft, arg1: address) {
        transfer(arg0, arg1);
    }

    fun add_attribute(arg0: &mut vector<Attribute>, arg1: vector<u8>, arg2: vector<u8>) {
        let v0 = Attribute{
            name  : 0x1::string::utf8(arg1),
            value : 0x1::string::utf8(arg2),
        };
        0x1::vector::push_back<Attribute>(arg0, v0);
    }

    public entry fun createCollection(arg0: &0x2::package::Publisher, arg1: bool, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
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
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(arg3));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"{project_url}"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"{link}"));
        let v7 = 0x2::display::new_with_fields<CubicNft>(arg0, v3, v5, arg8);
        0x2::display::update_version<CubicNft>(&mut v7);
        0x2::transfer::public_transfer<0x2::display::Display<CubicNft>>(v7, v0);
        0x2::transfer::share_object<Collection>(v1);
    }

    public entry fun createPhaser<T0>(arg0: &0x2::package::Publisher, arg1: &Collection, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u8, arg9: vector<u8>, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(arg8 == 0 || arg8 == 1 || arg8 == 2, 7);
        assert!(0x1::vector::length<u8>(&arg9) == 32 || 0x1::vector::length<u8>(&arg9) == 0, 8);
        let v0 = Phaser<T0>{
            id                    : 0x2::object::new(arg10),
            publisher             : 0x2::object::id<0x2::package::Publisher>(arg0),
            collection            : 0x2::object::id<Collection>(arg1),
            price                 : arg2,
            per_sender_limit      : arg3,
            total_sender_limit    : arg4,
            total_supply          : arg5,
            minted_amount         : 0,
            start_time            : arg6,
            end_time              : arg7,
            status                : arg8,
            whitelist_merkle_root : arg9,
            user_minted           : 0x2::table::new<address, u64>(arg10),
        };
        let v1 = CreatePhaserEvent{
            publisher             : v0.publisher,
            collection            : v0.collection,
            phaser                : 0x2::object::id<Phaser<T0>>(&v0),
            coin_type             : 0x1::type_name::get<T0>(),
            price                 : v0.price,
            per_sender_limit      : v0.per_sender_limit,
            total_sender_limit    : v0.total_sender_limit,
            total_supply          : v0.total_supply,
            start_time            : v0.start_time,
            end_time              : v0.end_time,
            status                : arg8,
            whitelist_merkle_root : arg9,
        };
        0x2::event::emit<CreatePhaserEvent>(v1);
        0x2::transfer::share_object<Phaser<T0>>(v0);
    }

    public entry fun createRegistry(arg0: &0x2::package::Publisher, arg1: &Collection, arg2: vector<u64>, arg3: vector<vector<u8>>, arg4: vector<vector<u8>>, arg5: vector<vector<u8>>, arg6: vector<vector<u8>>, arg7: bool, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.mbox, 17);
        let v0 = Registry{
            id          : 0x2::object::new(arg8),
            collection  : 0x2::object::id<Collection>(arg1),
            pool        : arg2,
            traits      : arg3,
            levels      : arg4,
            outlooks    : arg5,
            images      : arg6,
            r_img_count : 0,
            n_img_count : 0,
            status      : arg7,
        };
        let v1 = CreateRegistryEvent{
            registry : 0x2::object::id<Registry>(&v0),
            status   : arg7,
        };
        0x2::event::emit<CreateRegistryEvent>(v1);
        0x2::transfer::share_object<Registry>(v0);
    }

    public entry fun createWallet<T0>(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) {
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

    fun get_index_scope(arg0: u64, arg1: &vector<u64>) : (u64, u64) {
        if (arg0 == 0) {
            (0, sum(arg1, 0) - 1)
        } else {
            (sum(arg1, arg0 - 1), sum(arg1, arg0) - 1)
        }
    }

    fun get_new_url(arg0: vector<u8>, arg1: u8, arg2: u8) : 0x2::url::Url {
        0x1::vector::push_back<u8>(&mut arg0, 48);
        0x1::vector::push_back<u8>(&mut arg0, 48 + arg1 % arg2 + 1);
        0x1::vector::append<u8>(&mut arg0, b".png");
        0x2::url::new_unsafe_from_bytes(arg0)
    }

    fun init(arg0: NFT, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<NFT>(arg0, arg1);
    }

    fun isWhitelist<T0>(arg0: &mut Phaser<T0>, arg1: u64, arg2: vector<vector<u8>>, arg3: &mut 0x2::tx_context::TxContext) : bool {
        let v0 = Ticket{
            owner  : 0x2::tx_context::sender(arg3),
            amount : arg1,
        };
        0xadcca84883bd8df41013bc3978b1d7915820eb881a52a327c16b8dc26ee4aca9::merkle_proof::verify(&arg2, arg0.whitelist_merkle_root, 0x1::hash::sha2_256(0x2::bcs::to_bytes<Ticket>(&v0)))
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
            let v11 = CubicNft{
                id          : 0x2::object::new(arg5),
                collection  : arg2.collection,
                opened      : !arg1.mbox,
                creator     : v0,
                token_id    : v10,
                name        : arg1.name,
                image_url   : 0x2::url::new_unsafe(arg1.image_url),
                description : arg1.description,
                project_url : arg1.project_url,
                link        : arg1.link,
                attributes  : 0x1::vector::empty<Attribute>(),
            };
            0x1::vector::push_back<u64>(&mut v5, v10);
            0x1::vector::push_back<0x2::object::ID>(&mut v6, 0x2::object::id<CubicNft>(&v11));
            0x1::vector::push_back<0x1::ascii::String>(&mut v7, 0x2::url::inner_url(&v11.image_url));
            0x2::transfer::public_transfer<CubicNft>(v11, v0);
        };
        let v12 = MintNftEvent{
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
        0x2::event::emit<MintNftEvent>(v12);
        arg1.token_index = arg1.token_index + arg3;
        arg1.balance = arg1.balance + arg3;
        arg2.minted_amount = arg2.minted_amount + arg3;
    }

    public entry fun modifyPhaserLimit<T0>(arg0: &0x2::package::Publisher, arg1: &mut Phaser<T0>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
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

    public entry fun oneRegistry(arg0: &0x2::package::Publisher, arg1: &Collection, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v0, 10);
        0x1::vector::push_back<u64>(&mut v0, 10);
        0x1::vector::push_back<u64>(&mut v0, 10);
        0x1::vector::push_back<u64>(&mut v0, 10);
        0x1::vector::push_back<u64>(&mut v0, 10);
        0x1::vector::push_back<u64>(&mut v0, 10);
        0x1::vector::push_back<u64>(&mut v0, 60);
        0x1::vector::push_back<u64>(&mut v0, 80);
        let v1 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v1, b"Hero Level");
        0x1::vector::push_back<vector<u8>>(&mut v1, b"Hero Outlook");
        let v2 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v2, b"SSR");
        0x1::vector::push_back<vector<u8>>(&mut v2, b"SSR");
        0x1::vector::push_back<vector<u8>>(&mut v2, b"SR");
        0x1::vector::push_back<vector<u8>>(&mut v2, b"SR");
        0x1::vector::push_back<vector<u8>>(&mut v2, b"SR");
        0x1::vector::push_back<vector<u8>>(&mut v2, b"SR");
        0x1::vector::push_back<vector<u8>>(&mut v2, b"R");
        0x1::vector::push_back<vector<u8>>(&mut v2, b"N");
        let v3 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v3, b"SSR-Eygpt Anubis");
        0x1::vector::push_back<vector<u8>>(&mut v3, b"SSR-Metal Shark");
        0x1::vector::push_back<vector<u8>>(&mut v3, b"SR-Running Back No.5");
        0x1::vector::push_back<vector<u8>>(&mut v3, b"SR-Joker Mask");
        0x1::vector::push_back<vector<u8>>(&mut v3, b"SR-Treasure Hunter");
        0x1::vector::push_back<vector<u8>>(&mut v3, b"SR-Time Alert");
        0x1::vector::push_back<vector<u8>>(&mut v3, b"R-Basic Feature");
        0x1::vector::push_back<vector<u8>>(&mut v3, b"N-Basic Feature");
        let v4 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v4, b"https://cubic-static.cubicgames.xyz/common/loa/SSR-Eygpt+Anubis.png");
        0x1::vector::push_back<vector<u8>>(&mut v4, b"https://cubic-static.cubicgames.xyz/common/loa/SSR-Metal+Shark.png");
        0x1::vector::push_back<vector<u8>>(&mut v4, b"https://cubic-static.cubicgames.xyz/common/loa/SR-Running+Back+No.5.png");
        0x1::vector::push_back<vector<u8>>(&mut v4, b"https://cubic-static.cubicgames.xyz/common/loa/SR-Joker+Mask.png");
        0x1::vector::push_back<vector<u8>>(&mut v4, b"https://cubic-static.cubicgames.xyz/common/loa/SR-Treasure+Hunter.png");
        0x1::vector::push_back<vector<u8>>(&mut v4, b"https://cubic-static.cubicgames.xyz/common/loa/SR-Time+Alert.png");
        0x1::vector::push_back<vector<u8>>(&mut v4, b"https://cubic-static.cubicgames.xyz/common/loa/R+-+Basic+Feature+");
        0x1::vector::push_back<vector<u8>>(&mut v4, b"https://cubic-static.cubicgames.xyz/common/loa/N+-+Basic+Feature+");
        createRegistry(arg0, arg1, v0, v1, v2, v3, v4, arg2, arg3);
    }

    public entry fun open(arg0: &mut Registry, arg1: &mut CubicNft, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = sum(&arg0.pool, 0x1::vector::length<u64>(&arg0.pool) - 1);
        assert!(v0 > 0, 11);
        assert!(!arg1.opened, 15);
        assert!(arg0.status, 18);
        assert!(arg1.collection == arg0.collection, 16);
        let v1 = rand_index(0x2::object::uid_to_bytes(&arg1.id), v0);
        let v2 = 0x1::vector::length<u64>(&arg0.pool);
        let v3 = 0;
        while (v3 < v2) {
            if (*0x1::vector::borrow<u64>(&arg0.pool, v3) > 0) {
                let (v4, v5) = get_index_scope(v3, &arg0.pool);
                if (v4 <= v1 && v1 <= v5) {
                    arg1.image_url = 0x2::url::new_unsafe_from_bytes(*0x1::vector::borrow<vector<u8>>(&arg0.images, v3));
                    if (v3 == v2 - 2) {
                        arg1.image_url = get_new_url(*0x1::vector::borrow<vector<u8>>(&arg0.images, v3), arg0.r_img_count, 6);
                        arg0.r_img_count = arg0.r_img_count + 1;
                    };
                    if (v3 == v2 - 1) {
                        arg1.image_url = get_new_url(*0x1::vector::borrow<vector<u8>>(&arg0.images, v3), arg0.n_img_count, 8);
                        arg0.n_img_count = arg0.n_img_count + 1;
                    };
                    let v6 = &mut arg1.attributes;
                    add_attribute(v6, *0x1::vector::borrow<vector<u8>>(&arg0.traits, 0), *0x1::vector::borrow<vector<u8>>(&arg0.levels, v3));
                    let v7 = &mut arg1.attributes;
                    add_attribute(v7, *0x1::vector::borrow<vector<u8>>(&arg0.traits, 1), *0x1::vector::borrow<vector<u8>>(&arg0.outlooks, v3));
                    let v8 = 0x1::vector::borrow_mut<u64>(&mut arg0.pool, v3);
                    *v8 = *v8 - 1;
                    break
                };
            };
            v3 = v3 + 1;
        };
        arg1.opened = true;
        let v9 = OpenNftEvent{
            id         : 0x2::object::uid_to_inner(&arg1.id),
            image_url  : 0x2::url::inner_url(&arg1.image_url),
            attributes : arg1.attributes,
        };
        0x2::event::emit<OpenNftEvent>(v9);
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

    public fun rand_index(arg0: vector<u8>, arg1: u64) : u64 {
        let v0 = 0x1::hash::sha3_256(arg0);
        let v1 = 0x2::bcs::new(0x1::hash::sha3_256(v0));
        let v2 = 0x2::bcs::peel_u64(&mut v1) % arg1;
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&v2));
        let v3 = 0x2::bcs::new(0x1::hash::sha3_256(v0));
        0x2::bcs::peel_u64(&mut v3) % arg1
    }

    public entry fun setCollectionTotalSupply(arg0: &0x2::package::Publisher, arg1: &mut Collection, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.balance <= arg2, 14);
        arg1.total_supply = arg2;
        let v0 = SetCollectionTotalSupplyEvent{
            collection   : 0x2::object::id<Collection>(arg1),
            total_supply : arg2,
        };
        0x2::event::emit<SetCollectionTotalSupplyEvent>(v0);
    }

    public entry fun setPhaserStatus<T0>(arg0: &0x2::package::Publisher, arg1: &mut Phaser<T0>, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
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

    public entry fun setPhaserWhitelistMerkleRoot<T0>(arg0: &0x2::package::Publisher, arg1: &mut Phaser<T0>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(&arg2) == 32, 8);
        arg1.whitelist_merkle_root = arg2;
        let v0 = SetWhitelistMerkleRootEvent{
            publisher  : 0x2::object::id<0x2::package::Publisher>(arg0),
            collection : arg1.collection,
            phaser     : 0x2::object::id<Phaser<T0>>(arg1),
            root_hash  : arg2,
        };
        0x2::event::emit<SetWhitelistMerkleRootEvent>(v0);
    }

    public entry fun setRegistryStatus(arg0: &0x2::package::Publisher, arg1: &mut Registry, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.status = arg2;
        let v0 = SetRegistryEvent{
            registry : 0x2::object::id<Registry>(arg1),
            status   : arg2,
        };
        0x2::event::emit<SetRegistryEvent>(v0);
    }

    public entry fun standardMint<T0>(arg0: &0x2::clock::Clock, arg1: &mut Wallet<T0>, arg2: &mut Collection, arg3: &mut Phaser<T0>, arg4: u64, arg5: 0x2::coin::Coin<T0>, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg3.status == 1, 7);
        assert!(arg3.price > 0, 10);
        pay<T0>(arg1, arg3, arg4, arg5, arg6);
        mint<T0>(arg0, arg2, arg3, arg4, 0, arg6);
    }

    fun sum(arg0: &vector<u64>, arg1: u64) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v0 <= arg1) {
            v1 = v1 + *0x1::vector::borrow<u64>(arg0, v0);
            v0 = v0 + 1;
        };
        v1
    }

    public entry fun whitelistFreeMint<T0>(arg0: &0x2::clock::Clock, arg1: &mut Collection, arg2: &mut Phaser<T0>, arg3: u64, arg4: u64, arg5: vector<vector<u8>>, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.status == 2, 7);
        assert!(arg2.price == 0, 10);
        assert!(arg3 <= arg4, 12);
        assert!(isWhitelist<T0>(arg2, arg4, arg5, arg6), 0);
        mint<T0>(arg0, arg1, arg2, arg3, arg4, arg6);
    }

    public entry fun whitelistMint<T0>(arg0: &0x2::clock::Clock, arg1: &mut Wallet<T0>, arg2: &mut Collection, arg3: &mut Phaser<T0>, arg4: u64, arg5: 0x2::coin::Coin<T0>, arg6: u64, arg7: vector<vector<u8>>, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg3.status == 2, 7);
        assert!(arg3.price > 0, 10);
        assert!(arg4 <= arg6, 12);
        assert!(isWhitelist<T0>(arg3, arg6, arg7, arg8), 0);
        pay<T0>(arg1, arg3, arg4, arg5, arg8);
        mint<T0>(arg0, arg2, arg3, arg4, arg6, arg8);
    }

    public entry fun withdraw<T0>(arg0: &0x2::package::Publisher, arg1: &mut Wallet<T0>, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
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

