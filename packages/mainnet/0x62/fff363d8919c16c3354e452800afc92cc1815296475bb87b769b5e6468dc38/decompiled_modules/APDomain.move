module 0x62fff363d8919c16c3354e452800afc92cc1815296475bb87b769b5e6468dc38::APDomain {
    struct APDOMAIN has drop {
        dummy_field: bool,
    }

    struct DomainNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x1::string::String,
        ext: 0x1::string::String,
        collection: 0x1::string::String,
        creator: address,
        expiration: u64,
        regtime: u64,
    }

    struct Domain has store, key {
        id: 0x2::object::UID,
        domain: 0x1::string::String,
        nftid: 0x2::object::ID,
        creator: address,
        expiration: u64,
        regtime: u64,
        data: 0x2::vec_map::VecMap<u64, vector<u8>>,
    }

    struct GlobalMap has store, key {
        id: 0x2::object::UID,
        addr2domain: 0x2::table::Table<address, vector<u8>>,
        domain2addr: 0x2::table::Table<vector<u8>, address>,
        domains: 0x2::table::Table<vector<u8>, Domain>,
        sui_pool: 0x2::balance::Balance<0x2::sui::SUI>,
        apc_pool: 0x2::balance::Balance<0x62fff363d8919c16c3354e452800afc92cc1815296475bb87b769b5e6468dc38::apc::APC>,
    }

    struct BaseConfig has store, key {
        id: 0x2::object::UID,
        pause: bool,
        price_list: vector<u64>,
        min_year: u64,
        max_year: u64,
        min_len: u64,
        max_len: u64,
    }

    struct RegisterEvent has copy, drop, store {
        account: address,
        domain: 0x1::string::String,
        years: u64,
        price: u64,
        time: u64,
    }

    struct ReferralRecord has drop, store {
        account: address,
        domain: 0x1::string::String,
        price: u64,
        refund: u64,
        discount: u64,
        time: u64,
    }

    struct Referral has drop, store {
        level: u64,
        count: u64,
        amount: u64,
        refund: u64,
        discount: u64,
        records: vector<ReferralRecord>,
    }

    struct ReferralMap has key {
        id: 0x2::object::UID,
        refs: 0x2::table::Table<address, Referral>,
    }

    struct MintAPCEvent has copy, drop {
        addr: address,
        amount: u64,
        time: u64,
    }

    struct MintAPC has store {
        id: 0x2::object::UID,
        gen: u64,
        time: u64,
        rebate: u64,
    }

    struct MintAPCTable has key {
        id: 0x2::object::UID,
        mints: 0x2::table::Table<vector<u8>, MintAPC>,
    }

    struct AigcPayEvent has copy, drop {
        account: address,
        time: u64,
        type: 0x1::string::String,
        point: u64,
        amount: u64,
    }

    fun add_intdata_internal(arg0: &mut GlobalMap, arg1: vector<u8>, arg2: u64, arg3: u64) {
        let v0 = get_intdata_internal(arg0, arg1, arg2) + arg3;
        set_intdata_internal(arg0, arg1, arg2, v0);
    }

    public fun admin_address() : address {
        @0xdeaf4320dddc10e8a5c5deb8055d2e43401551e387f4515f4953b0bcf1fe0451
    }

    public entry fun batch_set_data(arg0: &mut GlobalMap, arg1: &0x2::clock::Clock, arg2: &DomainNFT, arg3: vector<u64>, arg4: vector<vector<u8>>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(is_have_valid_domain(arg0, arg1, arg2), 14);
        assert!(0x1::vector::length<u64>(&arg3) == 0x1::vector::length<vector<u8>>(&arg4), 2);
        let v0 = 0x2::table::borrow_mut<vector<u8>, Domain>(&mut arg0.domains, *0x1::string::bytes(&arg2.name));
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(&arg3)) {
            let v2 = *0x1::vector::borrow<u64>(&arg3, v1);
            assert!(v2 < 100000000 || v2 > 200000000, 9);
            if (0x2::vec_map::contains<u64, vector<u8>>(&v0.data, &v2)) {
                *0x2::vec_map::get_mut<u64, vector<u8>>(&mut v0.data, &v2) = *0x1::vector::borrow<vector<u8>>(&arg4, v1);
            } else {
                0x2::vec_map::insert<u64, vector<u8>>(&mut v0.data, v2, *0x1::vector::borrow<vector<u8>>(&arg4, v1));
            };
            v1 = v1 + 1;
        };
    }

    public entry fun bind_domain(arg0: &mut GlobalMap, arg1: &0x2::clock::Clock, arg2: &DomainNFT, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(is_have_valid_domain(arg0, arg1, arg2), 14);
        if (!0x2::table::contains<address, vector<u8>>(&arg0.addr2domain, v0)) {
            0x2::table::add<address, vector<u8>>(&mut arg0.addr2domain, v0, *0x1::string::bytes(&arg2.name));
        } else {
            *0x2::table::borrow_mut<address, vector<u8>>(&mut arg0.addr2domain, v0) = *0x1::string::bytes(&arg2.name);
        };
    }

    fun check_vaild(arg0: &vector<u8>) : bool {
        let v0 = true;
        let v1 = 0x1::vector::length<u8>(arg0);
        let v2 = 0;
        while (v2 < v1) {
            let v3 = *0x1::vector::borrow<u8>(arg0, v2);
            if (v3 < 128) {
                if (v3 >= 48 && v3 <= 57) {
                    v2 = v2 + 1;
                    continue
                };
                if (v3 >= 97 && v3 <= 122) {
                    v2 = v2 + 1;
                    continue
                };
                if (v3 == 46) {
                    if (v2 == 0 || v2 + 1 == v1 || 1000000 == v2 - 1) {
                        v0 = false;
                        break
                    };
                    v2 = v2 + 1;
                    continue
                } else {
                    v0 = false;
                    break
                };
            };
            if (v3 < 224) {
                v2 = v2 + 2;
                continue
            };
            if (v3 < 240) {
                v2 = v2 + 3;
                continue
            };
            if (v3 < 248) {
                v2 = v2 + 4;
                continue
            };
            if (v3 < 252) {
                v2 = v2 + 5;
                continue
            };
            v2 = v2 + 6;
        };
        v0
    }

    public entry fun claim_apc(arg0: &BaseConfig, arg1: &GlobalMap, arg2: &mut MintAPCTable, arg3: &0x2::clock::Clock, arg4: &mut 0x2::coin::TreasuryCap<0x62fff363d8919c16c3354e452800afc92cc1815296475bb87b769b5e6468dc38::apc::APC>, arg5: &mut DomainNFT, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = b"";
        let v1 = b"";
        claim_apc_internal(arg0, arg1, arg2, arg3, arg4, arg5, &v0, &v1, arg6);
    }

    fun claim_apc_internal(arg0: &BaseConfig, arg1: &GlobalMap, arg2: &mut MintAPCTable, arg3: &0x2::clock::Clock, arg4: &mut 0x2::coin::TreasuryCap<0x62fff363d8919c16c3354e452800afc92cc1815296475bb87b769b5e6468dc38::apc::APC>, arg5: &mut DomainNFT, arg6: &vector<u8>, arg7: &vector<u8>, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.pause, 8);
        let v0 = 0x2::tx_context::sender(arg8);
        let v1 = *0x1::string::bytes(&arg5.name);
        assert!(is_have_valid_domain(arg1, arg3, arg5), 14);
        if (!0x2::table::contains<vector<u8>, MintAPC>(&arg2.mints, v1)) {
            init_mint_apc(arg2, v1, arg8);
        };
        let v2 = 0x2::clock::timestamp_ms(arg3) / 1000;
        let v3 = 0x2::table::borrow<vector<u8>, MintAPC>(&mut arg2.mints, v1);
        assert!(v3.time < v2, 15);
        let v4 = get_root_domain(v1);
        let v5 = v3.rebate;
        let v6 = rebate_regress(arg2, 0, v1, 20000000 * (8 - 0x2::math::min(6, 0x62fff363d8919c16c3354e452800afc92cc1815296475bb87b769b5e6468dc38::string_utils::unicode_strlen(&v4))) / 0x2::math::pow(2, (v3.gen as u8)), arg8);
        let v7 = v6 + v5;
        assert!(v7 > 0, 2);
        0x62fff363d8919c16c3354e452800afc92cc1815296475bb87b769b5e6468dc38::apc::mint(arg4, v7, v0, arg8);
        let v8 = 0x2::table::borrow_mut<vector<u8>, MintAPC>(&mut arg2.mints, v1);
        if (v5 > 0) {
            v8.rebate = 0;
        };
        v8.time = v2 + 86400;
        let v9 = MintAPCEvent{
            addr   : v0,
            amount : v7,
            time   : v2,
        };
        0x2::event::emit<MintAPCEvent>(v9);
    }

    public entry fun claim_apc_with_oracle(arg0: &BaseConfig, arg1: &GlobalMap, arg2: &mut MintAPCTable, arg3: &0x2::clock::Clock, arg4: &mut 0x2::coin::TreasuryCap<0x62fff363d8919c16c3354e452800afc92cc1815296475bb87b769b5e6468dc38::apc::APC>, arg5: &mut DomainNFT, arg6: vector<u8>, arg7: vector<u8>, arg8: &mut 0x2::tx_context::TxContext) {
        claim_apc_internal(arg0, arg1, arg2, arg3, arg4, arg5, &arg6, &arg7, arg8);
    }

    public entry fun clean_bind_domain(arg0: &mut GlobalMap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        if (!0x2::table::contains<address, vector<u8>>(&arg0.addr2domain, v0)) {
            0x2::table::add<address, vector<u8>>(&mut arg0.addr2domain, v0, b"");
        } else {
            *0x2::table::borrow_mut<address, vector<u8>>(&mut arg0.addr2domain, v0) = b"";
        };
    }

    fun create_domain_nft(arg0: vector<u8>, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::object::new(arg3);
        let v2 = DomainNFT{
            id          : v1,
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(b"APass Name"),
            url         : get_domain_uri(arg0, 0),
            ext         : 0x1::string::utf8(b"@sui"),
            collection  : 0x1::string::utf8(b"APass"),
            creator     : v0,
            expiration  : arg1,
            regtime     : arg2,
        };
        0x2::transfer::transfer<DomainNFT>(v2, v0);
        0x2::object::uid_to_inner(&v1)
    }

    fun discount_with_card(arg0: &BaseConfig, arg1: u64, arg2: &vector<u8>) : u64 {
        arg1
    }

    fun discount_with_referral(arg0: &mut ReferralMap, arg1: &0x2::clock::Clock, arg2: &vector<u8>, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(v0 != arg4, 16);
        if (!0x2::table::contains<address, Referral>(&arg0.refs, arg4)) {
            let v1 = Referral{
                level    : 0,
                count    : 0,
                amount   : 0,
                refund   : 0,
                discount : 0,
                records  : 0x1::vector::empty<ReferralRecord>(),
            };
            0x2::table::add<address, Referral>(&mut arg0.refs, arg4, v1);
        };
        let v2 = 0x2::table::borrow_mut<address, Referral>(&mut arg0.refs, arg4);
        let v3 = 0;
        let v4 = vector[5, 10, 10, 10];
        if (v2.level < 0x1::vector::length<u64>(&v4)) {
            let v5 = vector[5, 10, 10, 10];
            let v6 = vector[5, 10, 15, 20];
            let v7 = arg3 * *0x1::vector::borrow<u64>(&v5, v2.level) / 100;
            let v8 = arg3 * *0x1::vector::borrow<u64>(&v6, v2.level) / 100;
            v3 = v8;
            let v9 = arg3 - v7;
            v2.discount = v2.discount + v7;
            v2.refund = v2.refund + v8;
            v2.count = v2.count + 1;
            v2.amount = v2.amount + v9;
            let v10 = ReferralRecord{
                account  : v0,
                domain   : 0x1::string::utf8(*arg2),
                price    : v9,
                refund   : v8,
                discount : v7,
                time     : 0x2::clock::timestamp_ms(arg1) / 1000,
            };
            0x1::vector::push_back<ReferralRecord>(&mut v2.records, v10);
            arg3 = v9 - v8;
        };
        (arg3, v3)
    }

    fun get_data_internal(arg0: &GlobalMap, arg1: vector<u8>, arg2: u64) : vector<u8> {
        let v0 = 0x2::table::borrow<vector<u8>, Domain>(&arg0.domains, arg1);
        let v1 = b"";
        if (0x2::vec_map::contains<u64, vector<u8>>(&v0.data, &arg2)) {
            v1 = *0x2::vec_map::get<u64, vector<u8>>(&v0.data, &arg2);
        };
        v1
    }

    public fun get_domain_len_by_address(arg0: &GlobalMap, arg1: address) : u64 {
        let v0 = resolve_address(arg0, arg1);
        0x62fff363d8919c16c3354e452800afc92cc1815296475bb87b769b5e6468dc38::string_utils::unicode_strlen(&v0)
    }

    fun get_domain_uri(arg0: vector<u8>, arg1: u64) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"https://aptpp.com/namepic/");
        0x1::string::append_utf8(&mut v0, b"sui_main/");
        0x1::string::append_utf8(&mut v0, arg0);
        if (arg1 > 0) {
            0x1::string::append_utf8(&mut v0, b"/lv");
            0x1::string::append_utf8(&mut v0, 0x62fff363d8919c16c3354e452800afc92cc1815296475bb87b769b5e6468dc38::string_utils::u64_to_string(arg1));
        };
        v0
    }

    fun get_intdata_internal(arg0: &GlobalMap, arg1: vector<u8>, arg2: u64) : u64 {
        let v0 = get_data_internal(arg0, arg1, arg2);
        0x62fff363d8919c16c3354e452800afc92cc1815296475bb87b769b5e6468dc38::string_utils::string_to_u64(&v0)
    }

    fun get_price(arg0: &BaseConfig, arg1: u64, arg2: u64) : u64 {
        let v0 = 0x1::vector::length<u64>(&arg0.price_list);
        if (arg2 >= v0) {
            arg2 = v0 - 1;
        };
        arg1 * *0x1::vector::borrow<u64>(&arg0.price_list, arg2)
    }

    fun get_root_domain(arg0: vector<u8>) : vector<u8> {
        let v0 = 0;
        loop {
            let v1 = 0x62fff363d8919c16c3354e452800afc92cc1815296475bb87b769b5e6468dc38::string_utils::string_get_parent(&arg0);
            let v2 = *0x1::string::bytes(&v1);
            if (0x1::vector::length<u8>(&v2) == 0) {
                break
            };
            v0 = v0 + 1;
            if (v0 >= 10) {
                abort 10
            };
            arg0 = v2;
        };
        arg0
    }

    fun get_sub_price(arg0: u64) : u64 {
        arg0 * 4 * 1000000000
    }

    fun init(arg0: APDOMAIN, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(admin_address() == 0x2::tx_context::sender(arg1), 1);
        let v0 = GlobalMap{
            id          : 0x2::object::new(arg1),
            addr2domain : 0x2::table::new<address, vector<u8>>(arg1),
            domain2addr : 0x2::table::new<vector<u8>, address>(arg1),
            domains     : 0x2::table::new<vector<u8>, Domain>(arg1),
            sui_pool    : 0x2::balance::zero<0x2::sui::SUI>(),
            apc_pool    : 0x2::balance::zero<0x62fff363d8919c16c3354e452800afc92cc1815296475bb87b769b5e6468dc38::apc::APC>(),
        };
        0x2::transfer::share_object<GlobalMap>(v0);
        let v1 = BaseConfig{
            id         : 0x2::object::new(arg1),
            pause      : false,
            price_list : vector[0, 0, 0, 480000000000, 120000000000, 60000000000, 15000000000],
            min_year   : 1,
            max_year   : 100,
            min_len    : 3,
            max_len    : 128,
        };
        0x2::transfer::share_object<BaseConfig>(v1);
        let v2 = ReferralMap{
            id   : 0x2::object::new(arg1),
            refs : 0x2::table::new<address, Referral>(arg1),
        };
        0x2::transfer::share_object<ReferralMap>(v2);
        let v3 = MintAPCTable{
            id    : 0x2::object::new(arg1),
            mints : 0x2::table::new<vector<u8>, MintAPC>(arg1),
        };
        0x2::transfer::share_object<MintAPCTable>(v3);
        let v4 = 0x2::package::claim<APDOMAIN>(arg0, arg1);
        let v5 = 0x1::vector::empty<0x1::string::String>();
        let v6 = &mut v5;
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"ext"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"collection"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"creator"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"registration time"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"expiration time"));
        let v7 = 0x1::vector::empty<0x1::string::String>();
        let v8 = &mut v7;
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"{name}{ext}"));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"{url}"));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"https://sui.apass.network/"));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"{ext}"));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"{collection}"));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"{creator}"));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"{expiration}"));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"{regtime}"));
        let v9 = 0x2::display::new_with_fields<DomainNFT>(&v4, v5, v7, arg1);
        0x2::display::update_version<DomainNFT>(&mut v9);
        0x2::transfer::public_transfer<0x2::display::Display<DomainNFT>>(v9, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
    }

    fun init_mint_apc(arg0: &mut MintAPCTable, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = MintAPC{
            id     : 0x2::object::new(arg2),
            gen    : 0,
            time   : 0,
            rebate : 0,
        };
        0x2::table::add<vector<u8>, MintAPC>(&mut arg0.mints, arg1, v0);
    }

    fun is_domain_expired(arg0: &GlobalMap, arg1: &0x2::clock::Clock, arg2: &vector<u8>) : bool {
        let v0 = false;
        if (0x2::table::contains<vector<u8>, Domain>(&arg0.domains, *arg2)) {
            v0 = 0x2::table::borrow<vector<u8>, Domain>(&arg0.domains, *arg2).expiration < 0x2::clock::timestamp_ms(arg1) / 1000;
        };
        v0
    }

    fun is_have_valid_domain(arg0: &GlobalMap, arg1: &0x2::clock::Clock, arg2: &DomainNFT) : bool {
        let v0 = false;
        let v1 = 0x1::string::bytes(&arg2.name);
        if (0x2::table::contains<vector<u8>, Domain>(&arg0.domains, *v1)) {
            let v2 = 0x2::table::borrow<vector<u8>, Domain>(&arg0.domains, *v1);
            let v3 = v2.expiration > 0x2::clock::timestamp_ms(arg1) / 1000 && 0x2::object::uid_to_inner(&arg2.id) == v2.nftid;
            v0 = v3;
        };
        v0
    }

    public entry fun payin_aigc_apc(arg0: &mut GlobalMap, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<0x62fff363d8919c16c3354e452800afc92cc1815296475bb87b769b5e6468dc38::apc::APC>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 > 0 && arg4 > 0 && arg3 * 100000000 == arg4, 5);
        let v0 = &mut arg0.apc_pool;
        store_coin<0x62fff363d8919c16c3354e452800afc92cc1815296475bb87b769b5e6468dc38::apc::APC>(v0, arg2, arg4, arg5);
        let v1 = AigcPayEvent{
            account : 0x2::tx_context::sender(arg5),
            time    : 0x2::clock::timestamp_ms(arg1) / 1000,
            type    : 0x1::string::utf8(b"APC"),
            point   : arg3,
            amount  : arg4,
        };
        0x2::event::emit<AigcPayEvent>(v1);
    }

    fun rebate_regress(arg0: &mut MintAPCTable, arg1: u64, arg2: vector<u8>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x62fff363d8919c16c3354e452800afc92cc1815296475bb87b769b5e6468dc38::string_utils::string_get_parent(&arg2);
        let v1 = 0x1::string::bytes(&v0);
        let v2 = arg3;
        if (0x1::vector::length<u8>(v1) > 0) {
            let v3 = arg3 * 20 / 100;
            v2 = arg3 - v3;
            rebate_regress(arg0, arg1 + 1, *v1, v3, arg4);
        };
        if (arg1 > 0) {
            if (!0x2::table::contains<vector<u8>, MintAPC>(&arg0.mints, arg2)) {
                init_mint_apc(arg0, arg2, arg4);
            };
            let v4 = 0x2::table::borrow_mut<vector<u8>, MintAPC>(&mut arg0.mints, arg2);
            v4.rebate = v4.rebate + arg3;
        };
        v2
    }

    public entry fun referral_set_level(arg0: &mut ReferralMap, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(admin_address() == 0x2::tx_context::sender(arg3), 1);
        assert!(0x2::table::contains<address, Referral>(&arg0.refs, arg1), 17);
        0x2::table::borrow_mut<address, Referral>(&mut arg0.refs, arg1).level = arg2;
    }

    public entry fun referral_upgrade(arg0: &mut ReferralMap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x2::table::contains<address, Referral>(&arg0.refs, v0), 17);
        let v1 = 0x2::table::borrow_mut<address, Referral>(&mut arg0.refs, v0);
        let v2 = v1.level;
        let v3 = vector[10, 50, 200];
        let v4 = if (v2 < 0x1::vector::length<u64>(&v3)) {
            let v5 = vector[100000000000, 500000000000, 2000000000000];
            v2 < 0x1::vector::length<u64>(&v5)
        } else {
            false
        };
        assert!(v4, 10);
        let v6 = vector[10, 50, 200];
        let v7 = vector[100000000000, 500000000000, 2000000000000];
        assert!(v1.amount >= *0x1::vector::borrow<u64>(&v7, v2) || v1.count >= *0x1::vector::borrow<u64>(&v6, v2), 18);
        v1.level = v1.level + 1;
    }

    public entry fun register(arg0: &BaseConfig, arg1: &mut GlobalMap, arg2: &mut ReferralMap, arg3: &0x2::clock::Clock, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: vector<u8>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        register_internal(arg0, arg1, arg2, arg3, arg4, arg5, arg6, 0x1::option::none<DomainNFT>(), @0x0, arg7);
    }

    fun register_internal(arg0: &BaseConfig, arg1: &mut GlobalMap, arg2: &mut ReferralMap, arg3: &0x2::clock::Clock, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: vector<u8>, arg6: u64, arg7: 0x1::option::Option<DomainNFT>, arg8: address, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg9);
        assert!(!arg0.pause, 8);
        let v1 = 0x62fff363d8919c16c3354e452800afc92cc1815296475bb87b769b5e6468dc38::string_utils::unicode_strlen(&arg5);
        assert!(arg6 >= arg0.min_year && arg6 <= arg0.max_year, 2);
        assert!(check_vaild(&arg5), 4);
        let v2 = 0x62fff363d8919c16c3354e452800afc92cc1815296475bb87b769b5e6468dc38::string_utils::string_get_parent(&arg5);
        let v3 = *0x1::string::bytes(&v2);
        let v4 = 0;
        let v5 = 0;
        let v6 = if (0x1::vector::length<u8>(&v3) > 0) {
            let v7 = 0x1::option::destroy_some<DomainNFT>(arg7);
            assert!(v1 >= 1 && v1 <= arg0.max_len, 2);
            assert!(v3 == *0x1::string::bytes(&v7.name) && is_have_valid_domain(arg1, arg3, &v7), 14);
            0x2::transfer::public_transfer<DomainNFT>(v7, v0);
            let v8 = 0;
            let v9 = 0;
            let v10 = 0x2::table::borrow<vector<u8>, Domain>(&arg1.domains, v3);
            let v11 = 100000000;
            if (0x2::vec_map::contains<u64, vector<u8>>(&v10.data, &v11)) {
                let v12 = 100000000;
                let v13 = 0x2::bcs::new(*0x2::vec_map::get<u64, vector<u8>>(&v10.data, &v12));
                v9 = 0x2::bcs::peel_u64(&mut v13);
            };
            let v14 = get_intdata_internal(arg1, v3, 100100000);
            let v15 = get_intdata_internal(arg1, v3, 100100001);
            assert!(v15 < 2, 12);
            v5 = v15 + 1;
            if (v14 == 0) {
                v8 = 1;
            } else if (v14 == 1) {
                v8 = 3;
            } else if (v14 == 2) {
                v8 = 5;
            } else if (v14 == 3) {
                v8 = 20;
            } else if (v14 == 4) {
                v8 = 40;
            } else if (v14 == 5) {
                v8 = 160;
            };
            assert!(v9 < v8, 11);
            let v16 = get_sub_price(arg6);
            assert!(v16 > 0, 5);
            let v17 = &mut arg1.sui_pool;
            store_coin<0x2::sui::SUI>(v17, arg4, v16, arg9);
            v16
        } else {
            0x1::option::destroy_none<DomainNFT>(arg7);
            assert!(v1 >= arg0.min_len && v1 <= arg0.max_len, 2);
            let v18 = get_price(arg0, arg6, v1);
            let v6 = v18;
            assert!(v18 > 0, 5);
            if (arg8 != @0x0) {
                let (v19, v20) = discount_with_referral(arg2, arg3, &arg5, v18, arg8, arg9);
                v4 = v20;
                v6 = v19;
            };
            if (v4 > 0 && arg8 != @0x0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg4, v4, arg9), arg8);
            };
            let v21 = &mut arg1.sui_pool;
            store_coin<0x2::sui::SUI>(v21, arg4, v6, arg9);
            v6
        };
        assert!(!0x2::table::contains<vector<u8>, Domain>(&arg1.domains, arg5) || is_domain_expired(arg1, arg3, &arg5), 6);
        if (!0x2::table::contains<address, vector<u8>>(&arg1.addr2domain, v0)) {
            0x2::table::add<address, vector<u8>>(&mut arg1.addr2domain, v0, arg5);
        };
        if (!0x2::table::contains<vector<u8>, address>(&arg1.domain2addr, arg5)) {
            0x2::table::add<vector<u8>, address>(&mut arg1.domain2addr, arg5, v0);
        } else {
            *0x2::table::borrow_mut<vector<u8>, address>(&mut arg1.domain2addr, arg5) = v0;
        };
        let v22 = 0x2::clock::timestamp_ms(arg3) / 1000;
        let v23 = v22 + 31536000 * arg6;
        let v24 = 0x2::vec_map::empty<u64, vector<u8>>();
        if (0x1::vector::length<u8>(&v3) > 0) {
            let v25 = 0x2::table::borrow_mut<vector<u8>, Domain>(&mut arg1.domains, v3);
            let v26 = 100000000 + 1;
            let v27 = 100000000;
            if (0x2::vec_map::contains<u64, vector<u8>>(&v25.data, &v27)) {
                let v28 = 100000000;
                let v29 = 0x2::vec_map::get_mut<u64, vector<u8>>(&mut v25.data, &v28);
                let v30 = 0x2::bcs::new(*v29);
                let v31 = 0x2::bcs::peel_u64(&mut v30) + 1;
                *v29 = 0x2::bcs::to_bytes<u64>(&v31);
                v26 = 100000000 + v31;
            } else {
                let v32 = 1;
                0x2::vec_map::insert<u64, vector<u8>>(&mut v25.data, 100000000, 0x2::bcs::to_bytes<u64>(&v32));
            };
            if (0x2::vec_map::contains<u64, vector<u8>>(&v25.data, &v26)) {
                *0x2::vec_map::get_mut<u64, vector<u8>>(&mut v25.data, &v26) = arg5;
            } else {
                0x2::vec_map::insert<u64, vector<u8>>(&mut v25.data, v26, arg5);
            };
            0x2::vec_map::insert<u64, vector<u8>>(&mut v24, 100100001, 0x62fff363d8919c16c3354e452800afc92cc1815296475bb87b769b5e6468dc38::string_utils::u64_to_string(v5));
        } else {
            0x2::vec_map::insert<u64, vector<u8>>(&mut v24, 1, 0x62fff363d8919c16c3354e452800afc92cc1815296475bb87b769b5e6468dc38::string_utils::address_to_string(&v0));
        };
        let v33 = create_domain_nft(arg5, v23, v22, arg9);
        let v34 = Domain{
            id         : 0x2::object::new(arg9),
            domain     : 0x1::string::utf8(arg5),
            nftid      : v33,
            creator    : v0,
            expiration : v23,
            regtime    : v22,
            data       : v24,
        };
        0x2::table::add<vector<u8>, Domain>(&mut arg1.domains, arg5, v34);
        let v35 = RegisterEvent{
            account : v0,
            domain  : 0x1::string::utf8(arg5),
            years   : arg6,
            price   : v6,
            time    : v22,
        };
        0x2::event::emit<RegisterEvent>(v35);
    }

    public entry fun register_sub(arg0: &BaseConfig, arg1: &mut GlobalMap, arg2: &mut ReferralMap, arg3: &0x2::clock::Clock, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: vector<u8>, arg6: u64, arg7: DomainNFT, arg8: &mut 0x2::tx_context::TxContext) {
        register_internal(arg0, arg1, arg2, arg3, arg4, arg5, arg6, 0x1::option::some<DomainNFT>(arg7), @0x0, arg8);
    }

    public entry fun register_with_referral(arg0: &BaseConfig, arg1: &mut GlobalMap, arg2: &mut ReferralMap, arg3: &0x2::clock::Clock, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: vector<u8>, arg6: u64, arg7: address, arg8: &mut 0x2::tx_context::TxContext) {
        register_internal(arg0, arg1, arg2, arg3, arg4, arg5, arg6, 0x1::option::none<DomainNFT>(), arg7, arg8);
    }

    public entry fun renewal(arg0: &BaseConfig, arg1: &mut GlobalMap, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut DomainNFT, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = *0x1::string::bytes(&arg4.name);
        let v2 = 0x62fff363d8919c16c3354e452800afc92cc1815296475bb87b769b5e6468dc38::string_utils::unicode_strlen(&v1);
        assert!(!arg0.pause, 8);
        assert!(arg5 >= arg0.min_year && arg5 <= arg0.max_year, 2);
        assert!(v2 >= arg0.min_len && v2 <= arg0.max_len, 2);
        assert!(0x2::table::contains<vector<u8>, Domain>(&arg1.domains, v1), 3);
        let v3 = get_price(arg0, arg5, v2);
        assert!(v3 > 0, 5);
        let v4 = &mut arg1.sui_pool;
        store_coin<0x2::sui::SUI>(v4, arg3, v3, arg6);
        let v5 = 0x2::table::borrow_mut<vector<u8>, Domain>(&mut arg1.domains, v1);
        let v6 = v5.expiration;
        let v7 = v6;
        let v8 = 0x2::clock::timestamp_ms(arg2) / 1000;
        if (v6 < v8) {
            v7 = v8;
        };
        v5.expiration = v7 + 31536000 * arg5;
        arg4.expiration = v5.expiration;
        let v9 = RegisterEvent{
            account : v0,
            domain  : 0x1::string::utf8(v1),
            years   : arg5,
            price   : v3,
            time    : v8,
        };
        0x2::event::emit<RegisterEvent>(v9);
    }

    public fun resolve_address(arg0: &GlobalMap, arg1: address) : vector<u8> {
        let v0 = b"";
        if (0x2::table::contains<address, vector<u8>>(&arg0.addr2domain, arg1)) {
            v0 = *0x2::table::borrow<address, vector<u8>>(&arg0.addr2domain, arg1);
        };
        v0
    }

    public entry fun set_config(arg0: &mut BaseConfig, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(admin_address() == 0x2::tx_context::sender(arg3), 1);
        if (arg1 == 1) {
            arg0.pause = arg2 > 0;
        } else if (arg1 == 2) {
            arg0.min_year = arg2;
        } else if (arg1 == 3) {
            arg0.max_year = arg2;
        } else if (arg1 == 4) {
            arg0.min_len = arg2;
        } else if (arg1 == 5) {
            arg0.max_len = arg2;
        } else if (arg1 >= 11 && arg1 <= 20) {
            *0x1::vector::borrow_mut<u64>(&mut arg0.price_list, arg1 - 10) = arg2;
        };
    }

    public entry fun set_data(arg0: &mut GlobalMap, arg1: &0x2::clock::Clock, arg2: &DomainNFT, arg3: u64, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 < 100000000 || arg3 > 200000000, 9);
        assert!(is_have_valid_domain(arg0, arg1, arg2), 14);
        set_data_internal(arg0, *0x1::string::bytes(&arg2.name), arg3, arg4);
    }

    fun set_data_internal(arg0: &mut GlobalMap, arg1: vector<u8>, arg2: u64, arg3: vector<u8>) {
        let v0 = 0x2::table::borrow_mut<vector<u8>, Domain>(&mut arg0.domains, arg1);
        if (0x2::vec_map::contains<u64, vector<u8>>(&v0.data, &arg2)) {
            *0x2::vec_map::get_mut<u64, vector<u8>>(&mut v0.data, &arg2) = arg3;
        } else {
            0x2::vec_map::insert<u64, vector<u8>>(&mut v0.data, arg2, arg3);
        };
    }

    fun set_intdata_internal(arg0: &mut GlobalMap, arg1: vector<u8>, arg2: u64, arg3: u64) {
        set_data_internal(arg0, arg1, arg2, 0x62fff363d8919c16c3354e452800afc92cc1815296475bb87b769b5e6468dc38::string_utils::u64_to_string(arg3));
    }

    fun store_coin<T0>(arg0: &mut 0x2::balance::Balance<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::put<T0>(arg0, 0x2::coin::split<T0>(&mut arg1, arg2, arg3));
        if (0x2::coin::value<T0>(&arg1) == 0) {
            0x2::coin::destroy_zero<T0>(arg1);
        } else {
            0x2::pay::keep<T0>(arg1, arg3);
        };
    }

    public entry fun upgrade_domain(arg0: &mut GlobalMap, arg1: &0x2::clock::Clock, arg2: &mut DomainNFT, arg3: 0x2::coin::Coin<0x62fff363d8919c16c3354e452800afc92cc1815296475bb87b769b5e6468dc38::apc::APC>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(is_have_valid_domain(arg0, arg1, arg2), 14);
        let v0 = *0x1::string::bytes(&arg2.name);
        let v1 = get_intdata_internal(arg0, v0, 100100000);
        let v2 = if (v1 == 0) {
            500000000
        } else if (v1 == 1) {
            2500000000
        } else if (v1 == 2) {
            10000000000
        } else if (v1 == 3) {
            50000000000
        } else {
            assert!(v1 == 4, 10);
            250000000000
        };
        assert!(v2 > 0, 5);
        let v3 = &mut arg0.apc_pool;
        store_coin<0x62fff363d8919c16c3354e452800afc92cc1815296475bb87b769b5e6468dc38::apc::APC>(v3, arg3, v2, arg4);
        let v4 = v1 + 1;
        set_intdata_internal(arg0, v0, 100100000, v4);
        arg2.url = get_domain_uri(v0, v4);
    }

    public entry fun withdraw_apc(arg0: &mut GlobalMap, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(admin_address() == v0, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x62fff363d8919c16c3354e452800afc92cc1815296475bb87b769b5e6468dc38::apc::APC>>(0x2::coin::take<0x62fff363d8919c16c3354e452800afc92cc1815296475bb87b769b5e6468dc38::apc::APC>(&mut arg0.apc_pool, arg1, arg2), v0);
    }

    public entry fun withdraw_sui(arg0: &mut GlobalMap, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(admin_address() == v0, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.sui_pool, arg1, arg2), v0);
    }

    // decompiled from Move bytecode v6
}

