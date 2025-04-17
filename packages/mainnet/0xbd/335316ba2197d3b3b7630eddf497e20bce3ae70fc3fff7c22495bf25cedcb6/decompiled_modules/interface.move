module 0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::interface {
    public fun admin_mint_for_giveaway(arg0: &mut 0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::mint::Sale, arg1: &0x2::clock::Clock, arg2: address, arg3: u64, arg4: &0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::allowed_versions::AV, arg5: &0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::acl::AdminWitness<0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::core::CORE>, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::allowed_versions::get_allowed_versions(arg4);
        0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::allowed_versions::assert_pkg_version(&v0);
        0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::mint::admin_mint_for_giveaway(arg0, arg1, arg2, arg3, arg6);
    }

    public fun admin_mint_nft(arg0: &mut 0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::mint::Sale, arg1: &0x2::clock::Clock, arg2: &0x2::transfer_policy::TransferPolicy<0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::mystic_yeti::MysticYeti>, arg3: address, arg4: u64, arg5: &0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::allowed_versions::AV, arg6: &0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::acl::AdminWitness<0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::core::CORE>, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::allowed_versions::get_allowed_versions(arg5);
        0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::allowed_versions::assert_pkg_version(&v0);
        0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::mint::admin_mint_nft(arg0, arg1, arg2, arg3, arg4, arg7);
    }

    public fun admin_mint_specific_nft(arg0: &mut 0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::mint::Sale, arg1: &0x2::transfer_policy::TransferPolicy<0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::mystic_yeti::MysticYeti>, arg2: address, arg3: vector<u64>, arg4: &0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::allowed_versions::AV, arg5: &0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::acl::AdminWitness<0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::core::CORE>, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::allowed_versions::get_allowed_versions(arg4);
        0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::allowed_versions::assert_pkg_version(&v0);
        0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::mint::admin_mint_specific_nft(arg0, arg1, arg2, arg3, arg6);
    }

    public fun airdrop_nfts(arg0: &mut 0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::mint::Sale, arg1: &0x2::transfer_policy::TransferPolicy<0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::mystic_yeti::MysticYeti>, arg2: &0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::allowed_versions::AV, arg3: &0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::acl::AdminWitness<0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::core::CORE>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::allowed_versions::get_allowed_versions(arg2);
        0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::allowed_versions::assert_pkg_version(&v0);
        0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::mint::airdrop_nfts(arg0, arg1, arg4);
    }

    public fun airdrop_pass(arg0: address, arg1: u64, arg2: &0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::allowed_versions::AV, arg3: &0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::acl::AdminWitness<0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::core::CORE>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::allowed_versions::get_allowed_versions(arg2);
        0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::allowed_versions::assert_pkg_version(&v0);
        0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::mint::airdrop_pass(arg0, arg1, arg4);
    }

    public fun destroy(arg0: 0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::mint::Sale, arg1: &0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::allowed_versions::AV, arg2: &0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::acl::AdminWitness<0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::core::CORE>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::allowed_versions::get_allowed_versions(arg1);
        0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::allowed_versions::assert_pkg_version(&v0);
        0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::mint::destroy(arg0);
    }

    public fun extract_lofi_balance(arg0: &mut 0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::mint::Sale, arg1: u64, arg2: &0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::allowed_versions::AV, arg3: &0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::acl::AdminWitness<0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::core::CORE>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xc5c4bc11427315926cf0cc284504d8e5693a10da75500a5198bdee23f47f4254::lofi_sui::LOFI_SUI> {
        let v0 = 0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::allowed_versions::get_allowed_versions(arg2);
        0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::allowed_versions::assert_pkg_version(&v0);
        0x2::coin::from_balance<0xc5c4bc11427315926cf0cc284504d8e5693a10da75500a5198bdee23f47f4254::lofi_sui::LOFI_SUI>(0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::mint::extract_lofi_balance(arg0, arg1), arg4)
    }

    public fun extract_sui_balance(arg0: &mut 0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::mint::Sale, arg1: u64, arg2: &0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::allowed_versions::AV, arg3: &0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::acl::AdminWitness<0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::core::CORE>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::allowed_versions::get_allowed_versions(arg2);
        0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::allowed_versions::assert_pkg_version(&v0);
        0x2::coin::from_balance<0x2::sui::SUI>(0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::mint::extract_sui_balance(arg0, arg1), arg4)
    }

    public entry fun mint_presale_whitelist(arg0: &mut 0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::mint::Sale, arg1: 0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::mint::WhitelistPass, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: u64, arg5: &0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::allowed_versions::AV, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::allowed_versions::get_allowed_versions(arg5);
        0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::allowed_versions::assert_pkg_version(&v0);
        0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::mint::mint_presale_whitelist_nft(arg0, arg1, arg2, arg3, arg4, arg6);
    }

    public entry fun mint_public(arg0: &mut 0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::mint::Sale, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: u64, arg4: &0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::allowed_versions::AV, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::allowed_versions::get_allowed_versions(arg4);
        0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::allowed_versions::assert_pkg_version(&v0);
        0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::mint::mint_public_nft(arg0, arg1, arg2, arg3, arg5);
    }

    public entry fun mint_whitelist(arg0: &mut 0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::mint::Sale, arg1: 0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::mint::WhitelistPass, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: u64, arg5: &0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::allowed_versions::AV, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::allowed_versions::get_allowed_versions(arg5);
        0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::allowed_versions::assert_pkg_version(&v0);
        0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::mint::mint_whitelist_nft(arg0, arg1, arg2, arg3, arg4, arg6);
    }

    public fun nft_data_push_back(arg0: &mut 0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::mint::Sale, arg1: u64, arg2: 0x1::string::String, arg3: &mut vector<0x1::string::String>, arg4: &mut vector<0x1::string::String>, arg5: &0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::allowed_versions::AV, arg6: &0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::acl::AdminWitness<0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::core::CORE>, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::allowed_versions::get_allowed_versions(arg5);
        0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::allowed_versions::assert_pkg_version(&v0);
        0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::mint::nft_data_push_back(arg0, 0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::mystic_yeti::new_mystic_yeti_data(arg1, arg2, 0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::attributes::from_vec(arg3, arg4)));
    }

    public fun reveal_nft(arg0: &mut 0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::mint::Sale, arg1: 0x2::coin::Coin<0xc5c4bc11427315926cf0cc284504d8e5693a10da75500a5198bdee23f47f4254::lofi_sui::LOFI_SUI>, arg2: 0x2::object::ID, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: &0x2::transfer_policy::TransferPolicy<0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::mystic_yeti::MysticYeti>, arg6: 0x2::transfer::Receiving<0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::mystic_yeti::RevealData>, arg7: &0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::allowed_versions::AV, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::allowed_versions::get_allowed_versions(arg7);
        0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::allowed_versions::assert_pkg_version(&v0);
        0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::mint::reveal_nft(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg8);
    }

    public fun set_mint_open(arg0: &mut 0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::mint::Sale, arg1: bool, arg2: &0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::allowed_versions::AV, arg3: &0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::acl::AdminWitness<0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::core::CORE>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::allowed_versions::get_allowed_versions(arg2);
        0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::allowed_versions::assert_pkg_version(&v0);
        0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::mint::set_mint_open(arg0, arg1);
    }

    public fun set_presale_whitelist_max_per_person(arg0: &mut 0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::mint::Sale, arg1: u64, arg2: &0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::allowed_versions::AV, arg3: &0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::acl::AdminWitness<0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::core::CORE>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::allowed_versions::get_allowed_versions(arg2);
        0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::allowed_versions::assert_pkg_version(&v0);
        0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::mint::set_presale_whitelist_max_per_person(arg0, arg1);
    }

    public fun set_presale_whitelist_price(arg0: &mut 0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::mint::Sale, arg1: u64, arg2: &0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::allowed_versions::AV, arg3: &0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::acl::AdminWitness<0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::core::CORE>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::allowed_versions::get_allowed_versions(arg2);
        0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::allowed_versions::assert_pkg_version(&v0);
        0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::mint::set_presale_whitelist_price(arg0, arg1);
    }

    public fun set_presale_whitelist_time(arg0: &mut 0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::mint::Sale, arg1: u64, arg2: &0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::allowed_versions::AV, arg3: &0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::acl::AdminWitness<0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::core::CORE>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::allowed_versions::get_allowed_versions(arg2);
        0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::allowed_versions::assert_pkg_version(&v0);
        0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::mint::set_presale_whitelist_time(arg0, arg1);
    }

    public fun set_public_max_per_person(arg0: &mut 0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::mint::Sale, arg1: u64, arg2: &0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::allowed_versions::AV, arg3: &0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::acl::AdminWitness<0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::core::CORE>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::allowed_versions::get_allowed_versions(arg2);
        0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::allowed_versions::assert_pkg_version(&v0);
        0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::mint::set_public_max_per_person(arg0, arg1);
    }

    public fun set_public_price(arg0: &mut 0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::mint::Sale, arg1: u64, arg2: &0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::allowed_versions::AV, arg3: &0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::acl::AdminWitness<0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::core::CORE>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::allowed_versions::get_allowed_versions(arg2);
        0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::allowed_versions::assert_pkg_version(&v0);
        0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::mint::set_public_price(arg0, arg1);
    }

    public fun set_public_time(arg0: &mut 0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::mint::Sale, arg1: u64, arg2: &0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::allowed_versions::AV, arg3: &0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::acl::AdminWitness<0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::core::CORE>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::allowed_versions::get_allowed_versions(arg2);
        0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::allowed_versions::assert_pkg_version(&v0);
        0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::mint::set_public_time(arg0, arg1);
    }

    public fun set_reveal_active(arg0: &mut 0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::mint::Sale, arg1: bool, arg2: &0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::allowed_versions::AV, arg3: &0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::acl::AdminWitness<0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::core::CORE>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::allowed_versions::get_allowed_versions(arg2);
        0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::allowed_versions::assert_pkg_version(&v0);
        0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::mint::set_reveal_active(arg0, arg1);
    }

    public fun set_reveal_price(arg0: &mut 0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::mint::Sale, arg1: u64, arg2: &0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::allowed_versions::AV, arg3: &0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::acl::AdminWitness<0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::core::CORE>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::allowed_versions::get_allowed_versions(arg2);
        0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::allowed_versions::assert_pkg_version(&v0);
        0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::mint::set_reveal_price(arg0, arg1);
    }

    public fun set_whitelist_max_per_person(arg0: &mut 0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::mint::Sale, arg1: u64, arg2: &0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::allowed_versions::AV, arg3: &0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::acl::AdminWitness<0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::core::CORE>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::allowed_versions::get_allowed_versions(arg2);
        0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::allowed_versions::assert_pkg_version(&v0);
        0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::mint::set_whitelist_max_per_person(arg0, arg1);
    }

    public fun set_whitelist_price(arg0: &mut 0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::mint::Sale, arg1: u64, arg2: &0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::allowed_versions::AV, arg3: &0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::acl::AdminWitness<0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::core::CORE>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::allowed_versions::get_allowed_versions(arg2);
        0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::allowed_versions::assert_pkg_version(&v0);
        0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::mint::set_whitelist_price(arg0, arg1);
    }

    public fun set_whitelist_time(arg0: &mut 0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::mint::Sale, arg1: u64, arg2: &0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::allowed_versions::AV, arg3: &0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::acl::AdminWitness<0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::core::CORE>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::allowed_versions::get_allowed_versions(arg2);
        0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::allowed_versions::assert_pkg_version(&v0);
        0xbd335316ba2197d3b3b7630eddf497e20bce3ae70fc3fff7c22495bf25cedcb6::mint::set_whitelist_time(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

