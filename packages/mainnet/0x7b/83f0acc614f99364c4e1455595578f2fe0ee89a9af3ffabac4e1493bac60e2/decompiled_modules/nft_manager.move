module 0xe64012786406e76306b3a56841772673a6ee9a9f69c70e431d1f051e39681b1e::nft_manager {
    struct AdminCapability has store, key {
        id: 0x2::object::UID,
    }

    struct Tier has store, key {
        id: 0x2::object::UID,
        tier_thresholds: 0x2::table::Table<u8, u128>,
        tier_token_uris: 0x2::table::Table<u8, vector<u8>>,
    }

    struct Presale has key {
        id: 0x2::object::UID,
        open: bool,
        raised_amount_sui: 0x2::balance::Balance<0x2::sui::SUI>,
        raised_amount_usdc: 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>,
        total_raised_amount_usd: u128,
        referrals: 0x2::table::Table<address, u64>,
    }

    struct Receipt has store, key {
        id: 0x2::object::UID,
        token_uri: vector<u8>,
    }

    struct ReceiptHolderRegistry has store, key {
        id: 0x2::object::UID,
        holders: 0x2::table::Table<address, vector<0x2::object::ID>>,
    }

    struct InvestmentRecord has store, key {
        id: 0x2::object::UID,
        amount_invested: 0x2::table::Table<0x2::object::ID, u128>,
    }

    public fun transfer(arg0: &mut ReceiptHolderRegistry, arg1: Receipt, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::borrow_id<Receipt>(&arg1);
        remove_from_registry(arg0, 0x2::tx_context::sender(arg3), v0);
        add_to_registry(arg0, arg2, v0);
        0x2::transfer::public_transfer<Receipt>(arg1, arg2);
    }

    fun add_to_registry(arg0: &mut ReceiptHolderRegistry, arg1: address, arg2: &0x2::object::ID) {
        if (!0x2::table::contains<address, vector<0x2::object::ID>>(&arg0.holders, arg1)) {
            let v0 = 0x1::vector::empty<0x2::object::ID>();
            0x1::vector::push_back<0x2::object::ID>(&mut v0, *arg2);
            0x2::table::add<address, vector<0x2::object::ID>>(&mut arg0.holders, arg1, v0);
        } else {
            0x1::vector::push_back<0x2::object::ID>(0x2::table::borrow_mut<address, vector<0x2::object::ID>>(&mut arg0.holders, arg1), *arg2);
        };
    }

    public fun burn(arg0: &mut ReceiptHolderRegistry, arg1: Receipt, arg2: &mut 0x2::tx_context::TxContext) {
        let Receipt {
            id        : v0,
            token_uri : _,
        } = arg1;
        let v2 = v0;
        remove_from_registry(arg0, 0x2::tx_context::sender(arg2), 0x2::object::uid_as_inner(&v2));
        0x2::object::delete(v2);
    }

    fun determine_token_uri(arg0: &Tier, arg1: u128) : vector<u8> {
        let v0 = 5;
        while (v0 > 0) {
            if (arg1 >= *0x2::table::borrow<u8, u128>(&arg0.tier_thresholds, v0)) {
                break
            };
            v0 = v0 - 1;
        };
        *0x2::table::borrow<u8, vector<u8>>(&arg0.tier_token_uris, v0)
    }

    public entry fun end_presale(arg0: &AdminCapability, arg1: &mut Presale) {
        arg1.open = false;
    }

    public fun get_amount_invested(arg0: &InvestmentRecord, arg1: 0x2::object::ID) : u128 {
        *0x2::table::borrow<0x2::object::ID, u128>(&arg0.amount_invested, arg1)
    }

    public fun get_holding_receipts(arg0: &ReceiptHolderRegistry, arg1: address) : vector<0x2::object::ID> {
        *0x2::table::borrow<address, vector<0x2::object::ID>>(&arg0.holders, arg1)
    }

    public fun get_raised_amount_sui(arg0: &Presale) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.raised_amount_sui)
    }

    public fun get_raised_amount_usdc(arg0: &Presale) : u64 {
        0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg0.raised_amount_usdc)
    }

    public fun get_referral_count(arg0: &Presale, arg1: address) : u64 {
        *0x2::table::borrow<address, u64>(&arg0.referrals, arg1)
    }

    public fun get_total_raised_amount_usd(arg0: &Presale) : u128 {
        arg0.total_raised_amount_usd
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = init_tier(arg0);
        let v1 = Presale{
            id                      : 0x2::object::new(arg0),
            open                    : true,
            raised_amount_sui       : 0x2::balance::zero<0x2::sui::SUI>(),
            raised_amount_usdc      : 0x2::balance::zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(),
            total_raised_amount_usd : 0,
            referrals               : 0x2::table::new<address, u64>(arg0),
        };
        0x2::transfer::share_object<Presale>(v1);
        0x2::transfer::freeze_object<Tier>(v0);
        let v2 = ReceiptHolderRegistry{
            id      : 0x2::object::new(arg0),
            holders : 0x2::table::new<address, vector<0x2::object::ID>>(arg0),
        };
        let v3 = InvestmentRecord{
            id              : 0x2::object::new(arg0),
            amount_invested : 0x2::table::new<0x2::object::ID, u128>(arg0),
        };
        0x2::transfer::share_object<ReceiptHolderRegistry>(v2);
        0x2::transfer::share_object<InvestmentRecord>(v3);
        let v4 = AdminCapability{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCapability>(v4, 0x2::tx_context::sender(arg0));
    }

    fun init_tier(arg0: &mut 0x2::tx_context::TxContext) : Tier {
        let v0 = Tier{
            id              : 0x2::object::new(arg0),
            tier_thresholds : 0x2::table::new<u8, u128>(arg0),
            tier_token_uris : 0x2::table::new<u8, vector<u8>>(arg0),
        };
        0x2::table::add<u8, u128>(&mut v0.tier_thresholds, 1, 1);
        0x2::table::add<u8, u128>(&mut v0.tier_thresholds, 2, 100);
        0x2::table::add<u8, u128>(&mut v0.tier_thresholds, 3, 1000);
        0x2::table::add<u8, u128>(&mut v0.tier_thresholds, 4, 5000);
        0x2::table::add<u8, u128>(&mut v0.tier_thresholds, 5, 10000);
        0x2::table::add<u8, vector<u8>>(&mut v0.tier_token_uris, 1, b"https://example.com/uri1");
        0x2::table::add<u8, vector<u8>>(&mut v0.tier_token_uris, 2, b"https://example.com/uri2");
        0x2::table::add<u8, vector<u8>>(&mut v0.tier_token_uris, 3, b"https://example.com/uri3");
        0x2::table::add<u8, vector<u8>>(&mut v0.tier_token_uris, 4, b"https://example.com/uri4");
        0x2::table::add<u8, vector<u8>>(&mut v0.tier_token_uris, 5, b"https://example.com/uri5");
        v0
    }

    public entry fun mint_by_admin(arg0: &AdminCapability, arg1: &mut ReceiptHolderRegistry, arg2: &mut InvestmentRecord, arg3: &Tier, arg4: u64, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        mint_to(arg1, arg2, arg3, (arg4 as u128) * 1000, arg5, arg6);
    }

    fun mint_to(arg0: &mut ReceiptHolderRegistry, arg1: &mut InvestmentRecord, arg2: &Tier, arg3: u128, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg5);
        let v1 = 0x2::object::uid_as_inner(&v0);
        add_to_registry(arg0, arg4, v1);
        0x2::table::add<0x2::object::ID, u128>(&mut arg1.amount_invested, *v1, arg3);
        let v2 = Receipt{
            id        : v0,
            token_uri : determine_token_uri(arg2, arg3),
        };
        0x2::transfer::public_transfer<Receipt>(v2, arg4);
    }

    public entry fun mint_with_sui(arg0: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg1: &mut Presale, arg2: &mut ReceiptHolderRegistry, arg3: &mut InvestmentRecord, arg4: &Tier, arg5: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg6: u64, arg7: 0x1::option::Option<address>, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg6 > 0, 0);
        assert!(arg1.open, 0);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.raised_amount_sui, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(arg5, arg6, arg8)));
        let (v0, _, _, _) = 0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::get_price(arg0, 371);
        update_presale_and_mint(arg1, arg2, arg3, arg4, arg7, (arg6 as u128) * v0 / 1000000000 / 1000000000, arg8);
    }

    public entry fun mint_with_usdc(arg0: &mut Presale, arg1: &mut ReceiptHolderRegistry, arg2: &mut InvestmentRecord, arg3: &Tier, arg4: &mut 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg5: u64, arg6: 0x1::option::Option<address>, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg5 > 0, 0);
        assert!(arg0.open, 0);
        0x2::balance::join<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.raised_amount_usdc, 0x2::coin::into_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x2::coin::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg4, arg5, arg7)));
        update_presale_and_mint(arg0, arg1, arg2, arg3, arg6, (arg5 as u128) * 1000, arg7);
    }

    fun remove_from_registry(arg0: &mut ReceiptHolderRegistry, arg1: address, arg2: &0x2::object::ID) {
        assert!(0x2::table::contains<address, vector<0x2::object::ID>>(&arg0.holders, arg1), 0);
        let v0 = 0x2::table::borrow_mut<address, vector<0x2::object::ID>>(&mut arg0.holders, arg1);
        let (v1, v2) = 0x1::vector::index_of<0x2::object::ID>(v0, arg2);
        assert!(v1, 0);
        0x1::vector::remove<0x2::object::ID>(v0, v2);
    }

    public entry fun transfer_admin_cap(arg0: AdminCapability, arg1: address) {
        0x2::transfer::transfer<AdminCapability>(arg0, arg1);
    }

    fun update_presale_and_mint(arg0: &mut Presale, arg1: &mut ReceiptHolderRegistry, arg2: &mut InvestmentRecord, arg3: &Tier, arg4: 0x1::option::Option<address>, arg5: u128, arg6: &mut 0x2::tx_context::TxContext) {
        arg0.total_raised_amount_usd = arg0.total_raised_amount_usd + arg5;
        if (arg0.total_raised_amount_usd >= (60000 as u128) * 1000000000) {
            arg0.open = false;
        };
        if (0x1::option::is_some<address>(&arg4)) {
            let v0 = *0x1::option::borrow<address>(&arg4);
            if (!0x2::table::contains<address, u64>(&arg0.referrals, v0)) {
                0x2::table::add<address, u64>(&mut arg0.referrals, v0, 1);
            } else {
                0x2::table::add<address, u64>(&mut arg0.referrals, v0, *0x2::table::borrow<address, u64>(&arg0.referrals, v0) + 1);
            };
        };
        let v1 = 0x2::tx_context::sender(arg6);
        mint_to(arg1, arg2, arg3, arg5, v1, arg6);
    }

    public entry fun withdraw_funds(arg0: &AdminCapability, arg1: &mut Presale, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg1.raised_amount_sui);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg1.raised_amount_sui, v0, arg2), 0x2::tx_context::sender(arg2));
        };
        let v1 = 0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg1.raised_amount_usdc);
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(0x2::coin::take<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg1.raised_amount_usdc, v1, arg2), 0x2::tx_context::sender(arg2));
        };
    }

    // decompiled from Move bytecode v6
}

