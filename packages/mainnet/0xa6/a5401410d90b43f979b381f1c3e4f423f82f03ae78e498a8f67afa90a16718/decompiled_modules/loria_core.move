module 0xa6a5401410d90b43f979b381f1c3e4f423f82f03ae78e498a8f67afa90a16718::loria_core {
    struct LoriaCore has key {
        id: 0x2::object::UID,
        collection_keys: vector<0x2::object::ID>,
        card_db: 0xa6a5401410d90b43f979b381f1c3e4f423f82f03ae78e498a8f67afa90a16718::loria_card_db::LoriaCardDb,
        max_decks_count: u64,
        max_cards_per_deck: u64,
        max_cards_per_pack: u64,
        level_up_price: u64,
        deck_thumb_blob_id: 0x1::string::String,
        basic_pack_template: LoriaPackTemplate,
        treasury: address,
    }

    struct LoriaPackTemplate has store {
        amount: vector<u64>,
        rarity: vector<0xa6a5401410d90b43f979b381f1c3e4f423f82f03ae78e498a8f67afa90a16718::loria_card::CardRarity>,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct LORIA_CORE has drop {
        dummy_field: bool,
    }

    struct CardMintEvent has copy, drop, store {
        card_id: 0x2::object::ID,
        owner: address,
    }

    struct CardsMintEvent has copy, drop, store {
        card_ids: vector<0x2::object::ID>,
        owner: address,
    }

    struct PackMintEvent has copy, drop, store {
        pack_id: 0x2::object::ID,
        owner: address,
    }

    public fun new(arg0: LORIA_CORE, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::types::is_one_time_witness<LORIA_CORE>(&arg0), 1);
        let v0 = create_rootlets_collection(arg1, arg2);
        let v1 = 0x1::vector::empty<0xa6a5401410d90b43f979b381f1c3e4f423f82f03ae78e498a8f67afa90a16718::loria_card::CardRarity>();
        let v2 = &mut v1;
        0x1::vector::push_back<0xa6a5401410d90b43f979b381f1c3e4f423f82f03ae78e498a8f67afa90a16718::loria_card::CardRarity>(v2, 0xa6a5401410d90b43f979b381f1c3e4f423f82f03ae78e498a8f67afa90a16718::loria_card::common());
        0x1::vector::push_back<0xa6a5401410d90b43f979b381f1c3e4f423f82f03ae78e498a8f67afa90a16718::loria_card::CardRarity>(v2, 0xa6a5401410d90b43f979b381f1c3e4f423f82f03ae78e498a8f67afa90a16718::loria_card::rare());
        0x1::vector::push_back<0xa6a5401410d90b43f979b381f1c3e4f423f82f03ae78e498a8f67afa90a16718::loria_card::CardRarity>(v2, 0xa6a5401410d90b43f979b381f1c3e4f423f82f03ae78e498a8f67afa90a16718::loria_card::epic());
        let v3 = LoriaPackTemplate{
            amount : vector[7, 2, 1],
            rarity : v1,
        };
        let v4 = 0x1::vector::empty<0x2::object::ID>();
        0x1::vector::push_back<0x2::object::ID>(&mut v4, v0);
        let v5 = LoriaCore{
            id                  : 0x2::object::new(arg2),
            collection_keys     : v4,
            card_db             : 0xa6a5401410d90b43f979b381f1c3e4f423f82f03ae78e498a8f67afa90a16718::loria_card_db::temp_init_rootlets_cards(0xa6a5401410d90b43f979b381f1c3e4f423f82f03ae78e498a8f67afa90a16718::loria_card_db::init_db(arg2), v0, arg2),
            max_decks_count     : 2,
            max_cards_per_deck  : 70,
            max_cards_per_pack  : 10,
            level_up_price      : 50000000000,
            deck_thumb_blob_id  : 0x1::string::utf8(b"Ocbo0ZLjmUP0W_jDg_Q7bnrkMHSy9kVHDrR44YiK0dU"),
            basic_pack_template : v3,
            treasury            : 0x2::tx_context::sender(arg2),
        };
        0x2::transfer::share_object<LoriaCore>(v5);
    }

    public fun add_cards_to_deck(arg0: &mut 0xa6a5401410d90b43f979b381f1c3e4f423f82f03ae78e498a8f67afa90a16718::loria_deck::LoriaDeck, arg1: vector<0x2::object::ID>, arg2: vector<0x2::object::ID>, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x2::object::ID>(&arg2)) {
            let v1 = 0x1::vector::borrow<0x2::object::ID>(&arg2, v0);
            assert!(0xa6a5401410d90b43f979b381f1c3e4f423f82f03ae78e498a8f67afa90a16718::loria_deck::contains_card(arg0, *v1), 7);
            0xa6a5401410d90b43f979b381f1c3e4f423f82f03ae78e498a8f67afa90a16718::loria_deck::remove_card(arg0, *v1, arg3);
            v0 = v0 + 1;
        };
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x2::object::ID>(&arg1)) {
            let v3 = 0x1::vector::borrow<0x2::object::ID>(&arg1, v2);
            assert!(!0xa6a5401410d90b43f979b381f1c3e4f423f82f03ae78e498a8f67afa90a16718::loria_deck::contains_card(arg0, *v3), 6);
            0xa6a5401410d90b43f979b381f1c3e4f423f82f03ae78e498a8f67afa90a16718::loria_deck::add_card(arg0, *v3, arg3);
            v2 = v2 + 1;
        };
    }

    public fun assign_card_to_deck(arg0: &mut 0xa6a5401410d90b43f979b381f1c3e4f423f82f03ae78e498a8f67afa90a16718::loria_deck::LoriaDeck, arg1: &mut 0xa6a5401410d90b43f979b381f1c3e4f423f82f03ae78e498a8f67afa90a16718::loria_card::LoriaCard) {
        0xa6a5401410d90b43f979b381f1c3e4f423f82f03ae78e498a8f67afa90a16718::loria_card::assign_deck(arg1, 0x2::object::id<0xa6a5401410d90b43f979b381f1c3e4f423f82f03ae78e498a8f67afa90a16718::loria_deck::LoriaDeck>(arg0));
    }

    public fun assign_cards_to_deck(arg0: &mut 0xa6a5401410d90b43f979b381f1c3e4f423f82f03ae78e498a8f67afa90a16718::loria_deck::LoriaDeck, arg1: &mut vector<0xa6a5401410d90b43f979b381f1c3e4f423f82f03ae78e498a8f67afa90a16718::loria_card::LoriaCard>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0xa6a5401410d90b43f979b381f1c3e4f423f82f03ae78e498a8f67afa90a16718::loria_card::LoriaCard>(arg1)) {
            0xa6a5401410d90b43f979b381f1c3e4f423f82f03ae78e498a8f67afa90a16718::loria_card::assign_deck(0x1::vector::borrow_mut<0xa6a5401410d90b43f979b381f1c3e4f423f82f03ae78e498a8f67afa90a16718::loria_card::LoriaCard>(arg1, v0), 0x2::object::id<0xa6a5401410d90b43f979b381f1c3e4f423f82f03ae78e498a8f67afa90a16718::loria_deck::LoriaDeck>(arg0));
            v0 = v0 + 1;
        };
    }

    public fun change_treasury_address(arg0: &mut LoriaCore, arg1: address, arg2: &AdminCap) : address {
        arg0.treasury = arg1;
        arg1
    }

    public fun create_m_card(arg0: &mut LoriaCore, arg1: 0x2::object::ID, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: u64, arg6: 0x1::option::Option<u64>, arg7: 0x1::option::Option<u64>, arg8: 0xa6a5401410d90b43f979b381f1c3e4f423f82f03ae78e498a8f67afa90a16718::loria_card::CardRarity, arg9: 0xa6a5401410d90b43f979b381f1c3e4f423f82f03ae78e498a8f67afa90a16718::loria_card::CardType, arg10: u64, arg11: &AdminCap, arg12: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0xa6a5401410d90b43f979b381f1c3e4f423f82f03ae78e498a8f67afa90a16718::loria_card::new_mintable(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg12);
        0xa6a5401410d90b43f979b381f1c3e4f423f82f03ae78e498a8f67afa90a16718::loria_card_db::add_card(&mut arg0.card_db, arg1, v0);
        0x2::object::id<0xa6a5401410d90b43f979b381f1c3e4f423f82f03ae78e498a8f67afa90a16718::loria_card::LoriaMintableCard>(&v0)
    }

    fun create_rootlets_collection(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0xa6a5401410d90b43f979b381f1c3e4f423f82f03ae78e498a8f67afa90a16718::loria_collection::new(0x1::string::utf8(b"HAgey06wd2mpc1kiJgzU2D7aRGpV7I-vDMHLobfO4EU"), 0x1::string::utf8(b"XnJasShO1CWe5YX5ZL9fBeMHMSyWxEoeXuy6y8BnsZM"), 0x1::string::utf8(b"https://rootlets.io/"), 0x1::string::utf8(b"rootlets"), 0x1::string::utf8(b"The Rootlets are friendly creatures that have descended to colonize Earth with their cuteness! Think steampunk space-pigs taking over the Suiverse."), 50000000, 3000, arg1);
        0x2::transfer::public_share_object<0xa6a5401410d90b43f979b381f1c3e4f423f82f03ae78e498a8f67afa90a16718::loria_collection::LoriaCollection>(v0);
        0xa6a5401410d90b43f979b381f1c3e4f423f82f03ae78e498a8f67afa90a16718::loria_collection::get_id(&v0)
    }

    public fun emit_card_mint_event(arg0: 0x2::object::ID, arg1: address) {
        let v0 = CardMintEvent{
            card_id : arg0,
            owner   : arg1,
        };
        0x2::event::emit<CardMintEvent>(v0);
    }

    public fun emit_cards_mint_event(arg0: vector<0x2::object::ID>, arg1: address) {
        let v0 = CardsMintEvent{
            card_ids : arg0,
            owner    : arg1,
        };
        0x2::event::emit<CardsMintEvent>(v0);
    }

    public fun emit_pack_mint_event(arg0: 0x2::object::ID, arg1: address) {
        let v0 = PackMintEvent{
            pack_id : arg0,
            owner   : arg1,
        };
        0x2::event::emit<PackMintEvent>(v0);
    }

    public fun get_card_ids_collection(arg0: &LoriaCore) : vector<0x2::object::ID> {
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x2::object::ID>(&arg0.collection_keys)) {
            let v2 = 0xa6a5401410d90b43f979b381f1c3e4f423f82f03ae78e498a8f67afa90a16718::loria_card_db::borrow_cards_from_collection(&arg0.card_db, *0x1::vector::borrow<0x2::object::ID>(&arg0.collection_keys, v1));
            let v3 = 0;
            while (v3 < 0x1::vector::length<0xa6a5401410d90b43f979b381f1c3e4f423f82f03ae78e498a8f67afa90a16718::loria_card::LoriaMintableCard>(v2)) {
                0x1::vector::push_back<0x2::object::ID>(&mut v0, 0x2::object::id<0xa6a5401410d90b43f979b381f1c3e4f423f82f03ae78e498a8f67afa90a16718::loria_card::LoriaMintableCard>(0x1::vector::borrow<0xa6a5401410d90b43f979b381f1c3e4f423f82f03ae78e498a8f67afa90a16718::loria_card::LoriaMintableCard>(v2, v3)));
                v3 = v3 + 1;
            };
            v1 = v1 + 1;
        };
        v0
    }

    public fun get_cards_from_pack(arg0: &0xa6a5401410d90b43f979b381f1c3e4f423f82f03ae78e498a8f67afa90a16718::loria_pack::LoriaPack) : vector<0x2::object::ID> {
        0xa6a5401410d90b43f979b381f1c3e4f423f82f03ae78e498a8f67afa90a16718::loria_pack::get_unpacked_cards(arg0)
    }

    public fun get_collection_ids(arg0: &LoriaCore) : vector<0x2::object::ID> {
        arg0.collection_keys
    }

    fun init(arg0: LORIA_CORE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        new(arg0, &v0, arg1);
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
    }

    entry fun mint_cards(arg0: &mut LoriaCore, arg1: &mut 0xa6a5401410d90b43f979b381f1c3e4f423f82f03ae78e498a8f67afa90a16718::loria_pack::LoriaPack, arg2: &0x2::random::Random, arg3: &mut 0x2::tx_context::TxContext) : vector<0x2::object::ID> {
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        let v1 = 0xa6a5401410d90b43f979b381f1c3e4f423f82f03ae78e498a8f67afa90a16718::loria_card_db::borrow_cards_from_collection_mutable(&mut arg0.card_db, 0xa6a5401410d90b43f979b381f1c3e4f423f82f03ae78e498a8f67afa90a16718::loria_pack::get_collection_id(arg1));
        let v2 = 0x1::vector::length<0xa6a5401410d90b43f979b381f1c3e4f423f82f03ae78e498a8f67afa90a16718::loria_card::LoriaMintableCard>(v1);
        assert!(v2 > 0, 1);
        let v3 = vector[];
        let v4 = vector[];
        let v5 = vector[];
        let v6 = vector[];
        let v7 = 0;
        while (v7 < v2) {
            let v8 = 0xa6a5401410d90b43f979b381f1c3e4f423f82f03ae78e498a8f67afa90a16718::loria_card::extract_card(0x1::vector::borrow<0xa6a5401410d90b43f979b381f1c3e4f423f82f03ae78e498a8f67afa90a16718::loria_card::LoriaMintableCard>(v1, v7));
            if (0xa6a5401410d90b43f979b381f1c3e4f423f82f03ae78e498a8f67afa90a16718::loria_card::is_common(v8)) {
                0x1::vector::push_back<u64>(&mut v6, v7);
            };
            if (0xa6a5401410d90b43f979b381f1c3e4f423f82f03ae78e498a8f67afa90a16718::loria_card::is_rare(v8)) {
                0x1::vector::push_back<u64>(&mut v5, v7);
            };
            if (0xa6a5401410d90b43f979b381f1c3e4f423f82f03ae78e498a8f67afa90a16718::loria_card::is_epic(v8)) {
                0x1::vector::push_back<u64>(&mut v4, v7);
            };
            if (0xa6a5401410d90b43f979b381f1c3e4f423f82f03ae78e498a8f67afa90a16718::loria_card::is_legendary(v8)) {
                0x1::vector::push_back<u64>(&mut v3, v7);
            };
            v7 = v7 + 1;
        };
        let v9 = 0x2::random::new_generator(arg2, arg3);
        let v10 = &mut v0;
        let v11 = &mut v9;
        mint_random_cards(&v6, 7, v1, v10, v11, arg1, arg3);
        let v12 = &mut v0;
        let v13 = &mut v9;
        mint_random_cards(&v5, 2, v1, v12, v13, arg1, arg3);
        if (0x2::random::generate_u64_in_range(&mut v9, 0, 100) < 95) {
            let v14 = &mut v0;
            let v15 = &mut v9;
            mint_random_cards(&v4, 1, v1, v14, v15, arg1, arg3);
        } else {
            let v16 = &mut v0;
            let v17 = &mut v9;
            mint_random_cards(&v3, 1, v1, v16, v17, arg1, arg3);
        };
        emit_cards_mint_event(v0, 0x2::tx_context::sender(arg3));
        v0
    }

    public fun mint_pack(arg0: &LoriaCore, arg1: &mut 0xa6a5401410d90b43f979b381f1c3e4f423f82f03ae78e498a8f67afa90a16718::loria_collection::LoriaCollection, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0xa6a5401410d90b43f979b381f1c3e4f423f82f03ae78e498a8f67afa90a16718::loria_collection::get_minted_packs(arg1) < 0xa6a5401410d90b43f979b381f1c3e4f423f82f03ae78e498a8f67afa90a16718::loria_collection::get_max_packs(arg1), 3);
        let v0 = 0xa6a5401410d90b43f979b381f1c3e4f423f82f03ae78e498a8f67afa90a16718::loria_collection::get_mint_price(arg1);
        let v1 = 0x2::coin::split<0x2::sui::SUI>(&mut arg2, v0, arg3);
        assert!(0x2::balance::value<0x2::sui::SUI>(0x2::coin::balance<0x2::sui::SUI>(&v1)) >= v0, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v1, arg0.treasury);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, 0x2::tx_context::sender(arg3));
        0xa6a5401410d90b43f979b381f1c3e4f423f82f03ae78e498a8f67afa90a16718::loria_collection::increment_minted_packs(arg1);
        emit_pack_mint_event(0xa6a5401410d90b43f979b381f1c3e4f423f82f03ae78e498a8f67afa90a16718::loria_pack::mint(0xa6a5401410d90b43f979b381f1c3e4f423f82f03ae78e498a8f67afa90a16718::loria_collection::get_id(arg1), 0xa6a5401410d90b43f979b381f1c3e4f423f82f03ae78e498a8f67afa90a16718::loria_collection::get_pack_blob_id(arg1), arg3), 0x2::tx_context::sender(arg3));
    }

    fun mint_random_cards(arg0: &vector<u64>, arg1: u64, arg2: &mut vector<0xa6a5401410d90b43f979b381f1c3e4f423f82f03ae78e498a8f67afa90a16718::loria_card::LoriaMintableCard>, arg3: &mut vector<0x2::object::ID>, arg4: &mut 0x2::random::RandomGenerator, arg5: &mut 0xa6a5401410d90b43f979b381f1c3e4f423f82f03ae78e498a8f67afa90a16718::loria_pack::LoriaPack, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<u64>(arg0);
        assert!(v0 > 0, 2);
        let v1 = 0;
        while (v1 < arg1) {
            let v2 = 0xa6a5401410d90b43f979b381f1c3e4f423f82f03ae78e498a8f67afa90a16718::loria_card::mint_card(0x1::vector::borrow_mut<0xa6a5401410d90b43f979b381f1c3e4f423f82f03ae78e498a8f67afa90a16718::loria_card::LoriaMintableCard>(arg2, *0x1::vector::borrow<u64>(arg0, 0x2::random::generate_u64_in_range(arg4, 0, v0 - 1))), 0x2::object::id<0xa6a5401410d90b43f979b381f1c3e4f423f82f03ae78e498a8f67afa90a16718::loria_pack::LoriaPack>(arg5), arg6);
            let v3 = 0x2::object::id<0xa6a5401410d90b43f979b381f1c3e4f423f82f03ae78e498a8f67afa90a16718::loria_card::LoriaCard>(&v2);
            0x1::vector::push_back<0x2::object::ID>(arg3, v3);
            emit_card_mint_event(v3, 0x2::tx_context::sender(arg6));
            0xa6a5401410d90b43f979b381f1c3e4f423f82f03ae78e498a8f67afa90a16718::loria_pack::add_unpacked_card(arg5, v3);
            0x2::transfer::public_transfer<0xa6a5401410d90b43f979b381f1c3e4f423f82f03ae78e498a8f67afa90a16718::loria_card::LoriaCard>(v2, 0x2::tx_context::sender(arg6));
            v1 = v1 + 1;
        };
    }

    public fun new_deck(arg0: &LoriaCore, arg1: &0xa6a5401410d90b43f979b381f1c3e4f423f82f03ae78e498a8f67afa90a16718::loria_card::LoriaCard, arg2: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0xa6a5401410d90b43f979b381f1c3e4f423f82f03ae78e498a8f67afa90a16718::loria_card::get_card_owner(arg1);
        assert!(0x1::option::extract<address>(&mut v0) == 0x2::tx_context::sender(arg2), 5);
        0xa6a5401410d90b43f979b381f1c3e4f423f82f03ae78e498a8f67afa90a16718::loria_deck::new(arg0.deck_thumb_blob_id, arg2)
    }

    public fun remove_card_from_deck(arg0: &mut 0xa6a5401410d90b43f979b381f1c3e4f423f82f03ae78e498a8f67afa90a16718::loria_deck::LoriaDeck, arg1: 0x2::object::ID, arg2: &0x2::tx_context::TxContext) {
        0xa6a5401410d90b43f979b381f1c3e4f423f82f03ae78e498a8f67afa90a16718::loria_deck::remove_card(arg0, arg1, arg2);
    }

    public fun remove_deck(arg0: 0xa6a5401410d90b43f979b381f1c3e4f423f82f03ae78e498a8f67afa90a16718::loria_deck::LoriaDeck, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0xa6a5401410d90b43f979b381f1c3e4f423f82f03ae78e498a8f67afa90a16718::loria_deck::get_owner(&arg0) == 0x2::tx_context::sender(arg1), 4);
        0xa6a5401410d90b43f979b381f1c3e4f423f82f03ae78e498a8f67afa90a16718::loria_deck::remove_deck(arg0, arg1);
    }

    public fun un_assign_card_to_deck(arg0: &mut 0xa6a5401410d90b43f979b381f1c3e4f423f82f03ae78e498a8f67afa90a16718::loria_deck::LoriaDeck, arg1: &mut 0xa6a5401410d90b43f979b381f1c3e4f423f82f03ae78e498a8f67afa90a16718::loria_card::LoriaCard) {
        0xa6a5401410d90b43f979b381f1c3e4f423f82f03ae78e498a8f67afa90a16718::loria_card::un_assign_deck(arg1, 0x2::object::id<0xa6a5401410d90b43f979b381f1c3e4f423f82f03ae78e498a8f67afa90a16718::loria_deck::LoriaDeck>(arg0));
    }

    public fun un_assign_cards_to_deck(arg0: &mut 0xa6a5401410d90b43f979b381f1c3e4f423f82f03ae78e498a8f67afa90a16718::loria_deck::LoriaDeck, arg1: &mut vector<0xa6a5401410d90b43f979b381f1c3e4f423f82f03ae78e498a8f67afa90a16718::loria_card::LoriaCard>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0xa6a5401410d90b43f979b381f1c3e4f423f82f03ae78e498a8f67afa90a16718::loria_card::LoriaCard>(arg1)) {
            0xa6a5401410d90b43f979b381f1c3e4f423f82f03ae78e498a8f67afa90a16718::loria_card::un_assign_deck(0x1::vector::borrow_mut<0xa6a5401410d90b43f979b381f1c3e4f423f82f03ae78e498a8f67afa90a16718::loria_card::LoriaCard>(arg1, v0), 0x2::object::id<0xa6a5401410d90b43f979b381f1c3e4f423f82f03ae78e498a8f67afa90a16718::loria_deck::LoriaDeck>(arg0));
            v0 = v0 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

