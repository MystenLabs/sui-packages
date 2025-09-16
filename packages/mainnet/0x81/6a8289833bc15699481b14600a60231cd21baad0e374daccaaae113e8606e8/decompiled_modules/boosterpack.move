module 0xb908f3c6fea6865d32e2048c520cdfe3b5c5bbcebb658117c41bad70f52b7ccc::boosterpack {
    struct BOOSTERPACK has drop {
        dummy_field: bool,
    }

    struct BoosterPack has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        link: 0x1::string::String,
        image_url: 0x1::string::String,
        description: 0x1::string::String,
        project_url: 0x1::string::String,
        creator: 0x1::string::String,
        pool_data: 0x1::string::String,
        key: 0x1::string::String,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    struct SBoosterPack has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        link: 0x1::string::String,
        image_url: 0x1::string::String,
        description: 0x1::string::String,
        project_url: 0x1::string::String,
        creator: 0x1::string::String,
        pool_data: 0x1::string::String,
        key: 0x1::string::String,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    struct BoosterPackUSDCPool has key {
        id: 0x2::object::UID,
        version: u8,
        balance: 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>,
    }

    struct BoosterPackRegistryCap has store, key {
        id: 0x2::object::UID,
    }

    struct BoosterPackRegistryPolicy has key {
        id: 0x2::object::UID,
        version: u8,
        empty_policy: 0x2::transfer_policy::TransferPolicy<BoosterPack>,
        policy_cap: 0x2::transfer_policy::TransferPolicyCap<BoosterPack>,
    }

    struct BoosterPackClaimed has copy, drop {
        pack_id: 0x2::object::ID,
        key: 0x1::string::String,
        nonce: u64,
        owner: address,
    }

    struct BoosterPackMinted has copy, drop {
        pack_id: 0x2::object::ID,
        key: 0x1::string::String,
        nonce: u64,
        owner: address,
        kiosk_id: 0x2::object::ID,
    }

    struct BoosterPackTransferred has copy, drop {
        pack_id: 0x2::object::ID,
        new_owner: address,
        kiosk_id: 0x2::object::ID,
        kiosk_owner_cap_id: 0x2::object::ID,
    }

    struct BoosterPackBurned has copy, drop {
        nft_id: 0x2::object::ID,
        key: 0x1::string::String,
        pool_data: 0x1::string::String,
    }

    struct SBoosterPackBurned has copy, drop {
        nft_id: 0x2::object::ID,
        key: 0x1::string::String,
        pool_data: 0x1::string::String,
    }

    struct BoosterPackUSDCPlaced has copy, drop {
        sender: address,
        amount: u64,
    }

    struct BoosterPackUSDCWithdrawn has copy, drop {
        sender: address,
        amount: u64,
    }

    struct SBoosterPackMinted has copy, drop {
        pack_id: 0x2::object::ID,
        key: 0x1::string::String,
        nonce: u64,
        owner: address,
    }

    public fun balance(arg0: &BoosterPackUSDCPool) : &0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC> {
        &arg0.balance
    }

    public fun transfer(arg0: &mut BoosterPackRegistryPolicy, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: &0x2::transfer_policy::TransferPolicy<BoosterPack>, arg4: 0x2::object::ID, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        validate_boosterpack_registry_policy_version(arg0);
        let (v0, v1) = 0x2::kiosk::purchase_with_cap<BoosterPack>(arg1, 0x2::kiosk::list_with_purchase_cap<BoosterPack>(arg1, arg2, arg4, 0, arg6), 0x2::coin::zero<0x2::sui::SUI>(arg6));
        let v2 = v0;
        let (_, _, _) = 0x2::transfer_policy::confirm_request<BoosterPack>(&arg0.empty_policy, v1);
        let (v6, v7) = 0x2::kiosk::new(arg6);
        let v8 = v7;
        let v9 = v6;
        0x2::kiosk::lock<BoosterPack>(&mut v9, &v8, arg3, v2);
        let v10 = BoosterPackTransferred{
            pack_id            : 0x2::object::uid_to_inner(&v2.id),
            new_owner          : arg5,
            kiosk_id           : 0x2::object::uid_to_inner(0x2::kiosk::uid(&v9)),
            kiosk_owner_cap_id : 0x2::kiosk::kiosk_owner_cap_for(&v8),
        };
        0x2::event::emit<BoosterPackTransferred>(v10);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v9);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v8, arg5);
    }

    public fun attributes(arg0: &BoosterPack) : 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String> {
        arg0.attributes
    }

    public fun burn(arg0: &mut BoosterPackRegistryPolicy, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: &mut 0x2::tx_context::TxContext) {
        validate_boosterpack_registry_policy_version(arg0);
        let (v0, v1) = 0x2::kiosk::purchase_with_cap<BoosterPack>(arg1, 0x2::kiosk::list_with_purchase_cap<BoosterPack>(arg1, arg2, arg3, 0, arg4), 0x2::coin::zero<0x2::sui::SUI>(arg4));
        let (_, _, _) = 0x2::transfer_policy::confirm_request<BoosterPack>(&arg0.empty_policy, v1);
        let BoosterPack {
            id          : v5,
            name        : _,
            link        : _,
            image_url   : _,
            description : _,
            project_url : _,
            creator     : _,
            pool_data   : v12,
            key         : v13,
            attributes  : _,
        } = v0;
        let v15 = v5;
        let v16 = BoosterPackBurned{
            nft_id    : 0x2::object::uid_to_inner(&v15),
            key       : v13,
            pool_data : v12,
        };
        0x2::event::emit<BoosterPackBurned>(v16);
        0x2::object::delete(v15);
    }

    public fun burn_soulbound(arg0: SBoosterPack) {
        let SBoosterPack {
            id          : v0,
            name        : _,
            link        : _,
            image_url   : _,
            description : _,
            project_url : _,
            creator     : _,
            pool_data   : v7,
            key         : v8,
            attributes  : _,
        } = arg0;
        let v10 = v0;
        let v11 = SBoosterPackBurned{
            nft_id    : 0x2::object::uid_to_inner(&v10),
            key       : v8,
            pool_data : v7,
        };
        0x2::event::emit<SBoosterPackBurned>(v11);
        0x2::object::delete(v10);
    }

    public fun claim_boosterpack(arg0: &mut 0xb908f3c6fea6865d32e2048c520cdfe3b5c5bbcebb658117c41bad70f52b7ccc::registry::Registry, arg1: &mut BoosterPackUSDCPool, arg2: vector<u8>, arg3: vector<u8>, arg4: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>, arg5: &mut 0x1::option::Option<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>, arg6: &mut 0x2::tx_context::TxContext) : BoosterPack {
        0xb908f3c6fea6865d32e2048c520cdfe3b5c5bbcebb658117c41bad70f52b7ccc::registry::validate_registry_version(arg0);
        validate_boosterpack_usdc_pool_version(arg1);
        let v0 = 0xb908f3c6fea6865d32e2048c520cdfe3b5c5bbcebb658117c41bad70f52b7ccc::registry::admin_public_key(arg0);
        assert!(0x2::ed25519::ed25519_verify(&arg3, &v0, &arg2), 0);
        let v1 = 0x2::bcs::new(arg2);
        let v2 = 0x2::bcs::peel_address(&mut v1);
        let v3 = 0x2::bcs::peel_u64(&mut v1);
        let v4 = 0x2::bcs::peel_u64(&mut v1);
        let v5 = 0x2::bcs::peel_u64(&mut v1);
        let v6 = 0x2::bcs::peel_vec_u8(&mut v1);
        assert!(0x2::bcs::peel_vec_u8(&mut v1) == b"BoosterPackClaim", 8);
        let v7 = 0x2::bcs::into_remainder_bytes(v1);
        assert!(0x1::vector::length<u8>(&v7) == 0, 9);
        assert!(v2 == 0x2::tx_context::sender(arg6), 1);
        assert!(!0x2::table::contains<u64, u64>(0xb908f3c6fea6865d32e2048c520cdfe3b5c5bbcebb658117c41bad70f52b7ccc::registry::claimed_list(arg0), v3), 2);
        if (v4 > 0) {
            assert!(0x1::option::is_some<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(arg5), 4);
            let v8 = 0x1::option::extract<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(arg5);
            assert!(0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&v8) == v4, 3);
            let v9 = BoosterPackUSDCPlaced{
                sender : 0x2::tx_context::sender(arg6),
                amount : 0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&v8),
            };
            0x2::event::emit<BoosterPackUSDCPlaced>(v9);
            0x2::balance::join<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg1.balance, 0x2::coin::into_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v8));
        };
        assert!(v5 + 0xb908f3c6fea6865d32e2048c520cdfe3b5c5bbcebb658117c41bad70f52b7ccc::registry::nonce_expiration_window(arg0) > 0x2::tx_context::epoch(arg6), 7);
        let v10 = BoosterPack{
            id          : 0x2::object::new(arg6),
            name        : 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v1)),
            link        : 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v1)),
            image_url   : 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v1)),
            description : 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v1)),
            project_url : 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v1)),
            creator     : 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v1)),
            pool_data   : 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v1)),
            key         : 0x1::string::utf8(v6),
            attributes  : arg4,
        };
        let v11 = BoosterPackClaimed{
            pack_id : 0x2::object::uid_to_inner(&v10.id),
            key     : 0x1::string::utf8(v6),
            nonce   : v3,
            owner   : v2,
        };
        0x2::event::emit<BoosterPackClaimed>(v11);
        0xb908f3c6fea6865d32e2048c520cdfe3b5c5bbcebb658117c41bad70f52b7ccc::registry::new_boosterpack_claim(arg0, v3, v5, arg6);
        v10
    }

    public fun creator(arg0: &BoosterPack) : 0x1::string::String {
        arg0.creator
    }

    public fun description(arg0: &BoosterPack) : 0x1::string::String {
        arg0.description
    }

    public fun id(arg0: &BoosterPack) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun image_url(arg0: &BoosterPack) : 0x1::string::String {
        arg0.image_url
    }

    fun init(arg0: BOOSTERPACK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<BOOSTERPACK>(arg0, arg1);
        let (v1, v2) = 0x2::transfer_policy::new<BoosterPack>(&v0, arg1);
        let v3 = BoosterPackRegistryPolicy{
            id           : 0x2::object::new(arg1),
            version      : 2,
            empty_policy : v1,
            policy_cap   : v2,
        };
        0x2::transfer::share_object<BoosterPackRegistryPolicy>(v3);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        let v4 = BoosterPackUSDCPool{
            id      : 0x2::object::new(arg1),
            version : 2,
            balance : 0x2::balance::zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(),
        };
        0x2::transfer::share_object<BoosterPackUSDCPool>(v4);
        let v5 = BoosterPackRegistryCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<BoosterPackRegistryCap>(v5, 0x2::tx_context::sender(arg1));
    }

    public fun key(arg0: &BoosterPack) : 0x1::string::String {
        arg0.key
    }

    public fun link(arg0: &BoosterPack) : 0x1::string::String {
        arg0.link
    }

    public(friend) fun mint_boosterpack(arg0: &0x2::transfer_policy::TransferPolicy<BoosterPack>, arg1: address, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::kiosk::new(arg11);
        let v2 = v1;
        let v3 = v0;
        let v4 = BoosterPack{
            id          : 0x2::object::new(arg11),
            name        : arg2,
            link        : arg3,
            image_url   : arg4,
            description : arg5,
            project_url : arg6,
            creator     : arg7,
            pool_data   : arg8,
            key         : arg9,
            attributes  : arg10,
        };
        0x2::kiosk::lock<BoosterPack>(&mut v3, &v2, arg0, v4);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v3);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v2, arg1);
        let v5 = BoosterPackMinted{
            pack_id  : 0x2::object::uid_to_inner(&v4.id),
            key      : arg9,
            nonce    : 0,
            owner    : arg1,
            kiosk_id : 0x2::object::uid_to_inner(0x2::kiosk::uid(&v3)),
        };
        0x2::event::emit<BoosterPackMinted>(v5);
    }

    public(friend) fun mint_soulbound_boosterpack(arg0: address, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = SBoosterPack{
            id          : 0x2::object::new(arg10),
            name        : arg1,
            link        : arg2,
            image_url   : arg3,
            description : arg4,
            project_url : arg5,
            creator     : arg6,
            pool_data   : arg7,
            key         : arg8,
            attributes  : arg9,
        };
        let v1 = SBoosterPackMinted{
            pack_id : 0x2::object::uid_to_inner(&v0.id),
            key     : arg8,
            nonce   : 0,
            owner   : arg0,
        };
        0x2::event::emit<SBoosterPackMinted>(v1);
        0x2::transfer::transfer<SBoosterPack>(v0, arg0);
    }

    public fun name(arg0: &BoosterPack) : 0x1::string::String {
        arg0.name
    }

    public fun pool_data(arg0: &BoosterPack) : 0x1::string::String {
        arg0.pool_data
    }

    public fun project_url(arg0: &BoosterPack) : 0x1::string::String {
        arg0.project_url
    }

    public fun pump_boosterpack_registry_policy_version(arg0: &0xb908f3c6fea6865d32e2048c520cdfe3b5c5bbcebb658117c41bad70f52b7ccc::registry::AdminCap, arg1: &mut BoosterPackRegistryPolicy) {
        arg1.version = 2;
    }

    public fun pump_boosterpack_usdc_pool_version(arg0: &0xb908f3c6fea6865d32e2048c520cdfe3b5c5bbcebb658117c41bad70f52b7ccc::registry::AdminCap, arg1: &mut BoosterPackUSDCPool) {
        arg1.version = 2;
    }

    public fun spool_data(arg0: &SBoosterPack) : 0x1::string::String {
        arg0.pool_data
    }

    public fun sweep_remaining_funds_to_treasury(arg0: &BoosterPackRegistryCap, arg1: &mut BoosterPackUSDCPool, arg2: &0xb908f3c6fea6865d32e2048c520cdfe3b5c5bbcebb658117c41bad70f52b7ccc::registry::PoolAdminSettings, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 > 0, 5);
        assert!(arg3 <= 0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg1.balance), 6);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(0x2::coin::take<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg1.balance, arg3, arg4), 0xb908f3c6fea6865d32e2048c520cdfe3b5c5bbcebb658117c41bad70f52b7ccc::registry::treasury_address(arg2));
        let v0 = BoosterPackUSDCWithdrawn{
            sender : 0x2::tx_context::sender(arg4),
            amount : arg3,
        };
        0x2::event::emit<BoosterPackUSDCWithdrawn>(v0);
    }

    public fun validate_boosterpack_registry_policy_version(arg0: &BoosterPackRegistryPolicy) {
        assert!(arg0.version == 2, 11);
    }

    public fun validate_boosterpack_usdc_pool_version(arg0: &BoosterPackUSDCPool) {
        assert!(arg0.version == 2, 10);
    }

    // decompiled from Move bytecode v6
}

