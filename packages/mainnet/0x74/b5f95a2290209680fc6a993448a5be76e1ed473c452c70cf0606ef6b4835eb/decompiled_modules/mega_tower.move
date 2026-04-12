module 0x74b5f95a2290209680fc6a993448a5be76e1ed473c452c70cf0606ef6b4835eb::mega_tower {
    struct MEGA_TOWER has drop {
        dummy_field: bool,
    }

    public entry fun purchase(arg0: &mut 0x2::kiosk::Kiosk, arg1: &mut 0x2::transfer_policy::TransferPolicy<0x74b5f95a2290209680fc6a993448a5be76e1ed473c452c70cf0606ef6b4835eb::nft::MegaTowerNFT>, arg2: 0x2::object::ID, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x2::kiosk::Kiosk, arg6: &0x2::kiosk::KioskOwnerCap, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::kiosk::purchase<0x74b5f95a2290209680fc6a993448a5be76e1ed473c452c70cf0606ef6b4835eb::nft::MegaTowerNFT>(arg0, arg2, arg3);
        let v2 = v1;
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::pay<0x74b5f95a2290209680fc6a993448a5be76e1ed473c452c70cf0606ef6b4835eb::nft::MegaTowerNFT>(arg1, &mut v2, 0x2::coin::split<0x2::sui::SUI>(arg4, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::fee_amount<0x74b5f95a2290209680fc6a993448a5be76e1ed473c452c70cf0606ef6b4835eb::nft::MegaTowerNFT>(arg1, 0x2::transfer_policy::paid<0x74b5f95a2290209680fc6a993448a5be76e1ed473c452c70cf0606ef6b4835eb::nft::MegaTowerNFT>(&v2)), arg7));
        0x2::kiosk::lock<0x74b5f95a2290209680fc6a993448a5be76e1ed473c452c70cf0606ef6b4835eb::nft::MegaTowerNFT>(arg5, arg6, arg1, v0);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::prove<0x74b5f95a2290209680fc6a993448a5be76e1ed473c452c70cf0606ef6b4835eb::nft::MegaTowerNFT>(&mut v2, arg5);
        let (_, _, _) = 0x2::transfer_policy::confirm_request<0x74b5f95a2290209680fc6a993448a5be76e1ed473c452c70cf0606ef6b4835eb::nft::MegaTowerNFT>(arg1, v2);
    }

    public entry fun withdraw_royalty(arg0: &0x74b5f95a2290209680fc6a993448a5be76e1ed473c452c70cf0606ef6b4835eb::admin::AdminCap, arg1: &0x74b5f95a2290209680fc6a993448a5be76e1ed473c452c70cf0606ef6b4835eb::roles::RoleRegistry, arg2: &mut 0x2::transfer_policy::TransferPolicy<0x74b5f95a2290209680fc6a993448a5be76e1ed473c452c70cf0606ef6b4835eb::nft::MegaTowerNFT>, arg3: &0x2::transfer_policy::TransferPolicyCap<0x74b5f95a2290209680fc6a993448a5be76e1ed473c452c70cf0606ef6b4835eb::nft::MegaTowerNFT>, arg4: 0x1::option::Option<u64>, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        0x74b5f95a2290209680fc6a993448a5be76e1ed473c452c70cf0606ef6b4835eb::roles::assert_not_frozen(arg1);
        0x74b5f95a2290209680fc6a993448a5be76e1ed473c452c70cf0606ef6b4835eb::roles::assert_admin(arg1, arg0);
        0x74b5f95a2290209680fc6a993448a5be76e1ed473c452c70cf0606ef6b4835eb::roles::assert_policy(arg1, arg3);
        0x74b5f95a2290209680fc6a993448a5be76e1ed473c452c70cf0606ef6b4835eb::admin::withdraw_royalty(arg0, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun update_authority_config(arg0: &0x74b5f95a2290209680fc6a993448a5be76e1ed473c452c70cf0606ef6b4835eb::admin::AdminCap, arg1: &0x74b5f95a2290209680fc6a993448a5be76e1ed473c452c70cf0606ef6b4835eb::roles::RoleRegistry, arg2: &mut 0x74b5f95a2290209680fc6a993448a5be76e1ed473c452c70cf0606ef6b4835eb::authority_config::AuthorityConfig, arg3: vector<u8>) {
        0x74b5f95a2290209680fc6a993448a5be76e1ed473c452c70cf0606ef6b4835eb::roles::assert_admin(arg1, arg0);
        0x74b5f95a2290209680fc6a993448a5be76e1ed473c452c70cf0606ef6b4835eb::authority_config::update_authority_config(arg0, arg2, arg3);
    }

    fun build_attributes(arg0: vector<0x1::string::String>, arg1: vector<0x1::string::String>) : 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String> {
        let v0 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
        let v1 = 0;
        let v2 = 0x1::vector::length<0x1::string::String>(&arg0);
        assert!(v2 == 0x1::vector::length<0x1::string::String>(&arg1), 0);
        while (v1 < v2) {
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, *0x1::vector::borrow<0x1::string::String>(&arg0, v1), *0x1::vector::borrow<0x1::string::String>(&arg1, v1));
            v1 = v1 + 1;
        };
        v0
    }

    fun init(arg0: MEGA_TOWER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x74b5f95a2290209680fc6a993448a5be76e1ed473c452c70cf0606ef6b4835eb::roles::init_root_cap(arg1);
        let v2 = 0x74b5f95a2290209680fc6a993448a5be76e1ed473c452c70cf0606ef6b4835eb::admin::init_admin_cap(arg1);
        let v3 = 0x2::package::claim<MEGA_TOWER>(arg0, arg1);
        let (v4, v5) = 0x2::transfer_policy::new<0x74b5f95a2290209680fc6a993448a5be76e1ed473c452c70cf0606ef6b4835eb::nft::MegaTowerNFT>(&v3, arg1);
        let v6 = v5;
        let v7 = v4;
        0x74b5f95a2290209680fc6a993448a5be76e1ed473c452c70cf0606ef6b4835eb::authority_config::init_authority_config(&v2, arg1);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::add<0x74b5f95a2290209680fc6a993448a5be76e1ed473c452c70cf0606ef6b4835eb::nft::MegaTowerNFT>(&mut v7, &v6, 0x74b5f95a2290209680fc6a993448a5be76e1ed473c452c70cf0606ef6b4835eb::constants::royalty_bp(), 0x74b5f95a2290209680fc6a993448a5be76e1ed473c452c70cf0606ef6b4835eb::constants::min_royalty_amount());
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::add<0x74b5f95a2290209680fc6a993448a5be76e1ed473c452c70cf0606ef6b4835eb::nft::MegaTowerNFT>(&mut v7, &v6);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<0x74b5f95a2290209680fc6a993448a5be76e1ed473c452c70cf0606ef6b4835eb::nft::MegaTowerNFT>>(v7);
        0x2::transfer::public_share_object<0x74b5f95a2290209680fc6a993448a5be76e1ed473c452c70cf0606ef6b4835eb::roles::RoleRegistry>(0x74b5f95a2290209680fc6a993448a5be76e1ed473c452c70cf0606ef6b4835eb::roles::init_role_registry(&v2, &v6, &v1, arg1));
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<0x74b5f95a2290209680fc6a993448a5be76e1ed473c452c70cf0606ef6b4835eb::nft::MegaTowerNFT>>(v6, v0);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v3, v0);
        0x2::transfer::public_transfer<0x74b5f95a2290209680fc6a993448a5be76e1ed473c452c70cf0606ef6b4835eb::roles::MainRootCap>(0x74b5f95a2290209680fc6a993448a5be76e1ed473c452c70cf0606ef6b4835eb::roles::init_main_root_cap(arg1), v0);
        0x2::transfer::public_transfer<0x74b5f95a2290209680fc6a993448a5be76e1ed473c452c70cf0606ef6b4835eb::roles::RootCap>(v1, v0);
        0x74b5f95a2290209680fc6a993448a5be76e1ed473c452c70cf0606ef6b4835eb::admin::transfer_admin_cap(v2, v0);
    }

    public entry fun mint(arg0: &0x74b5f95a2290209680fc6a993448a5be76e1ed473c452c70cf0606ef6b4835eb::admin::AdminCap, arg1: &0x74b5f95a2290209680fc6a993448a5be76e1ed473c452c70cf0606ef6b4835eb::roles::RoleRegistry, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: vector<0x1::string::String>, arg6: vector<0x1::string::String>, arg7: address, arg8: &mut 0x2::tx_context::TxContext) {
        0x74b5f95a2290209680fc6a993448a5be76e1ed473c452c70cf0606ef6b4835eb::roles::assert_not_frozen(arg1);
        0x74b5f95a2290209680fc6a993448a5be76e1ed473c452c70cf0606ef6b4835eb::roles::assert_admin(arg1, arg0);
        0x2::transfer::public_transfer<0x74b5f95a2290209680fc6a993448a5be76e1ed473c452c70cf0606ef6b4835eb::nft::MegaTowerNFT>(0x74b5f95a2290209680fc6a993448a5be76e1ed473c452c70cf0606ef6b4835eb::nft::mint(arg2, arg3, arg4, build_attributes(arg5, arg6), arg8), arg7);
    }

    public entry fun update_image_url(arg0: &mut 0x74b5f95a2290209680fc6a993448a5be76e1ed473c452c70cf0606ef6b4835eb::nft::MegaTowerNFT, arg1: &0x74b5f95a2290209680fc6a993448a5be76e1ed473c452c70cf0606ef6b4835eb::roles::RoleRegistry, arg2: &0x74b5f95a2290209680fc6a993448a5be76e1ed473c452c70cf0606ef6b4835eb::authority_config::AuthorityConfig, arg3: 0x1::string::String, arg4: u64, arg5: vector<u8>) {
        0x74b5f95a2290209680fc6a993448a5be76e1ed473c452c70cf0606ef6b4835eb::roles::assert_not_frozen(arg1);
        assert!(arg4 > 0x74b5f95a2290209680fc6a993448a5be76e1ed473c452c70cf0606ef6b4835eb::nft::last_nonce(arg0), 2);
        let v0 = 0x74b5f95a2290209680fc6a993448a5be76e1ed473c452c70cf0606ef6b4835eb::utils::build_update_image_signed_data(0x74b5f95a2290209680fc6a993448a5be76e1ed473c452c70cf0606ef6b4835eb::nft::id(arg0), &arg3, arg4);
        assert!(0x74b5f95a2290209680fc6a993448a5be76e1ed473c452c70cf0606ef6b4835eb::utils::verify_ed25519_signature(&arg5, 0x74b5f95a2290209680fc6a993448a5be76e1ed473c452c70cf0606ef6b4835eb::authority_config::authority_pubkey(arg2), &v0), 1);
        0x74b5f95a2290209680fc6a993448a5be76e1ed473c452c70cf0606ef6b4835eb::nft::update_image_url(arg0, arg3);
        0x74b5f95a2290209680fc6a993448a5be76e1ed473c452c70cf0606ef6b4835eb::nft::set_last_nonce(arg0, arg4);
    }

    public entry fun update_traits(arg0: &mut 0x74b5f95a2290209680fc6a993448a5be76e1ed473c452c70cf0606ef6b4835eb::nft::MegaTowerNFT, arg1: &0x74b5f95a2290209680fc6a993448a5be76e1ed473c452c70cf0606ef6b4835eb::roles::RoleRegistry, arg2: &0x74b5f95a2290209680fc6a993448a5be76e1ed473c452c70cf0606ef6b4835eb::authority_config::AuthorityConfig, arg3: vector<0x1::string::String>, arg4: vector<0x1::string::String>, arg5: u64, arg6: vector<u8>) {
        0x74b5f95a2290209680fc6a993448a5be76e1ed473c452c70cf0606ef6b4835eb::roles::assert_not_frozen(arg1);
        assert!(arg5 > 0x74b5f95a2290209680fc6a993448a5be76e1ed473c452c70cf0606ef6b4835eb::nft::last_nonce(arg0), 2);
        let v0 = 0x74b5f95a2290209680fc6a993448a5be76e1ed473c452c70cf0606ef6b4835eb::utils::build_update_traits_signed_data(0x74b5f95a2290209680fc6a993448a5be76e1ed473c452c70cf0606ef6b4835eb::nft::id(arg0), &arg3, &arg4, arg5);
        assert!(0x74b5f95a2290209680fc6a993448a5be76e1ed473c452c70cf0606ef6b4835eb::utils::verify_ed25519_signature(&arg6, 0x74b5f95a2290209680fc6a993448a5be76e1ed473c452c70cf0606ef6b4835eb::authority_config::authority_pubkey(arg2), &v0), 1);
        0x74b5f95a2290209680fc6a993448a5be76e1ed473c452c70cf0606ef6b4835eb::nft::update_attributes(arg0, build_attributes(arg3, arg4));
        0x74b5f95a2290209680fc6a993448a5be76e1ed473c452c70cf0606ef6b4835eb::nft::set_last_nonce(arg0, arg5);
    }

    // decompiled from Move bytecode v7
}

