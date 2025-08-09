module 0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::interface {
    public fun admin_airdrop_nfts(arg0: &mut 0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::mint::Sale, arg1: &0x2::transfer_policy::TransferPolicy<0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::mystic_yeti::MysticYeti>, arg2: &0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::allowed_versions::AV, arg3: &0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::acl::AdminWitness<0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::core::CORE>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::allowed_versions::get_allowed_versions(arg2);
        0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::allowed_versions::assert_pkg_version(&v0);
        0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::mint::airdrop_admin_nfts(arg0, arg1, arg4);
    }

    public fun admin_mint_for_giveaway(arg0: &mut 0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::mint::Sale, arg1: &0x2::clock::Clock, arg2: address, arg3: u64, arg4: &0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::allowed_versions::AV, arg5: &0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::acl::AdminWitness<0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::core::CORE>, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::allowed_versions::get_allowed_versions(arg4);
        0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::allowed_versions::assert_pkg_version(&v0);
        0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::mint::admin_mint_for_giveaway(arg0, arg1, arg2, arg3, arg6);
    }

    public fun admin_mint_nft(arg0: &mut 0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::mint::Sale, arg1: &0x2::clock::Clock, arg2: &0x2::transfer_policy::TransferPolicy<0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::mystic_yeti::MysticYeti>, arg3: address, arg4: u64, arg5: &0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::allowed_versions::AV, arg6: &0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::acl::AdminWitness<0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::core::CORE>, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::allowed_versions::get_allowed_versions(arg5);
        0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::allowed_versions::assert_pkg_version(&v0);
        0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::mint::admin_mint_nft(arg0, arg1, arg2, arg3, arg4, arg7);
    }

    public fun admin_mint_nft_for_airdrop(arg0: &mut 0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::mint::Sale, arg1: &0x2::clock::Clock, arg2: address, arg3: u64, arg4: &0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::allowed_versions::AV, arg5: &0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::acl::AdminWitness<0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::core::CORE>, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::allowed_versions::get_allowed_versions(arg4);
        0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::allowed_versions::assert_pkg_version(&v0);
        0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::mint::admin_mint_nft_for_airdrop(arg0, arg1, arg2, arg3, arg6);
    }

    public fun admin_mint_specific_nft(arg0: &mut 0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::mint::Sale, arg1: &0x2::transfer_policy::TransferPolicy<0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::mystic_yeti::MysticYeti>, arg2: address, arg3: vector<u64>, arg4: &0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::allowed_versions::AV, arg5: &0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::acl::AdminWitness<0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::core::CORE>, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::allowed_versions::get_allowed_versions(arg4);
        0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::allowed_versions::assert_pkg_version(&v0);
        0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::mint::admin_mint_specific_nft(arg0, arg1, arg2, arg3, arg6);
    }

    public fun airdrop_fix(arg0: &mut 0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::mint::Sale, arg1: &0x2::transfer_policy::TransferPolicy<0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::mystic_yeti::MysticYeti>, arg2: &0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::allowed_versions::AV, arg3: &0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::acl::AdminWitness<0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::core::CORE>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::allowed_versions::get_allowed_versions(arg2);
        0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::allowed_versions::assert_pkg_version(&v0);
        0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::mint::airdrop_fix(arg0, arg1, arg4);
    }

    public fun airdrop_nfts(arg0: &mut 0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::mint::Sale, arg1: &0x2::transfer_policy::TransferPolicy<0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::mystic_yeti::MysticYeti>, arg2: &0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::allowed_versions::AV, arg3: &0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::acl::AdminWitness<0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::core::CORE>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::allowed_versions::get_allowed_versions(arg2);
        0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::allowed_versions::assert_pkg_version(&v0);
        0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::mint::airdrop_nfts(arg0, arg1, arg4);
    }

    public fun airdrop_nfts_slow(arg0: &mut 0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::mint::Sale, arg1: &0x2::transfer_policy::TransferPolicy<0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::mystic_yeti::MysticYeti>, arg2: &0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::allowed_versions::AV, arg3: &0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::acl::AdminWitness<0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::core::CORE>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::allowed_versions::get_allowed_versions(arg2);
        0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::allowed_versions::assert_pkg_version(&v0);
        0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::mint::airdrop_nfts_slow(arg0, arg1, arg4);
    }

    public fun airdrop_one_of_one_nfts(arg0: &mut 0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::mint::Sale, arg1: &0x2::transfer_policy::TransferPolicy<0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::mystic_yeti::MysticYeti>, arg2: address, arg3: &0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::allowed_versions::AV, arg4: &0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::acl::AdminWitness<0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::core::CORE>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::allowed_versions::get_allowed_versions(arg3);
        0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::allowed_versions::assert_pkg_version(&v0);
        0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::mint::airdrop_one_of_one_nfts(arg0, arg1, arg2, arg5);
    }

    public fun airdrop_pass(arg0: address, arg1: u64, arg2: &0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::allowed_versions::AV, arg3: &0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::acl::AdminWitness<0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::core::CORE>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::allowed_versions::get_allowed_versions(arg2);
        0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::allowed_versions::assert_pkg_version(&v0);
        0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::mint::airdrop_pass(arg0, arg1, arg4);
    }

    public fun airdrop_special_drop_nfts(arg0: &mut 0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::mint::Sale, arg1: &0x2::transfer_policy::TransferPolicy<0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::mystic_yeti::MysticYeti>, arg2: address, arg3: &0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::allowed_versions::AV, arg4: &0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::acl::AdminWitness<0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::core::CORE>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::allowed_versions::get_allowed_versions(arg3);
        0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::allowed_versions::assert_pkg_version(&v0);
        0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::mint::mint_special_drop_nft(arg0, arg1, arg2, arg5);
    }

    public fun destroy(arg0: 0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::mint::Sale, arg1: &0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::allowed_versions::AV, arg2: &0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::acl::AdminWitness<0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::core::CORE>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::allowed_versions::get_allowed_versions(arg1);
        0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::allowed_versions::assert_pkg_version(&v0);
        0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::mint::destroy(arg0);
    }

    public fun extract_lofi_balance(arg0: &mut 0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::mint::Sale, arg1: u64, arg2: &0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::allowed_versions::AV, arg3: &0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::acl::AdminWitness<0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::core::CORE>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xc5c4bc11427315926cf0cc284504d8e5693a10da75500a5198bdee23f47f4254::lofi_sui::LOFI_SUI> {
        let v0 = 0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::allowed_versions::get_allowed_versions(arg2);
        0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::allowed_versions::assert_pkg_version(&v0);
        0x2::coin::from_balance<0xc5c4bc11427315926cf0cc284504d8e5693a10da75500a5198bdee23f47f4254::lofi_sui::LOFI_SUI>(0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::mint::extract_lofi_balance(arg0, arg1), arg4)
    }

    public fun extract_sui_balance(arg0: &mut 0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::mint::Sale, arg1: u64, arg2: &0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::allowed_versions::AV, arg3: &0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::acl::AdminWitness<0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::core::CORE>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::allowed_versions::get_allowed_versions(arg2);
        0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::allowed_versions::assert_pkg_version(&v0);
        0x2::coin::from_balance<0x2::sui::SUI>(0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::mint::extract_sui_balance(arg0, arg1), arg4)
    }

    public entry fun mint_presale_whitelist(arg0: &mut 0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::mint::Sale, arg1: 0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::mint::WhitelistPass, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: u64, arg5: &0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::allowed_versions::AV, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::allowed_versions::get_allowed_versions(arg5);
        0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::allowed_versions::assert_pkg_version(&v0);
        0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::mint::mint_presale_whitelist_nft(arg0, arg1, arg2, arg3, arg4, arg6);
    }

    public entry fun mint_public(arg0: &mut 0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::mint::Sale, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: u64, arg4: &0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::allowed_versions::AV, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::allowed_versions::get_allowed_versions(arg4);
        0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::allowed_versions::assert_pkg_version(&v0);
        0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::mint::mint_public_nft(arg0, arg1, arg2, arg3, arg5);
    }

    public entry fun mint_whitelist(arg0: &mut 0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::mint::Sale, arg1: 0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::mint::WhitelistPass, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: u64, arg5: &0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::allowed_versions::AV, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::allowed_versions::get_allowed_versions(arg5);
        0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::allowed_versions::assert_pkg_version(&v0);
        0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::mint::mint_whitelist_nft(arg0, arg1, arg2, arg3, arg4, arg6);
    }

    public fun nft_data_push_back(arg0: &mut 0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::mint::Sale, arg1: u64, arg2: 0x1::string::String, arg3: &mut vector<0x1::string::String>, arg4: &mut vector<0x1::string::String>, arg5: &0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::allowed_versions::AV, arg6: &0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::acl::AdminWitness<0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::core::CORE>, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::allowed_versions::get_allowed_versions(arg5);
        0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::allowed_versions::assert_pkg_version(&v0);
        0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::mint::nft_data_push_back(arg0, 0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::mystic_yeti::new_mystic_yeti_data(arg1, arg2, 0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::attributes::from_vec(arg3, arg4)));
    }

    public fun one_of_one_nft_data_push_back(arg0: &mut 0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::mint::Sale, arg1: u64, arg2: 0x1::string::String, arg3: &mut vector<0x1::string::String>, arg4: &mut vector<0x1::string::String>, arg5: &0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::allowed_versions::AV, arg6: &0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::acl::AdminWitness<0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::core::CORE>, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::allowed_versions::get_allowed_versions(arg5);
        0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::allowed_versions::assert_pkg_version(&v0);
        0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::mint::one_of_one_nft_data_push_back(arg0, 0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::mystic_yeti::new_mystic_yeti_data(arg1, arg2, 0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::attributes::from_vec(arg3, arg4)));
    }

    public fun remove_from_airdrop(arg0: &mut 0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::mint::Sale, arg1: &0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::allowed_versions::AV, arg2: &0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::acl::AdminWitness<0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::core::CORE>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::allowed_versions::get_allowed_versions(arg1);
        0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::allowed_versions::assert_pkg_version(&v0);
        0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::mint::remove_from_airdrop(arg0);
    }

    public fun reveal_nft(arg0: &mut 0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::mint::Sale, arg1: 0x2::coin::Coin<0xc5c4bc11427315926cf0cc284504d8e5693a10da75500a5198bdee23f47f4254::lofi_sui::LOFI_SUI>, arg2: 0x2::object::ID, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: &0x2::transfer_policy::TransferPolicy<0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::mystic_yeti::MysticYeti>, arg6: 0x2::transfer::Receiving<0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::mystic_yeti::RevealData>, arg7: &0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::allowed_versions::AV, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::allowed_versions::get_allowed_versions(arg7);
        0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::allowed_versions::assert_pkg_version(&v0);
        0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::mint::reveal_nft(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg8);
    }

    public fun reveal_nft_personal(arg0: &mut 0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::mint::Sale, arg1: 0x2::coin::Coin<0xc5c4bc11427315926cf0cc284504d8e5693a10da75500a5198bdee23f47f4254::lofi_sui::LOFI_SUI>, arg2: 0x2::object::ID, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg5: &0x2::transfer_policy::TransferPolicy<0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::mystic_yeti::MysticYeti>, arg6: 0x2::transfer::Receiving<0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::mystic_yeti::RevealData>, arg7: &0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::allowed_versions::AV, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::allowed_versions::get_allowed_versions(arg7);
        0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::allowed_versions::assert_pkg_version(&v0);
        0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::mint::reveal_nft(arg0, arg1, arg2, arg3, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow(arg4), arg5, arg6, arg8);
    }

    public fun set_mint_open(arg0: &mut 0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::mint::Sale, arg1: bool, arg2: &0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::allowed_versions::AV, arg3: &0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::acl::AdminWitness<0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::core::CORE>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::allowed_versions::get_allowed_versions(arg2);
        0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::allowed_versions::assert_pkg_version(&v0);
        0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::mint::set_mint_open(arg0, arg1);
    }

    public fun set_presale_whitelist_max_per_person(arg0: &mut 0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::mint::Sale, arg1: u64, arg2: &0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::allowed_versions::AV, arg3: &0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::acl::AdminWitness<0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::core::CORE>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::allowed_versions::get_allowed_versions(arg2);
        0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::allowed_versions::assert_pkg_version(&v0);
        0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::mint::set_presale_whitelist_max_per_person(arg0, arg1);
    }

    public fun set_presale_whitelist_price(arg0: &mut 0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::mint::Sale, arg1: u64, arg2: &0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::allowed_versions::AV, arg3: &0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::acl::AdminWitness<0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::core::CORE>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::allowed_versions::get_allowed_versions(arg2);
        0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::allowed_versions::assert_pkg_version(&v0);
        0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::mint::set_presale_whitelist_price(arg0, arg1);
    }

    public fun set_presale_whitelist_time(arg0: &mut 0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::mint::Sale, arg1: u64, arg2: &0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::allowed_versions::AV, arg3: &0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::acl::AdminWitness<0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::core::CORE>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::allowed_versions::get_allowed_versions(arg2);
        0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::allowed_versions::assert_pkg_version(&v0);
        0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::mint::set_presale_whitelist_time(arg0, arg1);
    }

    public fun set_public_max_per_person(arg0: &mut 0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::mint::Sale, arg1: u64, arg2: &0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::allowed_versions::AV, arg3: &0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::acl::AdminWitness<0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::core::CORE>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::allowed_versions::get_allowed_versions(arg2);
        0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::allowed_versions::assert_pkg_version(&v0);
        0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::mint::set_public_max_per_person(arg0, arg1);
    }

    public fun set_public_price(arg0: &mut 0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::mint::Sale, arg1: u64, arg2: &0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::allowed_versions::AV, arg3: &0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::acl::AdminWitness<0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::core::CORE>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::allowed_versions::get_allowed_versions(arg2);
        0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::allowed_versions::assert_pkg_version(&v0);
        0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::mint::set_public_price(arg0, arg1);
    }

    public fun set_public_time(arg0: &mut 0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::mint::Sale, arg1: u64, arg2: &0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::allowed_versions::AV, arg3: &0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::acl::AdminWitness<0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::core::CORE>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::allowed_versions::get_allowed_versions(arg2);
        0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::allowed_versions::assert_pkg_version(&v0);
        0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::mint::set_public_time(arg0, arg1);
    }

    public fun set_reveal_active(arg0: &mut 0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::mint::Sale, arg1: bool, arg2: &0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::allowed_versions::AV, arg3: &0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::acl::AdminWitness<0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::core::CORE>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::allowed_versions::get_allowed_versions(arg2);
        0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::allowed_versions::assert_pkg_version(&v0);
        0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::mint::set_reveal_active(arg0, arg1);
    }

    public fun set_reveal_price(arg0: &mut 0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::mint::Sale, arg1: u64, arg2: &0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::allowed_versions::AV, arg3: &0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::acl::AdminWitness<0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::core::CORE>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::allowed_versions::get_allowed_versions(arg2);
        0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::allowed_versions::assert_pkg_version(&v0);
        0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::mint::set_reveal_price(arg0, arg1);
    }

    public fun set_up_transfer_policy(arg0: &0x2::package::Publisher, arg1: &0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::allowed_versions::AV, arg2: &0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::acl::AdminWitness<0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::core::CORE>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::allowed_versions::get_allowed_versions(arg1);
        0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::allowed_versions::assert_pkg_version(&v0);
        let (v1, v2) = 0x2::transfer_policy::new<0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::mystic_yeti::MysticYeti>(arg0, arg3);
        let v3 = v2;
        let v4 = v1;
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::witness_rule::add<0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::mystic_yeti::MysticYeti, 0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::mint::WITNESS_RULE>(&mut v4, &v3);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::mystic_yeti::MysticYeti>>(v4);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::mystic_yeti::MysticYeti>>(v3, 0x2::tx_context::sender(arg3));
    }

    public fun set_whitelist_max_per_person(arg0: &mut 0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::mint::Sale, arg1: u64, arg2: &0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::allowed_versions::AV, arg3: &0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::acl::AdminWitness<0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::core::CORE>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::allowed_versions::get_allowed_versions(arg2);
        0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::allowed_versions::assert_pkg_version(&v0);
        0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::mint::set_whitelist_max_per_person(arg0, arg1);
    }

    public fun set_whitelist_price(arg0: &mut 0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::mint::Sale, arg1: u64, arg2: &0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::allowed_versions::AV, arg3: &0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::acl::AdminWitness<0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::core::CORE>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::allowed_versions::get_allowed_versions(arg2);
        0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::allowed_versions::assert_pkg_version(&v0);
        0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::mint::set_whitelist_price(arg0, arg1);
    }

    public fun set_whitelist_time(arg0: &mut 0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::mint::Sale, arg1: u64, arg2: &0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::allowed_versions::AV, arg3: &0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::acl::AdminWitness<0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::core::CORE>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::allowed_versions::get_allowed_versions(arg2);
        0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::allowed_versions::assert_pkg_version(&v0);
        0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::mint::set_whitelist_time(arg0, arg1);
    }

    public fun special_drop_data_push_back(arg0: &mut 0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::mint::Sale, arg1: u64, arg2: 0x1::string::String, arg3: &mut vector<0x1::string::String>, arg4: &mut vector<0x1::string::String>, arg5: &0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::allowed_versions::AV, arg6: &0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::acl::AdminWitness<0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::core::CORE>, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::allowed_versions::get_allowed_versions(arg5);
        0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::allowed_versions::assert_pkg_version(&v0);
        0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::mint::special_drop_data_push_back(arg0, 0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::mystic_yeti::new_mystic_yeti_data(arg1, arg2, 0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::attributes::from_vec(arg3, arg4)));
    }

    // decompiled from Move bytecode v6
}

