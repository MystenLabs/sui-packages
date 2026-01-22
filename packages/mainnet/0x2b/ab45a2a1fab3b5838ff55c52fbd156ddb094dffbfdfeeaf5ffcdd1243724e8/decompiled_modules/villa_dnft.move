module 0x2bab45a2a1fab3b5838ff55c52fbd156ddb094dffbfdfeeaf5ffcdd1243724e8::villa_dnft {
    struct VILLA_DNFT has drop {
        dummy_field: bool,
    }

    struct AppCap has store, key {
        id: 0x2::object::UID,
        app_address: address,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
        app_address: address,
    }

    struct AssetManagerCap has store, key {
        id: 0x2::object::UID,
        app_address: address,
    }

    struct SuperAdminRegistry has store, key {
        id: 0x2::object::UID,
        super_admin: address,
        admins: 0x2::table::Table<address, AdminInfo>,
        total_admins: u64,
        created_at: u64,
    }

    struct AddressRegistry has store, key {
        id: 0x2::object::UID,
        addresses: 0x2::table::Table<address, AddressInfo>,
        total_addresses: u64,
        created_at: u64,
    }

    struct AddressInfo has drop, store {
        address: address,
        registered_by: address,
        registered_at: u64,
        is_active: bool,
        last_activity: u64,
    }

    struct AdminInfo has drop, store {
        address: address,
        role: 0x1::string::String,
        permissions: vector<0x1::string::String>,
        granted_by: address,
        granted_at: u64,
        is_active: bool,
        last_activity: u64,
    }

    struct RolePermissionRegistry has store, key {
        id: 0x2::object::UID,
        roles: 0x2::table::Table<0x1::string::String, vector<0x1::string::String>>,
    }

    struct AdminDelegationCap has store, key {
        id: 0x2::object::UID,
        admin_address: address,
        delegated_by: address,
        expires_at: u64,
        permissions: vector<0x1::string::String>,
    }

    struct VillaProject has store, key {
        id: 0x2::object::UID,
        project_id: 0x1::string::String,
        name: 0x1::string::String,
        description: 0x1::string::String,
        total_villas: u64,
        max_total_shares: u64,
        total_shares_issued: u64,
        commission_rate: u64,
        affiliate_rate: u64,
        created_at: u64,
        updated_at: u64,
    }

    struct VillaMetadata has store, key {
        id: 0x2::object::UID,
        project_id: 0x1::string::String,
        villa_id: 0x1::string::String,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        location: 0x1::string::String,
        max_shares: u64,
        shares_issued: u64,
        price_per_share: u64,
        created_at: u64,
        updated_at: u64,
    }

    struct VillaShareNFT has store, key {
        id: 0x2::object::UID,
        project_id: 0x1::string::String,
        villa_id: 0x1::string::String,
        owner: address,
        affiliate_code: 0x1::string::String,
        is_affiliate_active: bool,
        created_at: u64,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        price: u64,
        is_listed: bool,
        listing_price: u64,
    }

    struct AffiliateReward has store, key {
        id: 0x2::object::UID,
        affiliate_code: 0x1::string::String,
        owner: address,
        total_earned: u64,
        total_paid: u64,
        pending_amount: u64,
        created_at: u64,
        updated_at: u64,
    }

    struct AppTreasury has store, key {
        id: 0x2::object::UID,
        project_id: 0x1::string::String,
        total_earned: u64,
        total_paid: u64,
        pending_amount: u64,
        created_at: u64,
        updated_at: u64,
    }

    struct TreasuryConfig has store, key {
        id: 0x2::object::UID,
        treasury_address: address,
        admin_address: address,
        created_at: u64,
        updated_at: u64,
    }

    struct AffiliateConfig has store, key {
        id: 0x2::object::UID,
        default_prefix: 0x1::string::String,
        current_prefix: 0x1::string::String,
        admin_address: address,
        is_active: bool,
        created_at: u64,
        updated_at: u64,
    }

    struct UserVault has store, key {
        id: 0x2::object::UID,
        owner: address,
        sui_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        usdc_balance: 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>,
        created_at: u64,
        updated_at: u64,
    }

    struct MintingConfig has store, key {
        id: 0x2::object::UID,
        is_enabled: bool,
        admin_address: address,
        created_at: u64,
        updated_at: u64,
    }

    struct VillaProjectCreated has copy, drop {
        project_id: 0x1::string::String,
        name: 0x1::string::String,
        max_total_shares: u64,
        created_at: u64,
    }

    struct VillaProjectUpdated has copy, drop {
        project_id: 0x1::string::String,
        old_name: 0x1::string::String,
        new_name: 0x1::string::String,
        old_commission_rate: u64,
        new_commission_rate: u64,
        old_affiliate_rate: u64,
        new_affiliate_rate: u64,
        updated_at: u64,
    }

    struct VillaMetadataCreated has copy, drop {
        project_id: 0x1::string::String,
        villa_id: 0x1::string::String,
        name: 0x1::string::String,
        max_shares: u64,
        created_at: u64,
    }

    struct VillaSharesMinted has copy, drop {
        project_id: 0x1::string::String,
        villa_id: 0x1::string::String,
        amount: u64,
        total_shares_issued: u64,
        created_at: u64,
        nft_name: 0x1::string::String,
        nft_description: 0x1::string::String,
        nft_image_url: 0x1::string::String,
        nft_price: u64,
    }

    struct AffiliateRewardEarned has copy, drop {
        affiliate_code: 0x1::string::String,
        owner: address,
        amount: u64,
        timestamp: u64,
    }

    struct CommissionPaid has copy, drop {
        recipient: address,
        amount: u64,
        timestamp: u64,
    }

    struct AdminAdded has copy, drop {
        admin_address: address,
        role: 0x1::string::String,
        granted_by: address,
        timestamp: u64,
    }

    struct AdminRemoved has copy, drop {
        admin_address: address,
        removed_by: address,
        timestamp: u64,
    }

    struct AdminRoleUpdated has copy, drop {
        admin_address: address,
        old_role: 0x1::string::String,
        new_role: 0x1::string::String,
        updated_by: address,
        timestamp: u64,
    }

    struct AdminPermissionGranted has copy, drop {
        admin_address: address,
        permission: 0x1::string::String,
        granted_by: address,
        timestamp: u64,
    }

    struct AdminPermissionRevoked has copy, drop {
        admin_address: address,
        permission: 0x1::string::String,
        revoked_by: address,
        timestamp: u64,
    }

    struct OwnershipTransferred has copy, drop {
        old_owner: address,
        new_owner: address,
        timestamp: u64,
    }

    struct AdminDelegationCreated has copy, drop {
        admin_address: address,
        delegated_by: address,
        permissions: vector<0x1::string::String>,
        expires_at: u64,
        timestamp: u64,
    }

    struct AdminListedForUser has copy, drop {
        nft_id: 0x2::object::ID,
        admin_address: address,
        user_address: address,
        price: u64,
        timestamp: u64,
    }

    struct AdminMintedForUser has copy, drop {
        nft_id: 0x2::object::ID,
        admin_address: address,
        user_address: address,
        timestamp: u64,
    }

    struct AdminMintedForAdmin has copy, drop {
        nft_id: 0x2::object::ID,
        admin_address: address,
        timestamp: u64,
    }

    struct AdminTransferredForUser has copy, drop {
        nft_id: 0x2::object::ID,
        admin_address: address,
        from_address: address,
        to_address: address,
        timestamp: u64,
    }

    struct AdminBoughtForUser has copy, drop {
        nft_id: 0x2::object::ID,
        admin_address: address,
        buyer_address: address,
        seller_address: address,
        price: u64,
        timestamp: u64,
    }

    struct AdminDepositedForUser has copy, drop {
        admin_address: address,
        user_address: address,
        amount: u64,
        token_type: 0x1::string::String,
        timestamp: u64,
    }

    struct AdminWithdrewForUser has copy, drop {
        admin_address: address,
        user_address: address,
        recipient_address: address,
        amount: u64,
        token_type: 0x1::string::String,
        timestamp: u64,
    }

    struct UserVaultCreated has copy, drop {
        vault_id: 0x2::object::ID,
        owner: address,
        timestamp: u64,
    }

    struct TokenDeposited has copy, drop {
        vault_id: 0x2::object::ID,
        owner: address,
        amount: u64,
        token_type: 0x1::string::String,
        timestamp: u64,
    }

    struct TokenWithdrawn has copy, drop {
        vault_id: 0x2::object::ID,
        owner: address,
        recipient: address,
        amount: u64,
        token_type: 0x1::string::String,
        timestamp: u64,
    }

    struct AddressRegistered has copy, drop {
        address: address,
        registered_by: address,
        timestamp: u64,
    }

    struct UserBoughtNFT has copy, drop {
        nft_id: 0x2::object::ID,
        user_address: address,
        project_id: 0x1::string::String,
        villa_id: 0x1::string::String,
        payment_amount: u64,
        timestamp: u64,
    }

    struct MintingStatusChanged has copy, drop {
        is_enabled: bool,
        changed_by: address,
        timestamp: u64,
    }

    public fun add_admin(arg0: &mut SuperAdminRegistry, arg1: &RolePermissionRegistry, arg2: address, arg3: 0x1::string::String, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.super_admin == 0x2::tx_context::sender(arg5), 23);
        assert!(!0x2::table::contains<address, AdminInfo>(&arg0.admins, arg2), 25);
        assert!(0x2::table::contains<0x1::string::String, vector<0x1::string::String>>(&arg1.roles, arg3), 27);
        let v0 = AdminInfo{
            address       : arg2,
            role          : arg3,
            permissions   : *0x2::table::borrow<0x1::string::String, vector<0x1::string::String>>(&arg1.roles, arg3),
            granted_by    : 0x2::tx_context::sender(arg5),
            granted_at    : 0x2::clock::timestamp_ms(arg4),
            is_active     : true,
            last_activity : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::table::add<address, AdminInfo>(&mut arg0.admins, arg2, v0);
        arg0.total_admins = arg0.total_admins + 1;
        let v1 = AdminAdded{
            admin_address : arg2,
            role          : arg3,
            granted_by    : 0x2::tx_context::sender(arg5),
            timestamp     : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<AdminAdded>(v1);
    }

    public fun admin_deposit_sui_for_user(arg0: &mut SuperAdminRegistry, arg1: &mut UserVault, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::table::contains<address, AdminInfo>(&arg0.admins, v0), 24);
        let v1 = 0x2::table::borrow<address, AdminInfo>(&arg0.admins, v0);
        assert!(v1.is_active, 24);
        let v2 = false;
        let v3 = 0;
        while (v3 < 0x1::vector::length<0x1::string::String>(&v1.permissions)) {
            let v4 = 0x1::string::utf8(b"ADMIN_DEPOSIT_FOR_USER");
            if (0x1::vector::borrow<0x1::string::String>(&v1.permissions, v3) == &v4) {
                v2 = true;
                break
            };
            v3 = v3 + 1;
        };
        assert!(v2, 28);
        arg1.updated_at = 0x2::clock::timestamp_ms(arg2);
        let v5 = 0;
        let v6 = AdminDepositedForUser{
            admin_address : v0,
            user_address  : arg1.owner,
            amount        : v5,
            token_type    : 0x1::string::utf8(b"SUI"),
            timestamp     : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<AdminDepositedForUser>(v6);
        let v7 = TokenDeposited{
            vault_id   : 0x2::object::uid_to_inner(&arg1.id),
            owner      : arg1.owner,
            amount     : v5,
            token_type : 0x1::string::utf8(b"SUI"),
            timestamp  : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<TokenDeposited>(v7);
    }

    public fun admin_deposit_usdc_for_user(arg0: &mut SuperAdminRegistry, arg1: &mut UserVault, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::table::contains<address, AdminInfo>(&arg0.admins, v0), 24);
        let v1 = 0x2::table::borrow<address, AdminInfo>(&arg0.admins, v0);
        assert!(v1.is_active, 24);
        let v2 = false;
        let v3 = 0;
        while (v3 < 0x1::vector::length<0x1::string::String>(&v1.permissions)) {
            let v4 = 0x1::string::utf8(b"ADMIN_DEPOSIT_FOR_USER");
            if (0x1::vector::borrow<0x1::string::String>(&v1.permissions, v3) == &v4) {
                v2 = true;
                break
            };
            v3 = v3 + 1;
        };
        assert!(v2, 28);
        arg1.updated_at = 0x2::clock::timestamp_ms(arg2);
        let v5 = 0;
        let v6 = AdminDepositedForUser{
            admin_address : v0,
            user_address  : arg1.owner,
            amount        : v5,
            token_type    : 0x1::string::utf8(b"USDC"),
            timestamp     : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<AdminDepositedForUser>(v6);
        let v7 = TokenDeposited{
            vault_id   : 0x2::object::uid_to_inner(&arg1.id),
            owner      : arg1.owner,
            amount     : v5,
            token_type : 0x1::string::utf8(b"USDC"),
            timestamp  : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<TokenDeposited>(v7);
    }

    public fun admin_mint_for_admin(arg0: &mut SuperAdminRegistry, arg1: &mut VillaProject, arg2: &mut VillaMetadata, arg3: &AffiliateConfig, arg4: &TreasuryConfig, arg5: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg6: u64, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : VillaShareNFT {
        assert!(0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg5) >= arg6, 30);
        let v0 = 0x2::tx_context::sender(arg11);
        assert!(0x2::table::contains<address, AdminInfo>(&arg0.admins, v0), 24);
        let v1 = 0x2::table::borrow<address, AdminInfo>(&arg0.admins, v0);
        assert!(v1.is_active, 24);
        let v2 = false;
        let v3 = 0;
        while (v3 < 0x1::vector::length<0x1::string::String>(&v1.permissions)) {
            let v4 = 0x1::string::utf8(b"ADMIN_MINT_FOR_ADMIN");
            if (0x1::vector::borrow<0x1::string::String>(&v1.permissions, v3) == &v4) {
                v2 = true;
                break
            };
            v3 = v3 + 1;
        };
        assert!(v2, 28);
        assert!(arg2.shares_issued < arg2.max_shares, 10);
        assert!(arg1.total_shares_issued < arg1.max_total_shares, 9);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(arg5, arg4.treasury_address);
        let v5 = 0x2::object::new(arg11);
        let v6 = VillaShareNFT{
            id                  : v5,
            project_id          : arg1.project_id,
            villa_id            : arg2.villa_id,
            owner               : v0,
            affiliate_code      : generate_affiliate_code(v0, arg3, arg10, arg11),
            is_affiliate_active : true,
            created_at          : 0x2::clock::timestamp_ms(arg10),
            name                : arg7,
            description         : arg8,
            image_url           : arg9,
            price               : arg2.price_per_share,
            is_listed           : false,
            listing_price       : 0,
        };
        arg2.shares_issued = arg2.shares_issued + 1;
        arg2.updated_at = 0x2::clock::timestamp_ms(arg10);
        arg1.total_shares_issued = arg1.total_shares_issued + 1;
        arg1.updated_at = 0x2::clock::timestamp_ms(arg10);
        let v7 = AdminMintedForAdmin{
            nft_id        : 0x2::object::uid_to_inner(&v6.id),
            admin_address : v0,
            timestamp     : 0x2::clock::timestamp_ms(arg10),
        };
        0x2::event::emit<AdminMintedForAdmin>(v7);
        let v8 = VillaSharesMinted{
            project_id          : arg1.project_id,
            villa_id            : arg2.villa_id,
            amount              : 1,
            total_shares_issued : arg2.shares_issued,
            created_at          : 0x2::clock::timestamp_ms(arg10),
            nft_name            : arg7,
            nft_description     : arg8,
            nft_image_url       : arg9,
            nft_price           : arg2.price_per_share,
        };
        0x2::event::emit<VillaSharesMinted>(v8);
        v6
    }

    public fun admin_mint_for_user(arg0: &mut SuperAdminRegistry, arg1: address, arg2: &mut VillaProject, arg3: &mut VillaMetadata, arg4: &AffiliateConfig, arg5: &TreasuryConfig, arg6: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg7: u64, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: 0x1::string::String, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : VillaShareNFT {
        assert!(0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg6) >= arg7, 30);
        let v0 = 0x2::tx_context::sender(arg12);
        assert!(0x2::table::contains<address, AdminInfo>(&arg0.admins, v0), 24);
        let v1 = 0x2::table::borrow<address, AdminInfo>(&arg0.admins, v0);
        assert!(v1.is_active, 24);
        let v2 = false;
        let v3 = 0;
        while (v3 < 0x1::vector::length<0x1::string::String>(&v1.permissions)) {
            let v4 = 0x1::string::utf8(b"ADMIN_MINT_FOR_USER");
            if (0x1::vector::borrow<0x1::string::String>(&v1.permissions, v3) == &v4) {
                v2 = true;
                break
            };
            v3 = v3 + 1;
        };
        assert!(v2, 28);
        assert!(arg3.shares_issued < arg3.max_shares, 10);
        assert!(arg2.total_shares_issued < arg2.max_total_shares, 9);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(arg6, arg5.treasury_address);
        let v5 = 0x2::object::new(arg12);
        let v6 = VillaShareNFT{
            id                  : v5,
            project_id          : arg2.project_id,
            villa_id            : arg3.villa_id,
            owner               : arg1,
            affiliate_code      : generate_affiliate_code(arg1, arg4, arg11, arg12),
            is_affiliate_active : true,
            created_at          : 0x2::clock::timestamp_ms(arg11),
            name                : arg8,
            description         : arg9,
            image_url           : arg10,
            price               : arg3.price_per_share,
            is_listed           : false,
            listing_price       : 0,
        };
        arg3.shares_issued = arg3.shares_issued + 1;
        arg3.updated_at = 0x2::clock::timestamp_ms(arg11);
        arg2.total_shares_issued = arg2.total_shares_issued + 1;
        arg2.updated_at = 0x2::clock::timestamp_ms(arg11);
        let v7 = AdminMintedForUser{
            nft_id        : 0x2::object::uid_to_inner(&v6.id),
            admin_address : v0,
            user_address  : arg1,
            timestamp     : 0x2::clock::timestamp_ms(arg11),
        };
        0x2::event::emit<AdminMintedForUser>(v7);
        let v8 = VillaSharesMinted{
            project_id          : arg2.project_id,
            villa_id            : arg3.villa_id,
            amount              : 1,
            total_shares_issued : arg3.shares_issued,
            created_at          : 0x2::clock::timestamp_ms(arg11),
            nft_name            : arg8,
            nft_description     : arg9,
            nft_image_url       : arg10,
            nft_price           : arg3.price_per_share,
        };
        0x2::event::emit<VillaSharesMinted>(v8);
        v6
    }

    public fun admin_transfer_for_user(arg0: &mut SuperAdminRegistry, arg1: VillaShareNFT, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : VillaShareNFT {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0x2::table::contains<address, AdminInfo>(&arg0.admins, v0), 24);
        let v1 = 0x2::table::borrow<address, AdminInfo>(&arg0.admins, v0);
        assert!(v1.is_active, 24);
        let v2 = false;
        let v3 = 0;
        while (v3 < 0x1::vector::length<0x1::string::String>(&v1.permissions)) {
            let v4 = 0x1::string::utf8(b"ADMIN_TRANSFER_FOR_USER");
            if (0x1::vector::borrow<0x1::string::String>(&v1.permissions, v3) == &v4) {
                v2 = true;
                break
            };
            v3 = v3 + 1;
        };
        assert!(v2, 28);
        arg1.owner = arg2;
        let v5 = AdminTransferredForUser{
            nft_id        : 0x2::object::uid_to_inner(&arg1.id),
            admin_address : v0,
            from_address  : arg1.owner,
            to_address    : arg2,
            timestamp     : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<AdminTransferredForUser>(v5);
        arg1
    }

    public fun admin_transfer_for_user_with_validation(arg0: &mut SuperAdminRegistry, arg1: &mut VillaShareNFT, arg2: address, arg3: address, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(0x2::table::contains<address, AdminInfo>(&arg0.admins, v0), 24);
        let v1 = 0x2::table::borrow<address, AdminInfo>(&arg0.admins, v0);
        assert!(v1.is_active, 24);
        let v2 = false;
        let v3 = 0;
        while (v3 < 0x1::vector::length<0x1::string::String>(&v1.permissions)) {
            let v4 = 0x1::string::utf8(b"ADMIN_TRANSFER_FOR_USER");
            if (0x1::vector::borrow<0x1::string::String>(&v1.permissions, v3) == &v4) {
                v2 = true;
                break
            };
            v3 = v3 + 1;
        };
        assert!(v2, 28);
        assert!(arg1.owner == arg2, 34);
        arg1.owner = arg3;
        let v5 = AdminTransferredForUser{
            nft_id        : 0x2::object::uid_to_inner(&arg1.id),
            admin_address : v0,
            from_address  : arg2,
            to_address    : arg3,
            timestamp     : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<AdminTransferredForUser>(v5);
    }

    public fun admin_withdraw_sui_for_user(arg0: &mut SuperAdminRegistry, arg1: &mut UserVault, arg2: u64, arg3: address, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(0x2::table::contains<address, AdminInfo>(&arg0.admins, v0), 24);
        let v1 = 0x2::table::borrow<address, AdminInfo>(&arg0.admins, v0);
        assert!(v1.is_active, 24);
        let v2 = false;
        let v3 = 0;
        while (v3 < 0x1::vector::length<0x1::string::String>(&v1.permissions)) {
            let v4 = 0x1::string::utf8(b"ADMIN_WITHDRAW_FOR_USER");
            if (0x1::vector::borrow<0x1::string::String>(&v1.permissions, v3) == &v4) {
                v2 = true;
                break
            };
            v3 = v3 + 1;
        };
        assert!(v2, 28);
        assert!(arg1.owner == arg3, 34);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg1.sui_balance) >= arg2, 29);
        arg1.updated_at = 0x2::clock::timestamp_ms(arg4);
        let v5 = AdminWithdrewForUser{
            admin_address     : v0,
            user_address      : arg1.owner,
            recipient_address : arg3,
            amount            : arg2,
            token_type        : 0x1::string::utf8(b"SUI"),
            timestamp         : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<AdminWithdrewForUser>(v5);
        let v6 = TokenWithdrawn{
            vault_id   : 0x2::object::uid_to_inner(&arg1.id),
            owner      : arg1.owner,
            recipient  : arg3,
            amount     : arg2,
            token_type : 0x1::string::utf8(b"SUI"),
            timestamp  : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<TokenWithdrawn>(v6);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.sui_balance, arg2), arg5)
    }

    public fun admin_withdraw_usdc_for_user(arg0: &mut SuperAdminRegistry, arg1: &mut UserVault, arg2: u64, arg3: address, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC> {
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(0x2::table::contains<address, AdminInfo>(&arg0.admins, v0), 24);
        let v1 = 0x2::table::borrow<address, AdminInfo>(&arg0.admins, v0);
        assert!(v1.is_active, 24);
        let v2 = false;
        let v3 = 0;
        while (v3 < 0x1::vector::length<0x1::string::String>(&v1.permissions)) {
            let v4 = 0x1::string::utf8(b"ADMIN_WITHDRAW_FOR_USER");
            if (0x1::vector::borrow<0x1::string::String>(&v1.permissions, v3) == &v4) {
                v2 = true;
                break
            };
            v3 = v3 + 1;
        };
        assert!(v2, 28);
        assert!(arg1.owner == arg3, 34);
        assert!(0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg1.usdc_balance) >= arg2, 29);
        arg1.updated_at = 0x2::clock::timestamp_ms(arg4);
        let v5 = AdminWithdrewForUser{
            admin_address     : v0,
            user_address      : arg1.owner,
            recipient_address : arg3,
            amount            : arg2,
            token_type        : 0x1::string::utf8(b"USDC"),
            timestamp         : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<AdminWithdrewForUser>(v5);
        let v6 = TokenWithdrawn{
            vault_id   : 0x2::object::uid_to_inner(&arg1.id),
            owner      : arg1.owner,
            recipient  : arg3,
            amount     : arg2,
            token_type : 0x1::string::utf8(b"USDC"),
            timestamp  : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<TokenWithdrawn>(v6);
        0x2::coin::from_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x2::balance::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg1.usdc_balance, arg2), arg5)
    }

    public fun claim_affiliate_reward(arg0: &mut AffiliateReward, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 1);
        let v0 = arg0.pending_amount;
        arg0.total_paid = arg0.total_paid + v0;
        arg0.pending_amount = 0;
        arg0.updated_at = 0x2::clock::timestamp_ms(arg1);
        let v1 = CommissionPaid{
            recipient : arg0.owner,
            amount    : v0,
            timestamp : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<CommissionPaid>(v1);
        v0
    }

    public fun claim_app_commission(arg0: &AppCap, arg1: &mut AppTreasury, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = arg1.pending_amount;
        arg1.total_paid = arg1.total_paid + v0;
        arg1.pending_amount = 0;
        arg1.updated_at = 0x2::clock::timestamp_ms(arg2);
        let v1 = CommissionPaid{
            recipient : 0x2::tx_context::sender(arg3),
            amount    : v0,
            timestamp : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<CommissionPaid>(v1);
        v0
    }

    public fun create_admin_delegation(arg0: &mut SuperAdminRegistry, arg1: address, arg2: vector<0x1::string::String>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : AdminDelegationCap {
        assert!(arg0.super_admin == 0x2::tx_context::sender(arg5), 23);
        assert!(0x2::table::contains<address, AdminInfo>(&arg0.admins, arg1), 26);
        assert!(arg3 > 0x2::clock::timestamp_ms(arg4), 15);
        let v0 = AdminDelegationCap{
            id            : 0x2::object::new(arg5),
            admin_address : arg1,
            delegated_by  : 0x2::tx_context::sender(arg5),
            expires_at    : arg3,
            permissions   : arg2,
        };
        let v1 = AdminDelegationCreated{
            admin_address : arg1,
            delegated_by  : 0x2::tx_context::sender(arg5),
            permissions   : v0.permissions,
            expires_at    : arg3,
            timestamp     : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<AdminDelegationCreated>(v1);
        v0
    }

    public fun create_affiliate_reward(arg0: &AppCap, arg1: 0x1::string::String, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : AffiliateReward {
        AffiliateReward{
            id             : 0x2::object::new(arg4),
            affiliate_code : arg1,
            owner          : arg2,
            total_earned   : 0,
            total_paid     : 0,
            pending_amount : 0,
            created_at     : 0x2::clock::timestamp_ms(arg3),
            updated_at     : 0x2::clock::timestamp_ms(arg3),
        }
    }

    public fun create_and_transfer_display(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) : 0x2::display::Display<VillaShareNFT> {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_id"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"villa_id"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://app.thehistorymaker.io"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{owner}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{project_id}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{villa_id}"));
        let v4 = 0x2::display::new_with_fields<VillaShareNFT>(arg0, v0, v2, arg1);
        0x2::display::update_version<VillaShareNFT>(&mut v4);
        v4
    }

    public fun create_app_cap_for_address(arg0: &AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : AppCap {
        AppCap{
            id          : 0x2::object::new(arg2),
            app_address : arg1,
        }
    }

    public fun create_app_treasury(arg0: &AppCap, arg1: 0x1::string::String, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : AppTreasury {
        AppTreasury{
            id             : 0x2::object::new(arg3),
            project_id     : arg1,
            total_earned   : 0,
            total_paid     : 0,
            pending_amount : 0,
            created_at     : 0x2::clock::timestamp_ms(arg2),
            updated_at     : 0x2::clock::timestamp_ms(arg2),
        }
    }

    public fun create_shared_app_cap(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        abort 28
    }

    public fun create_treasury_config(arg0: &AdminCap, arg1: address, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : TreasuryConfig {
        TreasuryConfig{
            id               : 0x2::object::new(arg3),
            treasury_address : arg1,
            admin_address    : 0x2::tx_context::sender(arg3),
            created_at       : 0x2::clock::timestamp_ms(arg2),
            updated_at       : 0x2::clock::timestamp_ms(arg2),
        }
    }

    public fun create_user_vault(arg0: address, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : UserVault {
        let v0 = UserVault{
            id           : 0x2::object::new(arg2),
            owner        : arg0,
            sui_balance  : 0x2::balance::zero<0x2::sui::SUI>(),
            usdc_balance : 0x2::balance::zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(),
            created_at   : 0x2::clock::timestamp_ms(arg1),
            updated_at   : 0x2::clock::timestamp_ms(arg1),
        };
        let v1 = UserVaultCreated{
            vault_id  : 0x2::object::uid_to_inner(&v0.id),
            owner     : arg0,
            timestamp : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<UserVaultCreated>(v1);
        v0
    }

    public fun create_villa_metadata(arg0: &AppCap, arg1: &SuperAdminRegistry, arg2: &mut VillaProject, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: u64, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : VillaMetadata {
        let v0 = 0x2::tx_context::sender(arg11);
        assert!(0x2::table::contains<address, AdminInfo>(&arg1.admins, v0), 24);
        let v1 = 0x2::table::borrow<address, AdminInfo>(&arg1.admins, v0);
        assert!(v1.is_active, 24);
        let v2 = false;
        let v3 = 0;
        while (v3 < 0x1::vector::length<0x1::string::String>(&v1.permissions)) {
            let v4 = 0x1::string::utf8(b"VILLA_MANAGEMENT");
            if (0x1::vector::borrow<0x1::string::String>(&v1.permissions, v3) == &v4) {
                v2 = true;
                break
            };
            v3 = v3 + 1;
        };
        assert!(v2, 28);
        assert!(arg8 > 0, 11);
        assert!(arg9 > 0, 12);
        assert!(arg2.total_shares_issued + arg8 <= arg2.max_total_shares, 9);
        let v5 = VillaMetadata{
            id              : 0x2::object::new(arg11),
            project_id      : arg2.project_id,
            villa_id        : arg3,
            name            : arg4,
            description     : arg5,
            image_url       : arg6,
            location        : arg7,
            max_shares      : arg8,
            shares_issued   : 0,
            price_per_share : arg9,
            created_at      : 0x2::clock::timestamp_ms(arg10),
            updated_at      : 0x2::clock::timestamp_ms(arg10),
        };
        arg2.total_villas = arg2.total_villas + 1;
        arg2.updated_at = 0x2::clock::timestamp_ms(arg10);
        let v6 = VillaMetadataCreated{
            project_id : arg2.project_id,
            villa_id   : v5.villa_id,
            name       : v5.name,
            max_shares : v5.max_shares,
            created_at : v5.created_at,
        };
        0x2::event::emit<VillaMetadataCreated>(v6);
        v5
    }

    public fun create_villa_metadata_with_admin(arg0: &AdminCap, arg1: &mut VillaProject, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : VillaMetadata {
        assert!(arg7 > 0, 11);
        assert!(arg8 > 0, 17);
        assert!(arg1.total_shares_issued + arg7 <= arg1.max_total_shares, 18);
        let v0 = VillaMetadata{
            id              : 0x2::object::new(arg10),
            project_id      : arg1.project_id,
            villa_id        : arg2,
            name            : arg3,
            description     : arg4,
            image_url       : arg6,
            location        : arg5,
            max_shares      : arg7,
            shares_issued   : 0,
            price_per_share : arg8,
            created_at      : 0x2::clock::timestamp_ms(arg9),
            updated_at      : 0x2::clock::timestamp_ms(arg9),
        };
        arg1.total_villas = arg1.total_villas + 1;
        arg1.total_shares_issued = arg1.total_shares_issued + arg7;
        arg1.updated_at = 0x2::clock::timestamp_ms(arg9);
        let v1 = VillaMetadataCreated{
            project_id : arg1.project_id,
            villa_id   : v0.villa_id,
            name       : v0.name,
            max_shares : v0.max_shares,
            created_at : v0.created_at,
        };
        0x2::event::emit<VillaMetadataCreated>(v1);
        v0
    }

    public fun create_villa_project(arg0: &AppCap, arg1: &SuperAdminRegistry, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : VillaProject {
        let v0 = 0x2::tx_context::sender(arg9);
        assert!(0x2::table::contains<address, AdminInfo>(&arg1.admins, v0), 24);
        let v1 = 0x2::table::borrow<address, AdminInfo>(&arg1.admins, v0);
        assert!(v1.is_active, 24);
        let v2 = false;
        let v3 = 0;
        while (v3 < 0x1::vector::length<0x1::string::String>(&v1.permissions)) {
            let v4 = 0x1::string::utf8(b"PROJECT_MANAGEMENT");
            if (0x1::vector::borrow<0x1::string::String>(&v1.permissions, v3) == &v4) {
                v2 = true;
                break
            };
            v3 = v3 + 1;
        };
        assert!(v2, 28);
        assert!(arg5 > 0, 11);
        assert!(arg6 <= 10000, 33);
        assert!(arg7 <= 10000, 33);
        let v5 = VillaProject{
            id                  : 0x2::object::new(arg9),
            project_id          : arg2,
            name                : arg3,
            description         : arg4,
            total_villas        : 0,
            max_total_shares    : arg5,
            total_shares_issued : 0,
            commission_rate     : arg6,
            affiliate_rate      : arg7,
            created_at          : 0x2::clock::timestamp_ms(arg8),
            updated_at          : 0x2::clock::timestamp_ms(arg8),
        };
        let v6 = VillaProjectCreated{
            project_id       : v5.project_id,
            name             : v5.name,
            max_total_shares : v5.max_total_shares,
            created_at       : v5.created_at,
        };
        0x2::event::emit<VillaProjectCreated>(v6);
        v5
    }

    public fun create_villa_project_with_admin(arg0: &AdminCap, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : VillaProject {
        assert!(arg4 > 0, 11);
        assert!(arg5 <= 10000, 33);
        assert!(arg6 <= 10000, 33);
        let v0 = VillaProject{
            id                  : 0x2::object::new(arg8),
            project_id          : arg1,
            name                : arg2,
            description         : arg3,
            total_villas        : 0,
            max_total_shares    : arg4,
            total_shares_issued : 0,
            commission_rate     : arg5,
            affiliate_rate      : arg6,
            created_at          : 0x2::clock::timestamp_ms(arg7),
            updated_at          : 0x2::clock::timestamp_ms(arg7),
        };
        let v1 = VillaProjectCreated{
            project_id       : v0.project_id,
            name             : v0.name,
            max_total_shares : v0.max_total_shares,
            created_at       : v0.created_at,
        };
        0x2::event::emit<VillaProjectCreated>(v1);
        v0
    }

    fun generate_affiliate_code(arg0: address, arg1: &AffiliateConfig, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x1::string::String {
        0x1::string::utf8(b"")
    }

    public fun get_address_info(arg0: &AddressRegistry, arg1: address) : (address, u64, bool, u64) {
        assert!(0x2::table::contains<address, AddressInfo>(&arg0.addresses, arg1), 31);
        let v0 = 0x2::table::borrow<address, AddressInfo>(&arg0.addresses, arg1);
        (v0.registered_by, v0.registered_at, v0.is_active, v0.last_activity)
    }

    public fun get_admin_info(arg0: &SuperAdminRegistry, arg1: address) : (0x1::string::String, vector<0x1::string::String>, address, u64, bool, u64) {
        assert!(0x2::table::contains<address, AdminInfo>(&arg0.admins, arg1), 26);
        let v0 = 0x2::table::borrow<address, AdminInfo>(&arg0.admins, arg1);
        (v0.role, v0.permissions, v0.granted_by, v0.granted_at, v0.is_active, v0.last_activity)
    }

    public fun get_affiliate_reward_info(arg0: &AffiliateReward) : (0x1::string::String, address, u64, u64, u64) {
        (arg0.affiliate_code, arg0.owner, arg0.total_earned, arg0.total_paid, arg0.pending_amount)
    }

    public fun get_all_admins(arg0: &SuperAdminRegistry) : vector<address> {
        let v0 = 0;
        while (v0 < arg0.total_admins) {
            v0 = v0 + 1;
        };
        0x1::vector::empty<address>()
    }

    public fun get_all_registered_addresses(arg0: &AddressRegistry) : vector<address> {
        let v0 = 0;
        while (v0 < arg0.total_addresses) {
            v0 = v0 + 1;
        };
        0x1::vector::empty<address>()
    }

    public fun get_app_treasury_info(arg0: &AppTreasury) : (0x1::string::String, u64, u64, u64) {
        (arg0.project_id, arg0.total_earned, arg0.total_paid, arg0.pending_amount)
    }

    public fun get_description(arg0: &VillaShareNFT) : &0x1::string::String {
        &arg0.description
    }

    public fun get_image_url(arg0: &VillaShareNFT) : &0x1::string::String {
        &arg0.image_url
    }

    public fun get_listing_price(arg0: &VillaShareNFT) : u64 {
        arg0.listing_price
    }

    public fun get_metadata(arg0: &VillaShareNFT) : (0x1::string::String, 0x1::string::String, 0x1::string::String) {
        (arg0.name, arg0.description, arg0.image_url)
    }

    public fun get_minting_enabled(arg0: &MintingConfig) : bool {
        arg0.is_enabled
    }

    public fun get_name(arg0: &VillaShareNFT) : &0x1::string::String {
        &arg0.name
    }

    public fun get_owner(arg0: &VillaShareNFT) : address {
        arg0.owner
    }

    public fun get_price(arg0: &VillaShareNFT) : u64 {
        arg0.price
    }

    public fun get_project_info(arg0: &VillaProject) : (0x1::string::String, 0x1::string::String, u64, u64, u64) {
        (arg0.project_id, arg0.name, arg0.total_villas, arg0.max_total_shares, arg0.total_shares_issued)
    }

    public fun get_share_nft_info(arg0: &VillaShareNFT) : (0x1::string::String, 0x1::string::String, address, 0x1::string::String, bool) {
        (arg0.project_id, arg0.villa_id, arg0.owner, arg0.affiliate_code, arg0.is_affiliate_active)
    }

    public fun get_super_admin(arg0: &SuperAdminRegistry) : address {
        arg0.super_admin
    }

    public fun get_total_admins(arg0: &SuperAdminRegistry) : u64 {
        arg0.total_admins
    }

    public fun get_total_registered_addresses(arg0: &AddressRegistry) : u64 {
        arg0.total_addresses
    }

    public fun get_user_vault_balance(arg0: &UserVault) : (u64, u64) {
        (0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance), 0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg0.usdc_balance))
    }

    public fun get_user_vault_owner(arg0: &UserVault) : address {
        arg0.owner
    }

    public fun get_villa_info(arg0: &VillaMetadata) : (0x1::string::String, 0x1::string::String, u64, u64, u64) {
        (arg0.villa_id, arg0.name, arg0.max_shares, arg0.shares_issued, arg0.price_per_share)
    }

    public fun grant_admin_permission(arg0: &mut SuperAdminRegistry, arg1: address, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.super_admin == 0x2::tx_context::sender(arg4), 23);
        assert!(0x2::table::contains<address, AdminInfo>(&arg0.admins, arg1), 26);
        let v0 = 0x2::table::borrow_mut<address, AdminInfo>(&mut arg0.admins, arg1);
        let v1 = 0;
        let v2 = false;
        while (v1 < 0x1::vector::length<0x1::string::String>(&v0.permissions)) {
            if (0x1::vector::borrow<0x1::string::String>(&v0.permissions, v1) == &arg2) {
                v2 = true;
                break
            };
            v1 = v1 + 1;
        };
        if (!v2) {
            0x1::vector::push_back<0x1::string::String>(&mut v0.permissions, arg2);
            v0.last_activity = 0x2::clock::timestamp_ms(arg3);
            let v3 = AdminPermissionGranted{
                admin_address : arg1,
                permission    : arg2,
                granted_by    : 0x2::tx_context::sender(arg4),
                timestamp     : 0x2::clock::timestamp_ms(arg3),
            };
            0x2::event::emit<AdminPermissionGranted>(v3);
        };
    }

    fun init(arg0: VILLA_DNFT, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<VILLA_DNFT>(arg0, arg1);
        let v0 = AppCap{
            id          : 0x2::object::new(arg1),
            app_address : 0x2::tx_context::sender(arg1),
        };
        0x2::transfer::transfer<AppCap>(v0, 0x2::tx_context::sender(arg1));
        let v1 = AdminCap{
            id          : 0x2::object::new(arg1),
            app_address : 0x2::tx_context::sender(arg1),
        };
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg1));
        let v2 = AssetManagerCap{
            id          : 0x2::object::new(arg1),
            app_address : 0x2::tx_context::sender(arg1),
        };
        0x2::transfer::transfer<AssetManagerCap>(v2, 0x2::tx_context::sender(arg1));
        let v3 = SuperAdminRegistry{
            id           : 0x2::object::new(arg1),
            super_admin  : 0x2::tx_context::sender(arg1),
            admins       : 0x2::table::new<address, AdminInfo>(arg1),
            total_admins : 0,
            created_at   : 0,
        };
        let v4 = 0x1::vector::empty<0x1::string::String>();
        let v5 = &mut v4;
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"ADMIN_MANAGEMENT"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"ROLE_MANAGEMENT"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"PERMISSION_MANAGEMENT"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"OWNERSHIP_TRANSFER"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"ADMIN_DELEGATION"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"ADMIN_LIST_FOR_USER"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"ADMIN_MINT_FOR_USER"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"ADMIN_MINT_FOR_ADMIN"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"ADMIN_TRANSFER_FOR_USER"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"ADMIN_BUY_FOR_USER"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"ADMIN_DEPOSIT_FOR_USER"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"ADMIN_WITHDRAW_FOR_USER"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"ALL_OPERATIONS"));
        let v6 = AdminInfo{
            address       : 0x2::tx_context::sender(arg1),
            role          : 0x1::string::utf8(b"SUPER_ADMIN"),
            permissions   : v4,
            granted_by    : 0x2::tx_context::sender(arg1),
            granted_at    : 0,
            is_active     : true,
            last_activity : 0,
        };
        0x2::table::add<address, AdminInfo>(&mut v3.admins, 0x2::tx_context::sender(arg1), v6);
        v3.total_admins = 1;
        let v7 = AddressRegistry{
            id              : 0x2::object::new(arg1),
            addresses       : 0x2::table::new<address, AddressInfo>(arg1),
            total_addresses : 0,
            created_at      : 0,
        };
        let v8 = AddressInfo{
            address       : 0x2::tx_context::sender(arg1),
            registered_by : 0x2::tx_context::sender(arg1),
            registered_at : 0,
            is_active     : true,
            last_activity : 0,
        };
        0x2::table::add<address, AddressInfo>(&mut v7.addresses, 0x2::tx_context::sender(arg1), v8);
        v7.total_addresses = 1;
        let v9 = RolePermissionRegistry{
            id    : 0x2::object::new(arg1),
            roles : 0x2::table::new<0x1::string::String, vector<0x1::string::String>>(arg1),
        };
        let v10 = 0x1::vector::empty<0x1::string::String>();
        let v11 = &mut v10;
        0x1::vector::push_back<0x1::string::String>(v11, 0x1::string::utf8(b"ADMIN_MANAGEMENT"));
        0x1::vector::push_back<0x1::string::String>(v11, 0x1::string::utf8(b"ROLE_MANAGEMENT"));
        0x1::vector::push_back<0x1::string::String>(v11, 0x1::string::utf8(b"PERMISSION_MANAGEMENT"));
        0x1::vector::push_back<0x1::string::String>(v11, 0x1::string::utf8(b"OWNERSHIP_TRANSFER"));
        0x1::vector::push_back<0x1::string::String>(v11, 0x1::string::utf8(b"ADMIN_DELEGATION"));
        0x1::vector::push_back<0x1::string::String>(v11, 0x1::string::utf8(b"ADMIN_LIST_FOR_USER"));
        0x1::vector::push_back<0x1::string::String>(v11, 0x1::string::utf8(b"ADMIN_MINT_FOR_USER"));
        0x1::vector::push_back<0x1::string::String>(v11, 0x1::string::utf8(b"ADMIN_MINT_FOR_ADMIN"));
        0x1::vector::push_back<0x1::string::String>(v11, 0x1::string::utf8(b"ADMIN_TRANSFER_FOR_USER"));
        0x1::vector::push_back<0x1::string::String>(v11, 0x1::string::utf8(b"ADMIN_BUY_FOR_USER"));
        0x1::vector::push_back<0x1::string::String>(v11, 0x1::string::utf8(b"ADMIN_DEPOSIT_FOR_USER"));
        0x1::vector::push_back<0x1::string::String>(v11, 0x1::string::utf8(b"ADMIN_WITHDRAW_FOR_USER"));
        0x1::vector::push_back<0x1::string::String>(v11, 0x1::string::utf8(b"ALL_OPERATIONS"));
        0x2::table::add<0x1::string::String, vector<0x1::string::String>>(&mut v9.roles, 0x1::string::utf8(b"SUPER_ADMIN"), v10);
        let v12 = 0x1::vector::empty<0x1::string::String>();
        let v13 = &mut v12;
        0x1::vector::push_back<0x1::string::String>(v13, 0x1::string::utf8(b"PROJECT_MANAGEMENT"));
        0x1::vector::push_back<0x1::string::String>(v13, 0x1::string::utf8(b"VILLA_MANAGEMENT"));
        0x1::vector::push_back<0x1::string::String>(v13, 0x1::string::utf8(b"MINTING"));
        0x1::vector::push_back<0x1::string::String>(v13, 0x1::string::utf8(b"ADMIN_LIST_FOR_USER"));
        0x1::vector::push_back<0x1::string::String>(v13, 0x1::string::utf8(b"ADMIN_MINT_FOR_USER"));
        0x1::vector::push_back<0x1::string::String>(v13, 0x1::string::utf8(b"ADMIN_MINT_FOR_ADMIN"));
        0x1::vector::push_back<0x1::string::String>(v13, 0x1::string::utf8(b"ADMIN_TRANSFER_FOR_USER"));
        0x1::vector::push_back<0x1::string::String>(v13, 0x1::string::utf8(b"ADMIN_BUY_FOR_USER"));
        0x1::vector::push_back<0x1::string::String>(v13, 0x1::string::utf8(b"ADMIN_DEPOSIT_FOR_USER"));
        0x1::vector::push_back<0x1::string::String>(v13, 0x1::string::utf8(b"ADMIN_WITHDRAW_FOR_USER"));
        0x2::table::add<0x1::string::String, vector<0x1::string::String>>(&mut v9.roles, 0x1::string::utf8(b"ADMIN"), v12);
        let v14 = 0x1::vector::empty<0x1::string::String>();
        0x1::vector::push_back<0x1::string::String>(&mut v14, 0x1::string::utf8(b"VILLA_MANAGEMENT"));
        0x2::table::add<0x1::string::String, vector<0x1::string::String>>(&mut v9.roles, 0x1::string::utf8(b"MODERATOR"), v14);
        let v15 = 0x1::vector::empty<0x1::string::String>();
        let v16 = &mut v15;
        0x1::vector::push_back<0x1::string::String>(v16, 0x1::string::utf8(b"VILLA_MANAGEMENT"));
        0x1::vector::push_back<0x1::string::String>(v16, 0x1::string::utf8(b"METADATA_UPDATE"));
        0x2::table::add<0x1::string::String, vector<0x1::string::String>>(&mut v9.roles, 0x1::string::utf8(b"ASSET_MANAGER"), v15);
        0x2::transfer::share_object<SuperAdminRegistry>(v3);
        0x2::transfer::share_object<AddressRegistry>(v7);
        0x2::transfer::share_object<RolePermissionRegistry>(v9);
        let v17 = 0;
        let v18 = AffiliateConfig{
            id             : 0x2::object::new(arg1),
            default_prefix : 0x1::string::utf8(b"AF"),
            current_prefix : 0x1::string::utf8(b"AF"),
            admin_address  : 0x2::tx_context::sender(arg1),
            is_active      : true,
            created_at     : v17,
            updated_at     : v17,
        };
        let v19 = MintingConfig{
            id            : 0x2::object::new(arg1),
            is_enabled    : true,
            admin_address : 0x2::tx_context::sender(arg1),
            created_at    : v17,
            updated_at    : v17,
        };
        0x2::transfer::transfer<AffiliateConfig>(v18, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<MintingConfig>(v19);
    }

    public fun initialize_super_admin_registry(arg0: &mut SuperAdminRegistry, arg1: &0x2::clock::Clock) {
        if (arg0.created_at == 0) {
            arg0.created_at = 0x2::clock::timestamp_ms(arg1);
        };
    }

    public fun is_address_registered(arg0: &AddressRegistry, arg1: address) : bool {
        0x2::table::contains<address, AddressInfo>(&arg0.addresses, arg1)
    }

    public fun is_admin(arg0: &SuperAdminRegistry, arg1: address) : bool {
        0x2::table::contains<address, AdminInfo>(&arg0.admins, arg1)
    }

    public fun is_listed(arg0: &VillaShareNFT) : bool {
        arg0.is_listed
    }

    public fun is_super_admin(arg0: &SuperAdminRegistry, arg1: address) : bool {
        arg0.super_admin == arg1
    }

    public fun register_address(arg0: &mut AddressRegistry, arg1: address, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!0x2::table::contains<address, AddressInfo>(&arg0.addresses, arg1), 25);
        let v0 = AddressInfo{
            address       : arg1,
            registered_by : 0x2::tx_context::sender(arg3),
            registered_at : 0x2::clock::timestamp_ms(arg2),
            is_active     : true,
            last_activity : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::table::add<address, AddressInfo>(&mut arg0.addresses, arg1, v0);
        arg0.total_addresses = arg0.total_addresses + 1;
        let v1 = AddressRegistered{
            address       : arg1,
            registered_by : 0x2::tx_context::sender(arg3),
            timestamp     : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<AddressRegistered>(v1);
    }

    public fun remove_admin(arg0: &mut SuperAdminRegistry, arg1: address, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.super_admin == 0x2::tx_context::sender(arg3), 23);
        assert!(0x2::table::contains<address, AdminInfo>(&arg0.admins, arg1), 26);
        0x2::table::remove<address, AdminInfo>(&mut arg0.admins, arg1);
        arg0.total_admins = arg0.total_admins - 1;
        let v0 = AdminRemoved{
            admin_address : arg1,
            removed_by    : 0x2::tx_context::sender(arg3),
            timestamp     : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<AdminRemoved>(v0);
    }

    public fun revoke_admin_permission(arg0: &mut SuperAdminRegistry, arg1: address, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.super_admin == 0x2::tx_context::sender(arg4), 23);
        assert!(0x2::table::contains<address, AdminInfo>(&arg0.admins, arg1), 26);
        let v0 = 0x2::table::borrow_mut<address, AdminInfo>(&mut arg0.admins, arg1);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::string::String>(&v0.permissions)) {
            if (0x1::vector::borrow<0x1::string::String>(&v0.permissions, v1) == &arg2) {
                0x1::vector::remove<0x1::string::String>(&mut v0.permissions, v1);
                v0.last_activity = 0x2::clock::timestamp_ms(arg3);
                let v2 = AdminPermissionRevoked{
                    admin_address : arg1,
                    permission    : arg2,
                    revoked_by    : 0x2::tx_context::sender(arg4),
                    timestamp     : 0x2::clock::timestamp_ms(arg3),
                };
                0x2::event::emit<AdminPermissionRevoked>(v2);
                break
            };
            v1 = v1 + 1;
        };
    }

    public fun toggle_minting_enabled(arg0: &mut MintingConfig, arg1: &SuperAdminRegistry, arg2: bool, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(arg1.super_admin == v0, 23);
        arg0.is_enabled = arg2;
        arg0.updated_at = 0x2::clock::timestamp_ms(arg3);
        let v1 = MintingStatusChanged{
            is_enabled : arg2,
            changed_by : v0,
            timestamp  : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<MintingStatusChanged>(v1);
    }

    public fun transfer_app_cap_to_address(arg0: &AdminCap, arg1: AppCap, arg2: address) {
        0x2::transfer::transfer<AppCap>(arg1, arg2);
    }

    public fun transfer_ownership(arg0: &mut SuperAdminRegistry, arg1: address, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.super_admin == 0x2::tx_context::sender(arg3), 23);
        arg0.super_admin = arg1;
        let v0 = OwnershipTransferred{
            old_owner : arg0.super_admin,
            new_owner : arg1,
            timestamp : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<OwnershipTransferred>(v0);
    }

    public fun update_admin_role(arg0: &mut SuperAdminRegistry, arg1: &RolePermissionRegistry, arg2: address, arg3: 0x1::string::String, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.super_admin == 0x2::tx_context::sender(arg5), 23);
        assert!(0x2::table::contains<address, AdminInfo>(&arg0.admins, arg2), 26);
        assert!(0x2::table::contains<0x1::string::String, vector<0x1::string::String>>(&arg1.roles, arg3), 27);
        let v0 = 0x2::table::borrow_mut<address, AdminInfo>(&mut arg0.admins, arg2);
        v0.role = arg3;
        v0.permissions = *0x2::table::borrow<0x1::string::String, vector<0x1::string::String>>(&arg1.roles, arg3);
        v0.last_activity = 0x2::clock::timestamp_ms(arg4);
        let v1 = AdminRoleUpdated{
            admin_address : arg2,
            old_role      : v0.role,
            new_role      : arg3,
            updated_by    : 0x2::tx_context::sender(arg5),
            timestamp     : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<AdminRoleUpdated>(v1);
    }

    public fun update_metadata(arg0: &mut VillaShareNFT, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg5), 34);
        arg0.name = arg1;
        arg0.description = arg2;
        arg0.image_url = arg3;
    }

    public fun update_price(arg0: &mut VillaShareNFT, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg3), 34);
        assert!(arg1 > 0, 33);
        arg0.price = arg1;
        if (arg0.is_listed) {
            arg0.listing_price = arg1;
        };
    }

    public fun update_treasury_address(arg0: &AdminCap, arg1: &mut TreasuryConfig, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.admin_address == 0x2::tx_context::sender(arg4), 1);
        arg1.treasury_address = arg2;
        arg1.updated_at = 0x2::clock::timestamp_ms(arg3);
    }

    public fun update_villa_metadata(arg0: &AssetManagerCap, arg1: &mut VillaMetadata, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &0x2::clock::Clock) {
        arg1.image_url = arg2;
        arg1.description = arg3;
        arg1.updated_at = 0x2::clock::timestamp_ms(arg4);
    }

    public fun update_villa_project(arg0: &AppCap, arg1: &mut VillaProject, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock) {
        assert!(arg4 <= 10000, 33);
        assert!(arg5 <= 10000, 33);
        arg1.name = arg2;
        arg1.description = arg3;
        arg1.commission_rate = arg4;
        arg1.affiliate_rate = arg5;
        arg1.updated_at = 0x2::clock::timestamp_ms(arg6);
        let v0 = VillaProjectUpdated{
            project_id          : arg1.project_id,
            old_name            : arg1.name,
            new_name            : arg2,
            old_commission_rate : arg1.commission_rate,
            new_commission_rate : arg4,
            old_affiliate_rate  : arg1.affiliate_rate,
            new_affiliate_rate  : arg5,
            updated_at          : 0x2::clock::timestamp_ms(arg6),
        };
        0x2::event::emit<VillaProjectUpdated>(v0);
    }

    public fun user_buy_nft(arg0: &MintingConfig, arg1: &mut VillaProject, arg2: &mut VillaMetadata, arg3: &AffiliateConfig, arg4: &TreasuryConfig, arg5: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg6: u64, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : VillaShareNFT {
        assert!(arg0.is_enabled, 35);
        let v0 = 0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg5);
        assert!(v0 >= arg6, 30);
        assert!(arg2.shares_issued < arg2.max_shares, 10);
        assert!(arg1.total_shares_issued < arg1.max_total_shares, 9);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(arg5, arg4.treasury_address);
        let v1 = 0x2::tx_context::sender(arg11);
        let v2 = 0x2::object::new(arg11);
        let v3 = VillaShareNFT{
            id                  : v2,
            project_id          : arg1.project_id,
            villa_id            : arg2.villa_id,
            owner               : v1,
            affiliate_code      : generate_affiliate_code(v1, arg3, arg10, arg11),
            is_affiliate_active : true,
            created_at          : 0x2::clock::timestamp_ms(arg10),
            name                : arg7,
            description         : arg8,
            image_url           : arg9,
            price               : arg2.price_per_share,
            is_listed           : false,
            listing_price       : 0,
        };
        arg2.shares_issued = arg2.shares_issued + 1;
        arg2.updated_at = 0x2::clock::timestamp_ms(arg10);
        arg1.total_shares_issued = arg1.total_shares_issued + 1;
        arg1.updated_at = 0x2::clock::timestamp_ms(arg10);
        let v4 = UserBoughtNFT{
            nft_id         : 0x2::object::uid_to_inner(&v3.id),
            user_address   : v1,
            project_id     : arg1.project_id,
            villa_id       : arg2.villa_id,
            payment_amount : v0,
            timestamp      : 0x2::clock::timestamp_ms(arg10),
        };
        0x2::event::emit<UserBoughtNFT>(v4);
        let v5 = VillaSharesMinted{
            project_id          : arg1.project_id,
            villa_id            : arg2.villa_id,
            amount              : 1,
            total_shares_issued : arg2.shares_issued,
            created_at          : 0x2::clock::timestamp_ms(arg10),
            nft_name            : arg7,
            nft_description     : arg8,
            nft_image_url       : arg9,
            nft_price           : arg2.price_per_share,
        };
        0x2::event::emit<VillaSharesMinted>(v5);
        v3
    }

    public fun user_deposit_sui_for_self(arg0: &mut UserVault, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 34);
        arg0.updated_at = 0x2::clock::timestamp_ms(arg1);
        let v0 = TokenDeposited{
            vault_id   : 0x2::object::uid_to_inner(&arg0.id),
            owner      : arg0.owner,
            amount     : 0,
            token_type : 0x1::string::utf8(b"SUI"),
            timestamp  : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<TokenDeposited>(v0);
    }

    public fun user_deposit_usdc_for_self(arg0: &mut UserVault, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 34);
        arg0.updated_at = 0x2::clock::timestamp_ms(arg1);
        let v0 = TokenDeposited{
            vault_id   : 0x2::object::uid_to_inner(&arg0.id),
            owner      : arg0.owner,
            amount     : 0,
            token_type : 0x1::string::utf8(b"USDC"),
            timestamp  : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<TokenDeposited>(v0);
    }

    // decompiled from Move bytecode v6
}

