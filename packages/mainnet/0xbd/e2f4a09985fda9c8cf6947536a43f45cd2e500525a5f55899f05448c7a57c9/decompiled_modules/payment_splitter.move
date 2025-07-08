module 0xbde2f4a09985fda9c8cf6947536a43f45cd2e500525a5f55899f05448c7a57c9::payment_splitter {
    struct CommitmentStatus has copy, drop, store {
        value: u8,
    }

    struct Commitment has copy, drop, store {
        commitment_id: u64,
        buyer: address,
        nft_quantity: u64,
        price_per_nft: u64,
        total_price: u64,
        deposit_paid: u64,
        remaining_amount: u64,
        sui_address: 0x1::string::String,
        commitment_time: u64,
        status: CommitmentStatus,
        inviter: address,
        token_type: u8,
    }

    struct UserCommitments has key {
        id: 0x2::object::UID,
        user: address,
        commitments: 0x2::table::Table<u64, Commitment>,
        commitment_count: u64,
    }

    struct InviterStats has key {
        id: 0x2::object::UID,
        inviter: address,
        commit_count: u64,
        purchase_count: u64,
        total_commit_value: u64,
        total_purchase_value: u64,
    }

    struct InviterStatsData has copy, drop, store {
        commit_count: u64,
        purchase_count: u64,
        total_commit_value: u64,
        total_purchase_value: u64,
    }

    struct PaymentSplitter has key {
        id: 0x2::object::UID,
        authority: address,
        project_owner: address,
        price_tiers: vector<u64>,
        inviter_percentage: u64,
        project_owner_percentage: u64,
        sender_refund_percentage: u64,
        commit_period: u64,
        purchase_period: u64,
        refund_period: u64,
        commit_start_time: u64,
        purchase_start_time: u64,
        refund_start_time: u64,
        total_commitments: u64,
        total_completed_purchases: u64,
        total_refunds: u64,
        total_inviter_payouts: u64,
        total_project_owner_payouts: u64,
        next_commitment_id: u64,
        inviter_stats: 0x2::table::Table<address, InviterStatsData>,
        paused: bool,
        usdt_balance: 0x2::balance::Balance<0x375f70cf2ae4c00bf37117d0c85a2c71545e6ee05c4a5c7d282cd66a4504b068::usdt::USDT>,
        usdc_balance: 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct PaymentSplitterInitialized has copy, drop {
        authority: address,
        project_owner: address,
    }

    struct CommitmentMade has copy, drop {
        buyer: address,
        commitment_id: u64,
        nft_quantity: u64,
        price_per_nft: u64,
        total_price: u64,
        deposit_paid: u64,
        sui_address: 0x1::string::String,
        inviter: address,
        token_type: u8,
    }

    struct PurchaseCompleted has copy, drop {
        buyer: address,
        commitment_id: u64,
        remaining_paid: u64,
        inviter_share: u64,
        project_owner_share: u64,
        timestamp: u64,
    }

    struct RefundProcessed has copy, drop {
        buyer: address,
        commitment_id: u64,
        refund_amount: u64,
        timestamp: u64,
    }

    struct ProjectOwnerUpdated has copy, drop {
        old_owner: address,
        new_owner: address,
    }

    struct PercentagesUpdated has copy, drop {
        authority: address,
        old_inviter_percentage: u64,
        old_project_owner_percentage: u64,
        old_sender_refund_percentage: u64,
        new_inviter_percentage: u64,
        new_project_owner_percentage: u64,
        new_sender_refund_percentage: u64,
    }

    struct PriceTierUpdated has copy, drop {
        authority: address,
        tier_index: u8,
        new_price: u64,
    }

    struct ContractPaused has copy, drop {
        paused: bool,
    }

    public fun add_commitment_to_user(arg0: &mut UserCommitments, arg1: Commitment) {
        0x2::table::add<u64, Commitment>(&mut arg0.commitments, arg1.commitment_id, arg1);
        arg0.commitment_count = arg0.commitment_count + 1;
    }

    public fun calculate_deposit(arg0: &PaymentSplitter, arg1: u64, arg2: u8) : u64 {
        assert!(arg2 < 4, 5);
        *0x1::vector::borrow<u64>(&arg0.price_tiers, (arg2 as u64)) * arg1 * 10 / 100
    }

    public fun calculate_split(arg0: &PaymentSplitter, arg1: u64) : (u64, u64, u64) {
        let v0 = arg1 * arg0.inviter_percentage / 100;
        let v1 = arg1 * arg0.sender_refund_percentage / 100;
        (v0, arg1 - v0 - v1, v1)
    }

    public entry fun commit_to_purchase(arg0: &mut PaymentSplitter, arg1: 0x2::coin::Coin<0x375f70cf2ae4c00bf37117d0c85a2c71545e6ee05c4a5c7d282cd66a4504b068::usdt::USDT>, arg2: u64, arg3: u8, arg4: vector<u8>, arg5: address, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 6);
        assert!(arg2 > 0, 7);
        assert!(arg3 < 4, 5);
        assert!(arg5 != @0x0, 1);
        assert!(!0x1::vector::is_empty<u8>(&arg4), 17);
        let v0 = 0x2::clock::timestamp_ms(arg6);
        assert!(v0 >= arg0.commit_start_time, 10);
        assert!(v0 <= arg0.commit_start_time + arg0.commit_period, 11);
        let v1 = 0x2::tx_context::sender(arg7);
        let v2 = *0x1::vector::borrow<u64>(&arg0.price_tiers, (arg3 as u64));
        let v3 = v2 * arg2;
        let v4 = v3 * 10 / 100;
        assert!(0x2::coin::value<0x375f70cf2ae4c00bf37117d0c85a2c71545e6ee05c4a5c7d282cd66a4504b068::usdt::USDT>(&arg1) >= v4, 3);
        0x2::balance::join<0x375f70cf2ae4c00bf37117d0c85a2c71545e6ee05c4a5c7d282cd66a4504b068::usdt::USDT>(&mut arg0.usdt_balance, 0x2::coin::into_balance<0x375f70cf2ae4c00bf37117d0c85a2c71545e6ee05c4a5c7d282cd66a4504b068::usdt::USDT>(arg1));
        let v5 = arg0.next_commitment_id;
        arg0.next_commitment_id = arg0.next_commitment_id + 1;
        let v6 = Commitment{
            commitment_id    : v5,
            buyer            : v1,
            nft_quantity     : arg2,
            price_per_nft    : v2,
            total_price      : v3,
            deposit_paid     : v4,
            remaining_amount : v3 - v4,
            sui_address      : 0x1::string::utf8(arg4),
            commitment_time  : v0,
            status           : new_commitment_status(0),
            inviter          : arg5,
            token_type       : 0,
        };
        let v7 = 0x2::table::new<u64, Commitment>(arg7);
        0x2::table::add<u64, Commitment>(&mut v7, v5, v6);
        let v8 = UserCommitments{
            id               : 0x2::object::new(arg7),
            user             : v1,
            commitments      : v7,
            commitment_count : 1,
        };
        0x2::transfer::share_object<UserCommitments>(v8);
        if (0x2::table::contains<address, InviterStatsData>(&arg0.inviter_stats, arg5)) {
            let v9 = 0x2::table::borrow_mut<address, InviterStatsData>(&mut arg0.inviter_stats, arg5);
            v9.commit_count = v9.commit_count + 1;
            v9.total_commit_value = v9.total_commit_value + v3;
        } else {
            let v10 = InviterStatsData{
                commit_count         : 1,
                purchase_count       : 0,
                total_commit_value   : v3,
                total_purchase_value : 0,
            };
            0x2::table::add<address, InviterStatsData>(&mut arg0.inviter_stats, arg5, v10);
        };
        arg0.total_commitments = arg0.total_commitments + v3;
        let v11 = CommitmentMade{
            buyer         : v1,
            commitment_id : v5,
            nft_quantity  : arg2,
            price_per_nft : v2,
            total_price   : v3,
            deposit_paid  : v4,
            sui_address   : 0x1::string::utf8(arg4),
            inviter       : arg5,
            token_type    : 0,
        };
        0x2::event::emit<CommitmentMade>(v11);
    }

    public entry fun commit_to_purchase_usdc(arg0: &mut PaymentSplitter, arg1: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg2: u64, arg3: u8, arg4: vector<u8>, arg5: address, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 6);
        assert!(arg2 > 0, 7);
        assert!(arg3 < 4, 5);
        assert!(arg5 != @0x0, 1);
        assert!(!0x1::vector::is_empty<u8>(&arg4), 17);
        let v0 = 0x2::clock::timestamp_ms(arg6);
        assert!(v0 >= arg0.commit_start_time, 10);
        assert!(v0 <= arg0.commit_start_time + arg0.commit_period, 11);
        let v1 = 0x2::tx_context::sender(arg7);
        let v2 = *0x1::vector::borrow<u64>(&arg0.price_tiers, (arg3 as u64));
        let v3 = v2 * arg2;
        let v4 = v3 * 10 / 100;
        assert!(0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg1) >= v4, 3);
        0x2::balance::join<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.usdc_balance, 0x2::coin::into_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg1));
        let v5 = arg0.next_commitment_id;
        arg0.next_commitment_id = arg0.next_commitment_id + 1;
        let v6 = Commitment{
            commitment_id    : v5,
            buyer            : v1,
            nft_quantity     : arg2,
            price_per_nft    : v2,
            total_price      : v3,
            deposit_paid     : v4,
            remaining_amount : v3 - v4,
            sui_address      : 0x1::string::utf8(arg4),
            commitment_time  : v0,
            status           : new_commitment_status(0),
            inviter          : arg5,
            token_type       : 1,
        };
        let v7 = 0x2::table::new<u64, Commitment>(arg7);
        0x2::table::add<u64, Commitment>(&mut v7, v5, v6);
        let v8 = UserCommitments{
            id               : 0x2::object::new(arg7),
            user             : v1,
            commitments      : v7,
            commitment_count : 1,
        };
        0x2::transfer::share_object<UserCommitments>(v8);
        if (0x2::table::contains<address, InviterStatsData>(&arg0.inviter_stats, arg5)) {
            let v9 = 0x2::table::borrow_mut<address, InviterStatsData>(&mut arg0.inviter_stats, arg5);
            v9.commit_count = v9.commit_count + 1;
            v9.total_commit_value = v9.total_commit_value + v3;
        } else {
            let v10 = InviterStatsData{
                commit_count         : 1,
                purchase_count       : 0,
                total_commit_value   : v3,
                total_purchase_value : 0,
            };
            0x2::table::add<address, InviterStatsData>(&mut arg0.inviter_stats, arg5, v10);
        };
        arg0.total_commitments = arg0.total_commitments + v3;
        let v11 = CommitmentMade{
            buyer         : v1,
            commitment_id : v5,
            nft_quantity  : arg2,
            price_per_nft : v2,
            total_price   : v3,
            deposit_paid  : v4,
            sui_address   : 0x1::string::utf8(arg4),
            inviter       : arg5,
            token_type    : 1,
        };
        0x2::event::emit<CommitmentMade>(v11);
    }

    public fun commitment_buyer(arg0: &Commitment) : address {
        arg0.buyer
    }

    public fun commitment_deposit_paid(arg0: &Commitment) : u64 {
        arg0.deposit_paid
    }

    public fun commitment_id(arg0: &Commitment) : u64 {
        arg0.commitment_id
    }

    public fun commitment_inviter(arg0: &Commitment) : address {
        arg0.inviter
    }

    public fun commitment_nft_quantity(arg0: &Commitment) : u64 {
        arg0.nft_quantity
    }

    public fun commitment_price_per_nft(arg0: &Commitment) : u64 {
        arg0.price_per_nft
    }

    public fun commitment_remaining_amount(arg0: &Commitment) : u64 {
        arg0.remaining_amount
    }

    public fun commitment_status(arg0: &Commitment) : u8 {
        arg0.status.value
    }

    public fun commitment_sui_address(arg0: &Commitment) : 0x1::string::String {
        arg0.sui_address
    }

    public fun commitment_token_type(arg0: &Commitment) : u8 {
        arg0.token_type
    }

    public fun commitment_total_price(arg0: &Commitment) : u64 {
        arg0.total_price
    }

    public entry fun complete_purchase(arg0: &mut PaymentSplitter, arg1: &mut UserCommitments, arg2: 0x2::coin::Coin<0x375f70cf2ae4c00bf37117d0c85a2c71545e6ee05c4a5c7d282cd66a4504b068::usdt::USDT>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 6);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        assert!(v0 >= arg0.purchase_start_time, 12);
        assert!(v0 <= arg0.purchase_start_time + arg0.purchase_period, 13);
        let v1 = 0x2::tx_context::sender(arg5);
        assert!(arg1.user == v1, 4);
        assert!(0x2::table::contains<u64, Commitment>(&arg1.commitments, arg3), 8);
        let v2 = 0x2::table::borrow_mut<u64, Commitment>(&mut arg1.commitments, arg3);
        assert!(v2.status.value == 0, 9);
        assert!(0x2::coin::value<0x375f70cf2ae4c00bf37117d0c85a2c71545e6ee05c4a5c7d282cd66a4504b068::usdt::USDT>(&arg2) >= v2.remaining_amount, 3);
        let v3 = v2.deposit_paid + v2.remaining_amount;
        let v4 = v3 * arg0.inviter_percentage / 100;
        let v5 = v3 - v4 - v3 * arg0.sender_refund_percentage / 100;
        let v6 = 0x2::coin::into_balance<0x375f70cf2ae4c00bf37117d0c85a2c71545e6ee05c4a5c7d282cd66a4504b068::usdt::USDT>(arg2);
        0x2::balance::join<0x375f70cf2ae4c00bf37117d0c85a2c71545e6ee05c4a5c7d282cd66a4504b068::usdt::USDT>(&mut v6, 0x2::balance::split<0x375f70cf2ae4c00bf37117d0c85a2c71545e6ee05c4a5c7d282cd66a4504b068::usdt::USDT>(&mut arg0.usdt_balance, v2.deposit_paid));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x375f70cf2ae4c00bf37117d0c85a2c71545e6ee05c4a5c7d282cd66a4504b068::usdt::USDT>>(0x2::coin::from_balance<0x375f70cf2ae4c00bf37117d0c85a2c71545e6ee05c4a5c7d282cd66a4504b068::usdt::USDT>(0x2::balance::split<0x375f70cf2ae4c00bf37117d0c85a2c71545e6ee05c4a5c7d282cd66a4504b068::usdt::USDT>(&mut v6, v4), arg5), v2.inviter);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x375f70cf2ae4c00bf37117d0c85a2c71545e6ee05c4a5c7d282cd66a4504b068::usdt::USDT>>(0x2::coin::from_balance<0x375f70cf2ae4c00bf37117d0c85a2c71545e6ee05c4a5c7d282cd66a4504b068::usdt::USDT>(0x2::balance::split<0x375f70cf2ae4c00bf37117d0c85a2c71545e6ee05c4a5c7d282cd66a4504b068::usdt::USDT>(&mut v6, v5), arg5), arg0.project_owner);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x375f70cf2ae4c00bf37117d0c85a2c71545e6ee05c4a5c7d282cd66a4504b068::usdt::USDT>>(0x2::coin::from_balance<0x375f70cf2ae4c00bf37117d0c85a2c71545e6ee05c4a5c7d282cd66a4504b068::usdt::USDT>(v6, arg5), v1);
        v2.status = new_commitment_status(1);
        let v7 = v2.inviter;
        if (0x2::table::contains<address, InviterStatsData>(&arg0.inviter_stats, v7)) {
            let v8 = 0x2::table::borrow_mut<address, InviterStatsData>(&mut arg0.inviter_stats, v7);
            v8.purchase_count = v8.purchase_count + 1;
            v8.total_purchase_value = v8.total_purchase_value + v3;
        };
        arg0.total_completed_purchases = arg0.total_completed_purchases + v3;
        arg0.total_inviter_payouts = arg0.total_inviter_payouts + v4;
        arg0.total_project_owner_payouts = arg0.total_project_owner_payouts + v5;
        let v9 = PurchaseCompleted{
            buyer               : v1,
            commitment_id       : arg3,
            remaining_paid      : v2.remaining_amount,
            inviter_share       : v4,
            project_owner_share : v5,
            timestamp           : v0,
        };
        0x2::event::emit<PurchaseCompleted>(v9);
    }

    public entry fun complete_purchase_usdc(arg0: &mut PaymentSplitter, arg1: &mut UserCommitments, arg2: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 6);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        assert!(v0 >= arg0.purchase_start_time, 12);
        assert!(v0 <= arg0.purchase_start_time + arg0.purchase_period, 13);
        let v1 = 0x2::tx_context::sender(arg5);
        assert!(arg1.user == v1, 4);
        assert!(0x2::table::contains<u64, Commitment>(&arg1.commitments, arg3), 8);
        let v2 = 0x2::table::borrow_mut<u64, Commitment>(&mut arg1.commitments, arg3);
        assert!(v2.token_type == 1, 8);
        assert!(v2.status.value == 0, 9);
        assert!(0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg2) >= v2.remaining_amount, 3);
        let v3 = v2.deposit_paid + v2.remaining_amount;
        let v4 = v3 * arg0.inviter_percentage / 100;
        let v5 = v3 - v4 - v3 * arg0.sender_refund_percentage / 100;
        let v6 = 0x2::coin::into_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2);
        0x2::balance::join<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut v6, 0x2::balance::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.usdc_balance, v2.deposit_paid));
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(0x2::coin::from_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x2::balance::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut v6, v4), arg5), v2.inviter);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(0x2::coin::from_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x2::balance::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut v6, v5), arg5), arg0.project_owner);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(0x2::coin::from_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v6, arg5), v1);
        v2.status = new_commitment_status(1);
        let v7 = v2.inviter;
        if (0x2::table::contains<address, InviterStatsData>(&arg0.inviter_stats, v7)) {
            let v8 = 0x2::table::borrow_mut<address, InviterStatsData>(&mut arg0.inviter_stats, v7);
            v8.purchase_count = v8.purchase_count + 1;
            v8.total_purchase_value = v8.total_purchase_value + v3;
        };
        arg0.total_completed_purchases = arg0.total_completed_purchases + v3;
        arg0.total_inviter_payouts = arg0.total_inviter_payouts + v4;
        arg0.total_project_owner_payouts = arg0.total_project_owner_payouts + v5;
        let v9 = PurchaseCompleted{
            buyer               : v1,
            commitment_id       : arg3,
            remaining_paid      : v2.remaining_amount,
            inviter_share       : v4,
            project_owner_share : v5,
            timestamp           : v0,
        };
        0x2::event::emit<PurchaseCompleted>(v9);
    }

    public fun get_authority(arg0: &PaymentSplitter) : address {
        arg0.authority
    }

    public fun get_commitment(arg0: &UserCommitments, arg1: u64) : &Commitment {
        0x2::table::borrow<u64, Commitment>(&arg0.commitments, arg1)
    }

    public fun get_contract_balance(arg0: &PaymentSplitter) : u64 {
        0x2::balance::value<0x375f70cf2ae4c00bf37117d0c85a2c71545e6ee05c4a5c7d282cd66a4504b068::usdt::USDT>(&arg0.usdt_balance)
    }

    public fun get_inviter_stats(arg0: &PaymentSplitter, arg1: address) : (u64, u64, u64, u64) {
        if (0x2::table::contains<address, InviterStatsData>(&arg0.inviter_stats, arg1)) {
            let v4 = 0x2::table::borrow<address, InviterStatsData>(&arg0.inviter_stats, arg1);
            (v4.commit_count, v4.purchase_count, v4.total_commit_value, v4.total_purchase_value)
        } else {
            (0, 0, 0, 0)
        }
    }

    public fun get_next_commitment_id(arg0: &PaymentSplitter) : u64 {
        arg0.next_commitment_id
    }

    public fun get_percentages(arg0: &PaymentSplitter) : (u64, u64, u64) {
        (arg0.inviter_percentage, arg0.project_owner_percentage, arg0.sender_refund_percentage)
    }

    public fun get_price_for_tier(arg0: u8) : u64 {
        if (arg0 == 0) {
            179000000
        } else if (arg0 == 1) {
            239000000
        } else if (arg0 == 2) {
            299000000
        } else {
            assert!(arg0 == 3, 5);
            359000000
        }
    }

    public fun get_price_tier(arg0: &PaymentSplitter, arg1: u8) : u64 {
        assert!(arg1 < 4, 5);
        *0x1::vector::borrow<u64>(&arg0.price_tiers, (arg1 as u64))
    }

    public fun get_price_tiers(arg0: &PaymentSplitter) : vector<u64> {
        arg0.price_tiers
    }

    public fun get_project_owner(arg0: &PaymentSplitter) : address {
        arg0.project_owner
    }

    public fun get_statistics(arg0: &PaymentSplitter) : (u64, u64, u64, u64, u64) {
        (arg0.total_commitments, arg0.total_completed_purchases, arg0.total_refunds, arg0.total_inviter_payouts, arg0.total_project_owner_payouts)
    }

    public fun get_time_config(arg0: &PaymentSplitter) : (u64, u64, u64, u64, u64, u64) {
        (arg0.commit_period, arg0.purchase_period, arg0.refund_period, arg0.commit_start_time, arg0.purchase_start_time, arg0.refund_start_time)
    }

    public fun get_usdc_balance(arg0: &PaymentSplitter) : u64 {
        0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg0.usdc_balance)
    }

    public fun get_usdt_balance(arg0: &PaymentSplitter) : u64 {
        0x2::balance::value<0x375f70cf2ae4c00bf37117d0c85a2c71545e6ee05c4a5c7d282cd66a4504b068::usdt::USDT>(&arg0.usdt_balance)
    }

    public fun get_user_commitment_count(arg0: &UserCommitments) : u64 {
        arg0.commitment_count
    }

    public fun has_commitment(arg0: &UserCommitments, arg1: u64) : bool {
        0x2::table::contains<u64, Commitment>(&arg0.commitments, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v1, 179000000);
        0x1::vector::push_back<u64>(&mut v1, 239000000);
        0x1::vector::push_back<u64>(&mut v1, 299000000);
        0x1::vector::push_back<u64>(&mut v1, 359000000);
        let v2 = 0;
        let v3 = PaymentSplitter{
            id                          : 0x2::object::new(arg0),
            authority                   : 0x2::tx_context::sender(arg0),
            project_owner               : 0x2::tx_context::sender(arg0),
            price_tiers                 : v1,
            inviter_percentage          : 10,
            project_owner_percentage    : 85,
            sender_refund_percentage    : 5,
            commit_period               : 259200000,
            purchase_period             : 604800000,
            refund_period               : 1209600000,
            commit_start_time           : v2,
            purchase_start_time         : v2,
            refund_start_time           : v2,
            total_commitments           : 0,
            total_completed_purchases   : 0,
            total_refunds               : 0,
            total_inviter_payouts       : 0,
            total_project_owner_payouts : 0,
            next_commitment_id          : 1,
            inviter_stats               : 0x2::table::new<address, InviterStatsData>(arg0),
            paused                      : false,
            usdt_balance                : 0x2::balance::zero<0x375f70cf2ae4c00bf37117d0c85a2c71545e6ee05c4a5c7d282cd66a4504b068::usdt::USDT>(),
            usdc_balance                : 0x2::balance::zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(),
        };
        0x2::transfer::share_object<PaymentSplitter>(v3);
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v4 = PaymentSplitterInitialized{
            authority     : 0x2::tx_context::sender(arg0),
            project_owner : 0x2::tx_context::sender(arg0),
        };
        0x2::event::emit<PaymentSplitterInitialized>(v4);
    }

    public fun is_commit_period_active(arg0: &PaymentSplitter, arg1: &0x2::clock::Clock) : bool {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        v0 >= arg0.commit_start_time && v0 <= arg0.commit_start_time + arg0.commit_period
    }

    public fun is_paused(arg0: &PaymentSplitter) : bool {
        arg0.paused
    }

    public fun is_purchase_period_active(arg0: &PaymentSplitter, arg1: &0x2::clock::Clock) : bool {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        v0 >= arg0.purchase_start_time && v0 <= arg0.purchase_start_time + arg0.purchase_period
    }

    public fun is_refund_period_active(arg0: &PaymentSplitter, arg1: &0x2::clock::Clock) : bool {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        v0 >= arg0.refund_start_time && v0 <= arg0.refund_start_time + arg0.refund_period
    }

    public fun new_commitment_status(arg0: u8) : CommitmentStatus {
        CommitmentStatus{value: arg0}
    }

    public entry fun request_refund(arg0: &mut PaymentSplitter, arg1: &mut UserCommitments, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 6);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        assert!(v0 >= arg0.refund_start_time, 14);
        assert!(v0 <= arg0.refund_start_time + arg0.refund_period, 15);
        let v1 = 0x2::tx_context::sender(arg4);
        assert!(arg1.user == v1, 4);
        assert!(0x2::table::contains<u64, Commitment>(&arg1.commitments, arg2), 8);
        let v2 = 0x2::table::borrow_mut<u64, Commitment>(&mut arg1.commitments, arg2);
        assert!(v2.status.value == 0, 9);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x375f70cf2ae4c00bf37117d0c85a2c71545e6ee05c4a5c7d282cd66a4504b068::usdt::USDT>>(0x2::coin::from_balance<0x375f70cf2ae4c00bf37117d0c85a2c71545e6ee05c4a5c7d282cd66a4504b068::usdt::USDT>(0x2::balance::split<0x375f70cf2ae4c00bf37117d0c85a2c71545e6ee05c4a5c7d282cd66a4504b068::usdt::USDT>(&mut arg0.usdt_balance, v2.deposit_paid), arg4), v1);
        v2.status = new_commitment_status(2);
        arg0.total_refunds = arg0.total_refunds + v2.deposit_paid;
        let v3 = RefundProcessed{
            buyer         : v1,
            commitment_id : arg2,
            refund_amount : v2.deposit_paid,
            timestamp     : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<RefundProcessed>(v3);
    }

    public entry fun request_refund_usdc(arg0: &mut PaymentSplitter, arg1: &mut UserCommitments, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 6);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        assert!(v0 >= arg0.refund_start_time, 14);
        assert!(v0 <= arg0.refund_start_time + arg0.refund_period, 15);
        let v1 = 0x2::tx_context::sender(arg4);
        assert!(arg1.user == v1, 4);
        assert!(0x2::table::contains<u64, Commitment>(&arg1.commitments, arg2), 8);
        let v2 = 0x2::table::borrow_mut<u64, Commitment>(&mut arg1.commitments, arg2);
        assert!(v2.token_type == 1, 8);
        assert!(v2.status.value == 0, 9);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(0x2::coin::from_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x2::balance::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.usdc_balance, v2.deposit_paid), arg4), v1);
        v2.status = new_commitment_status(2);
        arg0.total_refunds = arg0.total_refunds + v2.deposit_paid;
        let v3 = RefundProcessed{
            buyer         : v1,
            commitment_id : arg2,
            refund_amount : v2.deposit_paid,
            timestamp     : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<RefundProcessed>(v3);
    }

    public entry fun set_paused(arg0: &mut PaymentSplitter, arg1: &mut AdminCap, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        arg0.paused = arg2;
        let v0 = ContractPaused{paused: arg2};
        0x2::event::emit<ContractPaused>(v0);
    }

    public entry fun update_commit_period(arg0: &mut PaymentSplitter, arg1: &mut AdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        arg0.commit_period = arg2;
    }

    public entry fun update_commit_start_time(arg0: &mut PaymentSplitter, arg1: &mut AdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        arg0.commit_start_time = arg2;
    }

    public entry fun update_percentages(arg0: &mut PaymentSplitter, arg1: &mut AdminCap, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 + arg3 + arg4 == 100, 16);
        arg0.inviter_percentage = arg2;
        arg0.project_owner_percentage = arg3;
        arg0.sender_refund_percentage = arg4;
        let v0 = PercentagesUpdated{
            authority                    : 0x2::tx_context::sender(arg5),
            old_inviter_percentage       : arg0.inviter_percentage,
            old_project_owner_percentage : arg0.project_owner_percentage,
            old_sender_refund_percentage : arg0.sender_refund_percentage,
            new_inviter_percentage       : arg2,
            new_project_owner_percentage : arg3,
            new_sender_refund_percentage : arg4,
        };
        0x2::event::emit<PercentagesUpdated>(v0);
    }

    public entry fun update_price_tier(arg0: &mut PaymentSplitter, arg1: &mut AdminCap, arg2: u8, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 < 4, 5);
        assert!(arg3 > 0, 2);
        *0x1::vector::borrow_mut<u64>(&mut arg0.price_tiers, (arg2 as u64)) = arg3;
        let v0 = PriceTierUpdated{
            authority  : 0x2::tx_context::sender(arg4),
            tier_index : arg2,
            new_price  : arg3,
        };
        0x2::event::emit<PriceTierUpdated>(v0);
    }

    public entry fun update_project_owner(arg0: &mut PaymentSplitter, arg1: &mut AdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 != @0x0, 1);
        arg0.project_owner = arg2;
        let v0 = ProjectOwnerUpdated{
            old_owner : arg0.project_owner,
            new_owner : arg2,
        };
        0x2::event::emit<ProjectOwnerUpdated>(v0);
    }

    public entry fun update_purchase_period(arg0: &mut PaymentSplitter, arg1: &mut AdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        arg0.purchase_period = arg2;
    }

    public entry fun update_purchase_start_time(arg0: &mut PaymentSplitter, arg1: &mut AdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        arg0.purchase_start_time = arg2;
    }

    public entry fun update_refund_period(arg0: &mut PaymentSplitter, arg1: &mut AdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        arg0.refund_period = arg2;
    }

    public entry fun update_refund_start_time(arg0: &mut PaymentSplitter, arg1: &mut AdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        arg0.refund_start_time = arg2;
    }

    // decompiled from Move bytecode v6
}

