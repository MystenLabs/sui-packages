module 0x9185a11eeed71b0d8084a0f70289b2547e07185b986059394b6d036307331882::bp {
    struct BP has drop {
        dummy_field: bool,
    }

    struct LobbyManager has key {
        id: 0x2::object::UID,
        manager_address: address,
        board_count: u64,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct PlayerBoard has store, key {
        id: 0x2::object::UID,
        board_num: u64,
        player: address,
        current_board: 0x9185a11eeed71b0d8084a0f70289b2547e07185b986059394b6d036307331882::board::Round,
        image_url: 0x2::url::Url,
    }

    struct EventStartBoard has copy, drop {
        board_id: 0x2::object::ID,
        player: address,
    }

    struct EventNewRound has copy, drop {
        board_id: 0x2::object::ID,
        player: address,
        stage: u64,
    }

    struct EventEndBoard has copy, drop {
        board_id: 0x2::object::ID,
        player: address,
        stage: u64,
    }

    public fun current_stage(arg0: &PlayerBoard) : &u64 {
        0x9185a11eeed71b0d8084a0f70289b2547e07185b986059394b6d036307331882::board::current_stage(current_board(arg0))
    }

    public entry fun EndBoard(arg0: PlayerBoard, arg1: &mut LobbyManager, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg1.manager_address, 1);
        arg0.image_url = 0x2::url::new_unsafe_from_bytes(arg2);
        0x2::transfer::public_transfer<PlayerBoard>(arg0, arg0.player);
    }

    public fun LobbyManagerAddress(arg0: &mut LobbyManager) : &address {
        &arg0.manager_address
    }

    public entry fun StartBoard(arg0: &mut LobbyManager, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg0.manager_address, 1);
        let v1 = PlayerBoard{
            id            : 0x2::object::new(arg2),
            board_num     : arg0.board_count + 1,
            player        : arg1,
            current_board : 0x9185a11eeed71b0d8084a0f70289b2547e07185b986059394b6d036307331882::board::new_board(),
            image_url     : 0x2::url::new_unsafe_from_bytes(b""),
        };
        arg0.board_count = arg0.board_count + 1;
        let v2 = EventStartBoard{
            board_id : 0x2::object::uid_to_inner(&v1.id),
            player   : arg1,
        };
        0x2::event::emit<EventStartBoard>(v2);
        0x2::transfer::public_transfer<PlayerBoard>(v1, v0);
    }

    public entry fun UpdateBoard(arg0: &mut PlayerBoard, arg1: &mut LobbyManager, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg1.manager_address, 1);
        let v0 = arg0.current_board;
        0x9185a11eeed71b0d8084a0f70289b2547e07185b986059394b6d036307331882::board::update_stage(&mut v0, arg2, arg3);
        arg0.current_board = v0;
    }

    public fun board_id(arg0: &PlayerBoard) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun board_num(arg0: &PlayerBoard) : u64 {
        arg0.board_num
    }

    public(friend) fun create_lobbymanager(arg0: &mut 0x2::tx_context::TxContext) : LobbyManager {
        LobbyManager{
            id              : 0x2::object::new(arg0),
            manager_address : 0x2::tx_context::sender(arg0),
            board_count     : 0,
            balance         : 0x2::balance::zero<0x2::sui::SUI>(),
        }
    }

    public fun current_board(arg0: &PlayerBoard) : &0x9185a11eeed71b0d8084a0f70289b2547e07185b986059394b6d036307331882::board::Round {
        &arg0.current_board
    }

    fun init(arg0: BP, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::types::is_one_time_witness<BP>(&arg0), 0);
        let v0 = 0x2::package::claim<BP>(arg0, arg1);
        let v1 = 0x2::display::new<PlayerBoard>(&v0, arg1);
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"id"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"url"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"creator"));
        let v4 = 0x1::vector::empty<0x1::string::String>();
        let v5 = &mut v4;
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{id}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"Brick Pop"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"Inno Platform's On-Chain Game"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"https://inno.onbuff.com"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"ONBUFF"));
        0x2::display::add_multiple<PlayerBoard>(&mut v1, v2, v4);
        0x2::display::update_version<PlayerBoard>(&mut v1);
        0x2::transfer::public_transfer<0x2::display::Display<PlayerBoard>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<LobbyManager>(create_lobbymanager(arg1));
    }

    public fun player(arg0: &PlayerBoard) : &address {
        &arg0.player
    }

    // decompiled from Move bytecode v6
}

