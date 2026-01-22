module 0x62c1edbd3d79973aa09425ca2d253126bfe2400b1cbcbef2b80d802381b52f5c::gacha_machine {
    struct GACHA_MACHINE has drop {
        dummy_field: bool,
    }

    struct Store has store, key {
        id: 0x2::object::UID,
        version: u64,
        mint_admin: address,
        admin: address,
        public_key: vector<u8>,
        fee_balance: 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>,
        configs: 0x2::table::Table<0x1::string::String, Config>,
        default_config: Config,
        balances: 0x2::table::Table<0x1::string::String, 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>,
        default_balance: 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>,
        vaults: 0x2::table::Table<0x1::string::String, 0x62c1edbd3d79973aa09425ca2d253126bfe2400b1cbcbef2b80d802381b52f5c::gacha_vault::GachaVault<Card>>,
        pack_index: u128,
        transfer_policy: 0x2::transfer_policy::TransferPolicy<Card>,
        transfer_policy_cap: 0x2::transfer_policy::TransferPolicyCap<Card>,
        orders: 0x2::table::Table<u128, bool>,
    }

    struct Config has copy, drop, store {
        price: u64,
        pack_size: u64,
        enabled: bool,
    }

    struct Card has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        media_url: 0x1::string::String,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
        hash: vector<u8>,
        revealed: bool,
    }

    struct RedeemCardsRequest {
        order_id: 0x1::string::String,
        card_ids: vector<0x2::object::ID>,
    }

    struct CardMintedEvent has copy, drop {
        id: 0x1::string::String,
        card_id: 0x2::object::ID,
        vault_name: 0x1::string::String,
    }

    struct PackBoughtEvent has copy, drop {
        card_ids: vector<0x2::object::ID>,
        vault_name: 0x1::string::String,
        pack_id: u128,
        price: u64,
    }

    struct CardSoldEvent has copy, drop {
        card_id: 0x2::object::ID,
        vault_name: 0x1::string::String,
        order_id: u128,
        price: u64,
        fee: u64,
    }

    struct CardBurnedEvent has copy, drop {
        card_id: 0x2::object::ID,
        vault_name: 0x1::string::String,
    }

    struct CardRevealedEvent has copy, drop {
        card_id: 0x2::object::ID,
    }

    struct CardRedeemedEvent has copy, drop {
        card_id: 0x2::object::ID,
    }

    struct CardsRedeemedEvent has copy, drop {
        order_id: 0x1::string::String,
    }

    entry fun burn_card_in_vault(arg0: &0x2::clock::Clock, arg1: &mut Store, arg2: 0x1::string::String, arg3: 0x2::object::ID, arg4: u64, arg5: vector<u8>, arg6: &0x2::tx_context::TxContext) {
        verify_version(arg1);
        verify_mint_admin(arg1, arg6);
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0x2::tx_context::sender(arg6);
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<address>(&v1));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<0x1::string::String>(&arg2));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<0x2::object::ID>(&arg3));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg4));
        assert!(0x2::ed25519::ed25519_verify(&arg5, &arg1.public_key, &v0), 4);
        assert!(0x2::clock::timestamp_ms(arg0) < arg4, 6);
        let Card {
            id          : v2,
            name        : _,
            description : _,
            media_url   : _,
            attributes  : _,
            hash        : _,
            revealed    : _,
        } = 0x62c1edbd3d79973aa09425ca2d253126bfe2400b1cbcbef2b80d802381b52f5c::gacha_vault::remove_by_id<Card>(0x2::table::borrow_mut<0x1::string::String, 0x62c1edbd3d79973aa09425ca2d253126bfe2400b1cbcbef2b80d802381b52f5c::gacha_vault::GachaVault<Card>>(&mut arg1.vaults, arg2), arg3);
        0x2::object::delete(v2);
        let v9 = CardBurnedEvent{
            card_id    : arg3,
            vault_name : arg2,
        };
        0x2::event::emit<CardBurnedEvent>(v9);
    }

    fun buy_packs(arg0: &0x2::random::Random, arg1: &mut Store, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg4: 0x1::string::String, arg5: u64, arg6: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg7: &mut 0x2::tx_context::TxContext) {
        verify_version(arg1);
        let v0 = 0x2::random::new_generator(arg0, arg7);
        let v1 = &mut v0;
        let v2 = 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow(arg3);
        let v3 = if (0x2::table::contains<0x1::string::String, Config>(&arg1.configs, arg4)) {
            0x2::table::borrow<0x1::string::String, Config>(&arg1.configs, arg4)
        } else {
            &arg1.default_config
        };
        assert!(v3.enabled, 7);
        assert!(0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg6) == arg5 * v3.price, 3);
        let v4 = if (0x2::table::contains<0x1::string::String, 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(&arg1.balances, arg4)) {
            0x2::table::borrow_mut<0x1::string::String, 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(&mut arg1.balances, arg4)
        } else {
            &mut arg1.default_balance
        };
        0x2::balance::join<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v4, 0x2::coin::into_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg6));
        let v5 = 0x2::table::borrow_mut<0x1::string::String, 0x62c1edbd3d79973aa09425ca2d253126bfe2400b1cbcbef2b80d802381b52f5c::gacha_vault::GachaVault<Card>>(&mut arg1.vaults, arg4);
        while (arg5 > 0) {
            let v6 = 0;
            let v7 = arg1.pack_index + 1;
            let v8 = 0x1::vector::empty<0x2::object::ID>();
            while (v6 < v3.pack_size) {
                let v9 = 0x62c1edbd3d79973aa09425ca2d253126bfe2400b1cbcbef2b80d802381b52f5c::gacha_vault::remove_by_index<Card>(v5, 0x2::random::generate_u64_in_range(v1, 0, 0x62c1edbd3d79973aa09425ca2d253126bfe2400b1cbcbef2b80d802381b52f5c::gacha_vault::length<Card>(v5) - 1));
                0x1::vector::push_back<0x2::object::ID>(&mut v8, 0x2::object::id<Card>(&v9));
                0x2::kiosk::lock<Card>(arg2, v2, &arg1.transfer_policy, v9);
                v6 = v6 + 1;
            };
            let v10 = PackBoughtEvent{
                card_ids   : v8,
                vault_name : arg4,
                pack_id    : v7,
                price      : v3.price,
            };
            0x2::event::emit<PackBoughtEvent>(v10);
            arg1.pack_index = v7;
            arg5 = arg5 - 1;
        };
    }

    entry fun buy_packs_with_personal_kiosk(arg0: &0x2::random::Random, arg1: &mut Store, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg4: 0x1::string::String, arg5: u64, arg6: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg7: &mut 0x2::tx_context::TxContext) {
        buy_packs(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    entry fun buy_packs_without_personal_kiosk(arg0: &0x2::random::Random, arg1: &mut Store, arg2: 0x1::string::String, arg3: u64, arg4: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg5: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::kiosk::new(arg5);
        let v2 = v0;
        let v3 = 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::new(&mut v2, v1, arg5);
        let v4 = &mut v2;
        buy_packs(arg0, arg1, v4, &v3, arg2, arg3, arg4, arg5);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v2);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::transfer_to_sender(v3, arg5);
    }

    public fun finish_redeem_cards(arg0: RedeemCardsRequest) {
        let RedeemCardsRequest {
            order_id : v0,
            card_ids : v1,
        } = arg0;
        let v2 = v1;
        assert!(0x1::vector::length<0x2::object::ID>(&v2) == 0, 9);
        let v3 = CardsRedeemedEvent{order_id: v0};
        0x2::event::emit<CardsRedeemedEvent>(v3);
    }

    fun init(arg0: GACHA_MACHINE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<GACHA_MACHINE>(arg0, arg1);
        let v1 = 0x2::display::new<Card>(&v0, arg1);
        0x2::display::add<Card>(&mut v1, 0x1::string::utf8(b"collection_name"), 0x1::string::utf8(b"Axelotls Gacha 7"));
        0x2::display::add<Card>(&mut v1, 0x1::string::utf8(b"collection_description"), 0x1::string::utf8(b"axelotls are cool"));
        0x2::display::add<Card>(&mut v1, 0x1::string::utf8(b"collection_media_url"), 0x1::string::utf8(b"ipfs://bafybeidqb6ydqzcbbmbshoru2uso6nnzqlyyuudi3a3bb6mnjyi6ku5kqy"));
        0x2::display::add<Card>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<Card>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<Card>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{media_url}"));
        0x2::display::add<Card>(&mut v1, 0x1::string::utf8(b"media_url"), 0x1::string::utf8(b"{media_url}"));
        0x2::display::add<Card>(&mut v1, 0x1::string::utf8(b"attributes"), 0x1::string::utf8(b"{attributes}"));
        0x2::display::add<Card>(&mut v1, 0x1::string::utf8(b"hash"), 0x1::string::utf8(b"{hash}"));
        0x2::display::update_version<Card>(&mut v1);
        0x2::transfer::public_transfer<0x2::display::Display<Card>>(v1, 0x2::tx_context::sender(arg1));
        let (v2, v3) = 0x2::transfer_policy::new<Card>(&v0, arg1);
        let v4 = Config{
            price     : 0,
            pack_size : 0,
            enabled   : false,
        };
        let v5 = Store{
            id                  : 0x2::object::new(arg1),
            version             : 1,
            mint_admin          : 0x2::tx_context::sender(arg1),
            admin               : 0x2::tx_context::sender(arg1),
            public_key          : 0x1::vector::empty<u8>(),
            fee_balance         : 0x2::balance::zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(),
            configs             : 0x2::table::new<0x1::string::String, Config>(arg1),
            default_config      : v4,
            balances            : 0x2::table::new<0x1::string::String, 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(arg1),
            default_balance     : 0x2::balance::zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(),
            vaults              : 0x2::table::new<0x1::string::String, 0x62c1edbd3d79973aa09425ca2d253126bfe2400b1cbcbef2b80d802381b52f5c::gacha_vault::GachaVault<Card>>(arg1),
            pack_index          : 0,
            transfer_policy     : v2,
            transfer_policy_cap : v3,
            orders              : 0x2::table::new<u128, bool>(arg1),
        };
        0x2::transfer::public_share_object<Store>(v5);
        let (v6, v7) = 0x2::transfer_policy::new<Card>(&v0, arg1);
        let v8 = v7;
        let v9 = v6;
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::add<Card>(&mut v9, &v8);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk_rule::add<Card>(&mut v9, &v8);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<Card>>(v8, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<Card>>(v9);
    }

    entry fun mint_card(arg0: &0x2::clock::Clock, arg1: &mut Store, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: vector<u8>, arg8: u64, arg9: vector<u8>, arg10: &mut 0x2::tx_context::TxContext) {
        verify_version(arg1);
        verify_mint_admin(arg1, arg10);
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0x2::tx_context::sender(arg10);
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<address>(&v1));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<0x1::string::String>(&arg2));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<0x1::string::String>(&arg3));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<0x1::string::String>(&arg4));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<0x1::string::String>(&arg5));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<0x1::string::String>(&arg6));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<vector<u8>>(&arg7));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg8));
        assert!(0x2::ed25519::ed25519_verify(&arg9, &arg1.public_key, &v0), 4);
        assert!(0x2::clock::timestamp_ms(arg0) < arg8, 6);
        let v2 = Card{
            id          : 0x2::object::new(arg10),
            name        : arg4,
            description : arg5,
            media_url   : arg6,
            attributes  : 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>(),
            hash        : arg7,
            revealed    : false,
        };
        let v3 = CardMintedEvent{
            id         : arg2,
            card_id    : 0x2::object::id<Card>(&v2),
            vault_name : arg3,
        };
        0x2::event::emit<CardMintedEvent>(v3);
        if (!0x2::table::contains<0x1::string::String, 0x62c1edbd3d79973aa09425ca2d253126bfe2400b1cbcbef2b80d802381b52f5c::gacha_vault::GachaVault<Card>>(&arg1.vaults, arg3)) {
            0x2::table::add<0x1::string::String, 0x62c1edbd3d79973aa09425ca2d253126bfe2400b1cbcbef2b80d802381b52f5c::gacha_vault::GachaVault<Card>>(&mut arg1.vaults, arg3, 0x62c1edbd3d79973aa09425ca2d253126bfe2400b1cbcbef2b80d802381b52f5c::gacha_vault::new<Card>(arg10));
        };
        0x62c1edbd3d79973aa09425ca2d253126bfe2400b1cbcbef2b80d802381b52f5c::gacha_vault::add<Card>(0x2::table::borrow_mut<0x1::string::String, 0x62c1edbd3d79973aa09425ca2d253126bfe2400b1cbcbef2b80d802381b52f5c::gacha_vault::GachaVault<Card>>(&mut arg1.vaults, arg3), v2);
    }

    public fun redeem_card_with_request(arg0: &Store, arg1: 0x2::object::ID, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg4: &mut RedeemCardsRequest, arg5: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x1::vector::index_of<0x2::object::ID>(&arg4.card_ids, &arg1);
        assert!(v0, 9);
        0x1::vector::swap_remove<0x2::object::ID>(&mut arg4.card_ids, v1);
        let (v2, v3) = 0x2::kiosk::purchase_with_cap<Card>(arg2, 0x2::kiosk::list_with_purchase_cap<Card>(arg2, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow(arg3), arg1, 0, arg5), 0x2::coin::zero<0x2::sui::SUI>(arg5));
        let (_, _, _) = 0x2::transfer_policy::confirm_request<Card>(&arg0.transfer_policy, v3);
        let Card {
            id          : v7,
            name        : _,
            description : _,
            media_url   : _,
            attributes  : _,
            hash        : _,
            revealed    : v13,
        } = v2;
        assert!(v13, 10);
        0x2::object::delete(v7);
        let v14 = CardRedeemedEvent{card_id: arg1};
        0x2::event::emit<CardRedeemedEvent>(v14);
    }

    public fun redeem_cards(arg0: &0x2::clock::Clock, arg1: &mut Store, arg2: 0x1::string::String, arg3: vector<0x2::object::ID>, arg4: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg5: u64, arg6: vector<u8>, arg7: &0x2::tx_context::TxContext) : RedeemCardsRequest {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0x2::tx_context::sender(arg7);
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<address>(&v1));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<0x1::string::String>(&arg2));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<vector<0x2::object::ID>>(&arg3));
        let v2 = 0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg4);
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&v2));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg5));
        assert!(0x2::ed25519::ed25519_verify(&arg6, &arg1.public_key, &v0), 4);
        assert!(0x2::clock::timestamp_ms(arg0) < arg5, 6);
        assert!(0x1::vector::length<0x2::object::ID>(&arg3) > 0, 8);
        0x2::balance::join<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg1.default_balance, 0x2::coin::into_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg4));
        RedeemCardsRequest{
            order_id : arg2,
            card_ids : arg3,
        }
    }

    entry fun reveal_card(arg0: &0x2::clock::Clock, arg1: &Store, arg2: 0x2::object::ID, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: vector<0x1::string::String>, arg7: vector<0x1::string::String>, arg8: vector<u8>, arg9: u64, arg10: vector<u8>, arg11: &mut 0x2::kiosk::Kiosk, arg12: &0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg13: &mut 0x2::tx_context::TxContext) {
        verify_version(arg1);
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0x2::tx_context::sender(arg13);
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<address>(&v1));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<0x2::object::ID>(&arg2));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<0x1::string::String>(&arg3));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<0x1::string::String>(&arg4));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<0x1::string::String>(&arg5));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<vector<0x1::string::String>>(&arg6));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<vector<0x1::string::String>>(&arg7));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<vector<u8>>(&arg8));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg9));
        assert!(0x2::ed25519::ed25519_verify(&arg10, &arg1.public_key, &v0), 4);
        assert!(0x2::clock::timestamp_ms(arg0) < arg9, 6);
        let v2 = &arg1.transfer_policy;
        let v3 = 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow(arg12);
        let (v4, v5) = 0x2::kiosk::purchase_with_cap<Card>(arg11, 0x2::kiosk::list_with_purchase_cap<Card>(arg11, v3, arg2, 0, arg13), 0x2::coin::zero<0x2::sui::SUI>(arg13));
        let v6 = v4;
        assert!(!v6.revealed, 11);
        assert!(v6.hash == arg8, 9);
        v6.name = arg3;
        v6.description = arg4;
        v6.media_url = arg5;
        v6.attributes = 0x2::vec_map::from_keys_values<0x1::string::String, 0x1::string::String>(arg6, arg7);
        v6.revealed = true;
        let (_, _, _) = 0x2::transfer_policy::confirm_request<Card>(v2, v5);
        0x2::kiosk::lock<Card>(arg11, v3, v2, v6);
        let v10 = CardRevealedEvent{card_id: arg2};
        0x2::event::emit<CardRevealedEvent>(v10);
    }

    entry fun sell_card(arg0: &0x2::clock::Clock, arg1: &mut Store, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg4: u128, arg5: 0x1::string::String, arg6: 0x2::object::ID, arg7: u64, arg8: u64, arg9: u64, arg10: vector<u8>, arg11: &mut 0x2::tx_context::TxContext) {
        verify_version(arg1);
        assert!(!0x2::table::contains<u128, bool>(&arg1.orders, arg4), 5);
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0x2::tx_context::sender(arg11);
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<address>(&v1));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u128>(&arg4));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<0x1::string::String>(&arg5));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<0x2::object::ID>(&arg6));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg7));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg8));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg9));
        assert!(0x2::ed25519::ed25519_verify(&arg10, &arg1.public_key, &v0), 4);
        assert!(0x2::clock::timestamp_ms(arg0) < arg9, 6);
        let v2 = if (0x2::table::contains<0x1::string::String, Config>(&arg1.configs, arg5)) {
            0x2::table::borrow<0x1::string::String, Config>(&arg1.configs, arg5)
        } else {
            &arg1.default_config
        };
        assert!(v2.enabled, 7);
        let (v3, v4) = 0x2::kiosk::purchase_with_cap<Card>(arg2, 0x2::kiosk::list_with_purchase_cap<Card>(arg2, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow(arg3), arg6, 0, arg11), 0x2::coin::zero<0x2::sui::SUI>(arg11));
        let (_, _, _) = 0x2::transfer_policy::confirm_request<Card>(&arg1.transfer_policy, v4);
        let v8 = if (0x2::table::contains<0x1::string::String, 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(&arg1.balances, arg5)) {
            0x2::table::borrow_mut<0x1::string::String, 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(&mut arg1.balances, arg5)
        } else {
            &mut arg1.default_balance
        };
        assert!(arg7 + arg8 <= 0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v8), 3);
        0x2::pay::keep<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x2::coin::from_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x2::balance::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v8, arg7), arg11), arg11);
        0x2::balance::join<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg1.fee_balance, 0x2::balance::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v8, arg8));
        0x2::table::add<u128, bool>(&mut arg1.orders, arg4, true);
        let Card {
            id          : v9,
            name        : _,
            description : _,
            media_url   : _,
            attributes  : _,
            hash        : _,
            revealed    : _,
        } = v3;
        0x2::object::delete(v9);
        let v16 = CardSoldEvent{
            card_id    : arg6,
            vault_name : arg5,
            order_id   : arg4,
            price      : arg7,
            fee        : arg8,
        };
        0x2::event::emit<CardSoldEvent>(v16);
    }

    entry fun set_admin(arg0: &mut Store, arg1: address, arg2: &0x2::tx_context::TxContext) {
        verify_version(arg0);
        verify_admin(arg0, arg2);
        arg0.admin = arg1;
    }

    entry fun set_default_config(arg0: &mut Store, arg1: u64, arg2: u64, arg3: bool, arg4: &0x2::tx_context::TxContext) {
        verify_version(arg0);
        verify_admin(arg0, arg4);
        let v0 = Config{
            price     : arg1,
            pack_size : arg2,
            enabled   : arg3,
        };
        arg0.default_config = v0;
    }

    entry fun set_mint_admin(arg0: &mut Store, arg1: address, arg2: &0x2::tx_context::TxContext) {
        verify_version(arg0);
        verify_admin(arg0, arg2);
        arg0.mint_admin = arg1;
    }

    entry fun set_public_key(arg0: &mut Store, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) {
        verify_version(arg0);
        verify_admin(arg0, arg2);
        assert!(0x1::vector::length<u8>(&arg1) == 32, 4);
        arg0.public_key = arg1;
    }

    entry fun set_vault_config(arg0: &mut Store, arg1: 0x1::string::String, arg2: u64, arg3: u64, arg4: bool, arg5: &0x2::tx_context::TxContext) {
        verify_version(arg0);
        verify_admin(arg0, arg5);
        if (0x2::table::contains<0x1::string::String, Config>(&arg0.configs, arg1)) {
            0x2::table::remove<0x1::string::String, Config>(&mut arg0.configs, arg1);
        };
        let v0 = Config{
            price     : arg2,
            pack_size : arg3,
            enabled   : arg4,
        };
        0x2::table::add<0x1::string::String, Config>(&mut arg0.configs, arg1, v0);
    }

    entry fun set_version(arg0: &mut Store, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        verify_version(arg0);
        verify_admin(arg0, arg2);
        arg0.version = arg1;
    }

    entry fun top_up_default_balance(arg0: &mut Store, arg1: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg2: &0x2::tx_context::TxContext) {
        verify_version(arg0);
        verify_admin(arg0, arg2);
        0x2::balance::join<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.default_balance, 0x2::coin::into_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg1));
    }

    entry fun top_up_vault_balance(arg0: &mut Store, arg1: 0x1::string::String, arg2: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg3: &0x2::tx_context::TxContext) {
        verify_version(arg0);
        verify_admin(arg0, arg3);
        if (0x2::table::contains<0x1::string::String, 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(&arg0.balances, arg1)) {
            0x2::balance::join<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x2::table::borrow_mut<0x1::string::String, 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(&mut arg0.balances, arg1), 0x2::coin::into_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2));
        } else {
            0x2::table::add<0x1::string::String, 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(&mut arg0.balances, arg1, 0x2::coin::into_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2));
        };
    }

    fun verify_admin(arg0: &Store, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg1), 2);
    }

    fun verify_mint_admin(arg0: &Store, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.mint_admin == 0x2::tx_context::sender(arg1), 2);
    }

    fun verify_version(arg0: &Store) {
        assert!(arg0.version == 1, 1);
    }

    entry fun withdraw_default_balance(arg0: &mut Store, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        verify_version(arg0);
        verify_admin(arg0, arg3);
        let v0 = if (arg1 == 0) {
            0x2::balance::withdraw_all<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.default_balance)
        } else {
            0x2::balance::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.default_balance, arg1)
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(0x2::coin::from_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v0, arg3), arg2);
    }

    entry fun withdraw_fee_balance(arg0: &mut Store, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        verify_version(arg0);
        verify_admin(arg0, arg3);
        let v0 = if (arg1 == 0) {
            0x2::balance::withdraw_all<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.fee_balance)
        } else {
            0x2::balance::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.fee_balance, arg1)
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(0x2::coin::from_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v0, arg3), arg2);
    }

    entry fun withdraw_vault_balance(arg0: &mut Store, arg1: 0x1::string::String, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        verify_version(arg0);
        verify_admin(arg0, arg4);
        assert!(0x2::table::contains<0x1::string::String, 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(&arg0.balances, arg1), 3);
        let v0 = if (arg2 == 0) {
            0x2::balance::withdraw_all<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x2::table::borrow_mut<0x1::string::String, 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(&mut arg0.balances, arg1))
        } else {
            0x2::balance::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x2::table::borrow_mut<0x1::string::String, 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(&mut arg0.balances, arg1), arg2)
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(0x2::coin::from_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v0, arg4), arg3);
    }

    // decompiled from Move bytecode v6
}

