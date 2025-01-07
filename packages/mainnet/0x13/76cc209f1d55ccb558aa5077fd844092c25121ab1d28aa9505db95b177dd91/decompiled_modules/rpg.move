module 0x1376cc209f1d55ccb558aa5077fd844092c25121ab1d28aa9505db95b177dd91::rpg {
    struct Prompt has store, key {
        id: 0x2::object::UID,
        content: 0x1::string::String,
    }

    struct GamePrompt has store, key {
        id: 0x2::object::UID,
        image_url: 0x1::string::String,
        content: 0x1::string::String,
    }

    struct Game has store, key {
        id: 0x2::object::UID,
        index: u64,
        player: address,
        eth_address: 0x1::string::String,
        user_selections: 0x2::table::Table<u64, u8>,
        prompts: 0x2::table::Table<u64, GamePrompt>,
        is_finished: bool,
    }

    struct GamesRegistry has store, key {
        id: 0x2::object::UID,
        games: 0x2::table::Table<u64, Game>,
    }

    struct Score has store, key {
        id: 0x2::object::UID,
        eth_address: 0x1::string::String,
        hp_left: u64,
        turns: u64,
    }

    struct Scoreboard has store, key {
        id: 0x2::object::UID,
        scores: 0x2::table::Table<u64, Score>,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    public fun add_game_answer(arg0: u8, arg1: &mut GamesRegistry, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0 < 4, 1);
        let v0 = 0x2::table::borrow_mut<u64, Game>(&mut arg1.games, arg2);
        assert!(v0.player == 0x2::tx_context::sender(arg3), 0);
        assert!(v0.is_finished == false, 3);
        let v1 = 0x2::table::length<u64, u8>(&v0.user_selections);
        assert!(0x2::table::length<u64, GamePrompt>(&v0.prompts) - v1 == 1, 1);
        0x2::table::add<u64, u8>(&mut v0.user_selections, v1, arg0);
    }

    public fun add_game_prompt(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: &mut GamesRegistry, arg3: u64, arg4: bool, arg5: &AdminCap, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::table::borrow_mut<u64, Game>(&mut arg2.games, arg3);
        let v1 = 0x2::table::length<u64, GamePrompt>(&v0.prompts);
        assert!(v1 - 0x2::table::length<u64, u8>(&v0.user_selections) == 0, 1);
        let v2 = GamePrompt{
            id        : 0x2::object::new(arg6),
            image_url : arg1,
            content   : arg0,
        };
        0x2::table::add<u64, GamePrompt>(&mut v0.prompts, v1, v2);
        v0.is_finished = arg4;
    }

    public fun add_score(arg0: 0x1::string::String, arg1: u64, arg2: u64, arg3: &mut Scoreboard, arg4: &AdminCap, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = Score{
            id          : 0x2::object::new(arg5),
            eth_address : arg0,
            hp_left     : arg1,
            turns       : arg2,
        };
        0x2::table::add<u64, Score>(&mut arg3.scores, 0x2::table::length<u64, Score>(&arg3.scores), v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Prompt{
            id      : 0x2::object::new(arg0),
            content : 0x1::string::utf8(x"596f75206172652061206e61727261746f7220666f72206120746578742062617365642067616d652073657420696e2061206675747572697374696320776f726c642077686572652074686520706c61796572206973206669676874696e67207769746820225649494c494b222c20612063727970746f206461726b206c6f7264206861636b65722074686174206c6f6f6b73206c696b65206120687962726964206f662061206d616e20616e64206120646f672077697468203220686561647320616e6420697320746174746f6f65642066756c6c206f662063727970746f206c6f676f732e20486520686f6c64732062756e6368206f6620776569726420776561706f6e7320616e64207573657320756e69717565206669676874696e67207374796c657320746f206465666561742074686520706c617965722e200a0a5468652067616d6520697320706c6179656420696e207475726e7320776865726520796f752070726573656e742074686520706c61796572207769746820666f7572206f7074696f6e732028612c20622c20632c2064292061742065616368207475726e20746f2063686f6f7365207468656972206e65787420616374696f6e2c2074686520706c617965722063616e206f6e6c79207069636b206f6e65206f6620746865206f7074696f6e732c206e6f742061646420616e797468696e67207468656d73656c7665732e2047656e657261746520746865206f7074696f6e732073686f727420616e642070756e6368792c206e6f7420746f6f20766572626f73652e20426f74682074686520706c6179657220616e6420225649494c494b2220737461727420776974682031302c30303020485020616e6420796f7520696e637265617365206f722064656372656173652074686569722048502061667465722065616368207475726e2e200a0a546f20626567696e20776974682067656e657261746520616e20696d61676520746f2073686f7720626174746c6567726f756e6420616e64205649494c494b20776865726520796f752061736b2066726f6d2074686520706c6179657220776861742063686172616374657220746f20706c61792061732028636f6d65207570207769746820616e696d616c7320746f2073656c6563742066726f6d2c2061646420736f6d652061646a65637469766520746f206d616b652069742066756e6e79292e20506c656173652067656e6572617465206163636f7264696e6720696d61676573206f6620706c617965722773206368617261637465722e0a0a52656d656d62657220746f2067656e657261746520616e20696d616765206f6e206576657279207475726e206f6620686f772074686520626174746c6520706c617973206f757420776865726520796f75206164642061207265616c6c792073686f7274206465736372697074696f6e20746861742064657363726962657320746865207363656e6172696f2061742068616e642e204b65657020612066756e6e7920746f6e652e204372656174652066756e6e7920696d6167657320616e6420696d6d6572736976652c2074727920746f206b65657020612073746f72796c696e652e2050757420696d616765206465736372697074696f6e20696e205b494d4147455d20746167732e204d616b6520696d616765206465736372697074696f6e2061732070726f6d707420666f722044414c4c2d4520332e2041766f69642072657665616c696e6720667574757265206f7574636f6d6573206f722073756767657374696e672061202762657374272063686f6963653b20656163682073686f756c64207365656d20766961626c6520746f206d61696e7461696e207468652067616d6527732073757370656e73652e205468652067616d6520737461727473207768656e207573657220736179732073746172742e2052656d656d62657220746f206b65657020747261636b206f66205649494c494b277320616e6420706c6179657227732048502c20495420495320414c534f20706f737369626c65207468617420706c6179657227732063686f69636520687572747320686973206f776e2048502c20796f752064656369646520746861742061732061206e61727261746f72206261736564206f6e20706c6179657227732063686f6963652e204d696e696d756d20485020686974206973203130303020616e64206d617820353030302e0a53686f77204850206f6e206576657279207475726e206c696b6520746869733a0a796f75722048503a207b6e756d6265727d0a5649494c494b2048503a207b6e756d6265727d"),
        };
        0x2::transfer::transfer<Prompt>(v0, 0x2::tx_context::sender(arg0));
        let v1 = GamesRegistry{
            id    : 0x2::object::new(arg0),
            games : 0x2::table::new<u64, Game>(arg0),
        };
        0x2::transfer::share_object<GamesRegistry>(v1);
        let v2 = Scoreboard{
            id     : 0x2::object::new(arg0),
            scores : 0x2::table::new<u64, Score>(arg0),
        };
        0x2::transfer::share_object<Scoreboard>(v2);
        let v3 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v3, 0x2::tx_context::sender(arg0));
    }

    public fun start_game(arg0: 0x1::string::String, arg1: &mut GamesRegistry, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::table::length<u64, Game>(&arg1.games);
        let v1 = Game{
            id              : 0x2::object::new(arg2),
            index           : v0,
            player          : 0x2::tx_context::sender(arg2),
            eth_address     : arg0,
            user_selections : 0x2::table::new<u64, u8>(arg2),
            prompts         : 0x2::table::new<u64, GamePrompt>(arg2),
            is_finished     : false,
        };
        0x2::table::add<u64, Game>(&mut arg1.games, v0, v1);
    }

    // decompiled from Move bytecode v6
}

