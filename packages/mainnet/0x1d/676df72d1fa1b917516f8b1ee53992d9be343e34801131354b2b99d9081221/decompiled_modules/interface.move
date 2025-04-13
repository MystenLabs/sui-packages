module 0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::interface {
    public fun burn_blob(arg0: &mut 0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::blob_store::BlobStore, arg1: u64, arg2: &0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::allowed_versions::AV, arg3: &0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::acl::AdminWitness<0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::core::CORE>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::allowed_versions::get_allowed_versions(arg2);
        0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::allowed_versions::assert_pkg_version(&v0);
        0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::blob_store::burn_blob(arg0, arg1);
    }

    public fun renew_blob(arg0: &mut 0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::blob_store::BlobStore, arg1: u64, arg2: u32, arg3: &mut 0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>, arg4: &mut 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg5: &0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::allowed_versions::AV, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::allowed_versions::get_allowed_versions(arg5);
        0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::allowed_versions::assert_pkg_version(&v0);
        0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::blob_store::renew_blob(arg0, arg1, arg2, arg3, arg4);
    }

    public fun admin_mint_for_giveaway(arg0: &mut 0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::mint::Sale, arg1: &0x2::clock::Clock, arg2: address, arg3: u64, arg4: &0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::allowed_versions::AV, arg5: &0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::acl::AdminWitness<0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::core::CORE>, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::allowed_versions::get_allowed_versions(arg4);
        0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::allowed_versions::assert_pkg_version(&v0);
        0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::mint::admin_mint_for_giveaway(arg0, arg1, arg2, arg3, arg6);
    }

    public fun admin_mint_nft(arg0: &mut 0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::mint::Sale, arg1: &0x2::clock::Clock, arg2: &0x2::transfer_policy::TransferPolicy<0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::mystic_yeti::MysticYeti>, arg3: address, arg4: u64, arg5: &0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::allowed_versions::AV, arg6: &0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::acl::AdminWitness<0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::core::CORE>, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::allowed_versions::get_allowed_versions(arg5);
        0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::allowed_versions::assert_pkg_version(&v0);
        0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::mint::admin_mint_nft(arg0, arg1, arg2, arg3, arg4, arg7);
    }

    public fun admin_mint_specific_nft(arg0: &mut 0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::mint::Sale, arg1: &0x2::transfer_policy::TransferPolicy<0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::mystic_yeti::MysticYeti>, arg2: address, arg3: vector<u64>, arg4: &0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::allowed_versions::AV, arg5: &0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::acl::AdminWitness<0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::core::CORE>, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::allowed_versions::get_allowed_versions(arg4);
        0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::allowed_versions::assert_pkg_version(&v0);
        0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::mint::admin_mint_specific_nft(arg0, arg1, arg2, arg3, arg6);
    }

    public fun airdrop_nfts(arg0: &mut 0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::mint::Sale, arg1: &0x2::transfer_policy::TransferPolicy<0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::mystic_yeti::MysticYeti>, arg2: &0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::allowed_versions::AV, arg3: &0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::acl::AdminWitness<0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::core::CORE>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::allowed_versions::get_allowed_versions(arg2);
        0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::allowed_versions::assert_pkg_version(&v0);
        0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::mint::airdrop_nfts(arg0, arg1, arg4);
    }

    public fun airdrop_pass(arg0: address, arg1: u64, arg2: &0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::allowed_versions::AV, arg3: &0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::acl::AdminWitness<0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::core::CORE>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::allowed_versions::get_allowed_versions(arg2);
        0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::allowed_versions::assert_pkg_version(&v0);
        0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::mint::airdrop_pass(arg0, arg1, arg4);
    }

    public fun destroy(arg0: 0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::mint::Sale, arg1: &0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::allowed_versions::AV, arg2: &0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::acl::AdminWitness<0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::core::CORE>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::allowed_versions::get_allowed_versions(arg1);
        0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::allowed_versions::assert_pkg_version(&v0);
        0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::mint::destroy(arg0);
    }

    public fun extract_lofi_balance(arg0: &mut 0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::mint::Sale, arg1: u64, arg2: &0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::allowed_versions::AV, arg3: &0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::acl::AdminWitness<0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::core::CORE>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xf22da9a24ad027cccb5f2d496cbe91de953d363513db08a3a734d361c7c17503::LOFI::LOFI> {
        let v0 = 0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::allowed_versions::get_allowed_versions(arg2);
        0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::allowed_versions::assert_pkg_version(&v0);
        0x2::coin::from_balance<0xf22da9a24ad027cccb5f2d496cbe91de953d363513db08a3a734d361c7c17503::LOFI::LOFI>(0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::mint::extract_lofi_balance(arg0, arg1), arg4)
    }

    public fun extract_sui_balance(arg0: &mut 0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::mint::Sale, arg1: u64, arg2: &0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::allowed_versions::AV, arg3: &0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::acl::AdminWitness<0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::core::CORE>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::allowed_versions::get_allowed_versions(arg2);
        0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::allowed_versions::assert_pkg_version(&v0);
        0x2::coin::from_balance<0x2::sui::SUI>(0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::mint::extract_sui_balance(arg0, arg1), arg4)
    }

    public entry fun mint_presale_whitelist(arg0: &mut 0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::mint::Sale, arg1: 0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::mint::WhitelistPass, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: u64, arg5: &0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::allowed_versions::AV, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::allowed_versions::get_allowed_versions(arg5);
        0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::allowed_versions::assert_pkg_version(&v0);
        0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::mint::mint_presale_whitelist_nft(arg0, arg1, arg2, arg3, arg4, arg6);
    }

    public entry fun mint_public(arg0: &mut 0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::mint::Sale, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: u64, arg4: &0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::allowed_versions::AV, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::allowed_versions::get_allowed_versions(arg4);
        0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::allowed_versions::assert_pkg_version(&v0);
        0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::mint::mint_public_nft(arg0, arg1, arg2, arg3, arg5);
    }

    public entry fun mint_whitelist(arg0: &mut 0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::mint::Sale, arg1: 0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::mint::WhitelistPass, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: u64, arg5: &0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::allowed_versions::AV, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::allowed_versions::get_allowed_versions(arg5);
        0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::allowed_versions::assert_pkg_version(&v0);
        0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::mint::mint_whitelist_nft(arg0, arg1, arg2, arg3, arg4, arg6);
    }

    public fun nft_data_push_back(arg0: &mut 0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::mint::Sale, arg1: &mut 0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::blob_store::BlobStore, arg2: u64, arg3: 0x1::string::String, arg4: &mut vector<0x1::string::String>, arg5: &mut vector<0x1::string::String>, arg6: 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob, arg7: &0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::allowed_versions::AV, arg8: &0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::acl::AdminWitness<0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::core::CORE>, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::allowed_versions::get_allowed_versions(arg7);
        0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::allowed_versions::assert_pkg_version(&v0);
        0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::mint::nft_data_push_back(arg0, 0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::mystic_yeti::new_mystic_yeti_data(arg2, arg3, 0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::attributes::from_vec(arg4, arg5)));
        0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::blob_store::store_blob(arg1, arg2, arg6);
    }

    public fun reveal_nft(arg0: &mut 0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::mint::Sale, arg1: 0x2::coin::Coin<0xf22da9a24ad027cccb5f2d496cbe91de953d363513db08a3a734d361c7c17503::LOFI::LOFI>, arg2: 0x2::object::ID, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: &0x2::transfer_policy::TransferPolicy<0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::mystic_yeti::MysticYeti>, arg6: 0x2::transfer::Receiving<0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::mystic_yeti::RevealData>, arg7: &0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::allowed_versions::AV, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::allowed_versions::get_allowed_versions(arg7);
        0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::allowed_versions::assert_pkg_version(&v0);
        0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::mint::reveal_nft(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg8);
    }

    public fun set_mint_open(arg0: &mut 0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::mint::Sale, arg1: bool, arg2: &0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::allowed_versions::AV, arg3: &0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::acl::AdminWitness<0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::core::CORE>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::allowed_versions::get_allowed_versions(arg2);
        0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::allowed_versions::assert_pkg_version(&v0);
        0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::mint::set_mint_open(arg0, arg1);
    }

    public fun set_presale_whitelist_max_per_person(arg0: &mut 0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::mint::Sale, arg1: u64, arg2: &0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::allowed_versions::AV, arg3: &0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::acl::AdminWitness<0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::core::CORE>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::allowed_versions::get_allowed_versions(arg2);
        0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::allowed_versions::assert_pkg_version(&v0);
        0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::mint::set_presale_whitelist_max_per_person(arg0, arg1);
    }

    public fun set_presale_whitelist_price(arg0: &mut 0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::mint::Sale, arg1: u64, arg2: &0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::allowed_versions::AV, arg3: &0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::acl::AdminWitness<0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::core::CORE>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::allowed_versions::get_allowed_versions(arg2);
        0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::allowed_versions::assert_pkg_version(&v0);
        0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::mint::set_presale_whitelist_price(arg0, arg1);
    }

    public fun set_presale_whitelist_time(arg0: &mut 0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::mint::Sale, arg1: u64, arg2: &0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::allowed_versions::AV, arg3: &0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::acl::AdminWitness<0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::core::CORE>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::allowed_versions::get_allowed_versions(arg2);
        0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::allowed_versions::assert_pkg_version(&v0);
        0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::mint::set_presale_whitelist_time(arg0, arg1);
    }

    public fun set_public_max_per_person(arg0: &mut 0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::mint::Sale, arg1: u64, arg2: &0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::allowed_versions::AV, arg3: &0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::acl::AdminWitness<0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::core::CORE>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::allowed_versions::get_allowed_versions(arg2);
        0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::allowed_versions::assert_pkg_version(&v0);
        0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::mint::set_public_max_per_person(arg0, arg1);
    }

    public fun set_public_price(arg0: &mut 0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::mint::Sale, arg1: u64, arg2: &0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::allowed_versions::AV, arg3: &0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::acl::AdminWitness<0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::core::CORE>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::allowed_versions::get_allowed_versions(arg2);
        0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::allowed_versions::assert_pkg_version(&v0);
        0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::mint::set_public_price(arg0, arg1);
    }

    public fun set_public_time(arg0: &mut 0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::mint::Sale, arg1: u64, arg2: &0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::allowed_versions::AV, arg3: &0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::acl::AdminWitness<0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::core::CORE>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::allowed_versions::get_allowed_versions(arg2);
        0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::allowed_versions::assert_pkg_version(&v0);
        0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::mint::set_public_time(arg0, arg1);
    }

    public fun set_reveal_active(arg0: &mut 0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::mint::Sale, arg1: bool, arg2: &0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::allowed_versions::AV, arg3: &0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::acl::AdminWitness<0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::core::CORE>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::allowed_versions::get_allowed_versions(arg2);
        0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::allowed_versions::assert_pkg_version(&v0);
        0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::mint::set_reveal_active(arg0, arg1);
    }

    public fun set_reveal_price(arg0: &mut 0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::mint::Sale, arg1: u64, arg2: &0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::allowed_versions::AV, arg3: &0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::acl::AdminWitness<0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::core::CORE>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::allowed_versions::get_allowed_versions(arg2);
        0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::allowed_versions::assert_pkg_version(&v0);
        0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::mint::set_reveal_price(arg0, arg1);
    }

    public fun set_whitelist_max_per_person(arg0: &mut 0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::mint::Sale, arg1: u64, arg2: &0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::allowed_versions::AV, arg3: &0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::acl::AdminWitness<0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::core::CORE>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::allowed_versions::get_allowed_versions(arg2);
        0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::allowed_versions::assert_pkg_version(&v0);
        0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::mint::set_whitelist_max_per_person(arg0, arg1);
    }

    public fun set_whitelist_price(arg0: &mut 0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::mint::Sale, arg1: u64, arg2: &0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::allowed_versions::AV, arg3: &0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::acl::AdminWitness<0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::core::CORE>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::allowed_versions::get_allowed_versions(arg2);
        0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::allowed_versions::assert_pkg_version(&v0);
        0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::mint::set_whitelist_price(arg0, arg1);
    }

    public fun set_whitelist_time(arg0: &mut 0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::mint::Sale, arg1: u64, arg2: &0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::allowed_versions::AV, arg3: &0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::acl::AdminWitness<0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::core::CORE>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::allowed_versions::get_allowed_versions(arg2);
        0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::allowed_versions::assert_pkg_version(&v0);
        0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::mint::set_whitelist_time(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

