module 0x23fb7ba6ba9a0b1b66573563f208c169750ec6d7844e77295c8f31ceec258056::chakra_nft {
    struct CHAKRA_NFT has drop {
        dummy_field: bool,
    }

    struct ChakraNFT has key {
        id: 0x2::object::UID,
        number: u64,
        minted_by: address,
        referral_codes: u64,
        maya_burnt: u64,
    }

    struct GlobalConfig has key {
        id: 0x2::object::UID,
        status: bool,
        payments: 0x2::balance::Balance<0x2::sui::SUI>,
        base_price: u64,
        referral_price: u64,
        user_to_nft: 0x2::table::Table<address, 0x2::object::ID>,
        nft_to_user: 0x2::table::Table<0x2::object::ID, address>,
        referral_codes: 0x2::table::Table<u64, u64>,
        free_wl: 0x2::table::Table<address, bool>,
        boost_a_whitelists: 0x2::table::Table<address, bool>,
        boost_b_whitelists: 0x2::table::Table<address, bool>,
        boost_c_whitelists: 0x2::table::Table<address, bool>,
        boost_d_whitelists: 0x2::table::Table<address, bool>,
        boost_e_whitelists: 0x2::table::Table<address, bool>,
        boost_f_whitelists: 0x2::table::Table<address, bool>,
        boost_a: u64,
        boost_b: u64,
        boost_c: u64,
        boost_d: u64,
        boost_e: u64,
        boost_f: u64,
        count: u64,
        used_referral_count: u64,
    }

    public(friend) fun id(arg0: &ChakraNFT) : 0x2::object::ID {
        0x2::object::id<ChakraNFT>(arg0)
    }

    public fun transfer(arg0: ChakraNFT) {
        0x2::transfer::transfer<ChakraNFT>(arg0, arg0.minted_by);
    }

    public(friend) fun add_maya_burnt(arg0: &mut ChakraNFT, arg1: u64) {
        arg0.maya_burnt = arg0.maya_burnt + arg1;
    }

    public(friend) fun add_payment(arg0: &mut GlobalConfig, arg1: 0x2::balance::Balance<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.payments, arg1);
    }

    public(friend) fun add_referral_code(arg0: &mut GlobalConfig, arg1: &mut ChakraNFT, arg2: u64) {
        assert!(arg2 > 0, 0);
        assert!(!0x2::table::contains<u64, u64>(&arg0.referral_codes, arg2), 4);
        0x2::table::add<u64, u64>(&mut arg0.referral_codes, arg2, 7);
        arg1.referral_codes = arg2;
    }

    public fun admin_set_base_price(arg0: &0x23fb7ba6ba9a0b1b66573563f208c169750ec6d7844e77295c8f31ceec258056::admin::AdminCap, arg1: u64, arg2: &mut GlobalConfig, arg3: &0x2::tx_context::TxContext) {
        arg2.base_price = arg1;
    }

    public fun admin_set_boost_a(arg0: &0x23fb7ba6ba9a0b1b66573563f208c169750ec6d7844e77295c8f31ceec258056::admin::AdminCap, arg1: u64, arg2: &mut GlobalConfig, arg3: &0x2::tx_context::TxContext) {
        arg2.boost_a = arg1;
    }

    public fun admin_set_boost_b(arg0: &0x23fb7ba6ba9a0b1b66573563f208c169750ec6d7844e77295c8f31ceec258056::admin::AdminCap, arg1: u64, arg2: &mut GlobalConfig, arg3: &0x2::tx_context::TxContext) {
        arg2.boost_b = arg1;
    }

    public fun admin_set_boost_c(arg0: &0x23fb7ba6ba9a0b1b66573563f208c169750ec6d7844e77295c8f31ceec258056::admin::AdminCap, arg1: u64, arg2: &mut GlobalConfig, arg3: &0x2::tx_context::TxContext) {
        arg2.boost_c = arg1;
    }

    public fun admin_set_boost_d(arg0: &0x23fb7ba6ba9a0b1b66573563f208c169750ec6d7844e77295c8f31ceec258056::admin::AdminCap, arg1: u64, arg2: &mut GlobalConfig, arg3: &0x2::tx_context::TxContext) {
        arg2.boost_d = arg1;
    }

    public fun admin_set_boost_e(arg0: &0x23fb7ba6ba9a0b1b66573563f208c169750ec6d7844e77295c8f31ceec258056::admin::AdminCap, arg1: u64, arg2: &mut GlobalConfig, arg3: &0x2::tx_context::TxContext) {
        arg2.boost_e = arg1;
    }

    public fun admin_set_boost_f(arg0: &0x23fb7ba6ba9a0b1b66573563f208c169750ec6d7844e77295c8f31ceec258056::admin::AdminCap, arg1: u64, arg2: &mut GlobalConfig, arg3: &0x2::tx_context::TxContext) {
        arg2.boost_f = arg1;
    }

    public fun admin_set_referral_price(arg0: &0x23fb7ba6ba9a0b1b66573563f208c169750ec6d7844e77295c8f31ceec258056::admin::AdminCap, arg1: u64, arg2: &mut GlobalConfig, arg3: &0x2::tx_context::TxContext) {
        arg2.referral_price = arg1;
    }

    public fun admin_set_status(arg0: &0x23fb7ba6ba9a0b1b66573563f208c169750ec6d7844e77295c8f31ceec258056::admin::AdminCap, arg1: bool, arg2: &mut GlobalConfig, arg3: &0x2::tx_context::TxContext) {
        arg2.status = arg1;
    }

    public fun base_price(arg0: &GlobalConfig) : u64 {
        arg0.base_price
    }

    public fun batch_update_a(arg0: &0x23fb7ba6ba9a0b1b66573563f208c169750ec6d7844e77295c8f31ceec258056::admin::AdminCap, arg1: &mut GlobalConfig, arg2: vector<address>, arg3: bool, arg4: &0x2::tx_context::TxContext) {
        while (!0x1::vector::is_empty<address>(&arg2)) {
            let v0 = 0x1::vector::pop_back<address>(&mut arg2);
            let v1 = 0x2::table::contains<address, bool>(&arg1.boost_a_whitelists, v0);
            if (arg3) {
                if (!v1) {
                    0x2::table::add<address, bool>(&mut arg1.boost_a_whitelists, v0, true);
                    continue
                } else {
                    continue
                };
            };
            if (v1) {
                0x2::table::remove<address, bool>(&mut arg1.boost_a_whitelists, v0);
            };
        };
        0x1::vector::destroy_empty<address>(arg2);
    }

    public fun batch_update_b(arg0: &0x23fb7ba6ba9a0b1b66573563f208c169750ec6d7844e77295c8f31ceec258056::admin::AdminCap, arg1: &mut GlobalConfig, arg2: vector<address>, arg3: bool, arg4: &0x2::tx_context::TxContext) {
        while (!0x1::vector::is_empty<address>(&arg2)) {
            let v0 = 0x1::vector::pop_back<address>(&mut arg2);
            let v1 = 0x2::table::contains<address, bool>(&arg1.boost_b_whitelists, v0);
            if (arg3) {
                if (!v1) {
                    0x2::table::add<address, bool>(&mut arg1.boost_b_whitelists, v0, true);
                    continue
                } else {
                    continue
                };
            };
            if (v1) {
                0x2::table::remove<address, bool>(&mut arg1.boost_b_whitelists, v0);
            };
        };
        0x1::vector::destroy_empty<address>(arg2);
    }

    public fun batch_update_c(arg0: &0x23fb7ba6ba9a0b1b66573563f208c169750ec6d7844e77295c8f31ceec258056::admin::AdminCap, arg1: &mut GlobalConfig, arg2: vector<address>, arg3: bool, arg4: &0x2::tx_context::TxContext) {
        while (!0x1::vector::is_empty<address>(&arg2)) {
            let v0 = 0x1::vector::pop_back<address>(&mut arg2);
            let v1 = 0x2::table::contains<address, bool>(&arg1.boost_c_whitelists, v0);
            if (arg3) {
                if (!v1) {
                    0x2::table::add<address, bool>(&mut arg1.boost_c_whitelists, v0, true);
                    continue
                } else {
                    continue
                };
            };
            if (v1) {
                0x2::table::remove<address, bool>(&mut arg1.boost_c_whitelists, v0);
            };
        };
        0x1::vector::destroy_empty<address>(arg2);
    }

    public fun batch_update_d(arg0: &0x23fb7ba6ba9a0b1b66573563f208c169750ec6d7844e77295c8f31ceec258056::admin::AdminCap, arg1: &mut GlobalConfig, arg2: vector<address>, arg3: bool, arg4: &0x2::tx_context::TxContext) {
        while (!0x1::vector::is_empty<address>(&arg2)) {
            let v0 = 0x1::vector::pop_back<address>(&mut arg2);
            let v1 = 0x2::table::contains<address, bool>(&arg1.boost_d_whitelists, v0);
            if (arg3) {
                if (!v1) {
                    0x2::table::add<address, bool>(&mut arg1.boost_d_whitelists, v0, true);
                    continue
                } else {
                    continue
                };
            };
            if (v1) {
                0x2::table::remove<address, bool>(&mut arg1.boost_d_whitelists, v0);
            };
        };
        0x1::vector::destroy_empty<address>(arg2);
    }

    public fun batch_update_e(arg0: &0x23fb7ba6ba9a0b1b66573563f208c169750ec6d7844e77295c8f31ceec258056::admin::AdminCap, arg1: &mut GlobalConfig, arg2: vector<address>, arg3: bool, arg4: &0x2::tx_context::TxContext) {
        while (!0x1::vector::is_empty<address>(&arg2)) {
            let v0 = 0x1::vector::pop_back<address>(&mut arg2);
            let v1 = 0x2::table::contains<address, bool>(&arg1.boost_e_whitelists, v0);
            if (arg3) {
                if (!v1) {
                    0x2::table::add<address, bool>(&mut arg1.boost_e_whitelists, v0, true);
                    continue
                } else {
                    continue
                };
            };
            if (v1) {
                0x2::table::remove<address, bool>(&mut arg1.boost_e_whitelists, v0);
            };
        };
        0x1::vector::destroy_empty<address>(arg2);
    }

    public fun batch_update_f(arg0: &0x23fb7ba6ba9a0b1b66573563f208c169750ec6d7844e77295c8f31ceec258056::admin::AdminCap, arg1: &mut GlobalConfig, arg2: vector<address>, arg3: bool, arg4: &0x2::tx_context::TxContext) {
        while (!0x1::vector::is_empty<address>(&arg2)) {
            let v0 = 0x1::vector::pop_back<address>(&mut arg2);
            let v1 = 0x2::table::contains<address, bool>(&arg1.boost_f_whitelists, v0);
            if (arg3) {
                if (!v1) {
                    0x2::table::add<address, bool>(&mut arg1.boost_f_whitelists, v0, true);
                    continue
                } else {
                    continue
                };
            };
            if (v1) {
                0x2::table::remove<address, bool>(&mut arg1.boost_f_whitelists, v0);
            };
        };
        0x1::vector::destroy_empty<address>(arg2);
    }

    public fun batch_update_free_wl(arg0: &0x23fb7ba6ba9a0b1b66573563f208c169750ec6d7844e77295c8f31ceec258056::admin::AdminCap, arg1: &mut GlobalConfig, arg2: vector<address>, arg3: bool, arg4: &0x2::tx_context::TxContext) {
        while (!0x1::vector::is_empty<address>(&arg2)) {
            let v0 = 0x1::vector::pop_back<address>(&mut arg2);
            let v1 = 0x2::table::contains<address, bool>(&arg1.free_wl, v0);
            if (arg3) {
                if (!v1) {
                    0x2::table::add<address, bool>(&mut arg1.free_wl, v0, true);
                    continue
                } else {
                    continue
                };
            };
            if (v1) {
                0x2::table::remove<address, bool>(&mut arg1.free_wl, v0);
            };
        };
        0x1::vector::destroy_empty<address>(arg2);
    }

    public fun boost_a(arg0: &GlobalConfig) : u64 {
        arg0.boost_a
    }

    public fun boost_b(arg0: &GlobalConfig) : u64 {
        arg0.boost_b
    }

    public fun boost_c(arg0: &GlobalConfig) : u64 {
        arg0.boost_c
    }

    public fun boost_d(arg0: &GlobalConfig) : u64 {
        arg0.boost_d
    }

    public fun boost_e(arg0: &GlobalConfig) : u64 {
        arg0.boost_e
    }

    public fun boost_f(arg0: &GlobalConfig) : u64 {
        arg0.boost_f
    }

    public fun count(arg0: &GlobalConfig) : u64 {
        arg0.count
    }

    public(friend) fun create(arg0: &mut GlobalConfig, arg1: &mut 0x2::tx_context::TxContext) : ChakraNFT {
        arg0.count = arg0.count + 1;
        ChakraNFT{
            id             : 0x2::object::new(arg1),
            number         : arg0.count,
            minted_by      : 0x2::tx_context::sender(arg1),
            referral_codes : 0,
            maya_burnt     : 0,
        }
    }

    public fun get_user_by_nftId(arg0: &GlobalConfig, arg1: 0x2::object::ID) : address {
        *0x2::table::borrow<0x2::object::ID, address>(&arg0.nft_to_user, arg1)
    }

    public(friend) fun increment_used_referral_count(arg0: &mut GlobalConfig) {
        arg0.used_referral_count = arg0.used_referral_count + 1;
    }

    fun init(arg0: CHAKRA_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<CHAKRA_NFT>(arg0, arg1);
        let v1 = 0x2::display::new<ChakraNFT>(&v0, arg1);
        0x2::display::add<ChakraNFT>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"ChakraNFT #{number}"));
        0x2::display::add<ChakraNFT>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"ChakraNFT #{number}"));
        0x2::display::add<ChakraNFT>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"https://kriya-assets.s3.ap-southeast-1.amazonaws.com/assets/{points}.png"));
        0x2::display::add<ChakraNFT>(&mut v1, 0x1::string::utf8(b"minted_by"), 0x1::string::utf8(b"{minted_by}"));
        0x2::display::add<ChakraNFT>(&mut v1, 0x1::string::utf8(b"kiosk_id"), 0x1::string::utf8(b"{kiosk_id}"));
        0x2::display::add<ChakraNFT>(&mut v1, 0x1::string::utf8(b"kiosk_owner_cap_id"), 0x1::string::utf8(b"{kiosk_owner_cap_id}"));
        0x2::display::update_version<ChakraNFT>(&mut v1);
        let (v2, v3) = 0x2::transfer_policy::new<ChakraNFT>(&v0, arg1);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<ChakraNFT>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<ChakraNFT>>(v1, 0x2::tx_context::sender(arg1));
        let v4 = GlobalConfig{
            id                  : 0x2::object::new(arg1),
            status              : true,
            payments            : 0x2::balance::zero<0x2::sui::SUI>(),
            base_price          : 0 * 1000000000,
            referral_price      : 1 * 1000000000,
            user_to_nft         : 0x2::table::new<address, 0x2::object::ID>(arg1),
            nft_to_user         : 0x2::table::new<0x2::object::ID, address>(arg1),
            referral_codes      : 0x2::table::new<u64, u64>(arg1),
            free_wl             : 0x2::table::new<address, bool>(arg1),
            boost_a_whitelists  : 0x2::table::new<address, bool>(arg1),
            boost_b_whitelists  : 0x2::table::new<address, bool>(arg1),
            boost_c_whitelists  : 0x2::table::new<address, bool>(arg1),
            boost_d_whitelists  : 0x2::table::new<address, bool>(arg1),
            boost_e_whitelists  : 0x2::table::new<address, bool>(arg1),
            boost_f_whitelists  : 0x2::table::new<address, bool>(arg1),
            boost_a             : 200,
            boost_b             : 500,
            boost_c             : 100,
            boost_d             : 200,
            boost_e             : 300,
            boost_f             : 400,
            count               : 0,
            used_referral_count : 0,
        };
        0x2::transfer::share_object<GlobalConfig>(v4);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<ChakraNFT>>(v2);
    }

    public fun is_a_whitelisted(arg0: &GlobalConfig, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.boost_a_whitelists, arg1)
    }

    public fun is_b_whitelisted(arg0: &GlobalConfig, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.boost_b_whitelists, arg1)
    }

    public fun is_c_whitelisted(arg0: &GlobalConfig, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.boost_c_whitelists, arg1)
    }

    public fun is_code_available(arg0: &mut GlobalConfig, arg1: u64) : bool {
        !0x2::table::contains<u64, u64>(&arg0.referral_codes, arg1)
    }

    public fun is_d_whitelisted(arg0: &GlobalConfig, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.boost_d_whitelists, arg1)
    }

    public fun is_e_whitelisted(arg0: &GlobalConfig, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.boost_e_whitelists, arg1)
    }

    public fun is_f_whitelisted(arg0: &GlobalConfig, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.boost_f_whitelists, arg1)
    }

    public fun is_free_whitelisted(arg0: &GlobalConfig, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.free_wl, arg1)
    }

    public fun maya_burnt(arg0: &ChakraNFT) : u64 {
        arg0.maya_burnt
    }

    public fun minted_by(arg0: &ChakraNFT) : address {
        arg0.minted_by
    }

    public fun number(arg0: &ChakraNFT) : u64 {
        arg0.number
    }

    public fun referral_price(arg0: &GlobalConfig) : u64 {
        arg0.referral_price
    }

    public(friend) fun register(arg0: &mut GlobalConfig, arg1: 0x2::object::ID, arg2: address) {
        assert!(!0x2::table::contains<0x2::object::ID, address>(&arg0.nft_to_user, arg1), 2);
        assert!(!0x2::table::contains<address, 0x2::object::ID>(&arg0.user_to_nft, arg2), 3);
        0x2::table::add<address, 0x2::object::ID>(&mut arg0.user_to_nft, arg2, arg1);
        0x2::table::add<0x2::object::ID, address>(&mut arg0.nft_to_user, arg1, arg2);
    }

    public fun remaining_referrals(arg0: &GlobalConfig, arg1: u64) : u64 {
        *0x2::table::borrow<u64, u64>(&arg0.referral_codes, arg1)
    }

    public fun status(arg0: &GlobalConfig) : bool {
        arg0.status
    }

    public(friend) fun take_payment(arg0: &mut GlobalConfig, arg1: u64) : 0x2::balance::Balance<0x2::sui::SUI> {
        if (arg1 == 0) {
            0x2::balance::split<0x2::sui::SUI>(&mut arg0.payments, 0x2::balance::value<0x2::sui::SUI>(&arg0.payments))
        } else {
            0x2::balance::split<0x2::sui::SUI>(&mut arg0.payments, arg1)
        }
    }

    public fun total_referral_entries_count(arg0: &GlobalConfig) : u64 {
        0x2::table::length<u64, u64>(&arg0.referral_codes)
    }

    public(friend) fun use_referral_code(arg0: &mut GlobalConfig, arg1: u64) {
        assert!(0x2::table::contains<u64, u64>(&arg0.referral_codes, arg1), 0);
        let v0 = 0x2::table::borrow_mut<u64, u64>(&mut arg0.referral_codes, arg1);
        assert!(*v0 > 0, 1);
        *v0 = *v0 - 1;
    }

    public fun used_referral_count(arg0: &GlobalConfig) : u64 {
        arg0.used_referral_count
    }

    // decompiled from Move bytecode v6
}

