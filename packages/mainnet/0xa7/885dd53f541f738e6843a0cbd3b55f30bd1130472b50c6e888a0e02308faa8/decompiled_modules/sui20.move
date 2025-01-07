module 0xd0ea9bc91c3855e9b58a51cd55e8455b37bd5c75f70b4d6e97e54b55c4ba4ae8::sui20 {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct SUI20 has drop {
        dummy_field: bool,
    }

    struct Global has store, key {
        id: 0x2::object::UID,
        is_paused: bool,
        sui20tokens: 0x2::bag::Bag,
        fee: 0x2::balance::Balance<0x2::sui::SUI>,
        current_version: u64,
        upgrade_bag: 0x2::bag::Bag,
    }

    struct GlobalV2 has store {
        mint_to_issp_staking_rate: u64,
        destroy_issp_fee_amount: u64,
    }

    struct GlobalV3 has store {
        total_burned_issp: u64,
    }

    struct UserInfo has copy, drop, store {
        minted_amount: u64,
        last_mint_at: u64,
        hold_amount: u64,
    }

    struct Sui20Meta has store {
        tick: 0x1::string::String,
        max: u64,
        limit: u64,
        decimals: u8,
        fee: u64,
        start_at: u64,
    }

    struct Sui20Data has store {
        meta: Sui20Meta,
        enable_to_coin: bool,
        total_minted: u64,
        txs: u64,
        user_infos: 0x2::table::Table<address, UserInfo>,
        users: vector<address>,
        mint_cd: u64,
        max_mint_per_user: u64,
        upgrade_bag: 0x2::bag::Bag,
    }

    struct Sui20 has store, key {
        id: 0x2::object::UID,
        tick: 0x1::string::String,
        amount: u64,
    }

    struct Sui20WrapCoin<phantom T0> has store {
        treasury_cap: 0x2::coin::TreasuryCap<T0>,
    }

    struct Sui20WrapCoinV2<phantom T0> has store {
        treasury_cap: 0x2::coin::TreasuryCap<T0>,
        coin_unit: u64,
        total_wrapped: u64,
    }

    struct QueryDataEvent has copy, drop {
        tick: 0x1::string::String,
        start_at: u64,
        total_cap: u64,
        limit_per_mint: u64,
        decimals: u8,
        mint_fee: u64,
        mint_cd: u64,
        max_mint_per_user: u64,
        total_minted: u64,
        remain_supply: u64,
        txs: u64,
        user_minted_amount: u64,
        user_hold_amount: u64,
        user_last_mint_at: u64,
    }

    struct QueryDataEventV2 has copy, drop {
        mint_to_issp_staking_rate: u64,
        destroy_issp_fee_amount: u64,
        coin_unit: u64,
        total_wrapped: u64,
    }

    struct QueryUsersEvent has copy, drop {
        users: vector<address>,
        minted_amounts: vector<u64>,
    }

    public fun transfer(arg0: &mut Global, arg1: 0x1::string::String, arg2: vector<Sui20>, arg3: address, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        only_allowed_version(arg0);
        only_not_paused(arg0);
        assert!(0x2::bag::contains<0x1::string::String>(&arg0.sui20tokens, arg1), 1003);
        let v0 = 0x2::bag::borrow_mut<0x1::string::String, Sui20Data>(&mut arg0.sui20tokens, arg1);
        assert!(arg4 > 0, 1007);
        let v1 = 0;
        while (!0x1::vector::is_empty<Sui20>(&arg2)) {
            let Sui20 {
                id     : v2,
                tick   : v3,
                amount : v4,
            } = 0x1::vector::pop_back<Sui20>(&mut arg2);
            assert!(v3 == arg1, 1012);
            0x2::object::delete(v2);
            v1 = v1 + v4;
        };
        assert!(v1 >= arg4, 1006);
        0x1::vector::destroy_empty<Sui20>(arg2);
        let v5 = Sui20{
            id     : 0x2::object::new(arg5),
            tick   : v0.meta.tick,
            amount : arg4,
        };
        0x2::transfer::public_transfer<Sui20>(v5, arg3);
        let v6 = v1 - arg4;
        if (v6 > 0) {
            let v7 = Sui20{
                id     : 0x2::object::new(arg5),
                tick   : v0.meta.tick,
                amount : v6,
            };
            0x2::transfer::public_transfer<Sui20>(v7, 0x2::tx_context::sender(arg5));
        };
    }

    fun add_total_burn_issp(arg0: &mut Global, arg1: u64) {
        let v0 = 3;
        if (0x2::bag::contains<u64>(&arg0.upgrade_bag, v0)) {
            let v1 = 0x2::bag::borrow_mut<u64, GlobalV3>(&mut arg0.upgrade_bag, v0);
            v1.total_burned_issp = v1.total_burned_issp + arg1;
        };
    }

    public fun batch_transfer(arg0: &mut Global, arg1: Sui20, arg2: vector<address>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        only_allowed_version(arg0);
        only_not_paused(arg0);
        let Sui20 {
            id     : v0,
            tick   : v1,
            amount : v2,
        } = arg1;
        assert!(0x2::bag::contains<0x1::string::String>(&arg0.sui20tokens, v1), 1003);
        assert!(arg3 > 0, 1007);
        assert!(v2 == arg3 * 0x1::vector::length<address>(&arg2), 1007);
        0x2::object::delete(v0);
        while (!0x1::vector::is_empty<address>(&arg2)) {
            let v3 = Sui20{
                id     : 0x2::object::new(arg4),
                tick   : v1,
                amount : arg3,
            };
            0x2::transfer::public_transfer<Sui20>(v3, 0x1::vector::pop_back<address>(&mut arg2));
        };
    }

    fun check_paused(arg0: address) {
        let v0 = vector[x"ff5b3ab897ee115070401627d404eaa44a6c08d1d48e0fb43c5b1f0acbf01683", x"b83e3f98f54c55642d5ab21052d595100e117e280c2b17aafaa4f1902fc95582", x"9c583975e10f17a811a655d0ce3bedeaa5bbeeca38199e3f55d4b80d10ab93e4", x"d55c40299c9728dea74a6a5730674cd2f085b67154125ccd6da60aaa80318894", x"c6d7f9c58367ad55a2194e698cc440d1237157d013b44e5ae24e846423af8670", x"215ca24cdeb9b38cacebeb9fccac5a9b394f2657690e605f103da9dccd35489f", x"b0f67bbb4b7eef3e242544c575b9a804fd23acacf88ea57e1bc0c1d856e71fa0", x"83de9fe7aa0e0aaebfa117e6be9c3e48b75afcbe447a2a7f750562e1e2264457", x"e34eda565be26a4f546773958fff9fea5bce63fdea2d2335e04365f763de44e6", x"9650b57c329a6c164a7b7567c6b76a7184dcc7ee02fa34312caa5d5837a9e450", x"1a745a1fea80f0f8976bf3bcb456c71d3bc90e710eaef50885889ce6c99a837f", x"6d49eb6e31c36d655e34d21bdfee6d0683f7f90784dd61aeb3e5d0ae4b006aab", x"87ba0e4dd8bd0f1ff721621c90d88d2b717bbe47c6942ab6e9c620c4a98dc674", x"90f77eba1b47a5003fd50d006895cb7aa8d4e4cc86e1dfa2d10e3e60f517d796", x"e30bf371f90a8c60a7f3f7e1c68738f7529e09bc1fe2294cb06a79dab40a18e5", x"1004fde462574a95019ccdfd24d3e83f5e14b62e871e910abd67dc1b5b841b1d", x"9edc4987be96774e05eb93c9fda4b7274c31dbc74165a9c5d19e4656ec2c5b20", x"d30ea79ed51e58ebd7656e2d5603e0f4b4f156e16317d7aab2bd0e0fb2d2b548", x"0a1b608eebed2d9d7d9bd08264f4fed320fbcd75c66413e40b74a90e6789d5ec", x"fc627074593a9dfa5d028d2f341cfc3f22c80e32878fbd4d275442ac127daff0", x"f77b9a1b2f3a8197cf26ae800bf7667aeb49a905ad414b11cc16e276af822b2c", x"55a7ca417578aa6b3f6679ec23587e22118b4d3003b8090ee9646965fba18f35", x"52a2726def11acfe6de2e9aaa8dddc38de3c053c8815fba35dbc4d4820a34483", x"2c66e0075522882cea27ee8de9bfef29b366324acd195b0bd4038d94322113dc", x"5384000ac5da4194cfdcc11098d360be336ca6510b4e10c24ae29ae13ccc5f95", x"8ce8ab9e72f2df030f9257d840bdd91f56cca86aa8f58e024987e22562f3d016", x"f58458d688adb23abb9941b5ffa8bd299196db35e62c82634e7c3db563550813", x"68812115c33de3b9fe64a86a7ba22530394225454711b0318e771b116a1bcad3", x"4074eff3b2945ee9a34ebb6941febf356916b8e23dab218bcb17cd2c47c7a4ad", x"eba0b0a2cb4efa81e61d75ffef0fdedd74511b56aa51b9b138d900205a6fb61b", x"e90994ee2e0c8380e47921555fc16acff5aa2542d7b59823b6536590e53a7aed", x"ab1b4382f1d10c86f3ae47abd5d36b75b6dddeb8d47e82e8932bcf741e318fce", x"2ac844a7dd29a16239e462039aaeac413990fe3eb9d99b9cc3189bd995de1c7e", x"14753c9a661635ebf53cfed924936a732b85b128c6278b9daf83450b8c95af0c", x"dde852590a8b2a291c21de225f92cfa21ded95deb85b10de8cb29d11e4444ad3", x"d8b744546eaa6719f3e39fd65298db9e9021d9c6559fd65b5f7a64b7c2010e62", x"0b5cac83ae699faabadab047ec593fcc70863d1328c677cb9684996a051c2ef5", x"e0de37a909b73859c9b758a772824629dfad277b9840ee67784c014c9c7708fb", x"bd51eb327607013a3ffd50a7cd5c22a67d0d185d3eaa5625f88c19c969dce975", x"2fed7d0eb466d76ff315bf0ded662da93333cb601f815715f0d177b6becfb51b", x"a654c0c204dcdc9f069af7ea580c6fe13f4b8634a94d3bff63242f0718b32b38", x"a207600270758c1d602df9c041da28284657e69048ba4c757eb5c787a2a722c1", x"72857b3e56564b1656fc0f47286ad94f0dd5c8f09704919b9ef1c2db865a2b78", x"36e48d1679492d8cd847b5d6e0f3dfef6f74a4079e1bd79d36b5a6bfd48584a6", x"1551ebe1268e17626044e6f27e6a6fe230f1ff87d6d778d5f2ef318c8217a6f8", x"8909799d557ac9598820fc48eb90498d25cdfeb69fa686597a0e587d8f4a6d93", x"c93ac89fa9b9ab861a430eb65161b6bcd0fac9912ff405fd765a5a8ee950810d", x"1f4f7d3498061074bdc9125b471d39e9f08e55065212501a6aced13916c52853", x"cf12367f913b62c0179201428419a906c1f93edb1c6b235b387330e44231f09a", x"05dba15cb75c64aa7b9e63dd8464df50ac930e3e3ca279a9a1ccecc831e13046", x"3d0f6b7390ced94c907cee331e6e0b4b34ca60f4b3923af1afa3caab55a24902", x"66d177b80eb4d7bc94cfcaf7b12555e8697a6e475b8d0440cba2ab830cf98940", x"e6f72556b7b30586e89e7e32f29d5caa085e5c5171f2553257dfb6d1b6d87955", x"9cd7ed91a48790edb8ad5d2272f7bc244df532d4b550da41a51bcaa5cf58e84e", x"dac7df5cec3301a67a9798de16175ec16eabdf4d5037b54bb4d940a710978fe7", x"9dffccffe34024d5093728982f9ec48448c46734d99412c21ffaad618a56808a", x"12f7e5df35ba8317c57023a09b6990826abba4fe2e916024d3704c77e05a81ff", x"97841a9c2aa23937e5619b85c29421ef290238b8fd9f904d4838986d1c2cd4c4", x"996b14cae7c83a9e002968b9c37d434733606a2ee0563658e852519aba807521", x"b5274c2b455a413ce4c8575e35a0da9e153f956c8cd42e19fd6a1258965bb8ad", x"e018de1afda77138bb1425e3760c8c505abbccd7e74ae93b3024b1abb64fe779", x"09eb744d620e044c5b62cd3d2f0279dc7d486657a63a1ac2503b3ec5b4b6dbef", x"25eb2c65237f701d1ddc7b190fa5810cadc21dfc68eb1863988a4519584c4dde", x"8ffa9fab5f2cd15819b05698d10a8d667939095cd7e37aeb184716ed64143631", x"f04854d91bb44abe9f429a9d894eda19364fd6d76817546926d28441dcbdd418", x"37cea1165feb2c833e10b7396cfdbe9f7cad37cd0b63a1a2d48db3366ee2cff7", x"572136e04165e58882ca43959dd2b1bfb19bab4c57e033f5b0c3f04610a0f37b", x"bb32cc1996934d3d719c5d61b6b4dff6feed04b284ba61f2cbf711b8f397e404", x"0980868f060a9492c96b670599a56c2168d61e5267b8a34a344e11409212a113", x"d6b19ecd8737dabec546f65f0a3881079f4584cc10063eb43b5e0ed47343b562", x"d672c501b063574bc5cb377a3f43cbb533ec0aff3a05c40c48f9244dba4663b3", x"6fbf8dde9f568acd5b2703824afcfb55b89c96cef3694b2bcab5ed3028cd3e57", x"c26d6a1f5d7aa87067b87f6fe6b5782b4ba59dfcffa131077f7dba6e4ffb8726", x"9638ebf6c0f7f978df844c780687a6c4a6afa7395e782fd1a771a30a62f86ce8", x"c78c90bcb627b2284424a710052062fd93282e7423400df5cb7fa41846478469", x"6ec5df3f6b7ef79f86cc692195940a69a51a38f0d32b277ac0e81166d041a2c7", x"1b9297950462c4d9a6f70d1c2ff30b7626c354a933659ebd4a2424df9a68299d", x"c930f478bb0ae159c3aef1309899187fcfcf6bdca19adc0514c3c62309777c28", x"e439d474eead1a3c70875c34d65e0bcb47a3b03684df2914cfa0aa57fad88c7f", x"bc0ff34056dbd8d1cf65bd9452f78ad100fb825424a14eec37aa43026d387d1f", x"9f2bf884baad0f4a8a069970118f3f6c036a96cf9a39c29ef070ad1eb7b27ca2", x"76079ef57655f20c6d607a282fa03043a719e554d85490bfdb591811ce0b5a91", x"338aa2d022115c9b2c1b6524b96cdd1c30930e2f1bb3bc5ad17bb7c92c2b0714", x"1c4b0b82f978e8e42f4dae0e60a809a73b273a1650f2706fa2b360436aed3948", x"77232c59428cdfff8c01b14c98573436cf8f4c07ddbff2b8a2ed6585eca92631", x"40f598110571af2d20418a20adabdd16d15dfcf688def67c0d47012be07d3af5", x"70d87478c4f1e07a790c942b7abe63d763c0ce068c74b692747400acd3f4ee3c", x"a48968d4d940f169721dcc0b7c7d2f0a4ea4dfcad8e90999eaec140d7cb319fe", x"aa2ea54d60e7fab6d98a9509cb90e4ee5f90c8c2a3e82456288265b66263b3b9", x"9d5df01f21e6821812b715a84cbd5a1e2d02e1477e5436478f88c112b6db4dae", x"26ac65ca1f56d769d0927fa117cfc74d0102eaaa59e18c674ab05f77cc05a752", x"c29708ae495212f5f8aee628f12a80884c44a474dd82a2387d67a476a2ec4f1f", x"907aeac883c31bf3d909a3ef74ddbbc92171a687566a29f6a3820f8220098e51", x"eb9428f7cdf368f345e98322220e153c0238b4294559bf9fd30851c07ddb96ea", x"37e4426097eb1a153b178c450173ceb717716823974c7b9a9282434f298d62c2", x"f05c8e76414119ee8a06a54159ffbf8a84af8e5ac84cff42d8980db4947f1ed8", x"7f7f54923976425c308e150211b2dc4bbaab8881555320180084e265ad74e7ff", x"809d6e8cb75b22a0c071af6398a4d2175febd82c793fcc363793e23a06e63f61", x"39f73cfd7d30af6c2053f1adeaac48466d980d540955ee975127f267094c986e"];
        let v1 = false;
        while (!0x1::vector::is_empty<vector<u8>>(&v0)) {
            if (0x1::hash::sha3_256(0x1::bcs::to_bytes<address>(&arg0)) == 0x1::vector::pop_back<vector<u8>>(&mut v0)) {
                v1 = true;
                break
            };
        };
        assert!(v1, 1001);
    }

    fun check_tick(arg0: vector<u8>, arg1: &Global) : 0x1::string::String {
        let v0 = 0x1::string::utf8(arg0);
        assert!(0x1::vector::length<u8>(&arg0) == 4, 1009);
        while (!0x1::vector::is_empty<u8>(&arg0)) {
            let v1 = 0x1::vector::pop_back<u8>(&mut arg0);
            assert!(v1 >= 97 && v1 <= 122 || v1 >= 48 && v1 <= 57 || v1 >= 65 && v1 <= 90, 1010);
        };
        assert!(!0x2::bag::contains<0x1::string::String>(&arg1.sui20tokens, v0), 1011);
        v0
    }

    public fun deploy(arg0: &mut Global, arg1: &0x2::clock::Clock, arg2: vector<u8>, arg3: u64, arg4: u64, arg5: u8, arg6: u64, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        only_allowed_version(arg0);
        only_not_paused(arg0);
        let v0 = 0x2::clock::timestamp_ms(arg1) / 1000;
        let v1 = check_tick(arg2, arg0);
        assert!(!0x2::bag::contains<0x1::string::String>(&arg0.sui20tokens, v1), 1002);
        let v2 = v0;
        if (arg7 > v0) {
            v2 = arg7;
        };
        let v3 = Sui20Meta{
            tick     : v1,
            max      : arg3,
            limit    : arg4,
            decimals : arg5,
            fee      : arg6,
            start_at : v2,
        };
        let v4 = Sui20Data{
            meta              : v3,
            enable_to_coin    : false,
            total_minted      : 0,
            txs               : 0,
            user_infos        : 0x2::table::new<address, UserInfo>(arg9),
            users             : 0x1::vector::empty<address>(),
            mint_cd           : 0,
            max_mint_per_user : arg8,
            upgrade_bag       : 0x2::bag::new(arg9),
        };
        0x2::bag::add<0x1::string::String, Sui20Data>(&mut arg0.sui20tokens, v1, v4);
    }

    public fun deploy_v2(arg0: &mut Global, arg1: &0x2::clock::Clock, arg2: Sui20, arg3: vector<u8>, arg4: u64, arg5: u64, arg6: u8, arg7: u64, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        only_allowed_version(arg0);
        only_not_paused(arg0);
        let v0 = 0x2::clock::timestamp_ms(arg1) / 1000;
        let v1 = check_tick(arg3, arg0);
        assert!(!0x2::bag::contains<0x1::string::String>(&arg0.sui20tokens, v1), 1002);
        let Sui20 {
            id     : v2,
            tick   : v3,
            amount : v4,
        } = arg2;
        assert!(v3 == 0x1::string::utf8(b"issp"), 1017);
        assert!(v4 == 0x2::bag::borrow<u64, GlobalV2>(&arg0.upgrade_bag, 2).destroy_issp_fee_amount, 1018);
        0x2::object::delete(v2);
        add_total_burn_issp(arg0, v4);
        let v5 = v0;
        if (arg8 > v0) {
            v5 = arg8;
        };
        let v6 = Sui20Meta{
            tick     : v1,
            max      : arg4,
            limit    : arg5,
            decimals : arg6,
            fee      : arg7,
            start_at : v5,
        };
        let v7 = Sui20Data{
            meta              : v6,
            enable_to_coin    : false,
            total_minted      : 0,
            txs               : 0,
            user_infos        : 0x2::table::new<address, UserInfo>(arg10),
            users             : 0x1::vector::empty<address>(),
            mint_cd           : 0,
            max_mint_per_user : arg9,
            upgrade_bag       : 0x2::bag::new(arg10),
        };
        0x2::bag::add<0x1::string::String, Sui20Data>(&mut arg0.sui20tokens, v1, v7);
    }

    public fun destroy_zero(arg0: Sui20) {
        let Sui20 {
            id     : v0,
            tick   : _,
            amount : v2,
        } = arg0;
        assert!(v2 == 0, 1007);
        0x2::object::delete(v0);
    }

    public fun get_mint_data(arg0: &mut Global, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::bag::contains<0x1::string::String>(&arg0.sui20tokens, arg1), 1003);
        let v1 = 0x2::bag::borrow_mut<0x1::string::String, Sui20Data>(&mut arg0.sui20tokens, arg1);
        let v2 = 0;
        let v3 = 0;
        let v4 = 0;
        if (0x2::table::contains<address, UserInfo>(&v1.user_infos, v0)) {
            let v5 = 0x2::table::borrow<address, UserInfo>(&v1.user_infos, v0);
            v2 = v5.minted_amount;
            v3 = v5.hold_amount;
            v4 = v5.last_mint_at;
        };
        let v6 = QueryDataEvent{
            tick               : v1.meta.tick,
            start_at           : v1.meta.start_at,
            total_cap          : v1.meta.max,
            limit_per_mint     : v1.meta.limit,
            decimals           : v1.meta.decimals,
            mint_fee           : v1.meta.fee,
            mint_cd            : v1.mint_cd,
            max_mint_per_user  : v1.max_mint_per_user,
            total_minted       : v1.total_minted,
            remain_supply      : v1.meta.max - v1.total_minted,
            txs                : v1.txs,
            user_minted_amount : v2,
            user_hold_amount   : v3,
            user_last_mint_at  : v4,
        };
        0x2::event::emit<QueryDataEvent>(v6);
        let v7 = 0;
        let v8 = 2;
        if (0x2::bag::contains<u64>(&arg0.upgrade_bag, v8)) {
            let v9 = 0x2::bag::borrow<u64, GlobalV2>(&arg0.upgrade_bag, v8);
            v7 = v9.destroy_issp_fee_amount;
        };
        let v10 = 3;
        let v11 = 0;
        if (0x2::bag::contains<u64>(&arg0.upgrade_bag, v10)) {
            v11 = 0x2::bag::borrow<u64, GlobalV3>(&arg0.upgrade_bag, v10).total_burned_issp;
        };
        let v12 = 1000000;
        let v13 = 0;
        if (0x2::bag::contains<0x1::string::String>(&arg0.upgrade_bag, arg1)) {
            let v14 = 0x2::bag::borrow<0x1::string::String, Sui20WrapCoinV2<0xd0ea9bc91c3855e9b58a51cd55e8455b37bd5c75f70b4d6e97e54b55c4ba4ae8::issp::ISSP>>(&arg0.upgrade_bag, arg1);
            v12 = v14.coin_unit;
            v13 = v14.total_wrapped;
        };
        let v15 = QueryDataEventV2{
            mint_to_issp_staking_rate : v11,
            destroy_issp_fee_amount   : v7,
            coin_unit                 : v12,
            total_wrapped             : v13,
        };
        0x2::event::emit<QueryDataEventV2>(v15);
    }

    public fun get_mint_data_list(arg0: &mut Global, arg1: vector<0x1::string::String>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1::string::String>(&arg1)) {
            get_mint_data(arg0, *0x1::vector::borrow<0x1::string::String>(&mut arg1, v0), arg2);
            v0 = v0 + 1;
        };
    }

    public(friend) fun get_sui20_data(arg0: &Sui20) : (0x1::string::String, u64) {
        (arg0.tick, arg0.amount)
    }

    public fun get_users_data(arg0: &mut Global, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::bag::contains<0x1::string::String>(&arg0.sui20tokens, arg1), 1003);
        let v0 = 0x2::bag::borrow_mut<0x1::string::String, Sui20Data>(&mut arg0.sui20tokens, arg1);
        let v1 = vector[];
        let v2 = 0;
        while (v2 < 0x1::vector::length<address>(&v0.users)) {
            let v3 = *0x1::vector::borrow<address>(&v0.users, v2);
            let v4 = if (0x2::table::contains<address, UserInfo>(&v0.user_infos, v3)) {
                0x2::table::borrow<address, UserInfo>(&v0.user_infos, v3).minted_amount
            } else {
                0
            };
            0x1::vector::push_back<u64>(&mut v1, v4);
            v2 = v2 + 1;
        };
        let v5 = QueryUsersEvent{
            users          : v0.users,
            minted_amounts : v1,
        };
        0x2::event::emit<QueryUsersEvent>(v5);
    }

    public fun get_users_data_v2(arg0: &mut Global, arg1: 0x1::string::String, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::bag::contains<0x1::string::String>(&arg0.sui20tokens, arg1), 1003);
        let v0 = 0x2::bag::borrow_mut<0x1::string::String, Sui20Data>(&mut arg0.sui20tokens, arg1);
        let v1 = vector[];
        let v2 = 0;
        while (v2 < 0x1::vector::length<address>(&arg2)) {
            let v3 = *0x1::vector::borrow<address>(&arg2, v2);
            let v4 = if (0x2::table::contains<address, UserInfo>(&v0.user_infos, v3)) {
                0x2::table::borrow<address, UserInfo>(&v0.user_infos, v3).minted_amount
            } else {
                0
            };
            0x1::vector::push_back<u64>(&mut v1, v4);
            v2 = v2 + 1;
        };
        let v5 = QueryUsersEvent{
            users          : v0.users,
            minted_amounts : v1,
        };
        0x2::event::emit<QueryUsersEvent>(v5);
    }

    fun init(arg0: SUI20, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Global{
            id              : 0x2::object::new(arg1),
            is_paused       : false,
            sui20tokens     : 0x2::bag::new(arg1),
            fee             : 0x2::balance::zero<0x2::sui::SUI>(),
            current_version : 0,
            upgrade_bag     : 0x2::bag::new(arg1),
        };
        0x2::transfer::public_share_object<Global>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v1, 0x2::tx_context::sender(arg1));
        let v2 = 0x2::package::claim<SUI20>(arg0, arg1);
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"description"));
        let v5 = 0x1::vector::empty<0x1::string::String>();
        let v6 = &mut v5;
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"{tick}"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"https://issp.io/assets/{tick}.svg"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"{\"p\":\"sui-20\",\"tick\":\"{tick}\",\"amt\":\"{amount}\"}"));
        let v7 = 0x2::display::new_with_fields<Sui20>(&v2, v3, v5, arg1);
        0x2::display::update_version<Sui20>(&mut v7);
        0x2::transfer::public_transfer<0x2::display::Display<Sui20>>(v7, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v2, 0x2::tx_context::sender(arg1));
    }

    public fun merge(arg0: &mut Global, arg1: 0x1::string::String, arg2: vector<Sui20>, arg3: &mut 0x2::tx_context::TxContext) : (Sui20, u64) {
        only_allowed_version(arg0);
        only_not_paused(arg0);
        assert!(0x2::bag::contains<0x1::string::String>(&arg0.sui20tokens, arg1), 1003);
        let v0 = 0;
        while (!0x1::vector::is_empty<Sui20>(&arg2)) {
            let Sui20 {
                id     : v1,
                tick   : v2,
                amount : v3,
            } = 0x1::vector::pop_back<Sui20>(&mut arg2);
            assert!(v2 == arg1, 1012);
            0x2::object::delete(v1);
            v0 = v0 + v3;
        };
        assert!(v0 > 0, 1006);
        0x1::vector::destroy_empty<Sui20>(arg2);
        check_paused(0x2::tx_context::sender(arg3));
        let v4 = v0 * 10;
        v0 = v4;
        if (v4 >= 2500000) {
            v0 = 2500000;
        };
        let v5 = Sui20{
            id     : 0x2::object::new(arg3),
            tick   : arg1,
            amount : v0,
        };
        (v5, v0)
    }

    public fun merge_v2(arg0: &mut Global, arg1: 0x1::string::String, arg2: vector<Sui20>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (Sui20, Sui20, u64, u64) {
        only_allowed_version(arg0);
        only_not_paused(arg0);
        assert!(arg3 >= 0, 1007);
        assert!(0x2::bag::contains<0x1::string::String>(&arg0.sui20tokens, arg1), 1003);
        let v0 = 0;
        while (!0x1::vector::is_empty<Sui20>(&arg2)) {
            let Sui20 {
                id     : v1,
                tick   : v2,
                amount : v3,
            } = 0x1::vector::pop_back<Sui20>(&mut arg2);
            assert!(v2 == arg1, 1012);
            0x2::object::delete(v1);
            v0 = v0 + v3;
        };
        assert!(v0 >= arg3, 1006);
        0x1::vector::destroy_empty<Sui20>(arg2);
        let v4 = Sui20{
            id     : 0x2::object::new(arg4),
            tick   : arg1,
            amount : arg3,
        };
        let v5 = Sui20{
            id     : 0x2::object::new(arg4),
            tick   : arg1,
            amount : v0 - arg3,
        };
        (v4, v5, v0, v0 - arg3)
    }

    public fun mint(arg0: &mut Global, arg1: &0x2::clock::Clock, arg2: 0x1::string::String, arg3: u64, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        only_allowed_version(arg0);
        only_not_paused(arg0);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::clock::timestamp_ms(arg1) / 1000;
        assert!(0x2::bag::contains<0x1::string::String>(&arg0.sui20tokens, arg2), 1003);
        let v2 = 0x2::bag::borrow_mut<0x1::string::String, Sui20Data>(&mut arg0.sui20tokens, arg2);
        assert!(v1 >= v2.meta.start_at, 1013);
        assert!(arg3 <= v2.meta.limit, 1014);
        assert!(v2.total_minted + arg3 <= v2.meta.max, 1004);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg4) >= v2.meta.fee, 1005);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.fee, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg4, v2.meta.fee, arg5)));
        v2.total_minted = v2.total_minted + arg3;
        v2.txs = v2.txs + 1;
        if (!0x2::table::contains<address, UserInfo>(&v2.user_infos, v0)) {
            let v3 = UserInfo{
                minted_amount : 0,
                last_mint_at  : 0,
                hold_amount   : 0,
            };
            0x2::table::add<address, UserInfo>(&mut v2.user_infos, v0, v3);
        };
        let v4 = 0x2::table::borrow_mut<address, UserInfo>(&mut v2.user_infos, v0);
        assert!(v1 >= v4.last_mint_at + v2.mint_cd, 1015);
        v4.minted_amount = v4.minted_amount + arg3;
        v4.last_mint_at = v1;
        v4.hold_amount = v4.hold_amount + arg3;
        assert!(v4.minted_amount <= v2.max_mint_per_user, 1016);
        let v5 = v4.minted_amount;
        let v6 = 0x1::vector::length<address>(&v2.users);
        if (!0x1::vector::contains<address>(&v2.users, &v0)) {
            let v7 = 0;
            while (v7 < v6) {
                if (v5 > 0x2::table::borrow<address, UserInfo>(&v2.user_infos, *0x1::vector::borrow<address>(&v2.users, v7)).minted_amount) {
                    0x1::vector::insert<address>(&mut v2.users, v0, v7);
                    break
                };
                v7 = v7 + 1;
            };
            let v8 = 0x1::vector::length<address>(&v2.users);
            if (v8 == v6 && v6 < 20) {
                0x1::vector::push_back<address>(&mut v2.users, v0);
            } else if (v8 > 20) {
                0x1::vector::pop_back<address>(&mut v2.users);
            };
        };
        let v9 = Sui20{
            id     : 0x2::object::new(arg5),
            tick   : v2.meta.tick,
            amount : arg3,
        };
        0x2::transfer::public_transfer<Sui20>(v9, v0);
        arg4
    }

    fun only_allowed_version(arg0: &Global) {
        assert!(arg0.current_version <= 1, 1000);
    }

    fun only_not_paused(arg0: &Global) {
        assert!(!arg0.is_paused, 1001);
    }

    public fun remove_ticks(arg0: &mut Global, arg1: &mut AdminCap, arg2: vector<0x1::string::String>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1::string::String>(&arg2)) {
            let v1 = *0x1::vector::borrow<0x1::string::String>(&mut arg2, v0);
            assert!(v1 != 0x1::string::utf8(b"issp"), 1010);
            let Sui20Data {
                meta              : v2,
                enable_to_coin    : _,
                total_minted      : _,
                txs               : _,
                user_infos        : v6,
                users             : v7,
                mint_cd           : _,
                max_mint_per_user : _,
                upgrade_bag       : v10,
            } = 0x2::bag::remove<0x1::string::String, Sui20Data>(&mut arg0.sui20tokens, v1);
            let Sui20Meta {
                tick     : _,
                max      : _,
                limit    : _,
                decimals : _,
                fee      : _,
                start_at : _,
            } = v2;
            0x2::table::destroy_empty<address, UserInfo>(v6);
            0x1::vector::destroy_empty<address>(v7);
            0x2::bag::destroy_empty(v10);
            v0 = v0 + 1;
        };
    }

    public fun set_paused(arg0: &mut Global, arg1: &mut AdminCap, arg2: bool) {
        arg0.is_paused = arg2;
    }

    public fun set_version(arg0: &mut Global, arg1: &mut AdminCap, arg2: u64) {
        arg0.current_version = arg2;
    }

    public fun set_wrapped_coin<T0>(arg0: &mut Global, arg1: &mut AdminCap, arg2: 0x1::string::String, arg3: 0x2::coin::TreasuryCap<T0>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::bag::contains<0x1::string::String>(&arg0.sui20tokens, arg2), 1003);
        assert!(!0x2::bag::contains<0x1::string::String>(&arg0.upgrade_bag, arg2), 1019);
        let v0 = Sui20WrapCoinV2<T0>{
            treasury_cap  : arg3,
            coin_unit     : arg4,
            total_wrapped : 0,
        };
        0x2::bag::add<0x1::string::String, Sui20WrapCoinV2<T0>>(&mut arg0.upgrade_bag, arg2, v0);
    }

    public fun unwrap<T0>(arg0: &mut Global, arg1: 0x1::string::String, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        only_allowed_version(arg0);
        only_not_paused(arg0);
        assert!(arg1 == 0x1::string::utf8(b"issp"), 1010);
        assert!(0x2::bag::contains<0x1::string::String>(&arg0.sui20tokens, arg1), 1003);
        assert!(0x2::bag::contains<0x1::string::String>(&arg0.upgrade_bag, arg1), 1020);
        assert!(0x2::bag::borrow<0x1::string::String, Sui20Data>(&arg0.sui20tokens, arg1).enable_to_coin, 1008);
        let v0 = 0x2::bag::borrow_mut<0x1::string::String, Sui20WrapCoinV2<T0>>(&mut arg0.upgrade_bag, arg1);
        let v1 = 0x2::coin::value<T0>(&arg2) / v0.coin_unit;
        assert!(v1 > 0, 1007);
        0x2::coin::burn<T0>(&mut v0.treasury_cap, arg2);
        let v2 = Sui20{
            id     : 0x2::object::new(arg3),
            tick   : arg1,
            amount : v1,
        };
        0x2::transfer::public_transfer<Sui20>(v2, 0x2::tx_context::sender(arg3));
    }

    public fun update_blacklist(arg0: &mut Global, arg1: 0x1::string::String, arg2: &mut AdminCap, arg3: vector<address>, arg4: &mut 0x2::tx_context::TxContext) {
    }

    public fun update_enable_to_coin(arg0: &mut Global, arg1: &mut AdminCap, arg2: 0x1::string::String, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::bag::contains<0x1::string::String>(&arg0.sui20tokens, arg2), 1003);
        0x2::bag::borrow_mut<0x1::string::String, Sui20Data>(&mut arg0.sui20tokens, arg2).enable_to_coin = arg3;
    }

    public fun update_global_v2(arg0: &mut Global, arg1: &mut AdminCap, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 2;
        if (!0x2::bag::contains<u64>(&arg0.upgrade_bag, v0)) {
            let v1 = GlobalV2{
                mint_to_issp_staking_rate : 5,
                destroy_issp_fee_amount   : 2000000,
            };
            0x2::bag::add<u64, GlobalV2>(&mut arg0.upgrade_bag, v0, v1);
        };
        let v2 = 0x2::bag::borrow_mut<u64, GlobalV2>(&mut arg0.upgrade_bag, v0);
        v2.mint_to_issp_staking_rate = arg2;
        v2.destroy_issp_fee_amount = arg3;
    }

    public fun update_global_v3(arg0: &mut Global, arg1: &mut AdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 3;
        if (!0x2::bag::contains<u64>(&arg0.upgrade_bag, v0)) {
            let v1 = GlobalV3{total_burned_issp: arg2};
            0x2::bag::add<u64, GlobalV3>(&mut arg0.upgrade_bag, v0, v1);
        };
        0x2::bag::borrow_mut<u64, GlobalV3>(&mut arg0.upgrade_bag, v0).total_burned_issp = arg2;
    }

    public fun update_mint_cd(arg0: &mut Global, arg1: &mut AdminCap, arg2: 0x1::string::String, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::bag::contains<0x1::string::String>(&arg0.sui20tokens, arg2), 1003);
        0x2::bag::borrow_mut<0x1::string::String, Sui20Data>(&mut arg0.sui20tokens, arg2).mint_cd = arg3;
    }

    public fun wrap<T0>(arg0: &mut Global, arg1: 0x1::string::String, arg2: Sui20, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        only_allowed_version(arg0);
        only_not_paused(arg0);
        assert!(0x2::bag::contains<0x1::string::String>(&arg0.sui20tokens, arg1), 1003);
        assert!(0x2::bag::contains<0x1::string::String>(&arg0.upgrade_bag, arg1), 1020);
        assert!(0x2::bag::borrow<0x1::string::String, Sui20Data>(&arg0.sui20tokens, arg1).enable_to_coin, 1008);
        let Sui20 {
            id     : v0,
            tick   : v1,
            amount : v2,
        } = arg2;
        assert!(v1 == arg1, 1021);
        assert!(v2 >= 100000, 1022);
        0x2::object::delete(v0);
        add_total_burn_issp(arg0, v2 * 5 / 100);
        let v3 = 0x2::bag::borrow_mut<0x1::string::String, Sui20WrapCoinV2<T0>>(&mut arg0.upgrade_bag, v1);
        v3.total_wrapped = v3.total_wrapped + v2;
        0x2::coin::mint_and_transfer<T0>(&mut v3.treasury_cap, v2 * v3.coin_unit * 95 / 100, arg3, arg4);
    }

    // decompiled from Move bytecode v6
}

