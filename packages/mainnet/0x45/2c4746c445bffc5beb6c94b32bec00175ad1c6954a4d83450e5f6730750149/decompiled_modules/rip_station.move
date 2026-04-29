module 0x452c4746c445bffc5beb6c94b32bec00175ad1c6954a4d83450e5f6730750149::rip_station {
    struct RIP_STATION has drop {
        dummy_field: bool,
    }

    struct RipStationRevealExt has drop {
        dummy_field: bool,
    }

    struct RevealTicket has copy, drop, store {
        card_id: 0x2::object::ID,
    }

    struct Store has store, key {
        id: 0x2::object::UID,
        version: u64,
        admin: address,
        operator: address,
        public_key: vector<u8>,
        fee_balance: 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>,
        balance: 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>,
        vaults: 0x2::table::Table<0x1::string::String, 0x452c4746c445bffc5beb6c94b32bec00175ad1c6954a4d83450e5f6730750149::vault::Vault>,
        vault_configs: 0x2::table::Table<0x1::string::String, Config>,
        transfer_policies: 0x2::bag::Bag,
        transfer_policy_caps: 0x2::bag::Bag,
        pack_index: u128,
        orders: 0x2::table::Table<u128, bool>,
    }

    struct Config has copy, drop, store {
        enabled: bool,
        price: u64,
        pack_size: u64,
        placeholder_name: 0x1::string::String,
        placeholder_description: 0x1::string::String,
        placeholder_media_url: 0x1::string::String,
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

    struct CardBurnedEvent has copy, drop {
        card_id: 0x2::object::ID,
        vault_name: 0x1::string::String,
    }

    struct PackBoughtEvent has copy, drop {
        card_ids: vector<0x2::object::ID>,
        vault_name: 0x1::string::String,
        pack_id: u128,
        price: u64,
    }

    struct CardRevealedEvent has copy, drop {
        card_id: 0x2::object::ID,
    }

    struct CardDepositedForRevealEvent has copy, drop {
        card_id: 0x2::object::ID,
        kiosk_id: 0x2::object::ID,
    }

    struct CardSoldEvent has copy, drop {
        card_id: 0x2::object::ID,
        order_id: u128,
        price: u64,
        fee: u64,
    }

    struct CardsRedeemedEvent has copy, drop {
        order_id: 0x1::string::String,
    }

    struct CardRedeemedEvent has copy, drop {
        card_id: 0x2::object::ID,
    }

    entry fun init_card_type<T0: store + key>(arg0: &mut Store, arg1: &0x2::package::Publisher, arg2: &mut 0x2::tx_context::TxContext) {
        verify_version(arg0);
        verify_admin(arg0, arg2);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.transfer_policies, v0), 12);
        assert!(v0 == 0x1::type_name::with_defining_ids<0x452c4746c445bffc5beb6c94b32bec00175ad1c6954a4d83450e5f6730750149::pokemon::Card>(), 14);
        let (v1, v2) = 0x452c4746c445bffc5beb6c94b32bec00175ad1c6954a4d83450e5f6730750149::pokemon::init_card_type(arg1, arg2);
        0x2::bag::add<0x1::type_name::TypeName, 0x2::transfer_policy::TransferPolicy<0x452c4746c445bffc5beb6c94b32bec00175ad1c6954a4d83450e5f6730750149::pokemon::Card>>(&mut arg0.transfer_policies, v0, v1);
        0x2::bag::add<0x1::type_name::TypeName, 0x2::transfer_policy::TransferPolicyCap<0x452c4746c445bffc5beb6c94b32bec00175ad1c6954a4d83450e5f6730750149::pokemon::Card>>(&mut arg0.transfer_policy_caps, v0, v2);
    }

    entry fun burn_cards(arg0: &0x2::clock::Clock, arg1: &mut Store, arg2: 0x1::string::String, arg3: vector<0x2::object::ID>, arg4: u64, arg5: vector<u8>, arg6: &0x2::tx_context::TxContext) {
        verify_version(arg1);
        verify_operator(arg1, arg6);
        assert!(0x2::clock::timestamp_ms(arg0) < arg4, 6);
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0x2::tx_context::sender(arg6);
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<address>(&v1));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<0x1::string::String>(&arg2));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<vector<0x2::object::ID>>(&arg3));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg4));
        assert!(0x2::ed25519::ed25519_verify(&arg5, &arg1.public_key, &v0), 4);
        assert!(0x2::table::contains<0x1::string::String, 0x452c4746c445bffc5beb6c94b32bec00175ad1c6954a4d83450e5f6730750149::vault::Vault>(&arg1.vaults, arg2), 10);
        let v2 = 0x2::table::borrow_mut<0x1::string::String, 0x452c4746c445bffc5beb6c94b32bec00175ad1c6954a4d83450e5f6730750149::vault::Vault>(&mut arg1.vaults, arg2);
        let v3 = 0;
        while (v3 < 0x1::vector::length<0x2::object::ID>(&arg3)) {
            let v4 = *0x1::vector::borrow<0x2::object::ID>(&arg3, v3);
            assert!(0x452c4746c445bffc5beb6c94b32bec00175ad1c6954a4d83450e5f6730750149::vault::card_type(v2) == 0x1::type_name::with_defining_ids<0x452c4746c445bffc5beb6c94b32bec00175ad1c6954a4d83450e5f6730750149::pokemon::Card>(), 14);
            0x452c4746c445bffc5beb6c94b32bec00175ad1c6954a4d83450e5f6730750149::pokemon::burn_card(0x452c4746c445bffc5beb6c94b32bec00175ad1c6954a4d83450e5f6730750149::vault::remove_by_id<0x452c4746c445bffc5beb6c94b32bec00175ad1c6954a4d83450e5f6730750149::pokemon::Card>(v2, v4), false);
            let v5 = CardBurnedEvent{
                card_id    : v4,
                vault_name : arg2,
            };
            0x2::event::emit<CardBurnedEvent>(v5);
            v3 = v3 + 1;
        };
    }

    entry fun buy_packs_with_personal_kiosk(arg0: &0x2::random::Random, arg1: &mut Store, arg2: 0x1::string::String, arg3: u64, arg4: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg5: &mut 0x2::kiosk::Kiosk, arg6: &0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg7: &mut 0x2::tx_context::TxContext) : vector<0x2::object::ID> {
        verify_version(arg1);
        assert!(0x2::table::contains<0x1::string::String, 0x452c4746c445bffc5beb6c94b32bec00175ad1c6954a4d83450e5f6730750149::vault::Vault>(&arg1.vaults, arg2), 10);
        let v0 = 0x2::table::borrow_mut<0x1::string::String, 0x452c4746c445bffc5beb6c94b32bec00175ad1c6954a4d83450e5f6730750149::vault::Vault>(&mut arg1.vaults, arg2);
        assert!(0x2::table::contains<0x1::string::String, Config>(&arg1.vault_configs, arg2), 11);
        let v1 = 0x2::table::borrow<0x1::string::String, Config>(&arg1.vault_configs, arg2);
        assert!(v1.enabled, 7);
        assert!(arg3 <= 5, 15);
        if (0x2::tx_context::sender(arg7) != arg1.operator) {
            assert!(0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg4) == arg3 * v1.price, 3);
        };
        0x2::balance::join<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg1.balance, 0x2::coin::into_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg4));
        let v2 = 0x2::random::new_generator(arg0, arg7);
        let v3 = &mut v2;
        let v4 = 0x1::vector::empty<0x2::object::ID>();
        while (arg3 > 0) {
            let v5 = 0;
            while (v5 < v1.pack_size) {
                assert!(0x452c4746c445bffc5beb6c94b32bec00175ad1c6954a4d83450e5f6730750149::vault::card_type(v0) == 0x1::type_name::with_defining_ids<0x452c4746c445bffc5beb6c94b32bec00175ad1c6954a4d83450e5f6730750149::pokemon::Card>(), 14);
                let v6 = 0x452c4746c445bffc5beb6c94b32bec00175ad1c6954a4d83450e5f6730750149::vault::remove_by_index<0x452c4746c445bffc5beb6c94b32bec00175ad1c6954a4d83450e5f6730750149::pokemon::Card>(v0, 0x2::random::generate_u64_in_range(v3, 0, 0x452c4746c445bffc5beb6c94b32bec00175ad1c6954a4d83450e5f6730750149::vault::length(v0) - 1));
                0x1::vector::push_back<0x2::object::ID>(&mut v4, 0x2::object::id<0x452c4746c445bffc5beb6c94b32bec00175ad1c6954a4d83450e5f6730750149::pokemon::Card>(&v6));
                0x2::kiosk::lock<0x452c4746c445bffc5beb6c94b32bec00175ad1c6954a4d83450e5f6730750149::pokemon::Card>(arg5, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow(arg6), 0x2::bag::borrow<0x1::type_name::TypeName, 0x2::transfer_policy::TransferPolicy<0x452c4746c445bffc5beb6c94b32bec00175ad1c6954a4d83450e5f6730750149::pokemon::Card>>(&arg1.transfer_policies, 0x452c4746c445bffc5beb6c94b32bec00175ad1c6954a4d83450e5f6730750149::vault::card_type(v0)), v6);
                v5 = v5 + 1;
            };
            let v7 = PackBoughtEvent{
                card_ids   : v4,
                vault_name : arg2,
                pack_id    : arg1.pack_index + 1,
                price      : v1.price,
            };
            0x2::event::emit<PackBoughtEvent>(v7);
            arg1.pack_index = arg1.pack_index + 1;
            arg3 = arg3 - 1;
        };
        v4
    }

    entry fun buy_packs_with_personal_kiosk_and_deposit_for_reveal<T0: store + key>(arg0: &0x2::random::Random, arg1: &mut Store, arg2: 0x1::string::String, arg3: u64, arg4: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg5: &mut 0x2::kiosk::Kiosk, arg6: &0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg7: &mut 0x2::tx_context::TxContext) {
        verify_version(arg1);
        let v0 = buy_packs_with_personal_kiosk(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        0x1::vector::reverse<0x2::object::ID>(&mut v0);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x2::object::ID>(&v0)) {
            deposit_card_for_reveal<T0>(arg1, 0x1::vector::pop_back<0x2::object::ID>(&mut v0), arg5, arg6, arg7);
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<0x2::object::ID>(v0);
    }

    entry fun buy_packs_without_personal_kiosk(arg0: &0x2::random::Random, arg1: &mut Store, arg2: 0x1::string::String, arg3: u64, arg4: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg5: &mut 0x2::tx_context::TxContext) {
        verify_version(arg1);
        let (v0, v1) = 0x2::kiosk::new(arg5);
        let v2 = v0;
        let v3 = 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::new(&mut v2, v1, arg5);
        let v4 = &mut v2;
        buy_packs_with_personal_kiosk(arg0, arg1, arg2, arg3, arg4, v4, &v3, arg5);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v2);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::transfer_to_sender(v3, arg5);
    }

    entry fun buy_packs_without_personal_kiosk_and_deposit_for_reveal<T0: store + key>(arg0: &0x2::random::Random, arg1: &mut Store, arg2: 0x1::string::String, arg3: u64, arg4: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg5: &mut 0x2::tx_context::TxContext) {
        verify_version(arg1);
        let (v0, v1) = 0x2::kiosk::new(arg5);
        let v2 = v0;
        let v3 = 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::new(&mut v2, v1, arg5);
        let v4 = &mut v2;
        buy_packs_with_personal_kiosk_and_deposit_for_reveal<T0>(arg0, arg1, arg2, arg3, arg4, v4, &v3, arg5);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v2);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::transfer_to_sender(v3, arg5);
    }

    entry fun deposit_balance(arg0: &mut Store, arg1: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>) {
        verify_version(arg0);
        0x2::balance::join<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.balance, 0x2::coin::into_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg1));
    }

    entry fun deposit_card_for_reveal<T0: store + key>(arg0: &Store, arg1: 0x2::object::ID, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg4: &mut 0x2::tx_context::TxContext) {
        verify_version(arg0);
        if (!0x2::kiosk_extension::is_installed<RipStationRevealExt>(arg2)) {
            let v0 = RipStationRevealExt{dummy_field: false};
            0x2::kiosk_extension::add<RipStationRevealExt>(v0, arg2, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow(arg3), 2, arg4);
        };
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        assert!(v1 == 0x1::type_name::with_defining_ids<0x452c4746c445bffc5beb6c94b32bec00175ad1c6954a4d83450e5f6730750149::pokemon::Card>(), 14);
        let (v2, v3) = 0x2::kiosk::purchase_with_cap<0x452c4746c445bffc5beb6c94b32bec00175ad1c6954a4d83450e5f6730750149::pokemon::Card>(arg2, 0x2::kiosk::list_with_purchase_cap<0x452c4746c445bffc5beb6c94b32bec00175ad1c6954a4d83450e5f6730750149::pokemon::Card>(arg2, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow(arg3), arg1, 0, arg4), 0x2::coin::zero<0x2::sui::SUI>(arg4));
        let (_, _, _) = 0x2::transfer_policy::confirm_request<0x452c4746c445bffc5beb6c94b32bec00175ad1c6954a4d83450e5f6730750149::pokemon::Card>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::transfer_policy::TransferPolicy<0x452c4746c445bffc5beb6c94b32bec00175ad1c6954a4d83450e5f6730750149::pokemon::Card>>(&arg0.transfer_policies, v1), v3);
        let v7 = RipStationRevealExt{dummy_field: false};
        let v8 = RevealTicket{card_id: arg1};
        0x2::bag::add<RevealTicket, 0x452c4746c445bffc5beb6c94b32bec00175ad1c6954a4d83450e5f6730750149::pokemon::Card>(0x2::kiosk_extension::storage_mut<RipStationRevealExt>(v7, arg2), v8, v2);
        let v9 = CardDepositedForRevealEvent{
            card_id  : arg1,
            kiosk_id : 0x2::object::id<0x2::kiosk::Kiosk>(arg2),
        };
        0x2::event::emit<CardDepositedForRevealEvent>(v9);
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

    fun init(arg0: RIP_STATION, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Store{
            id                   : 0x2::object::new(arg1),
            version              : 1,
            admin                : 0x2::tx_context::sender(arg1),
            operator             : 0x2::tx_context::sender(arg1),
            public_key           : 0x1::vector::empty<u8>(),
            fee_balance          : 0x2::balance::zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(),
            balance              : 0x2::balance::zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(),
            vaults               : 0x2::table::new<0x1::string::String, 0x452c4746c445bffc5beb6c94b32bec00175ad1c6954a4d83450e5f6730750149::vault::Vault>(arg1),
            vault_configs        : 0x2::table::new<0x1::string::String, Config>(arg1),
            transfer_policies    : 0x2::bag::new(arg1),
            transfer_policy_caps : 0x2::bag::new(arg1),
            pack_index           : 0,
            orders               : 0x2::table::new<u128, bool>(arg1),
        };
        0x2::transfer::public_share_object<Store>(v0);
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<RIP_STATION>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    entry fun mint_cards(arg0: &0x2::clock::Clock, arg1: &mut Store, arg2: vector<0x1::string::String>, arg3: vector<vector<u8>>, arg4: 0x1::string::String, arg5: u64, arg6: vector<u8>, arg7: &mut 0x2::tx_context::TxContext) {
        verify_version(arg1);
        verify_operator(arg1, arg7);
        assert!(0x2::clock::timestamp_ms(arg0) < arg5, 6);
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0x2::tx_context::sender(arg7);
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<address>(&v1));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<vector<0x1::string::String>>(&arg2));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<vector<vector<u8>>>(&arg3));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<0x1::string::String>(&arg4));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg5));
        assert!(0x2::ed25519::ed25519_verify(&arg6, &arg1.public_key, &v0), 4);
        assert!(0x2::table::contains<0x1::string::String, 0x452c4746c445bffc5beb6c94b32bec00175ad1c6954a4d83450e5f6730750149::vault::Vault>(&arg1.vaults, arg4), 10);
        let v2 = 0x2::table::borrow_mut<0x1::string::String, 0x452c4746c445bffc5beb6c94b32bec00175ad1c6954a4d83450e5f6730750149::vault::Vault>(&mut arg1.vaults, arg4);
        assert!(0x2::table::contains<0x1::string::String, Config>(&arg1.vault_configs, arg4), 11);
        let v3 = 0x2::table::borrow<0x1::string::String, Config>(&arg1.vault_configs, arg4);
        let v4 = 0x1::vector::length<0x1::string::String>(&arg2);
        assert!(v4 == 0x1::vector::length<vector<u8>>(&arg3), 9);
        let v5 = 0;
        while (v5 < v4) {
            assert!(0x452c4746c445bffc5beb6c94b32bec00175ad1c6954a4d83450e5f6730750149::vault::card_type(v2) == 0x1::type_name::with_defining_ids<0x452c4746c445bffc5beb6c94b32bec00175ad1c6954a4d83450e5f6730750149::pokemon::Card>(), 14);
            let v6 = 0x452c4746c445bffc5beb6c94b32bec00175ad1c6954a4d83450e5f6730750149::pokemon::mint_card(v3.placeholder_name, v3.placeholder_description, v3.placeholder_media_url, 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>(), *0x1::vector::borrow<vector<u8>>(&arg3, v5), false, arg7);
            0x452c4746c445bffc5beb6c94b32bec00175ad1c6954a4d83450e5f6730750149::vault::add<0x452c4746c445bffc5beb6c94b32bec00175ad1c6954a4d83450e5f6730750149::pokemon::Card>(v2, v6);
            let v7 = CardMintedEvent{
                id         : *0x1::vector::borrow<0x1::string::String>(&arg2, v5),
                card_id    : 0x2::object::id<0x452c4746c445bffc5beb6c94b32bec00175ad1c6954a4d83450e5f6730750149::pokemon::Card>(&v6),
                vault_name : arg4,
            };
            0x2::event::emit<CardMintedEvent>(v7);
            v5 = v5 + 1;
        };
    }

    public fun redeem_card<T0: store + key>(arg0: &Store, arg1: &mut RedeemCardsRequest, arg2: 0x2::object::ID, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg5: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x1::vector::index_of<0x2::object::ID>(&arg1.card_ids, &arg2);
        assert!(v0, 9);
        0x1::vector::swap_remove<0x2::object::ID>(&mut arg1.card_ids, v1);
        let v2 = 0x1::type_name::with_defining_ids<T0>();
        assert!(v2 == 0x1::type_name::with_defining_ids<0x452c4746c445bffc5beb6c94b32bec00175ad1c6954a4d83450e5f6730750149::pokemon::Card>(), 14);
        let (v3, v4) = 0x2::kiosk::purchase_with_cap<0x452c4746c445bffc5beb6c94b32bec00175ad1c6954a4d83450e5f6730750149::pokemon::Card>(arg3, 0x2::kiosk::list_with_purchase_cap<0x452c4746c445bffc5beb6c94b32bec00175ad1c6954a4d83450e5f6730750149::pokemon::Card>(arg3, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow(arg4), arg2, 0, arg5), 0x2::coin::zero<0x2::sui::SUI>(arg5));
        let (_, _, _) = 0x2::transfer_policy::confirm_request<0x452c4746c445bffc5beb6c94b32bec00175ad1c6954a4d83450e5f6730750149::pokemon::Card>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::transfer_policy::TransferPolicy<0x452c4746c445bffc5beb6c94b32bec00175ad1c6954a4d83450e5f6730750149::pokemon::Card>>(&arg0.transfer_policies, v2), v4);
        0x452c4746c445bffc5beb6c94b32bec00175ad1c6954a4d83450e5f6730750149::pokemon::burn_card(v3, true);
        let v8 = CardRedeemedEvent{card_id: arg2};
        0x2::event::emit<CardRedeemedEvent>(v8);
    }

    entry fun reveal_and_return<T0: store + key>(arg0: &Store, arg1: 0x2::object::ID, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: vector<0x1::string::String>, arg6: vector<0x1::string::String>, arg7: vector<u8>, arg8: &mut 0x2::kiosk::Kiosk, arg9: &0x2::tx_context::TxContext) {
        verify_version(arg0);
        verify_operator(arg0, arg9);
        assert!(0x2::kiosk_extension::is_installed<RipStationRevealExt>(arg8), 16);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(v0 == 0x1::type_name::with_defining_ids<0x452c4746c445bffc5beb6c94b32bec00175ad1c6954a4d83450e5f6730750149::pokemon::Card>(), 14);
        let v1 = RipStationRevealExt{dummy_field: false};
        let v2 = 0x2::kiosk_extension::storage_mut<RipStationRevealExt>(v1, arg8);
        let v3 = RevealTicket{card_id: arg1};
        assert!(0x2::bag::contains<RevealTicket>(v2, v3), 17);
        let v4 = 0x2::bag::remove<RevealTicket, 0x452c4746c445bffc5beb6c94b32bec00175ad1c6954a4d83450e5f6730750149::pokemon::Card>(v2, v3);
        0x452c4746c445bffc5beb6c94b32bec00175ad1c6954a4d83450e5f6730750149::pokemon::reveal_card(&mut v4, arg2, arg3, arg4, 0x2::vec_map::from_keys_values<0x1::string::String, 0x1::string::String>(arg5, arg6), arg7);
        let v5 = RipStationRevealExt{dummy_field: false};
        0x2::kiosk_extension::lock<RipStationRevealExt, 0x452c4746c445bffc5beb6c94b32bec00175ad1c6954a4d83450e5f6730750149::pokemon::Card>(v5, arg8, v4, 0x2::bag::borrow<0x1::type_name::TypeName, 0x2::transfer_policy::TransferPolicy<0x452c4746c445bffc5beb6c94b32bec00175ad1c6954a4d83450e5f6730750149::pokemon::Card>>(&arg0.transfer_policies, v0));
        let v6 = CardRevealedEvent{card_id: arg1};
        0x2::event::emit<CardRevealedEvent>(v6);
    }

    entry fun sell_card<T0: store + key>(arg0: &0x2::clock::Clock, arg1: &mut Store, arg2: u128, arg3: 0x2::object::ID, arg4: u64, arg5: u64, arg6: u64, arg7: vector<u8>, arg8: &mut 0x2::kiosk::Kiosk, arg9: &0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg10: &mut 0x2::tx_context::TxContext) {
        verify_version(arg1);
        assert!(0x2::clock::timestamp_ms(arg0) < arg6, 6);
        assert!(!0x2::table::contains<u128, bool>(&arg1.orders, arg2), 5);
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0x2::tx_context::sender(arg10);
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<address>(&v1));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u128>(&arg2));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<0x2::object::ID>(&arg3));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg4));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg5));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg6));
        assert!(0x2::ed25519::ed25519_verify(&arg7, &arg1.public_key, &v0), 4);
        assert!(arg4 + arg5 <= 0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg1.balance), 3);
        0x2::pay::keep<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x2::coin::from_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x2::balance::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg1.balance, arg4), arg10), arg10);
        0x2::balance::join<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg1.fee_balance, 0x2::balance::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg1.balance, arg5));
        let v2 = 0x1::type_name::with_defining_ids<T0>();
        assert!(v2 == 0x1::type_name::with_defining_ids<0x452c4746c445bffc5beb6c94b32bec00175ad1c6954a4d83450e5f6730750149::pokemon::Card>(), 14);
        let (v3, v4) = 0x2::kiosk::purchase_with_cap<0x452c4746c445bffc5beb6c94b32bec00175ad1c6954a4d83450e5f6730750149::pokemon::Card>(arg8, 0x2::kiosk::list_with_purchase_cap<0x452c4746c445bffc5beb6c94b32bec00175ad1c6954a4d83450e5f6730750149::pokemon::Card>(arg8, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow(arg9), arg3, 0, arg10), 0x2::coin::zero<0x2::sui::SUI>(arg10));
        let (_, _, _) = 0x2::transfer_policy::confirm_request<0x452c4746c445bffc5beb6c94b32bec00175ad1c6954a4d83450e5f6730750149::pokemon::Card>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::transfer_policy::TransferPolicy<0x452c4746c445bffc5beb6c94b32bec00175ad1c6954a4d83450e5f6730750149::pokemon::Card>>(&arg1.transfer_policies, v2), v4);
        0x452c4746c445bffc5beb6c94b32bec00175ad1c6954a4d83450e5f6730750149::pokemon::burn_card(v3, true);
        let v8 = CardSoldEvent{
            card_id  : arg3,
            order_id : arg2,
            price    : arg4,
            fee      : arg5,
        };
        0x2::event::emit<CardSoldEvent>(v8);
        0x2::table::add<u128, bool>(&mut arg1.orders, arg2, true);
    }

    entry fun set_admin(arg0: &mut Store, arg1: address, arg2: &0x2::tx_context::TxContext) {
        verify_version(arg0);
        verify_admin(arg0, arg2);
        arg0.admin = arg1;
    }

    entry fun set_operator(arg0: &mut Store, arg1: address, arg2: &0x2::tx_context::TxContext) {
        verify_version(arg0);
        verify_admin(arg0, arg2);
        arg0.operator = arg1;
    }

    entry fun set_public_key(arg0: &mut Store, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) {
        verify_version(arg0);
        verify_admin(arg0, arg2);
        assert!(0x1::vector::length<u8>(&arg1) == 32, 4);
        arg0.public_key = arg1;
    }

    entry fun set_vault_config<T0: store + key>(arg0: &mut Store, arg1: 0x1::string::String, arg2: bool, arg3: u64, arg4: u64, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: &mut 0x2::tx_context::TxContext) {
        verify_version(arg0);
        verify_admin(arg0, arg8);
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&arg0.transfer_policies, 0x1::type_name::with_defining_ids<T0>()), 13);
        if (!0x2::table::contains<0x1::string::String, 0x452c4746c445bffc5beb6c94b32bec00175ad1c6954a4d83450e5f6730750149::vault::Vault>(&arg0.vaults, arg1)) {
            0x2::table::add<0x1::string::String, 0x452c4746c445bffc5beb6c94b32bec00175ad1c6954a4d83450e5f6730750149::vault::Vault>(&mut arg0.vaults, arg1, 0x452c4746c445bffc5beb6c94b32bec00175ad1c6954a4d83450e5f6730750149::vault::new<T0>(arg8));
        };
        if (0x2::table::contains<0x1::string::String, Config>(&arg0.vault_configs, arg1)) {
            0x2::table::remove<0x1::string::String, Config>(&mut arg0.vault_configs, arg1);
        };
        let v0 = Config{
            enabled                 : arg2,
            price                   : arg3,
            pack_size               : arg4,
            placeholder_name        : arg5,
            placeholder_description : arg6,
            placeholder_media_url   : arg7,
        };
        0x2::table::add<0x1::string::String, Config>(&mut arg0.vault_configs, arg1, v0);
    }

    entry fun set_version(arg0: &mut Store, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        verify_version(arg0);
        verify_admin(arg0, arg2);
        arg0.version = arg1;
    }

    public fun start_redeem_cards(arg0: &mut Store, arg1: 0x1::string::String, arg2: vector<0x2::object::ID>, arg3: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg4: u64, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) : RedeemCardsRequest {
        verify_version(arg0);
        assert!(0x1::vector::length<0x2::object::ID>(&arg2) > 0, 8);
        assert!(0x2::clock::timestamp_ms(arg6) < arg4, 6);
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0x2::tx_context::sender(arg7);
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<address>(&v1));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<0x1::string::String>(&arg1));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<vector<0x2::object::ID>>(&arg2));
        let v2 = 0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg3);
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&v2));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg4));
        assert!(0x2::ed25519::ed25519_verify(&arg5, &arg0.public_key, &v0), 4);
        0x2::balance::join<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.balance, 0x2::coin::into_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg3));
        RedeemCardsRequest{
            order_id : arg1,
            card_ids : arg2,
        }
    }

    fun verify_admin(arg0: &Store, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg1), 2);
    }

    fun verify_operator(arg0: &Store, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.operator == 0x2::tx_context::sender(arg1), 2);
    }

    fun verify_version(arg0: &Store) {
        assert!(arg0.version <= 1, 1);
    }

    entry fun withdraw_balance(arg0: &mut Store, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        verify_version(arg0);
        verify_admin(arg0, arg3);
        let v0 = if (arg1 == 0) {
            0x2::balance::withdraw_all<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.balance)
        } else {
            0x2::balance::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.balance, arg1)
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

    // decompiled from Move bytecode v7
}

