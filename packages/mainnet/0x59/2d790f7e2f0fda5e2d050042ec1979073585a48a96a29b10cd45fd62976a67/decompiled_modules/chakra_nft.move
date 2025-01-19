module 0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::chakra_nft {
    struct CHAKRA_NFT has drop {
        dummy_field: bool,
    }

    struct ReferralInfo has store {
        total_earned: u64,
        claimable: u64,
        remaining_uses: u64,
    }

    struct ChakraNFT has key {
        id: 0x2::object::UID,
        number: u64,
        minted_by: address,
        s1_alloc: u64,
        s2_alloc: u64,
        referral_codes: 0x1::string::String,
        referee_code: 0x1::string::String,
        maya_burnt: u64,
    }

    struct GlobalConfig has key {
        id: 0x2::object::UID,
        status: bool,
        payments: 0x2::balance::Balance<0x2::sui::SUI>,
        base_price: u64,
        referral_price: u64,
        max_codes_per_acc: u64,
        max_codes_per_whale: u64,
        user_to_nft: 0x2::table::Table<address, 0x2::object::ID>,
        nft_to_user: 0x2::table::Table<0x2::object::ID, address>,
        referral_codes: 0x2::table::Table<0x1::string::String, ReferralInfo>,
        whale_refferal_wl: 0x2::table::Table<address, bool>,
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
        bonus_percentage_per_claim: u64,
        max_bonus_per_claim: u64,
        referral_bonus_percentage: u64,
        used_referral_count: u64,
        total_maya_burnt: u64,
        version: 0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::version::Version,
    }

    struct BatchBoostUpdateEvent has copy, drop {
        boost_category: u8,
        is_added: bool,
        updated_addresses: vector<address>,
    }

    public(friend) fun id(arg0: &ChakraNFT) : 0x2::object::ID {
        0x2::object::id<ChakraNFT>(arg0)
    }

    public fun transfer(arg0: ChakraNFT) {
        0x2::transfer::transfer<ChakraNFT>(arg0, arg0.minted_by);
    }

    public(friend) fun add_maya_burnt(arg0: &mut ChakraNFT, arg1: &mut GlobalConfig, arg2: u64) {
        arg0.maya_burnt = arg0.maya_burnt + arg2;
        arg1.total_maya_burnt = arg1.total_maya_burnt + arg2;
    }

    public(friend) fun add_payment(arg0: &mut GlobalConfig, arg1: 0x2::balance::Balance<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.payments, arg1);
    }

    public(friend) fun add_referral_code(arg0: &mut GlobalConfig, arg1: &mut ChakraNFT, arg2: 0x1::string::String) {
        assert!(!0x1::string::is_empty(&arg2), 0);
        let v0 = 0x1::string::to_ascii(arg2);
        let v1 = 0x1::string::from_ascii(0x1::ascii::to_uppercase(&v0));
        assert!(!0x2::table::contains<0x1::string::String, ReferralInfo>(&arg0.referral_codes, v1), 4);
        let v2 = if (is_whale_whitelisted(arg0, arg1.minted_by)) {
            arg0.max_codes_per_whale
        } else {
            arg0.max_codes_per_acc
        };
        let v3 = ReferralInfo{
            total_earned   : 0,
            claimable      : 0,
            remaining_uses : v2,
        };
        0x2::table::add<0x1::string::String, ReferralInfo>(&mut arg0.referral_codes, v1, v3);
        arg1.referral_codes = v1;
    }

    public fun admin_add_whale_refferal_wl(arg0: &0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::admin::AdminCap, arg1: &mut GlobalConfig, arg2: address, arg3: &0x2::tx_context::TxContext) {
        0x2::table::add<address, bool>(&mut arg1.whale_refferal_wl, arg2, true);
    }

    public fun admin_overwrite_referral_claimable(arg0: &0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::admin::AdminCap, arg1: 0x1::string::String, arg2: u64, arg3: &mut GlobalConfig, arg4: &0x2::tx_context::TxContext) {
        0x2::table::borrow_mut<0x1::string::String, ReferralInfo>(&mut arg3.referral_codes, arg1).claimable = arg2;
    }

    public fun admin_overwrite_referral_uses(arg0: &0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::admin::AdminCap, arg1: 0x1::string::String, arg2: u64, arg3: &mut GlobalConfig, arg4: &0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x1::string::String, ReferralInfo>(&arg3.referral_codes, arg1), 0);
        0x2::table::borrow_mut<0x1::string::String, ReferralInfo>(&mut arg3.referral_codes, arg1).remaining_uses = arg2;
    }

    public fun admin_remove_whale_refferal_wl(arg0: &0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::admin::AdminCap, arg1: &mut GlobalConfig, arg2: address, arg3: &0x2::tx_context::TxContext) {
        0x2::table::remove<address, bool>(&mut arg1.whale_refferal_wl, arg2);
    }

    public fun admin_set_base_price(arg0: &0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::admin::AdminCap, arg1: u64, arg2: &mut GlobalConfig, arg3: &0x2::tx_context::TxContext) {
        arg2.base_price = arg1;
    }

    public fun admin_set_bonus_percentage_per_claim(arg0: &0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::admin::AdminCap, arg1: u64, arg2: &mut GlobalConfig) {
        arg2.bonus_percentage_per_claim = arg1;
    }

    public fun admin_set_boost_a(arg0: &0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::admin::AdminCap, arg1: u64, arg2: &mut GlobalConfig, arg3: &0x2::tx_context::TxContext) {
        arg2.boost_a = arg1;
    }

    public fun admin_set_boost_b(arg0: &0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::admin::AdminCap, arg1: u64, arg2: &mut GlobalConfig, arg3: &0x2::tx_context::TxContext) {
        arg2.boost_b = arg1;
    }

    public fun admin_set_boost_c(arg0: &0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::admin::AdminCap, arg1: u64, arg2: &mut GlobalConfig, arg3: &0x2::tx_context::TxContext) {
        arg2.boost_c = arg1;
    }

    public fun admin_set_boost_d(arg0: &0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::admin::AdminCap, arg1: u64, arg2: &mut GlobalConfig, arg3: &0x2::tx_context::TxContext) {
        arg2.boost_d = arg1;
    }

    public fun admin_set_boost_e(arg0: &0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::admin::AdminCap, arg1: u64, arg2: &mut GlobalConfig, arg3: &0x2::tx_context::TxContext) {
        arg2.boost_e = arg1;
    }

    public fun admin_set_boost_f(arg0: &0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::admin::AdminCap, arg1: u64, arg2: &mut GlobalConfig, arg3: &0x2::tx_context::TxContext) {
        arg2.boost_f = arg1;
    }

    public fun admin_set_display_url(arg0: &0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::admin::AdminCap, arg1: &mut 0x2::display::Display<ChakraNFT>, arg2: 0x1::string::String, arg3: &0x2::tx_context::TxContext) {
        0x2::display::edit<ChakraNFT>(arg1, 0x1::string::utf8(b"image_url"), arg2);
        0x2::display::update_version<ChakraNFT>(arg1);
    }

    public fun admin_set_max_bonus_per_claim(arg0: &0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::admin::AdminCap, arg1: u64, arg2: &mut GlobalConfig) {
        arg2.max_bonus_per_claim = arg1;
    }

    public fun admin_set_referral_bonus_percentage(arg0: &0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::admin::AdminCap, arg1: u64, arg2: &mut GlobalConfig) {
        arg2.referral_bonus_percentage = arg1;
    }

    public fun admin_set_referral_price(arg0: &0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::admin::AdminCap, arg1: u64, arg2: &mut GlobalConfig, arg3: &0x2::tx_context::TxContext) {
        arg2.referral_price = arg1;
    }

    public fun admin_set_refferal_limit_per_acc(arg0: &0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::admin::AdminCap, arg1: u64, arg2: &mut GlobalConfig, arg3: &0x2::tx_context::TxContext) {
        arg2.max_codes_per_acc = arg1;
    }

    public fun admin_set_refferal_limit_per_whale(arg0: &0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::admin::AdminCap, arg1: u64, arg2: &mut GlobalConfig, arg3: &0x2::tx_context::TxContext) {
        arg2.max_codes_per_whale = arg1;
    }

    public fun admin_set_status(arg0: &0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::admin::AdminCap, arg1: bool, arg2: &mut GlobalConfig, arg3: &0x2::tx_context::TxContext) {
        arg2.status = arg1;
    }

    public fun base_price(arg0: &GlobalConfig) : u64 {
        arg0.base_price
    }

    public fun batch_update_a(arg0: &0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::admin::AdminCap, arg1: &mut GlobalConfig, arg2: vector<address>, arg3: bool, arg4: &0x2::tx_context::TxContext) {
        let v0 = BatchBoostUpdateEvent{
            boost_category    : 0,
            is_added          : arg3,
            updated_addresses : arg2,
        };
        0x2::event::emit<BatchBoostUpdateEvent>(v0);
        while (!0x1::vector::is_empty<address>(&arg2)) {
            let v1 = 0x1::vector::pop_back<address>(&mut arg2);
            let v2 = 0x2::table::contains<address, bool>(&arg1.boost_a_whitelists, v1);
            if (arg3) {
                if (!v2) {
                    0x2::table::add<address, bool>(&mut arg1.boost_a_whitelists, v1, true);
                    continue
                } else {
                    continue
                };
            };
            if (v2) {
                0x2::table::remove<address, bool>(&mut arg1.boost_a_whitelists, v1);
            };
        };
        0x1::vector::destroy_empty<address>(arg2);
    }

    public fun batch_update_b(arg0: &0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::admin::AdminCap, arg1: &mut GlobalConfig, arg2: vector<address>, arg3: bool, arg4: &0x2::tx_context::TxContext) {
        let v0 = BatchBoostUpdateEvent{
            boost_category    : 1,
            is_added          : arg3,
            updated_addresses : arg2,
        };
        0x2::event::emit<BatchBoostUpdateEvent>(v0);
        while (!0x1::vector::is_empty<address>(&arg2)) {
            let v1 = 0x1::vector::pop_back<address>(&mut arg2);
            let v2 = 0x2::table::contains<address, bool>(&arg1.boost_b_whitelists, v1);
            if (arg3) {
                if (!v2) {
                    0x2::table::add<address, bool>(&mut arg1.boost_b_whitelists, v1, true);
                    continue
                } else {
                    continue
                };
            };
            if (v2) {
                0x2::table::remove<address, bool>(&mut arg1.boost_b_whitelists, v1);
            };
        };
        0x1::vector::destroy_empty<address>(arg2);
    }

    public fun batch_update_c(arg0: &0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::admin::AdminCap, arg1: &mut GlobalConfig, arg2: vector<address>, arg3: bool, arg4: &0x2::tx_context::TxContext) {
        let v0 = BatchBoostUpdateEvent{
            boost_category    : 2,
            is_added          : arg3,
            updated_addresses : arg2,
        };
        0x2::event::emit<BatchBoostUpdateEvent>(v0);
        while (!0x1::vector::is_empty<address>(&arg2)) {
            let v1 = 0x1::vector::pop_back<address>(&mut arg2);
            let v2 = 0x2::table::contains<address, bool>(&arg1.boost_c_whitelists, v1);
            if (arg3) {
                if (!v2) {
                    0x2::table::add<address, bool>(&mut arg1.boost_c_whitelists, v1, true);
                    continue
                } else {
                    continue
                };
            };
            if (v2) {
                0x2::table::remove<address, bool>(&mut arg1.boost_c_whitelists, v1);
            };
        };
        0x1::vector::destroy_empty<address>(arg2);
    }

    public fun batch_update_d(arg0: &0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::admin::AdminCap, arg1: &mut GlobalConfig, arg2: vector<address>, arg3: bool, arg4: &0x2::tx_context::TxContext) {
        let v0 = BatchBoostUpdateEvent{
            boost_category    : 3,
            is_added          : arg3,
            updated_addresses : arg2,
        };
        0x2::event::emit<BatchBoostUpdateEvent>(v0);
        while (!0x1::vector::is_empty<address>(&arg2)) {
            let v1 = 0x1::vector::pop_back<address>(&mut arg2);
            let v2 = 0x2::table::contains<address, bool>(&arg1.boost_d_whitelists, v1);
            if (arg3) {
                if (!v2) {
                    0x2::table::add<address, bool>(&mut arg1.boost_d_whitelists, v1, true);
                    continue
                } else {
                    continue
                };
            };
            if (v2) {
                0x2::table::remove<address, bool>(&mut arg1.boost_d_whitelists, v1);
            };
        };
        0x1::vector::destroy_empty<address>(arg2);
    }

    public fun batch_update_e(arg0: &0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::admin::AdminCap, arg1: &mut GlobalConfig, arg2: vector<address>, arg3: bool, arg4: &0x2::tx_context::TxContext) {
        let v0 = BatchBoostUpdateEvent{
            boost_category    : 4,
            is_added          : arg3,
            updated_addresses : arg2,
        };
        0x2::event::emit<BatchBoostUpdateEvent>(v0);
        while (!0x1::vector::is_empty<address>(&arg2)) {
            let v1 = 0x1::vector::pop_back<address>(&mut arg2);
            let v2 = 0x2::table::contains<address, bool>(&arg1.boost_e_whitelists, v1);
            if (arg3) {
                if (!v2) {
                    0x2::table::add<address, bool>(&mut arg1.boost_e_whitelists, v1, true);
                    continue
                } else {
                    continue
                };
            };
            if (v2) {
                0x2::table::remove<address, bool>(&mut arg1.boost_e_whitelists, v1);
            };
        };
        0x1::vector::destroy_empty<address>(arg2);
    }

    public fun batch_update_f(arg0: &0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::admin::AdminCap, arg1: &mut GlobalConfig, arg2: vector<address>, arg3: bool, arg4: &0x2::tx_context::TxContext) {
        let v0 = BatchBoostUpdateEvent{
            boost_category    : 5,
            is_added          : arg3,
            updated_addresses : arg2,
        };
        0x2::event::emit<BatchBoostUpdateEvent>(v0);
        while (!0x1::vector::is_empty<address>(&arg2)) {
            let v1 = 0x1::vector::pop_back<address>(&mut arg2);
            let v2 = 0x2::table::contains<address, bool>(&arg1.boost_f_whitelists, v1);
            if (arg3) {
                if (!v2) {
                    0x2::table::add<address, bool>(&mut arg1.boost_f_whitelists, v1, true);
                    continue
                } else {
                    continue
                };
            };
            if (v2) {
                0x2::table::remove<address, bool>(&mut arg1.boost_f_whitelists, v1);
            };
        };
        0x1::vector::destroy_empty<address>(arg2);
    }

    public fun bonus_percentage_per_claim(arg0: &GlobalConfig) : (u64, u64) {
        (arg0.bonus_percentage_per_claim, 1000)
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

    public(friend) fun create(arg0: &mut GlobalConfig, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) : ChakraNFT {
        arg0.count = arg0.count + 1;
        ChakraNFT{
            id             : 0x2::object::new(arg2),
            number         : arg0.count,
            minted_by      : 0x2::tx_context::sender(arg2),
            s1_alloc       : 0,
            s2_alloc       : 0,
            referral_codes : 0x1::string::utf8(b""),
            referee_code   : arg1,
            maya_burnt     : 0,
        }
    }

    public(friend) fun create_unsafe(arg0: &mut GlobalConfig, arg1: address, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : ChakraNFT {
        arg0.count = arg0.count + 1;
        ChakraNFT{
            id             : 0x2::object::new(arg4),
            number         : arg0.count,
            minted_by      : arg1,
            s1_alloc       : arg2,
            s2_alloc       : arg3,
            referral_codes : 0x1::string::utf8(b""),
            referee_code   : 0x1::string::utf8(b""),
            maya_burnt     : 0,
        }
    }

    public fun get_user_by_nftId(arg0: &GlobalConfig, arg1: 0x2::object::ID) : address {
        *0x2::table::borrow<0x2::object::ID, address>(&arg0.nft_to_user, arg1)
    }

    public(friend) fun increment_claimable_from_referral(arg0: &mut GlobalConfig, arg1: 0x1::string::String, arg2: u64) {
        if (0x2::table::contains<0x1::string::String, ReferralInfo>(&arg0.referral_codes, arg1)) {
            let v0 = 0x2::table::borrow_mut<0x1::string::String, ReferralInfo>(&mut arg0.referral_codes, arg1);
            v0.total_earned = v0.total_earned + arg2;
            v0.claimable = v0.claimable + arg2;
        };
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
        0x2::display::update_version<ChakraNFT>(&mut v1);
        let (v2, v3) = 0x2::transfer_policy::new<ChakraNFT>(&v0, arg1);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<ChakraNFT>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<ChakraNFT>>(v1, 0x2::tx_context::sender(arg1));
        let v4 = GlobalConfig{
            id                         : 0x2::object::new(arg1),
            status                     : true,
            payments                   : 0x2::balance::zero<0x2::sui::SUI>(),
            base_price                 : 0 * 1000000000,
            referral_price             : 1 * 1000000000,
            max_codes_per_acc          : 7,
            max_codes_per_whale        : 1000,
            user_to_nft                : 0x2::table::new<address, 0x2::object::ID>(arg1),
            nft_to_user                : 0x2::table::new<0x2::object::ID, address>(arg1),
            referral_codes             : 0x2::table::new<0x1::string::String, ReferralInfo>(arg1),
            whale_refferal_wl          : 0x2::table::new<address, bool>(arg1),
            boost_a_whitelists         : 0x2::table::new<address, bool>(arg1),
            boost_b_whitelists         : 0x2::table::new<address, bool>(arg1),
            boost_c_whitelists         : 0x2::table::new<address, bool>(arg1),
            boost_d_whitelists         : 0x2::table::new<address, bool>(arg1),
            boost_e_whitelists         : 0x2::table::new<address, bool>(arg1),
            boost_f_whitelists         : 0x2::table::new<address, bool>(arg1),
            boost_a                    : 200,
            boost_b                    : 500,
            boost_c                    : 100,
            boost_d                    : 200,
            boost_e                    : 300,
            boost_f                    : 400,
            count                      : 0,
            bonus_percentage_per_claim : 50,
            max_bonus_per_claim        : 50,
            referral_bonus_percentage  : 100,
            used_referral_count        : 0,
            total_maya_burnt           : 0,
            version                    : 0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::version::new(arg1),
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

    public fun is_code_available(arg0: &GlobalConfig, arg1: 0x1::string::String) : bool {
        !0x2::table::contains<0x1::string::String, ReferralInfo>(&arg0.referral_codes, arg1)
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

    public fun is_whale_whitelisted(arg0: &GlobalConfig, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.whale_refferal_wl, arg1)
    }

    public fun max_bonus_per_claim(arg0: &GlobalConfig) : u64 {
        arg0.max_bonus_per_claim
    }

    public fun max_codes_per_acc(arg0: &GlobalConfig) : u64 {
        arg0.max_codes_per_acc
    }

    public fun max_codes_per_whale(arg0: &GlobalConfig) : u64 {
        arg0.max_codes_per_whale
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

    public fun referee_code(arg0: &ChakraNFT) : 0x1::string::String {
        arg0.referee_code
    }

    public fun referral_bonus_percentage(arg0: &GlobalConfig) : (u64, u64) {
        (arg0.referral_bonus_percentage, 1000)
    }

    public fun referral_code(arg0: &ChakraNFT) : 0x1::string::String {
        arg0.referral_codes
    }

    public fun referral_info(arg0: &GlobalConfig, arg1: 0x1::string::String) : (u64, u64, u64) {
        let v0 = 0x2::table::borrow<0x1::string::String, ReferralInfo>(&arg0.referral_codes, arg1);
        (v0.total_earned, v0.claimable, v0.remaining_uses)
    }

    public fun referral_price(arg0: &GlobalConfig) : u64 {
        arg0.referral_price
    }

    public(friend) fun register(arg0: &mut GlobalConfig, arg1: 0x2::object::ID, arg2: address) {
        assert!(!0x2::table::contains<address, 0x2::object::ID>(&arg0.user_to_nft, arg2), 3);
        assert!(!0x2::table::contains<0x2::object::ID, address>(&arg0.nft_to_user, arg1), 2);
        0x2::table::add<address, 0x2::object::ID>(&mut arg0.user_to_nft, arg2, arg1);
        0x2::table::add<0x2::object::ID, address>(&mut arg0.nft_to_user, arg1, arg2);
    }

    public fun remaining_referrals(arg0: &GlobalConfig, arg1: 0x1::string::String) : (u64, bool) {
        if (0x2::table::contains<0x1::string::String, ReferralInfo>(&arg0.referral_codes, arg1)) {
            (0x2::table::borrow<0x1::string::String, ReferralInfo>(&arg0.referral_codes, arg1).remaining_uses, true)
        } else {
            (0, false)
        }
    }

    public(friend) fun reset_claimable_from_referral(arg0: &mut GlobalConfig, arg1: 0x1::string::String) {
        if (0x2::table::contains<0x1::string::String, ReferralInfo>(&arg0.referral_codes, arg1)) {
            0x2::table::borrow_mut<0x1::string::String, ReferralInfo>(&mut arg0.referral_codes, arg1).claimable = 0;
        };
    }

    public fun s_alloc(arg0: &ChakraNFT) : (u64, u64) {
        (arg0.s1_alloc, arg0.s2_alloc)
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

    public fun total_maya_burnt(arg0: &GlobalConfig) : u64 {
        arg0.total_maya_burnt
    }

    public fun total_referral_entries_count(arg0: &GlobalConfig) : u64 {
        0x2::table::length<0x1::string::String, ReferralInfo>(&arg0.referral_codes)
    }

    public(friend) fun update_s_alloc(arg0: &mut ChakraNFT, arg1: u64, arg2: u64) {
        arg0.s1_alloc = arg1;
        arg0.s2_alloc = arg2;
    }

    public(friend) fun use_referral_code(arg0: &mut GlobalConfig, arg1: 0x1::string::String) {
        assert!(0x2::table::contains<0x1::string::String, ReferralInfo>(&arg0.referral_codes, arg1), 0);
        let v0 = 0x2::table::borrow_mut<0x1::string::String, ReferralInfo>(&mut arg0.referral_codes, arg1);
        assert!(v0.remaining_uses > 0, 1);
        v0.remaining_uses = v0.remaining_uses - 1;
    }

    public fun used_referral_count(arg0: &GlobalConfig) : u64 {
        arg0.used_referral_count
    }

    public fun version(arg0: &GlobalConfig) : &0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::version::Version {
        &arg0.version
    }

    public(friend) fun version_mut(arg0: &0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::admin::AdminCap, arg1: &mut GlobalConfig) : &mut 0x66f3283a3a4ed92aa4de92a3105f90dc1dd07921a43585785b206d9d708a3193::version::Version {
        &mut arg1.version
    }

    // decompiled from Move bytecode v6
}

