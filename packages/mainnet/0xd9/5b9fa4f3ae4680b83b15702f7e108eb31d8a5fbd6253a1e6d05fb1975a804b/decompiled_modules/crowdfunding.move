module 0xd95b9fa4f3ae4680b83b15702f7e108eb31d8a5fbd6253a1e6d05fb1975a804b::crowdfunding {
    struct Project has store, key {
        id: 0x2::object::UID,
        title: 0x1::string::String,
        tagline: 0x1::string::String,
        description: 0x1::string::String,
        category: 0x1::string::String,
        goal: u64,
        blob_id: 0x1::string::String,
        creator: address,
        token_id: u64,
        status: 0x1::string::String,
        raised_amount: u64,
        currency_type: 0x1::string::String,
        created_at: u64,
        funding_deadline: u64,
        sui_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        usdc_balance: 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>,
        has_pending_withdrawal: bool,
    }

    struct Platform has key {
        id: 0x2::object::UID,
        admin: address,
        multi_sig_admins: vector<address>,
        fee_wallet_address: address,
        fee_wallet_email: 0x1::string::String,
        fee_percentage: u64,
        total_fees_collected: u64,
        project_counter: u64,
        share_rules: ShareRules,
    }

    struct AdminProposal has key {
        id: 0x2::object::UID,
        action_type: 0x1::string::String,
        target_id: address,
        new_value: 0x1::string::String,
        approvals: vector<address>,
        required_votes: u64,
        is_executed: bool,
    }

    struct ShareRules has drop, store {
        min_percentage: u64,
        max_percentage: u64,
        description: 0x1::string::String,
    }

    struct InvestmentReceipt has key {
        id: 0x2::object::UID,
        investor: address,
        project_id: address,
        project_title: 0x1::string::String,
        image_url: 0x1::string::String,
        amount: u64,
        currency_type: 0x1::string::String,
        investment_date: u64,
        share_percentage: u64,
        fee_paid: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct ProjectCreated has copy, drop {
        project_id: address,
        creator: address,
        title: 0x1::string::String,
        goal: u64,
        currency_type: 0x1::string::String,
    }

    struct ProjectFunded has copy, drop {
        project_id: address,
        investor: address,
        amount: u64,
        currency_type: 0x1::string::String,
        total_raised: u64,
    }

    struct ProjectStatusChanged has copy, drop {
        project_id: address,
        old_status: 0x1::string::String,
        new_status: 0x1::string::String,
        changed_by: address,
    }

    struct ReceiptMinted has copy, drop {
        receipt_id: address,
        investor: address,
        project_id: address,
        project_title: 0x1::string::String,
        image_url: 0x1::string::String,
        amount: u64,
        share_percentage: u64,
        fee_paid: u64,
    }

    struct ReceiptBurned has copy, drop {
        receipt_id: address,
        investor: address,
        project_id: address,
    }

    struct ProjectDeleted has copy, drop {
        project_id: address,
        deleted_by: address,
        reason: 0x1::string::String,
    }

    struct DonationReceived has copy, drop {
        donor: address,
        amount: u64,
        message: 0x1::string::String,
    }

    struct MultiSigAdminAdded has copy, drop {
        admin_address: address,
        added_by: address,
    }

    struct MultiSigAdminRemoved has copy, drop {
        admin_address: address,
        removed_by: address,
    }

    struct InvestorRefunded has copy, drop {
        investor: address,
        project_id: address,
        amount: u64,
        currency_type: 0x1::string::String,
    }

    struct PlatformFeeUpdated has copy, drop {
        old_fee: u64,
        new_fee: u64,
        updated_by: address,
    }

    entry fun add_multisig_admin(arg0: &AdminCap, arg1: &mut Platform, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg1.admin, 0);
        0x1::vector::push_back<address>(&mut arg1.multi_sig_admins, arg2);
        let v0 = MultiSigAdminAdded{
            admin_address : arg2,
            added_by      : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<MultiSigAdminAdded>(v0);
    }

    entry fun admin_delete_project(arg0: &AdminCap, arg1: Project, arg2: &Platform, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg2.admin, 0);
        let v0 = if (arg1.status == 0x1::string::utf8(b"hidden")) {
            true
        } else if (arg1.status == 0x1::string::utf8(b"pending")) {
            true
        } else if (arg1.status == 0x1::string::utf8(b"rejected")) {
            true
        } else {
            arg1.status == 0x1::string::utf8(b"approved")
        };
        assert!(v0, 9);
        let Project {
            id                     : v1,
            title                  : _,
            tagline                : _,
            description            : _,
            category               : _,
            goal                   : _,
            blob_id                : _,
            creator                : v8,
            token_id               : _,
            status                 : _,
            raised_amount          : _,
            currency_type          : _,
            created_at             : _,
            funding_deadline       : _,
            sui_balance            : v15,
            usdc_balance           : v16,
            has_pending_withdrawal : _,
        } = arg1;
        if (0x2::balance::value<0x2::sui::SUI>(&arg1.sui_balance) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v15, arg4), v8);
        } else {
            0x2::balance::destroy_zero<0x2::sui::SUI>(v15);
        };
        if (0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg1.usdc_balance) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(0x2::coin::from_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v16, arg4), v8);
        } else {
            0x2::balance::destroy_zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v16);
        };
        0x2::object::delete(v1);
        let v18 = ProjectDeleted{
            project_id : 0x2::object::uid_to_address(&arg1.id),
            deleted_by : 0x2::tx_context::sender(arg4),
            reason     : arg3,
        };
        0x2::event::emit<ProjectDeleted>(v18);
    }

    entry fun approve_withdrawal_proposal(arg0: &Platform, arg1: &mut AdminProposal, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x1::vector::contains<address>(&arg0.multi_sig_admins, &v0), 0);
        assert!(!0x1::vector::contains<address>(&arg1.approvals, &v0), 14);
        assert!(!arg1.is_executed, 9);
        0x1::vector::push_back<address>(&mut arg1.approvals, v0);
    }

    entry fun burn_receipt(arg0: InvestmentReceipt, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.investor, 13);
        let InvestmentReceipt {
            id               : v0,
            investor         : _,
            project_id       : _,
            project_title    : _,
            image_url        : _,
            amount           : _,
            currency_type    : _,
            investment_date  : _,
            share_percentage : _,
            fee_paid         : _,
        } = arg0;
        0x2::object::delete(v0);
        let v10 = ReceiptBurned{
            receipt_id : 0x2::object::uid_to_address(&arg0.id),
            investor   : arg0.investor,
            project_id : arg0.project_id,
        };
        0x2::event::emit<ReceiptBurned>(v10);
    }

    fun calculate_share_percentage(arg0: u64, arg1: u64, arg2: &ShareRules) : u64 {
        let v0 = arg0 * 10000 / arg1;
        if (v0 < arg2.min_percentage) {
            arg2.min_percentage
        } else if (v0 > arg2.max_percentage) {
            arg2.max_percentage
        } else {
            v0
        }
    }

    fun calculate_supermajority(arg0: &Platform) : u64 {
        let v0 = 0x1::vector::length<address>(&arg0.multi_sig_admins);
        if (v0 <= 2) {
            return v0
        };
        (2 * v0 + 2) / 3
    }

    entry fun create_project(arg0: &mut Platform, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: u64, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: u64, arg9: bool, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(arg7 == 0x1::string::utf8(b"SUI") || arg7 == 0x1::string::utf8(b"USDC"), 10);
        arg0.project_counter = arg0.project_counter + 1;
        let v0 = if (arg9) {
            0x1::string::utf8(b"pending")
        } else {
            0x1::string::utf8(b"hidden")
        };
        let v1 = Project{
            id                     : 0x2::object::new(arg11),
            title                  : arg1,
            tagline                : arg2,
            description            : arg3,
            category               : arg4,
            goal                   : arg5,
            blob_id                : arg6,
            creator                : 0x2::tx_context::sender(arg11),
            token_id               : arg0.project_counter,
            status                 : v0,
            raised_amount          : 0,
            currency_type          : arg7,
            created_at             : 0x2::clock::timestamp_ms(arg10),
            funding_deadline       : arg8,
            sui_balance            : 0x2::balance::zero<0x2::sui::SUI>(),
            usdc_balance           : 0x2::balance::zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(),
            has_pending_withdrawal : false,
        };
        let v2 = ProjectCreated{
            project_id    : 0x2::object::uid_to_address(&v1.id),
            creator       : 0x2::tx_context::sender(arg11),
            title         : v1.title,
            goal          : arg5,
            currency_type : v1.currency_type,
        };
        0x2::event::emit<ProjectCreated>(v2);
        0x2::transfer::share_object<Project>(v1);
    }

    entry fun delete_project(arg0: Project, arg1: &Platform, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg1.admin || v0 == arg0.creator, 13);
        assert!(arg0.raised_amount == 0, 12);
        let v1 = if (arg0.status == 0x1::string::utf8(b"hidden")) {
            true
        } else if (arg0.status == 0x1::string::utf8(b"pending")) {
            true
        } else {
            arg0.status == 0x1::string::utf8(b"rejected")
        };
        assert!(v1, 9);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance) == 0, 11);
        assert!(0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg0.usdc_balance) == 0, 11);
        let Project {
            id                     : v2,
            title                  : _,
            tagline                : _,
            description            : _,
            category               : _,
            goal                   : _,
            blob_id                : _,
            creator                : _,
            token_id               : _,
            status                 : _,
            raised_amount          : _,
            currency_type          : _,
            created_at             : _,
            funding_deadline       : _,
            sui_balance            : v16,
            usdc_balance           : v17,
            has_pending_withdrawal : _,
        } = arg0;
        0x2::balance::destroy_zero<0x2::sui::SUI>(v16);
        0x2::balance::destroy_zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v17);
        0x2::object::delete(v2);
        let v19 = ProjectDeleted{
            project_id : 0x2::object::uid_to_address(&arg0.id),
            deleted_by : v0,
            reason     : 0x1::string::utf8(b"Project deleted by authorized user"),
        };
        0x2::event::emit<ProjectDeleted>(v19);
    }

    entry fun donate_to_platform(arg0: &mut Platform, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 > 0, 4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, arg0.fee_wallet_address);
        arg0.total_fees_collected = arg0.total_fees_collected + v0;
        let v1 = DonationReceived{
            donor   : 0x2::tx_context::sender(arg3),
            amount  : v0,
            message : arg2,
        };
        0x2::event::emit<DonationReceived>(v1);
    }

    entry fun edit_project(arg0: &mut Project, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: u64, arg6: 0x1::string::String, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg8) == arg0.creator, 7);
        assert!(arg0.raised_amount == 0, 12);
        let v0 = if (arg0.status == 0x1::string::utf8(b"hidden")) {
            true
        } else if (arg0.status == 0x1::string::utf8(b"pending")) {
            true
        } else {
            arg0.status == 0x1::string::utf8(b"rejected")
        };
        assert!(v0, 9);
        arg0.title = arg1;
        arg0.tagline = arg2;
        arg0.description = arg3;
        arg0.category = arg4;
        arg0.goal = arg5;
        arg0.blob_id = arg6;
        arg0.funding_deadline = arg7;
    }

    entry fun execute_withdrawal(arg0: &mut AdminProposal, arg1: &mut Project, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.action_type == 0x1::string::utf8(b"WITHDRAW_FUNDS"), 13);
        assert!(arg0.target_id == 0x2::object::uid_to_address(&arg1.id), 17);
        assert!(0x1::vector::length<address>(&arg0.approvals) >= arg0.required_votes, 15);
        assert!(!arg0.is_executed, 9);
        assert!(0x2::tx_context::sender(arg2) == arg1.creator, 7);
        assert!(arg1.status == 0x1::string::utf8(b"funded"), 8);
        let v0 = arg1.currency_type;
        if (v0 == 0x1::string::utf8(b"SUI")) {
            assert!(0x2::balance::value<0x2::sui::SUI>(&arg1.sui_balance) > 0, 4);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg1.sui_balance), arg2), arg1.creator);
        } else {
            assert!(v0 == 0x1::string::utf8(b"USDC"), 10);
            assert!(0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg1.usdc_balance) > 0, 4);
            0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(0x2::coin::from_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x2::balance::withdraw_all<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg1.usdc_balance), arg2), arg1.creator);
        };
        arg1.raised_amount = 0;
        arg1.has_pending_withdrawal = false;
        arg1.status = 0x1::string::utf8(b"completed");
        arg0.is_executed = true;
        let v1 = ProjectStatusChanged{
            project_id : 0x2::object::uid_to_address(&arg1.id),
            old_status : arg1.status,
            new_status : arg1.status,
            changed_by : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<ProjectStatusChanged>(v1);
    }

    fun finalize_investment(arg0: &mut Project, arg1: &Platform, arg2: u64, arg3: u64, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        arg0.raised_amount = arg0.raised_amount + arg2;
        let v0 = calculate_share_percentage(arg2, arg0.goal, &arg1.share_rules);
        let v1 = InvestmentReceipt{
            id               : 0x2::object::new(arg7),
            investor         : 0x2::tx_context::sender(arg7),
            project_id       : 0x2::object::uid_to_address(&arg0.id),
            project_title    : arg0.title,
            image_url        : arg5,
            amount           : arg2,
            currency_type    : arg4,
            investment_date  : 0x2::clock::timestamp_ms(arg6),
            share_percentage : v0,
            fee_paid         : arg3,
        };
        let v2 = ReceiptMinted{
            receipt_id       : 0x2::object::uid_to_address(&v1.id),
            investor         : 0x2::tx_context::sender(arg7),
            project_id       : 0x2::object::uid_to_address(&arg0.id),
            project_title    : arg0.title,
            image_url        : v1.image_url,
            amount           : arg2,
            share_percentage : v0,
            fee_paid         : arg3,
        };
        0x2::event::emit<ReceiptMinted>(v2);
        if (arg0.raised_amount >= arg0.goal) {
            arg0.status = 0x1::string::utf8(b"funded");
        };
        0x2::transfer::transfer<InvestmentReceipt>(v1, 0x2::tx_context::sender(arg7));
        let v3 = ProjectFunded{
            project_id    : 0x2::object::uid_to_address(&arg0.id),
            investor      : 0x2::tx_context::sender(arg7),
            amount        : arg2,
            currency_type : arg4,
            total_raised  : arg0.raised_amount,
        };
        0x2::event::emit<ProjectFunded>(v3);
    }

    entry fun fund_project_sui(arg0: &mut Project, arg1: &mut Platform, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: 0x1::string::String, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status != 0x1::string::utf8(b"funded"), 5);
        let (v0, v1) = validate_contribution<0x2::sui::SUI>(arg0, arg1, &arg2, &arg3, 0x1::string::utf8(b"SUI"), arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, arg1.fee_wallet_address);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
        finalize_investment(arg0, arg1, v0, v1, 0x1::string::utf8(b"SUI"), arg4, arg5, arg6);
    }

    entry fun fund_project_usdc(arg0: &mut Project, arg1: &mut Platform, arg2: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg3: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg4: 0x1::string::String, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status != 0x1::string::utf8(b"funded"), 5);
        let (v0, v1) = validate_contribution<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg0, arg1, &arg2, &arg3, 0x1::string::utf8(b"USDC"), arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(arg3, arg1.fee_wallet_address);
        0x2::balance::join<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.usdc_balance, 0x2::coin::into_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2));
        finalize_investment(arg0, arg1, v0, v1, 0x1::string::utf8(b"USDC"), arg4, arg5, arg6);
    }

    public fun get_platform_fee(arg0: &Platform) : u64 {
        arg0.fee_percentage
    }

    public fun get_platform_info(arg0: &Platform) : (address, u64, u64, u64, u64) {
        (arg0.admin, arg0.total_fees_collected, arg0.project_counter, 0x1::vector::length<address>(&arg0.multi_sig_admins), arg0.fee_percentage)
    }

    public fun get_project_info(arg0: &Project) : (0x1::string::String, 0x1::string::String, 0x1::string::String, u64, u64, 0x1::string::String, address) {
        (arg0.title, arg0.description, arg0.status, arg0.goal, arg0.raised_amount, arg0.currency_type, arg0.creator)
    }

    public fun get_receipt_info(arg0: &InvestmentReceipt) : (address, address, 0x1::string::String, 0x1::string::String, u64, 0x1::string::String, u64, u64) {
        (arg0.investor, arg0.project_id, arg0.project_title, arg0.image_url, arg0.amount, arg0.currency_type, arg0.share_percentage, arg0.fee_paid)
    }

    public fun get_share_rules(arg0: &Platform) : (u64, u64, 0x1::string::String) {
        (arg0.share_rules.min_percentage, arg0.share_rules.max_percentage, arg0.share_rules.description)
    }

    public fun has_pending_withdrawal(arg0: &Project) : bool {
        arg0.has_pending_withdrawal
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = @0x42124c7cb849d74d15905723ca1a258371a9dfba54ab3eb1d2da31e993dad94d;
        let v1 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v1, v0);
        let v2 = ShareRules{
            min_percentage : 500,
            max_percentage : 1500,
            description    : 0x1::string::utf8(b"Default rules"),
        };
        let v3 = Platform{
            id                   : 0x2::object::new(arg0),
            admin                : v0,
            multi_sig_admins     : v1,
            fee_wallet_address   : v0,
            fee_wallet_email     : 0x1::string::utf8(b"admin@blkfndr.com"),
            fee_percentage       : 300,
            total_fees_collected : 0,
            project_counter      : 0,
            share_rules          : v2,
        };
        let v4 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v4, v0);
        0x2::transfer::share_object<Platform>(v3);
    }

    public fun is_project_approved(arg0: &Project) : bool {
        arg0.status == 0x1::string::utf8(b"approved")
    }

    entry fun mark_project_expired(arg0: &mut Project, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 0x1::string::utf8(b"approved"), 9);
        assert!(0x2::clock::timestamp_ms(arg1) > arg0.funding_deadline, 9);
        assert!(arg0.raised_amount < arg0.goal, 5);
        arg0.status = 0x1::string::utf8(b"expired");
        let v0 = ProjectStatusChanged{
            project_id : 0x2::object::uid_to_address(&arg0.id),
            old_status : arg0.status,
            new_status : arg0.status,
            changed_by : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<ProjectStatusChanged>(v0);
    }

    entry fun propose_withdrawal(arg0: &mut Project, arg1: &Platform, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.creator, 7);
        assert!(arg0.status == 0x1::string::utf8(b"funded"), 8);
        assert!(!arg0.has_pending_withdrawal, 19);
        arg0.has_pending_withdrawal = true;
        let v0 = AdminProposal{
            id             : 0x2::object::new(arg2),
            action_type    : 0x1::string::utf8(b"WITHDRAW_FUNDS"),
            target_id      : 0x2::object::uid_to_address(&arg0.id),
            new_value      : 0x1::string::utf8(b""),
            approvals      : 0x1::vector::empty<address>(),
            required_votes : calculate_supermajority(arg1),
            is_executed    : false,
        };
        0x2::transfer::share_object<AdminProposal>(v0);
    }

    entry fun refund_investor_sui(arg0: InvestmentReceipt, arg1: &mut Project, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.status == 0x1::string::utf8(b"expired"), 9);
        assert!(arg0.currency_type == 0x1::string::utf8(b"SUI"), 10);
        assert!(arg0.project_id == 0x2::object::uid_to_address(&arg1.id), 17);
        assert!(0x2::tx_context::sender(arg2) == arg0.investor, 13);
        let v0 = arg0.amount;
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg1.sui_balance) >= v0, 18);
        let v1 = arg0.investor;
        let v2 = arg0.project_id;
        let InvestmentReceipt {
            id               : v3,
            investor         : _,
            project_id       : _,
            project_title    : _,
            image_url        : _,
            amount           : _,
            currency_type    : _,
            investment_date  : _,
            share_percentage : _,
            fee_paid         : _,
        } = arg0;
        0x2::object::delete(v3);
        arg1.raised_amount = arg1.raised_amount - v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.sui_balance, v0), arg2), v1);
        let v13 = InvestorRefunded{
            investor      : v1,
            project_id    : v2,
            amount        : v0,
            currency_type : 0x1::string::utf8(b"SUI"),
        };
        0x2::event::emit<InvestorRefunded>(v13);
        let v14 = ReceiptBurned{
            receipt_id : 0x2::object::uid_to_address(&arg0.id),
            investor   : v1,
            project_id : v2,
        };
        0x2::event::emit<ReceiptBurned>(v14);
    }

    entry fun refund_investor_usdc(arg0: InvestmentReceipt, arg1: &mut Project, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.status == 0x1::string::utf8(b"expired"), 9);
        assert!(arg0.currency_type == 0x1::string::utf8(b"USDC"), 10);
        assert!(arg0.project_id == 0x2::object::uid_to_address(&arg1.id), 17);
        assert!(0x2::tx_context::sender(arg2) == arg0.investor, 13);
        let v0 = arg0.amount;
        assert!(0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg1.usdc_balance) >= v0, 18);
        let v1 = arg0.investor;
        let v2 = arg0.project_id;
        let InvestmentReceipt {
            id               : v3,
            investor         : _,
            project_id       : _,
            project_title    : _,
            image_url        : _,
            amount           : _,
            currency_type    : _,
            investment_date  : _,
            share_percentage : _,
            fee_paid         : _,
        } = arg0;
        0x2::object::delete(v3);
        arg1.raised_amount = arg1.raised_amount - v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(0x2::coin::from_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x2::balance::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg1.usdc_balance, v0), arg2), v1);
        let v13 = InvestorRefunded{
            investor      : v1,
            project_id    : v2,
            amount        : v0,
            currency_type : 0x1::string::utf8(b"USDC"),
        };
        0x2::event::emit<InvestorRefunded>(v13);
        let v14 = ReceiptBurned{
            receipt_id : 0x2::object::uid_to_address(&arg0.id),
            investor   : v1,
            project_id : v2,
        };
        0x2::event::emit<ReceiptBurned>(v14);
    }

    entry fun remove_multisig_admin(arg0: &AdminCap, arg1: &mut Platform, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg1.admin, 0);
        let (v0, v1) = 0x1::vector::index_of<address>(&arg1.multi_sig_admins, &arg2);
        assert!(v0, 1);
        0x1::vector::remove<address>(&mut arg1.multi_sig_admins, v1);
        let v2 = MultiSigAdminRemoved{
            admin_address : arg2,
            removed_by    : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<MultiSigAdminRemoved>(v2);
    }

    entry fun set_fee_wallet(arg0: &AdminCap, arg1: &mut Platform, arg2: address, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg1.admin, 0);
        arg1.fee_wallet_address = arg2;
        arg1.fee_wallet_email = arg3;
    }

    entry fun submit_project_for_review(arg0: &mut Project, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.creator, 7);
        assert!(arg0.status == 0x1::string::utf8(b"hidden") || arg0.status == 0x1::string::utf8(b"rejected"), 9);
        assert!(arg0.raised_amount == 0, 12);
        arg0.status = 0x1::string::utf8(b"pending");
        let v0 = ProjectStatusChanged{
            project_id : 0x2::object::uid_to_address(&arg0.id),
            old_status : arg0.status,
            new_status : arg0.status,
            changed_by : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<ProjectStatusChanged>(v0);
    }

    entry fun update_platform_fee(arg0: &AdminCap, arg1: &mut Platform, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg1.admin, 0);
        assert!(arg2 <= 10000, 21);
        arg1.fee_percentage = arg2;
        let v0 = PlatformFeeUpdated{
            old_fee    : arg1.fee_percentage,
            new_fee    : arg2,
            updated_by : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<PlatformFeeUpdated>(v0);
    }

    entry fun update_project_status(arg0: &AdminCap, arg1: &mut Project, arg2: &Platform, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg2.admin, 0);
        let v0 = if (arg3 == 0x1::string::utf8(b"hidden")) {
            true
        } else if (arg3 == 0x1::string::utf8(b"pending")) {
            true
        } else if (arg3 == 0x1::string::utf8(b"rejected")) {
            true
        } else if (arg3 == 0x1::string::utf8(b"approved")) {
            true
        } else if (arg3 == 0x1::string::utf8(b"funded")) {
            true
        } else if (arg3 == 0x1::string::utf8(b"completed")) {
            true
        } else {
            arg3 == 0x1::string::utf8(b"expired")
        };
        assert!(v0, 9);
        arg1.status = arg3;
        let v1 = ProjectStatusChanged{
            project_id : 0x2::object::uid_to_address(&arg1.id),
            old_status : arg1.status,
            new_status : arg1.status,
            changed_by : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<ProjectStatusChanged>(v1);
    }

    entry fun update_share_rules(arg0: &AdminCap, arg1: &mut Platform, arg2: u64, arg3: u64, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg5) == arg1.admin, 0);
        assert!(arg2 <= arg3, 6);
        assert!(arg3 <= 2000, 6);
        let v0 = ShareRules{
            min_percentage : arg2,
            max_percentage : arg3,
            description    : arg4,
        };
        arg1.share_rules = v0;
    }

    fun validate_contribution<T0>(arg0: &Project, arg1: &mut Platform, arg2: &0x2::coin::Coin<T0>, arg3: &0x2::coin::Coin<T0>, arg4: 0x1::string::String, arg5: &0x2::clock::Clock) : (u64, u64) {
        assert!(arg0.currency_type == arg4, 10);
        assert!(arg0.status == 0x1::string::utf8(b"approved"), 3);
        assert!(0x2::clock::timestamp_ms(arg5) <= arg0.funding_deadline, 16);
        let v0 = 0x2::coin::value<T0>(arg2);
        assert!(v0 > 0, 4);
        let v1 = v0 * arg1.fee_percentage / 10000;
        assert!(0x2::coin::value<T0>(arg3) == v1, 20);
        arg1.total_fees_collected = arg1.total_fees_collected + 0x2::coin::value<T0>(arg3);
        (v0, v1)
    }

    entry fun withdraw_project_from_review(arg0: &mut Project, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.creator, 7);
        assert!(arg0.status == 0x1::string::utf8(b"pending"), 9);
        assert!(arg0.raised_amount == 0, 12);
        arg0.status = 0x1::string::utf8(b"hidden");
        let v0 = ProjectStatusChanged{
            project_id : 0x2::object::uid_to_address(&arg0.id),
            old_status : arg0.status,
            new_status : arg0.status,
            changed_by : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<ProjectStatusChanged>(v0);
    }

    // decompiled from Move bytecode v6
}

