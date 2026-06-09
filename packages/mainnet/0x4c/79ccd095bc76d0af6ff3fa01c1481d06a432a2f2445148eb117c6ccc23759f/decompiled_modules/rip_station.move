module 0xa6d2695f4c006319e80bae63dc6ddce47c1c164db13101f59fe70aa7f57651b5::rip_station {
    struct RIP_STATION has drop {
        dummy_field: bool,
    }

    struct RipStationExt has drop {
        dummy_field: bool,
    }

    struct RevealTicket has copy, drop, store {
        card_id: 0x2::object::ID,
    }

    struct RedeemTicket has copy, drop, store {
        card_id: 0x2::object::ID,
        order_id: 0x1::string::String,
    }

    struct Store has store, key {
        id: 0x2::object::UID,
        version: u64,
        admin: address,
        operator: address,
        fee_receiver: address,
        royalty_receiver: address,
        public_key: vector<u8>,
        balance: 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>,
        vaults: 0x2::table::Table<0x1::string::String, 0xa6d2695f4c006319e80bae63dc6ddce47c1c164db13101f59fe70aa7f57651b5::vault::Vault>,
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
        remaining_packs: u64,
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

    struct VaultDisabledEvent has copy, drop {
        vault_name: 0x1::string::String,
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

    struct CardRedeemedEvent has copy, drop {
        card_id: 0x2::object::ID,
    }

    struct CardDelayedRedeemEvent has copy, drop {
        order_id: 0x1::string::String,
        card_id: 0x2::object::ID,
        kiosk_id: 0x2::object::ID,
    }

    struct CardTypeInitializedEvent<phantom T0> has copy, drop {
        dummy_field: bool,
    }

    entry fun init_card_type<T0>(arg0: &mut Store, arg1: &0x2::package::Publisher, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) {
        verify_version(arg0);
        verify_admin(arg0, arg5);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.transfer_policies, v0), 17);
        let (v1, v2) = 0xa6d2695f4c006319e80bae63dc6ddce47c1c164db13101f59fe70aa7f57651b5::card::init_card_type<T0>(arg1, arg2, arg3, arg4, arg5);
        0x2::bag::add<0x1::type_name::TypeName, 0x2::transfer_policy::TransferPolicy<0xa6d2695f4c006319e80bae63dc6ddce47c1c164db13101f59fe70aa7f57651b5::card::Card<T0>>>(&mut arg0.transfer_policies, v0, v1);
        0x2::bag::add<0x1::type_name::TypeName, 0x2::transfer_policy::TransferPolicyCap<0xa6d2695f4c006319e80bae63dc6ddce47c1c164db13101f59fe70aa7f57651b5::card::Card<T0>>>(&mut arg0.transfer_policy_caps, v0, v2);
        let v3 = CardTypeInitializedEvent<T0>{dummy_field: false};
        0x2::event::emit<CardTypeInitializedEvent<T0>>(v3);
    }

    entry fun burn_cards<T0>(arg0: &0x2::clock::Clock, arg1: &mut Store, arg2: 0x1::string::String, arg3: vector<0x2::object::ID>, arg4: u64, arg5: vector<u8>, arg6: &0x2::tx_context::TxContext) {
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
        assert!(0x2::table::contains<0x1::string::String, 0xa6d2695f4c006319e80bae63dc6ddce47c1c164db13101f59fe70aa7f57651b5::vault::Vault>(&arg1.vaults, arg2), 10);
        let v2 = 0x2::table::borrow_mut<0x1::string::String, 0xa6d2695f4c006319e80bae63dc6ddce47c1c164db13101f59fe70aa7f57651b5::vault::Vault>(&mut arg1.vaults, arg2);
        let v3 = 0;
        while (v3 < 0x1::vector::length<0x2::object::ID>(&arg3)) {
            let v4 = *0x1::vector::borrow<0x2::object::ID>(&arg3, v3);
            0xa6d2695f4c006319e80bae63dc6ddce47c1c164db13101f59fe70aa7f57651b5::card::burn_card<T0>(0xa6d2695f4c006319e80bae63dc6ddce47c1c164db13101f59fe70aa7f57651b5::vault::remove_by_id<T0>(v2, v4), false);
            let v5 = CardBurnedEvent{
                card_id    : v4,
                vault_name : arg2,
            };
            0x2::event::emit<CardBurnedEvent>(v5);
            v3 = v3 + 1;
        };
    }

    entry fun burn_redeem_card<T0>(arg0: &0x2::clock::Clock, arg1: &Store, arg2: 0x1::string::String, arg3: 0x2::object::ID, arg4: &mut 0x2::kiosk::Kiosk, arg5: u64, arg6: vector<u8>, arg7: &0x2::tx_context::TxContext) {
        verify_version(arg1);
        verify_operator(arg1, arg7);
        assert!(0x2::clock::timestamp_ms(arg0) < arg5, 6);
        assert!(0x2::kiosk_extension::is_installed<RipStationExt>(arg4), 15);
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0x2::tx_context::sender(arg7);
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<address>(&v1));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<0x1::string::String>(&arg2));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<0x2::object::ID>(&arg3));
        let v2 = 0x2::object::id<0x2::kiosk::Kiosk>(arg4);
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<0x2::object::ID>(&v2));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg5));
        assert!(0x2::ed25519::ed25519_verify(&arg6, &arg1.public_key, &v0), 4);
        let v3 = RipStationExt{dummy_field: false};
        let v4 = 0x2::kiosk_extension::storage_mut<RipStationExt>(v3, arg4);
        let v5 = RedeemTicket{
            card_id  : arg3,
            order_id : arg2,
        };
        assert!(0x2::bag::contains<RedeemTicket>(v4, v5), 16);
        0xa6d2695f4c006319e80bae63dc6ddce47c1c164db13101f59fe70aa7f57651b5::card::burn_card<T0>(0x2::bag::remove<RedeemTicket, 0xa6d2695f4c006319e80bae63dc6ddce47c1c164db13101f59fe70aa7f57651b5::card::Card<T0>>(v4, v5), true);
        let v6 = CardRedeemedEvent{card_id: arg3};
        0x2::event::emit<CardRedeemedEvent>(v6);
    }

    entry fun buy_packs<T0>(arg0: &0x2::random::Random, arg1: &mut Store, arg2: 0x1::string::String, arg3: u64, arg4: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg5: bool, arg6: &mut 0x2::tx_context::TxContext) {
        verify_version(arg1);
        let (v0, v1) = 0x2::kiosk::new(arg6);
        let v2 = v1;
        let v3 = v0;
        let v4 = &mut v3;
        buy_packs_into_kiosk<T0>(arg0, arg1, arg2, arg3, arg4, v4, &v2, arg5, arg6);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v3);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::transfer_to_sender(0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::new(&mut v3, v2, arg6), arg6);
    }

    entry fun buy_packs_for_recipient<T0>(arg0: &0x2::clock::Clock, arg1: &0x2::random::Random, arg2: &mut Store, arg3: 0x1::string::String, arg4: u64, arg5: bool, arg6: address, arg7: u64, arg8: vector<u8>, arg9: &mut 0x2::tx_context::TxContext) {
        verify_version(arg2);
        verify_operator(arg2, arg9);
        assert!(0x2::clock::timestamp_ms(arg0) < arg7, 6);
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0x2::tx_context::sender(arg9);
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<address>(&v1));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<0x1::string::String>(&arg3));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg4));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<bool>(&arg5));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<address>(&arg6));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg7));
        assert!(0x2::ed25519::ed25519_verify(&arg8, &arg2.public_key, &v0), 4);
        let (v2, v3) = 0x2::kiosk::new(arg9);
        let v4 = v3;
        let v5 = v2;
        let v6 = 0x2::coin::zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg9);
        let v7 = &mut v5;
        buy_packs_into_kiosk<T0>(arg1, arg2, arg3, arg4, v6, v7, &v4, arg5, arg9);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::create_for(&mut v5, v4, arg6, arg9);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v5);
    }

    fun buy_packs_into_kiosk<T0>(arg0: &0x2::random::Random, arg1: &mut Store, arg2: 0x1::string::String, arg3: u64, arg4: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg5: &mut 0x2::kiosk::Kiosk, arg6: &0x2::kiosk::KioskOwnerCap, arg7: bool, arg8: &mut 0x2::tx_context::TxContext) {
        verify_version(arg1);
        assert!(0x2::table::contains<0x1::string::String, 0xa6d2695f4c006319e80bae63dc6ddce47c1c164db13101f59fe70aa7f57651b5::vault::Vault>(&arg1.vaults, arg2), 10);
        let v0 = 0x2::table::borrow_mut<0x1::string::String, 0xa6d2695f4c006319e80bae63dc6ddce47c1c164db13101f59fe70aa7f57651b5::vault::Vault>(&mut arg1.vaults, arg2);
        assert!(0x2::table::contains<0x1::string::String, Config>(&arg1.vault_configs, arg2), 11);
        let v1 = 0x2::table::borrow_mut<0x1::string::String, Config>(&mut arg1.vault_configs, arg2);
        assert!(v1.enabled, 7);
        assert!(arg3 <= 5, 14);
        assert!(arg3 <= v1.remaining_packs, 18);
        v1.remaining_packs = v1.remaining_packs - arg3;
        if (v1.remaining_packs == 0) {
            v1.enabled = false;
            let v2 = VaultDisabledEvent{vault_name: arg2};
            0x2::event::emit<VaultDisabledEvent>(v2);
        };
        if (0x2::tx_context::sender(arg8) != arg1.operator) {
            assert!(0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg4) == arg3 * v1.price, 3);
        };
        0x2::balance::join<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg1.balance, 0x2::coin::into_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg4));
        let v3 = 0x2::random::new_generator(arg0, arg8);
        let v4 = &mut v3;
        assert!(0xa6d2695f4c006319e80bae63dc6ddce47c1c164db13101f59fe70aa7f57651b5::vault::card_type(v0) == 0x1::type_name::with_defining_ids<T0>(), 13);
        let v5 = 0x1::vector::empty<0x2::object::ID>();
        while (arg3 > 0) {
            let v6 = 0;
            let v7 = 0x1::vector::empty<0x2::object::ID>();
            while (v6 < v1.pack_size) {
                let v8 = 0xa6d2695f4c006319e80bae63dc6ddce47c1c164db13101f59fe70aa7f57651b5::vault::remove_by_index<T0>(v0, 0x2::random::generate_u64_in_range(v4, 0, 0xa6d2695f4c006319e80bae63dc6ddce47c1c164db13101f59fe70aa7f57651b5::vault::length(v0) - 1));
                0x1::vector::push_back<0x2::object::ID>(&mut v5, 0x2::object::id<0xa6d2695f4c006319e80bae63dc6ddce47c1c164db13101f59fe70aa7f57651b5::card::Card<T0>>(&v8));
                0x1::vector::push_back<0x2::object::ID>(&mut v7, 0x2::object::id<0xa6d2695f4c006319e80bae63dc6ddce47c1c164db13101f59fe70aa7f57651b5::card::Card<T0>>(&v8));
                0x2::kiosk::lock<0xa6d2695f4c006319e80bae63dc6ddce47c1c164db13101f59fe70aa7f57651b5::card::Card<T0>>(arg5, arg6, 0x2::bag::borrow<0x1::type_name::TypeName, 0x2::transfer_policy::TransferPolicy<0xa6d2695f4c006319e80bae63dc6ddce47c1c164db13101f59fe70aa7f57651b5::card::Card<T0>>>(&arg1.transfer_policies, 0xa6d2695f4c006319e80bae63dc6ddce47c1c164db13101f59fe70aa7f57651b5::vault::card_type(v0)), v8);
                v6 = v6 + 1;
            };
            arg1.pack_index = arg1.pack_index + 1;
            arg3 = arg3 - 1;
            let v9 = PackBoughtEvent{
                card_ids   : v7,
                vault_name : arg2,
                pack_id    : arg1.pack_index + 1,
                price      : v1.price,
            };
            0x2::event::emit<PackBoughtEvent>(v9);
        };
        if (arg7) {
            deposit_cards_for_reveal<T0>(arg1, v5, arg5, arg6, arg8);
        };
    }

    entry fun buy_packs_with_personal_kiosk<T0>(arg0: &0x2::random::Random, arg1: &mut Store, arg2: 0x1::string::String, arg3: u64, arg4: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg5: &mut 0x2::kiosk::Kiosk, arg6: &0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg7: bool, arg8: &mut 0x2::tx_context::TxContext) {
        verify_version(arg1);
        buy_packs_into_kiosk<T0>(arg0, arg1, arg2, arg3, arg4, arg5, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow(arg6), arg7, arg8);
    }

    entry fun deposit_balance(arg0: &mut Store, arg1: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>) {
        verify_version(arg0);
        0x2::balance::join<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.balance, 0x2::coin::into_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg1));
    }

    public fun deposit_card_for_redeem<T0>(arg0: &Store, arg1: &mut RedeemCardsRequest, arg2: 0x2::object::ID, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x1::vector::index_of<0x2::object::ID>(&arg1.card_ids, &arg2);
        assert!(v0, 9);
        0x1::vector::swap_remove<0x2::object::ID>(&mut arg1.card_ids, v1);
        if (!0x2::kiosk_extension::is_installed<RipStationExt>(arg3)) {
            let v2 = RipStationExt{dummy_field: false};
            0x2::kiosk_extension::add<RipStationExt>(v2, arg3, arg4, 2, arg5);
        };
        let v3 = remove_card_from_kiosk<T0>(arg0, arg3, arg4, arg2, arg5);
        let v4 = RipStationExt{dummy_field: false};
        let v5 = RedeemTicket{
            card_id  : arg2,
            order_id : arg1.order_id,
        };
        0x2::bag::add<RedeemTicket, 0xa6d2695f4c006319e80bae63dc6ddce47c1c164db13101f59fe70aa7f57651b5::card::Card<T0>>(0x2::kiosk_extension::storage_mut<RipStationExt>(v4, arg3), v5, v3);
        let v6 = CardDelayedRedeemEvent{
            order_id : arg1.order_id,
            card_id  : arg2,
            kiosk_id : 0x2::object::id<0x2::kiosk::Kiosk>(arg3),
        };
        0x2::event::emit<CardDelayedRedeemEvent>(v6);
    }

    public fun deposit_cards_for_reveal<T0>(arg0: &Store, arg1: vector<0x2::object::ID>, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: &mut 0x2::tx_context::TxContext) {
        verify_version(arg0);
        if (!0x2::kiosk_extension::is_installed<RipStationExt>(arg2)) {
            let v0 = RipStationExt{dummy_field: false};
            0x2::kiosk_extension::add<RipStationExt>(v0, arg2, arg3, 2, arg4);
        };
        0x1::vector::reverse<0x2::object::ID>(&mut arg1);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x2::object::ID>(&arg1)) {
            let v2 = 0x1::vector::pop_back<0x2::object::ID>(&mut arg1);
            let v3 = remove_card_from_kiosk<T0>(arg0, arg2, arg3, v2, arg4);
            let v4 = RipStationExt{dummy_field: false};
            let v5 = RevealTicket{card_id: v2};
            0x2::bag::add<RevealTicket, 0xa6d2695f4c006319e80bae63dc6ddce47c1c164db13101f59fe70aa7f57651b5::card::Card<T0>>(0x2::kiosk_extension::storage_mut<RipStationExt>(v4, arg2), v5, v3);
            let v6 = CardDepositedForRevealEvent{
                card_id  : v2,
                kiosk_id : 0x2::object::id<0x2::kiosk::Kiosk>(arg2),
            };
            0x2::event::emit<CardDepositedForRevealEvent>(v6);
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<0x2::object::ID>(arg1);
    }

    public fun finish_redeem_cards(arg0: RedeemCardsRequest) {
        let RedeemCardsRequest {
            order_id : _,
            card_ids : v1,
        } = arg0;
        let v2 = v1;
        assert!(0x1::vector::length<0x2::object::ID>(&v2) == 0, 9);
    }

    fun init(arg0: RIP_STATION, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Store{
            id                   : 0x2::object::new(arg1),
            version              : 2,
            admin                : 0x2::tx_context::sender(arg1),
            operator             : 0x2::tx_context::sender(arg1),
            fee_receiver         : 0x2::tx_context::sender(arg1),
            royalty_receiver     : 0x2::tx_context::sender(arg1),
            public_key           : 0x1::vector::empty<u8>(),
            balance              : 0x2::balance::zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(),
            vaults               : 0x2::table::new<0x1::string::String, 0xa6d2695f4c006319e80bae63dc6ddce47c1c164db13101f59fe70aa7f57651b5::vault::Vault>(arg1),
            vault_configs        : 0x2::table::new<0x1::string::String, Config>(arg1),
            transfer_policies    : 0x2::bag::new(arg1),
            transfer_policy_caps : 0x2::bag::new(arg1),
            pack_index           : 0,
            orders               : 0x2::table::new<u128, bool>(arg1),
        };
        0x2::transfer::public_share_object<Store>(v0);
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<RIP_STATION>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    entry fun mint_cards<T0>(arg0: &0x2::clock::Clock, arg1: &mut Store, arg2: vector<0x1::string::String>, arg3: vector<vector<u8>>, arg4: 0x1::string::String, arg5: u64, arg6: vector<u8>, arg7: &mut 0x2::tx_context::TxContext) {
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
        assert!(0x2::table::contains<0x1::string::String, 0xa6d2695f4c006319e80bae63dc6ddce47c1c164db13101f59fe70aa7f57651b5::vault::Vault>(&arg1.vaults, arg4), 10);
        let v2 = 0x2::table::borrow_mut<0x1::string::String, 0xa6d2695f4c006319e80bae63dc6ddce47c1c164db13101f59fe70aa7f57651b5::vault::Vault>(&mut arg1.vaults, arg4);
        assert!(0x2::table::contains<0x1::string::String, Config>(&arg1.vault_configs, arg4), 11);
        let v3 = 0x2::table::borrow<0x1::string::String, Config>(&arg1.vault_configs, arg4);
        assert!(0xa6d2695f4c006319e80bae63dc6ddce47c1c164db13101f59fe70aa7f57651b5::vault::card_type(v2) == 0x1::type_name::with_defining_ids<T0>(), 13);
        let v4 = 0x1::vector::length<0x1::string::String>(&arg2);
        assert!(v4 == 0x1::vector::length<vector<u8>>(&arg3), 9);
        let v5 = 0;
        while (v5 < v4) {
            let v6 = 0xa6d2695f4c006319e80bae63dc6ddce47c1c164db13101f59fe70aa7f57651b5::card::mint_card<T0>(v3.placeholder_name, v3.placeholder_description, v3.placeholder_media_url, 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>(), *0x1::vector::borrow<vector<u8>>(&arg3, v5), false, arg7);
            0xa6d2695f4c006319e80bae63dc6ddce47c1c164db13101f59fe70aa7f57651b5::vault::add<T0>(v2, v6);
            let v7 = CardMintedEvent{
                id         : *0x1::vector::borrow<0x1::string::String>(&arg2, v5),
                card_id    : 0x2::object::id<0xa6d2695f4c006319e80bae63dc6ddce47c1c164db13101f59fe70aa7f57651b5::card::Card<T0>>(&v6),
                vault_name : arg4,
            };
            0x2::event::emit<CardMintedEvent>(v7);
            v5 = v5 + 1;
        };
    }

    public fun redeem_card<T0>(arg0: &Store, arg1: &mut RedeemCardsRequest, arg2: 0x2::object::ID, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x1::vector::index_of<0x2::object::ID>(&arg1.card_ids, &arg2);
        assert!(v0, 9);
        0x1::vector::swap_remove<0x2::object::ID>(&mut arg1.card_ids, v1);
        0xa6d2695f4c006319e80bae63dc6ddce47c1c164db13101f59fe70aa7f57651b5::card::burn_card<T0>(remove_card_from_kiosk<T0>(arg0, arg3, arg4, arg2, arg5), true);
        let v2 = CardRedeemedEvent{card_id: arg2};
        0x2::event::emit<CardRedeemedEvent>(v2);
    }

    fun remove_card_from_kiosk<T0>(arg0: &Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: &mut 0x2::tx_context::TxContext) : 0xa6d2695f4c006319e80bae63dc6ddce47c1c164db13101f59fe70aa7f57651b5::card::Card<T0> {
        let (v0, v1) = 0x2::kiosk::purchase_with_cap<0xa6d2695f4c006319e80bae63dc6ddce47c1c164db13101f59fe70aa7f57651b5::card::Card<T0>>(arg1, 0x2::kiosk::list_with_purchase_cap<0xa6d2695f4c006319e80bae63dc6ddce47c1c164db13101f59fe70aa7f57651b5::card::Card<T0>>(arg1, arg2, arg3, 0, arg4), 0x2::coin::zero<0x2::sui::SUI>(arg4));
        let (_, _, _) = 0x2::transfer_policy::confirm_request<0xa6d2695f4c006319e80bae63dc6ddce47c1c164db13101f59fe70aa7f57651b5::card::Card<T0>>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::transfer_policy::TransferPolicy<0xa6d2695f4c006319e80bae63dc6ddce47c1c164db13101f59fe70aa7f57651b5::card::Card<T0>>>(&arg0.transfer_policies, 0x1::type_name::with_defining_ids<T0>()), v1);
        v0
    }

    entry fun reveal_and_return<T0>(arg0: &0x2::clock::Clock, arg1: &Store, arg2: 0x2::object::ID, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: vector<0x1::string::String>, arg7: vector<0x1::string::String>, arg8: vector<u8>, arg9: u64, arg10: vector<u8>, arg11: &mut 0x2::kiosk::Kiosk, arg12: &0x2::tx_context::TxContext) {
        verify_version(arg1);
        verify_operator(arg1, arg12);
        assert!(0x2::clock::timestamp_ms(arg0) < arg9, 6);
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0x2::tx_context::sender(arg12);
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
        assert!(0x2::kiosk_extension::is_installed<RipStationExt>(arg11), 15);
        let v2 = RipStationExt{dummy_field: false};
        let v3 = 0x2::kiosk_extension::storage_mut<RipStationExt>(v2, arg11);
        let v4 = RevealTicket{card_id: arg2};
        assert!(0x2::bag::contains<RevealTicket>(v3, v4), 16);
        let v5 = 0x2::bag::remove<RevealTicket, 0xa6d2695f4c006319e80bae63dc6ddce47c1c164db13101f59fe70aa7f57651b5::card::Card<T0>>(v3, v4);
        0xa6d2695f4c006319e80bae63dc6ddce47c1c164db13101f59fe70aa7f57651b5::card::reveal_card<T0>(&mut v5, arg3, arg4, arg5, 0x2::vec_map::from_keys_values<0x1::string::String, 0x1::string::String>(arg6, arg7), arg8);
        let v6 = RipStationExt{dummy_field: false};
        0x2::kiosk_extension::lock<RipStationExt, 0xa6d2695f4c006319e80bae63dc6ddce47c1c164db13101f59fe70aa7f57651b5::card::Card<T0>>(v6, arg11, v5, 0x2::bag::borrow<0x1::type_name::TypeName, 0x2::transfer_policy::TransferPolicy<0xa6d2695f4c006319e80bae63dc6ddce47c1c164db13101f59fe70aa7f57651b5::card::Card<T0>>>(&arg1.transfer_policies, 0x1::type_name::with_defining_ids<T0>()));
        let v7 = CardRevealedEvent{card_id: arg2};
        0x2::event::emit<CardRevealedEvent>(v7);
    }

    public fun sell_card<T0>(arg0: &0x2::clock::Clock, arg1: &mut Store, arg2: u128, arg3: 0x2::object::ID, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: vector<u8>, arg9: &mut 0x2::kiosk::Kiosk, arg10: &0x2::kiosk::KioskOwnerCap, arg11: &mut 0x2::tx_context::TxContext) {
        verify_version(arg1);
        assert!(0x2::clock::timestamp_ms(arg0) < arg7, 6);
        assert!(!0x2::table::contains<u128, bool>(&arg1.orders, arg2), 5);
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0x2::tx_context::sender(arg11);
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<address>(&v1));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u128>(&arg2));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<0x2::object::ID>(&arg3));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg4));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg5));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg6));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg7));
        assert!(0x2::ed25519::ed25519_verify(&arg8, &arg1.public_key, &v0), 4);
        assert!(arg4 + arg5 + arg6 <= 0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg1.balance), 3);
        0x2::pay::keep<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x2::coin::from_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x2::balance::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg1.balance, arg4), arg11), arg11);
        0x2::balance::send_funds<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x2::balance::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg1.balance, arg5), arg1.fee_receiver);
        0x2::balance::send_funds<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x2::balance::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg1.balance, arg6), arg1.royalty_receiver);
        0xa6d2695f4c006319e80bae63dc6ddce47c1c164db13101f59fe70aa7f57651b5::card::burn_card<T0>(remove_card_from_kiosk<T0>(arg1, arg9, arg10, arg3, arg11), true);
        let v2 = CardSoldEvent{
            card_id  : arg3,
            order_id : arg2,
            price    : arg4,
            fee      : arg5,
        };
        0x2::event::emit<CardSoldEvent>(v2);
        0x2::table::add<u128, bool>(&mut arg1.orders, arg2, true);
    }

    entry fun set_admin(arg0: &mut Store, arg1: address, arg2: &0x2::tx_context::TxContext) {
        verify_version(arg0);
        verify_admin(arg0, arg2);
        arg0.admin = arg1;
    }

    entry fun set_fee_receiver(arg0: &mut Store, arg1: address, arg2: &0x2::tx_context::TxContext) {
        verify_version(arg0);
        verify_admin(arg0, arg2);
        arg0.fee_receiver = arg1;
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

    entry fun set_royalty_receiver(arg0: &mut Store, arg1: address, arg2: &0x2::tx_context::TxContext) {
        verify_version(arg0);
        verify_admin(arg0, arg2);
        arg0.royalty_receiver = arg1;
    }

    entry fun set_vault_config<T0>(arg0: &mut Store, arg1: 0x1::string::String, arg2: bool, arg3: u64, arg4: u64, arg5: u64, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: &mut 0x2::tx_context::TxContext) {
        verify_version(arg0);
        verify_admin(arg0, arg9);
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&arg0.transfer_policies, 0x1::type_name::with_defining_ids<T0>()), 12);
        if (arg2) {
            assert!(arg5 > 0, 19);
        };
        if (!0x2::table::contains<0x1::string::String, 0xa6d2695f4c006319e80bae63dc6ddce47c1c164db13101f59fe70aa7f57651b5::vault::Vault>(&arg0.vaults, arg1)) {
            0x2::table::add<0x1::string::String, 0xa6d2695f4c006319e80bae63dc6ddce47c1c164db13101f59fe70aa7f57651b5::vault::Vault>(&mut arg0.vaults, arg1, 0xa6d2695f4c006319e80bae63dc6ddce47c1c164db13101f59fe70aa7f57651b5::vault::new<T0>(arg9));
        };
        if (0x2::table::contains<0x1::string::String, Config>(&arg0.vault_configs, arg1)) {
            0x2::table::remove<0x1::string::String, Config>(&mut arg0.vault_configs, arg1);
        };
        let v0 = Config{
            enabled                 : arg2,
            price                   : arg3,
            pack_size               : arg4,
            remaining_packs         : arg5,
            placeholder_name        : arg6,
            placeholder_description : arg7,
            placeholder_media_url   : arg8,
        };
        if (!v0.enabled) {
            let v1 = VaultDisabledEvent{vault_name: arg1};
            0x2::event::emit<VaultDisabledEvent>(v1);
        };
        0x2::table::add<0x1::string::String, Config>(&mut arg0.vault_configs, arg1, v0);
    }

    entry fun set_vault_enabled(arg0: &mut Store, arg1: 0x1::string::String, arg2: bool, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        verify_version(arg0);
        verify_operator(arg0, arg4);
        assert!(0x2::table::contains<0x1::string::String, Config>(&arg0.vault_configs, arg1), 11);
        if (arg2) {
            assert!(arg3 > 0, 19);
        };
        let v0 = 0x2::table::borrow_mut<0x1::string::String, Config>(&mut arg0.vault_configs, arg1);
        if (v0.enabled && !arg2) {
            let v1 = VaultDisabledEvent{vault_name: arg1};
            0x2::event::emit<VaultDisabledEvent>(v1);
        };
        v0.enabled = arg2;
        v0.remaining_packs = arg3;
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
        assert!(arg0.version <= 2, 1);
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

    // decompiled from Move bytecode v7
}

