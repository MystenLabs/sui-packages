module 0xe11d715e138e5d5896e874ca120a773095ba5916d4f4f59eae150a6e2b0c325f::manage {
    struct Playground has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
        owner: address,
        manager_list: vector<address>,
    }

    struct PlayerRecord has store {
        nickname: 0x1::string::String,
        time: u64,
        step: u64,
    }

    struct Manage has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
        enable: bool,
        total: u64,
        players: 0x2::table::Table<address, 0xe11d715e138e5d5896e874ca120a773095ba5916d4f4f59eae150a6e2b0c325f::player::Player>,
        record: PlayerRecord,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        fee: u64,
        owner: address,
        config_id: 0x2::object::ID,
        maps_count: u64,
    }

    struct ManagerMinted has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    struct UpdateRecord has copy, drop {
        player_address: address,
        record: u64,
        reason: 0x1::string::String,
    }

    public fun borrow(arg0: &Manage, arg1: address) : &0xe11d715e138e5d5896e874ca120a773095ba5916d4f4f59eae150a6e2b0c325f::player::Player {
        let v0 = 0x1::string::utf8(b"borrow");
        0x1::debug::print<0x1::string::String>(&v0);
        0x2::table::borrow<address, 0xe11d715e138e5d5896e874ca120a773095ba5916d4f4f59eae150a6e2b0c325f::player::Player>(&arg0.players, arg1)
    }

    public fun borrow_mut(arg0: &mut Manage, arg1: address) : &mut 0xe11d715e138e5d5896e874ca120a773095ba5916d4f4f59eae150a6e2b0c325f::player::Player {
        let v0 = 0x1::string::utf8(b"borrow_mut");
        0x1::debug::print<0x1::string::String>(&v0);
        0x2::table::borrow_mut<address, 0xe11d715e138e5d5896e874ca120a773095ba5916d4f4f59eae150a6e2b0c325f::player::Player>(&mut arg0.players, arg1)
    }

    public fun remove(arg0: &mut Manage, arg1: address) : 0xe11d715e138e5d5896e874ca120a773095ba5916d4f4f59eae150a6e2b0c325f::player::Player {
        let v0 = 0x1::string::utf8(b"remove");
        0x1::debug::print<0x1::string::String>(&v0);
        0x2::table::remove<address, 0xe11d715e138e5d5896e874ca120a773095ba5916d4f4f59eae150a6e2b0c325f::player::Player>(&mut arg0.players, arg1)
    }

    public entry fun create_manager(arg0: &mut Playground, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0xe11d715e138e5d5896e874ca120a773095ba5916d4f4f59eae150a6e2b0c325f::market::initialize_maps(b"Sokoban", b"Sokoban Maps", b"", arg4);
        let v2 = PlayerRecord{
            nickname : 0x1::string::utf8(b"nobody"),
            time     : 1000000000,
            step     : 1000000000,
        };
        let v3 = Manage{
            id          : 0x2::object::new(arg4),
            name        : 0x1::string::utf8(arg1),
            description : 0x1::string::utf8(arg2),
            url         : 0x2::url::new_unsafe_from_bytes(arg3),
            enable      : true,
            total       : 0,
            players     : 0x2::table::new<address, 0xe11d715e138e5d5896e874ca120a773095ba5916d4f4f59eae150a6e2b0c325f::player::Player>(arg4),
            record      : v2,
            balance     : 0x2::balance::zero<0x2::sui::SUI>(),
            fee         : 1000000,
            owner       : v0,
            config_id   : 0x2::object::id<0xe11d715e138e5d5896e874ca120a773095ba5916d4f4f59eae150a6e2b0c325f::market::PushBox>(&v1),
            maps_count  : 0,
        };
        let v4 = ManagerMinted{
            object_id : 0x2::object::id<Manage>(&v3),
            creator   : v0,
            name      : v3.name,
        };
        0x2::event::emit<ManagerMinted>(v4);
        0x1::vector::push_back<address>(&mut arg0.manager_list, 0x2::object::id_address<Manage>(&v3));
        0x2::transfer::public_transfer<0xe11d715e138e5d5896e874ca120a773095ba5916d4f4f59eae150a6e2b0c325f::market::PushBox>(v1, 0x2::tx_context::sender(arg4));
        0x2::transfer::public_share_object<Manage>(v3);
    }

    public entry fun create_playground(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Playground{
            id           : 0x2::object::new(arg3),
            name         : 0x1::string::utf8(arg0),
            description  : 0x1::string::utf8(arg1),
            url          : 0x2::url::new_unsafe_from_bytes(arg2),
            owner        : 0x2::tx_context::sender(arg3),
            manager_list : vector[],
        };
        0x2::transfer::public_share_object<Playground>(v0);
    }

    public fun description(arg0: &Manage) : &0x1::string::String {
        &arg0.description
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    public entry fun join_game(arg0: &mut Manage, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        if (0x2::table::contains<address, 0xe11d715e138e5d5896e874ca120a773095ba5916d4f4f59eae150a6e2b0c325f::player::Player>(&arg0.players, v0)) {
            let v1 = 0x1::string::utf8(b"player is exist.");
            0x1::debug::print<0x1::string::String>(&v1);
        } else {
            let v2 = 0x1::string::utf8(b"add player");
            0x1::debug::print<0x1::string::String>(&v2);
            let v3 = 0x1::string::utf8(arg1);
            0x1::string::append_utf8(&mut v3, b"'s played maps");
            let v4 = 0xe11d715e138e5d5896e874ca120a773095ba5916d4f4f59eae150a6e2b0c325f::market::initialize_maps(b"player_map", 0x1::string::into_bytes(v3), b"", arg2);
            0x2::table::add<address, 0xe11d715e138e5d5896e874ca120a773095ba5916d4f4f59eae150a6e2b0c325f::player::Player>(&mut arg0.players, v0, 0xe11d715e138e5d5896e874ca120a773095ba5916d4f4f59eae150a6e2b0c325f::player::create_player(arg1, &v4, arg2));
            arg0.total = arg0.total + 1;
            0x2::transfer::public_transfer<0xe11d715e138e5d5896e874ca120a773095ba5916d4f4f59eae150a6e2b0c325f::market::PushBox>(v4, 0x2::tx_context::sender(arg2));
        };
    }

    public fun name(arg0: &Manage) : &0x1::string::String {
        &arg0.name
    }

    public entry fun play_game(arg0: &mut Manage, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) == arg0.fee, 0);
        let v0 = 0x2::tx_context::sender(arg2);
        if (0x2::table::contains<address, 0xe11d715e138e5d5896e874ca120a773095ba5916d4f4f59eae150a6e2b0c325f::player::Player>(&arg0.players, v0)) {
            let v1 = 0x1::string::utf8(b"player is exist.");
            0x1::debug::print<0x1::string::String>(&v1);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, 0x2::tx_context::sender(arg2));
        } else {
            let v2 = 0x1::string::utf8(b"add player");
            0x1::debug::print<0x1::string::String>(&v2);
            let v3 = 0xe11d715e138e5d5896e874ca120a773095ba5916d4f4f59eae150a6e2b0c325f::market::initialize_maps(b"player_map", b"", b"", arg2);
            0x2::table::add<address, 0xe11d715e138e5d5896e874ca120a773095ba5916d4f4f59eae150a6e2b0c325f::player::Player>(&mut arg0.players, v0, 0xe11d715e138e5d5896e874ca120a773095ba5916d4f4f59eae150a6e2b0c325f::player::create_player(b"", &v3, arg2));
            arg0.total = arg0.total + 1;
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, arg0.owner);
            0x2::transfer::public_transfer<0xe11d715e138e5d5896e874ca120a773095ba5916d4f4f59eae150a6e2b0c325f::market::PushBox>(v3, 0x2::tx_context::sender(arg2));
        };
    }

    public entry fun update_description(arg0: &mut Manage, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.description = 0x1::string::utf8(arg1);
    }

    public entry fun update_fee(arg0: &mut Manage, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.fee = arg1;
    }

    public entry fun update_maps_count(arg0: &mut Manage, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.maps_count = arg1;
    }

    public entry fun update_name(arg0: &mut Manage, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.name = 0x1::string::utf8(arg1);
    }

    public entry fun update_record(arg0: &mut Manage, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: vector<u8>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) == 1000000, 0);
        assert!(0x1::vector::length<u8>(&arg2) <= 10, 1);
        let v0 = 0x2::tx_context::sender(arg5);
        if (0x2::table::contains<address, 0xe11d715e138e5d5896e874ca120a773095ba5916d4f4f59eae150a6e2b0c325f::player::Player>(&arg0.players, v0)) {
            let v1 = 0x1::string::utf8(b"update record");
            0x1::debug::print<0x1::string::String>(&v1);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, arg0.owner);
            if (arg3 < arg0.record.time && arg3 > 0) {
                arg0.record.nickname = 0x1::string::utf8(arg2);
                arg0.record.time = arg3;
                let v2 = UpdateRecord{
                    player_address : v0,
                    record         : arg3,
                    reason         : 0x1::string::utf8(b"time record"),
                };
                0x2::event::emit<UpdateRecord>(v2);
            };
            if (arg4 < arg0.record.step && arg4 > 0) {
                arg0.record.nickname = 0x1::string::utf8(arg2);
                arg0.record.step = arg4;
                let v3 = UpdateRecord{
                    player_address : v0,
                    record         : arg4,
                    reason         : 0x1::string::utf8(b"step record"),
                };
                0x2::event::emit<UpdateRecord>(v3);
            };
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, 0x2::tx_context::sender(arg5));
        };
    }

    // decompiled from Move bytecode v6
}

