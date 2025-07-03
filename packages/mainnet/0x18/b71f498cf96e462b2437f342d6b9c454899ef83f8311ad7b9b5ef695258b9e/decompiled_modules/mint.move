module 0x18b71f498cf96e462b2437f342d6b9c454899ef83f8311ad7b9b5ef695258b9e::mint {
    struct MINT has drop {
        dummy_field: bool,
    }

    struct MintPool has key {
        id: 0x2::object::UID,
        pfps: 0x2::table_vec::TableVec<0x18b71f498cf96e462b2437f342d6b9c454899ef83f8311ad7b9b5ef695258b9e::kila::Kila>,
        is_minting: bool,
        public_mint_price: u64,
        whitelist_mint_price: u64,
        max_num_whitelist_mints: u8,
    }

    struct SpecialMintPool has key {
        id: 0x2::object::UID,
        pfps: 0x2::object_table::ObjectTable<u16, 0x18b71f498cf96e462b2437f342d6b9c454899ef83f8311ad7b9b5ef695258b9e::kila::Kila>,
        is_minting: bool,
        mint_price: u64,
    }

    struct KilaWhitelistCap has key {
        id: 0x2::object::UID,
        max_num_whitelist_mints: u8,
        mint_used: u8,
    }

    fun add_to_public_mint_pool_internal(arg0: &mut MintPool, arg1: &SpecialMintPool, arg2: 0x18b71f498cf96e462b2437f342d6b9c454899ef83f8311ad7b9b5ef695258b9e::kila::Kila) {
        assert!(0x2::table_vec::length<0x18b71f498cf96e462b2437f342d6b9c454899ef83f8311ad7b9b5ef695258b9e::kila::Kila>(&arg0.pfps) <= 2427, 10);
        assert!(!0x2::object_table::contains<u16, 0x18b71f498cf96e462b2437f342d6b9c454899ef83f8311ad7b9b5ef695258b9e::kila::Kila>(&arg1.pfps, 0x18b71f498cf96e462b2437f342d6b9c454899ef83f8311ad7b9b5ef695258b9e::kila::get_pfp_number(&arg2)), 8);
        0x2::table_vec::push_back<0x18b71f498cf96e462b2437f342d6b9c454899ef83f8311ad7b9b5ef695258b9e::kila::Kila>(&mut arg0.pfps, arg2);
    }

    fun add_to_special_mint_pool_internal(arg0: &mut SpecialMintPool, arg1: 0x18b71f498cf96e462b2437f342d6b9c454899ef83f8311ad7b9b5ef695258b9e::kila::Kila) {
        assert!(0x2::object_table::length<u16, 0x18b71f498cf96e462b2437f342d6b9c454899ef83f8311ad7b9b5ef695258b9e::kila::Kila>(&arg0.pfps) <= 73, 11);
        assert!(!0x2::object_table::contains<u16, 0x18b71f498cf96e462b2437f342d6b9c454899ef83f8311ad7b9b5ef695258b9e::kila::Kila>(&arg0.pfps, 0x18b71f498cf96e462b2437f342d6b9c454899ef83f8311ad7b9b5ef695258b9e::kila::get_pfp_number(&arg1)), 8);
        0x2::object_table::add<u16, 0x18b71f498cf96e462b2437f342d6b9c454899ef83f8311ad7b9b5ef695258b9e::kila::Kila>(&mut arg0.pfps, 0x18b71f498cf96e462b2437f342d6b9c454899ef83f8311ad7b9b5ef695258b9e::kila::get_pfp_number(&arg1), arg1);
    }

    public fun admin_give_killa_whitelist_cap(arg0: &0x18b71f498cf96e462b2437f342d6b9c454899ef83f8311ad7b9b5ef695258b9e::admins::Admins, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x18b71f498cf96e462b2437f342d6b9c454899ef83f8311ad7b9b5ef695258b9e::admins::check_admin(arg0, arg2);
        let v0 = KilaWhitelistCap{
            id                      : 0x2::object::new(arg2),
            max_num_whitelist_mints : 4,
            mint_used               : 0,
        };
        0x2::transfer::transfer<KilaWhitelistCap>(v0, arg1);
    }

    public fun admin_make_pfp_add_to_public_mint_pool(arg0: &0x18b71f498cf96e462b2437f342d6b9c454899ef83f8311ad7b9b5ef695258b9e::admins::Admins, arg1: &mut MintPool, arg2: &SpecialMintPool, arg3: u16, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: 0x1::string::String, arg11: 0x1::string::String, arg12: &mut 0x2::tx_context::TxContext) {
        0x18b71f498cf96e462b2437f342d6b9c454899ef83f8311ad7b9b5ef695258b9e::admins::check_admin(arg0, arg12);
        assert!((arg3 as u64) <= 2427 && (arg3 as u64) > 73, 13);
        add_to_public_mint_pool_internal(arg1, arg2, 0x18b71f498cf96e462b2437f342d6b9c454899ef83f8311ad7b9b5ef695258b9e::kila::make_pfp(arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12));
    }

    public fun admin_make_pfp_add_to_special_mint_pool(arg0: &0x18b71f498cf96e462b2437f342d6b9c454899ef83f8311ad7b9b5ef695258b9e::admins::Admins, arg1: &mut SpecialMintPool, arg2: u16, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: 0x1::string::String, arg11: &mut 0x2::tx_context::TxContext) {
        0x18b71f498cf96e462b2437f342d6b9c454899ef83f8311ad7b9b5ef695258b9e::admins::check_admin(arg0, arg11);
        assert!((arg2 as u64) <= 73, 12);
        add_to_special_mint_pool_internal(arg1, 0x18b71f498cf96e462b2437f342d6b9c454899ef83f8311ad7b9b5ef695258b9e::kila::make_pfp(arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11));
    }

    public fun admin_mint_kila(arg0: &0x18b71f498cf96e462b2437f342d6b9c454899ef83f8311ad7b9b5ef695258b9e::admins::Admins, arg1: &mut MintPool, arg2: &0x2::transfer_policy::TransferPolicy<0x18b71f498cf96e462b2437f342d6b9c454899ef83f8311ad7b9b5ef695258b9e::kila::Kila>, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x18b71f498cf96e462b2437f342d6b9c454899ef83f8311ad7b9b5ef695258b9e::admins::check_admin(arg0, arg4);
        public_mint_kila_to_address_internal(arg1, arg2, arg3, arg4);
    }

    public fun admin_remove_from_special_mint_pool(arg0: &0x18b71f498cf96e462b2437f342d6b9c454899ef83f8311ad7b9b5ef695258b9e::admins::Admins, arg1: &mut SpecialMintPool, arg2: u16, arg3: &mut 0x2::tx_context::TxContext) : 0x18b71f498cf96e462b2437f342d6b9c454899ef83f8311ad7b9b5ef695258b9e::kila::Kila {
        0x18b71f498cf96e462b2437f342d6b9c454899ef83f8311ad7b9b5ef695258b9e::admins::check_admin(arg0, arg3);
        assert!(0x2::object_table::contains<u16, 0x18b71f498cf96e462b2437f342d6b9c454899ef83f8311ad7b9b5ef695258b9e::kila::Kila>(&arg1.pfps, arg2), 3);
        0x2::object_table::remove<u16, 0x18b71f498cf96e462b2437f342d6b9c454899ef83f8311ad7b9b5ef695258b9e::kila::Kila>(&mut arg1.pfps, arg2)
    }

    public fun admin_set_public_mint_price(arg0: &0x18b71f498cf96e462b2437f342d6b9c454899ef83f8311ad7b9b5ef695258b9e::admins::Admins, arg1: &mut MintPool, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x18b71f498cf96e462b2437f342d6b9c454899ef83f8311ad7b9b5ef695258b9e::admins::check_admin(arg0, arg3);
        arg1.public_mint_price = arg2;
    }

    public fun admin_set_special_mint_price(arg0: &0x18b71f498cf96e462b2437f342d6b9c454899ef83f8311ad7b9b5ef695258b9e::admins::Admins, arg1: &mut SpecialMintPool, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x18b71f498cf96e462b2437f342d6b9c454899ef83f8311ad7b9b5ef695258b9e::admins::check_admin(arg0, arg3);
        arg1.mint_price = arg2;
    }

    public fun admin_set_whitelist_mint_price(arg0: &0x18b71f498cf96e462b2437f342d6b9c454899ef83f8311ad7b9b5ef695258b9e::admins::Admins, arg1: &mut MintPool, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x18b71f498cf96e462b2437f342d6b9c454899ef83f8311ad7b9b5ef695258b9e::admins::check_admin(arg0, arg3);
        arg1.whitelist_mint_price = arg2;
    }

    public fun admin_special_mint_kila(arg0: &0x18b71f498cf96e462b2437f342d6b9c454899ef83f8311ad7b9b5ef695258b9e::admins::Admins, arg1: &mut SpecialMintPool, arg2: &0x2::transfer_policy::TransferPolicy<0x18b71f498cf96e462b2437f342d6b9c454899ef83f8311ad7b9b5ef695258b9e::kila::Kila>, arg3: address, arg4: u16, arg5: &mut 0x2::tx_context::TxContext) {
        0x18b71f498cf96e462b2437f342d6b9c454899ef83f8311ad7b9b5ef695258b9e::admins::check_admin(arg0, arg5);
        assert!(0x2::object_table::contains<u16, 0x18b71f498cf96e462b2437f342d6b9c454899ef83f8311ad7b9b5ef695258b9e::kila::Kila>(&arg1.pfps, arg4), 3);
        special_mint_to_address_internal(arg1, arg3, arg4, arg2, arg5);
    }

    public fun admin_start_public_minting(arg0: &0x18b71f498cf96e462b2437f342d6b9c454899ef83f8311ad7b9b5ef695258b9e::admins::Admins, arg1: &mut MintPool, arg2: &mut 0x2::tx_context::TxContext) {
        0x18b71f498cf96e462b2437f342d6b9c454899ef83f8311ad7b9b5ef695258b9e::admins::check_admin(arg0, arg2);
        assert!(arg1.is_minting == false, 6);
        arg1.is_minting = true;
    }

    public fun admin_start_special_minting(arg0: &0x18b71f498cf96e462b2437f342d6b9c454899ef83f8311ad7b9b5ef695258b9e::admins::Admins, arg1: &mut SpecialMintPool, arg2: &mut 0x2::tx_context::TxContext) {
        0x18b71f498cf96e462b2437f342d6b9c454899ef83f8311ad7b9b5ef695258b9e::admins::check_admin(arg0, arg2);
        assert!(arg1.is_minting == false, 6);
        arg1.is_minting = true;
    }

    public fun admin_stop_public_minting(arg0: &0x18b71f498cf96e462b2437f342d6b9c454899ef83f8311ad7b9b5ef695258b9e::admins::Admins, arg1: &mut MintPool, arg2: &mut 0x2::tx_context::TxContext) {
        0x18b71f498cf96e462b2437f342d6b9c454899ef83f8311ad7b9b5ef695258b9e::admins::check_admin(arg0, arg2);
        assert!(arg1.is_minting == true, 7);
        arg1.is_minting = false;
    }

    public fun admin_stop_special_minting(arg0: &0x18b71f498cf96e462b2437f342d6b9c454899ef83f8311ad7b9b5ef695258b9e::admins::Admins, arg1: &mut SpecialMintPool, arg2: &mut 0x2::tx_context::TxContext) {
        0x18b71f498cf96e462b2437f342d6b9c454899ef83f8311ad7b9b5ef695258b9e::admins::check_admin(arg0, arg2);
        assert!(arg1.is_minting == true, 7);
        arg1.is_minting = false;
    }

    fun init(arg0: MINT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = MintPool{
            id                      : 0x2::object::new(arg1),
            pfps                    : 0x2::table_vec::empty<0x18b71f498cf96e462b2437f342d6b9c454899ef83f8311ad7b9b5ef695258b9e::kila::Kila>(arg1),
            is_minting              : false,
            public_mint_price       : 3000000000,
            whitelist_mint_price    : 1500000000,
            max_num_whitelist_mints : 4,
        };
        let v1 = SpecialMintPool{
            id         : 0x2::object::new(arg1),
            pfps       : 0x2::object_table::new<u16, 0x18b71f498cf96e462b2437f342d6b9c454899ef83f8311ad7b9b5ef695258b9e::kila::Kila>(arg1),
            is_minting : false,
            mint_price : 0,
        };
        0x2::transfer::share_object<MintPool>(v0);
        0x2::transfer::share_object<SpecialMintPool>(v1);
    }

    public fun public_mint(arg0: &mut MintPool, arg1: &0x2::transfer_policy::TransferPolicy<0x18b71f498cf96e462b2437f342d6b9c454899ef83f8311ad7b9b5ef695258b9e::kila::Kila>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.is_minting == true, 7);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) > 0, 1);
        public_mint_internal(arg0, arg1, arg2, arg3);
    }

    fun public_mint_internal(arg0: &mut MintPool, arg1: &0x2::transfer_policy::TransferPolicy<0x18b71f498cf96e462b2437f342d6b9c454899ef83f8311ad7b9b5ef695258b9e::kila::Kila>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::kiosk::new(arg3);
        let v2 = v1;
        let v3 = v0;
        let v4 = 0x2::table_vec::pop_back<0x18b71f498cf96e462b2437f342d6b9c454899ef83f8311ad7b9b5ef695258b9e::kila::Kila>(&mut arg0.pfps);
        0x18b71f498cf96e462b2437f342d6b9c454899ef83f8311ad7b9b5ef695258b9e::kila::set_minted_by(&mut v4, 0x2::tx_context::sender(arg3));
        0x2::kiosk::lock<0x18b71f498cf96e462b2437f342d6b9c454899ef83f8311ad7b9b5ef695258b9e::kila::Kila>(&mut v3, &v2, arg1, v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, @0x73e82e0c4c5f25a3607e4a58ce6b178c2ce77f568508fa65b03a9157d5144a1f);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v2, 0x2::tx_context::sender(arg3));
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v3);
    }

    fun public_mint_kila_to_address_internal(arg0: &mut MintPool, arg1: &0x2::transfer_policy::TransferPolicy<0x18b71f498cf96e462b2437f342d6b9c454899ef83f8311ad7b9b5ef695258b9e::kila::Kila>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::table_vec::pop_back<0x18b71f498cf96e462b2437f342d6b9c454899ef83f8311ad7b9b5ef695258b9e::kila::Kila>(&mut arg0.pfps);
        0x18b71f498cf96e462b2437f342d6b9c454899ef83f8311ad7b9b5ef695258b9e::kila::set_minted_by(&mut v0, 0x2::tx_context::sender(arg3));
        let (v1, v2) = 0x2::kiosk::new(arg3);
        let v3 = v2;
        let v4 = v1;
        0x2::kiosk::lock<0x18b71f498cf96e462b2437f342d6b9c454899ef83f8311ad7b9b5ef695258b9e::kila::Kila>(&mut v4, &v3, arg1, v0);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v3, arg2);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v4);
    }

    public fun special_mint(arg0: &mut SpecialMintPool, arg1: u16, arg2: &0x2::transfer_policy::TransferPolicy<0x18b71f498cf96e462b2437f342d6b9c454899ef83f8311ad7b9b5ef695258b9e::kila::Kila>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.is_minting == true, 7);
        assert!(0x2::object_table::contains<u16, 0x18b71f498cf96e462b2437f342d6b9c454899ef83f8311ad7b9b5ef695258b9e::kila::Kila>(&arg0.pfps, arg1), 3);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) > 0, 1);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) == arg0.mint_price, 2);
        special_mint_internal(arg0, arg1, arg2, arg3, arg4);
    }

    fun special_mint_internal(arg0: &mut SpecialMintPool, arg1: u16, arg2: &0x2::transfer_policy::TransferPolicy<0x18b71f498cf96e462b2437f342d6b9c454899ef83f8311ad7b9b5ef695258b9e::kila::Kila>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object_table::remove<u16, 0x18b71f498cf96e462b2437f342d6b9c454899ef83f8311ad7b9b5ef695258b9e::kila::Kila>(&mut arg0.pfps, arg1);
        0x18b71f498cf96e462b2437f342d6b9c454899ef83f8311ad7b9b5ef695258b9e::kila::set_minted_by(&mut v0, 0x2::tx_context::sender(arg4));
        let (v1, v2) = 0x2::kiosk::new(arg4);
        let v3 = v2;
        let v4 = v1;
        0x2::kiosk::lock<0x18b71f498cf96e462b2437f342d6b9c454899ef83f8311ad7b9b5ef695258b9e::kila::Kila>(&mut v4, &v3, arg2, v0);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v3, 0x2::tx_context::sender(arg4));
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, @0x73e82e0c4c5f25a3607e4a58ce6b178c2ce77f568508fa65b03a9157d5144a1f);
    }

    fun special_mint_to_address_internal(arg0: &mut SpecialMintPool, arg1: address, arg2: u16, arg3: &0x2::transfer_policy::TransferPolicy<0x18b71f498cf96e462b2437f342d6b9c454899ef83f8311ad7b9b5ef695258b9e::kila::Kila>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object_table::remove<u16, 0x18b71f498cf96e462b2437f342d6b9c454899ef83f8311ad7b9b5ef695258b9e::kila::Kila>(&mut arg0.pfps, arg2);
        0x18b71f498cf96e462b2437f342d6b9c454899ef83f8311ad7b9b5ef695258b9e::kila::set_minted_by(&mut v0, 0x2::tx_context::sender(arg4));
        let (v1, v2) = 0x2::kiosk::new(arg4);
        let v3 = v2;
        let v4 = v1;
        0x2::kiosk::lock<0x18b71f498cf96e462b2437f342d6b9c454899ef83f8311ad7b9b5ef695258b9e::kila::Kila>(&mut v4, &v3, arg3, v0);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v3, arg1);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v4);
    }

    public fun whitelist_mint(arg0: &mut MintPool, arg1: &0x2::transfer_policy::TransferPolicy<0x18b71f498cf96e462b2437f342d6b9c454899ef83f8311ad7b9b5ef695258b9e::kila::Kila>, arg2: KilaWhitelistCap, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.is_minting == true, 7);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) > 0, 1);
        assert!(arg2.mint_used <= arg2.max_num_whitelist_mints, 9);
        whitelist_mint_internal(arg0, arg1, arg3, arg2, arg4);
    }

    fun whitelist_mint_internal(arg0: &mut MintPool, arg1: &0x2::transfer_policy::TransferPolicy<0x18b71f498cf96e462b2437f342d6b9c454899ef83f8311ad7b9b5ef695258b9e::kila::Kila>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: KilaWhitelistCap, arg4: &mut 0x2::tx_context::TxContext) {
        public_mint_internal(arg0, arg1, arg2, arg4);
        if (arg3.mint_used == arg3.max_num_whitelist_mints - 1) {
            let KilaWhitelistCap {
                id                      : v0,
                max_num_whitelist_mints : _,
                mint_used               : _,
            } = arg3;
            0x2::object::delete(v0);
        } else {
            arg3.mint_used = arg3.mint_used + 1;
            0x2::transfer::transfer<KilaWhitelistCap>(arg3, 0x2::tx_context::sender(arg4));
        };
    }

    // decompiled from Move bytecode v6
}

