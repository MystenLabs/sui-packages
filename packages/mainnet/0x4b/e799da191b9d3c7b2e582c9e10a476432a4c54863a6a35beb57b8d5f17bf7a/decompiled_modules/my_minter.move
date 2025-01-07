module 0x4be799da191b9d3c7b2e582c9e10a476432a4c54863a6a35beb57b8d5f17bf7a::my_minter {
    struct SalePhase has drop, store {
        price: u64,
        max_sales: 0x1::option::Option<u64>,
        mints_per_user: 0x1::option::Option<u64>,
        start_time: u64,
        name: 0x1::string::String,
        root: 0x1::option::Option<vector<u8>>,
    }

    struct NFTMinted has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
        minter: address,
    }

    struct Collection has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        owner: address,
    }

    struct Minter has key {
        id: 0x2::object::UID,
        collection: 0x2::object::ID,
        owner: address,
        minted: u64,
        supply: u64,
        name: 0x1::string::String,
        description: 0x1::string::String,
        phases: vector<SalePhase>,
        user_buys: 0x2::table::Table<address, u64>,
        sale_phase_buys: 0x2::table::Table<0x1::string::String, u64>,
        url: 0x1::string::String,
    }

    struct MY_MINTER has drop {
        dummy_field: bool,
    }

    struct Nft has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        img_url: 0x1::string::String,
        image_url: 0x1::string::String,
        url: 0x2::url::Url,
        collection_id: 0x2::object::ID,
        symbol: 0x1::option::Option<0x1::string::String>,
        attribute_keys: vector<0x1::string::String>,
        attribute_values: vector<0x1::string::String>,
        creator: address,
    }

    public entry fun add_phase(arg0: &mut Minter, arg1: 0x1::string::String, arg2: u64, arg3: 0x1::option::Option<u64>, arg4: 0x1::option::Option<u64>, arg5: u64, arg6: 0x1::option::Option<vector<u8>>, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg7), 5);
        let v0 = 0;
        let v1 = 0x1::vector::length<SalePhase>(&arg0.phases);
        while (v0 < 0x1::vector::length<SalePhase>(&arg0.phases)) {
            if (0x1::vector::borrow_mut<SalePhase>(&mut arg0.phases, v0).name == arg1) {
                v1 = v0;
                break
            };
            v0 = v0 + 1;
        };
        assert!(v1 >= 0x1::vector::length<SalePhase>(&arg0.phases), 9);
        let v2 = SalePhase{
            price          : arg2,
            max_sales      : arg3,
            mints_per_user : arg4,
            start_time     : arg5,
            name           : arg1,
            root           : arg6,
        };
        let v3 = 0;
        while (v3 < 0x1::vector::length<SalePhase>(&arg0.phases)) {
            if (0x1::vector::borrow_mut<SalePhase>(&mut arg0.phases, v3).start_time > arg5) {
                break
            };
            v3 = v3 + 1;
        };
        0x1::vector::insert<SalePhase>(&mut arg0.phases, v2, v3);
    }

    fun compare_vector(arg0: &vector<u8>, arg1: &vector<u8>) : u8 {
        let v0 = 0x1::vector::length<u8>(arg0);
        assert!(0x1::vector::length<u8>(arg1) == v0, 4);
        let v1 = 0;
        while (v1 < v0) {
            if (*0x1::vector::borrow<u8>(arg0, v1) > *0x1::vector::borrow<u8>(arg1, v1)) {
                return 1
            };
            if (*0x1::vector::borrow<u8>(arg0, v1) < *0x1::vector::borrow<u8>(arg1, v1)) {
                return 2
            };
            v1 = v1 + 1;
        };
        0
    }

    public entry fun create(arg0: u64, arg1: u64, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: u64, arg7: 0x1::string::String, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = Collection{
            id          : 0x2::object::new(arg8),
            name        : arg4,
            description : arg5,
            owner       : 0x2::tx_context::sender(arg8),
        };
        let v1 = SalePhase{
            price          : arg6,
            max_sales      : 0x1::option::none<u64>(),
            mints_per_user : 0x1::option::none<u64>(),
            start_time     : arg0,
            name           : 0x1::string::utf8(b"Public"),
            root           : 0x1::option::none<vector<u8>>(),
        };
        let v2 = Minter{
            id              : 0x2::object::new(arg8),
            collection      : 0x2::object::uid_to_inner(&v0.id),
            owner           : 0x2::tx_context::sender(arg8),
            minted          : 0,
            supply          : arg1,
            name            : arg2,
            description     : arg3,
            phases          : 0x1::vector::singleton<SalePhase>(v1),
            user_buys       : 0x2::table::new<address, u64>(arg8),
            sale_phase_buys : 0x2::table::new<0x1::string::String, u64>(arg8),
            url             : arg7,
        };
        0x2::transfer::share_object<Collection>(v0);
        0x2::transfer::share_object<Minter>(v2);
    }

    fun extract_vector(arg0: vector<u8>, arg1: u64, arg2: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        assert!(arg1 <= arg2 && arg2 <= 0x1::vector::length<u8>(&arg0), 7);
        while (arg1 < arg2) {
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(&arg0, arg1));
            arg1 = arg1 + 1;
        };
        v0
    }

    fun hashPair(arg0: vector<u8>, arg1: vector<u8>) : vector<u8> {
        if (compare_vector(&arg0, &arg1) == 2) {
            0x1::vector::append<u8>(&mut arg0, arg1);
            0x2::hash::keccak256(&arg0)
        } else {
            0x1::vector::append<u8>(&mut arg1, arg0);
            0x2::hash::keccak256(&arg1)
        }
    }

    fun init(arg0: MY_MINTER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{creator}"));
        let v4 = 0x2::package::claim<MY_MINTER>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<Nft>(&v4, v0, v2, arg1);
        0x2::display::update_version<Nft>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Nft>>(v5, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut Minter, arg1: u64, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0xaa2a2cfcbf56c651088854c00b1bebac7ce8d6c81367569fe77a9513a021f9eb::minter::Config, arg4: &0x2::clock::Clock, arg5: vector<u8>, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = b"Minting";
        0x1::debug::print<vector<u8>>(&v0);
        let v1 = 0x2::tx_context::sender(arg6);
        let v2 = &arg0.phases;
        let v3 = 0;
        let v4 = 0x1::vector::length<SalePhase>(v2);
        while (v3 < 0x1::vector::length<SalePhase>(v2)) {
            if (0x2::clock::timestamp_ms(arg4) < 0x1::vector::borrow<SalePhase>(v2, v3).start_time) {
                break
            };
            v4 = v3;
            v3 = v3 + 1;
        };
        assert!(v4 < 0x1::vector::length<SalePhase>(v2), 0);
        let v5 = 0x1::vector::borrow<SalePhase>(v2, v4);
        if (!0x2::table::contains<0x1::string::String, u64>(&arg0.sale_phase_buys, v5.name)) {
            0x2::table::add<0x1::string::String, u64>(&mut arg0.sale_phase_buys, v5.name, 0);
        };
        if (!0x2::table::contains<address, u64>(&arg0.user_buys, v1)) {
            0x2::table::add<address, u64>(&mut arg0.user_buys, v1, 0);
        };
        let v6 = 0x2::table::borrow_mut<0x1::string::String, u64>(&mut arg0.sale_phase_buys, v5.name);
        let v7 = 0x2::table::borrow_mut<address, u64>(&mut arg0.user_buys, v1);
        let v8 = arg0.supply - arg0.minted;
        let v9 = v8;
        if (0x1::option::is_some<u64>(&v5.max_sales)) {
            v9 = 0x2::math::min(v8, *0x1::option::borrow<u64>(&v5.max_sales) - *v6);
        };
        if (0x1::option::is_some<u64>(&v5.mints_per_user)) {
            v9 = 0x2::math::min(v9, *0x1::option::borrow<u64>(&v5.mints_per_user) - *v7);
        };
        assert!(v9 > 0, 3);
        if (0x1::option::is_some<vector<u8>>(&v5.root)) {
            let v10 = 0x1::bcs::to_bytes<address>(&v1);
            verify(arg5, *0x1::option::borrow<vector<u8>>(&v5.root), 0x2::hash::keccak256(&v10));
        };
        let v11 = 0x2::math::min(arg1, v9);
        let v12 = 0x2::coin::value<0x2::sui::SUI>(arg2);
        0x1::debug::print<u64>(&v12);
        assert!(0x2::coin::value<0x2::sui::SUI>(arg2) >= (v5.price + 0xaa2a2cfcbf56c651088854c00b1bebac7ce8d6c81367569fe77a9513a021f9eb::minter::b(arg3)) * v11, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg2, v5.price * v11, arg6), arg0.owner);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg2, 0xaa2a2cfcbf56c651088854c00b1bebac7ce8d6c81367569fe77a9513a021f9eb::minter::b(arg3) * v11, arg6), 0xaa2a2cfcbf56c651088854c00b1bebac7ce8d6c81367569fe77a9513a021f9eb::minter::a(arg3));
        let v13 = 0;
        while (v13 < v11) {
            let v14 = 0x1::string::utf8(*0x1::string::bytes(&arg0.name));
            0x1::string::append(&mut v14, to_string(arg0.minted + v13));
            let v15 = 0x1::string::utf8(*0x1::string::bytes(&arg0.url));
            0x1::string::append(&mut v15, to_string(arg0.minted + v13));
            0x1::debug::print<0x1::string::String>(&v14);
            let v16 = Nft{
                id               : 0x2::object::new(arg6),
                name             : v14,
                description      : arg0.description,
                img_url          : v15,
                image_url        : v15,
                url              : 0x2::url::new_unsafe(0x1::string::to_ascii(v15)),
                collection_id    : arg0.collection,
                symbol           : 0x1::option::none<0x1::string::String>(),
                attribute_keys   : 0x1::vector::empty<0x1::string::String>(),
                attribute_values : 0x1::vector::empty<0x1::string::String>(),
                creator          : arg0.owner,
            };
            let v17 = NFTMinted{
                object_id : 0x2::object::id<Nft>(&v16),
                creator   : arg0.owner,
                name      : v16.name,
                minter    : v1,
            };
            0x2::event::emit<NFTMinted>(v17);
            0x2::transfer::transfer<Nft>(v16, v1);
            v13 = v13 + 1;
        };
        *v6 = *v6 + v11;
        *v7 = *v7 + v11;
        arg0.minted = arg0.minted + v11;
    }

    fun processProof(arg0: vector<u8>, arg1: vector<u8>) : vector<u8> {
        assert!(0x1::vector::length<u8>(&arg0) % 32 == 0, 5);
        assert!(0x1::vector::length<u8>(&arg1) == 32, 6);
        let v0 = arg1;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(&arg0) / 32) {
            v0 = hashPair(v0, extract_vector(arg0, v1 * 32, v1 * 32 + 32));
            v1 = v1 + 1;
        };
        v0
    }

    public entry fun remove_phase(arg0: &mut Minter, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 5);
        let v0 = 0;
        let v1 = 0x1::vector::length<SalePhase>(&arg0.phases);
        while (v0 < 0x1::vector::length<SalePhase>(&arg0.phases)) {
            if (0x1::vector::borrow_mut<SalePhase>(&mut arg0.phases, v0).name == arg1) {
                v1 = v0;
                break
            };
            v0 = v0 + 1;
        };
        assert!(v1 < 0x1::vector::length<SalePhase>(&arg0.phases), 9);
        0x1::vector::remove<SalePhase>(&mut arg0.phases, v1);
    }

    fun to_string(arg0: u64) : 0x1::string::String {
        if (arg0 == 0) {
            return 0x1::string::utf8(b"0")
        };
        let v0 = 0;
        while (arg0 != 0) {
            v0 = v0 + 1;
            arg0 = arg0 / 10;
        };
        let v1 = zero_padded(v0);
        let v2 = v0 - 1;
        while (arg0 != 0) {
            *0x1::vector::borrow_mut<u8>(&mut v1, v2) = 48 + ((arg0 % 10) as u8);
            if (v2 > 0) {
                v2 = v2 - 1;
            };
            arg0 = arg0 / 10;
        };
        0x1::string::utf8(v1)
    }

    public entry fun update_phase(arg0: &mut Minter, arg1: 0x1::string::String, arg2: u64, arg3: 0x1::option::Option<u64>, arg4: 0x1::option::Option<u64>, arg5: u64, arg6: 0x1::option::Option<vector<u8>>, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg7), 5);
        let v0 = 0;
        let v1 = 0x1::vector::length<SalePhase>(&arg0.phases);
        while (v0 < 0x1::vector::length<SalePhase>(&arg0.phases)) {
            if (0x1::vector::borrow_mut<SalePhase>(&mut arg0.phases, v0).name == arg1) {
                v1 = v0;
                break
            };
            v0 = v0 + 1;
        };
        assert!(v1 < 0x1::vector::length<SalePhase>(&arg0.phases), 9);
        let v2 = 0x1::vector::remove<SalePhase>(&mut arg0.phases, v1);
        v2.price = arg2;
        v2.max_sales = arg3;
        v2.mints_per_user = arg4;
        v2.start_time = arg5;
        v2.root = arg6;
        let v3 = 0;
        while (v3 < 0x1::vector::length<SalePhase>(&arg0.phases)) {
            if (0x1::vector::borrow_mut<SalePhase>(&mut arg0.phases, v3).start_time > arg5) {
                break
            };
            v3 = v3 + 1;
        };
        0x1::vector::insert<SalePhase>(&mut arg0.phases, v2, v3);
    }

    fun verify(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>) {
        0x1::debug::print<vector<u8>>(&arg0);
        0x1::debug::print<vector<u8>>(&arg2);
        let v0 = processProof(arg0, arg2);
        0x1::debug::print<vector<u8>>(&v0);
        0x1::debug::print<vector<u8>>(&arg1);
        let v1 = processProof(arg0, arg2);
        assert!(compare_vector(&v1, &arg1) == 0, 8);
    }

    fun zero_padded(arg0: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0;
        while (v1 < arg0) {
            0x1::vector::push_back<u8>(&mut v0, 0);
            v1 = v1 + 1;
        };
        v0
    }

    // decompiled from Move bytecode v6
}

