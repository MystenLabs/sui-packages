module 0x14470654c3a7ba95508adea62f05b227a9a1dac1a1a0128eee296ce12ce55d58::swarm_license_sale {
    struct MasterPower has key {
        id: 0x2::object::UID,
    }

    struct AdminPower has key {
        id: 0x2::object::UID,
    }

    struct AdminWhitelist has key {
        id: 0x2::object::UID,
        wallets: 0x2::vec_set::VecSet<address>,
    }

    struct Referrer has store, key {
        id: 0x2::object::UID,
        wallet: address,
        code: 0x1::string::String,
        referrals: 0x2::object_table::ObjectTable<address, Referee>,
        sales: u64,
    }

    struct ReferrerReceipt has key {
        id: 0x2::object::UID,
        referrer_id: 0x2::object::ID,
    }

    struct Referee has store, key {
        id: 0x2::object::UID,
        referrer_id: 0x2::object::ID,
    }

    struct License has store, key {
        id: 0x2::object::UID,
        price: Price,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
    }

    struct Price has store, key {
        id: 0x2::object::UID,
        current: u64,
        next: u64,
    }

    struct Treasury has key {
        id: 0x2::object::UID,
        wallet: address,
        sales: u64,
        airdrops: u64,
        total_distribution: u64,
        balance: u64,
        holders: 0x2::table::Table<address, 0x2::vec_set::VecSet<0x2::object::ID>>,
        price: Price,
        custom_referral_codes: 0x2::table::Table<address, 0x1::string::String>,
        wallet_addres_to_referrer_id: 0x2::table::Table<address, 0x2::object::ID>,
        referral_code_to_referrer: 0x2::object_table::ObjectTable<0x1::string::String, Referrer>,
        is_purchasing_paused: bool,
    }

    struct CreateLicenseEvent has copy, drop {
        license_id: 0x2::object::ID,
        referral_code: 0x1::string::String,
        owner: address,
        current_price: u64,
        referrer_id: 0x2::object::ID,
        referrer_wallet_address: address,
    }

    struct CreateReferrerEvent has copy, drop {
        referrer_id: 0x2::object::ID,
        code: 0x1::string::String,
        wallet: address,
    }

    struct ReferrerCashbackPaybackEvent has copy, drop {
        referee_id: 0x2::object::ID,
        referrer_id: 0x2::object::ID,
        quantity: u64,
        treasury_payment_amount: u64,
        cashback_amount: u64,
        code: 0x1::string::String,
    }

    public entry fun airdrop_license(arg0: &AdminPower, arg1: &AdminWhitelist, arg2: &mut Treasury, arg3: address, arg4: 0x1::string::String, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert_only_admin(arg1, 0x2::tx_context::sender(arg6));
        assert!(arg5 > 0, 5);
        assert!(arg5 <= 50, 5);
        internal_create_referrer(arg2, arg3, arg6);
        let v0 = 0;
        loop {
            v0 = v0 + 1;
            if (v0 > arg5) {
                break
            };
            let v1 = Price{
                id      : 0x2::object::new(arg6),
                current : 0,
                next    : 0,
            };
            internal_create_and_transfer_license(arg2, v1, arg3, arg4, arg6);
        };
        arg2.airdrops = arg2.airdrops + arg5;
        arg2.total_distribution = arg2.total_distribution + arg5;
    }

    public entry fun approve_admin_power(arg0: &MasterPower, arg1: &mut AdminWhitelist, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminPower{id: 0x2::object::new(arg3)};
        0x2::transfer::transfer<AdminPower>(v0, arg2);
        if (!0x2::vec_set::contains<address>(&arg1.wallets, &arg2)) {
            0x2::vec_set::insert<address>(&mut arg1.wallets, arg2);
        };
    }

    fun assert_only_admin(arg0: &AdminWhitelist, arg1: address) {
        assert!(0x2::vec_set::contains<address>(&arg0.wallets, &arg1), 1);
    }

    public entry fun assign_custom_referral_code(arg0: &AdminPower, arg1: &AdminWhitelist, arg2: &mut Treasury, arg3: address, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) {
        assert_only_admin(arg1, 0x2::tx_context::sender(arg5));
        assert!(!0x2::object_table::contains<0x1::string::String, Referrer>(&arg2.referral_code_to_referrer, arg4), 4);
        0x2::table::add<address, 0x1::string::String>(&mut arg2.custom_referral_codes, arg3, arg4);
        internal_create_referrer(arg2, arg3, arg5);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MasterPower{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<MasterPower>(v0, @0x240ee10031bd2b6cab0c7b155076c507bb4a752a50d8b64b72f540c4800ac3c7);
        let v1 = Price{
            id      : 0x2::object::new(arg0),
            current : 999000000,
            next    : internal_calculate_price(1),
        };
        let v2 = Treasury{
            id                           : 0x2::object::new(arg0),
            wallet                       : @0xcf4ed6b33856f7a4eef1c20c0ceb440bc5dda07717b9137ac154cd6c3d9c0798,
            sales                        : 0,
            airdrops                     : 0,
            total_distribution           : 0,
            balance                      : 0,
            holders                      : 0x2::table::new<address, 0x2::vec_set::VecSet<0x2::object::ID>>(arg0),
            price                        : v1,
            custom_referral_codes        : 0x2::table::new<address, 0x1::string::String>(arg0),
            wallet_addres_to_referrer_id : 0x2::table::new<address, 0x2::object::ID>(arg0),
            referral_code_to_referrer    : 0x2::object_table::new<0x1::string::String, Referrer>(arg0),
            is_purchasing_paused         : false,
        };
        0x2::transfer::share_object<Treasury>(v2);
        let v3 = AdminWhitelist{
            id      : 0x2::object::new(arg0),
            wallets : 0x2::vec_set::empty<address>(),
        };
        0x2::transfer::share_object<AdminWhitelist>(v3);
    }

    fun internal_calculate_cashback_amount(arg0: u64, arg1: u64) : u64 {
        arg0 * arg1 / 1000000
    }

    fun internal_calculate_price(arg0: u64) : u64 {
        if (arg0 <= 12000) {
            return 999000000
        };
        if (arg0 <= 16500) {
            return 1099000000 + (arg0 - 12000) / 100 * 10000000
        };
        if (arg0 <= 21000) {
            return 1559000000 + (arg0 - 16500) / 100 * 20000000
        };
        if (arg0 <= 25500) {
            return 2469000000 + (arg0 - 21000) / 100 * 30000000
        };
        if (arg0 <= 30000) {
            return 3829000000 + (arg0 - 25500) / 100 * 40000000
        };
        3829000000 + (30000 - 25500) / 100 * 40000000
    }

    fun internal_calculate_referral_cashback_rate(arg0: u64) : u64 {
        if (arg0 == 0) {
            return 0
        };
        let v0 = 50000 + (arg0 - 1) / 5 * 2000;
        if (v0 > 100000) {
            100000
        } else {
            v0
        }
    }

    fun internal_create_and_transfer_license(arg0: &mut Treasury, arg1: Price, arg2: address, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = License{
            id          : 0x2::object::new(arg4),
            price       : arg1,
            name        : 0x1::string::utf8(b"Swarm Network Agent License"),
            description : 0x1::string::utf8(b"This Agent License grants you access to exclusive Swarm Network products."),
            url         : 0x2::url::new_unsafe_from_bytes(b"https://blockchainassetregistry.infura-ipfs.io/ipfs/bafybeihkoo5676virvhw2x2hg4hoicmxrg2k57p7zeyvmfhcj4c2bxh4dm/swarm-network-agent-license-NFT-ascii-art.png"),
        };
        if (!0x2::table::contains<address, 0x2::vec_set::VecSet<0x2::object::ID>>(&arg0.holders, arg2)) {
            0x2::table::add<address, 0x2::vec_set::VecSet<0x2::object::ID>>(&mut arg0.holders, arg2, 0x2::vec_set::empty<0x2::object::ID>());
        };
        0x2::vec_set::insert<0x2::object::ID>(0x2::table::borrow_mut<address, 0x2::vec_set::VecSet<0x2::object::ID>>(&mut arg0.holders, arg2), 0x2::object::id<License>(&v0));
        let v1 = 0x2::object_table::borrow<0x1::string::String, Referrer>(&arg0.referral_code_to_referrer, arg3);
        let v2 = CreateLicenseEvent{
            license_id              : 0x2::object::id<License>(&v0),
            referral_code           : arg3,
            owner                   : arg2,
            current_price           : v0.price.current,
            referrer_id             : 0x2::object::id<Referrer>(v1),
            referrer_wallet_address : v1.wallet,
        };
        0x2::event::emit<CreateLicenseEvent>(v2);
        0x2::transfer::transfer<License>(v0, arg2);
    }

    fun internal_create_referee(arg0: &mut Treasury, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object_table::contains<0x1::string::String, Referrer>(&arg0.referral_code_to_referrer, arg1), 9223374437741494271);
        let v0 = 0x2::object_table::borrow_mut<0x1::string::String, Referrer>(&mut arg0.referral_code_to_referrer, arg1);
        if (0x2::object_table::contains<address, Referee>(&v0.referrals, 0x2::tx_context::sender(arg2))) {
            return
        };
        let v1 = Referee{
            id          : 0x2::object::new(arg2),
            referrer_id : 0x2::object::id<Referrer>(v0),
        };
        0x2::object_table::add<address, Referee>(&mut v0.referrals, 0x2::tx_context::sender(arg2), v1);
    }

    fun internal_create_referrer(arg0: &mut Treasury, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::table::contains<address, 0x2::vec_set::VecSet<0x2::object::ID>>(&arg0.holders, arg1)) {
            return
        };
        let v0 = if (0x2::table::contains<address, 0x1::string::String>(&arg0.custom_referral_codes, arg1)) {
            *0x2::table::borrow<address, 0x1::string::String>(&arg0.custom_referral_codes, arg1)
        } else {
            internal_generate_referral_code(arg1)
        };
        if (0x2::object_table::contains<0x1::string::String, Referrer>(&arg0.referral_code_to_referrer, v0)) {
            return
        };
        let v1 = Referrer{
            id        : 0x2::object::new(arg2),
            wallet    : arg1,
            code      : v0,
            referrals : 0x2::object_table::new<address, Referee>(arg2),
            sales     : 0,
        };
        let v2 = 0x2::object::id<Referrer>(&v1);
        let v3 = ReferrerReceipt{
            id          : 0x2::object::new(arg2),
            referrer_id : v2,
        };
        let v4 = CreateReferrerEvent{
            referrer_id : v2,
            code        : v0,
            wallet      : arg1,
        };
        0x2::event::emit<CreateReferrerEvent>(v4);
        if (0x2::table::contains<address, 0x2::object::ID>(&arg0.wallet_addres_to_referrer_id, arg1)) {
            0x2::table::remove<address, 0x2::object::ID>(&mut arg0.wallet_addres_to_referrer_id, arg1);
        };
        0x2::table::add<address, 0x2::object::ID>(&mut arg0.wallet_addres_to_referrer_id, arg1, v2);
        0x2::object_table::add<0x1::string::String, Referrer>(&mut arg0.referral_code_to_referrer, v0, v1);
        0x2::transfer::transfer<ReferrerReceipt>(v3, arg1);
    }

    fun internal_generate_referral_code(arg0: address) : 0x1::string::String {
        let v0 = 0x2::bcs::to_bytes<address>(&arg0);
        let v1 = 0x1::vector::empty<u8>();
        let v2 = 0;
        while (v2 < 3) {
            0x1::vector::push_back<u8>(&mut v1, *0x1::vector::borrow<u8>(&v0, v2) % 26 + 65);
            v2 = v2 + 1;
        };
        while (v2 < 6) {
            0x1::vector::push_back<u8>(&mut v1, *0x1::vector::borrow<u8>(&v0, v2) % 10 + 48);
            v2 = v2 + 1;
        };
        0x1::string::utf8(v1)
    }

    fun internal_process_payment(arg0: &mut Treasury, arg1: &mut 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg2: u64, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object_table::contains<0x1::string::String, Referrer>(&arg0.referral_code_to_referrer, arg3), 9223374025424633855);
        let v0 = 0x2::object_table::borrow<0x1::string::String, Referrer>(&arg0.referral_code_to_referrer, arg3);
        let v1 = 0x2::tx_context::sender(arg4);
        assert!(&v0.wallet != &v1, 3);
        let v2 = v0.sales;
        let v3 = arg0.total_distribution;
        let v4 = 0;
        let v5 = 0;
        let v6 = 0;
        let v7 = 0;
        let v8 = 0;
        while (v8 < arg2) {
            v8 = v8 + 1;
            let v9 = internal_calculate_price(v3 + v8);
            let v10 = internal_calculate_price(v3 + v8 + 1);
            if (v8 == arg2) {
                v6 = v9;
                v7 = v10;
            };
            let v11 = internal_calculate_cashback_amount(v9, internal_calculate_referral_cashback_rate(v2 + v8));
            v5 = v5 + v11;
            let v12 = v4 + v9;
            v4 = v12 - v11;
            let v13 = Price{
                id      : 0x2::object::new(arg4),
                current : v9,
                next    : v10,
            };
            let v14 = 0x2::tx_context::sender(arg4);
            internal_create_and_transfer_license(arg0, v13, v14, arg3, arg4);
        };
        arg0.price.current = v6;
        arg0.price.next = v7;
        let v15 = 0x2::object_table::borrow_mut<0x1::string::String, Referrer>(&mut arg0.referral_code_to_referrer, arg3);
        v15.sales = v15.sales + arg2;
        0x2::pay::split_and_transfer<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg1, v4, arg0.wallet, arg4);
        0x2::pay::split_and_transfer<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg1, v5, v15.wallet, arg4);
        arg0.sales = arg0.sales + arg2;
        arg0.total_distribution = arg0.total_distribution + arg2;
        arg0.balance = arg0.balance + v4;
        let v16 = ReferrerCashbackPaybackEvent{
            referee_id              : 0x2::object::id<Referee>(0x2::object_table::borrow<address, Referee>(&v15.referrals, 0x2::tx_context::sender(arg4))),
            referrer_id             : 0x2::object::id<Referrer>(v15),
            quantity                : arg2,
            treasury_payment_amount : v4,
            cashback_amount         : v5,
            code                    : v15.code,
        };
        0x2::event::emit<ReferrerCashbackPaybackEvent>(v16);
    }

    public entry fun pause_sales(arg0: &AdminPower, arg1: &mut Treasury, arg2: &AdminWhitelist, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) {
        assert_only_admin(arg2, 0x2::tx_context::sender(arg4));
        arg1.is_purchasing_paused = arg3;
    }

    public entry fun purchase_license(arg0: &mut Treasury, arg1: &mut 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg2: u64, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.is_purchasing_paused == false, 2);
        assert!(arg2 > 0, 5);
        let v0 = 0x2::tx_context::sender(arg4);
        internal_create_referrer(arg0, v0, arg4);
        internal_create_referee(arg0, arg3, arg4);
        internal_process_payment(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun revoke_admin_power(arg0: &MasterPower, arg1: &mut AdminWhitelist, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        if (0x2::vec_set::contains<address>(&arg1.wallets, &arg2)) {
            0x2::vec_set::remove<address>(&mut arg1.wallets, &arg2);
        };
    }

    // decompiled from Move bytecode v6
}

