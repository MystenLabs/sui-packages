module 0xc74bb85fe876880d63c1553a24731596a5e7ea72f48ef144e96a5370e953b86d::villa_dnft {
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

    struct DNFTListing has store, key {
        id: 0x2::object::UID,
        share_nft_id: 0x2::object::ID,
        project_id: 0x1::string::String,
        villa_id: 0x1::string::String,
        seller: address,
        price: u64,
        affiliate_code: 0x1::string::String,
        is_active: bool,
        created_at: u64,
        expires_at: u64,
        nft_name: 0x1::string::String,
        nft_description: 0x1::string::String,
        nft_image_url: 0x1::string::String,
    }

    struct DNFTTrade has store, key {
        id: 0x2::object::UID,
        share_nft_id: 0x2::object::ID,
        project_id: 0x1::string::String,
        villa_id: 0x1::string::String,
        seller: address,
        buyer: address,
        price: u64,
        affiliate_commission: u64,
        app_commission: u64,
        timestamp: u64,
    }

    struct SaleCommission has drop {
        affiliate_commission: u64,
        app_commission: u64,
        total_price: u64,
    }

    struct VillaMarketplace has store, key {
        id: 0x2::object::UID,
        project_id: 0x1::string::String,
        listings: 0x2::table::Table<0x2::object::ID, DNFTListing>,
        trades: 0x2::table::Table<0x2::object::ID, DNFTTrade>,
        commission_rate: u64,
        affiliate_rate: u64,
        created_at: u64,
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

    struct CommissionConfig has store, key {
        id: 0x2::object::UID,
        default_commission_rate: u64,
        current_commission_rate: u64,
        admin_address: address,
        is_active: bool,
        created_at: u64,
        updated_at: u64,
    }

    struct TreasuryBalance has store, key {
        id: 0x2::object::UID,
        sui_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        usdc_balance: 0x2::balance::Balance<USDC>,
        total_commission_earned: u64,
        total_commission_withdrawn: u64,
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
        usdc_balance: 0x2::balance::Balance<USDC>,
        created_at: u64,
        updated_at: u64,
    }

    struct USDC has drop {
        dummy_field: bool,
    }

    struct BatchEscrowConfig has store, key {
        id: 0x2::object::UID,
        max_batch_size: u64,
        default_expiry_hours: u64,
        default_affiliate_active: bool,
        created_at: u64,
        updated_at: u64,
    }

    struct BatchEscrow<phantom T0> has store, key {
        id: 0x2::object::UID,
        buyer: address,
        platform: address,
        total_amount: u64,
        nft_count: u64,
        nft_ids: vector<0x2::object::ID>,
        project_id: 0x1::string::String,
        villa_id: 0x1::string::String,
        created_at: u64,
        expires_at: u64,
        status: u8,
        successful_nfts: u64,
        failed_nfts: u64,
        processed_amount: u64,
        refund_amount: u64,
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

    struct DNFTListed has copy, drop {
        share_nft_id: 0x2::object::ID,
        seller: address,
        price: u64,
        created_at: u64,
    }

    struct DNFTBought has copy, drop {
        share_nft_id: 0x2::object::ID,
        buyer: address,
        seller: address,
        price: u64,
        affiliate_commission: u64,
        app_commission: u64,
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

    struct NFTListed has copy, drop {
        nft_id: 0x2::object::ID,
        owner: address,
        price: u64,
        timestamp: u64,
    }

    struct NFTDelisted has copy, drop {
        nft_id: 0x2::object::ID,
        owner: address,
        timestamp: u64,
    }

    struct NFTTransferred has copy, drop {
        nft_id: 0x2::object::ID,
        from: address,
        to: address,
        timestamp: u64,
    }

    struct PriceUpdated has copy, drop {
        nft_id: 0x2::object::ID,
        old_price: u64,
        new_price: u64,
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

    struct CommissionConfigUpdated has copy, drop {
        admin_address: address,
        old_rate: u64,
        new_rate: u64,
        timestamp: u64,
    }

    struct CommissionCollected has copy, drop {
        seller_address: address,
        buyer_address: address,
        total_price: u64,
        commission_amount: u64,
        seller_received: u64,
        timestamp: u64,
    }

    struct CommissionWithdrawn has copy, drop {
        admin_address: address,
        amount: u64,
        token_type: 0x1::string::String,
        timestamp: u64,
    }

    struct TreasuryBalanceUpdated has copy, drop {
        sui_balance: u64,
        usdc_balance: u64,
        total_earned: u64,
        timestamp: u64,
    }

    struct AffiliateConfigUpdated has copy, drop {
        admin_address: address,
        old_prefix: 0x1::string::String,
        new_prefix: 0x1::string::String,
        timestamp: u64,
    }

    struct BatchEscrowCreated has copy, drop {
        escrow_id: 0x2::object::ID,
        buyer: address,
        platform: address,
        total_amount: u64,
        nft_count: u64,
        project_id: 0x1::string::String,
        villa_id: 0x1::string::String,
        expires_at: u64,
        timestamp: u64,
    }

    struct BatchMintingCompleted has copy, drop {
        escrow_id: 0x2::object::ID,
        buyer: address,
        platform: address,
        total_nfts: u64,
        successful_nfts: u64,
        failed_nfts: u64,
        processed_amount: u64,
        refund_amount: u64,
        timestamp: u64,
    }

    struct BatchEscrowProcessed has copy, drop {
        escrow_id: 0x2::object::ID,
        buyer: address,
        platform: address,
        processed_amount: u64,
        refund_amount: u64,
        successful_nfts: u64,
        failed_nfts: u64,
        timestamp: u64,
    }

    struct BatchEscrowCancelled has copy, drop {
        escrow_id: 0x2::object::ID,
        buyer: address,
        platform: address,
        total_amount: u64,
        nft_count: u64,
        cancel_reason: u8,
        timestamp: u64,
    }

    struct BatchEscrowConfigUpdated has copy, drop {
        admin_address: address,
        max_batch_size: u64,
        default_expiry_hours: u64,
        default_affiliate_active: bool,
        timestamp: u64,
    }

    public fun transfer(arg0: VillaShareNFT, arg1: address, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        arg0.owner = arg1;
        let v0 = NFTTransferred{
            nft_id    : 0x2::object::uid_to_inner(&arg0.id),
            from      : arg0.owner,
            to        : arg1,
            timestamp : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<NFTTransferred>(v0);
        0x2::transfer::public_transfer<VillaShareNFT>(arg0, arg1);
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

    public fun admin_batch_mint_with_escrow(arg0: &mut SuperAdminRegistry, arg1: &mut BatchEscrow<USDC>, arg2: &BatchEscrowConfig, arg3: &mut VillaProject, arg4: &mut VillaMetadata, arg5: &AffiliateConfig, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : vector<VillaShareNFT> {
        let v0 = 0x2::tx_context::sender(arg10);
        assert!(0x2::table::contains<address, AdminInfo>(&arg0.admins, v0), 24);
        assert!(0x2::table::borrow<address, AdminInfo>(&arg0.admins, v0).is_active, 24);
        assert!(arg1.status == 0, 35);
        assert!(0x2::clock::timestamp_ms(arg9) <= arg1.expires_at, 36);
        arg1.status = 1;
        let v1 = 0x1::vector::empty<VillaShareNFT>();
        let v2 = 0x1::vector::empty<0x2::object::ID>();
        let v3 = 0;
        let v4 = 0;
        let v5 = arg4.price_per_share;
        let v6 = 0;
        while (v6 < arg1.nft_count) {
            let v7 = 0x2::object::new(arg10);
            let v8 = VillaShareNFT{
                id                  : v7,
                project_id          : arg3.project_id,
                villa_id            : arg4.villa_id,
                owner               : arg1.buyer,
                affiliate_code      : generate_affiliate_code(arg1.buyer, arg5, arg9, arg10),
                is_affiliate_active : arg2.default_affiliate_active,
                created_at          : 0x2::clock::timestamp_ms(arg9),
                name                : arg6,
                description         : arg7,
                image_url           : arg8,
                price               : v5,
                is_listed           : true,
                listing_price       : v5,
            };
            0x1::vector::push_back<VillaShareNFT>(&mut v1, v8);
            0x1::vector::push_back<0x2::object::ID>(&mut v2, 0x2::object::uid_to_inner(&0x1::vector::borrow<VillaShareNFT>(&v1, v6).id));
            v3 = v3 + 1;
            v6 = v6 + 1;
        };
        arg1.nft_ids = v2;
        arg1.successful_nfts = v3;
        arg1.failed_nfts = v4;
        let v9 = v5 * v3;
        let v10 = arg1.total_amount - v9;
        arg1.processed_amount = v9;
        arg1.refund_amount = v10;
        arg4.shares_issued = arg4.shares_issued + v3;
        arg3.total_shares_issued = arg3.total_shares_issued + v3;
        if (v3 == arg1.nft_count) {
            arg1.status = 2;
        } else if (v3 > 0) {
            arg1.status = 3;
        } else {
            arg1.status = 4;
        };
        let v11 = 0;
        while (v11 < v3) {
            let v12 = VillaSharesMinted{
                project_id          : arg3.project_id,
                villa_id            : arg4.villa_id,
                amount              : 1,
                total_shares_issued : arg4.shares_issued,
                created_at          : 0x2::clock::timestamp_ms(arg9),
                nft_name            : arg6,
                nft_description     : arg7,
                nft_image_url       : arg8,
                nft_price           : v5,
            };
            0x2::event::emit<VillaSharesMinted>(v12);
            v11 = v11 + 1;
        };
        let v13 = BatchMintingCompleted{
            escrow_id        : 0x2::object::uid_to_inner(&arg1.id),
            buyer            : arg1.buyer,
            platform         : v0,
            total_nfts       : arg1.nft_count,
            successful_nfts  : v3,
            failed_nfts      : v4,
            processed_amount : v9,
            refund_amount    : v10,
            timestamp        : 0x2::clock::timestamp_ms(arg9),
        };
        0x2::event::emit<BatchMintingCompleted>(v13);
        v1
    }

    public fun admin_buy_for_user(arg0: &mut SuperAdminRegistry, arg1: &mut VillaMarketplace, arg2: &mut CommissionConfig, arg3: &mut TreasuryBalance, arg4: &AffiliateConfig, arg5: 0x2::object::ID, arg6: address, arg7: 0x2::coin::Coin<0x2::sui::SUI>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : VillaShareNFT {
        let v0 = 0x2::tx_context::sender(arg9);
        assert!(0x2::table::contains<address, AdminInfo>(&arg0.admins, v0), 24);
        let v1 = 0x2::table::borrow<address, AdminInfo>(&arg0.admins, v0);
        assert!(v1.is_active, 24);
        let v2 = false;
        let v3 = 0;
        while (v3 < 0x1::vector::length<0x1::string::String>(&v1.permissions)) {
            let v4 = 0x1::string::utf8(b"ADMIN_BUY_FOR_USER");
            if (0x1::vector::borrow<0x1::string::String>(&v1.permissions, v3) == &v4) {
                v2 = true;
                break
            };
            v3 = v3 + 1;
        };
        assert!(v2, 28);
        let v5 = 0x2::table::remove<0x2::object::ID, DNFTListing>(&mut arg1.listings, arg5);
        assert!(v5.is_active, 14);
        assert!(0x2::clock::timestamp_ms(arg8) <= v5.expires_at, 15);
        let DNFTListing {
            id              : v6,
            share_nft_id    : v7,
            project_id      : v8,
            villa_id        : v9,
            seller          : v10,
            price           : v11,
            affiliate_code  : _,
            is_active       : _,
            created_at      : _,
            expires_at      : _,
            nft_name        : v16,
            nft_description : v17,
            nft_image_url   : v18,
        } = v5;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg7) >= v11, 30);
        let v19 = v11 * arg1.affiliate_rate / 10000;
        let v20 = v11 * arg1.commission_rate / 10000;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg7, v10);
        let v21 = 0x2::object::new(arg9);
        let v22 = generate_affiliate_code(arg6, arg4, arg8, arg9);
        let v23 = VillaShareNFT{
            id                  : v21,
            project_id          : v8,
            villa_id            : v9,
            owner               : arg6,
            affiliate_code      : v22,
            is_affiliate_active : true,
            created_at          : 0x2::clock::timestamp_ms(arg8),
            name                : v16,
            description         : v17,
            image_url           : v18,
            price               : v11,
            is_listed           : false,
            listing_price       : 0,
        };
        let v24 = DNFTTrade{
            id                   : 0x2::object::new(arg9),
            share_nft_id         : v7,
            project_id           : v8,
            villa_id             : v9,
            seller               : v10,
            buyer                : arg6,
            price                : v11,
            affiliate_commission : v19,
            app_commission       : v20,
            timestamp            : 0x2::clock::timestamp_ms(arg8),
        };
        0x2::table::add<0x2::object::ID, DNFTTrade>(&mut arg1.trades, v7, v24);
        0x2::object::delete(v6);
        let v25 = AdminBoughtForUser{
            nft_id         : 0x2::object::uid_to_inner(&v23.id),
            admin_address  : v0,
            buyer_address  : arg6,
            seller_address : v10,
            price          : v11,
            timestamp      : 0x2::clock::timestamp_ms(arg8),
        };
        0x2::event::emit<AdminBoughtForUser>(v25);
        let v26 = DNFTBought{
            share_nft_id         : 0x2::object::uid_to_inner(&v23.id),
            buyer                : arg6,
            seller               : v10,
            price                : v11,
            affiliate_commission : v19,
            app_commission       : v20,
        };
        0x2::event::emit<DNFTBought>(v26);
        v23
    }

    public fun admin_cancel_batch_escrow(arg0: &mut SuperAdminRegistry, arg1: &mut BatchEscrow<USDC>, arg2: u8, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0x2::table::contains<address, AdminInfo>(&arg0.admins, v0), 24);
        assert!(arg1.status == 0 || arg1.status == 1, 35);
        assert!(arg2 >= 1 && arg2 <= 5, 37);
        arg1.status = 5;
        let v1 = BatchEscrowCancelled{
            escrow_id     : 0x2::object::uid_to_inner(&arg1.id),
            buyer         : arg1.buyer,
            platform      : v0,
            total_amount  : arg1.total_amount,
            nft_count     : arg1.nft_count,
            cancel_reason : arg2,
            timestamp     : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<BatchEscrowCancelled>(v1);
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

    public fun admin_list_for_user(arg0: &mut SuperAdminRegistry, arg1: &mut VillaShareNFT, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0x2::table::contains<address, AdminInfo>(&arg0.admins, v0), 24);
        let v1 = 0x2::table::borrow<address, AdminInfo>(&arg0.admins, v0);
        assert!(v1.is_active, 24);
        let v2 = false;
        let v3 = 0;
        while (v3 < 0x1::vector::length<0x1::string::String>(&v1.permissions)) {
            let v4 = 0x1::string::utf8(b"ADMIN_LIST_FOR_USER");
            if (0x1::vector::borrow<0x1::string::String>(&v1.permissions, v3) == &v4) {
                v2 = true;
                break
            };
            v3 = v3 + 1;
        };
        assert!(v2, 28);
        assert!(!arg1.is_listed, 20);
        assert!(arg2 > 0, 21);
        arg1.is_listed = true;
        arg1.listing_price = arg2;
        arg1.price = arg2;
        let v5 = AdminListedForUser{
            nft_id        : 0x2::object::uid_to_inner(&arg1.id),
            admin_address : v0,
            user_address  : arg1.owner,
            price         : arg2,
            timestamp     : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<AdminListedForUser>(v5);
        let v6 = NFTListed{
            nft_id    : 0x2::object::uid_to_inner(&arg1.id),
            owner     : arg1.owner,
            price     : arg2,
            timestamp : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<NFTListed>(v6);
    }

    public fun admin_mint_for_admin(arg0: &mut SuperAdminRegistry, arg1: &mut VillaProject, arg2: &mut VillaMetadata, arg3: &AffiliateConfig, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : VillaShareNFT {
        let v0 = 0x2::tx_context::sender(arg8);
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
        let v5 = 0x2::object::new(arg8);
        let v6 = VillaShareNFT{
            id                  : v5,
            project_id          : arg1.project_id,
            villa_id            : arg2.villa_id,
            owner               : v0,
            affiliate_code      : generate_affiliate_code(v0, arg3, arg7, arg8),
            is_affiliate_active : true,
            created_at          : 0x2::clock::timestamp_ms(arg7),
            name                : arg4,
            description         : arg5,
            image_url           : arg6,
            price               : arg2.price_per_share,
            is_listed           : false,
            listing_price       : 0,
        };
        arg2.shares_issued = arg2.shares_issued + 1;
        arg2.updated_at = 0x2::clock::timestamp_ms(arg7);
        arg1.total_shares_issued = arg1.total_shares_issued + 1;
        arg1.updated_at = 0x2::clock::timestamp_ms(arg7);
        let v7 = AdminMintedForAdmin{
            nft_id        : 0x2::object::uid_to_inner(&v6.id),
            admin_address : v0,
            timestamp     : 0x2::clock::timestamp_ms(arg7),
        };
        0x2::event::emit<AdminMintedForAdmin>(v7);
        let v8 = VillaSharesMinted{
            project_id          : arg1.project_id,
            villa_id            : arg2.villa_id,
            amount              : 1,
            total_shares_issued : arg2.shares_issued,
            created_at          : 0x2::clock::timestamp_ms(arg7),
            nft_name            : arg4,
            nft_description     : arg5,
            nft_image_url       : arg6,
            nft_price           : arg2.price_per_share,
        };
        0x2::event::emit<VillaSharesMinted>(v8);
        v6
    }

    public fun admin_mint_for_user(arg0: &mut SuperAdminRegistry, arg1: address, arg2: &mut VillaProject, arg3: &mut VillaMetadata, arg4: &AffiliateConfig, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : VillaShareNFT {
        let v0 = 0x2::tx_context::sender(arg9);
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
        let v5 = 0x2::object::new(arg9);
        let v6 = VillaShareNFT{
            id                  : v5,
            project_id          : arg2.project_id,
            villa_id            : arg3.villa_id,
            owner               : arg1,
            affiliate_code      : generate_affiliate_code(arg1, arg4, arg8, arg9),
            is_affiliate_active : true,
            created_at          : 0x2::clock::timestamp_ms(arg8),
            name                : arg5,
            description         : arg6,
            image_url           : arg7,
            price               : arg3.price_per_share,
            is_listed           : false,
            listing_price       : 0,
        };
        arg3.shares_issued = arg3.shares_issued + 1;
        arg3.updated_at = 0x2::clock::timestamp_ms(arg8);
        arg2.total_shares_issued = arg2.total_shares_issued + 1;
        arg2.updated_at = 0x2::clock::timestamp_ms(arg8);
        let v7 = AdminMintedForUser{
            nft_id        : 0x2::object::uid_to_inner(&v6.id),
            admin_address : v0,
            user_address  : arg1,
            timestamp     : 0x2::clock::timestamp_ms(arg8),
        };
        0x2::event::emit<AdminMintedForUser>(v7);
        let v8 = VillaSharesMinted{
            project_id          : arg2.project_id,
            villa_id            : arg3.villa_id,
            amount              : 1,
            total_shares_issued : arg3.shares_issued,
            created_at          : 0x2::clock::timestamp_ms(arg8),
            nft_name            : arg5,
            nft_description     : arg6,
            nft_image_url       : arg7,
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
        let v5 = arg1.owner;
        let v6 = 0x2::object::uid_to_inner(&arg1.id);
        arg1.owner = arg2;
        let v7 = AdminTransferredForUser{
            nft_id        : v6,
            admin_address : v0,
            from_address  : v5,
            to_address    : arg2,
            timestamp     : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<AdminTransferredForUser>(v7);
        let v8 = NFTTransferred{
            nft_id    : v6,
            from      : v5,
            to        : arg2,
            timestamp : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<NFTTransferred>(v8);
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
        assert!(arg1.owner == arg2, 22);
        let v5 = 0x2::object::uid_to_inner(&arg1.id);
        arg1.owner = arg3;
        let v6 = AdminTransferredForUser{
            nft_id        : v5,
            admin_address : v0,
            from_address  : arg2,
            to_address    : arg3,
            timestamp     : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<AdminTransferredForUser>(v6);
        let v7 = NFTTransferred{
            nft_id    : v5,
            from      : arg2,
            to        : arg3,
            timestamp : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<NFTTransferred>(v7);
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
        assert!(arg1.owner == arg3, 22);
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

    public fun admin_withdraw_sui_from_treasury(arg0: &CommissionConfig, arg1: &mut TreasuryBalance, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(0x2::tx_context::sender(arg4) == arg0.admin_address, 24);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg1.sui_balance) >= arg2, 32);
        arg1.total_commission_withdrawn = arg1.total_commission_withdrawn + arg2;
        arg1.updated_at = 0x2::clock::timestamp_ms(arg3);
        let v0 = CommissionWithdrawn{
            admin_address : 0x2::tx_context::sender(arg4),
            amount        : arg2,
            token_type    : 0x1::string::utf8(b"SUI"),
            timestamp     : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<CommissionWithdrawn>(v0);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.sui_balance, arg2), arg4)
    }

    public fun admin_withdraw_usdc_for_user(arg0: &mut SuperAdminRegistry, arg1: &mut UserVault, arg2: u64, arg3: address, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<USDC> {
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
        assert!(arg1.owner == arg3, 22);
        assert!(0x2::balance::value<USDC>(&arg1.usdc_balance) >= arg2, 29);
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
        0x2::coin::from_balance<USDC>(0x2::balance::split<USDC>(&mut arg1.usdc_balance, arg2), arg5)
    }

    public fun admin_withdraw_usdc_from_treasury(arg0: &CommissionConfig, arg1: &mut TreasuryBalance, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<USDC> {
        assert!(0x2::tx_context::sender(arg4) == arg0.admin_address, 24);
        assert!(0x2::balance::value<USDC>(&arg1.usdc_balance) >= arg2, 32);
        arg1.total_commission_withdrawn = arg1.total_commission_withdrawn + arg2;
        arg1.updated_at = 0x2::clock::timestamp_ms(arg3);
        let v0 = CommissionWithdrawn{
            admin_address : 0x2::tx_context::sender(arg4),
            amount        : arg2,
            token_type    : 0x1::string::utf8(b"USDC"),
            timestamp     : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<CommissionWithdrawn>(v0);
        0x2::coin::from_balance<USDC>(0x2::balance::split<USDC>(&mut arg1.usdc_balance, arg2), arg4)
    }

    public fun buy_dnft_from_marketplace(arg0: &mut VillaMarketplace, arg1: &mut VillaShareNFT, arg2: &AffiliateConfig, arg3: 0x2::object::ID, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : SaleCommission {
        let v0 = 0x2::table::remove<0x2::object::ID, DNFTListing>(&mut arg0.listings, arg3);
        assert!(v0.is_active, 14);
        assert!(0x2::clock::timestamp_ms(arg5) <= v0.expires_at, 15);
        let DNFTListing {
            id              : v1,
            share_nft_id    : v2,
            project_id      : v3,
            villa_id        : v4,
            seller          : v5,
            price           : v6,
            affiliate_code  : _,
            is_active       : _,
            created_at      : _,
            expires_at      : _,
            nft_name        : _,
            nft_description : _,
            nft_image_url   : _,
        } = v0;
        let v14 = v6 * arg0.affiliate_rate / 10000;
        let v15 = v6 * arg0.commission_rate / 10000;
        let v16 = SaleCommission{
            affiliate_commission : v14,
            app_commission       : v15,
            total_price          : v6,
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg4, v5);
        arg1.owner = 0x2::tx_context::sender(arg6);
        let v17 = 0x2::tx_context::sender(arg6);
        let v18 = generate_affiliate_code(v17, arg2, arg5, arg6);
        arg1.affiliate_code = v18;
        arg1.is_affiliate_active = true;
        arg1.price = v6;
        arg1.is_listed = false;
        arg1.listing_price = 0;
        let v19 = DNFTTrade{
            id                   : 0x2::object::new(arg6),
            share_nft_id         : v2,
            project_id           : v3,
            villa_id             : v4,
            seller               : v5,
            buyer                : 0x2::tx_context::sender(arg6),
            price                : v6,
            affiliate_commission : v14,
            app_commission       : v15,
            timestamp            : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::table::add<0x2::object::ID, DNFTTrade>(&mut arg0.trades, v2, v19);
        0x2::object::delete(v1);
        let v20 = DNFTBought{
            share_nft_id         : 0x2::object::uid_to_inner(&arg1.id),
            buyer                : 0x2::tx_context::sender(arg6),
            seller               : v5,
            price                : v6,
            affiliate_commission : v14,
            app_commission       : v15,
        };
        0x2::event::emit<DNFTBought>(v20);
        v16
    }

    public fun calculate_commission_amount(arg0: &CommissionConfig, arg1: u64, arg2: address) : u64 {
        if (is_admin_exempt_from_commission(arg0, arg2)) {
            return 0
        };
        arg1 * arg0.current_commission_rate / 10000
    }

    public fun cancel_listing(arg0: &mut VillaMarketplace, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let DNFTListing {
            id              : v0,
            share_nft_id    : _,
            project_id      : _,
            villa_id        : _,
            seller          : v4,
            price           : _,
            affiliate_code  : _,
            is_active       : _,
            created_at      : _,
            expires_at      : _,
            nft_name        : _,
            nft_description : _,
            nft_image_url   : _,
        } = 0x2::table::remove<0x2::object::ID, DNFTListing>(&mut arg0.listings, arg1);
        assert!(v4 == 0x2::tx_context::sender(arg3), 1);
        0x2::object::delete(v0);
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

    public fun cleanup_batch_escrow(arg0: BatchEscrow<USDC>) {
        assert!(arg0.status == 2 || arg0.status == 5, 38);
        let BatchEscrow {
            id               : v0,
            buyer            : _,
            platform         : _,
            total_amount     : _,
            nft_count        : _,
            nft_ids          : _,
            project_id       : _,
            villa_id         : _,
            created_at       : _,
            expires_at       : _,
            status           : _,
            successful_nfts  : _,
            failed_nfts      : _,
            processed_amount : _,
            refund_amount    : _,
        } = arg0;
        0x2::object::delete(v0);
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

    public fun create_batch_escrow_config(arg0: &mut SuperAdminRegistry, arg1: u64, arg2: u64, arg3: bool, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : BatchEscrowConfig {
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(0x2::table::contains<address, AdminInfo>(&arg0.admins, v0), 24);
        assert!(0x2::table::borrow<address, AdminInfo>(&arg0.admins, v0).is_active, 24);
        assert!(arg1 > 0, 33);
        assert!(arg2 > 0, 33);
        BatchEscrowConfig{
            id                       : 0x2::object::new(arg5),
            max_batch_size           : arg1,
            default_expiry_hours     : arg2,
            default_affiliate_active : arg3,
            created_at               : 0x2::clock::timestamp_ms(arg4),
            updated_at               : 0x2::clock::timestamp_ms(arg4),
        }
    }

    public fun create_batch_escrow_with_payment(arg0: &mut SuperAdminRegistry, arg1: &BatchEscrowConfig, arg2: address, arg3: &mut VillaProject, arg4: &mut VillaMetadata, arg5: u64, arg6: 0x2::coin::Coin<USDC>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : BatchEscrow<USDC> {
        let v0 = 0x2::tx_context::sender(arg8);
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
        assert!(arg5 > 0, 33);
        assert!(arg5 <= arg1.max_batch_size, 34);
        assert!(arg5 <= arg4.max_shares - arg4.shares_issued, 10);
        assert!(arg5 <= arg3.max_total_shares - arg3.total_shares_issued, 9);
        assert!(0x2::coin::value<USDC>(&arg6) >= arg4.price_per_share * arg5, 30);
        let v5 = 0x2::clock::timestamp_ms(arg7) + arg1.default_expiry_hours * 3600000;
        let v6 = 0x2::coin::value<USDC>(&arg6);
        let v7 = BatchEscrow<USDC>{
            id               : 0x2::object::new(arg8),
            buyer            : arg2,
            platform         : v0,
            total_amount     : v6,
            nft_count        : arg5,
            nft_ids          : 0x1::vector::empty<0x2::object::ID>(),
            project_id       : arg3.project_id,
            villa_id         : arg4.villa_id,
            created_at       : 0x2::clock::timestamp_ms(arg7),
            expires_at       : v5,
            status           : 0,
            successful_nfts  : 0,
            failed_nfts      : 0,
            processed_amount : 0,
            refund_amount    : 0,
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<USDC>>(arg6, v0);
        let v8 = BatchEscrowCreated{
            escrow_id    : 0x2::object::uid_to_inner(&v7.id),
            buyer        : arg2,
            platform     : v0,
            total_amount : v6,
            nft_count    : arg5,
            project_id   : arg3.project_id,
            villa_id     : arg4.villa_id,
            expires_at   : v5,
            timestamp    : 0x2::clock::timestamp_ms(arg7),
        };
        0x2::event::emit<BatchEscrowCreated>(v8);
        v7
    }

    public fun create_marketplace(arg0: &AppCap, arg1: 0x1::string::String, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : VillaMarketplace {
        VillaMarketplace{
            id              : 0x2::object::new(arg5),
            project_id      : arg1,
            listings        : 0x2::table::new<0x2::object::ID, DNFTListing>(arg5),
            trades          : 0x2::table::new<0x2::object::ID, DNFTTrade>(arg5),
            commission_rate : arg2,
            affiliate_rate  : arg3,
            created_at      : 0x2::clock::timestamp_ms(arg4),
        }
    }

    public fun create_shared_app_cap(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AppCap{
            id          : 0x2::object::new(arg1),
            app_address : @0x0,
        };
        0x2::transfer::share_object<AppCap>(v0);
    }

    public fun create_user_vault(arg0: address, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : UserVault {
        let v0 = UserVault{
            id           : 0x2::object::new(arg2),
            owner        : arg0,
            sui_balance  : 0x2::balance::zero<0x2::sui::SUI>(),
            usdc_balance : 0x2::balance::zero<USDC>(),
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

    public fun create_villa_metadata(arg0: &AppCap, arg1: &mut VillaProject, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : VillaMetadata {
        assert!(arg7 > 0, 11);
        assert!(arg8 > 0, 12);
        assert!(arg1.total_shares_issued + arg7 <= arg1.max_total_shares, 9);
        let v0 = VillaMetadata{
            id              : 0x2::object::new(arg10),
            project_id      : arg1.project_id,
            villa_id        : arg2,
            name            : arg3,
            description     : arg4,
            image_url       : arg5,
            location        : arg6,
            max_shares      : arg7,
            shares_issued   : 0,
            price_per_share : arg8,
            created_at      : 0x2::clock::timestamp_ms(arg9),
            updated_at      : 0x2::clock::timestamp_ms(arg9),
        };
        arg1.total_villas = arg1.total_villas + 1;
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

    public fun create_villa_project(arg0: &AppCap, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : VillaProject {
        assert!(arg4 > 0, 11);
        assert!(arg5 <= 10000, 16);
        assert!(arg6 <= 10000, 16);
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

    public fun create_villa_project_with_admin(arg0: &AdminCap, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : VillaProject {
        assert!(arg4 > 0, 11);
        assert!(arg5 <= 10000, 16);
        assert!(arg6 <= 10000, 16);
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

    public fun delist(arg0: &mut VillaShareNFT, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 22);
        assert!(arg0.is_listed, 19);
        arg0.is_listed = false;
        arg0.listing_price = 0;
        let v0 = NFTDelisted{
            nft_id    : 0x2::object::uid_to_inner(&arg0.id),
            owner     : arg0.owner,
            timestamp : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<NFTDelisted>(v0);
    }

    public fun distribute_commission(arg0: &AppCap, arg1: &mut AffiliateReward, arg2: &mut AppTreasury, arg3: SaleCommission, arg4: &0x2::clock::Clock) {
        arg1.total_earned = arg1.total_earned + arg3.affiliate_commission;
        arg1.pending_amount = arg1.pending_amount + arg3.affiliate_commission;
        arg1.updated_at = 0x2::clock::timestamp_ms(arg4);
        arg2.total_earned = arg2.total_earned + arg3.app_commission;
        arg2.pending_amount = arg2.pending_amount + arg3.app_commission;
        arg2.updated_at = 0x2::clock::timestamp_ms(arg4);
        let v0 = AffiliateRewardEarned{
            affiliate_code : arg1.affiliate_code,
            owner          : arg1.owner,
            amount         : arg3.affiliate_commission,
            timestamp      : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<AffiliateRewardEarned>(v0);
    }

    fun generate_affiliate_code(arg0: address, arg1: &AffiliateConfig, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x1::string::String {
        arg1.current_prefix
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

    public fun get_affiliate_config_info(arg0: &AffiliateConfig) : (0x1::string::String, 0x1::string::String, address, bool, u64, u64) {
        (arg0.default_prefix, arg0.current_prefix, arg0.admin_address, arg0.is_active, arg0.created_at, arg0.updated_at)
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

    public fun get_batch_escrow_config_details(arg0: &BatchEscrowConfig) : (u64, u64, bool) {
        (arg0.max_batch_size, arg0.default_expiry_hours, arg0.default_affiliate_active)
    }

    public fun get_batch_escrow_details(arg0: &BatchEscrow<USDC>) : (address, address, u64, u64, u8) {
        (arg0.buyer, arg0.platform, arg0.total_amount, arg0.nft_count, arg0.status)
    }

    public fun get_batch_escrow_status(arg0: &BatchEscrow<USDC>) : u8 {
        arg0.status
    }

    public fun get_commission_config(arg0: &CommissionConfig) : (u64, u64, address, bool, u64) {
        (arg0.default_commission_rate, arg0.current_commission_rate, arg0.admin_address, arg0.is_active, arg0.updated_at)
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

    public fun get_marketplace_info(arg0: &VillaMarketplace) : (0x1::string::String, u64, u64, u64) {
        (arg0.project_id, arg0.commission_rate, arg0.affiliate_rate, arg0.created_at)
    }

    public fun get_metadata(arg0: &VillaShareNFT) : (0x1::string::String, 0x1::string::String, 0x1::string::String) {
        (arg0.name, arg0.description, arg0.image_url)
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

    public fun get_treasury_balance_info(arg0: &TreasuryBalance) : (u64, u64, u64, u64) {
        (0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance), 0x2::balance::value<USDC>(&arg0.usdc_balance), arg0.total_commission_earned, arg0.total_commission_withdrawn)
    }

    public fun get_user_vault_balance(arg0: &UserVault) : (u64, u64) {
        (0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance), 0x2::balance::value<USDC>(&arg0.usdc_balance))
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
        0x2::transfer::share_object<AppCap>(v0);
        let v1 = AdminCap{
            id          : 0x2::object::new(arg1),
            app_address : 0x2::tx_context::sender(arg1),
        };
        0x2::transfer::share_object<AdminCap>(v1);
        let v2 = AssetManagerCap{
            id          : 0x2::object::new(arg1),
            app_address : 0x2::tx_context::sender(arg1),
        };
        0x2::transfer::share_object<AssetManagerCap>(v2);
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
        0x1::vector::push_back<0x1::string::String>(v13, 0x1::string::utf8(b"MARKETPLACE_MANAGEMENT"));
        0x1::vector::push_back<0x1::string::String>(v13, 0x1::string::utf8(b"ADMIN_LIST_FOR_USER"));
        0x1::vector::push_back<0x1::string::String>(v13, 0x1::string::utf8(b"ADMIN_MINT_FOR_USER"));
        0x1::vector::push_back<0x1::string::String>(v13, 0x1::string::utf8(b"ADMIN_MINT_FOR_ADMIN"));
        0x1::vector::push_back<0x1::string::String>(v13, 0x1::string::utf8(b"ADMIN_TRANSFER_FOR_USER"));
        0x1::vector::push_back<0x1::string::String>(v13, 0x1::string::utf8(b"ADMIN_BUY_FOR_USER"));
        0x1::vector::push_back<0x1::string::String>(v13, 0x1::string::utf8(b"ADMIN_DEPOSIT_FOR_USER"));
        0x1::vector::push_back<0x1::string::String>(v13, 0x1::string::utf8(b"ADMIN_WITHDRAW_FOR_USER"));
        0x2::table::add<0x1::string::String, vector<0x1::string::String>>(&mut v9.roles, 0x1::string::utf8(b"ADMIN"), v12);
        let v14 = 0x1::vector::empty<0x1::string::String>();
        let v15 = &mut v14;
        0x1::vector::push_back<0x1::string::String>(v15, 0x1::string::utf8(b"VILLA_MANAGEMENT"));
        0x1::vector::push_back<0x1::string::String>(v15, 0x1::string::utf8(b"MARKETPLACE_MANAGEMENT"));
        0x2::table::add<0x1::string::String, vector<0x1::string::String>>(&mut v9.roles, 0x1::string::utf8(b"MODERATOR"), v14);
        let v16 = 0x1::vector::empty<0x1::string::String>();
        let v17 = &mut v16;
        0x1::vector::push_back<0x1::string::String>(v17, 0x1::string::utf8(b"VILLA_MANAGEMENT"));
        0x1::vector::push_back<0x1::string::String>(v17, 0x1::string::utf8(b"METADATA_UPDATE"));
        0x2::table::add<0x1::string::String, vector<0x1::string::String>>(&mut v9.roles, 0x1::string::utf8(b"ASSET_MANAGER"), v16);
        0x2::transfer::share_object<SuperAdminRegistry>(v3);
        0x2::transfer::share_object<AddressRegistry>(v7);
        0x2::transfer::share_object<RolePermissionRegistry>(v9);
        let v18 = 0;
        let v19 = CommissionConfig{
            id                      : 0x2::object::new(arg1),
            default_commission_rate : 1000,
            current_commission_rate : 1000,
            admin_address           : 0x2::tx_context::sender(arg1),
            is_active               : true,
            created_at              : v18,
            updated_at              : v18,
        };
        let v20 = TreasuryBalance{
            id                         : 0x2::object::new(arg1),
            sui_balance                : 0x2::balance::zero<0x2::sui::SUI>(),
            usdc_balance               : 0x2::balance::zero<USDC>(),
            total_commission_earned    : 0,
            total_commission_withdrawn : 0,
            created_at                 : v18,
            updated_at                 : v18,
        };
        let v21 = AffiliateConfig{
            id             : 0x2::object::new(arg1),
            default_prefix : 0x1::string::utf8(b"AF"),
            current_prefix : 0x1::string::utf8(b"AF"),
            admin_address  : 0x2::tx_context::sender(arg1),
            is_active      : true,
            created_at     : v18,
            updated_at     : v18,
        };
        0x2::transfer::transfer<CommissionConfig>(v19, 0x2::tx_context::sender(arg1));
        0x2::transfer::transfer<TreasuryBalance>(v20, 0x2::tx_context::sender(arg1));
        0x2::transfer::transfer<AffiliateConfig>(v21, 0x2::tx_context::sender(arg1));
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

    public fun is_admin_exempt_from_commission(arg0: &CommissionConfig, arg1: address) : bool {
        arg1 == arg0.admin_address
    }

    public fun is_batch_escrow_expired(arg0: &BatchEscrow<USDC>, arg1: &0x2::clock::Clock) : bool {
        0x2::clock::timestamp_ms(arg1) > arg0.expires_at
    }

    public fun is_listed(arg0: &VillaShareNFT) : bool {
        arg0.is_listed
    }

    public fun is_super_admin(arg0: &SuperAdminRegistry, arg1: address) : bool {
        arg0.super_admin == arg1
    }

    public fun list_dnft_for_sale(arg0: &mut VillaMarketplace, arg1: &mut VillaShareNFT, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 12);
        assert!(arg3 > 0x2::clock::timestamp_ms(arg4), 15);
        arg1.is_listed = true;
        arg1.listing_price = arg2;
        let v0 = 0x2::object::uid_to_inner(&arg1.id);
        let v1 = DNFTListing{
            id              : 0x2::object::new(arg5),
            share_nft_id    : v0,
            project_id      : arg1.project_id,
            villa_id        : arg1.villa_id,
            seller          : arg1.owner,
            price           : arg2,
            affiliate_code  : arg1.affiliate_code,
            is_active       : true,
            created_at      : 0x2::clock::timestamp_ms(arg4),
            expires_at      : arg3,
            nft_name        : arg1.name,
            nft_description : arg1.description,
            nft_image_url   : arg1.image_url,
        };
        0x2::table::add<0x2::object::ID, DNFTListing>(&mut arg0.listings, v1.share_nft_id, v1);
        let v2 = DNFTListed{
            share_nft_id : v0,
            seller       : arg1.owner,
            price        : arg2,
            created_at   : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<DNFTListed>(v2);
    }

    public fun list_for_sale(arg0: &mut VillaShareNFT, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg3), 22);
        assert!(!arg0.is_listed, 20);
        assert!(arg1 > 0, 21);
        arg0.is_listed = true;
        arg0.listing_price = arg1;
        arg0.price = arg1;
        let v0 = NFTListed{
            nft_id    : 0x2::object::uid_to_inner(&arg0.id),
            owner     : arg0.owner,
            price     : arg1,
            timestamp : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<NFTListed>(v0);
    }

    public fun mint_villa_share(arg0: &AppCap, arg1: &mut VillaProject, arg2: &mut VillaMetadata, arg3: &AffiliateConfig, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : VillaShareNFT {
        assert!(arg2.shares_issued < arg2.max_shares, 10);
        assert!(arg1.total_shares_issued < arg1.max_total_shares, 9);
        let v0 = 0x2::object::new(arg8);
        let v1 = 0x2::tx_context::sender(arg8);
        let v2 = 0x2::tx_context::sender(arg8);
        let v3 = VillaShareNFT{
            id                  : v0,
            project_id          : arg1.project_id,
            villa_id            : arg2.villa_id,
            owner               : v1,
            affiliate_code      : generate_affiliate_code(v2, arg3, arg7, arg8),
            is_affiliate_active : true,
            created_at          : 0x2::clock::timestamp_ms(arg7),
            name                : arg4,
            description         : arg5,
            image_url           : arg6,
            price               : arg2.price_per_share,
            is_listed           : false,
            listing_price       : 0,
        };
        arg2.shares_issued = arg2.shares_issued + 1;
        arg2.updated_at = 0x2::clock::timestamp_ms(arg7);
        arg1.total_shares_issued = arg1.total_shares_issued + 1;
        arg1.updated_at = 0x2::clock::timestamp_ms(arg7);
        let v4 = VillaSharesMinted{
            project_id          : arg1.project_id,
            villa_id            : arg2.villa_id,
            amount              : 1,
            total_shares_issued : arg2.shares_issued,
            created_at          : 0x2::clock::timestamp_ms(arg7),
            nft_name            : arg4,
            nft_description     : arg5,
            nft_image_url       : arg6,
            nft_price           : arg2.price_per_share,
        };
        0x2::event::emit<VillaSharesMinted>(v4);
        v3
    }

    public fun mint_villa_shares_batch(arg0: &AppCap, arg1: &mut VillaProject, arg2: &mut VillaMetadata, arg3: &AffiliateConfig, arg4: u64, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : vector<VillaShareNFT> {
        assert!(arg4 > 0, 11);
        assert!(arg2.shares_issued + arg4 <= arg2.max_shares, 10);
        assert!(arg1.total_shares_issued + arg4 <= arg1.max_total_shares, 9);
        let v0 = 0x1::vector::empty<VillaShareNFT>();
        let v1 = 0;
        while (v1 < arg4) {
            let v2 = 0x2::object::new(arg9);
            let v3 = 0x2::tx_context::sender(arg9);
            let v4 = 0x2::tx_context::sender(arg9);
            let v5 = VillaShareNFT{
                id                  : v2,
                project_id          : arg1.project_id,
                villa_id            : arg2.villa_id,
                owner               : v3,
                affiliate_code      : generate_affiliate_code(v4, arg3, arg8, arg9),
                is_affiliate_active : true,
                created_at          : 0x2::clock::timestamp_ms(arg8),
                name                : arg5,
                description         : arg6,
                image_url           : arg7,
                price               : arg2.price_per_share,
                is_listed           : false,
                listing_price       : 0,
            };
            0x1::vector::push_back<VillaShareNFT>(&mut v0, v5);
            v1 = v1 + 1;
        };
        arg2.shares_issued = arg2.shares_issued + arg4;
        arg2.updated_at = 0x2::clock::timestamp_ms(arg8);
        arg1.total_shares_issued = arg1.total_shares_issued + arg4;
        arg1.updated_at = 0x2::clock::timestamp_ms(arg8);
        let v6 = VillaSharesMinted{
            project_id          : arg1.project_id,
            villa_id            : arg2.villa_id,
            amount              : arg4,
            total_shares_issued : arg2.shares_issued,
            created_at          : 0x2::clock::timestamp_ms(arg8),
            nft_name            : arg5,
            nft_description     : arg6,
            nft_image_url       : arg7,
            nft_price           : arg2.price_per_share,
        };
        0x2::event::emit<VillaSharesMinted>(v6);
        v0
    }

    public fun process_batch_escrow_payment(arg0: &mut BatchEscrow<USDC>, arg1: &mut CommissionConfig, arg2: &mut TreasuryBalance, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 2 || arg0.status == 3 || arg0.status == 4, 35);
        if (arg0.processed_amount > 0) {
            arg2.total_commission_earned = arg2.total_commission_earned + arg0.processed_amount * arg1.current_commission_rate / 10000;
        };
        let v0 = BatchEscrowProcessed{
            escrow_id        : 0x2::object::uid_to_inner(&arg0.id),
            buyer            : arg0.buyer,
            platform         : arg0.platform,
            processed_amount : arg0.processed_amount,
            refund_amount    : arg0.refund_amount,
            successful_nfts  : arg0.successful_nfts,
            failed_nfts      : arg0.failed_nfts,
            timestamp        : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<BatchEscrowProcessed>(v0);
    }

    public fun process_commission_payment(arg0: &mut CommissionConfig, arg1: &mut TreasuryBalance, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: address, arg4: address, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = calculate_commission_amount(arg0, arg5, arg3);
        if (v0 == 0) {
            return 0x2::coin::split<0x2::sui::SUI>(arg2, arg5, arg7)
        };
        let v1 = arg5 - v0;
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.sui_balance, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(arg2, v0, arg7)));
        arg1.total_commission_earned = arg1.total_commission_earned + v0;
        arg1.updated_at = 0x2::clock::timestamp_ms(arg6);
        let v2 = CommissionCollected{
            seller_address    : arg3,
            buyer_address     : arg4,
            total_price       : arg5,
            commission_amount : v0,
            seller_received   : v1,
            timestamp         : 0x2::clock::timestamp_ms(arg6),
        };
        0x2::event::emit<CommissionCollected>(v2);
        let v3 = TreasuryBalanceUpdated{
            sui_balance  : 0x2::balance::value<0x2::sui::SUI>(&arg1.sui_balance),
            usdc_balance : 0x2::balance::value<USDC>(&arg1.usdc_balance),
            total_earned : arg1.total_commission_earned,
            timestamp    : 0x2::clock::timestamp_ms(arg6),
        };
        0x2::event::emit<TreasuryBalanceUpdated>(v3);
        0x2::coin::split<0x2::sui::SUI>(arg2, v1, arg7)
    }

    public fun process_usdc_commission_payment(arg0: &mut CommissionConfig, arg1: &mut TreasuryBalance, arg2: &mut 0x2::coin::Coin<USDC>, arg3: address, arg4: address, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<USDC> {
        let v0 = calculate_commission_amount(arg0, arg5, arg3);
        if (v0 == 0) {
            return 0x2::coin::split<USDC>(arg2, arg5, arg7)
        };
        let v1 = arg5 - v0;
        0x2::balance::join<USDC>(&mut arg1.usdc_balance, 0x2::coin::into_balance<USDC>(0x2::coin::split<USDC>(arg2, v0, arg7)));
        arg1.total_commission_earned = arg1.total_commission_earned + v0;
        arg1.updated_at = 0x2::clock::timestamp_ms(arg6);
        let v2 = CommissionCollected{
            seller_address    : arg3,
            buyer_address     : arg4,
            total_price       : arg5,
            commission_amount : v0,
            seller_received   : v1,
            timestamp         : 0x2::clock::timestamp_ms(arg6),
        };
        0x2::event::emit<CommissionCollected>(v2);
        let v3 = TreasuryBalanceUpdated{
            sui_balance  : 0x2::balance::value<0x2::sui::SUI>(&arg1.sui_balance),
            usdc_balance : 0x2::balance::value<USDC>(&arg1.usdc_balance),
            total_earned : arg1.total_commission_earned,
            timestamp    : 0x2::clock::timestamp_ms(arg6),
        };
        0x2::event::emit<TreasuryBalanceUpdated>(v3);
        0x2::coin::split<USDC>(arg2, v1, arg7)
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

    public fun update_affiliate_prefix(arg0: &mut AffiliateConfig, arg1: 0x1::string::String, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin_address, 24);
        assert!(arg0.is_active, 1);
        arg0.current_prefix = arg1;
        arg0.updated_at = 0x2::clock::timestamp_ms(arg2);
        let v0 = AffiliateConfigUpdated{
            admin_address : 0x2::tx_context::sender(arg3),
            old_prefix    : arg0.current_prefix,
            new_prefix    : arg1,
            timestamp     : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<AffiliateConfigUpdated>(v0);
    }

    public fun update_batch_escrow_config(arg0: &mut SuperAdminRegistry, arg1: &mut BatchEscrowConfig, arg2: u64, arg3: u64, arg4: bool, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        assert!(0x2::table::contains<address, AdminInfo>(&arg0.admins, v0), 24);
        assert!(0x2::table::borrow<address, AdminInfo>(&arg0.admins, v0).is_active, 24);
        assert!(arg2 > 0, 33);
        assert!(arg3 > 0, 33);
        arg1.max_batch_size = arg2;
        arg1.default_expiry_hours = arg3;
        arg1.default_affiliate_active = arg4;
        arg1.updated_at = 0x2::clock::timestamp_ms(arg5);
        let v1 = BatchEscrowConfigUpdated{
            admin_address            : v0,
            max_batch_size           : arg2,
            default_expiry_hours     : arg3,
            default_affiliate_active : arg4,
            timestamp                : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<BatchEscrowConfigUpdated>(v1);
    }

    public fun update_commission_rate(arg0: &mut CommissionConfig, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin_address, 24);
        assert!(arg1 <= 10000, 16);
        arg0.current_commission_rate = arg1;
        arg0.updated_at = 0x2::clock::timestamp_ms(arg2);
        let v0 = CommissionConfigUpdated{
            admin_address : 0x2::tx_context::sender(arg3),
            old_rate      : arg0.current_commission_rate,
            new_rate      : arg1,
            timestamp     : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<CommissionConfigUpdated>(v0);
    }

    public fun update_metadata(arg0: &mut VillaShareNFT, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg5), 22);
        arg0.name = arg1;
        arg0.description = arg2;
        arg0.image_url = arg3;
    }

    public fun update_price(arg0: &mut VillaShareNFT, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg3), 22);
        assert!(arg1 > 0, 21);
        arg0.price = arg1;
        if (arg0.is_listed) {
            arg0.listing_price = arg1;
        };
        let v0 = PriceUpdated{
            nft_id    : 0x2::object::uid_to_inner(&arg0.id),
            old_price : arg0.price,
            new_price : arg1,
            timestamp : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<PriceUpdated>(v0);
    }

    public fun update_villa_metadata(arg0: &AssetManagerCap, arg1: &mut VillaMetadata, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &0x2::clock::Clock) {
        arg1.image_url = arg2;
        arg1.description = arg3;
        arg1.updated_at = 0x2::clock::timestamp_ms(arg4);
    }

    public fun update_villa_project(arg0: &AppCap, arg1: &mut VillaProject, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock) {
        assert!(arg4 <= 10000, 16);
        assert!(arg5 <= 10000, 16);
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

    public fun user_buy_for_self(arg0: &mut VillaMarketplace, arg1: &AffiliateConfig, arg2: 0x2::object::ID, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : VillaShareNFT {
        let v0 = 0x2::table::remove<0x2::object::ID, DNFTListing>(&mut arg0.listings, arg2);
        assert!(v0.is_active, 14);
        assert!(0x2::clock::timestamp_ms(arg4) <= v0.expires_at, 15);
        let DNFTListing {
            id              : v1,
            share_nft_id    : v2,
            project_id      : v3,
            villa_id        : v4,
            seller          : v5,
            price           : v6,
            affiliate_code  : _,
            is_active       : _,
            created_at      : _,
            expires_at      : _,
            nft_name        : v11,
            nft_description : v12,
            nft_image_url   : v13,
        } = v0;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) >= v6, 30);
        let v14 = v6 * arg0.affiliate_rate / 10000;
        let v15 = v6 * arg0.commission_rate / 10000;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, v5);
        let v16 = 0x2::tx_context::sender(arg5);
        let v17 = 0x2::object::new(arg5);
        let v18 = generate_affiliate_code(v16, arg1, arg4, arg5);
        let v19 = VillaShareNFT{
            id                  : v17,
            project_id          : v3,
            villa_id            : v4,
            owner               : v16,
            affiliate_code      : v18,
            is_affiliate_active : true,
            created_at          : 0x2::clock::timestamp_ms(arg4),
            name                : v11,
            description         : v12,
            image_url           : v13,
            price               : v6,
            is_listed           : false,
            listing_price       : 0,
        };
        let v20 = DNFTTrade{
            id                   : 0x2::object::new(arg5),
            share_nft_id         : v2,
            project_id           : v3,
            villa_id             : v4,
            seller               : v5,
            buyer                : v16,
            price                : v6,
            affiliate_commission : v14,
            app_commission       : v15,
            timestamp            : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::table::add<0x2::object::ID, DNFTTrade>(&mut arg0.trades, v2, v20);
        0x2::object::delete(v1);
        let v21 = DNFTBought{
            share_nft_id         : 0x2::object::uid_to_inner(&v19.id),
            buyer                : v16,
            seller               : v5,
            price                : v6,
            affiliate_commission : v14,
            app_commission       : v15,
        };
        0x2::event::emit<DNFTBought>(v21);
        v19
    }

    public fun user_buy_with_usdc_for_self(arg0: &mut VillaMarketplace, arg1: &AffiliateConfig, arg2: 0x2::object::ID, arg3: 0x2::coin::Coin<USDC>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : VillaShareNFT {
        let v0 = 0x2::table::remove<0x2::object::ID, DNFTListing>(&mut arg0.listings, arg2);
        assert!(v0.is_active, 14);
        assert!(0x2::clock::timestamp_ms(arg4) <= v0.expires_at, 15);
        let DNFTListing {
            id              : v1,
            share_nft_id    : v2,
            project_id      : v3,
            villa_id        : v4,
            seller          : v5,
            price           : v6,
            affiliate_code  : _,
            is_active       : _,
            created_at      : _,
            expires_at      : _,
            nft_name        : v11,
            nft_description : v12,
            nft_image_url   : v13,
        } = v0;
        assert!(0x2::coin::value<USDC>(&arg3) >= v6, 30);
        let v14 = v6 * arg0.affiliate_rate / 10000;
        let v15 = v6 * arg0.commission_rate / 10000;
        0x2::transfer::public_transfer<0x2::coin::Coin<USDC>>(arg3, v5);
        let v16 = 0x2::tx_context::sender(arg5);
        let v17 = 0x2::object::new(arg5);
        let v18 = generate_affiliate_code(v16, arg1, arg4, arg5);
        let v19 = VillaShareNFT{
            id                  : v17,
            project_id          : v3,
            villa_id            : v4,
            owner               : v16,
            affiliate_code      : v18,
            is_affiliate_active : true,
            created_at          : 0x2::clock::timestamp_ms(arg4),
            name                : v11,
            description         : v12,
            image_url           : v13,
            price               : v6,
            is_listed           : false,
            listing_price       : 0,
        };
        let v20 = DNFTTrade{
            id                   : 0x2::object::new(arg5),
            share_nft_id         : v2,
            project_id           : v3,
            villa_id             : v4,
            seller               : v5,
            buyer                : v16,
            price                : v6,
            affiliate_commission : v14,
            app_commission       : v15,
            timestamp            : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::table::add<0x2::object::ID, DNFTTrade>(&mut arg0.trades, v2, v20);
        0x2::object::delete(v1);
        let v21 = DNFTBought{
            share_nft_id         : 0x2::object::uid_to_inner(&v19.id),
            buyer                : v16,
            seller               : v5,
            price                : v6,
            affiliate_commission : v14,
            app_commission       : v15,
        };
        0x2::event::emit<DNFTBought>(v21);
        v19
    }

    public fun user_deposit_sui_for_self(arg0: &mut UserVault, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 22);
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
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 22);
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

    public fun user_withdraw_sui_for_self(arg0: &mut UserVault, arg1: u64, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(arg0.owner == 0x2::tx_context::sender(arg4), 22);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance) >= arg1, 29);
        arg0.updated_at = 0x2::clock::timestamp_ms(arg3);
        let v0 = TokenWithdrawn{
            vault_id   : 0x2::object::uid_to_inner(&arg0.id),
            owner      : arg0.owner,
            recipient  : arg2,
            amount     : arg1,
            token_type : 0x1::string::utf8(b"SUI"),
            timestamp  : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<TokenWithdrawn>(v0);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_balance, arg1), arg4)
    }

    public fun user_withdraw_usdc_for_self(arg0: &mut UserVault, arg1: u64, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<USDC> {
        assert!(arg0.owner == 0x2::tx_context::sender(arg4), 22);
        assert!(0x2::balance::value<USDC>(&arg0.usdc_balance) >= arg1, 29);
        arg0.updated_at = 0x2::clock::timestamp_ms(arg3);
        let v0 = TokenWithdrawn{
            vault_id   : 0x2::object::uid_to_inner(&arg0.id),
            owner      : arg0.owner,
            recipient  : arg2,
            amount     : arg1,
            token_type : 0x1::string::utf8(b"USDC"),
            timestamp  : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<TokenWithdrawn>(v0);
        0x2::coin::from_balance<USDC>(0x2::balance::split<USDC>(&mut arg0.usdc_balance, arg1), arg4)
    }

    // decompiled from Move bytecode v6
}

