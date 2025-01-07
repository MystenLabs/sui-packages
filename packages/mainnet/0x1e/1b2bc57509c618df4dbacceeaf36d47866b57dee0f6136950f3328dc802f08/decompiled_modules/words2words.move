module 0x1e1b2bc57509c618df4dbacceeaf36d47866b57dee0f6136950f3328dc802f08::words2words {
    struct WordsData has store, key {
        id: 0x2::object::UID,
        funds: 0x2::balance::Balance<0x2::sui::SUI>,
        admin: address,
        beneficiary: address,
    }

    struct Pack has drop, store {
        parts_of_speech: 0x2::vec_map::VecMap<0x1::string::String, u64>,
        words: 0x2::vec_map::VecMap<0x1::string::String, vector<0x1::string::String>>,
        name: 0x1::string::String,
        price: u64,
        background: 0x1::string::String,
    }

    struct Word has store, key {
        id: 0x2::object::UID,
        word: 0x1::string::String,
        part_of_speech: 0x1::string::String,
        background: 0x1::string::String,
        pack: 0x1::string::String,
    }

    struct Sentence has store, key {
        id: 0x2::object::UID,
        sentence: 0x1::string::String,
        background_image: 0x1::string::String,
        title: 0x1::string::String,
        author: 0x1::string::String,
        image_url: 0x1::string::String,
        created_at: u64,
        words: vector<0x1::string::String>,
        parts_of_speech: vector<0x1::string::String>,
        words_packs: vector<0x1::string::String>,
        words_backgrounds: vector<0x1::string::String>,
    }

    struct WORDS2WORDS has drop {
        dummy_field: bool,
    }

    public entry fun add_pack(arg0: vector<u8>, arg1: u64, arg2: vector<u8>, arg3: vector<u64>, arg4: &mut WordsData, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg4.admin == 0x2::tx_context::sender(arg5), 1);
        let v0 = 0x2::vec_map::empty<0x1::string::String, u64>();
        let v1 = 0;
        let v2 = vector[b"nouns_3_4_letters", b"nouns_5_6_letters", b"nouns_7_9_letters", b"verbs_action", b"verbs_past_tense_irregular", b"verbs_linking", b"verbs_helping", b"adjectives_3_4_letters", b"adjectives_5_6_letters", b"adjectives_7_8_letters", b"adverbs_2_5_letters", b"adverbs_6_7_letters", b"adverbs_8_9_letters", b"conjunctions_coordinating", b"conjunctions_subordinating", b"pronouns_group_1", b"pronouns_group_2", b"pronouns_group_3", b"prepositions_group_1", b"prepositions_group_2", b"prepositions_group_3", b"interjections", b"suffixes", b"articles"];
        while (v1 < 0x1::vector::length<vector<u8>>(&v2)) {
            let v3 = vector[b"nouns_3_4_letters", b"nouns_5_6_letters", b"nouns_7_9_letters", b"verbs_action", b"verbs_past_tense_irregular", b"verbs_linking", b"verbs_helping", b"adjectives_3_4_letters", b"adjectives_5_6_letters", b"adjectives_7_8_letters", b"adverbs_2_5_letters", b"adverbs_6_7_letters", b"adverbs_8_9_letters", b"conjunctions_coordinating", b"conjunctions_subordinating", b"pronouns_group_1", b"pronouns_group_2", b"pronouns_group_3", b"prepositions_group_1", b"prepositions_group_2", b"prepositions_group_3", b"interjections", b"suffixes", b"articles"];
            0x2::vec_map::insert<0x1::string::String, u64>(&mut v0, 0x1::string::utf8(*0x1::vector::borrow<vector<u8>>(&v3, v1)), *0x1::vector::borrow<u64>(&arg3, v1));
            v1 = v1 + 1;
        };
        let v4 = Pack{
            parts_of_speech : v0,
            words           : 0x2::vec_map::empty<0x1::string::String, vector<0x1::string::String>>(),
            name            : 0x1::string::utf8(arg0),
            price           : arg1,
            background      : 0x1::string::utf8(arg2),
        };
        0x2::dynamic_field::add<0x1::string::String, Pack>(&mut arg4.id, 0x1::string::utf8(arg0), v4);
    }

    public entry fun add_part_of_speech_words(arg0: vector<u8>, arg1: &mut WordsData, arg2: vector<vector<u8>>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.admin == 0x2::tx_context::sender(arg3), 1);
        let v0 = 0x1::vector::empty<0x1::string::String>();
        while (!0x1::vector::is_empty<vector<u8>>(&arg2)) {
            0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(0x1::vector::pop_back<vector<u8>>(&mut arg2)));
        };
        0x2::dynamic_field::add<0x1::string::String, vector<0x1::string::String>>(&mut arg1.id, 0x1::string::utf8(arg0), v0);
    }

    public entry fun add_special_pack(arg0: vector<u8>, arg1: u64, arg2: vector<u8>, arg3: vector<u64>, arg4: vector<vector<u8>>, arg5: &mut WordsData, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg5.admin == 0x2::tx_context::sender(arg6), 1);
        let v0 = 0x2::vec_map::empty<0x1::string::String, u64>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(&arg3)) {
            0x2::vec_map::insert<0x1::string::String, u64>(&mut v0, 0x1::string::utf8(*0x1::vector::borrow<vector<u8>>(&arg4, v1)), *0x1::vector::borrow<u64>(&arg3, v1));
            v1 = v1 + 1;
        };
        let v2 = Pack{
            parts_of_speech : v0,
            words           : 0x2::vec_map::empty<0x1::string::String, vector<0x1::string::String>>(),
            name            : 0x1::string::utf8(arg0),
            price           : arg1,
            background      : 0x1::string::utf8(arg2),
        };
        0x2::dynamic_field::add<0x1::string::String, Pack>(&mut arg5.id, 0x1::string::utf8(arg0), v2);
    }

    public entry fun add_special_pack_pos(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<vector<u8>>, arg3: &mut WordsData, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg3.admin == 0x2::tx_context::sender(arg4), 1);
        let v0 = 0x1::vector::empty<0x1::string::String>();
        while (!0x1::vector::is_empty<vector<u8>>(&arg2)) {
            0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(0x1::vector::pop_back<vector<u8>>(&mut arg2)));
        };
        0x2::vec_map::insert<0x1::string::String, vector<0x1::string::String>>(&mut 0x2::dynamic_field::borrow_mut<0x1::string::String, Pack>(&mut arg3.id, 0x1::string::utf8(arg0)).words, 0x1::string::utf8(arg1), v0);
    }

    public entry fun end_pack(arg0: vector<u8>, arg1: &mut WordsData, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.admin == 0x2::tx_context::sender(arg2), 1);
        0x2::dynamic_field::remove<0x1::string::String, Pack>(&mut arg1.id, 0x1::string::utf8(arg0));
    }

    fun init(arg0: WORDS2WORDS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<WORDS2WORDS>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"word"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{word}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{word}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://ui-avatars.com/api/?name={word}&length=20&size=512&font-size=0.1&bold=true&background={background}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"Word NFT"));
        let v5 = 0x2::display::new_with_fields<Word>(&v0, v1, v3, arg1);
        0x2::display::update_version<Word>(&mut v5);
        0x2::transfer::public_transfer<0x2::display::Display<Word>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = 0x1::vector::empty<0x1::string::String>();
        let v7 = &mut v6;
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"poem"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"title"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"author"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"background"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"createdAt"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"description"));
        let v8 = 0x1::vector::empty<0x1::string::String>();
        let v9 = &mut v8;
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"{title}"));
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"{sentence}"));
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"{title}"));
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"{author}"));
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"{background}"));
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"{created_at}"));
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"Poem NFT"));
        let v10 = 0x2::display::new_with_fields<Sentence>(&v0, v6, v8, arg1);
        0x2::display::update_version<Sentence>(&mut v10);
        0x2::transfer::public_transfer<0x2::display::Display<Sentence>>(v10, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        let v11 = WordsData{
            id          : 0x2::object::new(arg1),
            funds       : 0x2::balance::zero<0x2::sui::SUI>(),
            admin       : 0x2::tx_context::sender(arg1),
            beneficiary : 0x2::tx_context::sender(arg1),
        };
        0x2::transfer::share_object<WordsData>(v11);
    }

    fun internal_mint_and_transfer_word(arg0: address, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = Word{
            id             : 0x2::object::new(arg5),
            word           : arg1,
            part_of_speech : arg2,
            background     : arg3,
            pack           : arg4,
        };
        0x2::transfer::public_transfer<Word>(v0, arg0);
    }

    fun internal_mint_booster_pack_and_transfer_words(arg0: address, arg1: vector<u8>, arg2: &mut WordsData, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::dynamic_field::borrow<0x1::string::String, Pack>(&arg2.id, 0x1::string::utf8(arg1));
        assert!(v0.price == 0x2::coin::value<0x2::sui::SUI>(&arg3), 0);
        let v1 = 0;
        let v2 = 0x2::vec_map::keys<0x1::string::String, vector<0x1::string::String>>(&v0.words);
        while (v1 < 0x1::vector::length<0x1::string::String>(&v2)) {
            let v3 = 0x1::vector::borrow<0x1::string::String>(&v2, v1);
            let v4 = 0x2::vec_map::get<0x1::string::String, u64>(&v0.parts_of_speech, v3);
            let v5 = *0x2::vec_map::get<0x1::string::String, vector<0x1::string::String>>(&v0.words, v3);
            let v6 = 0;
            while (v6 < *v4) {
                let v7 = random_index(0x1::vector::length<0x1::string::String>(&v5), arg4);
                internal_mint_and_transfer_word(arg0, *0x1::vector::borrow<0x1::string::String>(&v5, v7), *v3, v0.background, v0.name, arg4);
                0x1::vector::remove<0x1::string::String>(&mut v5, v7);
                v6 = v6 + 1;
            };
            v1 = v1 + 1;
        };
        0x2::coin::put<0x2::sui::SUI>(&mut arg2.funds, arg3);
    }

    fun internal_mint_pack_and_transfer_words(arg0: address, arg1: vector<u8>, arg2: &mut WordsData, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::dynamic_field::borrow<0x1::string::String, Pack>(&arg2.id, 0x1::string::utf8(arg1));
        assert!(v0.price == 0x2::coin::value<0x2::sui::SUI>(&arg3), 0);
        let v1 = 0;
        loop {
            let v2 = vector[b"nouns_3_4_letters", b"nouns_5_6_letters", b"nouns_7_9_letters", b"verbs_action", b"verbs_past_tense_irregular", b"verbs_linking", b"verbs_helping", b"adjectives_3_4_letters", b"adjectives_5_6_letters", b"adjectives_7_8_letters", b"adverbs_2_5_letters", b"adverbs_6_7_letters", b"adverbs_8_9_letters", b"conjunctions_coordinating", b"conjunctions_subordinating", b"pronouns_group_1", b"pronouns_group_2", b"pronouns_group_3", b"prepositions_group_1", b"prepositions_group_2", b"prepositions_group_3", b"interjections", b"suffixes", b"articles"];
            if (v1 < 0x1::vector::length<vector<u8>>(&v2)) {
                let v3 = vector[b"nouns_3_4_letters", b"nouns_5_6_letters", b"nouns_7_9_letters", b"verbs_action", b"verbs_past_tense_irregular", b"verbs_linking", b"verbs_helping", b"adjectives_3_4_letters", b"adjectives_5_6_letters", b"adjectives_7_8_letters", b"adverbs_2_5_letters", b"adverbs_6_7_letters", b"adverbs_8_9_letters", b"conjunctions_coordinating", b"conjunctions_subordinating", b"pronouns_group_1", b"pronouns_group_2", b"pronouns_group_3", b"prepositions_group_1", b"prepositions_group_2", b"prepositions_group_3", b"interjections", b"suffixes", b"articles"];
                let v4 = *0x1::vector::borrow<vector<u8>>(&v3, v1);
                let v5 = vector[b"noun", b"noun", b"noun", b"verb", b"verb", b"verb", b"verb", b"adjective", b"adjective", b"adjective", b"adverb", b"adverbs", b"adverb", b"conjunction", b"conjunction", b"pronoun", b"pronoun", b"pronoun", b"preposition", b"preposition", b"preposition", b"interjection", b"suffix", b"article"];
                let v6 = 0x1::string::utf8(v4);
                let v7 = 0x2::vec_map::get<0x1::string::String, u64>(&v0.parts_of_speech, &v6);
                if (0x2::dynamic_field::exists_<0x1::string::String>(&arg2.id, 0x1::string::utf8(v4))) {
                    let v8 = *0x2::dynamic_field::borrow<0x1::string::String, vector<0x1::string::String>>(&arg2.id, 0x1::string::utf8(v4));
                    let v9 = 0;
                    while (v9 < *v7) {
                        let v10 = random_index(0x1::vector::length<0x1::string::String>(&v8), arg4);
                        internal_mint_and_transfer_word(arg0, *0x1::vector::borrow<0x1::string::String>(&v8, v10), 0x1::string::utf8(*0x1::vector::borrow<vector<u8>>(&v5, v1)), v0.background, v0.name, arg4);
                        0x1::vector::remove<0x1::string::String>(&mut v8, v10);
                        v9 = v9 + 1;
                    };
                };
                v1 = v1 + 1;
            } else {
                break
            };
        };
        0x2::coin::put<0x2::sui::SUI>(&mut arg2.funds, arg3);
    }

    public entry fun make_sentence(arg0: vector<Word>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::utf8(b"");
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = 0x1::vector::empty<0x1::string::String>();
        while (!0x1::vector::is_empty<Word>(&arg0)) {
            let Word {
                id             : v5,
                word           : v6,
                part_of_speech : v7,
                background     : v8,
                pack           : v9,
            } = 0x1::vector::pop_back<Word>(&mut arg0);
            0x1::vector::push_back<0x1::string::String>(&mut v1, v6);
            0x1::vector::push_back<0x1::string::String>(&mut v2, v7);
            0x1::vector::push_back<0x1::string::String>(&mut v3, v9);
            0x1::vector::push_back<0x1::string::String>(&mut v4, v8);
            0x1::string::append(&mut v0, v6);
            0x1::string::append(&mut v0, 0x1::string::utf8(b" "));
            0x2::object::delete(v5);
        };
        0x1::debug::print<0x1::string::String>(&v0);
        let v10 = Sentence{
            id                : 0x2::object::new(arg6),
            sentence          : v0,
            background_image  : 0x1::string::utf8(arg2),
            title             : 0x1::string::utf8(arg3),
            author            : 0x1::string::utf8(arg4),
            image_url         : 0x1::string::utf8(arg1),
            created_at        : 0x2::clock::timestamp_ms(arg5),
            words             : v1,
            parts_of_speech   : v2,
            words_packs       : v3,
            words_backgrounds : v4,
        };
        0x2::transfer::public_transfer<Sentence>(v10, 0x2::tx_context::sender(arg6));
        0x1::vector::destroy_empty<Word>(arg0);
    }

    public entry fun mintBoosterPack(arg0: address, arg1: vector<u8>, arg2: &mut WordsData, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        internal_mint_booster_pack_and_transfer_words(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun mintPack(arg0: address, arg1: vector<u8>, arg2: &mut WordsData, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        internal_mint_pack_and_transfer_words(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun mutate_admin(arg0: address, arg1: &mut WordsData, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.admin == 0x2::tx_context::sender(arg2) || 0x2::tx_context::sender(arg2) == @0x6abfe414d37abdd5d74d78158e1f81e3586333005a3556136b907b7f62a0b7b9, 1);
        arg1.admin = arg0;
    }

    public entry fun mutate_beneficiary(arg0: address, arg1: &mut WordsData, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.admin == 0x2::tx_context::sender(arg2), 1);
        arg1.beneficiary = arg0;
    }

    fun random_index(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x1e1b2bc57509c618df4dbacceeaf36d47866b57dee0f6136950f3328dc802f08::pseudorandom::rand_with_ctx(arg1);
        0x1e1b2bc57509c618df4dbacceeaf36d47866b57dee0f6136950f3328dc802f08::pseudorandom::select_u64(arg0, &v0)
    }

    public entry fun release_funds(arg0: &mut WordsData, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.beneficiary == 0x2::tx_context::sender(arg1), 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.funds, 0x2::balance::value<0x2::sui::SUI>(&arg0.funds), arg1), arg0.beneficiary);
    }

    public entry fun sentence_to_words(arg0: Sentence, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let Sentence {
            id                : v1,
            sentence          : _,
            background_image  : _,
            title             : _,
            author            : _,
            image_url         : _,
            created_at        : _,
            words             : v8,
            parts_of_speech   : v9,
            words_packs       : v10,
            words_backgrounds : v11,
        } = arg0;
        let v12 = v11;
        let v13 = v10;
        let v14 = v9;
        let v15 = v8;
        while (!0x1::vector::is_empty<0x1::string::String>(&v15)) {
            internal_mint_and_transfer_word(v0, 0x1::vector::pop_back<0x1::string::String>(&mut v15), 0x1::vector::pop_back<0x1::string::String>(&mut v14), 0x1::vector::pop_back<0x1::string::String>(&mut v12), 0x1::vector::pop_back<0x1::string::String>(&mut v13), arg1);
        };
        0x2::object::delete(v1);
    }

    // decompiled from Move bytecode v6
}

