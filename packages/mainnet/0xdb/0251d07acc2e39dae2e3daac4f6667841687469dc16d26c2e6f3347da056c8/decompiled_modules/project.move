module 0xdb0251d07acc2e39dae2e3daac4f6667841687469dc16d26c2e6f3347da056c8::project {
    struct ProjectCreated has copy, drop {
        project_id: 0x2::object::ID,
        project_number: u64,
        creator: address,
        name: 0x1::string::String,
        description_blob_id: 0x1::string::String,
        icon_url: 0x1::string::String,
        source_code_blob_id: 0x1::string::String,
        project_details_blob_id: 0x1::string::String,
        base_rate: u64,
        funding_allocation: u64,
        end_time_ms: 0x1::option::Option<u64>,
        unsold_action: u8,
        timestamp_ms: u64,
    }

    struct Contributed has copy, drop {
        project_id: 0x2::object::ID,
        contributor: address,
        receipt_id: 0x2::object::ID,
        sui_amount: u64,
        refunded_amount: u64,
        token_share: u64,
        sold_before: u64,
        sold_after: u64,
        timestamp_ms: u64,
    }

    struct Closed has copy, drop {
        project_id: 0x2::object::ID,
        trigger: u8,
        triggered_by: address,
        sold: u64,
        total_sui_raised: u64,
        fee_bps_snapshot: u64,
        timestamp_ms: u64,
    }

    struct Compromised has copy, drop {
        project_id: 0x2::object::ID,
        admin: address,
        status_before: u8,
        drained_principal: u64,
        drained_fee: u64,
        treasury_address: address,
        unminted_tokens: u64,
        timestamp_ms: u64,
    }

    struct Claimed has copy, drop {
        project_id: 0x2::object::ID,
        user: address,
        receipt_id: 0x2::object::ID,
        sui_amount: u64,
        token_share: u64,
        timestamp_ms: u64,
    }

    struct Withdrawn has copy, drop {
        project_id: 0x2::object::ID,
        project_owner: address,
        recipient: address,
        gross_amount: u64,
        fee_amount: u64,
        net_to_owner: u64,
        project_balance_after: u64,
        timestamp_ms: u64,
    }

    struct UnsoldProcessed has copy, drop {
        project_id: 0x2::object::ID,
        project_owner: address,
        amount: u64,
        action: u8,
        final_total_supply: u64,
        timestamp_ms: u64,
    }

    struct MetadataUpdated has copy, drop {
        project_id: 0x2::object::ID,
        updater: address,
        new_name: 0x1::option::Option<0x1::string::String>,
        new_description_blob_id: 0x1::option::Option<0x1::string::String>,
        new_icon_url: 0x1::option::Option<0x1::string::String>,
        new_source_code_blob_id: 0x1::option::Option<0x1::string::String>,
        new_project_details_blob_id: 0x1::option::Option<0x1::string::String>,
        timestamp_ms: u64,
    }

    struct ProjectAdminRenounced has copy, drop {
        project_id: 0x2::object::ID,
        old_admin: address,
        timestamp_ms: u64,
    }

    struct ProjectAdminTransferred has copy, drop {
        project_id: 0x2::object::ID,
        old_admin: address,
        new_admin: address,
        timestamp_ms: u64,
    }

    struct ProjectVerified has copy, drop {
        project_id: 0x2::object::ID,
        admin: address,
        timestamp_ms: u64,
    }

    struct ProjectUnverified has copy, drop {
        project_id: 0x2::object::ID,
        admin: address,
        timestamp_ms: u64,
    }

    struct Project<phantom T0> has key {
        id: 0x2::object::UID,
        creator: address,
        name: 0x1::string::String,
        description_blob_id: 0x1::string::String,
        icon_url: 0x1::string::String,
        source_code_blob_id: 0x1::string::String,
        project_details_blob_id: 0x1::string::String,
        base_rate: u64,
        funding_allocation: u64,
        end_time_ms: 0x1::option::Option<u64>,
        unsold_action: u8,
        status: u8,
        sold: u64,
        unsold_processed: bool,
        verified: bool,
        sui_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        treasury_cap: 0x2::coin::TreasuryCap<T0>,
        created_at_ms: u64,
    }

    struct ProjectAdminCap<phantom T0> has store, key {
        id: 0x2::object::UID,
        project_id: 0x2::object::ID,
    }

    public fun admin_close<T0>(arg0: &0xdb0251d07acc2e39dae2e3daac4f6667841687469dc16d26c2e6f3347da056c8::platform::PlatformAdminCap, arg1: &mut Project<T0>, arg2: &0xdb0251d07acc2e39dae2e3daac4f6667841687469dc16d26c2e6f3347da056c8::platform::Platform, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(arg1.status == 0, 200);
        arg1.status = 1;
        let v0 = Closed{
            project_id       : 0x2::object::id<Project<T0>>(arg1),
            trigger          : 2,
            triggered_by     : 0x2::tx_context::sender(arg4),
            sold             : arg1.sold,
            total_sui_raised : 0x2::balance::value<0x2::sui::SUI>(&arg1.sui_balance),
            fee_bps_snapshot : 0xdb0251d07acc2e39dae2e3daac4f6667841687469dc16d26c2e6f3347da056c8::platform::fee_bps_internal(arg2),
            timestamp_ms     : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<Closed>(v0);
    }

    public fun admin_compromise<T0>(arg0: &0xdb0251d07acc2e39dae2e3daac4f6667841687469dc16d26c2e6f3347da056c8::platform::PlatformAdminCap, arg1: &mut Project<T0>, arg2: &mut 0xdb0251d07acc2e39dae2e3daac4f6667841687469dc16d26c2e6f3347da056c8::platform::Platform, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.status == 0 || arg1.status == 1, 203);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg1.sui_balance);
        let v1 = 0xdb0251d07acc2e39dae2e3daac4f6667841687469dc16d26c2e6f3347da056c8::math::calc_fee(v0, 0xdb0251d07acc2e39dae2e3daac4f6667841687469dc16d26c2e6f3347da056c8::platform::fee_bps_internal(arg2));
        let v2 = v0 - v1;
        let v3 = 0xdb0251d07acc2e39dae2e3daac4f6667841687469dc16d26c2e6f3347da056c8::platform::treasury_address_internal(arg2);
        let v4 = if (arg1.unsold_processed) {
            0
        } else {
            10000000000000000000 - arg1.sold
        };
        arg1.status = 2;
        if (v1 > 0) {
            0xdb0251d07acc2e39dae2e3daac4f6667841687469dc16d26c2e6f3347da056c8::platform::deposit_fee(arg2, 0x2::balance::split<0x2::sui::SUI>(&mut arg1.sui_balance, v1));
        };
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.sui_balance, v2), arg4), v3);
        };
        let v5 = Compromised{
            project_id        : 0x2::object::id<Project<T0>>(arg1),
            admin             : 0x2::tx_context::sender(arg4),
            status_before     : arg1.status,
            drained_principal : v2,
            drained_fee       : v1,
            treasury_address  : v3,
            unminted_tokens   : v4,
            timestamp_ms      : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<Compromised>(v5);
    }

    public fun admin_unverify_project<T0>(arg0: &0xdb0251d07acc2e39dae2e3daac4f6667841687469dc16d26c2e6f3347da056c8::platform::PlatformAdminCap, arg1: &mut Project<T0>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        arg1.verified = false;
        let v0 = ProjectUnverified{
            project_id   : 0x2::object::id<Project<T0>>(arg1),
            admin        : 0x2::tx_context::sender(arg3),
            timestamp_ms : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<ProjectUnverified>(v0);
    }

    public fun admin_verify_project<T0>(arg0: &0xdb0251d07acc2e39dae2e3daac4f6667841687469dc16d26c2e6f3347da056c8::platform::PlatformAdminCap, arg1: &mut Project<T0>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        arg1.verified = true;
        let v0 = ProjectVerified{
            project_id   : 0x2::object::id<Project<T0>>(arg1),
            admin        : 0x2::tx_context::sender(arg3),
            timestamp_ms : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<ProjectVerified>(v0);
    }

    public fun base_rate<T0>(arg0: &Project<T0>) : u64 {
        arg0.base_rate
    }

    public fun cap_project_id<T0>(arg0: &ProjectAdminCap<T0>) : 0x2::object::ID {
        arg0.project_id
    }

    public fun claim<T0>(arg0: &mut Project<T0>, arg1: 0xdb0251d07acc2e39dae2e3daac4f6667841687469dc16d26c2e6f3347da056c8::receipt::ContributionReceipt<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg0.status == 1 || arg0.status == 2, 202);
        let (v0, v1, v2, v3) = 0xdb0251d07acc2e39dae2e3daac4f6667841687469dc16d26c2e6f3347da056c8::receipt::destroy<T0>(arg1);
        let v4 = 0x2::object::id<Project<T0>>(arg0);
        assert!(v1 == v4, 400);
        let v5 = Claimed{
            project_id   : v4,
            user         : 0x2::tx_context::sender(arg3),
            receipt_id   : v0,
            sui_amount   : v2,
            token_share  : v3,
            timestamp_ms : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<Claimed>(v5);
        0x2::coin::mint<T0>(&mut arg0.treasury_cap, v3, arg3)
    }

    public fun claim_multiple<T0>(arg0: &mut Project<T0>, arg1: vector<0xdb0251d07acc2e39dae2e3daac4f6667841687469dc16d26c2e6f3347da056c8::receipt::ContributionReceipt<T0>>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg0.status == 1 || arg0.status == 2, 202);
        assert!(!0x1::vector::is_empty<0xdb0251d07acc2e39dae2e3daac4f6667841687469dc16d26c2e6f3347da056c8::receipt::ContributionReceipt<T0>>(&arg1), 401);
        let v0 = 0x2::object::id<Project<T0>>(arg0);
        let v1 = 0;
        while (!0x1::vector::is_empty<0xdb0251d07acc2e39dae2e3daac4f6667841687469dc16d26c2e6f3347da056c8::receipt::ContributionReceipt<T0>>(&arg1)) {
            let (v2, v3, v4, v5) = 0xdb0251d07acc2e39dae2e3daac4f6667841687469dc16d26c2e6f3347da056c8::receipt::destroy<T0>(0x1::vector::pop_back<0xdb0251d07acc2e39dae2e3daac4f6667841687469dc16d26c2e6f3347da056c8::receipt::ContributionReceipt<T0>>(&mut arg1));
            assert!(v3 == v0, 400);
            v1 = v1 + v5;
            let v6 = Claimed{
                project_id   : v0,
                user         : 0x2::tx_context::sender(arg3),
                receipt_id   : v2,
                sui_amount   : v4,
                token_share  : v5,
                timestamp_ms : 0x2::clock::timestamp_ms(arg2),
            };
            0x2::event::emit<Claimed>(v6);
        };
        0x1::vector::destroy_empty<0xdb0251d07acc2e39dae2e3daac4f6667841687469dc16d26c2e6f3347da056c8::receipt::ContributionReceipt<T0>>(arg1);
        0x2::coin::mint<T0>(&mut arg0.treasury_cap, v1, arg3)
    }

    public fun close_trigger_admin() : u8 {
        2
    }

    public fun close_trigger_sellout() : u8 {
        1
    }

    public fun close_trigger_time() : u8 {
        0
    }

    public fun contribute<T0>(arg0: &mut Project<T0>, arg1: &0xdb0251d07acc2e39dae2e3daac4f6667841687469dc16d26c2e6f3347da056c8::platform::Platform, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0xdb0251d07acc2e39dae2e3daac4f6667841687469dc16d26c2e6f3347da056c8::receipt::ContributionReceipt<T0>, 0x2::coin::Coin<0x2::sui::SUI>) {
        0xdb0251d07acc2e39dae2e3daac4f6667841687469dc16d26c2e6f3347da056c8::platform::assert_not_paused(arg1);
        assert!(arg0.status == 0, 200);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert!(v0 > 0, 300);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        if (0x1::option::is_some<u64>(&arg0.end_time_ms)) {
            assert!(v1 < *0x1::option::borrow<u64>(&arg0.end_time_ms), 302);
        };
        assert!(arg0.sold < arg0.funding_allocation, 301);
        let v2 = arg0.sold;
        let v3 = arg0.funding_allocation - v2;
        let v4 = 0xdb0251d07acc2e39dae2e3daac4f6667841687469dc16d26c2e6f3347da056c8::math::calc_sui_for_tokens_fixed(v3, arg0.base_rate);
        let (v5, v6, v7) = if (v0 >= v4) {
            (v3, v4, v0 - v4)
        } else {
            (0xdb0251d07acc2e39dae2e3daac4f6667841687469dc16d26c2e6f3347da056c8::math::calc_tokens_fixed(v0, arg0.base_rate), v0, 0)
        };
        let v8 = if (v7 > 0) {
            0x2::coin::split<0x2::sui::SUI>(&mut arg2, v7, arg4)
        } else {
            0x2::coin::zero<0x2::sui::SUI>(arg4)
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
        arg0.sold = v2 + v5;
        let v9 = 0x2::object::id<Project<T0>>(arg0);
        if (arg0.sold == arg0.funding_allocation) {
            arg0.status = 1;
            let v10 = Closed{
                project_id       : v9,
                trigger          : 1,
                triggered_by     : @0x0,
                sold             : arg0.sold,
                total_sui_raised : 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance),
                fee_bps_snapshot : 0xdb0251d07acc2e39dae2e3daac4f6667841687469dc16d26c2e6f3347da056c8::platform::fee_bps_internal(arg1),
                timestamp_ms     : v1,
            };
            0x2::event::emit<Closed>(v10);
        };
        let v11 = 0xdb0251d07acc2e39dae2e3daac4f6667841687469dc16d26c2e6f3347da056c8::receipt::new<T0>(v9, v6, v5, v1, arg4);
        let v12 = Contributed{
            project_id      : v9,
            contributor     : 0x2::tx_context::sender(arg4),
            receipt_id      : 0x2::object::id<0xdb0251d07acc2e39dae2e3daac4f6667841687469dc16d26c2e6f3347da056c8::receipt::ContributionReceipt<T0>>(&v11),
            sui_amount      : v6,
            refunded_amount : v7,
            token_share     : v5,
            sold_before     : v2,
            sold_after      : arg0.sold,
            timestamp_ms    : v1,
        };
        0x2::event::emit<Contributed>(v12);
        (v11, v8)
    }

    public fun create_project<T0>(arg0: &mut 0xdb0251d07acc2e39dae2e3daac4f6667841687469dc16d26c2e6f3347da056c8::platform::Platform, arg1: 0x2::coin::TreasuryCap<T0>, arg2: 0x2::coin::CoinMetadata<T0>, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: u64, arg9: u64, arg10: 0x1::option::Option<u64>, arg11: u8, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : ProjectAdminCap<T0> {
        0xdb0251d07acc2e39dae2e3daac4f6667841687469dc16d26c2e6f3347da056c8::platform::assert_not_paused(arg0);
        assert!(arg8 > 0, 101);
        assert!(arg9 > 0 && arg9 <= 10000000000000000000, 103);
        assert!(0x2::coin::total_supply<T0>(&arg1) == 0, 104);
        assert!(arg11 == 0 || arg11 == 1, 105);
        let v0 = 0x2::clock::timestamp_ms(arg12);
        if (0x1::option::is_some<u64>(&arg10)) {
            assert!(*0x1::option::borrow<u64>(&arg10) > v0, 108);
        };
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T0>>(arg2);
        let v1 = 0x2::tx_context::sender(arg13);
        let v2 = Project<T0>{
            id                      : 0x2::object::new(arg13),
            creator                 : v1,
            name                    : arg3,
            description_blob_id     : arg4,
            icon_url                : arg5,
            source_code_blob_id     : arg6,
            project_details_blob_id : arg7,
            base_rate               : arg8,
            funding_allocation      : arg9,
            end_time_ms             : arg10,
            unsold_action           : arg11,
            status                  : 0,
            sold                    : 0,
            unsold_processed        : false,
            verified                : false,
            sui_balance             : 0x2::balance::zero<0x2::sui::SUI>(),
            treasury_cap            : arg1,
            created_at_ms           : v0,
        };
        let v3 = 0x2::object::id<Project<T0>>(&v2);
        let v4 = ProjectAdminCap<T0>{
            id         : 0x2::object::new(arg13),
            project_id : v3,
        };
        let v5 = ProjectCreated{
            project_id              : v3,
            project_number          : 0xdb0251d07acc2e39dae2e3daac4f6667841687469dc16d26c2e6f3347da056c8::platform::bump_project_counter(arg0),
            creator                 : v1,
            name                    : v2.name,
            description_blob_id     : v2.description_blob_id,
            icon_url                : v2.icon_url,
            source_code_blob_id     : v2.source_code_blob_id,
            project_details_blob_id : v2.project_details_blob_id,
            base_rate               : v2.base_rate,
            funding_allocation      : v2.funding_allocation,
            end_time_ms             : v2.end_time_ms,
            unsold_action           : v2.unsold_action,
            timestamp_ms            : v0,
        };
        0x2::event::emit<ProjectCreated>(v5);
        0x2::transfer::share_object<Project<T0>>(v2);
        v4
    }

    public fun created_at_ms<T0>(arg0: &Project<T0>) : u64 {
        arg0.created_at_ms
    }

    public fun creator<T0>(arg0: &Project<T0>) : address {
        arg0.creator
    }

    public fun decimals() : u8 {
        9
    }

    public fun description_blob_id<T0>(arg0: &Project<T0>) : &0x1::string::String {
        &arg0.description_blob_id
    }

    public fun end_time_ms<T0>(arg0: &Project<T0>) : 0x1::option::Option<u64> {
        arg0.end_time_ms
    }

    public fun funding_allocation<T0>(arg0: &Project<T0>) : u64 {
        arg0.funding_allocation
    }

    public fun icon_url<T0>(arg0: &Project<T0>) : &0x1::string::String {
        &arg0.icon_url
    }

    public fun is_verified<T0>(arg0: &Project<T0>) : bool {
        arg0.verified
    }

    public fun name<T0>(arg0: &Project<T0>) : &0x1::string::String {
        &arg0.name
    }

    public fun permissionless_finalize<T0>(arg0: &mut Project<T0>, arg1: &0xdb0251d07acc2e39dae2e3daac4f6667841687469dc16d26c2e6f3347da056c8::platform::Platform, arg2: &0x2::clock::Clock) {
        assert!(arg0.status == 0, 200);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = 0x1::option::is_some<u64>(&arg0.end_time_ms) && v0 >= *0x1::option::borrow<u64>(&arg0.end_time_ms);
        if (!v1 && !(arg0.sold == arg0.funding_allocation)) {
            assert!(0x1::option::is_none<u64>(&arg0.end_time_ms), 205);
            abort 206
        };
        let v2 = if (v1) {
            0
        } else {
            1
        };
        arg0.status = 1;
        let v3 = Closed{
            project_id       : 0x2::object::id<Project<T0>>(arg0),
            trigger          : v2,
            triggered_by     : @0x0,
            sold             : arg0.sold,
            total_sui_raised : 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance),
            fee_bps_snapshot : 0xdb0251d07acc2e39dae2e3daac4f6667841687469dc16d26c2e6f3347da056c8::platform::fee_bps_internal(arg1),
            timestamp_ms     : v0,
        };
        0x2::event::emit<Closed>(v3);
    }

    public fun process_unsold<T0>(arg0: &ProjectAdminCap<T0>, arg1: &mut Project<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.project_id == 0x2::object::id<Project<T0>>(arg1), 500);
        assert!(arg1.status == 1, 201);
        assert!(!arg1.unsold_processed, 601);
        let v0 = 10000000000000000000 - arg1.sold;
        arg1.unsold_processed = true;
        if (v0 == 0) {
            let v1 = UnsoldProcessed{
                project_id         : 0x2::object::id<Project<T0>>(arg1),
                project_owner      : 0x2::tx_context::sender(arg3),
                amount             : 0,
                action             : arg1.unsold_action,
                final_total_supply : arg1.sold,
                timestamp_ms       : 0x2::clock::timestamp_ms(arg2),
            };
            0x2::event::emit<UnsoldProcessed>(v1);
            return
        };
        if (arg1.unsold_action == 0) {
            0x2::coin::burn<T0>(&mut arg1.treasury_cap, 0x2::coin::mint<T0>(&mut arg1.treasury_cap, v0, arg3));
            let v2 = UnsoldProcessed{
                project_id         : 0x2::object::id<Project<T0>>(arg1),
                project_owner      : 0x2::tx_context::sender(arg3),
                amount             : v0,
                action             : 0,
                final_total_supply : arg1.sold,
                timestamp_ms       : 0x2::clock::timestamp_ms(arg2),
            };
            0x2::event::emit<UnsoldProcessed>(v2);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::mint<T0>(&mut arg1.treasury_cap, v0, arg3), arg1.creator);
            let v3 = UnsoldProcessed{
                project_id         : 0x2::object::id<Project<T0>>(arg1),
                project_owner      : 0x2::tx_context::sender(arg3),
                amount             : v0,
                action             : 1,
                final_total_supply : 10000000000000000000,
                timestamp_ms       : 0x2::clock::timestamp_ms(arg2),
            };
            0x2::event::emit<UnsoldProcessed>(v3);
        };
    }

    public fun project_details_blob_id<T0>(arg0: &Project<T0>) : &0x1::string::String {
        &arg0.project_details_blob_id
    }

    public fun renounce_project_admin<T0>(arg0: ProjectAdminCap<T0>, arg1: &Project<T0>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(arg0.project_id == 0x2::object::id<Project<T0>>(arg1), 500);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg1.sui_balance) == 0, 502);
        if (arg1.status == 1) {
            assert!(arg1.unsold_processed, 503);
        };
        let ProjectAdminCap {
            id         : v0,
            project_id : v1,
        } = arg0;
        let v2 = ProjectAdminRenounced{
            project_id   : v1,
            old_admin    : 0x2::tx_context::sender(arg3),
            timestamp_ms : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<ProjectAdminRenounced>(v2);
        0x2::object::delete(v0);
    }

    public fun sold<T0>(arg0: &Project<T0>) : u64 {
        arg0.sold
    }

    public fun source_code_blob_id<T0>(arg0: &Project<T0>) : &0x1::string::String {
        &arg0.source_code_blob_id
    }

    public fun status<T0>(arg0: &Project<T0>) : u8 {
        arg0.status
    }

    public fun status_active() : u8 {
        0
    }

    public fun status_closed() : u8 {
        1
    }

    public fun status_compromised() : u8 {
        2
    }

    public fun sui_balance<T0>(arg0: &Project<T0>) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance)
    }

    public fun total_supply_raw() : u64 {
        10000000000000000000
    }

    public fun transfer_project_admin<T0>(arg0: ProjectAdminCap<T0>, arg1: address, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(arg1 != @0x0, 501);
        let v0 = ProjectAdminTransferred{
            project_id   : arg0.project_id,
            old_admin    : 0x2::tx_context::sender(arg3),
            new_admin    : arg1,
            timestamp_ms : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<ProjectAdminTransferred>(v0);
        0x2::transfer::public_transfer<ProjectAdminCap<T0>>(arg0, arg1);
    }

    public fun try_finalize<T0>(arg0: &mut Project<T0>, arg1: &0xdb0251d07acc2e39dae2e3daac4f6667841687469dc16d26c2e6f3347da056c8::platform::Platform, arg2: &0x2::clock::Clock) {
        if (arg0.status != 0) {
            return
        };
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = 0x1::option::is_some<u64>(&arg0.end_time_ms) && v0 >= *0x1::option::borrow<u64>(&arg0.end_time_ms);
        if (!v1 && !(arg0.sold == arg0.funding_allocation)) {
            return
        };
        let v2 = if (v1) {
            0
        } else {
            1
        };
        arg0.status = 1;
        let v3 = Closed{
            project_id       : 0x2::object::id<Project<T0>>(arg0),
            trigger          : v2,
            triggered_by     : @0x0,
            sold             : arg0.sold,
            total_sui_raised : 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance),
            fee_bps_snapshot : 0xdb0251d07acc2e39dae2e3daac4f6667841687469dc16d26c2e6f3347da056c8::platform::fee_bps_internal(arg1),
            timestamp_ms     : v0,
        };
        0x2::event::emit<Closed>(v3);
    }

    public fun unsold_action<T0>(arg0: &Project<T0>) : u8 {
        arg0.unsold_action
    }

    public fun unsold_burn() : u8 {
        0
    }

    public fun unsold_processed<T0>(arg0: &Project<T0>) : bool {
        arg0.unsold_processed
    }

    public fun unsold_transfer_to_creator() : u8 {
        1
    }

    public fun update_metadata<T0>(arg0: &ProjectAdminCap<T0>, arg1: &mut Project<T0>, arg2: 0x1::option::Option<0x1::string::String>, arg3: 0x1::option::Option<0x1::string::String>, arg4: 0x1::option::Option<0x1::string::String>, arg5: 0x1::option::Option<0x1::string::String>, arg6: 0x1::option::Option<0x1::string::String>, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) {
        assert!(arg0.project_id == 0x2::object::id<Project<T0>>(arg1), 500);
        assert!(arg1.status != 2, 204);
        if (0x1::option::is_some<0x1::string::String>(&arg2)) {
            arg1.name = *0x1::option::borrow<0x1::string::String>(&arg2);
        };
        if (0x1::option::is_some<0x1::string::String>(&arg3)) {
            arg1.description_blob_id = *0x1::option::borrow<0x1::string::String>(&arg3);
        };
        if (0x1::option::is_some<0x1::string::String>(&arg4)) {
            arg1.icon_url = *0x1::option::borrow<0x1::string::String>(&arg4);
        };
        if (0x1::option::is_some<0x1::string::String>(&arg5)) {
            arg1.source_code_blob_id = *0x1::option::borrow<0x1::string::String>(&arg5);
        };
        if (0x1::option::is_some<0x1::string::String>(&arg6)) {
            arg1.project_details_blob_id = *0x1::option::borrow<0x1::string::String>(&arg6);
        };
        let v0 = MetadataUpdated{
            project_id                  : 0x2::object::id<Project<T0>>(arg1),
            updater                     : 0x2::tx_context::sender(arg8),
            new_name                    : arg2,
            new_description_blob_id     : arg3,
            new_icon_url                : arg4,
            new_source_code_blob_id     : arg5,
            new_project_details_blob_id : arg6,
            timestamp_ms                : 0x2::clock::timestamp_ms(arg7),
        };
        0x2::event::emit<MetadataUpdated>(v0);
    }

    public fun withdraw_sui<T0>(arg0: &ProjectAdminCap<T0>, arg1: &mut Project<T0>, arg2: &mut 0xdb0251d07acc2e39dae2e3daac4f6667841687469dc16d26c2e6f3347da056c8::platform::Platform, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(arg0.project_id == 0x2::object::id<Project<T0>>(arg1), 500);
        assert!(arg1.status == 1, 201);
        assert!(arg3 > 0, 602);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg1.sui_balance) >= arg3, 600);
        let v0 = 0xdb0251d07acc2e39dae2e3daac4f6667841687469dc16d26c2e6f3347da056c8::math::calc_fee(arg3, 0xdb0251d07acc2e39dae2e3daac4f6667841687469dc16d26c2e6f3347da056c8::platform::fee_bps_internal(arg2));
        let v1 = arg3 - v0;
        if (v0 > 0) {
            0xdb0251d07acc2e39dae2e3daac4f6667841687469dc16d26c2e6f3347da056c8::platform::deposit_fee(arg2, 0x2::balance::split<0x2::sui::SUI>(&mut arg1.sui_balance, v0));
        };
        let v2 = 0x2::tx_context::sender(arg5);
        let v3 = Withdrawn{
            project_id            : 0x2::object::id<Project<T0>>(arg1),
            project_owner         : v2,
            recipient             : v2,
            gross_amount          : arg3,
            fee_amount            : v0,
            net_to_owner          : v1,
            project_balance_after : 0x2::balance::value<0x2::sui::SUI>(&arg1.sui_balance),
            timestamp_ms          : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<Withdrawn>(v3);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.sui_balance, v1), arg5)
    }

    // decompiled from Move bytecode v7
}

