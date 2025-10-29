module 0xe123841a78c44d48c108f340621a2bd3211069de71ebec465d10d50e34caf41c::cosmetics {
    struct CosmeticApplied has copy, drop {
        doonies_token_id: u64,
        cosmetic_id: 0x2::object::ID,
        trait_type: 0x1::string::String,
        trait_value: 0x1::string::String,
        applier: address,
    }

    struct CosmeticRemoved has copy, drop {
        doonies_token_id: u64,
        cosmetic_id: 0x2::object::ID,
        trait_type: 0x1::string::String,
        remover: address,
    }

    struct GodNFTReminted has copy, drop {
        old_token_id: u64,
        new_token_id: u64,
        new_nft_id: 0x2::object::ID,
        god_token_id: u64,
        reminter: address,
    }

    struct CosmeticTemplateAdded has copy, drop {
        template_id: 0x2::object::ID,
        name: 0x1::string::String,
        trait_type: 0x1::string::String,
        points_price: u64,
        sui_price: 0x1::option::Option<u64>,
        available: bool,
        stock: 0x1::option::Option<u64>,
    }

    struct CosmeticTemplateUpdated has copy, drop {
        template_id: 0x2::object::ID,
        updated_fields: vector<0x1::string::String>,
    }

    struct CosmeticTemplateAvailabilityChanged has copy, drop {
        template_id: 0x2::object::ID,
        available: bool,
    }

    struct CosmeticPurchased has copy, drop {
        template_id: 0x2::object::ID,
        instance_id: 0x2::object::ID,
        buyer: address,
        payment_type: 0x1::string::String,
        amount: u64,
    }

    struct VaultPrizeRolled has copy, drop {
        sender: address,
        prize_type: 0x1::string::String,
        prize_id: 0x2::object::ID,
    }

    struct COSMETICS has drop {
        dummy_field: bool,
    }

    struct CosmeticAdminCap has key {
        id: 0x2::object::UID,
    }

    struct CosmeticCollection has key {
        id: 0x2::object::UID,
        admin_address: address,
        total_templates_created: u64,
        cosmetics_by_type: 0x2::table::Table<0x1::string::String, u64>,
        cosmetic_catalog: 0x2::table::Table<0x2::object::ID, CosmeticTemplate>,
        catalog_index: vector<0x2::object::ID>,
        available_index: vector<0x2::object::ID>,
        trait_categories: vector<0x1::string::String>,
        user_points: 0x2::table::Table<address, u64>,
    }

    struct CosmeticTemplate has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url_bytes: vector<u8>,
        trait_type: 0x1::string::String,
        trait_value: 0x1::string::String,
        points_price: u64,
        sui_price: 0x1::option::Option<u64>,
        available: bool,
        stock: 0x1::option::Option<u64>,
        cosmetic_seq: u64,
    }

    struct CosmeticNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x2::url::Url,
        trait_type: 0x1::string::String,
        trait_value: 0x1::string::String,
        template_id: 0x2::object::ID,
    }

    struct FreePassNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x2::url::Url,
    }

    struct RewardVault has store, key {
        id: 0x2::object::UID,
        token_prize_ids: vector<0x2::object::ID>,
        nft_direct_prize_ids: vector<0x2::object::ID>,
        nft_kiosk_prize_ids: vector<0x2::object::ID>,
        bones_sale_balance: 0x2::coin::Coin<0xe123841a78c44d48c108f340621a2bd3211069de71ebec465d10d50e34caf41c::bones::BONES>,
        bones_sale_unit: u64,
        bones_sale_price_sui: u64,
        god_prize_bps: u64,
        token_prize_bps: u64,
        nft_prize_bps: u64,
        free_pass_bps: u64,
        free_pass_price_sui: u64,
        free_pass_max_supply: u64,
        free_pass_total_sold: u64,
        paused: bool,
    }

    struct CosmeticOverrides has store, key {
        id: 0x2::object::UID,
        doonies_token_id: u64,
        overrides: 0x2::table::Table<0x1::string::String, 0x2::object::ID>,
        applied_cosmetics: vector<0x2::object::ID>,
    }

    struct PendingRewards has store, key {
        id: 0x2::object::UID,
        token_prize_ids: vector<0x2::object::ID>,
        nft_direct_prize_ids: vector<0x2::object::ID>,
        nft_kiosk_prize_ids: vector<0x2::object::ID>,
    }

    struct GodNFTList has key {
        id: 0x2::object::UID,
        god_nfts: 0x2::table::Table<u64, 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>,
        available_god_ids: vector<u64>,
    }

    public fun add_god_nft(arg0: &CosmeticAdminCap, arg1: &CosmeticCollection, arg2: &mut GodNFTList, arg3: u64, arg4: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg5) == arg1.admin_address, 1);
        if (0x2::table::contains<u64, 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>(&arg2.god_nfts, arg3)) {
            *0x2::table::borrow_mut<u64, 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>(&mut arg2.god_nfts, arg3) = arg4;
        } else {
            0x2::table::add<u64, 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>(&mut arg2.god_nfts, arg3, arg4);
        };
        if (!0x1::vector::contains<u64>(&arg2.available_god_ids, &arg3)) {
            0x1::vector::push_back<u64>(&mut arg2.available_god_ids, arg3);
        };
    }

    fun add_to_available_index(arg0: &mut CosmeticCollection, arg1: 0x2::object::ID) {
        if (!0x1::vector::contains<0x2::object::ID>(&arg0.available_index, &arg1)) {
            0x1::vector::push_back<0x2::object::ID>(&mut arg0.available_index, arg1);
        };
    }

    public entry fun admin_add_template(arg0: &CosmeticAdminCap, arg1: &mut CosmeticCollection, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: vector<u8>, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: u64, arg8: 0x1::option::Option<u64>, arg9: bool, arg10: 0x1::option::Option<u64>, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg11) == arg1.admin_address, 1);
        assert!(is_valid_trait_type(arg5), 3);
        let v0 = create_cosmetic_template(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
        let v1 = 0x2::object::id<CosmeticTemplate>(&v0);
        0x2::table::add<0x2::object::ID, CosmeticTemplate>(&mut arg1.cosmetic_catalog, v1, v0);
        0x1::vector::push_back<0x2::object::ID>(&mut arg1.catalog_index, v1);
        if (arg9) {
            add_to_available_index(arg1, v1);
        };
        let v2 = CosmeticTemplateAdded{
            template_id  : v1,
            name         : arg2,
            trait_type   : arg5,
            points_price : arg7,
            sui_price    : arg8,
            available    : arg9,
            stock        : arg10,
        };
        0x2::event::emit<CosmeticTemplateAdded>(v2);
    }

    public entry fun admin_deposit_nft_direct<T0: store + key>(arg0: &CosmeticAdminCap, arg1: &CosmeticCollection, arg2: &mut RewardVault, arg3: T0, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg1.admin_address, 1);
        let v0 = 0x2::object::id<T0>(&arg3);
        0x2::dynamic_object_field::add<0x2::object::ID, T0>(&mut arg2.id, v0, arg3);
        0x1::vector::push_back<0x2::object::ID>(&mut arg2.nft_direct_prize_ids, v0);
    }

    public entry fun admin_deposit_token<T0>(arg0: &CosmeticAdminCap, arg1: &CosmeticCollection, arg2: &mut RewardVault, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg1.admin_address, 1);
        let v0 = 0x2::object::id<0x2::coin::Coin<T0>>(&arg3);
        0x2::dynamic_object_field::add<0x2::object::ID, 0x2::coin::Coin<T0>>(&mut arg2.id, v0, arg3);
        0x1::vector::push_back<0x2::object::ID>(&mut arg2.token_prize_ids, v0);
    }

    public entry fun admin_fund_bones(arg0: &CosmeticAdminCap, arg1: &CosmeticCollection, arg2: &mut RewardVault, arg3: 0x2::coin::Coin<0xe123841a78c44d48c108f340621a2bd3211069de71ebec465d10d50e34caf41c::bones::BONES>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg1.admin_address, 1);
        0x2::coin::join<0xe123841a78c44d48c108f340621a2bd3211069de71ebec465d10d50e34caf41c::bones::BONES>(&mut arg2.bones_sale_balance, arg3);
    }

    public entry fun admin_fund_sui(arg0: &CosmeticAdminCap, arg1: &CosmeticCollection, arg2: &mut RewardVault, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg1.admin_address, 1);
        let v0 = 0x2::object::id<0x2::coin::Coin<0x2::sui::SUI>>(&arg3);
        0x2::dynamic_object_field::add<0x2::object::ID, 0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2.id, v0, arg3);
        0x1::vector::push_back<0x2::object::ID>(&mut arg2.token_prize_ids, v0);
    }

    public entry fun admin_grant_points(arg0: &CosmeticAdminCap, arg1: &mut CosmeticCollection, arg2: vector<address>, arg3: vector<u64>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg1.admin_address, 1);
        let v0 = 0x1::vector::length<address>(&arg2);
        assert!(v0 == 0x1::vector::length<u64>(&arg3), 9);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = *0x1::vector::borrow<address>(&arg2, v1);
            if (0x2::table::contains<address, u64>(&arg1.user_points, v2)) {
                let v3 = 0x2::table::borrow_mut<address, u64>(&mut arg1.user_points, v2);
                *v3 = *v3 + *0x1::vector::borrow<u64>(&arg3, v1);
            } else {
                0x2::table::add<address, u64>(&mut arg1.user_points, v2, *0x1::vector::borrow<u64>(&arg3, v1));
            };
            v1 = v1 + 1;
        };
    }

    public entry fun admin_list_kiosk_prize<T0: store + key>(arg0: &CosmeticAdminCap, arg1: &CosmeticCollection, arg2: &mut RewardVault, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: 0x2::object::ID, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg6) == arg1.admin_address, 1);
        if (0x2::kiosk::is_listed(arg3, arg5)) {
            0x2::kiosk::delist<T0>(arg3, arg4, arg5);
        };
        0x2::dynamic_object_field::add<0x2::object::ID, 0x2::kiosk::PurchaseCap<T0>>(&mut arg2.id, arg5, 0x2::kiosk::list_with_purchase_cap<T0>(arg3, arg4, arg5, 0, arg6));
        0x1::vector::push_back<0x2::object::ID>(&mut arg2.nft_kiosk_prize_ids, arg5);
    }

    public entry fun admin_remove_template(arg0: &CosmeticAdminCap, arg1: &mut CosmeticCollection, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg1.admin_address, 1);
        assert!(0x2::table::contains<0x2::object::ID, CosmeticTemplate>(&arg1.cosmetic_catalog, arg2), 10);
        let CosmeticTemplate {
            id              : v0,
            name            : _,
            description     : _,
            image_url_bytes : _,
            trait_type      : _,
            trait_value     : _,
            points_price    : _,
            sui_price       : _,
            available       : _,
            stock           : _,
            cosmetic_seq    : _,
        } = 0x2::table::remove<0x2::object::ID, CosmeticTemplate>(&mut arg1.cosmetic_catalog, arg2);
        0x2::object::delete(v0);
        let (v11, v12) = 0x1::vector::index_of<0x2::object::ID>(&arg1.catalog_index, &arg2);
        if (v11) {
            0x1::vector::remove<0x2::object::ID>(&mut arg1.catalog_index, v12);
        };
        remove_from_available_index(arg1, arg2);
    }

    public entry fun admin_set_availability(arg0: &CosmeticAdminCap, arg1: &mut CosmeticCollection, arg2: 0x2::object::ID, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg1.admin_address, 1);
        assert!(0x2::table::contains<0x2::object::ID, CosmeticTemplate>(&arg1.cosmetic_catalog, arg2), 10);
        0x2::table::borrow_mut<0x2::object::ID, CosmeticTemplate>(&mut arg1.cosmetic_catalog, arg2).available = arg3;
        update_available_index(arg1, arg2, arg3);
        let v0 = CosmeticTemplateAvailabilityChanged{
            template_id : arg2,
            available   : arg3,
        };
        0x2::event::emit<CosmeticTemplateAvailabilityChanged>(v0);
    }

    public entry fun admin_set_bones_sale(arg0: &CosmeticAdminCap, arg1: &CosmeticCollection, arg2: &mut RewardVault, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg5) == arg1.admin_address, 1);
        arg2.bones_sale_unit = arg3;
        arg2.bones_sale_price_sui = arg4;
    }

    public entry fun admin_set_doonies_prize_pool(arg0: &CosmeticAdminCap, arg1: &CosmeticCollection, arg2: &mut RewardVault, arg3: vector<0x2::object::ID>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg1.admin_address, 1);
        arg2.nft_kiosk_prize_ids = arg3;
    }

    public entry fun admin_set_free_pass_sale(arg0: &CosmeticAdminCap, arg1: &CosmeticCollection, arg2: &mut RewardVault, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg5) == arg1.admin_address, 1);
        arg2.free_pass_price_sui = arg3;
        arg2.free_pass_max_supply = arg4;
    }

    public entry fun admin_set_loot_templates(arg0: &CosmeticAdminCap, arg1: &CosmeticCollection, arg2: &mut RewardVault, arg3: vector<0x2::object::ID>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg1.admin_address, 1);
        arg2.nft_direct_prize_ids = arg3;
    }

    public entry fun admin_set_prize_bps(arg0: &CosmeticAdminCap, arg1: &CosmeticCollection, arg2: &mut RewardVault, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg7) == arg1.admin_address, 1);
        let v0 = if (arg3 <= 10000) {
            if (arg4 <= 10000) {
                if (arg5 <= 10000) {
                    arg6 <= 10000
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 9);
        arg2.god_prize_bps = arg3;
        arg2.token_prize_bps = arg4;
        arg2.nft_prize_bps = arg5;
        arg2.free_pass_bps = arg6;
    }

    public entry fun admin_set_prize_pools(arg0: &CosmeticAdminCap, arg1: &CosmeticCollection, arg2: &mut RewardVault, arg3: vector<0x2::object::ID>, arg4: vector<0x2::object::ID>, arg5: vector<0x2::object::ID>, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg6) == arg1.admin_address, 1);
        arg2.token_prize_ids = arg3;
        arg2.nft_direct_prize_ids = arg4;
        arg2.nft_kiosk_prize_ids = arg5;
    }

    public entry fun admin_update_template(arg0: &CosmeticAdminCap, arg1: &mut CosmeticCollection, arg2: 0x2::object::ID, arg3: 0x1::option::Option<0x1::string::String>, arg4: 0x1::option::Option<0x1::string::String>, arg5: 0x1::option::Option<vector<u8>>, arg6: 0x1::option::Option<0x1::string::String>, arg7: 0x1::option::Option<0x1::string::String>, arg8: 0x1::option::Option<u64>, arg9: 0x1::option::Option<0x1::option::Option<u64>>, arg10: 0x1::option::Option<0x1::option::Option<u64>>, arg11: 0x1::option::Option<bool>, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg12) == arg1.admin_address, 1);
        assert!(0x2::table::contains<0x2::object::ID, CosmeticTemplate>(&arg1.cosmetic_catalog, arg2), 10);
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, CosmeticTemplate>(&mut arg1.cosmetic_catalog, arg2);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        if (0x1::option::is_some<0x1::string::String>(&arg3)) {
            v0.name = 0x1::option::extract<0x1::string::String>(&mut arg3);
            0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::string::utf8(b"name"));
        };
        if (0x1::option::is_some<0x1::string::String>(&arg4)) {
            v0.description = 0x1::option::extract<0x1::string::String>(&mut arg4);
            0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::string::utf8(b"description"));
        };
        if (0x1::option::is_some<vector<u8>>(&arg5)) {
            v0.image_url_bytes = 0x1::option::extract<vector<u8>>(&mut arg5);
            0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::string::utf8(b"image_url"));
        };
        if (0x1::option::is_some<0x1::string::String>(&arg6)) {
            let v2 = 0x1::option::extract<0x1::string::String>(&mut arg6);
            assert!(is_valid_trait_type(v2), 3);
            v0.trait_type = v2;
            0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::string::utf8(b"trait_type"));
        };
        if (0x1::option::is_some<0x1::string::String>(&arg7)) {
            v0.trait_value = 0x1::option::extract<0x1::string::String>(&mut arg7);
            0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::string::utf8(b"trait_value"));
        };
        if (0x1::option::is_some<u64>(&arg8)) {
            v0.points_price = 0x1::option::extract<u64>(&mut arg8);
            0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::string::utf8(b"points_price"));
        };
        if (0x1::option::is_some<0x1::option::Option<u64>>(&arg9)) {
            v0.sui_price = 0x1::option::extract<0x1::option::Option<u64>>(&mut arg9);
            0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::string::utf8(b"sui_price"));
        };
        if (0x1::option::is_some<0x1::option::Option<u64>>(&arg10)) {
            v0.stock = 0x1::option::extract<0x1::option::Option<u64>>(&mut arg10);
            0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::string::utf8(b"stock"));
        };
        if (0x1::option::is_some<bool>(&arg11)) {
            let v3 = 0x1::option::extract<bool>(&mut arg11);
            v0.available = v3;
            update_available_index(arg1, arg2, v3);
            0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::string::utf8(b"available"));
        };
        let v4 = CosmeticTemplateUpdated{
            template_id    : arg2,
            updated_fields : v1,
        };
        0x2::event::emit<CosmeticTemplateUpdated>(v4);
    }

    public entry fun admin_withdraw_kiosk_prize<T0: store + key>(arg0: &CosmeticAdminCap, arg1: &CosmeticCollection, arg2: &mut RewardVault, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: 0x2::object::ID, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg6) == arg1.admin_address, 1);
        let (v0, v1) = 0x1::vector::index_of<0x2::object::ID>(&arg2.nft_kiosk_prize_ids, &arg5);
        assert!(v0, 10);
        0x1::vector::remove<0x2::object::ID>(&mut arg2.nft_kiosk_prize_ids, v1);
        if (0x2::kiosk::is_listed(arg3, arg5)) {
            0x2::kiosk::delist<T0>(arg3, arg4, arg5);
        };
        0x2::kiosk::return_purchase_cap<T0>(arg3, 0x2::dynamic_object_field::remove<0x2::object::ID, 0x2::kiosk::PurchaseCap<T0>>(&mut arg2.id, arg5));
    }

    public entry fun admin_withdraw_nft_direct<T0: store + key>(arg0: &CosmeticAdminCap, arg1: &CosmeticCollection, arg2: &mut RewardVault, arg3: 0x2::object::ID, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg1.admin_address, 1);
        let (v0, v1) = 0x1::vector::index_of<0x2::object::ID>(&arg2.nft_direct_prize_ids, &arg3);
        assert!(v0, 10);
        0x1::vector::remove<0x2::object::ID>(&mut arg2.nft_direct_prize_ids, v1);
        0x2::transfer::public_transfer<T0>(0x2::dynamic_object_field::remove<0x2::object::ID, T0>(&mut arg2.id, arg3), 0x2::tx_context::sender(arg4));
    }

    public entry fun admin_withdraw_token<T0>(arg0: &CosmeticAdminCap, arg1: &CosmeticCollection, arg2: &mut RewardVault, arg3: 0x2::object::ID, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg1.admin_address, 1);
        let (v0, v1) = 0x1::vector::index_of<0x2::object::ID>(&arg2.token_prize_ids, &arg3);
        assert!(v0, 10);
        0x1::vector::remove<0x2::object::ID>(&mut arg2.token_prize_ids, v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::dynamic_object_field::remove<0x2::object::ID, 0x2::coin::Coin<T0>>(&mut arg2.id, arg3), 0x2::tx_context::sender(arg4));
    }

    public entry fun apply_cosmetic(arg0: &mut CosmeticCollection, arg1: CosmeticNFT, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::tx_context::sender(arg3) == arg0.admin_address, 1);
        let v1 = if (0x2::dynamic_object_field::exists_<u64>(&arg0.id, arg2)) {
            0x2::dynamic_object_field::borrow_mut<u64, CosmeticOverrides>(&mut arg0.id, arg2)
        } else {
            0x2::dynamic_object_field::add<u64, CosmeticOverrides>(&mut arg0.id, arg2, get_or_create_overrides(arg2, arg3));
            0x2::dynamic_object_field::borrow_mut<u64, CosmeticOverrides>(&mut arg0.id, arg2)
        };
        let v2 = 0x2::object::id<CosmeticNFT>(&arg1);
        let v3 = arg1.trait_type;
        if (0x2::table::contains<0x1::string::String, 0x2::object::ID>(&v1.overrides, v3)) {
            let v4 = *0x2::table::borrow<0x1::string::String, 0x2::object::ID>(&v1.overrides, v3);
            0x2::table::remove<0x1::string::String, 0x2::object::ID>(&mut v1.overrides, v3);
            let (v5, v6) = 0x1::vector::index_of<0x2::object::ID>(&v1.applied_cosmetics, &v4);
            if (v5) {
                0x1::vector::remove<0x2::object::ID>(&mut v1.applied_cosmetics, v6);
            };
            0x2::transfer::public_transfer<CosmeticNFT>(0x2::dynamic_object_field::remove<0x2::object::ID, CosmeticNFT>(&mut v1.id, v4), v0);
        };
        0x2::table::add<0x1::string::String, 0x2::object::ID>(&mut v1.overrides, v3, v2);
        0x1::vector::push_back<0x2::object::ID>(&mut v1.applied_cosmetics, v2);
        0x2::dynamic_object_field::add<0x2::object::ID, CosmeticNFT>(&mut v1.id, v2, arg1);
        let v7 = CosmeticApplied{
            doonies_token_id : arg2,
            cosmetic_id      : v2,
            trait_type       : v3,
            trait_value      : arg1.trait_value,
            applier          : v0,
        };
        0x2::event::emit<CosmeticApplied>(v7);
    }

    public entry fun buy_bones(arg0: &mut RewardVault, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.bones_sale_unit > 0 && arg0.bones_sale_price_sui > 0, 9);
        assert!(arg2 > 0 && arg2 <= 10, 9);
        let v0 = arg0.bones_sale_price_sui * arg2;
        let v1 = arg0.bones_sale_unit * arg2;
        assert!(0x2::coin::value<0x2::sui::SUI>(arg1) >= v0, 12);
        assert!(0x2::coin::value<0xe123841a78c44d48c108f340621a2bd3211069de71ebec465d10d50e34caf41c::bones::BONES>(&arg0.bones_sale_balance) >= v1, 10);
        let v2 = 0x2::coin::split<0x2::sui::SUI>(arg1, v0, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xe123841a78c44d48c108f340621a2bd3211069de71ebec465d10d50e34caf41c::bones::BONES>>(0x2::coin::split<0xe123841a78c44d48c108f340621a2bd3211069de71ebec465d10d50e34caf41c::bones::BONES>(&mut arg0.bones_sale_balance, v1, arg3), 0x2::tx_context::sender(arg3));
        let v3 = 0x2::object::id<0x2::coin::Coin<0x2::sui::SUI>>(&v2);
        0x2::dynamic_object_field::add<0x2::object::ID, 0x2::coin::Coin<0x2::sui::SUI>>(&mut arg0.id, v3, v2);
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.token_prize_ids, v3);
    }

    public entry fun buy_free_pass(arg0: &mut RewardVault, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.free_pass_price_sui > 0, 9);
        assert!(arg2 > 0 && arg2 <= 10, 9);
        if (arg0.free_pass_max_supply > 0) {
            assert!(arg0.free_pass_total_sold + arg2 <= arg0.free_pass_max_supply, 9);
        };
        let v0 = arg0.free_pass_price_sui * arg2;
        assert!(0x2::coin::value<0x2::sui::SUI>(arg1) >= v0, 12);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg1, v0, arg3), @0xa3585953487cf72b94233df0895ae7f6bb05c873772f6ad956dac9cafb946d5d);
        let v1 = 0;
        while (v1 < arg2) {
            let v2 = FreePassNFT{
                id          : 0x2::object::new(arg3),
                name        : 0x1::string::utf8(b"Doonies Free Pass"),
                description : 0x1::string::utf8(b"One free vault roll"),
                image_url   : 0x2::url::new_unsafe_from_bytes(b"https://walrus.doonies.net/freepass.png"),
            };
            0x2::transfer::public_transfer<FreePassNFT>(v2, 0x2::tx_context::sender(arg3));
            arg0.free_pass_total_sold = arg0.free_pass_total_sold + 1;
            v1 = v1 + 1;
        };
    }

    public entry fun claim_nft_direct<T0: store + key>(arg0: &mut CosmeticCollection, arg1: &mut RewardVault, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = get_or_create_pending(arg0, v0, arg3);
        let (v2, v3) = 0x1::vector::index_of<0x2::object::ID>(&v1.nft_direct_prize_ids, &arg2);
        assert!(v2, 10);
        0x1::vector::remove<0x2::object::ID>(&mut v1.nft_direct_prize_ids, v3);
        0x2::transfer::public_transfer<T0>(0x2::dynamic_object_field::remove<0x2::object::ID, T0>(&mut arg1.id, arg2), v0);
    }

    public entry fun claim_nft_kiosk<T0: store + key>(arg0: &mut CosmeticCollection, arg1: &mut RewardVault, arg2: &mut 0x2::kiosk::Kiosk, arg3: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg4: 0x2::object::ID, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = get_or_create_pending(arg0, v0, arg5);
        let (v2, v3) = 0x1::vector::index_of<0x2::object::ID>(&v1.nft_kiosk_prize_ids, &arg4);
        assert!(v2, 10);
        0x1::vector::remove<0x2::object::ID>(&mut v1.nft_kiosk_prize_ids, v3);
        let (v4, v5) = 0x2::kiosk::purchase_with_cap<T0>(arg2, 0x2::dynamic_object_field::remove<0x2::object::ID, 0x2::kiosk::PurchaseCap<T0>>(&mut arg1.id, arg4), 0x2::coin::zero<0x2::sui::SUI>(arg5));
        let v6 = v5;
        let (v7, v8) = 0x2::kiosk::new(arg5);
        let v9 = v8;
        let v10 = v7;
        0x2::kiosk::lock<T0>(&mut v10, &v9, arg3, v4);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::prove<T0>(&mut v6, &v10);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::fee_amount<T0>(arg3, 0x2::transfer_policy::paid<T0>(&v6));
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::pay<T0>(arg3, &mut v6, 0x2::coin::zero<0x2::sui::SUI>(arg5));
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg3, v6);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v10);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v9, v0);
    }

    public entry fun claim_nft_kiosk_with_cap<T0: store + key>(arg0: &mut CosmeticCollection, arg1: &mut RewardVault, arg2: &mut 0x2::kiosk::Kiosk, arg3: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg4: 0x2::object::ID, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = get_or_create_pending(arg0, v0, arg5);
        let (v2, v3) = 0x1::vector::index_of<0x2::object::ID>(&v1.nft_kiosk_prize_ids, &arg4);
        assert!(v2, 10);
        0x1::vector::remove<0x2::object::ID>(&mut v1.nft_kiosk_prize_ids, v3);
        let (v4, v5) = 0x2::kiosk::purchase_with_cap<T0>(arg2, 0x2::dynamic_object_field::remove<0x2::object::ID, 0x2::kiosk::PurchaseCap<T0>>(&mut arg1.id, arg4), 0x2::coin::zero<0x2::sui::SUI>(arg5));
        let v6 = v5;
        let (v7, v8) = 0x2::kiosk::new(arg5);
        let v9 = v8;
        let v10 = v7;
        0x2::kiosk::lock<T0>(&mut v10, &v9, arg3, v4);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::prove<T0>(&mut v6, &v10);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::fee_amount<T0>(arg3, 0x2::transfer_policy::paid<T0>(&v6));
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::pay<T0>(arg3, &mut v6, 0x2::coin::zero<0x2::sui::SUI>(arg5));
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg3, v6);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v10);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v9, v0);
    }

    public entry fun claim_token<T0: store>(arg0: &mut CosmeticCollection, arg1: &mut RewardVault, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = get_or_create_pending(arg0, v0, arg3);
        let (v2, v3) = 0x1::vector::index_of<0x2::object::ID>(&v1.token_prize_ids, &arg2);
        assert!(v2, 10);
        0x1::vector::remove<0x2::object::ID>(&mut v1.token_prize_ids, v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::dynamic_object_field::remove<0x2::object::ID, 0x2::coin::Coin<T0>>(&mut arg1.id, arg2), v0);
    }

    fun create_cosmetic_instance(arg0: &CosmeticTemplate, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) : CosmeticNFT {
        CosmeticNFT{
            id          : 0x2::object::new(arg2),
            name        : arg0.name,
            description : arg0.description,
            image_url   : 0x2::url::new_unsafe_from_bytes(arg0.image_url_bytes),
            trait_type  : arg0.trait_type,
            trait_value : arg0.trait_value,
            template_id : arg1,
        }
    }

    fun create_cosmetic_template(arg0: &mut CosmeticCollection, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: vector<u8>, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: u64, arg7: 0x1::option::Option<u64>, arg8: bool, arg9: 0x1::option::Option<u64>, arg10: &mut 0x2::tx_context::TxContext) : CosmeticTemplate {
        arg0.total_templates_created = arg0.total_templates_created + 1;
        if (0x2::table::contains<0x1::string::String, u64>(&arg0.cosmetics_by_type, arg4)) {
            0x2::table::remove<0x1::string::String, u64>(&mut arg0.cosmetics_by_type, arg4);
            0x2::table::add<0x1::string::String, u64>(&mut arg0.cosmetics_by_type, arg4, *0x2::table::borrow<0x1::string::String, u64>(&arg0.cosmetics_by_type, arg4) + 1);
        } else {
            0x2::table::add<0x1::string::String, u64>(&mut arg0.cosmetics_by_type, arg4, 1);
        };
        CosmeticTemplate{
            id              : 0x2::object::new(arg10),
            name            : arg1,
            description     : arg2,
            image_url_bytes : arg3,
            trait_type      : arg4,
            trait_value     : arg5,
            points_price    : arg6,
            sui_price       : arg7,
            available       : arg8,
            stock           : arg9,
            cosmetic_seq    : arg0.total_templates_created,
        }
    }

    public fun get_applied_cosmetics(arg0: &CosmeticCollection, arg1: u64) : vector<0x2::object::ID> {
        if (0x2::dynamic_object_field::exists_<u64>(&arg0.id, arg1)) {
            0x2::dynamic_object_field::borrow<u64, CosmeticOverrides>(&arg0.id, arg1).applied_cosmetics
        } else {
            0x1::vector::empty<0x2::object::ID>()
        }
    }

    public fun get_cosmetic_overrides(arg0: &CosmeticCollection, arg1: u64) : (vector<0x1::string::String>, vector<0x2::object::ID>) {
        if (0x2::dynamic_object_field::exists_<u64>(&arg0.id, arg1)) {
            (0x1::vector::empty<0x1::string::String>(), 0x2::dynamic_object_field::borrow<u64, CosmeticOverrides>(&arg0.id, arg1).applied_cosmetics)
        } else {
            (0x1::vector::empty<0x1::string::String>(), 0x1::vector::empty<0x2::object::ID>())
        }
    }

    public fun get_cosmetics_count_by_type(arg0: &CosmeticCollection, arg1: 0x1::string::String) : u64 {
        if (0x2::table::contains<0x1::string::String, u64>(&arg0.cosmetics_by_type, arg1)) {
            *0x2::table::borrow<0x1::string::String, u64>(&arg0.cosmetics_by_type, arg1)
        } else {
            0
        }
    }

    public fun get_god_nft_attributes(arg0: &GodNFTList, arg1: u64) : 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String> {
        assert!(0x2::table::contains<u64, 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>(&arg0.god_nfts, arg1), 5);
        *0x2::table::borrow<u64, 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>(&arg0.god_nfts, arg1)
    }

    fun get_or_create_overrides(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) : CosmeticOverrides {
        CosmeticOverrides{
            id                : 0x2::object::new(arg1),
            doonies_token_id  : arg0,
            overrides         : 0x2::table::new<0x1::string::String, 0x2::object::ID>(arg1),
            applied_cosmetics : 0x1::vector::empty<0x2::object::ID>(),
        }
    }

    fun get_or_create_pending(arg0: &mut CosmeticCollection, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : &mut PendingRewards {
        if (0x2::dynamic_object_field::exists_<address>(&mut arg0.id, arg1)) {
            0x2::dynamic_object_field::borrow_mut<address, PendingRewards>(&mut arg0.id, arg1)
        } else {
            let v1 = PendingRewards{
                id                   : 0x2::object::new(arg2),
                token_prize_ids      : 0x1::vector::empty<0x2::object::ID>(),
                nft_direct_prize_ids : 0x1::vector::empty<0x2::object::ID>(),
                nft_kiosk_prize_ids  : 0x1::vector::empty<0x2::object::ID>(),
            };
            0x2::dynamic_object_field::add<address, PendingRewards>(&mut arg0.id, arg1, v1);
            0x2::dynamic_object_field::borrow_mut<address, PendingRewards>(&mut arg0.id, arg1)
        }
    }

    public fun get_template_info(arg0: &CosmeticCollection, arg1: 0x2::object::ID) : (0x1::string::String, 0x1::string::String, 0x1::string::String, 0x1::string::String, u64, 0x1::option::Option<u64>, bool, 0x1::option::Option<u64>) {
        assert!(0x2::table::contains<0x2::object::ID, CosmeticTemplate>(&arg0.cosmetic_catalog, arg1), 10);
        let v0 = 0x2::table::borrow<0x2::object::ID, CosmeticTemplate>(&arg0.cosmetic_catalog, arg1);
        (v0.name, v0.description, v0.trait_type, v0.trait_value, v0.points_price, v0.sui_price, v0.available, v0.stock)
    }

    public fun get_total_templates_created(arg0: &CosmeticCollection) : u64 {
        arg0.total_templates_created
    }

    public fun get_trait_categories(arg0: &CosmeticCollection) : vector<0x1::string::String> {
        arg0.trait_categories
    }

    public fun get_user_points(arg0: &CosmeticCollection, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.user_points, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.user_points, arg1)
        } else {
            0
        }
    }

    public fun has_cosmetic_overrides(arg0: &CosmeticCollection, arg1: u64) : bool {
        0x2::dynamic_object_field::exists_<u64>(&arg0.id, arg1)
    }

    fun init(arg0: COSMETICS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<COSMETICS>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"Background"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"Base"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"Clothes"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"Eyes"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"Hats"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"Key"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"Lens"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"Mouth"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"Shades"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"Tattoos"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"Teeth"));
        let v3 = CosmeticCollection{
            id                      : 0x2::object::new(arg1),
            admin_address           : @0x9728ec13d7321c7ee46669454e6d49857cc29fed09ba13696af7692c55e61a24,
            total_templates_created : 0,
            cosmetics_by_type       : 0x2::table::new<0x1::string::String, u64>(arg1),
            cosmetic_catalog        : 0x2::table::new<0x2::object::ID, CosmeticTemplate>(arg1),
            catalog_index           : 0x1::vector::empty<0x2::object::ID>(),
            available_index         : 0x1::vector::empty<0x2::object::ID>(),
            trait_categories        : v1,
            user_points             : 0x2::table::new<address, u64>(arg1),
        };
        let v4 = CosmeticAdminCap{id: 0x2::object::new(arg1)};
        let v5 = 0x2::display::new<CosmeticNFT>(&v0, arg1);
        0x2::display::add<CosmeticNFT>(&mut v5, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<CosmeticNFT>(&mut v5, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<CosmeticNFT>(&mut v5, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::add<CosmeticNFT>(&mut v5, 0x1::string::utf8(b"trait_type"), 0x1::string::utf8(b"{trait_type}"));
        0x2::display::add<CosmeticNFT>(&mut v5, 0x1::string::utf8(b"trait_value"), 0x1::string::utf8(b"{trait_value}"));
        0x2::display::update_version<CosmeticNFT>(&mut v5);
        let v6 = 0x2::display::new<FreePassNFT>(&v0, arg1);
        0x2::display::add<FreePassNFT>(&mut v6, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"Doonies Free Pass"));
        0x2::display::add<FreePassNFT>(&mut v6, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"One free vault roll"));
        0x2::display::add<FreePassNFT>(&mut v6, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"https://walrus.doonies.net/freepass.png"));
        0x2::display::update_version<FreePassNFT>(&mut v6);
        let (v7, v8) = 0x2::transfer_policy::new<CosmeticNFT>(&v0, arg1);
        let v9 = GodNFTList{
            id                : 0x2::object::new(arg1),
            god_nfts          : 0x2::table::new<u64, 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>(arg1),
            available_god_ids : 0x1::vector::empty<u64>(),
        };
        let v10 = RewardVault{
            id                   : 0x2::object::new(arg1),
            token_prize_ids      : 0x1::vector::empty<0x2::object::ID>(),
            nft_direct_prize_ids : 0x1::vector::empty<0x2::object::ID>(),
            nft_kiosk_prize_ids  : 0x1::vector::empty<0x2::object::ID>(),
            bones_sale_balance   : 0x2::coin::zero<0xe123841a78c44d48c108f340621a2bd3211069de71ebec465d10d50e34caf41c::bones::BONES>(arg1),
            bones_sale_unit      : 1000,
            bones_sale_price_sui : 0,
            god_prize_bps        : 40,
            token_prize_bps      : 500,
            nft_prize_bps        : 200,
            free_pass_bps        : 1000,
            free_pass_price_sui  : 1000000000,
            free_pass_max_supply : 10000,
            free_pass_total_sold : 0,
            paused               : false,
        };
        0x2::transfer::transfer<CosmeticAdminCap>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<CosmeticNFT>>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<CosmeticNFT>>(v8, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<FreePassNFT>>(v6, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<CosmeticNFT>>(v7);
        0x2::transfer::share_object<CosmeticCollection>(v3);
        0x2::transfer::share_object<GodNFTList>(v9);
        0x2::transfer::share_object<RewardVault>(v10);
    }

    public fun is_god_nft(arg0: &GodNFTList, arg1: u64) : bool {
        0x2::table::contains<u64, 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>(&arg0.god_nfts, arg1)
    }

    fun is_valid_trait_type(arg0: 0x1::string::String) : bool {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Background"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Base"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Clothes"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Eyes"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Hats"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Key"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Lens"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Mouth"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Shades"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Tattoos"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Teeth"));
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::string::String>(&v0)) {
            if (arg0 == *0x1::vector::borrow<0x1::string::String>(&v0, v2)) {
                return true
            };
            v2 = v2 + 1;
        };
        false
    }

    public fun list_available(arg0: &CosmeticCollection) : vector<0x2::object::ID> {
        arg0.available_index
    }

    public fun list_catalog(arg0: &CosmeticCollection) : vector<0x2::object::ID> {
        arg0.catalog_index
    }

    public fun list_vault_all_prizes(arg0: &RewardVault) : (vector<0x2::object::ID>, vector<0x2::object::ID>, vector<0x2::object::ID>) {
        (arg0.token_prize_ids, arg0.nft_direct_prize_ids, arg0.nft_kiosk_prize_ids)
    }

    public fun list_vault_nft_direct_prizes(arg0: &RewardVault) : vector<0x2::object::ID> {
        arg0.nft_direct_prize_ids
    }

    public fun list_vault_nft_kiosk_prizes(arg0: &RewardVault) : vector<0x2::object::ID> {
        arg0.nft_kiosk_prize_ids
    }

    public fun list_vault_token_prizes(arg0: &RewardVault) : vector<0x2::object::ID> {
        arg0.token_prize_ids
    }

    public entry fun pause_rolls(arg0: &CosmeticAdminCap, arg1: &mut RewardVault, arg2: &mut 0x2::tx_context::TxContext) {
        arg1.paused = true;
    }

    fun perform_roll(arg0: &mut CosmeticCollection, arg1: &mut RewardVault, arg2: &mut GodNFTList, arg3: &mut 0xe123841a78c44d48c108f340621a2bd3211069de71ebec465d10d50e34caf41c::doonies::NFTCollection, arg4: 0xe123841a78c44d48c108f340621a2bd3211069de71ebec465d10d50e34caf41c::doonies::NFT, arg5: &mut 0x2::transfer_policy::TransferPolicy<0xe123841a78c44d48c108f340621a2bd3211069de71ebec465d10d50e34caf41c::doonies::NFT>, arg6: &mut 0x2::kiosk::Kiosk, arg7: &0x2::kiosk::KioskOwnerCap, arg8: &0x2::random::Random, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg9);
        let v1 = 0xe123841a78c44d48c108f340621a2bd3211069de71ebec465d10d50e34caf41c::doonies::get_token_id(&arg4);
        let v2 = 0x2::random::new_generator(arg8, arg9);
        if (0x2::random::generate_u64_in_range(&mut v2, 0, 10000) < arg1.god_prize_bps) {
            assert!(!0x1::vector::is_empty<u64>(&arg2.available_god_ids), 10);
            let v3 = 0x2::random::generate_u64_in_range(&mut v2, 0, 0x1::vector::length<u64>(&arg2.available_god_ids));
            let v4 = *0x1::vector::borrow<u64>(&arg2.available_god_ids, v3);
            0x1::vector::remove<u64>(&mut arg2.available_god_ids, v3);
            0xe123841a78c44d48c108f340621a2bd3211069de71ebec465d10d50e34caf41c::doonies::burn_nft_internal(arg4, arg3);
            let v5 = 0xe123841a78c44d48c108f340621a2bd3211069de71ebec465d10d50e34caf41c::doonies::create_nft_with_attributes(arg3, v1, *0x2::table::borrow<u64, 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>(&arg2.god_nfts, v4), arg9);
            let v6 = 0x2::object::id<0xe123841a78c44d48c108f340621a2bd3211069de71ebec465d10d50e34caf41c::doonies::NFT>(&v5);
            0x2::kiosk::lock<0xe123841a78c44d48c108f340621a2bd3211069de71ebec465d10d50e34caf41c::doonies::NFT>(arg6, arg7, arg5, v5);
            let v7 = GodNFTReminted{
                old_token_id : v1,
                new_token_id : v1,
                new_nft_id   : v6,
                god_token_id : v4,
                reminter     : v0,
            };
            0x2::event::emit<GodNFTReminted>(v7);
            let v8 = VaultPrizeRolled{
                sender     : v0,
                prize_type : 0x1::string::utf8(b"god"),
                prize_id   : v6,
            };
            0x2::event::emit<VaultPrizeRolled>(v8);
        } else {
            let v9 = 0x2::random::generate_u64_in_range(&mut v2, 0, 10000);
            if (v9 < arg1.token_prize_bps && !0x1::vector::is_empty<0x2::object::ID>(&arg1.token_prize_ids)) {
                let v10 = 0x2::random::generate_u64_in_range(&mut v2, 0, 0x1::vector::length<0x2::object::ID>(&arg1.token_prize_ids));
                let v11 = *0x1::vector::borrow<0x2::object::ID>(&arg1.token_prize_ids, v10);
                0x1::vector::push_back<0x2::object::ID>(&mut get_or_create_pending(arg0, v0, arg9).token_prize_ids, v11);
                0x1::vector::swap_remove<0x2::object::ID>(&mut arg1.token_prize_ids, v10);
                let v12 = VaultPrizeRolled{
                    sender     : v0,
                    prize_type : 0x1::string::utf8(b"token"),
                    prize_id   : v11,
                };
                0x2::event::emit<VaultPrizeRolled>(v12);
            } else if (v9 < arg1.token_prize_bps + arg1.nft_prize_bps) {
                if (!0x1::vector::is_empty<0x2::object::ID>(&arg1.nft_direct_prize_ids)) {
                    let v13 = 0x2::random::generate_u64_in_range(&mut v2, 0, 0x1::vector::length<0x2::object::ID>(&arg1.nft_direct_prize_ids));
                    let v14 = *0x1::vector::borrow<0x2::object::ID>(&arg1.nft_direct_prize_ids, v13);
                    0x1::vector::push_back<0x2::object::ID>(&mut get_or_create_pending(arg0, v0, arg9).nft_direct_prize_ids, v14);
                    0x1::vector::swap_remove<0x2::object::ID>(&mut arg1.nft_direct_prize_ids, v13);
                    let v15 = VaultPrizeRolled{
                        sender     : v0,
                        prize_type : 0x1::string::utf8(b"nft"),
                        prize_id   : v14,
                    };
                    0x2::event::emit<VaultPrizeRolled>(v15);
                } else if (!0x1::vector::is_empty<0x2::object::ID>(&arg1.nft_kiosk_prize_ids)) {
                    let v16 = 0x2::random::generate_u64_in_range(&mut v2, 0, 0x1::vector::length<0x2::object::ID>(&arg1.nft_kiosk_prize_ids));
                    let v17 = *0x1::vector::borrow<0x2::object::ID>(&arg1.nft_kiosk_prize_ids, v16);
                    0x1::vector::push_back<0x2::object::ID>(&mut get_or_create_pending(arg0, v0, arg9).nft_kiosk_prize_ids, v17);
                    0x1::vector::swap_remove<0x2::object::ID>(&mut arg1.nft_kiosk_prize_ids, v16);
                    let v18 = VaultPrizeRolled{
                        sender     : v0,
                        prize_type : 0x1::string::utf8(b"nft"),
                        prize_id   : v17,
                    };
                    0x2::event::emit<VaultPrizeRolled>(v18);
                } else {
                    let v19 = VaultPrizeRolled{
                        sender     : v0,
                        prize_type : 0x1::string::utf8(b"none"),
                        prize_id   : 0x2::object::id<0xe123841a78c44d48c108f340621a2bd3211069de71ebec465d10d50e34caf41c::doonies::NFT>(&arg4),
                    };
                    0x2::event::emit<VaultPrizeRolled>(v19);
                };
            } else if (v9 < arg1.token_prize_bps + arg1.nft_prize_bps + arg1.free_pass_bps) {
                if (arg1.free_pass_price_sui > 0) {
                    let v20 = FreePassNFT{
                        id          : 0x2::object::new(arg9),
                        name        : 0x1::string::utf8(b"Doonies Free Pass"),
                        description : 0x1::string::utf8(b"One free vault roll"),
                        image_url   : 0x2::url::new_unsafe_from_bytes(b"https://walrus.doonies.net/freepass.png"),
                    };
                    0x2::transfer::public_transfer<FreePassNFT>(v20, v0);
                    let v21 = VaultPrizeRolled{
                        sender     : v0,
                        prize_type : 0x1::string::utf8(b"pass"),
                        prize_id   : 0x2::object::id<FreePassNFT>(&v20),
                    };
                    0x2::event::emit<VaultPrizeRolled>(v21);
                } else {
                    let v22 = VaultPrizeRolled{
                        sender     : v0,
                        prize_type : 0x1::string::utf8(b"none"),
                        prize_id   : 0x2::object::id<0xe123841a78c44d48c108f340621a2bd3211069de71ebec465d10d50e34caf41c::doonies::NFT>(&arg4),
                    };
                    0x2::event::emit<VaultPrizeRolled>(v22);
                };
            } else {
                let v23 = VaultPrizeRolled{
                    sender     : v0,
                    prize_type : 0x1::string::utf8(b"none"),
                    prize_id   : 0x2::object::id<0xe123841a78c44d48c108f340621a2bd3211069de71ebec465d10d50e34caf41c::doonies::NFT>(&arg4),
                };
                0x2::event::emit<VaultPrizeRolled>(v23);
            };
            0x2::kiosk::lock<0xe123841a78c44d48c108f340621a2bd3211069de71ebec465d10d50e34caf41c::doonies::NFT>(arg6, arg7, arg5, arg4);
        };
    }

    public entry fun purchase_cosmetic(arg0: &mut CosmeticCollection, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<0xe123841a78c44d48c108f340621a2bd3211069de71ebec465d10d50e34caf41c::bones::BONES>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::table::contains<0x2::object::ID, CosmeticTemplate>(&arg0.cosmetic_catalog, arg1), 10);
        let v1 = 0x2::table::borrow_mut<0x2::object::ID, CosmeticTemplate>(&mut arg0.cosmetic_catalog, arg1);
        assert!(v1.available, 10);
        if (0x1::option::is_some<u64>(&v1.stock)) {
            assert!(*0x1::option::borrow<u64>(&v1.stock) > 0, 10);
        };
        let v2 = v1.points_price;
        assert!(0x2::coin::value<0xe123841a78c44d48c108f340621a2bd3211069de71ebec465d10d50e34caf41c::bones::BONES>(&arg2) >= v2, 12);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xe123841a78c44d48c108f340621a2bd3211069de71ebec465d10d50e34caf41c::bones::BONES>>(0x2::coin::split<0xe123841a78c44d48c108f340621a2bd3211069de71ebec465d10d50e34caf41c::bones::BONES>(&mut arg2, v2, arg3), arg0.admin_address);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xe123841a78c44d48c108f340621a2bd3211069de71ebec465d10d50e34caf41c::bones::BONES>>(arg2, v0);
        let v3 = create_cosmetic_instance(v1, arg1, arg3);
        let v4 = CosmeticPurchased{
            template_id  : arg1,
            instance_id  : 0x2::object::id<CosmeticNFT>(&v3),
            buyer        : v0,
            payment_type : 0x1::string::utf8(b"BONES"),
            amount       : v2,
        };
        0x2::event::emit<CosmeticPurchased>(v4);
        0x2::transfer::public_transfer<CosmeticNFT>(v3, v0);
        if (0x1::option::is_some<u64>(&v1.stock)) {
            let v5 = 0x1::option::borrow_mut<u64>(&mut v1.stock);
            *v5 = *v5 - 1;
            if (*v5 == 0) {
                v1.available = false;
                remove_from_available_index(arg0, arg1);
            };
        };
    }

    public entry fun purchase_cosmetic_with_points(arg0: &mut CosmeticCollection, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::table::contains<0x2::object::ID, CosmeticTemplate>(&arg0.cosmetic_catalog, arg1), 10);
        let v1 = 0x2::table::borrow_mut<0x2::object::ID, CosmeticTemplate>(&mut arg0.cosmetic_catalog, arg1);
        assert!(v1.available, 10);
        if (0x1::option::is_some<u64>(&v1.stock)) {
            assert!(*0x1::option::borrow<u64>(&v1.stock) > 0, 10);
        };
        let v2 = v1.points_price;
        assert!(0x2::table::contains<address, u64>(&arg0.user_points, v0), 12);
        let v3 = 0x2::table::borrow_mut<address, u64>(&mut arg0.user_points, v0);
        assert!(*v3 >= v2, 12);
        *v3 = *v3 - v2;
        let v4 = create_cosmetic_instance(v1, arg1, arg2);
        let v5 = CosmeticPurchased{
            template_id  : arg1,
            instance_id  : 0x2::object::id<CosmeticNFT>(&v4),
            buyer        : v0,
            payment_type : 0x1::string::utf8(b"POINTS"),
            amount       : v2,
        };
        0x2::event::emit<CosmeticPurchased>(v5);
        0x2::transfer::public_transfer<CosmeticNFT>(v4, v0);
        if (0x1::option::is_some<u64>(&v1.stock)) {
            let v6 = 0x1::option::borrow_mut<u64>(&mut v1.stock);
            *v6 = *v6 - 1;
            if (*v6 == 0) {
                v1.available = false;
                remove_from_available_index(arg0, arg1);
            };
        };
    }

    public entry fun remove_cosmetic(arg0: &mut CosmeticCollection, arg1: u64, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::tx_context::sender(arg3) == arg0.admin_address, 1);
        assert!(0x2::dynamic_object_field::exists_<u64>(&arg0.id, arg1), 10);
        let v1 = 0x2::dynamic_object_field::borrow_mut<u64, CosmeticOverrides>(&mut arg0.id, arg1);
        assert!(0x2::table::contains<0x1::string::String, 0x2::object::ID>(&v1.overrides, arg2), 10);
        let v2 = *0x2::table::borrow<0x1::string::String, 0x2::object::ID>(&v1.overrides, arg2);
        0x2::table::remove<0x1::string::String, 0x2::object::ID>(&mut v1.overrides, arg2);
        let (v3, v4) = 0x1::vector::index_of<0x2::object::ID>(&v1.applied_cosmetics, &v2);
        if (v3) {
            0x1::vector::remove<0x2::object::ID>(&mut v1.applied_cosmetics, v4);
        };
        0x2::transfer::public_transfer<CosmeticNFT>(0x2::dynamic_object_field::remove<0x2::object::ID, CosmeticNFT>(&mut v1.id, v2), v0);
        let v5 = CosmeticRemoved{
            doonies_token_id : arg1,
            cosmetic_id      : v2,
            trait_type       : arg2,
            remover          : v0,
        };
        0x2::event::emit<CosmeticRemoved>(v5);
    }

    fun remove_from_available_index(arg0: &mut CosmeticCollection, arg1: 0x2::object::ID) {
        let (v0, v1) = 0x1::vector::index_of<0x2::object::ID>(&arg0.available_index, &arg1);
        if (v0) {
            0x1::vector::remove<0x2::object::ID>(&mut arg0.available_index, v1);
        };
    }

    public entry fun roll_vault_prize(arg0: &mut CosmeticCollection, arg1: &mut RewardVault, arg2: &mut GodNFTList, arg3: &mut 0xe123841a78c44d48c108f340621a2bd3211069de71ebec465d10d50e34caf41c::doonies::NFTCollection, arg4: 0xe123841a78c44d48c108f340621a2bd3211069de71ebec465d10d50e34caf41c::doonies::NFT, arg5: &mut 0x2::transfer_policy::TransferPolicy<0xe123841a78c44d48c108f340621a2bd3211069de71ebec465d10d50e34caf41c::doonies::NFT>, arg6: &mut 0x2::kiosk::Kiosk, arg7: &0x2::kiosk::KioskOwnerCap, arg8: &0x2::random::Random, arg9: 0x2::coin::Coin<0xe123841a78c44d48c108f340621a2bd3211069de71ebec465d10d50e34caf41c::bones::BONES>, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.paused, 13);
        assert!(0x2::coin::value<0xe123841a78c44d48c108f340621a2bd3211069de71ebec465d10d50e34caf41c::bones::BONES>(&arg9) >= 1000, 12);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xe123841a78c44d48c108f340621a2bd3211069de71ebec465d10d50e34caf41c::bones::BONES>>(0x2::coin::split<0xe123841a78c44d48c108f340621a2bd3211069de71ebec465d10d50e34caf41c::bones::BONES>(&mut arg9, 1000, arg10), arg0.admin_address);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xe123841a78c44d48c108f340621a2bd3211069de71ebec465d10d50e34caf41c::bones::BONES>>(arg9, 0x2::tx_context::sender(arg10));
        perform_roll(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg10);
    }

    public entry fun roll_vault_prize_with_pass(arg0: &mut CosmeticCollection, arg1: &mut RewardVault, arg2: &mut GodNFTList, arg3: &mut 0xe123841a78c44d48c108f340621a2bd3211069de71ebec465d10d50e34caf41c::doonies::NFTCollection, arg4: 0xe123841a78c44d48c108f340621a2bd3211069de71ebec465d10d50e34caf41c::doonies::NFT, arg5: &mut 0x2::transfer_policy::TransferPolicy<0xe123841a78c44d48c108f340621a2bd3211069de71ebec465d10d50e34caf41c::doonies::NFT>, arg6: &mut 0x2::kiosk::Kiosk, arg7: &0x2::kiosk::KioskOwnerCap, arg8: &0x2::random::Random, arg9: FreePassNFT, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.paused, 13);
        let FreePassNFT {
            id          : v0,
            name        : _,
            description : _,
            image_url   : _,
        } = arg9;
        0x2::object::delete(v0);
        perform_roll(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg10);
    }

    public entry fun roll_vault_prize_with_points(arg0: &mut CosmeticCollection, arg1: &mut RewardVault, arg2: &mut GodNFTList, arg3: &mut 0xe123841a78c44d48c108f340621a2bd3211069de71ebec465d10d50e34caf41c::doonies::NFTCollection, arg4: 0xe123841a78c44d48c108f340621a2bd3211069de71ebec465d10d50e34caf41c::doonies::NFT, arg5: &mut 0x2::transfer_policy::TransferPolicy<0xe123841a78c44d48c108f340621a2bd3211069de71ebec465d10d50e34caf41c::doonies::NFT>, arg6: &mut 0x2::kiosk::Kiosk, arg7: &0x2::kiosk::KioskOwnerCap, arg8: &0x2::random::Random, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.paused, 13);
        let v0 = 0x2::tx_context::sender(arg9);
        assert!(0x2::table::contains<address, u64>(&arg0.user_points, v0), 12);
        let v1 = 0x2::table::borrow_mut<address, u64>(&mut arg0.user_points, v0);
        assert!(*v1 >= 1000, 12);
        *v1 = *v1 - 1000;
        perform_roll(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
    }

    public entry fun unpause_rolls(arg0: &CosmeticAdminCap, arg1: &mut RewardVault, arg2: &mut 0x2::tx_context::TxContext) {
        arg1.paused = false;
    }

    fun update_available_index(arg0: &mut CosmeticCollection, arg1: 0x2::object::ID, arg2: bool) {
        if (arg2) {
            add_to_available_index(arg0, arg1);
        } else {
            remove_from_available_index(arg0, arg1);
        };
    }

    // decompiled from Move bytecode v6
}

