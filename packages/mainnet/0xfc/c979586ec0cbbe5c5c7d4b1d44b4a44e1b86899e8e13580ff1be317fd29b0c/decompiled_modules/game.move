module 0xfcc979586ec0cbbe5c5c7d4b1d44b4a44e1b86899e8e13580ff1be317fd29b0c::game {
    struct GAME has drop {
        dummy_field: bool,
    }

    struct AlphabetNFT has store, key {
        id: 0x2::object::UID,
        letter: 0x1::string::String,
        svg: 0x1::string::String,
    }

    struct WordNFT has store, key {
        id: 0x2::object::UID,
        word: 0x1::string::String,
    }

    struct GameState has key {
        id: 0x2::object::UID,
        words: vector<0x1::string::String>,
        last_updated: u64,
        player_states: 0x2::table::Table<address, PlayerState>,
    }

    struct PlayerState has store {
        last_mint: u64,
    }

    struct WordCreated has copy, drop {
        player: address,
        word: 0x1::string::String,
    }

    fun create_alphabet_nft(arg0: u8, arg1: &mut 0x2::tx_context::TxContext) : AlphabetNFT {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::push_back<u8>(&mut v0, arg0);
        AlphabetNFT{
            id     : 0x2::object::new(arg1),
            letter : 0x1::string::utf8(v0),
            svg    : 0xfcc979586ec0cbbe5c5c7d4b1d44b4a44e1b86899e8e13580ff1be317fd29b0c::svg::get_svg(arg0),
        }
    }

    public entry fun create_word(arg0: &mut GameState, arg1: vector<AlphabetNFT>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = b"";
        let v2 = 0;
        while (v2 < 0x1::vector::length<AlphabetNFT>(&arg1)) {
            0x1::vector::append<u8>(&mut v1, *0x1::string::bytes(&0x1::vector::borrow<AlphabetNFT>(&arg1, v2).letter));
            v2 = v2 + 1;
        };
        assert!(0x1::vector::length<u8>(&v1) >= 3, 0);
        let v3 = 0x1::string::utf8(v1);
        assert!(0x1::vector::contains<0x1::string::String>(&arg0.words, &v3) == false, 1);
        let v4 = *0x1::string::bytes(0x1::vector::borrow<0x1::string::String>(&arg0.words, 0x1::vector::length<0x1::string::String>(&arg0.words) - 1));
        assert!(*0x1::vector::borrow<u8>(&v1, 0) == 0x1::vector::pop_back<u8>(&mut v4), 2);
        0x1::vector::push_back<0x1::string::String>(&mut arg0.words, 0x1::string::utf8(v1));
        arg0.last_updated = 0x2::clock::timestamp_ms(arg2);
        let v5 = WordNFT{
            id   : 0x2::object::new(arg3),
            word : 0x1::string::utf8(v1),
        };
        0x2::transfer::transfer<WordNFT>(v5, v0);
        let v6 = WordCreated{
            player : v0,
            word   : 0x1::string::utf8(v1),
        };
        0x2::event::emit<WordCreated>(v6);
        while (!0x1::vector::is_empty<AlphabetNFT>(&arg1)) {
            let AlphabetNFT {
                id     : v7,
                letter : _,
                svg    : _,
            } = 0x1::vector::pop_back<AlphabetNFT>(&mut arg1);
            0x2::object::delete(v7);
        };
        0x1::vector::destroy_empty<AlphabetNFT>(arg1);
    }

    fun init(arg0: GAME, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = GameState{
            id            : 0x2::object::new(arg1),
            words         : 0x1::vector::singleton<0x1::string::String>(0x1::string::utf8(b"START")),
            last_updated  : 0,
            player_states : 0x2::table::new<address, PlayerState>(arg1),
        };
        0x2::transfer::share_object<GameState>(v0);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"Alphabet NFT {letter}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"data:image/svg+xml;base64,{svg}"));
        let v5 = 0x2::package::claim<GAME>(arg0, arg1);
        let v6 = 0x2::display::new_with_fields<AlphabetNFT>(&v5, v1, v3, arg1);
        0x2::display::update_version<AlphabetNFT>(&mut v6);
        0x2::transfer::public_transfer<0x2::display::Display<AlphabetNFT>>(v6, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v5, 0x2::tx_context::sender(arg1));
    }

    entry fun mint_daily_nfts(arg0: &mut GameState, arg1: &0x2::clock::Clock, arg2: &0x2::random::Random, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::random::new_generator(arg2, arg3);
        let v2 = 0;
        while (v2 < 0x2::random::generate_u8_in_range(&mut v1, 1, 10)) {
            let v3 = &mut v1;
            let v4 = create_alphabet_nft(weighted_random_letter(v3), arg3);
            0x2::transfer::transfer<AlphabetNFT>(v4, v0);
            v2 = v2 + 1;
        };
        0x2::transfer::transfer<AlphabetNFT>(create_alphabet_nft(84, arg3), v0);
        if (0x2::table::contains<address, PlayerState>(&arg0.player_states, v0)) {
            0x2::table::borrow_mut<address, PlayerState>(&mut arg0.player_states, v0).last_mint = 0x2::clock::timestamp_ms(arg1);
        } else {
            let v5 = PlayerState{last_mint: 0x2::clock::timestamp_ms(arg1)};
            0x2::table::add<address, PlayerState>(&mut arg0.player_states, v0, v5);
        };
    }

    fun weighted_random_letter(arg0: &mut 0x2::random::RandomGenerator) : u8 {
        if (0x2::random::generate_u8_in_range(arg0, 0, 99) < 50) {
            let v1 = b"ETAOINS";
            *0x1::vector::borrow<u8>(&v1, 0x2::random::generate_u64_in_range(arg0, 0, 6))
        } else {
            0x2::random::generate_u8_in_range(arg0, 65, 90)
        }
    }

    // decompiled from Move bytecode v6
}

