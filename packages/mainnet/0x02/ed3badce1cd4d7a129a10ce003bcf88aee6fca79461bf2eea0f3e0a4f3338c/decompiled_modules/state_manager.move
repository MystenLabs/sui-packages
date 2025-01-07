module 0x2ed3badce1cd4d7a129a10ce003bcf88aee6fca79461bf2eea0f3e0a4f3338c::state_manager {
    struct PlayerWaitList has key {
        id: 0x2::object::UID,
        lords: vector<address>,
        farmers: vector<address>,
    }

    struct RoomState has key {
        id: 0x2::object::UID,
        state: u8,
        player_addrs: vector<address>,
        cur_player_idx: u64,
        registed_players: vector<address>,
        pk: Pk,
        card_deck: CardDeck,
    }

    struct Pk has store, key {
        id: 0x2::object::UID,
        x0: u256,
        y0: u256,
        x1: u256,
        y1: u256,
        x2: u256,
        y2: u256,
    }

    struct CardDeck has store, key {
        id: 0x2::object::UID,
        X0: vector<u256>,
        X1: vector<u256>,
        Y0: vector<u256>,
        Y1: vector<u256>,
        selector0: u256,
        selector1: u256,
    }

    struct PlayerEvent has copy, drop {
        to_addr: vector<address>,
        action: u8,
        cards: vector<u8>,
        room_state_id: address,
    }

    struct RegistrationEvent has copy, drop {
        to_addr: vector<address>,
        pk_x0: u256,
        pk_y0: u256,
        pk_x1: u256,
        pk_y1: u256,
        pk_x2: u256,
        pk_y2: u256,
    }

    fun create_game(arg0: vector<address>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Pk{
            id : 0x2::object::new(arg1),
            x0 : 0,
            y0 : 0,
            x1 : 0,
            y1 : 0,
            x2 : 0,
            y2 : 0,
        };
        let v1 = CardDeck{
            id        : 0x2::object::new(arg1),
            X0        : vector[],
            X1        : vector[],
            Y0        : vector[],
            Y1        : vector[],
            selector0 : 0,
            selector1 : 0,
        };
        let v2 = RoomState{
            id               : 0x2::object::new(arg1),
            state            : 2,
            player_addrs     : arg0,
            cur_player_idx   : 0,
            registed_players : vector[],
            pk               : v0,
            card_deck        : v1,
        };
        let v3 = PlayerEvent{
            to_addr       : arg0,
            action        : 2,
            cards         : b"",
            room_state_id : 0x2::object::id_to_address(0x2::object::borrow_id<RoomState>(&v2)),
        };
        0x2::event::emit<PlayerEvent>(v3);
        0x2::transfer::share_object<RoomState>(v2);
    }

    public entry fun emit_dummy_PlayerEvent(arg0: address, arg1: u8, arg2: address, arg3: address) {
        let v0 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v0, arg0);
        let v1 = PlayerEvent{
            to_addr       : v0,
            action        : arg1,
            cards         : b"",
            room_state_id : arg2,
        };
        0x2::event::emit<PlayerEvent>(v1);
    }

    public entry fun emit_dummy_RegistrationEvent(arg0: address, arg1: u256, arg2: u256, arg3: u256, arg4: u256, arg5: u256, arg6: u256) {
        let v0 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v0, arg0);
        let v1 = RegistrationEvent{
            to_addr : v0,
            pk_x0   : arg1,
            pk_y0   : arg2,
            pk_x1   : arg3,
            pk_y1   : arg4,
            pk_x2   : arg5,
            pk_y2   : arg6,
        };
        0x2::event::emit<RegistrationEvent>(v1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PlayerWaitList{
            id      : 0x2::object::new(arg0),
            lords   : vector[],
            farmers : vector[],
        };
        0x2::transfer::share_object<PlayerWaitList>(v0);
    }

    public entry fun join_game(arg0: &mut PlayerWaitList, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(!0x1::vector::contains<address>(&arg0.lords, &v0), 0);
        let v1 = 0x2::tx_context::sender(arg2);
        assert!(!0x1::vector::contains<address>(&arg0.farmers, &v1), 0);
        if (arg1 == 0) {
            if (0x1::vector::length<address>(&arg0.farmers) > 1) {
                let v2 = 0x1::vector::empty<address>();
                let v3 = &mut v2;
                0x1::vector::push_back<address>(v3, 0x2::tx_context::sender(arg2));
                0x1::vector::push_back<address>(v3, 0x1::vector::pop_back<address>(&mut arg0.farmers));
                0x1::vector::push_back<address>(v3, 0x1::vector::pop_back<address>(&mut arg0.farmers));
                create_game(v2, arg2);
            } else {
                0x1::vector::push_back<address>(&mut arg0.lords, 0x2::tx_context::sender(arg2));
            };
        } else if (0x1::vector::length<address>(&arg0.lords) > 0 && 0x1::vector::length<address>(&arg0.farmers) > 0) {
            let v4 = 0x1::vector::empty<address>();
            let v5 = &mut v4;
            0x1::vector::push_back<address>(v5, 0x1::vector::pop_back<address>(&mut arg0.lords));
            0x1::vector::push_back<address>(v5, 0x1::vector::pop_back<address>(&mut arg0.farmers));
            0x1::vector::push_back<address>(v5, 0x2::tx_context::sender(arg2));
            create_game(v4, arg2);
        } else {
            0x1::vector::push_back<address>(&mut arg0.farmers, 0x2::tx_context::sender(arg2));
        };
    }

    public entry fun registe_pk(arg0: &mut RoomState, arg1: u256, arg2: u256, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.state == 2, 0);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x1::vector::contains<address>(&arg0.player_addrs, &v0), 0);
        let v1 = 0x2::tx_context::sender(arg3);
        assert!(!0x1::vector::contains<address>(&arg0.registed_players, &v1), 0);
        0x1::vector::push_back<address>(&mut arg0.registed_players, 0x2::tx_context::sender(arg3));
        if (0x1::vector::length<address>(&arg0.registed_players) == 3) {
            arg0.state = 2;
        };
        let v2 = vector[];
        let v3 = 0;
        while (v3 < 3) {
            if (*0x1::vector::borrow<address>(&arg0.player_addrs, v3) != 0x2::tx_context::sender(arg3)) {
                0x1::vector::push_back<address>(&mut v2, *0x1::vector::borrow<address>(&arg0.player_addrs, v3));
            };
        };
        if (0x1::vector::length<address>(&arg0.registed_players) == 3) {
            0x1::vector::destroy_empty<address>(arg0.registed_players);
            arg0.state = 3;
            arg0.cur_player_idx = 0;
            let v4 = &arg0.pk;
            let v5 = RegistrationEvent{
                to_addr : arg0.player_addrs,
                pk_x0   : v4.x0,
                pk_y0   : v4.y0,
                pk_x1   : v4.x1,
                pk_y1   : v4.y1,
                pk_x2   : v4.x2,
                pk_y2   : v4.y2,
            };
            0x2::event::emit<RegistrationEvent>(v5);
        };
    }

    fun set_next_player(arg0: &mut RoomState) : (u64, address) {
        arg0.cur_player_idx = (arg0.cur_player_idx + 1) % 3;
        (arg0.cur_player_idx, *0x1::vector::borrow<address>(&arg0.player_addrs, arg0.cur_player_idx))
    }

    public fun shuffle_card(arg0: &mut RoomState, arg1: &mut CardDeck, arg2: vector<u256>, arg3: vector<u256>, arg4: u256, arg5: u256, arg6: vector<u8>, arg7: vector<u8>, arg8: vector<u8>, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.state == 3, 0);
        assert!(*0x1::vector::borrow<address>(&arg0.player_addrs, arg0.cur_player_idx) == 0x2::tx_context::sender(arg9), 0);
        let v0 = 0x2::tx_context::sender(arg9);
        assert!(!0x1::vector::contains<address>(&arg0.registed_players, &v0), 0);
        0x1::vector::push_back<address>(&mut arg0.registed_players, 0x2::tx_context::sender(arg9));
        arg1.X0 = arg2;
        arg1.X1 = arg3;
        arg1.selector0 = arg4;
        arg1.selector1 = arg5;
        let (_, v2) = set_next_player(arg0);
        let v3 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v3, v2);
        let v4 = PlayerEvent{
            to_addr       : v3,
            action        : 3,
            cards         : b"",
            room_state_id : @0x0,
        };
        0x2::event::emit<PlayerEvent>(v4);
        if (0x1::vector::length<address>(&arg0.registed_players) == 3) {
            0x1::vector::destroy_empty<address>(arg0.registed_players);
            arg0.cur_player_idx = 1;
            arg0.state = 4;
            let v5 = 0x1::vector::empty<address>();
            0x1::vector::push_back<address>(&mut v5, *0x1::vector::borrow<address>(&arg0.player_addrs, arg0.cur_player_idx));
            let v6 = vector[b" 3", x"000f", x"101f"];
            let v7 = PlayerEvent{
                to_addr       : v5,
                action        : 4,
                cards         : *0x1::vector::borrow<vector<u8>>(&v6, arg0.cur_player_idx),
                room_state_id : @0x0,
            };
            0x2::event::emit<PlayerEvent>(v7);
        };
    }

    // decompiled from Move bytecode v6
}

