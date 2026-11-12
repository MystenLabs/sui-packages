module 0x85baedc449aa80e4cec5f91d466fe317f2e0fb9c4db5a7d23bd574b8a065bc01::denovel {
    struct ChangeShard has key {
        id: 0x2::object::UID,
        shard_index: u8,
        count: u64,
    }

    struct ObjectChangedKey has copy, drop, store {
        seq: u64,
    }

    struct ObjectChanged has store, key {
        id: 0x2::object::UID,
        object_type: u16,
        object_id: 0x2::object::ID,
    }

    struct SelfHostedNode has store, key {
        id: 0x2::object::UID,
        owner: address,
        ip: 0x1::string::String,
        port: u16,
        active: bool,
        sync_public_key: vector<u8>,
        active_agreement_count: u64,
        provider_registration_count: u64,
        node_encrypt_pubkey: vector<u8>,
        node_sign_pubkey: vector<u8>,
    }

    struct HostingProvider has store, key {
        id: 0x2::object::UID,
        owner: address,
        hosted_node_id: 0x2::object::ID,
        commission_bps: u16,
        active: bool,
        disabled: bool,
    }

    struct AuthorHostingAgreement has store, key {
        id: 0x2::object::UID,
        author: address,
        provider: address,
        provider_ip: 0x1::string::String,
        provider_port: u16,
        commission_bps: u16,
        active: bool,
        suspension_state: u8,
        started_at: u64,
        node_id: 0x2::object::ID,
        node_encrypt_pubkey: vector<u8>,
        node_sign_pubkey: vector<u8>,
    }

    struct DENOVEL has drop {
        dummy_field: bool,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct UserCap has key {
        id: 0x2::object::UID,
        owner: address,
    }

    struct POINT has drop {
        _seal: bool,
    }

    struct DaoMemberChanged has store, key {
        id: 0x2::object::UID,
        dao_id: 0x2::object::ID,
        member: address,
        action: u8,
        reason: 0x1::string::String,
        operator: address,
        timestamp: u64,
        seq: u64,
    }

    struct FinancialPart has copy, drop, store {
        part_type: u8,
        wallet_addr: address,
        obj_id: 0x2::object::ID,
    }

    struct FinancialRecord has store, key {
        id: 0x2::object::UID,
        tx_type: u8,
        fee_type: u8,
        from: FinancialPart,
        to: FinancialPart,
        coin_type: 0x1::string::String,
        coin_decimals: u8,
        work_name: 0x1::string::String,
        chapter_title: 0x1::string::String,
        amount: u64,
        ref_id: 0x2::object::ID,
        ref_payment_type: u8,
        ref_payment_id: 0x2::object::ID,
        timestamp: u64,
        parent_id: 0x2::object::ID,
        share_seq: u64,
    }

    struct DaoDenylistChanged has store, key {
        id: 0x2::object::UID,
        dao_id: 0x2::object::ID,
        user: address,
        denied: u8,
        operator: address,
        seq: u64,
    }

    struct AllowedCoins has key {
        id: 0x2::object::UID,
        symbols: 0x2::vec_set::VecSet<0x1::string::String>,
    }

    struct PlatformDenyList has key {
        id: 0x2::object::UID,
        denylist_change_seq: u64,
    }

    struct PlatformDenylistChanged has store, key {
        id: 0x2::object::UID,
        user: address,
        denied: u8,
        seq: u64,
    }

    struct AdminDisableRecord has store, key {
        id: 0x2::object::UID,
        object_type: u8,
        object_id: 0x2::object::ID,
        disabled: bool,
        user_id: 0x2::object::ID,
    }

    struct DaoWork has drop, store {
        dummy_field: bool,
    }

    struct DaoDenylist has drop, store {
        dummy_field: bool,
    }

    struct DaoDenylistKey has copy, drop, store {
        user: address,
    }

    struct GlobalDenylist has drop, store {
        dummy_field: bool,
    }

    struct TestWalletListKey has copy, drop, store {
        dummy_field: bool,
    }

    struct TestWalletList has key {
        id: 0x2::object::UID,
        visible: bool,
        seq: u64,
    }

    struct TestWalletChanged has store, key {
        id: 0x2::object::UID,
        user: address,
        state: u8,
        seq: u64,
    }

    struct UserWork has drop, store {
        dummy_field: bool,
    }

    struct WorkPayer has drop, store {
        dummy_field: bool,
    }

    struct DaoMember has copy, drop, store {
        member: address,
    }

    struct DaoMemberData has drop, store {
        joined_at: u64,
    }

    struct FundMemberShareData has drop, store {
        shares: u64,
        role: 0x1::string::String,
    }

    struct DaoInviteCode has copy, drop, store {
        uuid: vector<u8>,
    }

    struct DaoInviteCodeData has drop, store {
        inviter: address,
        recipient: address,
        used_by: address,
        used_at: u64,
    }

    struct RegInviteCode has copy, drop, store {
        uuid: vector<u8>,
    }

    struct RegInviteCodeData has drop, store {
        inviter: address,
        recipient: address,
        used_by: address,
        used_at: u64,
    }

    struct GeneralInviteCodeBookKey has copy, drop, store {
        dummy_field: bool,
    }

    struct GeneralInviteCodeEntry has copy, drop, store {
        uuid: vector<u8>,
        signature: vector<u8>,
        label: 0x1::string::String,
        created_at: u64,
        revoked: bool,
        revoked_at: u64,
    }

    struct GeneralInviteCodeBook has drop, store {
        entries: vector<GeneralInviteCodeEntry>,
    }

    struct ContentTagsKey has copy, drop, store {
        content_type: u8,
    }

    struct ContentTags has key {
        id: 0x2::object::UID,
        content_type: u8,
        list: 0x2::vec_set::VecSet<0x1::string::String>,
    }

    struct ContentTagTextKey has copy, drop, store {
        content_type: u8,
        tag: 0x1::string::String,
    }

    struct TagLocaleText has drop, store {
        locale: 0x1::string::String,
        text: 0x1::string::String,
    }

    struct ContentTagText has key {
        id: 0x2::object::UID,
        content_type: u8,
        tag: 0x1::string::String,
        texts: vector<TagLocaleText>,
    }

    struct SignalingServers has key {
        id: 0x2::object::UID,
        urls: 0x2::vec_set::VecSet<0x1::string::String>,
    }

    struct Complaint has key {
        id: 0x2::object::UID,
        reader: address,
        chapter_id: 0x2::object::ID,
        work_id: 0x2::object::ID,
        complaint_type: u8,
        fee: u64,
        coin_type: 0x1::string::String,
    }

    struct UserAgreementContent has store, key {
        id: 0x2::object::UID,
        content: 0x1::string::String,
    }

    struct Registry has key {
        id: 0x2::object::UID,
    }

    struct NameKey has copy, drop, store {
        name: 0x1::string::String,
    }

    struct UserInfo has copy, drop, store {
        user_id: 0x2::object::ID,
        auto_pubkey: vector<u8>,
        encrypt_pubkey: vector<u8>,
    }

    struct PubKeyRegistry has key {
        id: 0x2::object::UID,
    }

    struct PubKeyRegKey has copy, drop, store {
        pubkey: vector<u8>,
    }

    struct PlatformReferral has store {
        referral_window1: u8,
        referral_window2: u8,
        referral_bps1: u16,
        referral_bps2: u16,
        referral_author_bps1: u16,
        referral_author_bps2: u16,
    }

    struct PlatformComplaint has store {
        base_complaint_fee: u64,
        complaint_min_points_total: u64,
        complaint_threshold: u64,
        max_closed_chapters_for_banned_work: u8,
    }

    struct PlatformWorkConfig has store {
        max_banned_works_for_author: u8,
        max_work_tags: u8,
        min_chapter_publish_interval_seconds: u64,
    }

    struct WorkDepositAmountKey has copy, drop, store {
        dummy_field: bool,
    }

    struct WorkDepositRefundSecondsKey has copy, drop, store {
        dummy_field: bool,
    }

    struct WorkDepositCoinTypeKey has copy, drop, store {
        dummy_field: bool,
    }

    struct RandomOutletBpsKey has copy, drop, store {
        dummy_field: bool,
    }

    struct Platform has key {
        id: 0x2::object::UID,
        user_agreement_version: u8,
        platform_fee_bps: u16,
        system_work_id: 0x2::object::ID,
        system_dao_id: 0x2::object::ID,
        disabled: bool,
        enabled_content_types: 0x2::vec_set::VecSet<u8>,
        registration_mode: u8,
        create_dao_without_work_allowed: bool,
        admin_user_id: 0x2::object::ID,
        platform_denylist_id: 0x2::object::ID,
        referral: PlatformReferral,
        complaint: PlatformComplaint,
        work: PlatformWorkConfig,
        change_shard_ids: vector<0x2::object::ID>,
        points_supply: 0x2::balance::Supply<POINT>,
        pubkey_registry_id: 0x2::object::ID,
        current_version: u64,
        current_package_id: 0x2::object::ID,
        pending_version: u64,
        pending_package_id: 0x2::object::ID,
        registry_id: 0x2::object::ID,
        allowed_coins_id: 0x2::object::ID,
        signaling_servers_id: 0x2::object::ID,
        admin_cap_id: 0x2::object::ID,
    }

    struct NovelFund<phantom T0> has key {
        id: 0x2::object::UID,
        owner: address,
        coin_type: 0x1::string::String,
        dao_id: 0x2::object::ID,
        coin_decimals: u8,
        balance: 0x2::balance::Balance<T0>,
        rewards_per_share_cumulative: u128,
        fund_type: u8,
        debts: 0x2::table::Table<address, u128>,
    }

    struct FundMemberShareKey has copy, drop, store {
        user: address,
    }

    struct AuthorFundKey has copy, drop, store {
        dummy_field: bool,
    }

    struct PlatformFundKey has copy, drop, store {
        dummy_field: bool,
    }

    struct FundShares has store, key {
        id: 0x2::object::UID,
        total_shares: u64,
        owner: address,
        fund_coin_seqs: 0x2::table::Table<0x1::string::String, 0x2::object::ID>,
        fund_member_seq: u64,
    }

    struct FundMemberChanged has store, key {
        id: 0x2::object::UID,
        dao_id: 0x2::object::ID,
        member: address,
        role: 0x1::string::String,
        shares: u64,
        action: u8,
        seq: u64,
    }

    struct SettleTicket {
        dao_id: 0x2::object::ID,
        member: address,
        expected: u64,
        done: u64,
        action: u8,
        settled: vector<0x2::object::ID>,
    }

    struct ShareChangeTicket {
        dao_id: 0x2::object::ID,
        member: address,
        expected: u64,
        done: u64,
        action: u8,
        amount: u64,
        role: 0x1::string::String,
        author_obj_id: 0x2::object::ID,
        settled: vector<0x2::object::ID>,
    }

    struct ChapterUuidKey has copy, drop, store {
        value: 0x1::string::String,
    }

    struct ChapterContentHashKey has copy, drop, store {
        value: vector<u8>,
    }

    struct UserHosting has store {
        state: u8,
        provider: address,
    }

    struct UserAgreementSign has store {
        sign_pubkey: vector<u8>,
        signature: vector<u8>,
        version: u8,
    }

    struct User has key {
        id: 0x2::object::UID,
        owner: address,
        name: 0x1::string::String,
        intro: 0x1::string::String,
        avatar: 0x1::option::Option<0x2::object::ID>,
        avatar_mime_type: 0x1::string::String,
        referrer: address,
        referral_time: u64,
        agreement: UserAgreementSign,
        dao_id: 0x1::option::Option<0x2::object::ID>,
        banned_work_count: u8,
        encrypt_pubkey: vector<u8>,
        auto_pubkey: vector<u8>,
        complaint_count: u64,
        age_confirm_signatures: 0x2::table::Table<u8, vector<u8>>,
        points_balance: 0x2::balance::Balance<POINT>,
        page_key_paused: bool,
        hosting: UserHosting,
        work_count: u64,
        points_earned_cumulative: u64,
        node_disabled: bool,
        author_service_disabled: bool,
    }

    struct Work has store, key {
        id: 0x2::object::UID,
        owner: address,
        content_type: u8,
        dao_id: 0x2::object::ID,
        name: 0x1::string::String,
        intro: 0x1::string::String,
        tags: vector<0x1::string::String>,
        age_rating: u8,
        closed_chapter_count: u8,
        banned: bool,
        payers_count: u64,
        disabled: bool,
        cover: 0x1::option::Option<0x2::object::ID>,
        cover_mime_type: 0x1::string::String,
        published_at: u64,
        chapter_count: u64,
        last_chapter_published_at: u64,
    }

    struct WorkDeposit<phantom T0> has key {
        id: 0x2::object::UID,
        balance: 0x1::option::Option<0x2::balance::Balance<T0>>,
        coin_type: 0x1::string::String,
        amount: u64,
        withdrawn: bool,
        unlock_at: u64,
        work_id: 0x2::object::ID,
    }

    struct PendingPayout<phantom T0> has key {
        id: 0x2::object::UID,
        member: address,
        dao_id: 0x2::object::ID,
        fund_id: 0x2::object::ID,
        coin_type: 0x1::string::String,
        coin_decimals: u8,
        amount: u64,
        balance: 0x1::option::Option<0x2::balance::Balance<T0>>,
        claimed: bool,
        created_at: u64,
    }

    struct Chapter has key {
        id: 0x2::object::UID,
        uuid: 0x1::string::String,
        owner: address,
        dao_id: 0x2::object::ID,
        work_id: 0x2::object::ID,
        part_name: 0x1::string::String,
        title: 0x1::string::String,
        preview: 0x1::string::String,
        content_hash: vector<u8>,
        published_at: u64,
        mime_type: 0x1::string::String,
        coin_type: 0x1::string::String,
        coin_decimals: u8,
        price: u64,
        policy: u8,
        banned: bool,
        complained: 0x2::table::Table<address, 0x2::object::ID>,
        seqno: u64,
    }

    struct ChapterMemberPriceKey has copy, drop, store {
        dummy_field: bool,
    }

    struct ChapterContent has key {
        id: 0x2::object::UID,
        owner: address,
        work_id: 0x2::object::ID,
        chapter_uuid: 0x1::string::String,
        bytes: vector<u8>,
        mime_type: 0x1::string::String,
        encrypt_pubkey: 0x1::string::String,
        created_at: u64,
    }

    struct Avatar has key {
        id: 0x2::object::UID,
        owner: address,
        user_id: 0x2::object::ID,
        bytes: vector<u8>,
        mime_type: 0x1::string::String,
        width: u32,
        height: u32,
        updated_at: u64,
    }

    struct Cover has key {
        id: 0x2::object::UID,
        owner: address,
        work_id: 0x2::object::ID,
        bytes: vector<u8>,
        mime_type: 0x1::string::String,
        width: u32,
        height: u32,
        updated_at: u64,
    }

    struct Payment has key {
        id: 0x2::object::UID,
        reader: address,
        author_id: 0x2::object::ID,
        work_id: 0x2::object::ID,
        chapter_id: 0x2::object::ID,
        price: u64,
        amount: u64,
        platform_bps: u16,
        platform_fee: u64,
        referral_bps: u16,
        referral_fee: u64,
        coin_type: 0x1::string::String,
        coin_decimals: u8,
    }

    struct Contacts has drop, store {
        x: 0x1::string::String,
        discord: 0x1::string::String,
        telegram: 0x1::string::String,
    }

    struct DaoJoinRequirements has drop, store {
        min_platform_points: u64,
    }

    struct DaoMemberPolicy has drop, store {
        fee_required: u64,
        fee_coin_type: 0x1::string::String,
        member_duration: u64,
        join_requirements: DaoJoinRequirements,
    }

    struct Dao has key {
        id: 0x2::object::UID,
        owner: address,
        name: 0x1::string::String,
        intro: 0x1::string::String,
        is_private: bool,
        age_rating: u8,
        contacts: Contacts,
        disabled: bool,
        member_policy: DaoMemberPolicy,
        dao_member_change_seq: u64,
        dao_denylist_change_seq: u64,
    }

    struct VersionNoticeUrl has copy, drop, store {
        url_type: u8,
        mime_type: vector<u8>,
        url: vector<u8>,
    }

    struct EndVersionNotice has copy, drop, store {
        end_type: u8,
        latest: u64,
        min_required: u64,
        stop_scope: u8,
        notice_url: VersionNoticeUrl,
    }

    struct AppVersionNotice has store, key {
        id: 0x2::object::UID,
        ends: vector<EndVersionNotice>,
    }

    struct AppVersionNoticeKey has copy, drop, store {
        dummy_field: bool,
    }

    fun address_of(arg0: &vector<u8>) : address {
        let v0 = 0x1::vector::length<u8>(arg0);
        if (v0 == 32) {
            let v2 = 0x1::vector::empty<u8>();
            0x1::vector::push_back<u8>(&mut v2, 0);
            0x1::vector::append<u8>(&mut v2, *arg0);
            0x2::address::from_bytes(0x2::hash::blake2b256(&v2))
        } else if (v0 == 33) {
            0x2::address::from_bytes(0x2::hash::blake2b256(arg0))
        } else {
            assert!(v0 == 34, 1017);
            0x2::address::from_bytes(0x2::hash::blake2b256(arg0))
        }
    }

    entry fun admin_add_allowed_coin<T0: drop>(arg0: &mut Platform, arg1: &mut AllowedCoins, arg2: &0x2::coin_registry::Currency<T0>, arg3: &AdminCap, arg4: &mut ChangeShard, arg5: &mut 0x2::tx_context::TxContext) {
        ensure_contract_version(arg0);
        assert_shard_matches(arg0, arg4, arg5);
        let v0 = coin_type_from_type<T0>();
        if (!0x2::vec_set::contains<0x1::string::String>(&arg1.symbols, &v0)) {
            0x2::vec_set::insert<0x1::string::String>(&mut arg1.symbols, v0);
            record_object_change(arg4, 20, 0x2::object::id<AllowedCoins>(arg1), arg5);
            init_platform_fund<T0>(arg0, arg2, arg3, arg4, arg5);
        };
    }

    entry fun admin_add_change_shard(arg0: &mut Platform, arg1: &mut ChangeShard, arg2: &AdminCap, arg3: &mut 0x2::tx_context::TxContext) {
        ensure_contract_version(arg0);
        assert!(0x1::vector::length<0x2::object::ID>(&arg0.change_shard_ids) < 256, 2020);
        assert!(arg1.shard_index == 0, 2019);
        assert!(*0x1::vector::borrow<0x2::object::ID>(&arg0.change_shard_ids, 0) == 0x2::object::id<ChangeShard>(arg1), 2019);
        let v0 = ChangeShard{
            id          : 0x2::object::new(arg3),
            shard_index : (0x1::vector::length<0x2::object::ID>(&arg0.change_shard_ids) as u8),
            count       : 0,
        };
        0x2::transfer::share_object<ChangeShard>(v0);
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.change_shard_ids, 0x2::object::id<ChangeShard>(&v0));
        record_object_change(arg1, 19, 0x2::object::id<Platform>(arg0), arg3);
    }

    entry fun admin_add_content_tag_with_texts(arg0: &Platform, arg1: &mut ContentTags, arg2: &mut ContentTagText, arg3: 0x1::string::String, arg4: vector<0x1::string::String>, arg5: vector<0x1::string::String>, arg6: &AdminCap, arg7: &mut ChangeShard, arg8: &mut 0x2::tx_context::TxContext) {
        ensure_contract_version(arg0);
        assert_shard_matches(arg0, arg7, arg8);
        assert!(arg1.content_type == arg2.content_type, 1059);
        assert!(arg2.tag == arg3, 1141);
        assert!(!0x2::vec_set::contains<0x1::string::String>(&arg1.list, &arg3), 1142);
        assert_tag_text_input(&arg3, &arg4, &arg5);
        0x2::vec_set::insert<0x1::string::String>(&mut arg1.list, arg3);
        upsert_tag_texts(arg2, arg4, arg5);
        record_object_change(arg7, 21, 0x2::object::id<ContentTags>(arg1), arg8);
        record_object_change(arg7, 26, 0x2::object::id<ContentTagText>(arg2), arg8);
    }

    entry fun admin_add_content_tags(arg0: &Platform, arg1: &mut ContentTags, arg2: vector<0x1::string::String>, arg3: &AdminCap, arg4: &mut ChangeShard, arg5: &mut 0x2::tx_context::TxContext) {
        ensure_contract_version(arg0);
        assert_shard_matches(arg0, arg4, arg5);
        let v0 = 0;
        let v1 = 0x1::vector::empty<0x1::string::String>();
        while (v0 < 0x1::vector::length<0x1::string::String>(&arg2)) {
            let v2 = *0x1::vector::borrow<0x1::string::String>(&arg2, v0);
            assert!(0x1::vector::length<u8>(0x1::string::as_bytes(&v2)) <= 64, 1140);
            if (!0x2::vec_set::contains<0x1::string::String>(&arg1.list, &v2)) {
                0x2::vec_set::insert<0x1::string::String>(&mut arg1.list, v2);
                0x1::vector::push_back<0x1::string::String>(&mut v1, v2);
            };
            v0 = v0 + 1;
        };
        if (0x1::vector::length<0x1::string::String>(&v1) > 0) {
            record_object_change(arg4, 21, 0x2::object::id<ContentTags>(arg1), arg5);
        };
    }

    entry fun admin_add_signaling_server(arg0: &Platform, arg1: &mut SignalingServers, arg2: 0x1::string::String, arg3: &AdminCap, arg4: &mut ChangeShard, arg5: &mut 0x2::tx_context::TxContext) {
        ensure_contract_version(arg0);
        assert_shard_matches(arg0, arg4, arg5);
        if (0x2::vec_set::contains<0x1::string::String>(&arg1.urls, &arg2)) {
            return
        };
        0x2::vec_set::insert<0x1::string::String>(&mut arg1.urls, arg2);
        record_object_change(arg4, 22, 0x2::object::id<SignalingServers>(arg1), arg5);
    }

    entry fun admin_disable_content_type(arg0: &mut Platform, arg1: u8, arg2: &AdminCap, arg3: &mut ChangeShard, arg4: &mut 0x2::tx_context::TxContext) {
        ensure_contract_version(arg0);
        assert_shard_matches(arg0, arg3, arg4);
        assert!(arg1 != 0, 2012);
        if (0x2::vec_set::contains<u8>(&arg0.enabled_content_types, &arg1)) {
            0x2::vec_set::remove<u8>(&mut arg0.enabled_content_types, &arg1);
            record_object_change(arg3, 19, 0x2::object::id<Platform>(arg0), arg4);
        };
    }

    entry fun admin_enable_content_type(arg0: &mut Platform, arg1: u8, arg2: &AdminCap, arg3: &mut ChangeShard, arg4: &mut 0x2::tx_context::TxContext) {
        ensure_contract_version(arg0);
        assert_shard_matches(arg0, arg3, arg4);
        let v0 = false;
        if (!0x2::vec_set::contains<u8>(&arg0.enabled_content_types, &arg1)) {
            0x2::vec_set::insert<u8>(&mut arg0.enabled_content_types, arg1);
            v0 = true;
            let v1 = ContentTagsKey{content_type: arg1};
            if (!0x2::derived_object::exists<ContentTagsKey>(&arg0.id, v1)) {
                let v2 = ContentTagsKey{content_type: arg1};
                let v3 = ContentTags{
                    id           : 0x2::derived_object::claim<ContentTagsKey>(&mut arg0.id, v2),
                    content_type : arg1,
                    list         : 0x2::vec_set::empty<0x1::string::String>(),
                };
                record_object_change(arg3, 21, 0x2::object::id<ContentTags>(&v3), arg4);
                0x2::transfer::share_object<ContentTags>(v3);
            };
        };
        if (v0) {
            record_object_change(arg3, 19, 0x2::object::id<Platform>(arg0), arg4);
        };
    }

    entry fun admin_init_and_set_test_wallet_batch(arg0: &mut Platform, arg1: vector<address>, arg2: bool, arg3: &AdminCap, arg4: &mut ChangeShard, arg5: &mut 0x2::tx_context::TxContext) {
        ensure_contract_version(arg0);
        assert_shard_matches(arg0, arg4, arg5);
        assert_test_wallet_list_not_created(arg0);
        let v0 = TestWalletListKey{dummy_field: false};
        let v1 = TestWalletList{
            id      : 0x2::derived_object::claim<TestWalletListKey>(&mut arg0.id, v0),
            visible : false,
            seq     : 0,
        };
        let v2 = &mut v1;
        apply_test_wallet_batch(v2, arg1, arg2, arg4, arg5);
        0x2::transfer::share_object<TestWalletList>(v1);
        record_object_change(arg4, 25, 0x2::object::id<TestWalletList>(&v1), arg5);
    }

    entry fun admin_init_app_version_notice(arg0: &mut Platform, arg1: &AdminCap, arg2: &mut ChangeShard, arg3: &mut 0x2::tx_context::TxContext) {
        ensure_contract_version(arg0);
        assert_shard_matches(arg0, arg2, arg3);
        assert_app_version_notice_not_created(arg0);
        let v0 = AppVersionNoticeKey{dummy_field: false};
        let v1 = AppVersionNotice{
            id   : 0x2::derived_object::claim<AppVersionNoticeKey>(&mut arg0.id, v0),
            ends : 0x1::vector::empty<EndVersionNotice>(),
        };
        0x2::transfer::share_object<AppVersionNotice>(v1);
        record_object_change(arg2, 28, 0x2::object::id<AppVersionNotice>(&v1), arg3);
    }

    entry fun admin_init_content_tag_texts(arg0: &mut Platform, arg1: u8, arg2: vector<0x1::string::String>, arg3: &AdminCap, arg4: &mut ChangeShard, arg5: &mut 0x2::tx_context::TxContext) {
        ensure_contract_version(arg0);
        assert_shard_matches(arg0, arg4, arg5);
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1::string::String>(&arg2)) {
            let v1 = *0x1::vector::borrow<0x1::string::String>(&arg2, v0);
            assert!(0x1::string::length(&v1) > 0, 1137);
            assert!(0x1::string::length(&v1) <= 64, 1140);
            let v2 = ContentTagTextKey{
                content_type : arg1,
                tag          : v1,
            };
            if (!0x2::derived_object::exists<ContentTagTextKey>(&arg0.id, v2)) {
                let v3 = ContentTagTextKey{
                    content_type : arg1,
                    tag          : v1,
                };
                let v4 = ContentTagText{
                    id           : 0x2::derived_object::claim<ContentTagTextKey>(&mut arg0.id, v3),
                    content_type : arg1,
                    tag          : v1,
                    texts        : 0x1::vector::empty<TagLocaleText>(),
                };
                record_object_change(arg4, 26, 0x2::object::id<ContentTagText>(&v4), arg5);
                0x2::transfer::share_object<ContentTagText>(v4);
            };
            v0 = v0 + 1;
        };
    }

    entry fun admin_init_work_governance_config(arg0: &mut Platform, arg1: &AdminCap, arg2: &mut ChangeShard, arg3: &mut 0x2::tx_context::TxContext) {
        ensure_contract_version(arg0);
        assert_shard_matches(arg0, arg2, arg3);
        let v0 = WorkDepositAmountKey{dummy_field: false};
        let v1 = if (!0x2::dynamic_field::exists<WorkDepositAmountKey>(&arg0.id, v0)) {
            let v2 = WorkDepositRefundSecondsKey{dummy_field: false};
            if (!0x2::dynamic_field::exists<WorkDepositRefundSecondsKey>(&arg0.id, v2)) {
                let v3 = WorkDepositCoinTypeKey{dummy_field: false};
                if (!0x2::dynamic_field::exists<WorkDepositCoinTypeKey>(&arg0.id, v3)) {
                    let v4 = RandomOutletBpsKey{dummy_field: false};
                    !0x2::dynamic_field::exists<RandomOutletBpsKey>(&arg0.id, v4)
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 1134);
        let v5 = WorkDepositAmountKey{dummy_field: false};
        0x2::dynamic_field::add<WorkDepositAmountKey, u64>(&mut arg0.id, v5, 0);
        let v6 = WorkDepositRefundSecondsKey{dummy_field: false};
        0x2::dynamic_field::add<WorkDepositRefundSecondsKey, u64>(&mut arg0.id, v6, 0);
        let v7 = WorkDepositCoinTypeKey{dummy_field: false};
        0x2::dynamic_field::add<WorkDepositCoinTypeKey, 0x1::string::String>(&mut arg0.id, v7, default_work_deposit_coin_type());
        let v8 = RandomOutletBpsKey{dummy_field: false};
        0x2::dynamic_field::add<RandomOutletBpsKey, u16>(&mut arg0.id, v8, 2500);
        record_object_change(arg2, 19, 0x2::object::id<Platform>(arg0), arg3);
    }

    entry fun admin_remove_content_tags(arg0: &Platform, arg1: &mut ContentTags, arg2: vector<0x1::string::String>, arg3: &AdminCap, arg4: &mut ChangeShard, arg5: &mut 0x2::tx_context::TxContext) {
        ensure_contract_version(arg0);
        assert_shard_matches(arg0, arg4, arg5);
        let v0 = 0;
        let v1 = 0x1::vector::empty<0x1::string::String>();
        while (v0 < 0x1::vector::length<0x1::string::String>(&arg2)) {
            let v2 = *0x1::vector::borrow<0x1::string::String>(&arg2, v0);
            if (0x2::vec_set::contains<0x1::string::String>(&arg1.list, &v2)) {
                0x2::vec_set::remove<0x1::string::String>(&mut arg1.list, &v2);
                0x1::vector::push_back<0x1::string::String>(&mut v1, v2);
            };
            v0 = v0 + 1;
        };
        if (0x1::vector::length<0x1::string::String>(&v1) > 0) {
            record_object_change(arg4, 21, 0x2::object::id<ContentTags>(arg1), arg5);
        };
    }

    entry fun admin_remove_signaling_server(arg0: &Platform, arg1: &mut SignalingServers, arg2: 0x1::string::String, arg3: &AdminCap, arg4: &mut ChangeShard, arg5: &mut 0x2::tx_context::TxContext) {
        ensure_contract_version(arg0);
        assert_shard_matches(arg0, arg4, arg5);
        if (!0x2::vec_set::contains<0x1::string::String>(&arg1.urls, &arg2)) {
            return
        };
        0x2::vec_set::remove<0x1::string::String>(&mut arg1.urls, &arg2);
        record_object_change(arg4, 22, 0x2::object::id<SignalingServers>(arg1), arg5);
    }

    entry fun admin_set_author_service_disabled(arg0: &Platform, arg1: &mut User, arg2: bool, arg3: &AdminCap, arg4: &mut ChangeShard, arg5: &mut 0x2::tx_context::TxContext) {
        ensure_contract_version(arg0);
        assert_shard_matches(arg0, arg4, arg5);
        if (arg2) {
            assert!(arg1.owner != 0x2::tx_context::sender(arg5), 1099);
        };
        arg1.author_service_disabled = arg2;
        record_admin_disable(6, 0x2::object::id<User>(arg1), arg2, arg4, arg5);
        record_object_change(arg4, 0, 0x2::object::id<User>(arg1), arg5);
    }

    entry fun admin_set_ban_thresholds(arg0: &mut Platform, arg1: u8, arg2: u8, arg3: &AdminCap, arg4: &mut ChangeShard, arg5: &mut 0x2::tx_context::TxContext) {
        ensure_contract_version(arg0);
        assert_shard_matches(arg0, arg4, arg5);
        assert!(arg2 > 0, 1105);
        arg0.complaint.max_closed_chapters_for_banned_work = arg1;
        arg0.work.max_banned_works_for_author = arg2;
        record_object_change(arg4, 19, 0x2::object::id<Platform>(arg0), arg5);
    }

    entry fun admin_set_base_complaint_fee(arg0: &mut Platform, arg1: u64, arg2: &AdminCap, arg3: &mut ChangeShard, arg4: &mut 0x2::tx_context::TxContext) {
        ensure_contract_version(arg0);
        assert_shard_matches(arg0, arg3, arg4);
        arg0.complaint.base_complaint_fee = arg1;
        record_object_change(arg3, 19, 0x2::object::id<Platform>(arg0), arg4);
    }

    entry fun admin_set_complaint_limits(arg0: &mut Platform, arg1: u64, arg2: &AdminCap, arg3: &mut ChangeShard, arg4: &mut 0x2::tx_context::TxContext) {
        ensure_contract_version(arg0);
        assert_shard_matches(arg0, arg3, arg4);
        arg0.complaint.complaint_min_points_total = arg1;
        record_object_change(arg3, 19, 0x2::object::id<Platform>(arg0), arg4);
    }

    entry fun admin_set_complaint_threshold(arg0: &mut Platform, arg1: u64, arg2: &AdminCap, arg3: &mut ChangeShard, arg4: &mut 0x2::tx_context::TxContext) {
        ensure_contract_version(arg0);
        assert_shard_matches(arg0, arg3, arg4);
        arg0.complaint.complaint_threshold = arg1;
        record_object_change(arg3, 19, 0x2::object::id<Platform>(arg0), arg4);
    }

    entry fun admin_set_content_tag_texts(arg0: &Platform, arg1: &ContentTags, arg2: &mut ContentTagText, arg3: 0x1::string::String, arg4: vector<0x1::string::String>, arg5: vector<0x1::string::String>, arg6: &AdminCap, arg7: &mut ChangeShard, arg8: &mut 0x2::tx_context::TxContext) {
        ensure_contract_version(arg0);
        assert_shard_matches(arg0, arg7, arg8);
        assert!(0x2::vec_set::contains<0x1::string::String>(&arg1.list, &arg3), 1059);
        assert!(arg1.content_type == arg2.content_type, 1059);
        assert!(arg2.tag == arg3, 1141);
        assert_tag_text_input(&arg3, &arg4, &arg5);
        upsert_tag_texts(arg2, arg4, arg5);
        record_object_change(arg7, 26, 0x2::object::id<ContentTagText>(arg2), arg8);
    }

    entry fun admin_set_contract_version(arg0: &mut Platform, arg1: &AdminCap, arg2: &mut ChangeShard, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.pending_version == 16, 2025);
        assert_shard_matches(arg0, arg2, arg3);
        arg0.current_version = 16;
        arg0.current_package_id = arg0.pending_package_id;
        arg0.pending_version = 0;
        arg0.pending_package_id = 0x2::object::id_from_address(@0x0);
        record_object_change(arg2, 19, 0x2::object::id<Platform>(arg0), arg3);
    }

    entry fun admin_set_create_dao_without_work_allowed(arg0: &mut Platform, arg1: bool, arg2: &AdminCap, arg3: &mut ChangeShard, arg4: &mut 0x2::tx_context::TxContext) {
        ensure_contract_version(arg0);
        assert_shard_matches(arg0, arg3, arg4);
        arg0.create_dao_without_work_allowed = arg1;
        record_object_change(arg3, 19, 0x2::object::id<Platform>(arg0), arg4);
    }

    entry fun admin_set_dao_disabled(arg0: &Platform, arg1: &mut Dao, arg2: bool, arg3: &AdminCap, arg4: &mut ChangeShard, arg5: &mut 0x2::tx_context::TxContext) {
        ensure_contract_version(arg0);
        assert_shard_matches(arg0, arg4, arg5);
        if (arg2) {
            assert!(arg1.owner != 0x2::tx_context::sender(arg5), 1099);
            assert!(0x2::object::id<Dao>(arg1) != arg0.system_dao_id, 1099);
        };
        arg1.disabled = arg2;
        record_admin_disable(2, 0x2::object::id<Dao>(arg1), arg2, arg4, arg5);
        record_object_change(arg4, 1, 0x2::object::id<Dao>(arg1), arg5);
    }

    entry fun admin_set_denylisted_batch(arg0: &Platform, arg1: &mut PlatformDenyList, arg2: vector<address>, arg3: bool, arg4: &AdminCap, arg5: &mut ChangeShard, arg6: &mut 0x2::tx_context::TxContext) {
        ensure_contract_version(arg0);
        assert_shard_matches(arg0, arg5, arg6);
        let v0 = 0x1::vector::length<address>(&arg2);
        assert!(v0 > 0 && v0 <= 100, 1124);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = *0x1::vector::borrow<address>(&arg2, v1);
            if (arg3) {
                assert!(v2 != 0x2::tx_context::sender(arg6), 1123);
                if (!0x2::dynamic_field::exists<address>(&arg1.id, v2)) {
                    let v3 = GlobalDenylist{dummy_field: false};
                    0x2::dynamic_field::add<address, GlobalDenylist>(&mut arg1.id, v2, v3);
                };
            } else if (0x2::dynamic_field::exists<address>(&arg1.id, v2)) {
                0x2::dynamic_field::remove<address, GlobalDenylist>(&mut arg1.id, v2);
            };
            arg1.denylist_change_seq = arg1.denylist_change_seq + 1;
            let v4 = if (arg3) {
                2
            } else {
                1
            };
            let v5 = PlatformDenylistChanged{
                id     : 0x2::object::new(arg6),
                user   : v2,
                denied : v4,
                seq    : arg1.denylist_change_seq,
            };
            0x2::transfer::share_object<PlatformDenylistChanged>(v5);
            record_object_change(arg5, 9, 0x2::object::id<PlatformDenylistChanged>(&v5), arg6);
            v1 = v1 + 1;
        };
    }

    entry fun admin_set_hosting_provider_disabled(arg0: &Platform, arg1: &mut HostingProvider, arg2: bool, arg3: &AdminCap, arg4: &mut ChangeShard, arg5: &mut 0x2::tx_context::TxContext) {
        ensure_contract_version(arg0);
        assert_shard_matches(arg0, arg4, arg5);
        if (arg2) {
            assert!(arg1.owner != 0x2::tx_context::sender(arg5), 1099);
        };
        arg1.disabled = arg2;
        record_admin_disable(4, 0x2::object::id<HostingProvider>(arg1), arg2, arg4, arg5);
        record_object_change(arg4, 14, 0x2::object::id<HostingProvider>(arg1), arg5);
    }

    entry fun admin_set_min_chapter_publish_interval(arg0: &mut Platform, arg1: u64, arg2: &AdminCap, arg3: &mut ChangeShard, arg4: &mut 0x2::tx_context::TxContext) {
        ensure_contract_version(arg0);
        assert_shard_matches(arg0, arg3, arg4);
        arg0.work.min_chapter_publish_interval_seconds = arg1;
        record_object_change(arg3, 19, 0x2::object::id<Platform>(arg0), arg4);
    }

    entry fun admin_set_node_service_disabled(arg0: &Platform, arg1: &mut User, arg2: bool, arg3: &AdminCap, arg4: &mut ChangeShard, arg5: &mut 0x2::tx_context::TxContext) {
        ensure_contract_version(arg0);
        assert_shard_matches(arg0, arg4, arg5);
        if (arg2) {
            assert!(arg1.owner != 0x2::tx_context::sender(arg5), 1099);
            assert!(arg1.hosting.state == 3, 2022);
        };
        arg1.node_disabled = arg2;
        record_admin_disable(5, 0x2::object::id<User>(arg1), arg2, arg4, arg5);
        record_object_change(arg4, 0, 0x2::object::id<User>(arg1), arg5);
    }

    entry fun admin_set_platform_disabled(arg0: &mut Platform, arg1: bool, arg2: &AdminCap, arg3: &mut ChangeShard, arg4: &mut 0x2::tx_context::TxContext) {
        ensure_contract_version(arg0);
        assert_shard_matches(arg0, arg3, arg4);
        arg0.disabled = arg1;
        record_object_change(arg3, 19, 0x2::object::id<Platform>(arg0), arg4);
    }

    entry fun admin_set_random_outlet_bps(arg0: &mut Platform, arg1: u16, arg2: &AdminCap, arg3: &mut ChangeShard, arg4: &mut 0x2::tx_context::TxContext) {
        ensure_contract_version(arg0);
        assert_shard_matches(arg0, arg3, arg4);
        assert!(arg1 <= 10000, 1125);
        let v0 = RandomOutletBpsKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists<RandomOutletBpsKey>(&arg0.id, v0), 1127);
        let v1 = RandomOutletBpsKey{dummy_field: false};
        *0x2::dynamic_field::borrow_mut<RandomOutletBpsKey, u16>(&mut arg0.id, v1) = arg1;
        record_object_change(arg3, 19, 0x2::object::id<Platform>(arg0), arg4);
    }

    entry fun admin_set_referral_params(arg0: &mut Platform, arg1: u8, arg2: u8, arg3: u16, arg4: u16, arg5: u16, arg6: u16, arg7: u16, arg8: &AdminCap, arg9: &mut ChangeShard, arg10: &mut 0x2::tx_context::TxContext) {
        ensure_contract_version(arg0);
        assert_shard_matches(arg0, arg9, arg10);
        assert!(10000 > arg7, 1061);
        assert!(10000 >= arg3 && arg3 >= arg4, 1061);
        assert!(10000 >= arg5 && arg5 >= arg6, 1061);
        assert!(arg2 >= arg1, 1061);
        assert!(arg3 + arg5 <= 10000, 1061);
        assert!(arg4 + arg6 <= 10000, 1061);
        arg0.referral.referral_window1 = arg1;
        arg0.referral.referral_window2 = arg2;
        arg0.referral.referral_bps1 = arg3;
        arg0.referral.referral_bps2 = arg4;
        arg0.referral.referral_author_bps1 = arg5;
        arg0.referral.referral_author_bps2 = arg6;
        arg0.platform_fee_bps = arg7;
        record_object_change(arg9, 19, 0x2::object::id<Platform>(arg0), arg10);
    }

    entry fun admin_set_registration_mode(arg0: &mut Platform, arg1: u8, arg2: &AdminCap, arg3: &mut ChangeShard, arg4: &mut 0x2::tx_context::TxContext) {
        ensure_contract_version(arg0);
        assert_shard_matches(arg0, arg3, arg4);
        assert!(arg1 <= 2, 2021);
        arg0.registration_mode = arg1;
        record_object_change(arg3, 19, 0x2::object::id<Platform>(arg0), arg4);
    }

    entry fun admin_set_test_data_visible(arg0: &Platform, arg1: &mut TestWalletList, arg2: bool, arg3: &AdminCap, arg4: &mut ChangeShard, arg5: &mut 0x2::tx_context::TxContext) {
        ensure_contract_version(arg0);
        assert_shard_matches(arg0, arg4, arg5);
        arg1.visible = arg2;
        arg1.seq = arg1.seq + 1;
        record_object_change(arg4, 25, 0x2::object::id<TestWalletList>(arg1), arg5);
    }

    entry fun admin_set_test_wallet_batch(arg0: &Platform, arg1: &mut TestWalletList, arg2: vector<address>, arg3: bool, arg4: &AdminCap, arg5: &mut ChangeShard, arg6: &mut 0x2::tx_context::TxContext) {
        ensure_contract_version(arg0);
        assert_shard_matches(arg0, arg5, arg6);
        apply_test_wallet_batch(arg1, arg2, arg3, arg5, arg6);
    }

    entry fun admin_set_work_deposit_amount(arg0: &mut Platform, arg1: u64, arg2: &AdminCap, arg3: &mut ChangeShard, arg4: &mut 0x2::tx_context::TxContext) {
        ensure_contract_version(arg0);
        assert_shard_matches(arg0, arg3, arg4);
        let v0 = WorkDepositAmountKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists<WorkDepositAmountKey>(&arg0.id, v0), 1127);
        if (arg1 > 0) {
            let v1 = WorkDepositRefundSecondsKey{dummy_field: false};
            assert!(0x2::dynamic_field::exists<WorkDepositRefundSecondsKey>(&arg0.id, v1), 1127);
            let v2 = WorkDepositCoinTypeKey{dummy_field: false};
            assert!(0x2::dynamic_field::exists<WorkDepositCoinTypeKey>(&arg0.id, v2), 1127);
            let v3 = WorkDepositRefundSecondsKey{dummy_field: false};
            let v4 = WorkDepositCoinTypeKey{dummy_field: false};
            let v5 = 0x2::dynamic_field::borrow<WorkDepositCoinTypeKey, 0x1::string::String>(&arg0.id, v4);
            assert!(*0x2::dynamic_field::borrow<WorkDepositRefundSecondsKey, u64>(&arg0.id, v3) > 0, 1126);
            assert!(0x1::string::length(v5) > 0, 1126);
        };
        let v6 = WorkDepositAmountKey{dummy_field: false};
        *0x2::dynamic_field::borrow_mut<WorkDepositAmountKey, u64>(&mut arg0.id, v6) = arg1;
        record_object_change(arg3, 19, 0x2::object::id<Platform>(arg0), arg4);
    }

    entry fun admin_set_work_deposit_coin_type(arg0: &mut Platform, arg1: 0x1::string::String, arg2: &AllowedCoins, arg3: &AdminCap, arg4: &mut ChangeShard, arg5: &mut 0x2::tx_context::TxContext) {
        ensure_contract_version(arg0);
        assert_shard_matches(arg0, arg4, arg5);
        assert!(0x2::vec_set::contains<0x1::string::String>(&arg2.symbols, &arg1), 1006);
        let v0 = WorkDepositCoinTypeKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists<WorkDepositCoinTypeKey>(&arg0.id, v0), 1127);
        let v1 = WorkDepositCoinTypeKey{dummy_field: false};
        *0x2::dynamic_field::borrow_mut<WorkDepositCoinTypeKey, 0x1::string::String>(&mut arg0.id, v1) = arg1;
        record_object_change(arg4, 19, 0x2::object::id<Platform>(arg0), arg5);
    }

    entry fun admin_set_work_deposit_refund_seconds(arg0: &mut Platform, arg1: u64, arg2: &AdminCap, arg3: &mut ChangeShard, arg4: &mut 0x2::tx_context::TxContext) {
        ensure_contract_version(arg0);
        assert_shard_matches(arg0, arg3, arg4);
        assert!(arg1 > 0 && arg1 <= 315360000, 1126);
        let v0 = WorkDepositRefundSecondsKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists<WorkDepositRefundSecondsKey>(&arg0.id, v0), 1127);
        let v1 = WorkDepositRefundSecondsKey{dummy_field: false};
        *0x2::dynamic_field::borrow_mut<WorkDepositRefundSecondsKey, u64>(&mut arg0.id, v1) = arg1;
        record_object_change(arg3, 19, 0x2::object::id<Platform>(arg0), arg4);
    }

    entry fun admin_set_work_disabled(arg0: &Platform, arg1: &mut Work, arg2: bool, arg3: &AdminCap, arg4: &mut ChangeShard, arg5: &mut 0x2::tx_context::TxContext) {
        ensure_contract_version(arg0);
        assert_shard_matches(arg0, arg4, arg5);
        if (arg2) {
            assert!(arg1.owner != 0x2::tx_context::sender(arg5), 1099);
        };
        arg1.disabled = arg2;
        record_admin_disable(1, 0x2::object::id<Work>(arg1), arg2, arg4, arg5);
        record_object_change(arg4, 5, 0x2::object::id<Work>(arg1), arg5);
    }

    entry fun admin_update_app_version_notice(arg0: &Platform, arg1: &mut AppVersionNotice, arg2: &AdminCap, arg3: &mut ChangeShard, arg4: u8, arg5: u64, arg6: u64, arg7: u8, arg8: u8, arg9: vector<u8>, arg10: vector<u8>, arg11: &mut 0x2::tx_context::TxContext) {
        ensure_contract_version(arg0);
        assert_shard_matches(arg0, arg3, arg11);
        assert!(arg6 <= arg5, 2031);
        assert!(arg7 <= 2, 2034);
        let v0 = VersionNoticeUrl{
            url_type  : arg8,
            mime_type : arg9,
            url       : arg10,
        };
        let v1 = EndVersionNotice{
            end_type     : arg4,
            latest       : arg5,
            min_required : arg6,
            stop_scope   : arg7,
            notice_url   : v0,
        };
        let v2 = 0;
        let v3 = 0;
        while (v2 < 0x1::vector::length<EndVersionNotice>(&arg1.ends)) {
            if (0x1::vector::borrow<EndVersionNotice>(&arg1.ends, v2).end_type == arg4) {
                let v4 = v3 + 1;
                v3 = v4;
                if (v4 == 1) {
                    *0x1::vector::borrow_mut<EndVersionNotice>(&mut arg1.ends, v2) = v1;
                };
            };
            v2 = v2 + 1;
        };
        assert!(v3 <= 1, 2032);
        if (v3 == 0) {
            0x1::vector::push_back<EndVersionNotice>(&mut arg1.ends, v1);
        };
        record_object_change(arg3, 28, 0x2::object::id<AppVersionNotice>(arg1), arg11);
    }

    entry fun admin_update_user_agreement_content(arg0: &mut Platform, arg1: 0x1::string::String, arg2: &AdminCap, arg3: &mut ChangeShard, arg4: &mut 0x2::tx_context::TxContext) {
        ensure_contract_version(arg0);
        assert_shard_matches(arg0, arg3, arg4);
        arg0.user_agreement_version = arg0.user_agreement_version + 1;
        let v0 = UserAgreementContent{
            id      : 0x2::object::new(arg4),
            content : arg1,
        };
        0x2::dynamic_object_field::add<u8, UserAgreementContent>(&mut arg0.id, arg0.user_agreement_version, v0);
        record_object_change(arg3, 19, 0x2::object::id<Platform>(arg0), arg4);
    }

    entry fun admin_withdraw_platform_with_coin<T0: drop>(arg0: &Platform, arg1: &mut NovelFund<T0>, arg2: &AdminCap, arg3: &mut User, arg4: &0x2::clock::Clock, arg5: &mut ChangeShard, arg6: &mut 0x2::tx_context::TxContext) {
        ensure_contract_version(arg0);
        assert_shard_matches(arg0, arg5, arg6);
        let v0 = 0x2::tx_context::sender(arg6);
        assert!(v0 == arg3.owner, 1032);
        assert!(arg1.dao_id == 0x2::object::id_from_address(@0x0), 1065);
        let v1 = PlatformFundKey{dummy_field: false};
        assert!(0x2::object::id<NovelFund<T0>>(arg1) == *0x2::table::borrow<0x1::string::String, 0x2::object::ID>(&0x2::dynamic_object_field::borrow<PlatformFundKey, FundShares>(&arg0.id, v1).fund_coin_seqs, fund_coin_key(b"platform", coin_type_from_type<T0>())), 1065);
        let v2 = arg1.owner;
        let v3 = platform_fund_claim<T0>(arg0, arg1, v2);
        record_object_change(arg5, 3, 0x2::object::id<NovelFund<T0>>(arg1), arg6);
        let v4 = 0x2::balance::value<T0>(&v3);
        if (v4 == 0) {
            0x2::balance::destroy_zero<T0>(v3);
            return
        };
        let v5 = 0x2::object::id<NovelFund<T0>>(arg1);
        let v6 = 0x2::object::id_from_address(@0x0);
        let v7 = empty_string();
        let v8 = FinancialPart{
            part_type   : 1,
            wallet_addr : @0x0,
            obj_id      : v5,
        };
        let v9 = FinancialPart{
            part_type   : 0,
            wallet_addr : v0,
            obj_id      : v6,
        };
        create_dual_financial_record(4, 0, v8, v9, coin_type_from_type<T0>(), arg1.coin_decimals, v4, v5, 0, v6, 0x2::clock::timestamp_ms(arg4) / 1000, v7, v7, 0x2::object::id<NovelFund<T0>>(arg1), 0x2::object::id<User>(arg3), arg5, arg6, 0);
        if (0x2::balance::value<T0>(&v3) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v3, arg6), v0);
        } else {
            0x2::balance::destroy_zero<T0>(v3);
        };
    }

    entry fun announce_contract_upgrade(arg0: &mut Platform, arg1: u64, arg2: 0x2::object::ID, arg3: &AdminCap, arg4: &mut ChangeShard, arg5: &mut 0x2::tx_context::TxContext) {
        ensure_contract_version(arg0);
        assert!(arg1 > arg0.current_version, 2026);
        assert!(arg2 != 0x2::object::id_from_address(@0x0), 2026);
        assert_shard_matches(arg0, arg4, arg5);
        arg0.pending_version = arg1;
        arg0.pending_package_id = arg2;
        record_object_change(arg4, 19, 0x2::object::id<Platform>(arg0), arg5);
    }

    entry fun apply_dao_member(arg0: &mut Platform, arg1: &PlatformDenyList, arg2: &mut Dao, arg3: &User, arg4: &mut User, arg5: vector<u8>, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: &mut ChangeShard, arg9: &mut 0x2::tx_context::TxContext) {
        ensure_contract_version(arg0);
        assert_shard_matches(arg0, arg8, arg9);
        assert!(!arg0.disabled, 1091);
        let v0 = 0x2::tx_context::sender(arg9);
        assert!(!0x2::dynamic_field::exists<address>(&arg1.id, v0), 1021);
        assert!(!0x2::dynamic_field::exists<address>(&arg1.id, arg3.owner), 1021);
        let v1 = DaoDenylistKey{user: v0};
        assert!(!0x2::dynamic_field::exists<DaoDenylistKey>(&arg2.id, v1), 1021);
        assert!(v0 == arg4.owner, 1032);
        assert!(arg2.owner == arg3.owner, 1009);
        assert!(!arg2.disabled, 1043);
        assert!(arg2.member_policy.fee_required == 0, 1053);
        verify_dao_private_invite(arg2, arg3, arg5, arg6, arg7, arg9);
        let v2 = 0x2::clock::timestamp_ms(arg7) / 1000;
        assert!(!dao_member_is_valid(arg2, v0, v2), 1054);
        consume_dao_join_points(arg0, arg2, arg4, v2, arg8, arg9);
        let v3 = DaoMember{member: v0};
        if (0x2::dynamic_field::exists<DaoMember>(&arg2.id, v3)) {
            let v4 = DaoMember{member: v0};
            0x2::dynamic_field::borrow_mut<DaoMember, DaoMemberData>(&mut arg2.id, v4).joined_at = v2;
        } else {
            let v5 = DaoMember{member: v0};
            let v6 = DaoMemberData{joined_at: v2};
            0x2::dynamic_field::add<DaoMember, DaoMemberData>(&mut arg2.id, v5, v6);
        };
        create_dao_member_changed(arg2, arg8, v0, 0, 0x1::string::utf8(b""), v0, v2, arg9);
    }

    entry fun apply_dao_member_with_coin<T0: drop>(arg0: &mut Platform, arg1: &PlatformDenyList, arg2: &mut Dao, arg3: &User, arg4: &mut User, arg5: 0x2::coin::Coin<T0>, arg6: vector<u8>, arg7: vector<u8>, arg8: &AllowedCoins, arg9: &mut NovelFund<T0>, arg10: &mut NovelFund<T0>, arg11: &0x2::clock::Clock, arg12: &mut ChangeShard, arg13: &mut 0x2::tx_context::TxContext) {
        ensure_contract_version(arg0);
        assert_shard_matches(arg0, arg12, arg13);
        assert!(!arg0.disabled, 1091);
        let v0 = 0x2::tx_context::sender(arg13);
        assert!(!0x2::dynamic_field::exists<address>(&arg1.id, v0), 1021);
        assert!(!0x2::dynamic_field::exists<address>(&arg1.id, arg3.owner), 1021);
        let v1 = DaoDenylistKey{user: v0};
        assert!(!0x2::dynamic_field::exists<DaoDenylistKey>(&arg2.id, v1), 1021);
        assert!(v0 == arg4.owner, 1032);
        assert!(arg2.owner == arg3.owner, 1009);
        assert!(!arg2.disabled, 1043);
        assert!(arg2.member_policy.fee_required > 0, 1053);
        verify_dao_private_invite(arg2, arg3, arg6, arg7, arg11, arg13);
        let v2 = 0x2::clock::timestamp_ms(arg11) / 1000;
        assert!(!dao_member_is_valid(arg2, v0, v2), 1054);
        consume_dao_join_points(arg0, arg2, arg4, v2, arg12, arg13);
        let v3 = coin_type_from_type<T0>();
        assert!(0x2::vec_set::contains<0x1::string::String>(&arg8.symbols, &v3), 1006);
        assert!(arg2.member_policy.fee_coin_type == v3, 1006);
        assert!(0x2::coin::value<T0>(&arg5) == arg2.member_policy.fee_required, 1008);
        assert!(arg10.owner == arg2.owner, 1035);
        let v4 = AuthorFundKey{dummy_field: false};
        assert!(0x2::object::id<NovelFund<T0>>(arg10) == *0x2::table::borrow<0x1::string::String, 0x2::object::ID>(&0x2::dynamic_object_field::borrow<AuthorFundKey, FundShares>(&arg2.id, v4).fund_coin_seqs, fund_coin_key(b"team", v3)), 1073);
        let v5 = PlatformFundKey{dummy_field: false};
        assert!(0x2::object::id<NovelFund<T0>>(arg9) == *0x2::table::borrow<0x1::string::String, 0x2::object::ID>(&0x2::dynamic_object_field::borrow<PlatformFundKey, FundShares>(&arg0.id, v5).fund_coin_seqs, fund_coin_key(b"platform", v3)), 1065);
        let v6 = bps_of(arg2.member_policy.fee_required, arg0.platform_fee_bps);
        let v7 = 0x2::coin::into_balance<T0>(arg5);
        platform_deposit<T0>(arg0, arg9, 0x2::balance::split<T0>(&mut v7, v6));
        record_object_change(arg12, 3, 0x2::object::id<NovelFund<T0>>(arg9), arg13);
        let v8 = dao_deposit<T0>(arg2, arg10, v7);
        record_object_change(arg12, 3, 0x2::object::id<NovelFund<T0>>(arg10), arg13);
        let v9 = DaoMember{member: v0};
        if (0x2::dynamic_field::exists<DaoMember>(&arg2.id, v9)) {
            let v10 = DaoMember{member: v0};
            0x2::dynamic_field::borrow_mut<DaoMember, DaoMemberData>(&mut arg2.id, v10).joined_at = v2;
        } else {
            let v11 = DaoMember{member: v0};
            let v12 = DaoMemberData{joined_at: v2};
            0x2::dynamic_field::add<DaoMember, DaoMemberData>(&mut arg2.id, v11, v12);
        };
        create_dao_member_changed(arg2, arg12, v0, 0, 0x1::string::utf8(b""), v0, v2, arg13);
        let v13 = 0x2::object::id<Dao>(arg2);
        let v14 = 0x2::object::id_from_address(@0x0);
        let v15 = @0x0;
        let v16 = empty_string();
        let v17 = 0x2::object::id<NovelFund<T0>>(arg10);
        let v18 = FinancialPart{
            part_type   : 0,
            wallet_addr : v0,
            obj_id      : v14,
        };
        let v19 = FinancialPart{
            part_type   : 1,
            wallet_addr : v15,
            obj_id      : v17,
        };
        create_financial_record(2, 0, v18, v19, v3, arg10.coin_decimals, arg2.member_policy.fee_required, v13, 0, v14, v2, v16, v16, 0x2::object::id<User>(arg4), arg12, arg13, current_dao_fund_member_seq(arg2));
        let v20 = FinancialPart{
            part_type   : 0,
            wallet_addr : v0,
            obj_id      : v14,
        };
        let v21 = FinancialPart{
            part_type   : 1,
            wallet_addr : v15,
            obj_id      : v17,
        };
        create_financial_record(2, 1, v20, v21, v3, arg10.coin_decimals, v8, v13, 0, v14, v2, v16, v16, 0x2::object::id<NovelFund<T0>>(arg10), arg12, arg13, current_dao_fund_member_seq(arg2));
        let v22 = FinancialPart{
            part_type   : 0,
            wallet_addr : v0,
            obj_id      : v14,
        };
        let v23 = FinancialPart{
            part_type   : 1,
            wallet_addr : v15,
            obj_id      : 0x2::object::id<NovelFund<T0>>(arg9),
        };
        create_financial_record(2, 2, v22, v23, v3, arg9.coin_decimals, v6, v13, 0, v14, v2, v16, v16, 0x2::object::id<NovelFund<T0>>(arg9), arg12, arg13, 0);
    }

    fun apply_test_wallet_batch(arg0: &mut TestWalletList, arg1: vector<address>, arg2: bool, arg3: &mut ChangeShard, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<address>(&arg1);
        assert!(v0 > 0 && v0 <= 100, 1130);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = *0x1::vector::borrow<address>(&arg1, v1);
            if (arg2) {
                if (!0x2::dynamic_field::exists<address>(&arg0.id, v2)) {
                    let v3 = GlobalDenylist{dummy_field: false};
                    0x2::dynamic_field::add<address, GlobalDenylist>(&mut arg0.id, v2, v3);
                };
            } else if (0x2::dynamic_field::exists<address>(&arg0.id, v2)) {
                0x2::dynamic_field::remove<address, GlobalDenylist>(&mut arg0.id, v2);
            };
            arg0.seq = arg0.seq + 1;
            let v4 = if (arg2) {
                1
            } else {
                2
            };
            let v5 = TestWalletChanged{
                id    : 0x2::object::new(arg4),
                user  : v2,
                state : v4,
                seq   : arg0.seq,
            };
            0x2::transfer::share_object<TestWalletChanged>(v5);
            record_object_change(arg3, 24, 0x2::object::id<TestWalletChanged>(&v5), arg4);
            v1 = v1 + 1;
        };
    }

    fun apply_user_profile_fields(arg0: &mut User, arg1: &mut Registry, arg2: 0x1::string::String, arg3: 0x1::string::String) {
        if (0x1::string::length(&arg2) > 0) {
            arg0.name = update_registered_name(arg1, &arg0.name, arg2, arg0.owner);
        };
        if (0x1::string::length(&arg3) > 0) {
            arg0.intro = arg3;
        };
    }

    fun assert_app_version_notice_not_created(arg0: &Platform) {
        let v0 = AppVersionNoticeKey{dummy_field: false};
        assert!(!0x2::derived_object::exists<AppVersionNoticeKey>(&arg0.id, v0), 2033);
    }

    fun assert_chapter_payment_common<T0: drop>(arg0: &Platform, arg1: &PlatformDenyList, arg2: &AllowedCoins, arg3: &User, arg4: &Dao, arg5: &User, arg6: &Work, arg7: &NovelFund<T0>, arg8: &NovelFund<T0>, arg9: &Chapter, arg10: u8, arg11: u64, arg12: &0x2::clock::Clock, arg13: address) : (u64, 0x1::string::String, bool) {
        assert!(!0x2::dynamic_field::exists<address>(&arg1.id, arg5.owner), 1021);
        assert!(!0x2::dynamic_field::exists<address>(&arg1.id, arg3.owner), 1021);
        let v0 = DaoDenylistKey{user: arg5.owner};
        assert!(!0x2::dynamic_field::exists<DaoDenylistKey>(&arg4.id, v0), 1021);
        assert!(!arg0.disabled, 1091);
        assert!(!arg4.disabled, 1043);
        assert!(!arg6.disabled, 1045);
        assert!(!arg5.page_key_paused, 1070);
        ensure_auto_wallet_sender(arg5, arg13);
        let v1 = 0x2::clock::timestamp_ms(arg12) / 1000;
        let v2 = coin_type_from_type<T0>();
        assert!(0x2::vec_set::contains<0x1::string::String>(&arg2.symbols, &v2), 1006);
        assert!(arg9.coin_type == v2, 1006);
        assert!(arg9.coin_decimals == arg10, 1008);
        let v3 = if (arg9.policy == 4) {
            let v4 = ChapterMemberPriceKey{dummy_field: false};
            assert!(0x2::dynamic_field::exists<ChapterMemberPriceKey>(&arg9.id, v4), 1056);
            let v5 = ChapterMemberPriceKey{dummy_field: false};
            if (dao_member_is_valid(arg4, arg5.owner, v1)) {
                *0x2::dynamic_field::borrow<ChapterMemberPriceKey, u64>(&arg9.id, v5)
            } else {
                arg9.price
            }
        } else {
            arg9.price
        };
        assert!(arg11 == v3, 1008);
        assert!(arg3.owner == arg9.owner, 1009);
        assert!(0x2::dynamic_field::exists<0x2::object::ID>(&arg3.id, arg9.work_id), 1033);
        assert!(arg4.owner == arg3.owner, 1009);
        assert!(0x2::object::id<Dao>(arg4) == arg6.dao_id, 1009);
        assert!(0x2::object::id<Work>(arg6) == arg9.work_id, 1001);
        assert!(!arg6.banned, 1004);
        assert!(!arg9.banned, 1100);
        assert!(arg9.price > 0, 1057);
        assert!(arg5.owner != arg3.owner, 1057);
        if (arg9.policy == 3) {
            assert!(dao_member_is_valid(arg4, arg5.owner, v1), 1036);
        } else if (arg9.policy == 1) {
            assert!(!dao_member_is_valid(arg4, arg5.owner, v1), 1057);
        };
        assert!(!0x2::dynamic_field::exists<0x2::object::ID>(&arg5.id, 0x2::object::id<Chapter>(arg9)), 1074);
        assert!(arg8.owner == arg9.owner, 1035);
        let v6 = AuthorFundKey{dummy_field: false};
        assert!(0x2::object::id<NovelFund<T0>>(arg8) == *0x2::table::borrow<0x1::string::String, 0x2::object::ID>(&0x2::dynamic_object_field::borrow<AuthorFundKey, FundShares>(&arg4.id, v6).fund_coin_seqs, fund_coin_key(b"team", coin_type_from_type<T0>())), 1073);
        let v7 = PlatformFundKey{dummy_field: false};
        assert!(0x2::object::id<NovelFund<T0>>(arg7) == *0x2::table::borrow<0x1::string::String, 0x2::object::ID>(&0x2::dynamic_object_field::borrow<PlatformFundKey, FundShares>(&arg0.id, v7).fund_coin_seqs, fund_coin_key(b"platform", coin_type_from_type<T0>())), 1065);
        (v1, v2, !0x2::dynamic_field::exists<address>(&arg6.id, arg5.owner))
    }

    fun assert_fund_pool_set_unchanged(arg0: &Dao, arg1: u64) {
        let v0 = AuthorFundKey{dummy_field: false};
        assert!(0x2::table::length<0x1::string::String, 0x2::object::ID>(&0x2::dynamic_object_field::borrow<AuthorFundKey, FundShares>(&arg0.id, v0).fund_coin_seqs) == arg1, 2030);
    }

    fun assert_shard_matches(arg0: &Platform, arg1: &ChangeShard, arg2: &0x2::tx_context::TxContext) {
        assert!((arg1.shard_index as u64) == ((0x2::address::to_u256(0x2::tx_context::sender(arg2)) % (0x1::vector::length<0x2::object::ID>(&arg0.change_shard_ids) as u256)) as u64), 2019);
    }

    fun assert_share_target_allowed(arg0: &PlatformDenyList, arg1: &Dao, arg2: address) {
        assert!(!0x2::dynamic_field::exists<address>(&arg0.id, arg2), 1021);
        let v0 = DaoDenylistKey{user: arg2};
        assert!(!0x2::dynamic_field::exists<DaoDenylistKey>(&arg1.id, v0), 1021);
        assert!(arg2 != arg1.owner, 1114);
    }

    fun assert_tag_text_input(arg0: &0x1::string::String, arg1: &vector<0x1::string::String>, arg2: &vector<0x1::string::String>) {
        assert!(0x1::string::length(arg0) > 0, 1137);
        assert!(0x1::string::length(arg0) <= 64, 1140);
        assert!(0x1::vector::length<0x1::string::String>(arg1) == 0x1::vector::length<0x1::string::String>(arg2), 1135);
        assert!(0x1::vector::length<0x1::string::String>(arg1) > 0, 1137);
        assert!(0x1::vector::length<0x1::string::String>(arg1) <= 64, 1136);
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1::string::String>(arg1)) {
            assert!(0x1::string::length(0x1::vector::borrow<0x1::string::String>(arg1, v0)) > 0, 1137);
            assert!(0x1::string::length(0x1::vector::borrow<0x1::string::String>(arg2, v0)) > 0, 1137);
            assert!(0x1::string::length(0x1::vector::borrow<0x1::string::String>(arg2, v0)) <= 64, 1138);
            let v1 = v0 + 1;
            while (v1 < 0x1::vector::length<0x1::string::String>(arg1)) {
                assert!(*0x1::vector::borrow<0x1::string::String>(arg1, v0) != *0x1::vector::borrow<0x1::string::String>(arg1, v1), 1139);
                v1 = v1 + 1;
            };
            v0 = v0 + 1;
        };
    }

    fun assert_test_wallet_list_not_created(arg0: &Platform) {
        let v0 = TestWalletListKey{dummy_field: false};
        assert!(!0x2::derived_object::exists<TestWalletListKey>(&arg0.id, v0), 1132);
    }

    fun author_referral_fee_from_platform_fee(arg0: &Platform, arg1: &User, arg2: u64, arg3: u64) : u64 {
        if (!has_valid_referrer(arg1)) {
            return 0
        };
        let v0 = arg1.referral_time;
        let v1 = if (arg2 > v0) {
            arg2 - v0
        } else {
            0
        };
        bps_of(arg3, resolve_referral_window_bps((arg0.referral.referral_window1 as u64), (arg0.referral.referral_window2 as u64), arg0.referral.referral_author_bps1, arg0.referral.referral_author_bps2, v1))
    }

    entry fun author_withdraw_with_coin<T0: drop>(arg0: &Platform, arg1: &PlatformDenyList, arg2: &mut Dao, arg3: UserCap, arg4: &mut User, arg5: &mut NovelFund<T0>, arg6: &0x2::clock::Clock, arg7: &mut ChangeShard, arg8: &mut 0x2::tx_context::TxContext) {
        ensure_contract_version(arg0);
        assert_shard_matches(arg0, arg7, arg8);
        assert!(!arg0.disabled, 1091);
        let v0 = 0x2::tx_context::sender(arg8);
        assert!(!0x2::dynamic_field::exists<address>(&arg1.id, v0), 1021);
        assert!(arg5.dao_id == 0x2::object::id<Dao>(arg2), 1065);
        assert!(!arg2.disabled, 1043);
        let v1 = DaoDenylistKey{user: arg4.owner};
        assert!(!0x2::dynamic_field::exists<DaoDenylistKey>(&arg2.id, v1), 1021);
        assert!(arg5.owner == arg4.owner, 1035);
        assert!(arg3.owner != @0x0, 1069);
        assert!(arg3.owner == arg4.owner, 1068);
        let v2 = AuthorFundKey{dummy_field: false};
        let v3 = fund_claim<T0>(0x2::dynamic_object_field::borrow_mut<AuthorFundKey, FundShares>(&mut arg2.id, v2), arg5, arg4.owner);
        record_object_change(arg7, 3, 0x2::object::id<NovelFund<T0>>(arg5), arg8);
        if (0x2::balance::value<T0>(&v3) == 0) {
            0x2::balance::destroy_zero<T0>(v3);
            0x2::transfer::transfer<UserCap>(arg3, v0);
            return
        };
        let v4 = 0x2::object::id_from_address(@0x0);
        let v5 = empty_string();
        let v6 = FinancialPart{
            part_type   : 1,
            wallet_addr : @0x0,
            obj_id      : 0x2::object::id<NovelFund<T0>>(arg5),
        };
        let v7 = FinancialPart{
            part_type   : 0,
            wallet_addr : v0,
            obj_id      : v4,
        };
        create_dual_financial_record(5, 0, v6, v7, coin_type_from_type<T0>(), arg5.coin_decimals, 0x2::balance::value<T0>(&v3), 0x2::object::id<User>(arg4), 0, v4, 0x2::clock::timestamp_ms(arg6) / 1000, v5, v5, 0x2::object::id<NovelFund<T0>>(arg5), 0x2::object::id<User>(arg4), arg7, arg8, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v3, arg8), v0);
        0x2::transfer::transfer<UserCap>(arg3, v0);
    }

    public fun begin_fund_settle(arg0: &Platform, arg1: &PlatformDenyList, arg2: &mut Dao, arg3: &User, arg4: u8, arg5: &mut ChangeShard, arg6: &mut 0x2::tx_context::TxContext) : SettleTicket {
        ensure_contract_version(arg0);
        assert_shard_matches(arg0, arg5, arg6);
        assert!(!arg0.disabled, 1091);
        assert!(!0x2::dynamic_field::exists<address>(&arg1.id, 0x2::tx_context::sender(arg6)), 1021);
        assert!(arg4 == 3 || arg4 == 4, 1117);
        if (arg4 == 3) {
            assert!(0x2::tx_context::sender(arg6) == arg2.owner, 1104);
        } else {
            assert!(0x2::tx_context::sender(arg6) == arg3.owner, 1032);
        };
        assert!(!arg2.disabled, 1043);
        assert!(arg3.owner != arg2.owner, 1114);
        if (arg4 == 4) {
            let v0 = DaoDenylistKey{user: arg3.owner};
            assert!(!0x2::dynamic_field::exists<DaoDenylistKey>(&arg2.id, v0), 1021);
        };
        let v1 = AuthorFundKey{dummy_field: false};
        let v2 = 0x2::dynamic_object_field::borrow<AuthorFundKey, FundShares>(&arg2.id, v1);
        ledger_assert_has_share(v2, arg3.owner);
        SettleTicket{
            dao_id   : 0x2::object::id<Dao>(arg2),
            member   : arg3.owner,
            expected : 0x2::table::length<0x1::string::String, 0x2::object::ID>(&v2.fund_coin_seqs),
            done     : 0,
            action   : arg4,
            settled  : 0x1::vector::empty<0x2::object::ID>(),
        }
    }

    public fun begin_share_settle(arg0: &Platform, arg1: &PlatformDenyList, arg2: &mut Dao, arg3: &User, arg4: &User, arg5: u8, arg6: 0x1::string::String, arg7: u64, arg8: &mut ChangeShard, arg9: &mut 0x2::tx_context::TxContext) : ShareChangeTicket {
        ensure_contract_version(arg0);
        assert_shard_matches(arg0, arg8, arg9);
        assert!(!arg0.disabled, 1091);
        let v0 = 0x2::tx_context::sender(arg9);
        assert!(!0x2::dynamic_field::exists<address>(&arg1.id, v0), 1021);
        assert!(arg5 == 1 || arg5 == 2, 1117);
        assert!(v0 == arg2.owner, 1104);
        assert!(arg3.owner == arg2.owner, 1104);
        assert!(!arg2.disabled, 1043);
        assert_share_target_allowed(arg1, arg2, arg4.owner);
        assert!(arg7 > 0, 1008);
        ensure_author_fund_ledger(arg2, arg8, arg9);
        let v1 = AuthorFundKey{dummy_field: false};
        let v2 = 0x2::dynamic_object_field::borrow<AuthorFundKey, FundShares>(&arg2.id, v1);
        if (arg5 == 2) {
            ledger_assert_has_share(v2, arg4.owner);
        } else {
            assert!(ledger_share(v2, arg4.owner) == 0, 1143);
            assert!(arg7 < ledger_share(v2, arg2.owner), 1118);
        };
        ShareChangeTicket{
            dao_id        : 0x2::object::id<Dao>(arg2),
            member        : arg4.owner,
            expected      : 0x2::table::length<0x1::string::String, 0x2::object::ID>(&v2.fund_coin_seqs),
            done          : 0,
            action        : arg5,
            amount        : arg7,
            role          : arg6,
            author_obj_id : 0x2::object::id<User>(arg3),
            settled       : 0x1::vector::empty<0x2::object::ID>(),
        }
    }

    fun bps_of(arg0: u64, arg1: u16) : u64 {
        (((arg0 as u128) * (arg1 as u128) / 10000) as u64)
    }

    entry fun cancel_hosting_agreement(arg0: &Platform, arg1: &PlatformDenyList, arg2: &mut AuthorHostingAgreement, arg3: &mut SelfHostedNode, arg4: &mut User, arg5: &mut ChangeShard, arg6: &mut 0x2::tx_context::TxContext) {
        ensure_contract_version(arg0);
        assert_shard_matches(arg0, arg5, arg6);
        assert!(!arg0.disabled, 1091);
        assert!(!0x2::dynamic_field::exists<address>(&arg1.id, 0x2::tx_context::sender(arg6)), 1021);
        assert!(arg4.owner == 0x2::tx_context::sender(arg6), 1032);
        assert!(arg2.author == 0x2::tx_context::sender(arg6), 1032);
        assert!(arg2.suspension_state == 2, 2007);
        assert!(arg4.hosting.state == 2, 2007);
        assert!(arg2.node_id == 0x2::object::id<SelfHostedNode>(arg3), 2008);
        arg2.active = false;
        arg3.active_agreement_count = arg3.active_agreement_count - 1;
        arg2.suspension_state = 0;
        arg4.hosting.state = 0;
        arg4.hosting.provider = @0x0;
        record_object_change(arg5, 4, 0x2::object::id<AuthorHostingAgreement>(arg2), arg6);
        record_object_change(arg5, 0, 0x2::object::id<User>(arg4), arg6);
        record_object_change(arg5, 2, 0x2::object::id<SelfHostedNode>(arg3), arg6);
    }

    public fun change_shard_count(arg0: &Platform) : u64 {
        ensure_contract_version(arg0);
        0x1::vector::length<0x2::object::ID>(&arg0.change_shard_ids)
    }

    fun chapter_policy_assert_price_match(arg0: u64, arg1: u8, arg2: u64) {
        if (arg1 == 0 || arg1 == 2) {
            assert!(arg0 == 0, 1056);
            return
        };
        if (arg1 == 1 || arg1 == 3) {
            assert!(arg0 > 0, 1056);
            return
        };
        assert!(arg1 == 4, 1055);
        assert!(arg0 > 0, 1056);
        assert!(arg2 > 0 && arg2 < arg0, 1056);
    }

    fun chapter_read_permission(arg0: &Dao, arg1: &Chapter, arg2: &User, arg3: u64) : bool {
        if (arg1.policy == 0) {
            return true
        };
        arg1.policy == 1 && (dao_member_is_valid(arg0, arg2.owner, arg3) || 0x2::dynamic_field::exists<0x2::object::ID>(&arg2.id, 0x2::object::id<Chapter>(arg1))) || arg1.policy == 2 && dao_member_is_valid(arg0, arg2.owner, arg3) || arg1.policy == 3 && dao_member_is_valid(arg0, arg2.owner, arg3) && 0x2::dynamic_field::exists<0x2::object::ID>(&arg2.id, 0x2::object::id<Chapter>(arg1)) || arg1.policy == 4 && 0x2::dynamic_field::exists<0x2::object::ID>(&arg2.id, 0x2::object::id<Chapter>(arg1))
    }

    entry fun chapter_update_content_v2(arg0: &Platform, arg1: &PlatformDenyList, arg2: &User, arg3: &mut Chapter, arg4: &mut ChapterContent, arg5: vector<u8>, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: &mut ChangeShard, arg9: &mut 0x2::tx_context::TxContext) {
        ensure_contract_version(arg0);
        assert_shard_matches(arg0, arg8, arg9);
        assert!(!arg0.disabled, 1091);
        let v0 = 0x2::tx_context::sender(arg9);
        assert!(!0x2::dynamic_field::exists<address>(&arg1.id, v0), 1021);
        assert!(!0x2::dynamic_field::exists<address>(&arg1.id, arg2.owner), 1021);
        ensure_auto_wallet_sender(arg2, v0);
        assert!(!arg2.page_key_paused, 1070);
        assert!(arg3.owner == arg2.owner, 1009);
        assert!(!arg3.banned, 1004);
        assert!(arg4.owner == arg2.owner, 1009);
        assert!(arg4.work_id == arg3.work_id, 1009);
        assert!(arg4.chapter_uuid == arg3.uuid, 1009);
        assert!(0x1::vector::length<u8>(&arg5) > 0, 1031);
        assert!(0x1::vector::length<u8>(0x1::string::as_bytes(&arg6)) > 0, 1031);
        arg4.bytes = arg5;
        arg4.mime_type = 0x1::string::utf8(*0x1::string::as_bytes(&arg7));
        arg3.preview = arg6;
        record_object_change(arg8, 16, 0x2::object::id<ChapterContent>(arg4), arg9);
        record_object_change(arg8, 6, 0x2::object::id<Chapter>(arg3), arg9);
    }

    fun charge_work_deposit<T0: drop>(arg0: &Platform, arg1: &AllowedCoins, arg2: address, arg3: 0x1::option::Option<0x2::coin::Coin<T0>>, arg4: 0x2::object::ID, arg5: u64, arg6: &mut ChangeShard, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = WorkDepositAmountKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists<WorkDepositAmountKey>(&arg0.id, v0), 1127);
        let v1 = WorkDepositAmountKey{dummy_field: false};
        let v2 = *0x2::dynamic_field::borrow<WorkDepositAmountKey, u64>(&arg0.id, v1);
        if (v2 == 0) {
            assert!(0x1::option::is_none<0x2::coin::Coin<T0>>(&arg3), 1008);
            0x1::option::destroy_none<0x2::coin::Coin<T0>>(arg3);
            return
        };
        let v3 = WorkDepositRefundSecondsKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists<WorkDepositRefundSecondsKey>(&arg0.id, v3), 1127);
        let v4 = WorkDepositCoinTypeKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists<WorkDepositCoinTypeKey>(&arg0.id, v4), 1127);
        let v5 = WorkDepositRefundSecondsKey{dummy_field: false};
        let v6 = WorkDepositCoinTypeKey{dummy_field: false};
        let v7 = *0x2::dynamic_field::borrow<WorkDepositCoinTypeKey, 0x1::string::String>(&arg0.id, v6);
        let v8 = coin_type_from_type<T0>();
        assert!(v8 == v7, 1006);
        assert!(0x2::vec_set::contains<0x1::string::String>(&arg1.symbols, &v7), 1006);
        assert!(0x1::option::is_some<0x2::coin::Coin<T0>>(&arg3), 1008);
        let v9 = 0x1::option::extract<0x2::coin::Coin<T0>>(&mut arg3);
        0x1::option::destroy_none<0x2::coin::Coin<T0>>(arg3);
        assert!(0x2::coin::value<T0>(&v9) == v2, 1008);
        let v10 = WorkDeposit<T0>{
            id        : 0x2::object::new(arg7),
            balance   : 0x1::option::some<0x2::balance::Balance<T0>>(0x2::coin::into_balance<T0>(v9)),
            coin_type : v8,
            amount    : v2,
            withdrawn : false,
            unlock_at : arg5 + *0x2::dynamic_field::borrow<WorkDepositRefundSecondsKey, u64>(&arg0.id, v5),
            work_id   : arg4,
        };
        0x2::transfer::transfer<WorkDeposit<T0>>(v10, arg2);
        record_object_change(arg6, 23, 0x2::object::id<WorkDeposit<T0>>(&v10), arg7);
    }

    fun check_and_register_name(arg0: &mut Registry, arg1: 0x1::string::String, arg2: address) : 0x1::string::String {
        let v0 = normalize_name(arg1);
        if (0x1::string::length(&v0) > 0) {
            let v1 = NameKey{name: v0};
            assert!(!0x2::dynamic_field::exists<NameKey>(&arg0.id, v1), 1084);
            let v2 = NameKey{name: v0};
            0x2::dynamic_field::add<NameKey, address>(&mut arg0.id, v2, arg2);
        };
        v0
    }

    public fun check_member_status(arg0: &Platform, arg1: &PlatformDenyList, arg2: &Dao, arg3: address, arg4: &0x2::clock::Clock) : (bool, u64) {
        ensure_contract_version(arg0);
        let v0 = 0x2::clock::timestamp_ms(arg4) / 1000;
        if (0x2::dynamic_field::exists<address>(&arg1.id, arg3)) {
            return (false, v0)
        };
        let v1 = DaoDenylistKey{user: arg3};
        if (0x2::dynamic_field::exists<DaoDenylistKey>(&arg2.id, v1)) {
            return (false, v0)
        };
        (dao_member_is_valid(arg2, arg3, v0), v0)
    }

    entry fun claim_pending_payout<T0: drop>(arg0: &Platform, arg1: &PlatformDenyList, arg2: &mut PendingPayout<T0>, arg3: &Dao, arg4: &User, arg5: &0x2::clock::Clock, arg6: &mut ChangeShard, arg7: &mut 0x2::tx_context::TxContext) {
        ensure_contract_version(arg0);
        assert_shard_matches(arg0, arg6, arg7);
        assert!(!arg0.disabled, 1091);
        let v0 = 0x2::tx_context::sender(arg7);
        assert!(v0 == arg2.member, 1032);
        assert!(0x2::object::id<Dao>(arg3) == arg2.dao_id, 1133);
        assert!(arg4.owner == arg2.member, 1032);
        assert!(!0x2::dynamic_field::exists<address>(&arg1.id, v0), 1021);
        let v1 = DaoDenylistKey{user: v0};
        assert!(!0x2::dynamic_field::exists<DaoDenylistKey>(&arg3.id, v1), 1021);
        assert!(!arg2.claimed, 2029);
        assert!(0x1::option::is_some<0x2::balance::Balance<T0>>(&arg2.balance), 2029);
        arg2.claimed = true;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x1::option::extract<0x2::balance::Balance<T0>>(&mut arg2.balance), arg7), v0);
        record_object_change(arg6, 27, 0x2::object::id<PendingPayout<T0>>(arg2), arg7);
        let v2 = 0x2::object::id<PendingPayout<T0>>(arg2);
        let v3 = FinancialPart{
            part_type   : 3,
            wallet_addr : arg2.member,
            obj_id      : v2,
        };
        let v4 = FinancialPart{
            part_type   : 0,
            wallet_addr : arg2.member,
            obj_id      : 0x2::object::id_from_address(@0x0),
        };
        create_financial_record(5, 0, v3, v4, string_clone(&arg2.coin_type), arg2.coin_decimals, arg2.amount, arg2.fund_id, 0, v2, 0x2::clock::timestamp_ms(arg5) / 1000, empty_string(), empty_string(), 0x2::object::id<User>(arg4), arg6, arg7, 0);
    }

    fun coin_decimals_from_currency<T0>(arg0: &0x2::coin_registry::Currency<T0>) : u8 {
        0x2::coin_registry::decimals<T0>(arg0)
    }

    fun coin_type_from_type<T0>() : 0x1::string::String {
        0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()))
    }

    entry fun complain_chapter(arg0: &mut Platform, arg1: &PlatformDenyList, arg2: &mut User, arg3: &mut User, arg4: &mut Work, arg5: &mut Chapter, arg6: &Dao, arg7: u8, arg8: &0x2::clock::Clock, arg9: &mut ChangeShard, arg10: &mut 0x2::tx_context::TxContext) {
        ensure_contract_version(arg0);
        assert_shard_matches(arg0, arg9, arg10);
        let v0 = arg2.owner;
        assert!(!0x2::dynamic_field::exists<address>(&arg1.id, v0), 1021);
        let v1 = DaoDenylistKey{user: v0};
        assert!(!0x2::dynamic_field::exists<DaoDenylistKey>(&arg6.id, v1), 1021);
        assert!(!arg0.disabled, 1091);
        assert!(!arg6.disabled, 1043);
        ensure_auto_wallet_sender(arg2, 0x2::tx_context::sender(arg10));
        assert!(arg3.owner == arg4.owner, 1009);
        assert!(arg4.owner == arg5.owner, 1009);
        assert!(0x2::object::id<Work>(arg4) == arg5.work_id, 1001);
        assert!(0x2::object::id<Dao>(arg6) == arg4.dao_id, 1009);
        assert!(arg6.owner == arg3.owner, 1009);
        assert!(!arg4.disabled, 1045);
        assert!(!arg4.banned, 1004);
        assert!(arg2.owner != arg3.owner, 1057);
        assert!(!arg2.page_key_paused, 1070);
        assert!(arg4.dao_id != arg0.system_dao_id, 1089);
        let v2 = if (arg7 == 1) {
            true
        } else if (arg7 == 2) {
            true
        } else if (arg7 == 3) {
            true
        } else if (arg7 == 4) {
            true
        } else if (arg7 == 5) {
            true
        } else {
            arg7 == 6
        };
        assert!(v2, 1037);
        assert!(0x2::balance::value<POINT>(&arg2.points_balance) >= arg0.complaint.complaint_min_points_total, 1039);
        let v3 = 0x2::clock::timestamp_ms(arg8) / 1000;
        assert!(!0x2::table::contains<address, 0x2::object::ID>(&arg5.complained, v0), 1038);
        let v4 = coin_type_from_type<POINT>();
        assert!(!arg5.banned, 1100);
        assert!(chapter_read_permission(arg6, arg5, arg2, v3), 1144);
        let v5 = complaint_fee_for_user(arg0, arg2);
        assert!(0x2::balance::value<POINT>(&arg2.points_balance) >= v5, 1049);
        0x2::balance::decrease_supply<POINT>(&mut arg0.points_supply, 0x2::balance::split<POINT>(&mut arg2.points_balance, v5));
        let v6 = 0x2::object::id<Chapter>(arg5);
        let v7 = 0x2::object::id_from_address(@0x0);
        let v8 = FinancialPart{
            part_type   : 0,
            wallet_addr : v0,
            obj_id      : v7,
        };
        let v9 = FinancialPart{
            part_type   : 0,
            wallet_addr : @0x0,
            obj_id      : v7,
        };
        create_financial_record(3, 0, v8, v9, v4, 0, v5, v6, 0, v7, v3, arg4.name, arg5.title, 0x2::object::id<User>(arg2), arg9, arg10, 0);
        arg2.complaint_count = arg2.complaint_count + 1;
        let v10 = Complaint{
            id             : 0x2::object::new(arg10),
            reader         : v0,
            chapter_id     : 0x2::object::id<Chapter>(arg5),
            work_id        : arg5.work_id,
            complaint_type : arg7,
            fee            : v5,
            coin_type      : v4,
        };
        let v11 = 0x2::object::id<Complaint>(&v10);
        0x2::table::add<address, 0x2::object::ID>(&mut arg5.complained, v0, v11);
        0x2::transfer::share_object<Complaint>(v10);
        record_object_change(arg9, 13, v11, arg10);
        record_object_change(arg9, 0, 0x2::object::id<User>(arg2), arg10);
        record_object_change(arg9, 6, v6, arg10);
        if (arg0.complaint.complaint_threshold > 0 && 0x2::table::length<address, 0x2::object::ID>(&arg5.complained) >= arg0.complaint.complaint_threshold) {
            arg5.banned = true;
            arg4.closed_chapter_count = arg4.closed_chapter_count + 1;
            record_object_change(arg9, 5, 0x2::object::id<Work>(arg4), arg10);
            if (arg0.complaint.max_closed_chapters_for_banned_work > 0 && arg4.closed_chapter_count >= arg0.complaint.max_closed_chapters_for_banned_work) {
                if (!arg4.banned) {
                    arg4.banned = true;
                    arg3.banned_work_count = arg3.banned_work_count + 1;
                    record_object_change(arg9, 0, 0x2::object::id<User>(arg3), arg10);
                };
            };
        };
    }

    fun complaint_fee(arg0: u64, arg1: u64) : u64 {
        let v0 = (arg0 as u128) * ((arg1 as u128) + 1);
        if (v0 > 18446744073709551615) {
            return 18446744073709551615
        };
        (v0 as u64)
    }

    public fun complaint_fee_for_user(arg0: &Platform, arg1: &User) : u64 {
        ensure_contract_version(arg0);
        complaint_fee(arg0.complaint.base_complaint_fee, arg1.complaint_count)
    }

    fun consume_dao_join_points(arg0: &mut Platform, arg1: &Dao, arg2: &mut User, arg3: u64, arg4: &mut ChangeShard, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = arg1.member_policy.join_requirements.min_platform_points;
        if (v0 == 0) {
            return
        };
        assert!(0x2::balance::value<POINT>(&arg2.points_balance) >= v0, 1063);
        0x2::balance::decrease_supply<POINT>(&mut arg0.points_supply, 0x2::balance::split<POINT>(&mut arg2.points_balance, v0));
        let v1 = 0x2::object::id_from_address(@0x0);
        let v2 = FinancialPart{
            part_type   : 0,
            wallet_addr : arg2.owner,
            obj_id      : v1,
        };
        let v3 = FinancialPart{
            part_type   : 0,
            wallet_addr : @0x0,
            obj_id      : v1,
        };
        create_financial_record(12, 0, v2, v3, coin_type_from_type<POINT>(), 0, v0, 0x2::object::id<Dao>(arg1), 0, v1, arg3, empty_string(), empty_string(), 0x2::object::id<User>(arg2), arg4, arg5, 0);
        record_object_change(arg4, 0, 0x2::object::id<User>(arg2), arg5);
    }

    entry fun create_avatar(arg0: &Platform, arg1: &PlatformDenyList, arg2: &mut User, arg3: vector<u8>, arg4: 0x1::string::String, arg5: u32, arg6: u32, arg7: &mut ChangeShard, arg8: &mut 0x2::tx_context::TxContext) {
        ensure_contract_version(arg0);
        assert_shard_matches(arg0, arg7, arg8);
        assert!(!arg0.disabled, 1091);
        ensure_auto_wallet_sender(arg2, 0x2::tx_context::sender(arg8));
        assert!(!arg2.page_key_paused, 1070);
        assert!(!0x2::dynamic_field::exists<address>(&arg1.id, arg2.owner), 1021);
        assert!(0x1::vector::length<u8>(&arg3) > 0, 1031);
        assert!(0x1::option::is_none<0x2::object::ID>(&arg2.avatar), 1034);
        let v0 = Avatar{
            id         : 0x2::object::new(arg8),
            owner      : arg2.owner,
            user_id    : 0x2::object::id<User>(arg2),
            bytes      : arg3,
            mime_type  : 0x1::string::utf8(*0x1::string::as_bytes(&arg4)),
            width      : arg5,
            height     : arg6,
            updated_at : 0x2::tx_context::epoch_timestamp_ms(arg8) / 1000,
        };
        let v1 = 0x2::object::id<Avatar>(&v0);
        0x2::transfer::share_object<Avatar>(v0);
        0x1::option::fill<0x2::object::ID>(&mut arg2.avatar, v1);
        arg2.avatar_mime_type = arg4;
        record_object_change(arg7, 17, v1, arg8);
        record_object_change(arg7, 0, 0x2::object::id<User>(arg2), arg8);
    }

    entry fun create_avatar_and_profile(arg0: &Platform, arg1: &PlatformDenyList, arg2: &mut User, arg3: &mut Registry, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: vector<u8>, arg7: 0x1::string::String, arg8: u32, arg9: u32, arg10: &mut ChangeShard, arg11: &mut 0x2::tx_context::TxContext) {
        ensure_contract_version(arg0);
        assert_shard_matches(arg0, arg10, arg11);
        assert!(!arg0.disabled, 1091);
        ensure_auto_wallet_sender(arg2, 0x2::tx_context::sender(arg11));
        assert!(!arg2.page_key_paused, 1070);
        assert!(!0x2::dynamic_field::exists<address>(&arg1.id, arg2.owner), 1021);
        assert!(0x1::vector::length<u8>(&arg6) > 0, 1031);
        assert!(0x1::option::is_none<0x2::object::ID>(&arg2.avatar), 1034);
        let v0 = Avatar{
            id         : 0x2::object::new(arg11),
            owner      : arg2.owner,
            user_id    : 0x2::object::id<User>(arg2),
            bytes      : arg6,
            mime_type  : 0x1::string::utf8(*0x1::string::as_bytes(&arg7)),
            width      : arg8,
            height     : arg9,
            updated_at : 0x2::tx_context::epoch_timestamp_ms(arg11) / 1000,
        };
        let v1 = 0x2::object::id<Avatar>(&v0);
        0x2::transfer::share_object<Avatar>(v0);
        0x1::option::fill<0x2::object::ID>(&mut arg2.avatar, v1);
        arg2.avatar_mime_type = arg7;
        apply_user_profile_fields(arg2, arg3, arg4, arg5);
        record_object_change(arg10, 17, v1, arg11);
        record_object_change(arg10, 0, 0x2::object::id<User>(arg2), arg11);
    }

    entry fun create_cover(arg0: &Platform, arg1: &PlatformDenyList, arg2: &mut User, arg3: &mut Work, arg4: vector<u8>, arg5: 0x1::string::String, arg6: u32, arg7: u32, arg8: &mut ChangeShard, arg9: &mut 0x2::tx_context::TxContext) {
        ensure_contract_version(arg0);
        assert_shard_matches(arg0, arg8, arg9);
        assert!(!arg0.disabled, 1091);
        let v0 = 0x2::tx_context::sender(arg9);
        assert!(!0x2::dynamic_field::exists<address>(&arg1.id, v0), 1021);
        assert!(!0x2::dynamic_field::exists<address>(&arg1.id, arg2.owner), 1021);
        ensure_auto_wallet_sender(arg2, v0);
        assert!(!arg2.page_key_paused, 1070);
        assert!(arg2.owner == arg3.owner, 1033);
        assert!(0x1::vector::length<u8>(&arg4) > 0, 1031);
        assert!(0x1::option::is_none<0x2::object::ID>(&arg3.cover), 1040);
        let v1 = Cover{
            id         : 0x2::object::new(arg9),
            owner      : arg3.owner,
            work_id    : 0x2::object::id<Work>(arg3),
            bytes      : arg4,
            mime_type  : 0x1::string::utf8(*0x1::string::as_bytes(&arg5)),
            width      : arg6,
            height     : arg7,
            updated_at : 0x2::tx_context::epoch_timestamp_ms(arg9) / 1000,
        };
        let v2 = 0x2::object::id<Cover>(&v1);
        0x2::transfer::share_object<Cover>(v1);
        0x1::option::fill<0x2::object::ID>(&mut arg3.cover, v2);
        arg3.cover_mime_type = arg5;
        record_object_change(arg8, 18, v2, arg9);
        record_object_change(arg8, 5, 0x2::object::id<Work>(arg3), arg9);
    }

    entry fun create_dao(arg0: &Platform, arg1: &PlatformDenyList, arg2: &mut Registry, arg3: &mut User, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: &mut ChangeShard, arg10: &mut 0x2::tx_context::TxContext) {
        ensure_contract_version(arg0);
        assert_shard_matches(arg0, arg9, arg10);
        let v0 = 0x2::tx_context::sender(arg10);
        assert!(!0x2::dynamic_field::exists<address>(&arg1.id, arg3.owner), 1021);
        assert!(!0x2::dynamic_field::exists<address>(&arg1.id, v0), 1021);
        assert!(!arg0.disabled, 1091);
        ensure_auto_wallet_sender(arg3, v0);
        assert!(!arg3.page_key_paused, 1070);
        assert!(arg0.create_dao_without_work_allowed, 1101);
        let v1 = normalize_name(arg4);
        assert!(0x1::string::length(&v1) > 0, 1023);
        share_dao(new_dao(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10));
    }

    fun create_dao_fund_impl<T0: drop>(arg0: &mut Dao, arg1: u8, arg2: vector<u8>, arg3: u8, arg4: &mut ChangeShard, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 == b"team", 1120);
        let v0 = coin_type_from_type<T0>();
        ensure_author_fund_ledger(arg0, arg4, arg5);
        let v1 = fund_coin_key(arg2, v0);
        let v2 = AuthorFundKey{dummy_field: false};
        if (0x2::table::contains<0x1::string::String, 0x2::object::ID>(&0x2::dynamic_object_field::borrow<AuthorFundKey, FundShares>(&arg0.id, v2).fund_coin_seqs, v1)) {
            return
        };
        let v3 = fund_new_impl<T0>(arg0.owner, v0, 0x2::object::id<Dao>(arg0), arg1, arg3, arg5);
        let v4 = 0x2::object::id<NovelFund<T0>>(&v3);
        let v5 = AuthorFundKey{dummy_field: false};
        0x2::table::add<0x1::string::String, 0x2::object::ID>(&mut 0x2::dynamic_object_field::borrow_mut<AuthorFundKey, FundShares>(&mut arg0.id, v5).fund_coin_seqs, v1, v4);
        0x2::transfer::share_object<NovelFund<T0>>(v3);
        record_object_change(arg4, 3, v4, arg5);
    }

    fun create_dao_member_changed(arg0: &mut Dao, arg1: &mut ChangeShard, arg2: address, arg3: u8, arg4: 0x1::string::String, arg5: address, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        arg0.dao_member_change_seq = arg0.dao_member_change_seq + 1;
        let v0 = DaoMemberChanged{
            id        : 0x2::object::new(arg7),
            dao_id    : 0x2::object::id<Dao>(arg0),
            member    : arg2,
            action    : arg3,
            reason    : arg4,
            operator  : arg5,
            timestamp : arg6,
            seq       : arg0.dao_member_change_seq,
        };
        0x2::transfer::share_object<DaoMemberChanged>(v0);
        record_object_change(arg1, 7, 0x2::object::id<DaoMemberChanged>(&v0), arg7);
    }

    fun create_dual_financial_record(arg0: u8, arg1: u8, arg2: FinancialPart, arg3: FinancialPart, arg4: 0x1::string::String, arg5: u8, arg6: u64, arg7: 0x2::object::ID, arg8: u8, arg9: 0x2::object::ID, arg10: u64, arg11: 0x1::string::String, arg12: 0x1::string::String, arg13: 0x2::object::ID, arg14: 0x2::object::ID, arg15: &mut ChangeShard, arg16: &mut 0x2::tx_context::TxContext, arg17: u64) {
        create_financial_record(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg15, arg16, arg17);
        create_financial_record(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg14, arg15, arg16, arg17);
    }

    fun create_financial_record(arg0: u8, arg1: u8, arg2: FinancialPart, arg3: FinancialPart, arg4: 0x1::string::String, arg5: u8, arg6: u64, arg7: 0x2::object::ID, arg8: u8, arg9: 0x2::object::ID, arg10: u64, arg11: 0x1::string::String, arg12: 0x1::string::String, arg13: 0x2::object::ID, arg14: &mut ChangeShard, arg15: &mut 0x2::tx_context::TxContext, arg16: u64) {
        let v0 = FinancialRecord{
            id               : 0x2::object::new(arg15),
            tx_type          : arg0,
            fee_type         : arg1,
            from             : arg2,
            to               : arg3,
            coin_type        : arg4,
            coin_decimals    : arg5,
            work_name        : arg11,
            chapter_title    : arg12,
            amount           : arg6,
            ref_id           : arg7,
            ref_payment_type : arg8,
            ref_payment_id   : arg9,
            timestamp        : arg10,
            parent_id        : arg13,
            share_seq        : arg16,
        };
        0x2::transfer::share_object<FinancialRecord>(v0);
        record_object_change(arg14, 11, 0x2::object::id<FinancialRecord>(&v0), arg15);
    }

    fun create_fund_member_changed(arg0: &mut Dao, arg1: &mut ChangeShard, arg2: address, arg3: 0x1::string::String, arg4: u64, arg5: u8, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = AuthorFundKey{dummy_field: false};
        let v1 = 0x2::dynamic_object_field::borrow_mut<AuthorFundKey, FundShares>(&mut arg0.id, v0);
        v1.fund_member_seq = v1.fund_member_seq + 1;
        let v2 = FundMemberChanged{
            id     : 0x2::object::new(arg6),
            dao_id : 0x2::object::id<Dao>(arg0),
            member : arg2,
            role   : arg3,
            shares : arg4,
            action : arg5,
            seq    : v1.fund_member_seq,
        };
        0x2::transfer::share_object<FundMemberChanged>(v2);
        record_object_change(arg1, 15, 0x2::object::id<FundMemberChanged>(&v2), arg6);
    }

    entry fun create_general_invite_code(arg0: &Platform, arg1: &PlatformDenyList, arg2: &mut User, arg3: vector<u8>, arg4: vector<u8>, arg5: 0x1::string::String, arg6: &0x2::clock::Clock, arg7: &mut ChangeShard, arg8: &mut 0x2::tx_context::TxContext) {
        ensure_contract_version(arg0);
        assert_shard_matches(arg0, arg7, arg8);
        assert!(!arg0.disabled, 1091);
        assert!(0x2::tx_context::sender(arg8) == arg2.owner, 1032);
        assert!(!0x2::dynamic_field::exists<address>(&arg1.id, arg2.owner), 1021);
        if (arg0.registration_mode == 0) {
            assert!(0x2::object::id<User>(arg2) == arg0.admin_user_id, 1096);
        };
        let v0 = 0x1::string::length(&arg5);
        assert!(v0 > 0 && v0 <= 96, 2036);
        let v1 = normalize_name(arg5);
        assert!(0x1::string::length(&v1) > 0, 2036);
        assert!(0x1::vector::length<u8>(&arg3) == 17, 1093);
        assert!(0x1::vector::length<u8>(&arg4) > 0, 1093);
        assert!(*0x1::vector::borrow<u8>(&arg3, 0) == 2, 1093);
        verify_reg_invite_signature(arg2, arg3, arg4, @0x0);
        let v2 = GeneralInviteCodeEntry{
            uuid       : arg3,
            signature  : arg4,
            label      : arg5,
            created_at : 0x2::clock::timestamp_ms(arg6) / 1000,
            revoked    : false,
            revoked_at : 0,
        };
        let v3 = GeneralInviteCodeBookKey{dummy_field: false};
        if (0x2::dynamic_field::exists<GeneralInviteCodeBookKey>(&arg2.id, v3)) {
            let v4 = 0x2::dynamic_field::borrow_mut<GeneralInviteCodeBookKey, GeneralInviteCodeBook>(&mut arg2.id, v3);
            let v5 = general_invite_entry_index(v4, arg3);
            assert!(0x1::option::is_none<u64>(&v5), 1094);
            0x1::vector::push_back<GeneralInviteCodeEntry>(&mut v4.entries, v2);
        } else {
            let v6 = GeneralInviteCodeBook{entries: 0x1::vector::empty<GeneralInviteCodeEntry>()};
            0x1::vector::push_back<GeneralInviteCodeEntry>(&mut v6.entries, v2);
            0x2::dynamic_field::add<GeneralInviteCodeBookKey, GeneralInviteCodeBook>(&mut arg2.id, v3, v6);
        };
        record_object_change(arg7, 0, 0x2::object::id<User>(arg2), arg8);
    }

    public fun create_team_fund<T0: drop>(arg0: &Platform, arg1: &PlatformDenyList, arg2: &mut Dao, arg3: &0x2::coin_registry::Currency<T0>, arg4: &mut ChangeShard, arg5: &mut 0x2::tx_context::TxContext) {
        ensure_contract_version(arg0);
        abort 2023
    }

    public(friend) fun create_team_fund_v2<T0: drop>(arg0: &Platform, arg1: &PlatformDenyList, arg2: &mut Dao, arg3: &0x2::coin_registry::Currency<T0>, arg4: &mut ChangeShard, arg5: &mut 0x2::tx_context::TxContext) {
        ensure_contract_version(arg0);
        assert_shard_matches(arg0, arg4, arg5);
        assert!(!0x2::dynamic_field::exists<address>(&arg1.id, arg2.owner), 1021);
        assert!(0x2::tx_context::sender(arg5) == arg2.owner, 1104);
        create_dao_fund_impl<T0>(arg2, coin_decimals_from_currency<T0>(arg3), b"team", 1, arg4, arg5);
    }

    fun create_test_wallet_list(arg0: &mut Platform, arg1: &mut ChangeShard, arg2: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert_test_wallet_list_not_created(arg0);
        let v0 = TestWalletListKey{dummy_field: false};
        let v1 = TestWalletList{
            id      : 0x2::derived_object::claim<TestWalletListKey>(&mut arg0.id, v0),
            visible : false,
            seq     : 0,
        };
        let v2 = 0x2::object::id<TestWalletList>(&v1);
        0x2::transfer::share_object<TestWalletList>(v1);
        record_object_change(arg1, 25, v2, arg2);
        v2
    }

    fun create_user_cap(arg0: &mut 0x2::tx_context::TxContext) : UserCap {
        UserCap{
            id    : 0x2::object::new(arg0),
            owner : @0x0,
        }
    }

    fun create_user_with_owner(arg0: &Platform, arg1: &PlatformDenyList, arg2: &mut Registry, arg3: &mut PubKeyRegistry, arg4: &mut User, arg5: address, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: vector<u8>, arg9: vector<u8>, arg10: vector<u8>, arg11: vector<u8>, arg12: vector<u8>, arg13: u8, arg14: &0x2::clock::Clock, arg15: &mut ChangeShard, arg16: &mut 0x2::tx_context::TxContext) : User {
        assert!(!0x2::dynamic_field::exists<address>(&arg1.id, 0x2::tx_context::sender(arg16)), 1021);
        assert!(!0x2::dynamic_field::exists<address>(&arg1.id, arg5), 1021);
        assert!(!0x2::dynamic_field::exists<address>(&arg2.id, arg5), 1085);
        assert!(0x1::vector::length<u8>(0x1::string::as_bytes(&arg6)) > 0, 1023);
        let v0 = normalize_name(arg6);
        assert!(0x1::string::length(&v0) > 0, 1023);
        assert!(0x1::vector::length<u8>(0x1::string::as_bytes(&arg7)) > 0, 1024);
        assert!(0x1::vector::length<u8>(&arg11) == 32, 1080);
        let v1 = if (0x1::vector::length<u8>(&arg10) == 32) {
            true
        } else if (0x1::vector::length<u8>(&arg10) == 33) {
            true
        } else {
            0x1::vector::length<u8>(&arg10) == 34
        };
        assert!(v1, 1017);
        register_pubkey(arg3, arg11, arg5);
        let v2 = 0x1::vector::length<u8>(&arg8) > 0 || 0x1::vector::length<u8>(&arg9) > 0;
        let v3 = if (arg0.registration_mode == 2 && !v2) {
            @0x0
        } else {
            if (arg0.registration_mode == 0) {
                assert!(0x2::object::id<User>(arg4) == arg0.admin_user_id, 1096);
            } else if (!(0x2::object::id<User>(arg4) == arg0.admin_user_id)) {
                assert!(!0x2::dynamic_field::exists<address>(&arg1.id, arg4.owner), 1021);
                assert!(arg4.owner != arg5, 1093);
            };
            verify_reg_invite_code(arg4, arg8, arg9, arg14, arg16);
            arg4.owner
        };
        let v4 = check_and_register_name(arg2, arg6, arg5);
        let v5 = b"Sender:0x";
        0x1::vector::append<u8>(&mut v5, 0x1::string::into_bytes(0x2::address::to_string(arg5)));
        0x1::vector::append<u8>(&mut v5, b";Version:");
        0x1::vector::append<u8>(&mut v5, u8_to_ascii_bytes(arg13));
        0x1::vector::append<u8>(&mut v5, b";Content:");
        assert!(arg13 >= arg0.user_agreement_version, 2001);
        0x1::vector::append<u8>(&mut v5, *0x1::string::as_bytes(&0x2::dynamic_object_field::borrow<u8, UserAgreementContent>(&arg0.id, arg13).content));
        let v6 = b"";
        0x1::vector::push_back<u8>(&mut v6, 3);
        0x1::vector::push_back<u8>(&mut v6, 0);
        0x1::vector::push_back<u8>(&mut v6, 0);
        0x1::vector::append<u8>(&mut v6, 0x2::bcs::to_bytes<vector<u8>>(&v5));
        let v7 = 0x2::hash::blake2b256(&v6);
        assert!(0x1::vector::length<u8>(&v7) == 32, 10162);
        assert!(verify_signature(&arg11, &v7, &arg12), 10163);
        let v8 = if (v3 != @0x0) {
            0x2::clock::timestamp_ms(arg14) / 1000
        } else {
            0
        };
        let v9 = UserAgreementSign{
            sign_pubkey : arg11,
            signature   : arg12,
            version     : arg13,
        };
        let v10 = UserHosting{
            state    : 0,
            provider : @0x0,
        };
        let v11 = User{
            id                       : 0x2::object::new(arg16),
            owner                    : arg5,
            name                     : v4,
            intro                    : arg7,
            avatar                   : 0x1::option::none<0x2::object::ID>(),
            avatar_mime_type         : 0x1::string::utf8(b""),
            referrer                 : v3,
            referral_time            : v8,
            agreement                : v9,
            dao_id                   : 0x1::option::none<0x2::object::ID>(),
            banned_work_count        : 0,
            encrypt_pubkey           : arg10,
            auto_pubkey              : arg11,
            complaint_count          : 0,
            age_confirm_signatures   : 0x2::table::new<u8, vector<u8>>(arg16),
            points_balance           : 0x2::balance::zero<POINT>(),
            page_key_paused          : false,
            hosting                  : v10,
            work_count               : 0,
            points_earned_cumulative : 0,
            node_disabled            : false,
            author_service_disabled  : false,
        };
        let v12 = 0x2::object::id<User>(&v11);
        let v13 = UserInfo{
            user_id        : v12,
            auto_pubkey    : arg11,
            encrypt_pubkey : arg10,
        };
        0x2::dynamic_field::add<address, UserInfo>(&mut arg2.id, arg5, v13);
        record_object_change(arg15, 0, v12, arg16);
        v11
    }

    fun current_dao_fund_member_seq(arg0: &Dao) : u64 {
        let v0 = AuthorFundKey{dummy_field: false};
        if (0x2::dynamic_object_field::exists<AuthorFundKey>(&arg0.id, v0)) {
            let v2 = AuthorFundKey{dummy_field: false};
            0x2::dynamic_object_field::borrow<AuthorFundKey, FundShares>(&arg0.id, v2).fund_member_seq
        } else {
            0
        }
    }

    fun dao_deposit<T0>(arg0: &Dao, arg1: &mut NovelFund<T0>, arg2: 0x2::balance::Balance<T0>) : u64 {
        let v0 = 0x2::balance::value<T0>(&arg2);
        if (v0 == 0) {
            0x2::balance::destroy_zero<T0>(arg2);
            return 0
        };
        let v1 = AuthorFundKey{dummy_field: false};
        fund_deposit<T0>(arg1, 0x2::dynamic_object_field::borrow<AuthorFundKey, FundShares>(&arg0.id, v1).total_shares, arg2);
        v0
    }

    fun dao_member_is_valid(arg0: &Dao, arg1: address, arg2: u64) : bool {
        if (arg1 == arg0.owner) {
            return true
        };
        let v0 = DaoMember{member: arg1};
        if (!0x2::dynamic_field::exists<DaoMember>(&arg0.id, v0)) {
            return false
        };
        if (arg0.member_policy.member_duration == 0) {
            return true
        };
        let v1 = DaoMember{member: arg1};
        arg2 <= 0x2::dynamic_field::borrow<DaoMember, DaoMemberData>(&arg0.id, v1).joined_at + arg0.member_policy.member_duration
    }

    entry fun dao_remove_member(arg0: &Platform, arg1: &PlatformDenyList, arg2: &mut Dao, arg3: address, arg4: 0x1::string::String, arg5: &0x2::clock::Clock, arg6: &mut ChangeShard, arg7: &mut 0x2::tx_context::TxContext) {
        ensure_contract_version(arg0);
        assert_shard_matches(arg0, arg6, arg7);
        assert!(!arg0.disabled, 1091);
        assert!(!0x2::dynamic_field::exists<address>(&arg1.id, 0x2::tx_context::sender(arg7)), 1021);
        let v0 = 0x2::tx_context::sender(arg7);
        assert!(v0 == arg2.owner, 1009);
        assert!(arg3 != arg2.owner, 1090);
        let v1 = DaoMember{member: arg3};
        if (0x2::dynamic_field::exists<DaoMember>(&arg2.id, v1)) {
            let v2 = DaoMember{member: arg3};
            0x2::dynamic_field::remove<DaoMember, DaoMemberData>(&mut arg2.id, v2);
            create_dao_member_changed(arg2, arg6, arg3, 2, arg4, v0, 0x2::clock::timestamp_ms(arg5) / 1000, arg7);
        };
    }

    entry fun dao_set_age_rating(arg0: &Platform, arg1: &PlatformDenyList, arg2: &mut Dao, arg3: u8, arg4: &mut ChangeShard, arg5: &mut 0x2::tx_context::TxContext) {
        ensure_contract_version(arg0);
        assert_shard_matches(arg0, arg4, arg5);
        assert!(!arg0.disabled, 1091);
        assert!(!0x2::dynamic_field::exists<address>(&arg1.id, 0x2::tx_context::sender(arg5)), 1021);
        assert!(0x2::tx_context::sender(arg5) == arg2.owner, 1009);
        let v0 = if (arg3 == 0) {
            true
        } else if (arg3 == 1) {
            true
        } else if (arg3 == 2) {
            true
        } else {
            arg3 == 3
        };
        assert!(v0, 1028);
        assert!(arg3 >= arg2.age_rating, 1122);
        arg2.age_rating = arg3;
        record_object_change(arg4, 1, 0x2::object::id<Dao>(arg2), arg5);
    }

    entry fun dao_set_contacts(arg0: &Platform, arg1: &PlatformDenyList, arg2: &mut Dao, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: &mut ChangeShard, arg7: &mut 0x2::tx_context::TxContext) {
        ensure_contract_version(arg0);
        assert_shard_matches(arg0, arg6, arg7);
        assert!(!arg0.disabled, 1091);
        assert!(!0x2::dynamic_field::exists<address>(&arg1.id, 0x2::tx_context::sender(arg7)), 1021);
        assert!(0x2::tx_context::sender(arg7) == arg2.owner, 1009);
        let v0 = Contacts{
            x        : arg3,
            discord  : arg4,
            telegram : arg5,
        };
        arg2.contacts = v0;
        record_object_change(arg6, 1, 0x2::object::id<Dao>(arg2), arg7);
    }

    entry fun dao_set_denylisted(arg0: &Platform, arg1: &PlatformDenyList, arg2: &mut Dao, arg3: address, arg4: bool, arg5: &mut ChangeShard, arg6: &mut 0x2::tx_context::TxContext) {
        ensure_contract_version(arg0);
        assert_shard_matches(arg0, arg5, arg6);
        assert!(!arg0.disabled, 1091);
        assert!(!0x2::dynamic_field::exists<address>(&arg1.id, 0x2::tx_context::sender(arg6)), 1021);
        let v0 = 0x2::tx_context::sender(arg6);
        assert!(v0 == arg2.owner, 1009);
        if (arg4) {
            assert!(arg3 != v0, 1088);
            let v1 = DaoDenylistKey{user: arg3};
            if (!0x2::dynamic_field::exists<DaoDenylistKey>(&arg2.id, v1)) {
                let v2 = DaoDenylistKey{user: arg3};
                let v3 = DaoDenylist{dummy_field: false};
                0x2::dynamic_field::add<DaoDenylistKey, DaoDenylist>(&mut arg2.id, v2, v3);
            };
        } else {
            let v4 = DaoDenylistKey{user: arg3};
            if (0x2::dynamic_field::exists<DaoDenylistKey>(&arg2.id, v4)) {
                let v5 = DaoDenylistKey{user: arg3};
                0x2::dynamic_field::remove<DaoDenylistKey, DaoDenylist>(&mut arg2.id, v5);
            };
        };
        arg2.dao_denylist_change_seq = arg2.dao_denylist_change_seq + 1;
        let v6 = if (arg4) {
            2
        } else {
            1
        };
        let v7 = DaoDenylistChanged{
            id       : 0x2::object::new(arg6),
            dao_id   : 0x2::object::id<Dao>(arg2),
            user     : arg3,
            denied   : v6,
            operator : v0,
            seq      : arg2.dao_denylist_change_seq,
        };
        0x2::transfer::share_object<DaoDenylistChanged>(v7);
        record_object_change(arg5, 8, 0x2::object::id<DaoDenylistChanged>(&v7), arg6);
    }

    entry fun dao_set_member_policy<T0: drop>(arg0: &Platform, arg1: &PlatformDenyList, arg2: &mut Dao, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::coin_registry::Currency<T0>, arg7: &AllowedCoins, arg8: &mut ChangeShard, arg9: &mut 0x2::tx_context::TxContext) {
        ensure_contract_version(arg0);
        assert_shard_matches(arg0, arg8, arg9);
        assert!(!arg0.disabled, 1091);
        let v0 = 0x2::tx_context::sender(arg9);
        assert!(!0x2::dynamic_field::exists<address>(&arg1.id, v0), 1021);
        assert!(v0 == arg2.owner, 1009);
        let v1 = coin_type_from_type<T0>();
        assert!(0x2::vec_set::contains<0x1::string::String>(&arg7.symbols, &v1), 1006);
        if (arg3 > 0) {
            create_dao_fund_impl<T0>(arg2, coin_decimals_from_currency<T0>(arg6), b"team", 1, arg8, arg9);
            arg2.member_policy.fee_required = arg3;
            arg2.member_policy.fee_coin_type = v1;
        } else {
            arg2.member_policy.fee_required = 0;
            arg2.member_policy.fee_coin_type = 0x1::string::utf8(b"");
        };
        arg2.member_policy.member_duration = arg4;
        let v2 = DaoJoinRequirements{min_platform_points: arg5};
        arg2.member_policy.join_requirements = v2;
        record_object_change(arg8, 1, 0x2::object::id<Dao>(arg2), arg9);
    }

    entry fun dao_set_privacy(arg0: &Platform, arg1: &PlatformDenyList, arg2: &mut Dao, arg3: bool, arg4: &mut ChangeShard, arg5: &mut 0x2::tx_context::TxContext) {
        ensure_contract_version(arg0);
        assert_shard_matches(arg0, arg4, arg5);
        assert!(!arg0.disabled, 1091);
        assert!(!0x2::dynamic_field::exists<address>(&arg1.id, 0x2::tx_context::sender(arg5)), 1021);
        assert!(0x2::tx_context::sender(arg5) == arg2.owner, 1009);
        arg2.is_private = arg3;
        record_object_change(arg4, 1, 0x2::object::id<Dao>(arg2), arg5);
    }

    entry fun dao_set_profile(arg0: &Platform, arg1: &PlatformDenyList, arg2: &mut Dao, arg3: &mut Registry, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: &mut ChangeShard, arg7: &mut 0x2::tx_context::TxContext) {
        ensure_contract_version(arg0);
        assert_shard_matches(arg0, arg6, arg7);
        assert!(!arg0.disabled, 1091);
        assert!(!0x2::dynamic_field::exists<address>(&arg1.id, 0x2::tx_context::sender(arg7)), 1021);
        let v0 = 0x2::tx_context::sender(arg7);
        assert!(v0 == arg2.owner, 1009);
        if (0x1::string::length(&arg4) > 0) {
            arg2.name = update_registered_name(arg3, &arg2.name, arg4, v0);
        };
        arg2.intro = arg5;
        record_object_change(arg6, 1, 0x2::object::id<Dao>(arg2), arg7);
    }

    fun default_work_deposit_coin_type() : 0x1::string::String {
        0x1::string::utf8(b"")
    }

    fun derived_fund_id(arg0: &0x2::table::Table<0x1::string::String, 0x2::object::ID>, arg1: vector<u8>, arg2: &0x1::string::String) : 0x2::object::ID {
        let v0 = fund_coin_key(arg1, *arg2);
        if (0x2::table::contains<0x1::string::String, 0x2::object::ID>(arg0, v0)) {
            *0x2::table::borrow<0x1::string::String, 0x2::object::ID>(arg0, v0)
        } else {
            0x2::object::id_from_address(@0x0)
        }
    }

    fun empty_string() : 0x1::string::String {
        0x1::string::utf8(b"")
    }

    fun ensure_author_fund_ledger(arg0: &mut Dao, arg1: &mut ChangeShard, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = AuthorFundKey{dummy_field: false};
        if (!0x2::dynamic_object_field::exists<AuthorFundKey>(&arg0.id, v0)) {
            let v1 = arg0.owner;
            let v2 = AuthorFundKey{dummy_field: false};
            let v3 = &mut arg0.id;
            new_fund_share<AuthorFundKey>(v2, v3, v1, arg2);
            create_fund_member_changed(arg0, arg1, v1, 0x1::string::utf8(b""), 10000, 1, arg2);
        };
    }

    fun ensure_auto_wallet_sender(arg0: &User, arg1: address) {
        assert!(arg1 == address_of(&arg0.auto_pubkey), 1081);
    }

    fun ensure_contract_version(arg0: &Platform) {
        assert!(arg0.current_version == 16, 2024);
    }

    fun ensure_platform_fund_ledger(arg0: &mut Platform, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = PlatformFundKey{dummy_field: false};
        if (!0x2::dynamic_object_field::exists<PlatformFundKey>(&arg0.id, v0)) {
            let v1 = PlatformFundKey{dummy_field: false};
            let v2 = &mut arg0.id;
            new_fund_share<PlatformFundKey>(v1, v2, arg1, arg2);
        };
    }

    public fun finish_fund_settle(arg0: &Platform, arg1: &PlatformDenyList, arg2: &mut Dao, arg3: &User, arg4: SettleTicket, arg5: &mut ChangeShard, arg6: &mut 0x2::tx_context::TxContext) {
        ensure_contract_version(arg0);
        assert_shard_matches(arg0, arg5, arg6);
        assert!(!arg0.disabled, 1091);
        assert!(!0x2::dynamic_field::exists<address>(&arg1.id, 0x2::tx_context::sender(arg6)), 1021);
        if (arg4.action == 4) {
            assert!(0x2::tx_context::sender(arg6) == arg3.owner, 1032);
        } else {
            assert!(0x2::tx_context::sender(arg6) == arg2.owner, 1104);
        };
        assert!(!arg2.disabled, 1043);
        assert!(arg4.dao_id == 0x2::object::id<Dao>(arg2), 1116);
        assert!(arg4.member == arg3.owner, 1116);
        assert!(arg4.action == 3 || arg4.action == 4, 1117);
        assert!(arg4.done == arg4.expected, 1115);
        assert_fund_pool_set_unchanged(arg2, arg4.expected);
        let SettleTicket {
            dao_id   : _,
            member   : v1,
            expected : _,
            done     : _,
            action   : v4,
            settled  : _,
        } = arg4;
        let v6 = AuthorFundKey{dummy_field: false};
        let v7 = 0x2::dynamic_object_field::borrow_mut<AuthorFundKey, FundShares>(&mut arg2.id, v6);
        ledger_assert_has_share(v7, v1);
        let v8 = FundMemberShareKey{user: v1};
        let v9 = 0x2::dynamic_field::remove<FundMemberShareKey, FundMemberShareData>(&mut v7.id, v8);
        let v10 = v7.owner;
        let v11 = FundMemberShareKey{user: v10};
        let v12 = 0x2::dynamic_field::borrow_mut<FundMemberShareKey, FundMemberShareData>(&mut v7.id, v11);
        v12.shares = ledger_share(v7, v10) + v9.shares;
        create_fund_member_changed(arg2, arg5, v1, 0x1::string::utf8(b""), 0, v4, arg6);
        let v13 = arg2.owner;
        create_fund_member_changed(arg2, arg5, v13, 0x1::string::utf8(x"e4bd9ce88085"), v12.shares, 2, arg6);
    }

    public fun finish_share_settle(arg0: &Platform, arg1: &PlatformDenyList, arg2: &mut Dao, arg3: &User, arg4: ShareChangeTicket, arg5: &mut ChangeShard, arg6: &mut 0x2::tx_context::TxContext) {
        ensure_contract_version(arg0);
        assert_shard_matches(arg0, arg5, arg6);
        assert!(!arg0.disabled, 1091);
        assert!(!0x2::dynamic_field::exists<address>(&arg1.id, 0x2::tx_context::sender(arg6)), 1021);
        assert!(0x2::tx_context::sender(arg6) == arg2.owner, 1104);
        assert!(!arg2.disabled, 1043);
        assert!(arg4.dao_id == 0x2::object::id<Dao>(arg2), 1116);
        assert!(arg4.member == arg3.owner, 1116);
        assert!(arg4.action == 1 || arg4.action == 2, 1117);
        assert!(arg4.done == arg4.expected, 1115);
        assert_fund_pool_set_unchanged(arg2, arg4.expected);
        let ShareChangeTicket {
            dao_id        : _,
            member        : v1,
            expected      : _,
            done          : _,
            action        : v4,
            amount        : v5,
            role          : v6,
            author_obj_id : _,
            settled       : _,
        } = arg4;
        let v9 = v6;
        let v10 = AuthorFundKey{dummy_field: false};
        let v11 = 0x2::dynamic_object_field::borrow_mut<AuthorFundKey, FundShares>(&mut arg2.id, v10);
        if (v4 == 1) {
            fund_add_share_ledger(v11, v1, v5, string_clone(&v9));
        } else {
            fund_update_share_ledger(v11, v1, v5, string_clone(&v9));
        };
        let v12 = ledger_share(v11, v11.owner);
        create_fund_member_changed(arg2, arg5, v1, v9, ledger_share(v11, v1), v4, arg6);
        let v13 = arg2.owner;
        create_fund_member_changed(arg2, arg5, v13, 0x1::string::utf8(x"e4bd9ce88085"), v12, 2, arg6);
    }

    fun fund_add_share_ledger(arg0: &mut FundShares, arg1: address, arg2: u64, arg3: 0x1::string::String) {
        let v0 = arg0.owner;
        let v1 = ledger_share(arg0, v0);
        assert!(arg2 < v1, 1118);
        let v2 = FundMemberShareKey{user: arg1};
        if (0x2::dynamic_field::exists<FundMemberShareKey>(&arg0.id, v2)) {
            let v3 = FundMemberShareKey{user: arg1};
            let v4 = 0x2::dynamic_field::borrow_mut<FundMemberShareKey, FundMemberShareData>(&mut arg0.id, v3);
            v4.shares = v4.shares + arg2;
            v4.role = arg3;
        } else {
            let v5 = FundMemberShareKey{user: arg1};
            let v6 = FundMemberShareData{
                shares : arg2,
                role   : arg3,
            };
            0x2::dynamic_field::add<FundMemberShareKey, FundMemberShareData>(&mut arg0.id, v5, v6);
        };
        let v7 = FundMemberShareKey{user: v0};
        0x2::dynamic_field::borrow_mut<FundMemberShareKey, FundMemberShareData>(&mut arg0.id, v7).shares = v1 - arg2;
    }

    fun fund_claim<T0: drop>(arg0: &FundShares, arg1: &mut NovelFund<T0>, arg2: address) : 0x2::balance::Balance<T0> {
        fund_claim_impl<T0>(arg1, arg2, ledger_share(arg0, arg2))
    }

    entry fun fund_claim_entry<T0: drop>(arg0: &Platform, arg1: &PlatformDenyList, arg2: &mut Dao, arg3: &mut NovelFund<T0>, arg4: &mut User, arg5: &0x2::clock::Clock, arg6: &mut ChangeShard, arg7: &mut 0x2::tx_context::TxContext) {
        ensure_contract_version(arg0);
        assert_shard_matches(arg0, arg6, arg7);
        assert!(!arg0.disabled, 1091);
        assert!(!0x2::dynamic_field::exists<address>(&arg1.id, arg4.owner), 1021);
        assert!(arg3.dao_id == 0x2::object::id<Dao>(arg2), 1065);
        assert!(!arg2.disabled, 1043);
        let v0 = DaoDenylistKey{user: arg4.owner};
        assert!(!0x2::dynamic_field::exists<DaoDenylistKey>(&arg2.id, v0), 1021);
        let v1 = 0x2::tx_context::sender(arg7);
        assert!(v1 == arg4.owner, 1032);
        let v2 = AuthorFundKey{dummy_field: false};
        let v3 = fund_claim<T0>(0x2::dynamic_object_field::borrow_mut<AuthorFundKey, FundShares>(&mut arg2.id, v2), arg3, v1);
        record_object_change(arg6, 3, 0x2::object::id<NovelFund<T0>>(arg3), arg7);
        settle_fund_withdraw_impl<T0>(arg1, arg3, v1, 0x2::object::id<User>(arg4), v3, 0x2::clock::timestamp_ms(arg5) / 1000, arg6, arg7, 5, false);
    }

    fun fund_claim_impl<T0: drop>(arg0: &mut NovelFund<T0>, arg1: address, arg2: u64) : 0x2::balance::Balance<T0> {
        if (arg2 == 0) {
            return 0x2::balance::zero<T0>()
        };
        if (!0x2::table::contains<address, u128>(&arg0.debts, arg1)) {
            0x2::table::add<address, u128>(&mut arg0.debts, arg1, 0);
        };
        let v0 = 0x2::table::borrow_mut<address, u128>(&mut arg0.debts, arg1);
        let v1 = sat_mul_u128((arg2 as u128), arg0.rewards_per_share_cumulative);
        let v2 = if (v1 > *v0) {
            (v1 - *v0) / 1000000000000
        } else {
            0
        };
        if (v2 > 0) {
            assert!(v2 <= 18446744073709551615, 1008);
            let v4 = (v2 as u64);
            let v5 = 0x2::balance::value<T0>(&arg0.balance);
            let v6 = if (v5 < v4) {
                v5
            } else {
                v4
            };
            if (v6 > 0) {
                *v0 = sat_add_u128(*v0, (v6 as u128) * 1000000000000);
                0x2::balance::split<T0>(&mut arg0.balance, v6)
            } else {
                0x2::balance::zero<T0>()
            }
        } else {
            0x2::balance::zero<T0>()
        }
    }

    fun fund_coin_key(arg0: vector<u8>, arg1: 0x1::string::String) : 0x1::string::String {
        let v0 = 0x1::string::utf8(arg0);
        0x1::string::append_utf8(&mut v0, b":");
        0x1::string::append(&mut v0, arg1);
        v0
    }

    fun fund_deposit<T0>(arg0: &mut NovelFund<T0>, arg1: u64, arg2: 0x2::balance::Balance<T0>) {
        let v0 = 0x2::balance::value<T0>(&arg2);
        if (v0 > 0 && arg1 > 0) {
            arg0.rewards_per_share_cumulative = sat_add_u128(arg0.rewards_per_share_cumulative, (v0 as u128) * 1000000000000 / (arg1 as u128));
        };
        0x2::balance::join<T0>(&mut arg0.balance, arg2);
    }

    fun fund_new_impl<T0: drop>(arg0: address, arg1: 0x1::string::String, arg2: 0x2::object::ID, arg3: u8, arg4: u8, arg5: &mut 0x2::tx_context::TxContext) : NovelFund<T0> {
        NovelFund<T0>{
            id                           : 0x2::object::new(arg5),
            owner                        : arg0,
            coin_type                    : arg1,
            dao_id                       : arg2,
            coin_decimals                : arg3,
            balance                      : 0x2::balance::zero<T0>(),
            rewards_per_share_cumulative : 0,
            fund_type                    : arg4,
            debts                        : 0x2::table::new<address, u128>(arg5),
        }
    }

    fun fund_new_platform<T0: drop>(arg0: address, arg1: 0x1::string::String, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) : NovelFund<T0> {
        NovelFund<T0>{
            id                           : 0x2::object::new(arg3),
            owner                        : arg0,
            coin_type                    : arg1,
            dao_id                       : 0x2::object::id_from_address(@0x0),
            coin_decimals                : arg2,
            balance                      : 0x2::balance::zero<T0>(),
            rewards_per_share_cumulative : 0,
            fund_type                    : 0,
            debts                        : 0x2::table::new<address, u128>(arg3),
        }
    }

    fun fund_update_share_ledger(arg0: &mut FundShares, arg1: address, arg2: u64, arg3: 0x1::string::String) {
        ledger_assert_has_share(arg0, arg1);
        let v0 = ledger_share(arg0, arg1);
        let v1 = FundMemberShareKey{user: arg1};
        let v2 = 0x2::dynamic_field::borrow_mut<FundMemberShareKey, FundMemberShareData>(&mut arg0.id, v1);
        v2.shares = arg2;
        v2.role = arg3;
        let v3 = arg0.owner;
        let v4 = ledger_share(arg0, v3);
        let v5 = if (arg2 > v0) {
            arg2 - v0
        } else {
            v0 - arg2
        };
        if (arg2 > v0) {
            assert!(v5 < v4, 1118);
            let v6 = FundMemberShareKey{user: v3};
            0x2::dynamic_field::borrow_mut<FundMemberShareKey, FundMemberShareData>(&mut arg0.id, v6).shares = v4 - v5;
        } else if (arg2 < v0) {
            let v7 = FundMemberShareKey{user: v3};
            0x2::dynamic_field::borrow_mut<FundMemberShareKey, FundMemberShareData>(&mut arg0.id, v7).shares = v4 + v5;
        };
    }

    fun general_invite_entry_index(arg0: &GeneralInviteCodeBook, arg1: vector<u8>) : 0x1::option::Option<u64> {
        let v0 = 0;
        while (v0 < 0x1::vector::length<GeneralInviteCodeEntry>(&arg0.entries)) {
            if (0x1::vector::borrow<GeneralInviteCodeEntry>(&arg0.entries, v0).uuid == arg1) {
                return 0x1::option::some<u64>(v0)
            };
            v0 = v0 + 1;
        };
        0x1::option::none<u64>()
    }

    public fun get_chapter_access_snapshot(arg0: &Platform, arg1: &PlatformDenyList, arg2: &Dao, arg3: &Chapter, arg4: &User, arg5: &0x2::clock::Clock) : (bool, bool, bool, bool, u8, u64, vector<u8>, u64) {
        ensure_contract_version(arg0);
        let v0 = arg4.owner;
        let v1 = 0x2::dynamic_field::exists<address>(&arg1.id, v0);
        let v2 = DaoDenylistKey{user: v0};
        let v3 = 0x2::dynamic_field::exists<DaoDenylistKey>(&arg2.id, v2);
        let v4 = (v1 || v3) && false || dao_member_is_valid(arg2, v0, 0x2::clock::timestamp_ms(arg5) / 1000);
        let v5 = if (arg2.member_policy.member_duration == 0) {
            true
        } else {
            let v6 = DaoMember{member: v0};
            !0x2::dynamic_field::exists<DaoMember>(&arg2.id, v6)
        };
        let v7 = if (v5) {
            0
        } else {
            let v8 = DaoMember{member: v0};
            0x2::dynamic_field::borrow<DaoMember, DaoMemberData>(&arg2.id, v8).joined_at + arg2.member_policy.member_duration
        };
        (v1, v3, v4, 0x2::dynamic_field::exists<0x2::object::ID>(&arg4.id, 0x2::object::id<Chapter>(arg3)), arg3.policy, arg3.price, arg3.content_hash, v7)
    }

    public fun get_chapter_access_snapshot_v2(arg0: &Platform, arg1: &PlatformDenyList, arg2: &Dao, arg3: &Chapter, arg4: &User, arg5: &0x2::clock::Clock) : (bool, bool, bool, bool, u8, u64, vector<u8>, u64, u64) {
        ensure_contract_version(arg0);
        let v0 = arg4.owner;
        let v1 = 0x2::dynamic_field::exists<address>(&arg1.id, v0);
        let v2 = DaoDenylistKey{user: v0};
        let v3 = 0x2::dynamic_field::exists<DaoDenylistKey>(&arg2.id, v2);
        let v4 = (v1 || v3) && false || dao_member_is_valid(arg2, v0, 0x2::clock::timestamp_ms(arg5) / 1000);
        let v5 = if (arg2.member_policy.member_duration == 0) {
            true
        } else {
            let v6 = DaoMember{member: v0};
            !0x2::dynamic_field::exists<DaoMember>(&arg2.id, v6)
        };
        let v7 = if (v5) {
            0
        } else {
            let v8 = DaoMember{member: v0};
            0x2::dynamic_field::borrow<DaoMember, DaoMemberData>(&arg2.id, v8).joined_at + arg2.member_policy.member_duration
        };
        let v9 = ChapterMemberPriceKey{dummy_field: false};
        let v10 = if (0x2::dynamic_field::exists<ChapterMemberPriceKey>(&arg3.id, v9)) {
            let v11 = ChapterMemberPriceKey{dummy_field: false};
            *0x2::dynamic_field::borrow<ChapterMemberPriceKey, u64>(&arg3.id, v11)
        } else {
            0
        };
        (v1, v3, v4, 0x2::dynamic_field::exists<0x2::object::ID>(&arg4.id, 0x2::object::id<Chapter>(arg3)), arg3.policy, arg3.price, arg3.content_hash, v7, v10)
    }

    public fun get_contract_upgrade_info(arg0: &Platform) : (u64, u64, 0x2::object::ID, u64, 0x2::object::ID) {
        (16, arg0.current_version, arg0.current_package_id, arg0.pending_version, arg0.pending_package_id)
    }

    public fun get_dao_join_requirements(arg0: &Dao, arg1: &Platform, arg2: &User) : (u64, 0x1::string::String, 0x2::object::ID, 0x2::object::ID, address, u64, u64) {
        ensure_contract_version(arg1);
        let v0 = &arg0.member_policy;
        let v1 = v0.fee_coin_type;
        let v2 = AuthorFundKey{dummy_field: false};
        let v3 = if (0x2::dynamic_object_field::exists<AuthorFundKey>(&arg0.id, v2)) {
            let v4 = AuthorFundKey{dummy_field: false};
            derived_fund_id(&0x2::dynamic_object_field::borrow<AuthorFundKey, FundShares>(&arg0.id, v4).fund_coin_seqs, b"team", &v1)
        } else {
            0x2::object::id_from_address(@0x0)
        };
        let v5 = PlatformFundKey{dummy_field: false};
        let v6 = if (0x2::dynamic_object_field::exists<PlatformFundKey>(&arg1.id, v5)) {
            let v7 = PlatformFundKey{dummy_field: false};
            derived_fund_id(&0x2::dynamic_object_field::borrow<PlatformFundKey, FundShares>(&arg1.id, v7).fund_coin_seqs, b"platform", &v1)
        } else {
            0x2::object::id_from_address(@0x0)
        };
        (v0.fee_required, v1, v3, v6, arg0.owner, v0.join_requirements.min_platform_points, 0x2::balance::value<POINT>(&arg2.points_balance))
    }

    public fun get_payment_data(arg0: &Chapter, arg1: &Dao, arg2: &Platform, arg3: &User, arg4: &User) : (u64, 0x1::string::String, 0x2::object::ID, 0x2::object::ID, address, address, address) {
        ensure_contract_version(arg2);
        let v0 = arg0.coin_type;
        let v1 = AuthorFundKey{dummy_field: false};
        let v2 = if (0x2::dynamic_object_field::exists<AuthorFundKey>(&arg1.id, v1)) {
            let v3 = AuthorFundKey{dummy_field: false};
            derived_fund_id(&0x2::dynamic_object_field::borrow<AuthorFundKey, FundShares>(&arg1.id, v3).fund_coin_seqs, b"team", &v0)
        } else {
            0x2::object::id_from_address(@0x0)
        };
        let v4 = PlatformFundKey{dummy_field: false};
        let v5 = if (0x2::dynamic_object_field::exists<PlatformFundKey>(&arg2.id, v4)) {
            let v6 = PlatformFundKey{dummy_field: false};
            derived_fund_id(&0x2::dynamic_object_field::borrow<PlatformFundKey, FundShares>(&arg2.id, v6).fund_coin_seqs, b"platform", &v0)
        } else {
            0x2::object::id_from_address(@0x0)
        };
        (arg0.price, v0, v2, v5, arg0.owner, arg3.referrer, arg4.referrer)
    }

    public fun get_payment_data_v2(arg0: &Chapter, arg1: &Dao, arg2: &Platform, arg3: &User, arg4: &User) : (u64, 0x1::string::String, 0x2::object::ID, 0x2::object::ID, address, address, address, u64) {
        ensure_contract_version(arg2);
        let v0 = arg0.coin_type;
        let v1 = AuthorFundKey{dummy_field: false};
        let v2 = if (0x2::dynamic_object_field::exists<AuthorFundKey>(&arg1.id, v1)) {
            let v3 = AuthorFundKey{dummy_field: false};
            derived_fund_id(&0x2::dynamic_object_field::borrow<AuthorFundKey, FundShares>(&arg1.id, v3).fund_coin_seqs, b"team", &v0)
        } else {
            0x2::object::id_from_address(@0x0)
        };
        let v4 = PlatformFundKey{dummy_field: false};
        let v5 = if (0x2::dynamic_object_field::exists<PlatformFundKey>(&arg2.id, v4)) {
            let v6 = PlatformFundKey{dummy_field: false};
            derived_fund_id(&0x2::dynamic_object_field::borrow<PlatformFundKey, FundShares>(&arg2.id, v6).fund_coin_seqs, b"platform", &v0)
        } else {
            0x2::object::id_from_address(@0x0)
        };
        let v7 = ChapterMemberPriceKey{dummy_field: false};
        let v8 = if (0x2::dynamic_field::exists<ChapterMemberPriceKey>(&arg0.id, v7)) {
            let v9 = ChapterMemberPriceKey{dummy_field: false};
            *0x2::dynamic_field::borrow<ChapterMemberPriceKey, u64>(&arg0.id, v9)
        } else {
            0
        };
        (arg0.price, v0, v2, v5, arg0.owner, arg3.referrer, arg4.referrer, v8)
    }

    public fun get_reader_points(arg0: &Platform, arg1: &User) : u64 {
        ensure_contract_version(arg0);
        0x2::balance::value<POINT>(&arg1.points_balance)
    }

    public fun get_reader_points_earned(arg0: &Platform, arg1: &User) : u64 {
        ensure_contract_version(arg0);
        arg1.points_earned_cumulative
    }

    public fun get_user_agreement_version(arg0: &Platform) : u8 {
        ensure_contract_version(arg0);
        arg0.user_agreement_version
    }

    public fun get_user_pubkeys_snapshot(arg0: &Platform, arg1: &Registry, arg2: address) : (bool, vector<u8>, vector<u8>) {
        ensure_contract_version(arg0);
        if (!0x2::dynamic_field::exists<address>(&arg1.id, arg2)) {
            return (false, b"", b"")
        };
        let v0 = 0x2::dynamic_field::borrow<address, UserInfo>(&arg1.id, arg2);
        (true, v0.auto_pubkey, v0.encrypt_pubkey)
    }

    public fun get_user_register_snapshot(arg0: &Platform, arg1: &Registry, arg2: address) : (bool, 0x2::object::ID, u8, 0x1::string::String) {
        ensure_contract_version(arg0);
        let v0 = if (0x2::dynamic_field::exists<address>(&arg1.id, arg2)) {
            0x2::dynamic_field::borrow<address, UserInfo>(&arg1.id, arg2).user_id
        } else {
            0x2::object::id_from_address(@0x0)
        };
        let v1 = arg0.user_agreement_version;
        (v0 != 0x2::object::id_from_address(@0x0), v0, v1, 0x2::dynamic_object_field::borrow<u8, UserAgreementContent>(&arg0.id, v1).content)
    }

    fun has_valid_referrer(arg0: &User) : bool {
        if (arg0.referrer != @0x0) {
            if (arg0.referrer != arg0.owner) {
                arg0.referral_time > 0
            } else {
                false
            }
        } else {
            false
        }
    }

    fun init(arg0: DENOVEL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = AdminCap{id: 0x2::object::new(arg1)};
        let v2 = 0x2::object::new(arg1);
        let v3 = 0x2::object::uid_to_inner(&v2);
        let v4 = Contacts{
            x        : 0x1::string::utf8(b""),
            discord  : 0x1::string::utf8(b""),
            telegram : 0x1::string::utf8(b""),
        };
        let v5 = DaoJoinRequirements{min_platform_points: 0};
        let v6 = DaoMemberPolicy{
            fee_required      : 0,
            fee_coin_type     : 0x1::string::utf8(b""),
            member_duration   : 0,
            join_requirements : v5,
        };
        let v7 = Dao{
            id                      : v2,
            owner                   : v0,
            name                    : 0x1::string::utf8(b"DeNovel.DAO"),
            intro                   : 0x1::string::utf8(b"Official DAO"),
            is_private              : false,
            age_rating              : 0,
            contacts                : v4,
            disabled                : false,
            member_policy           : v6,
            dao_member_change_seq   : 0,
            dao_denylist_change_seq : 0,
        };
        let v8 = DaoMember{member: v0};
        let v9 = DaoMemberData{joined_at: 0};
        0x2::dynamic_field::add<DaoMember, DaoMemberData>(&mut v7.id, v8, v9);
        v7.dao_member_change_seq = 1;
        let v10 = DaoMemberChanged{
            id        : 0x2::object::new(arg1),
            dao_id    : v3,
            member    : v0,
            action    : 0,
            reason    : 0x1::string::utf8(b""),
            operator  : v0,
            timestamp : 0x2::tx_context::epoch_timestamp_ms(arg1) / 1000,
            seq       : v7.dao_member_change_seq,
        };
        0x2::transfer::share_object<DaoMemberChanged>(v10);
        let v11 = SignalingServers{
            id   : 0x2::object::new(arg1),
            urls : 0x2::vec_set::empty<0x1::string::String>(),
        };
        let v12 = init_admin_user(v0, v3, arg1);
        let v13 = 0x2::object::id<User>(&v12);
        let v14 = ChangeShard{
            id          : 0x2::object::new(arg1),
            shard_index : 0,
            count       : 0,
        };
        let v15 = POINT{_seal: true};
        let v16 = 0x1::vector::empty<0x2::object::ID>();
        0x1::vector::push_back<0x2::object::ID>(&mut v16, 0x2::object::id<ChangeShard>(&v14));
        let v17 = PlatformReferral{
            referral_window1     : 30,
            referral_window2     : 60,
            referral_bps1        : 500,
            referral_bps2        : 250,
            referral_author_bps1 : 5000,
            referral_author_bps2 : 2500,
        };
        let v18 = PlatformComplaint{
            base_complaint_fee                  : 10,
            complaint_min_points_total          : 1,
            complaint_threshold                 : 50,
            max_closed_chapters_for_banned_work : 5,
        };
        let v19 = PlatformWorkConfig{
            max_banned_works_for_author          : 2,
            max_work_tags                        : 5,
            min_chapter_publish_interval_seconds : 0,
        };
        let v20 = Platform{
            id                              : 0x2::object::new(arg1),
            user_agreement_version          : 0,
            platform_fee_bps                : 2000,
            system_work_id                  : 0x2::object::id_from_address(@0x0),
            system_dao_id                   : v3,
            disabled                        : false,
            enabled_content_types           : 0x2::vec_set::empty<u8>(),
            registration_mode               : 0,
            create_dao_without_work_allowed : false,
            admin_user_id                   : v13,
            platform_denylist_id            : 0x2::object::id_from_address(@0x0),
            referral                        : v17,
            complaint                       : v18,
            work                            : v19,
            change_shard_ids                : v16,
            points_supply                   : 0x2::balance::create_supply<POINT>(v15),
            pubkey_registry_id              : 0x2::object::id_from_address(@0x0),
            current_version                 : 16,
            current_package_id              : 0x2::object::id_from_address(0x1::type_name::defining_id<DENOVEL>()),
            pending_version                 : 0,
            pending_package_id              : 0x2::object::id_from_address(@0x0),
            registry_id                     : 0x2::object::id_from_address(@0x0),
            allowed_coins_id                : 0x2::object::id_from_address(@0x0),
            signaling_servers_id            : 0x2::object::id_from_address(@0x0),
            admin_cap_id                    : 0x2::object::id_from_address(@0x0),
        };
        let v21 = PlatformDenyList{
            id                  : 0x2::object::new(arg1),
            denylist_change_seq : 0,
        };
        v20.platform_denylist_id = 0x2::object::id<PlatformDenyList>(&v21);
        let v22 = PubKeyRegistry{id: 0x2::object::new(arg1)};
        v20.pubkey_registry_id = 0x2::object::id<PubKeyRegistry>(&v22);
        v20.admin_cap_id = 0x2::object::id<AdminCap>(&v1);
        v20.signaling_servers_id = 0x2::object::id<SignalingServers>(&v11);
        let v23 = &mut v14;
        record_object_change(v23, 19, 0x2::object::id<Platform>(&v20), arg1);
        let v24 = &mut v14;
        record_object_change(v24, 1, v3, arg1);
        let v25 = &mut v14;
        record_object_change(v25, 7, 0x2::object::id<DaoMemberChanged>(&v10), arg1);
        let v26 = &mut v14;
        record_object_change(v26, 0, v13, arg1);
        0x2::vec_set::insert<u8>(&mut v20.enabled_content_types, 0);
        let v27 = ContentTagsKey{content_type: 0};
        let v28 = ContentTags{
            id           : 0x2::derived_object::claim<ContentTagsKey>(&mut v20.id, v27),
            content_type : 0,
            list         : 0x2::vec_set::empty<0x1::string::String>(),
        };
        let v29 = 0x1::vector::empty<0x1::string::String>();
        let v30 = &mut v29;
        0x1::vector::push_back<0x1::string::String>(v30, 0x1::string::utf8(x"e78e84e5b9bb"));
        0x1::vector::push_back<0x1::string::String>(v30, 0x1::string::utf8(x"e8a880e68385"));
        0x1::vector::push_back<0x1::string::String>(v30, 0x1::string::utf8(x"e983bde5b882"));
        0x1::vector::push_back<0x1::string::String>(v30, 0x1::string::utf8(x"e7a791e5b9bb"));
        0x1::vector::push_back<0x1::string::String>(v30, 0x1::string::utf8(x"e6ada6e4bea0"));
        0x1::vector::push_back<0x1::string::String>(v30, 0x1::string::utf8(x"e682ace79691"));
        0x1::vector::push_back<0x1::string::String>(v30, 0x1::string::utf8(x"e58e86e58fb2"));
        0x1::vector::push_back<0x1::string::String>(v30, 0x1::string::utf8(x"e6b8b8e6888f"));
        0x1::vector::push_back<0x1::string::String>(v30, 0x1::string::utf8(x"e8bdbbe5b08fe8afb4"));
        0x1::vector::push_back<0x1::string::String>(v30, 0x1::string::utf8(x"e585ace5918a"));
        let v31 = 0;
        while (v31 < 0x1::vector::length<0x1::string::String>(&v29)) {
            0x2::vec_set::insert<0x1::string::String>(&mut v28.list, *0x1::vector::borrow<0x1::string::String>(&v29, v31));
            v31 = v31 + 1;
        };
        v12.work_count = v12.work_count + 1;
        let v32 = 0x1::vector::empty<0x1::string::String>();
        0x1::vector::push_back<0x1::string::String>(&mut v32, 0x1::string::utf8(x"e585ace5918a"));
        let v33 = Work{
            id                        : 0x2::object::new(arg1),
            owner                     : v0,
            content_type              : 0,
            dao_id                    : v3,
            name                      : 0x1::string::utf8(x"44654e6f76656c20e585ace5918ae69dbf"),
            intro                     : 0x1::string::utf8(x"e5b9b3e58fb0e585ace5918ae4b88ee7b3bbe7bb9fe9809ae79fa5"),
            tags                      : v32,
            age_rating                : 0,
            closed_chapter_count      : 0,
            banned                    : false,
            payers_count              : 0,
            disabled                  : false,
            cover                     : 0x1::option::none<0x2::object::ID>(),
            cover_mime_type           : 0x1::string::utf8(b""),
            published_at              : 0x2::tx_context::epoch_timestamp_ms(arg1) / 1000,
            chapter_count             : 0,
            last_chapter_published_at : 0,
        };
        let v34 = 0x2::object::id<Work>(&v33);
        v20.system_work_id = v34;
        0x2::transfer::share_object<Work>(v33);
        let v35 = &mut v14;
        record_object_change(v35, 5, v34, arg1);
        let v36 = UserWork{dummy_field: false};
        0x2::dynamic_field::add<0x2::object::ID, UserWork>(&mut v12.id, v34, v36);
        let v37 = DaoWork{dummy_field: false};
        0x2::dynamic_field::add<0x2::object::ID, DaoWork>(&mut v7.id, v34, v37);
        let v38 = init_allowed_coins(arg1);
        v20.allowed_coins_id = 0x2::object::id<AllowedCoins>(&v38);
        let v39 = Registry{id: 0x2::object::new(arg1)};
        v20.registry_id = 0x2::object::id<Registry>(&v39);
        let v40 = NameKey{name: 0x1::string::utf8(b"denovel.system")};
        0x2::dynamic_field::add<NameKey, address>(&mut v39.id, v40, v0);
        let v41 = NameKey{name: 0x1::string::utf8(b"denovel.admin")};
        0x2::dynamic_field::add<NameKey, address>(&mut v39.id, v41, v0);
        let v42 = NameKey{name: 0x1::string::utf8(b"DeNovelBoard")};
        0x2::dynamic_field::add<NameKey, address>(&mut v39.id, v42, v0);
        let v43 = UserInfo{
            user_id        : v13,
            auto_pubkey    : v12.auto_pubkey,
            encrypt_pubkey : v12.encrypt_pubkey,
        };
        0x2::dynamic_field::add<address, UserInfo>(&mut v39.id, v0, v43);
        let v44 = create_user_cap(arg1);
        v44.owner = v0;
        let v45 = WorkDepositAmountKey{dummy_field: false};
        0x2::dynamic_field::add<WorkDepositAmountKey, u64>(&mut v20.id, v45, 0);
        let v46 = WorkDepositRefundSecondsKey{dummy_field: false};
        0x2::dynamic_field::add<WorkDepositRefundSecondsKey, u64>(&mut v20.id, v46, 0);
        let v47 = WorkDepositCoinTypeKey{dummy_field: false};
        0x2::dynamic_field::add<WorkDepositCoinTypeKey, 0x1::string::String>(&mut v20.id, v47, default_work_deposit_coin_type());
        let v48 = RandomOutletBpsKey{dummy_field: false};
        0x2::dynamic_field::add<RandomOutletBpsKey, u16>(&mut v20.id, v48, 2500);
        0x2::transfer::share_object<User>(v12);
        0x2::transfer::transfer<UserCap>(v44, v0);
        0x2::transfer::share_object<Platform>(v20);
        let v49 = &mut v14;
        record_object_change(v49, 20, 0x2::object::id<AllowedCoins>(&v38), arg1);
        let v50 = &mut v14;
        record_object_change(v50, 21, 0x2::object::id<ContentTags>(&v28), arg1);
        let v51 = &mut v14;
        record_object_change(v51, 22, 0x2::object::id<SignalingServers>(&v11), arg1);
        0x2::transfer::share_object<ChangeShard>(v14);
        0x2::transfer::share_object<Dao>(v7);
        0x2::transfer::share_object<PlatformDenyList>(v21);
        0x2::transfer::share_object<ContentTags>(v28);
        0x2::transfer::share_object<SignalingServers>(v11);
        0x2::transfer::share_object<AllowedCoins>(v38);
        0x2::transfer::share_object<Registry>(v39);
        0x2::transfer::share_object<PubKeyRegistry>(v22);
        0x2::transfer::transfer<AdminCap>(v1, v0);
    }

    fun init_admin_user(arg0: address, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) : User {
        let v0 = UserAgreementSign{
            sign_pubkey : b"",
            signature   : b"",
            version     : 0,
        };
        let v1 = UserHosting{
            state    : 0,
            provider : @0x0,
        };
        User{
            id                       : 0x2::object::new(arg2),
            owner                    : arg0,
            name                     : 0x1::string::utf8(b"denovel.admin"),
            intro                    : 0x1::string::utf8(b"DeNovel Admin"),
            avatar                   : 0x1::option::none<0x2::object::ID>(),
            avatar_mime_type         : 0x1::string::utf8(b""),
            referrer                 : @0x0,
            referral_time            : 0,
            agreement                : v0,
            dao_id                   : 0x1::option::some<0x2::object::ID>(arg1),
            banned_work_count        : 0,
            encrypt_pubkey           : b"",
            auto_pubkey              : x"0000000000000000000000000000000000000000000000000000000000000000",
            complaint_count          : 0,
            age_confirm_signatures   : 0x2::table::new<u8, vector<u8>>(arg2),
            points_balance           : 0x2::balance::zero<POINT>(),
            page_key_paused          : false,
            hosting                  : v1,
            work_count               : 0,
            points_earned_cumulative : 0,
            node_disabled            : false,
            author_service_disabled  : false,
        }
    }

    fun init_allowed_coins(arg0: &mut 0x2::tx_context::TxContext) : AllowedCoins {
        AllowedCoins{
            id      : 0x2::object::new(arg0),
            symbols : 0x2::vec_set::empty<0x1::string::String>(),
        }
    }

    entry fun init_platform_fund<T0: drop>(arg0: &mut Platform, arg1: &0x2::coin_registry::Currency<T0>, arg2: &AdminCap, arg3: &mut ChangeShard, arg4: &mut 0x2::tx_context::TxContext) {
        ensure_contract_version(arg0);
        assert_shard_matches(arg0, arg3, arg4);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = coin_type_from_type<T0>();
        ensure_platform_fund_ledger(arg0, v0, arg4);
        let v2 = fund_coin_key(b"platform", v1);
        let v3 = PlatformFundKey{dummy_field: false};
        if (0x2::table::contains<0x1::string::String, 0x2::object::ID>(&0x2::dynamic_object_field::borrow<PlatformFundKey, FundShares>(&arg0.id, v3).fund_coin_seqs, v2)) {
            return
        };
        let v4 = fund_new_platform<T0>(v0, v1, coin_decimals_from_currency<T0>(arg1), arg4);
        let v5 = 0x2::object::id<NovelFund<T0>>(&v4);
        let v6 = PlatformFundKey{dummy_field: false};
        0x2::table::add<0x1::string::String, 0x2::object::ID>(&mut 0x2::dynamic_object_field::borrow_mut<PlatformFundKey, FundShares>(&mut arg0.id, v6).fund_coin_seqs, v2, v5);
        0x2::transfer::share_object<NovelFund<T0>>(v4);
        record_object_change(arg3, 3, v5, arg4);
    }

    public fun is_name_taken(arg0: &Platform, arg1: &Registry, arg2: 0x1::string::String) : bool {
        ensure_contract_version(arg0);
        let v0 = normalize_name(arg2);
        if (0x1::string::length(&v0) == 0) {
            false
        } else {
            let v2 = NameKey{name: v0};
            0x2::dynamic_field::exists<NameKey>(&arg1.id, v2)
        }
    }

    fun ledger_assert_has_share(arg0: &FundShares, arg1: address) {
        assert!(ledger_share(arg0, arg1) > 0, 1113);
    }

    fun ledger_share(arg0: &FundShares, arg1: address) : u64 {
        let v0 = FundMemberShareKey{user: arg1};
        if (!0x2::dynamic_field::exists<FundMemberShareKey>(&arg0.id, v0)) {
            0
        } else {
            let v2 = FundMemberShareKey{user: arg1};
            0x2::dynamic_field::borrow<FundMemberShareKey, FundMemberShareData>(&arg0.id, v2).shares
        }
    }

    entry fun member_leave_dao(arg0: &Platform, arg1: &PlatformDenyList, arg2: &mut Dao, arg3: &User, arg4: &0x2::clock::Clock, arg5: &mut ChangeShard, arg6: &mut 0x2::tx_context::TxContext) {
        ensure_contract_version(arg0);
        assert_shard_matches(arg0, arg5, arg6);
        assert!(!arg0.disabled, 1091);
        let v0 = 0x2::tx_context::sender(arg6);
        assert!(!0x2::dynamic_field::exists<address>(&arg1.id, v0), 1021);
        let v1 = DaoDenylistKey{user: v0};
        assert!(!0x2::dynamic_field::exists<DaoDenylistKey>(&arg2.id, v1), 1021);
        assert!(v0 == arg3.owner, 1032);
        assert!(v0 != arg2.owner, 1009);
        let v2 = DaoMember{member: v0};
        assert!(0x2::dynamic_field::exists<DaoMember>(&arg2.id, v2), 1036);
        let v3 = DaoMember{member: v0};
        0x2::dynamic_field::remove<DaoMember, DaoMemberData>(&mut arg2.id, v3);
        create_dao_member_changed(arg2, arg5, v0, 1, 0x1::string::utf8(b""), v0, 0x2::clock::timestamp_ms(arg4) / 1000, arg6);
    }

    fun mint_points_for_pay(arg0: &mut Platform, arg1: &mut User, arg2: u64, arg3: u8, arg4: u64, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x2::object::ID, arg8: &mut ChangeShard, arg9: &mut 0x2::tx_context::TxContext) {
        if (arg2 == 0) {
            return
        };
        let v0 = 1;
        let v1 = 0;
        while (v1 < arg3 && v0 <= 34028236692093846346337460743176821145) {
            v0 = v0 * 10;
            v1 = v1 + 1;
        };
        let v2 = (arg2 as u128) * 10 / v0;
        if (v2 == 0 || v2 > 18446744073709551615) {
            return
        };
        0x2::balance::join<POINT>(&mut arg1.points_balance, 0x2::balance::increase_supply<POINT>(&mut arg0.points_supply, (v2 as u64)));
        arg1.points_earned_cumulative = arg1.points_earned_cumulative + (v2 as u64);
        let v3 = FinancialPart{
            part_type   : 1,
            wallet_addr : @0x0,
            obj_id      : 0x2::object::id<Platform>(arg0),
        };
        let v4 = FinancialPart{
            part_type   : 0,
            wallet_addr : arg1.owner,
            obj_id      : 0x2::object::id_from_address(@0x0),
        };
        create_financial_record(6, 0, v3, v4, coin_type_from_type<POINT>(), 0, (v2 as u64), arg7, 1, 0x2::object::id_from_address(@0x0), arg4, arg5, arg6, 0x2::object::id<User>(arg1), arg8, arg9, 0);
        record_object_change(arg8, 0, 0x2::object::id<User>(arg1), arg9);
    }

    fun new_dao(arg0: &PlatformDenyList, arg1: &mut Registry, arg2: &mut User, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: &mut ChangeShard, arg9: &mut 0x2::tx_context::TxContext) : Dao {
        let v0 = arg2.owner;
        assert!(!0x2::dynamic_field::exists<address>(&arg0.id, 0x2::tx_context::sender(arg9)), 1021);
        let v1 = 0x2::object::new(arg9);
        assert!(0x1::option::is_none<0x2::object::ID>(&arg2.dao_id), 1009);
        arg2.dao_id = 0x1::option::some<0x2::object::ID>(0x2::object::uid_to_inner(&v1));
        let v2 = Contacts{
            x        : arg5,
            discord  : arg6,
            telegram : arg7,
        };
        let v3 = DaoJoinRequirements{min_platform_points: 0};
        let v4 = DaoMemberPolicy{
            fee_required      : 0,
            fee_coin_type     : 0x1::string::utf8(b""),
            member_duration   : 0,
            join_requirements : v3,
        };
        let v5 = Dao{
            id                      : v1,
            owner                   : v0,
            name                    : check_and_register_name(arg1, arg3, v0),
            intro                   : arg4,
            is_private              : false,
            age_rating              : 0,
            contacts                : v2,
            disabled                : false,
            member_policy           : v4,
            dao_member_change_seq   : 0,
            dao_denylist_change_seq : 0,
        };
        let v6 = DaoMember{member: v0};
        let v7 = DaoMemberData{joined_at: 0};
        0x2::dynamic_field::add<DaoMember, DaoMemberData>(&mut v5.id, v6, v7);
        record_object_change(arg8, 1, 0x2::object::id<Dao>(&v5), arg9);
        record_object_change(arg8, 0, 0x2::object::id<User>(arg2), arg9);
        let v8 = &mut v5;
        let v9 = 0x2::tx_context::epoch_timestamp_ms(arg9) / 1000;
        create_dao_member_changed(v8, arg8, v0, 0, 0x1::string::utf8(b""), v0, v9, arg9);
        v5
    }

    fun new_fund_share<T0: copy + drop + store>(arg0: T0, arg1: &mut 0x2::object::UID, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : &mut FundShares {
        let v0 = FundShares{
            id              : 0x2::object::new(arg3),
            total_shares    : 10000,
            owner           : arg2,
            fund_coin_seqs  : 0x2::table::new<0x1::string::String, 0x2::object::ID>(arg3),
            fund_member_seq : 0,
        };
        let v1 = FundMemberShareKey{user: arg2};
        let v2 = FundMemberShareData{
            shares : 10000,
            role   : 0x1::string::utf8(b""),
        };
        0x2::dynamic_field::add<FundMemberShareKey, FundMemberShareData>(&mut v0.id, v1, v2);
        0x2::dynamic_object_field::add<T0, FundShares>(arg1, arg0, v0);
        0x2::dynamic_object_field::borrow_mut<T0, FundShares>(arg1, arg0)
    }

    fun normalize_name(arg0: 0x1::string::String) : 0x1::string::String {
        let v0 = 0x1::string::as_bytes(&arg0);
        let v1 = b"";
        let v2 = 0;
        while (v2 < 0x1::vector::length<u8>(v0)) {
            let v3 = *0x1::vector::borrow<u8>(v0, v2);
            if (v3 > 32) {
                0x1::vector::push_back<u8>(&mut v1, v3);
            };
            v2 = v2 + 1;
        };
        0x1::string::utf8(v1)
    }

    entry fun pay_for_chapter_with_coin<T0: drop>(arg0: &mut Platform, arg1: &PlatformDenyList, arg2: &Registry, arg3: 0x2::coin::Coin<T0>, arg4: &AllowedCoins, arg5: &0x2::coin_registry::Currency<T0>, arg6: &User, arg7: &Dao, arg8: &mut User, arg9: &User, arg10: 0x2::object::ID, arg11: &mut Work, arg12: &mut NovelFund<T0>, arg13: &mut NovelFund<T0>, arg14: &Chapter, arg15: &0x2::clock::Clock, arg16: &mut ChangeShard, arg17: &mut 0x2::tx_context::TxContext) {
        ensure_contract_version(arg0);
        assert_shard_matches(arg0, arg16, arg17);
        assert!(!arg0.disabled, 1091);
        pay_for_chapter_with_coin_core<T0>(arg0, arg1, arg2, arg3, arg4, coin_decimals_from_currency<T0>(arg5), arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17);
    }

    fun pay_for_chapter_with_coin_core<T0: drop>(arg0: &mut Platform, arg1: &PlatformDenyList, arg2: &Registry, arg3: 0x2::coin::Coin<T0>, arg4: &AllowedCoins, arg5: u8, arg6: &User, arg7: &Dao, arg8: &mut User, arg9: &User, arg10: 0x2::object::ID, arg11: &mut Work, arg12: &mut NovelFund<T0>, arg13: &mut NovelFund<T0>, arg14: &Chapter, arg15: &0x2::clock::Clock, arg16: &mut ChangeShard, arg17: &mut 0x2::tx_context::TxContext) {
        if (has_valid_referrer(arg8)) {
            assert!(arg9.owner == arg8.referrer, 1032);
        };
        if (has_valid_referrer(arg6)) {
            assert!(arg10 == registry_user_id_of(arg2, arg6.referrer), 1032);
        };
        pay_for_chapter_with_coin_impl<T0>(arg0, arg1, arg3, arg4, arg5, arg6, arg7, arg8, 0x1::option::some<0x2::object::ID>(0x2::object::id<User>(arg9)), arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17);
    }

    fun pay_for_chapter_with_coin_impl<T0: drop>(arg0: &mut Platform, arg1: &PlatformDenyList, arg2: 0x2::coin::Coin<T0>, arg3: &AllowedCoins, arg4: u8, arg5: &User, arg6: &Dao, arg7: &mut User, arg8: 0x1::option::Option<0x2::object::ID>, arg9: 0x2::object::ID, arg10: &mut Work, arg11: &mut NovelFund<T0>, arg12: &mut NovelFund<T0>, arg13: &Chapter, arg14: &0x2::clock::Clock, arg15: &mut ChangeShard, arg16: &mut 0x2::tx_context::TxContext) {
        assert!(arg5.hosting.state == 0 || arg5.hosting.state == 3, 2007);
        assert!(!arg5.node_disabled, 1047);
        assert!(!arg5.author_service_disabled, 1048);
        let v0 = 0x2::coin::value<T0>(&arg2);
        let (v1, v2, v3) = assert_chapter_payment_common<T0>(arg0, arg1, arg3, arg5, arg6, arg7, arg10, arg11, arg12, arg13, arg4, v0, arg14, 0x2::tx_context::sender(arg16));
        let v4 = bps_of(v0, arg0.platform_fee_bps);
        let v5 = resolve_reader_referral_bps(arg7, arg0, v1);
        let (v6, v7, v8, v9, v10) = split_chapter_payment_balances<T0>(arg2, v4, author_referral_fee_from_platform_fee(arg0, arg5, v1, v4), bps_of(v4, v5));
        let (v11, v12) = transfer_referral_fees<T0>(v8, v7, arg7, arg5, arg16);
        let v13 = arg10.name;
        let v14 = settle_chapter_payment_common<T0>(arg0, arg6, arg5, arg7, arg10, arg11, arg12, arg13, v6, v9, v2, arg4, v0, v4, v10, v11, v5, v3, v1, arg15, arg16);
        if (v11 > 0) {
            let v15 = 0x2::object::id<NovelFund<T0>>(arg11);
            let v16 = FinancialPart{
                part_type   : 1,
                wallet_addr : @0x0,
                obj_id      : v15,
            };
            let v17 = FinancialPart{
                part_type   : 0,
                wallet_addr : arg7.referrer,
                obj_id      : 0x2::object::id_from_address(@0x0),
            };
            create_dual_financial_record(1, 4, v16, v17, v2, arg4, v11, 0x2::object::id<Chapter>(arg13), 1, v14, v1, v13, arg13.title, v15, 0x1::option::destroy_some<0x2::object::ID>(arg8), arg15, arg16, 0);
        };
        record_author_referral_fee<T0>(1, 3, v12, v2, arg4, v1, v14, arg11, arg5, arg9, arg13, arg10, arg15, arg16);
    }

    entry fun pay_for_chapter_with_coin_with_hosting<T0: drop>(arg0: &mut Platform, arg1: &PlatformDenyList, arg2: &Registry, arg3: 0x2::coin::Coin<T0>, arg4: &AllowedCoins, arg5: &0x2::coin_registry::Currency<T0>, arg6: &User, arg7: &Dao, arg8: &mut User, arg9: &User, arg10: 0x2::object::ID, arg11: &User, arg12: &mut Work, arg13: &mut NovelFund<T0>, arg14: &mut NovelFund<T0>, arg15: &SelfHostedNode, arg16: &HostingProvider, arg17: &AuthorHostingAgreement, arg18: &Chapter, arg19: &0x2::clock::Clock, arg20: &mut ChangeShard, arg21: &mut 0x2::tx_context::TxContext) {
        ensure_contract_version(arg0);
        assert_shard_matches(arg0, arg20, arg21);
        assert!(!arg0.disabled, 1091);
        assert!(arg11.owner == arg17.provider, 1032);
        if (has_valid_referrer(arg8)) {
            assert!(arg9.owner == arg8.referrer, 1032);
        };
        if (has_valid_referrer(arg6)) {
            assert!(arg10 == registry_user_id_of(arg2, arg6.referrer), 1032);
        };
        let v0 = coin_decimals_from_currency<T0>(arg5);
        let (v1, v2, v3, v4) = pay_for_chapter_with_hosting_impl<T0>(arg0, arg1, arg3, arg4, v0, arg6, arg7, arg8, arg12, arg13, arg14, arg15, arg16, arg17, arg11.owner, arg11.node_disabled, arg18, arg19, arg20, arg21);
        let v5 = 0x2::object::id<Chapter>(arg18);
        let v6 = 0x2::object::id_from_address(@0x0);
        let v7 = coin_type_from_type<T0>();
        let v8 = empty_string();
        if (v2 > 0) {
            let v9 = FinancialPart{
                part_type   : 0,
                wallet_addr : arg8.owner,
                obj_id      : v6,
            };
            let v10 = FinancialPart{
                part_type   : 0,
                wallet_addr : arg17.provider,
                obj_id      : v6,
            };
            create_financial_record(1, 5, v9, v10, v7, v0, v2, v5, 1, v1, 0x2::clock::timestamp_ms(arg19) / 1000, v8, v8, 0x2::object::id<User>(arg11), arg20, arg21, 0);
        };
        if (v3 > 0) {
            let v11 = 0x2::object::id<NovelFund<T0>>(arg13);
            let v12 = FinancialPart{
                part_type   : 1,
                wallet_addr : @0x0,
                obj_id      : v11,
            };
            let v13 = FinancialPart{
                part_type   : 0,
                wallet_addr : arg8.referrer,
                obj_id      : v6,
            };
            create_dual_financial_record(1, 4, v12, v13, v7, v0, v3, v5, 1, v1, 0x2::clock::timestamp_ms(arg19) / 1000, arg12.name, arg18.title, v11, 0x2::object::id<User>(arg9), arg20, arg21, 0);
        };
        record_author_referral_fee<T0>(1, 3, v4, v7, v0, 0x2::clock::timestamp_ms(arg19) / 1000, v1, arg13, arg6, arg10, arg18, arg12, arg20, arg21);
    }

    entry fun pay_for_chapter_with_coin_with_hosting_reader_provider<T0: drop>(arg0: &mut Platform, arg1: &PlatformDenyList, arg2: &Registry, arg3: 0x2::coin::Coin<T0>, arg4: &AllowedCoins, arg5: &0x2::coin_registry::Currency<T0>, arg6: &User, arg7: &Dao, arg8: &mut User, arg9: &User, arg10: 0x2::object::ID, arg11: u8, arg12: &mut Work, arg13: &mut NovelFund<T0>, arg14: &mut NovelFund<T0>, arg15: &SelfHostedNode, arg16: &HostingProvider, arg17: &AuthorHostingAgreement, arg18: &Chapter, arg19: &0x2::clock::Clock, arg20: &mut ChangeShard, arg21: &mut 0x2::tx_context::TxContext) {
        ensure_contract_version(arg0);
        assert_shard_matches(arg0, arg20, arg21);
        assert!(!arg0.disabled, 1091);
        assert!(arg11 == 1, 2028);
        assert!(arg8.owner == arg17.provider, 1032);
        if (has_valid_referrer(arg8)) {
            assert!(arg9.owner == arg8.referrer, 1032);
        };
        if (has_valid_referrer(arg6)) {
            assert!(arg10 == registry_user_id_of(arg2, arg6.referrer), 1032);
        };
        let v0 = coin_decimals_from_currency<T0>(arg5);
        let v1 = arg8.owner;
        let v2 = arg8.node_disabled;
        let (v3, v4, v5, v6) = pay_for_chapter_with_hosting_impl<T0>(arg0, arg1, arg3, arg4, v0, arg6, arg7, arg8, arg12, arg13, arg14, arg15, arg16, arg17, v1, v2, arg18, arg19, arg20, arg21);
        let v7 = 0x2::object::id<Chapter>(arg18);
        let v8 = 0x2::object::id_from_address(@0x0);
        let v9 = coin_type_from_type<T0>();
        let v10 = empty_string();
        if (v4 > 0) {
            let v11 = FinancialPart{
                part_type   : 0,
                wallet_addr : arg8.owner,
                obj_id      : v8,
            };
            let v12 = FinancialPart{
                part_type   : 0,
                wallet_addr : arg17.provider,
                obj_id      : v8,
            };
            create_financial_record(1, 5, v11, v12, v9, v0, v4, v7, 1, v3, 0x2::clock::timestamp_ms(arg19) / 1000, v10, v10, 0x2::object::id<User>(arg8), arg20, arg21, 0);
        };
        if (v5 > 0) {
            let v13 = 0x2::object::id<NovelFund<T0>>(arg13);
            let v14 = FinancialPart{
                part_type   : 1,
                wallet_addr : @0x0,
                obj_id      : v13,
            };
            let v15 = FinancialPart{
                part_type   : 0,
                wallet_addr : arg8.referrer,
                obj_id      : v8,
            };
            create_dual_financial_record(1, 4, v14, v15, v9, v0, v5, v7, 1, v3, 0x2::clock::timestamp_ms(arg19) / 1000, arg12.name, arg18.title, v13, 0x2::object::id<User>(arg9), arg20, arg21, 0);
        };
        record_author_referral_fee<T0>(1, 3, v6, v9, v0, 0x2::clock::timestamp_ms(arg19) / 1000, v3, arg13, arg6, arg10, arg18, arg12, arg20, arg21);
    }

    entry fun pay_for_chapter_with_coin_without_referral<T0: drop>(arg0: &mut Platform, arg1: &PlatformDenyList, arg2: &Registry, arg3: 0x2::coin::Coin<T0>, arg4: &AllowedCoins, arg5: &0x2::coin_registry::Currency<T0>, arg6: &User, arg7: &Dao, arg8: &mut User, arg9: 0x2::object::ID, arg10: &mut Work, arg11: &mut NovelFund<T0>, arg12: &mut NovelFund<T0>, arg13: &Chapter, arg14: &0x2::clock::Clock, arg15: &mut ChangeShard, arg16: &mut 0x2::tx_context::TxContext) {
        ensure_contract_version(arg0);
        assert_shard_matches(arg0, arg15, arg16);
        assert!(!arg0.disabled, 1091);
        pay_for_chapter_with_coin_without_referral_core<T0>(arg0, arg1, arg2, arg3, arg4, coin_decimals_from_currency<T0>(arg5), arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16);
    }

    fun pay_for_chapter_with_coin_without_referral_core<T0: drop>(arg0: &mut Platform, arg1: &PlatformDenyList, arg2: &Registry, arg3: 0x2::coin::Coin<T0>, arg4: &AllowedCoins, arg5: u8, arg6: &User, arg7: &Dao, arg8: &mut User, arg9: 0x2::object::ID, arg10: &mut Work, arg11: &mut NovelFund<T0>, arg12: &mut NovelFund<T0>, arg13: &Chapter, arg14: &0x2::clock::Clock, arg15: &mut ChangeShard, arg16: &mut 0x2::tx_context::TxContext) {
        assert!(!has_valid_referrer(arg8), 1051);
        if (has_valid_referrer(arg6)) {
            assert!(arg9 == registry_user_id_of(arg2, arg6.referrer), 1032);
        };
        pay_for_chapter_with_coin_impl<T0>(arg0, arg1, arg3, arg4, arg5, arg6, arg7, arg8, 0x1::option::none<0x2::object::ID>(), arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16);
    }

    entry fun pay_for_chapter_with_coin_without_referral_with_hosting<T0: drop>(arg0: &mut Platform, arg1: &PlatformDenyList, arg2: &Registry, arg3: 0x2::coin::Coin<T0>, arg4: &AllowedCoins, arg5: &0x2::coin_registry::Currency<T0>, arg6: &User, arg7: &Dao, arg8: &mut User, arg9: 0x2::object::ID, arg10: &User, arg11: &mut Work, arg12: &mut NovelFund<T0>, arg13: &mut NovelFund<T0>, arg14: &SelfHostedNode, arg15: &HostingProvider, arg16: &AuthorHostingAgreement, arg17: &Chapter, arg18: &0x2::clock::Clock, arg19: &mut ChangeShard, arg20: &mut 0x2::tx_context::TxContext) {
        ensure_contract_version(arg0);
        assert_shard_matches(arg0, arg19, arg20);
        assert!(!arg0.disabled, 1091);
        assert!(!has_valid_referrer(arg8), 1051);
        assert!(arg10.owner == arg16.provider, 1032);
        if (has_valid_referrer(arg6)) {
            assert!(arg9 == registry_user_id_of(arg2, arg6.referrer), 1032);
        };
        let v0 = coin_decimals_from_currency<T0>(arg5);
        let (v1, v2, _, v4) = pay_for_chapter_with_hosting_impl<T0>(arg0, arg1, arg3, arg4, v0, arg6, arg7, arg8, arg11, arg12, arg13, arg14, arg15, arg16, arg10.owner, arg10.node_disabled, arg17, arg18, arg19, arg20);
        record_author_referral_fee<T0>(1, 3, v4, coin_type_from_type<T0>(), v0, 0x2::clock::timestamp_ms(arg18) / 1000, v1, arg12, arg6, arg9, arg17, arg11, arg19, arg20);
        if (v2 > 0) {
            let v5 = 0x2::object::id_from_address(@0x0);
            let v6 = empty_string();
            let v7 = FinancialPart{
                part_type   : 0,
                wallet_addr : arg8.owner,
                obj_id      : v5,
            };
            let v8 = FinancialPart{
                part_type   : 0,
                wallet_addr : arg16.provider,
                obj_id      : v5,
            };
            create_financial_record(1, 5, v7, v8, coin_type_from_type<T0>(), v0, v2, 0x2::object::id<Chapter>(arg17), 1, v1, 0x2::clock::timestamp_ms(arg18) / 1000, v6, v6, 0x2::object::id<User>(arg10), arg19, arg20, 0);
        };
    }

    entry fun pay_for_chapter_with_coin_without_referral_with_hosting_reader_provider<T0: drop>(arg0: &mut Platform, arg1: &PlatformDenyList, arg2: &Registry, arg3: 0x2::coin::Coin<T0>, arg4: &AllowedCoins, arg5: &0x2::coin_registry::Currency<T0>, arg6: &User, arg7: &Dao, arg8: &mut User, arg9: 0x2::object::ID, arg10: u8, arg11: &mut Work, arg12: &mut NovelFund<T0>, arg13: &mut NovelFund<T0>, arg14: &SelfHostedNode, arg15: &HostingProvider, arg16: &AuthorHostingAgreement, arg17: &Chapter, arg18: &0x2::clock::Clock, arg19: &mut ChangeShard, arg20: &mut 0x2::tx_context::TxContext) {
        ensure_contract_version(arg0);
        assert_shard_matches(arg0, arg19, arg20);
        assert!(!arg0.disabled, 1091);
        assert!(!has_valid_referrer(arg8), 1051);
        assert!(arg10 == 1, 2028);
        assert!(arg8.owner == arg16.provider, 1032);
        if (has_valid_referrer(arg6)) {
            assert!(arg9 == registry_user_id_of(arg2, arg6.referrer), 1032);
        };
        let v0 = coin_decimals_from_currency<T0>(arg5);
        let v1 = arg8.owner;
        let v2 = arg8.node_disabled;
        let (v3, v4, _, v6) = pay_for_chapter_with_hosting_impl<T0>(arg0, arg1, arg3, arg4, v0, arg6, arg7, arg8, arg11, arg12, arg13, arg14, arg15, arg16, v1, v2, arg17, arg18, arg19, arg20);
        record_author_referral_fee<T0>(1, 3, v6, coin_type_from_type<T0>(), v0, 0x2::clock::timestamp_ms(arg18) / 1000, v3, arg12, arg6, arg9, arg17, arg11, arg19, arg20);
        if (v4 > 0) {
            let v7 = 0x2::object::id_from_address(@0x0);
            let v8 = empty_string();
            let v9 = FinancialPart{
                part_type   : 0,
                wallet_addr : arg8.owner,
                obj_id      : v7,
            };
            let v10 = FinancialPart{
                part_type   : 0,
                wallet_addr : arg16.provider,
                obj_id      : v7,
            };
            create_financial_record(1, 5, v9, v10, coin_type_from_type<T0>(), v0, v4, 0x2::object::id<Chapter>(arg17), 1, v3, 0x2::clock::timestamp_ms(arg18) / 1000, v8, v8, 0x2::object::id<User>(arg8), arg19, arg20, 0);
        };
    }

    fun pay_for_chapter_with_hosting_impl<T0: drop>(arg0: &mut Platform, arg1: &PlatformDenyList, arg2: 0x2::coin::Coin<T0>, arg3: &AllowedCoins, arg4: u8, arg5: &User, arg6: &Dao, arg7: &mut User, arg8: &mut Work, arg9: &mut NovelFund<T0>, arg10: &mut NovelFund<T0>, arg11: &SelfHostedNode, arg12: &HostingProvider, arg13: &AuthorHostingAgreement, arg14: address, arg15: bool, arg16: &Chapter, arg17: &0x2::clock::Clock, arg18: &mut ChangeShard, arg19: &mut 0x2::tx_context::TxContext) : (0x2::object::ID, u64, u64, u64) {
        require_active_hosting(arg5);
        assert!(arg13.author == arg5.owner, 2008);
        assert!(arg13.provider == arg5.hosting.provider, 2008);
        assert!(!arg12.disabled, 2010);
        assert!(arg14 == arg12.owner, 1032);
        assert!(!arg15, 1047);
        assert!(!arg5.author_service_disabled, 1048);
        assert!(!0x2::dynamic_field::exists<address>(&arg1.id, arg14), 1021);
        assert!(arg11.owner == arg12.owner, 2010);
        assert!(arg12.hosted_node_id == 0x2::object::id<SelfHostedNode>(arg11), 2010);
        assert!(arg13.provider == arg12.owner, 2008);
        assert!(arg13.node_id == 0x2::object::id<SelfHostedNode>(arg11), 2008);
        assert!(arg13.active, 2003);
        assert!(arg13.suspension_state == 1, 2007);
        let v0 = 0x2::coin::value<T0>(&arg2);
        let v1 = bps_of(v0, arg13.commission_bps);
        let v2 = bps_of(v0, arg0.platform_fee_bps);
        let (v3, v4, v5) = assert_chapter_payment_common<T0>(arg0, arg1, arg3, arg5, arg6, arg7, arg8, arg9, arg10, arg16, arg4, v0, arg17, 0x2::tx_context::sender(arg19));
        let v6 = 0x2::coin::into_balance<T0>(arg2);
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v6, v1), arg19), arg13.provider);
        } else {
            0x2::balance::destroy_zero<T0>(0x2::balance::split<T0>(&mut v6, v1));
        };
        assert!((v0 as u128) > (v1 as u128) + (v2 as u128), 2006);
        let v7 = resolve_reader_referral_bps(arg7, arg0, v3);
        let (v8, v9, v10, v11, v12) = split_chapter_payment_balances<T0>(0x2::coin::from_balance<T0>(v6, arg19), v2, author_referral_fee_from_platform_fee(arg0, arg5, v3, v2), bps_of(v2, v7));
        let (v13, v14) = transfer_referral_fees<T0>(v10, v9, arg7, arg5, arg19);
        (settle_chapter_payment_common<T0>(arg0, arg6, arg5, arg7, arg8, arg9, arg10, arg16, v8, v11, v4, arg4, v0, v2, v12, v13, v7, v5, v3, arg18, arg19), v1, v13, v14)
    }

    fun platform_deposit<T0>(arg0: &Platform, arg1: &mut NovelFund<T0>, arg2: 0x2::balance::Balance<T0>) {
        let v0 = PlatformFundKey{dummy_field: false};
        fund_deposit<T0>(arg1, 0x2::dynamic_object_field::borrow<PlatformFundKey, FundShares>(&arg0.id, v0).total_shares, arg2);
    }

    fun platform_fund_claim<T0: drop>(arg0: &Platform, arg1: &mut NovelFund<T0>, arg2: address) : 0x2::balance::Balance<T0> {
        let v0 = PlatformFundKey{dummy_field: false};
        fund_claim_impl<T0>(arg1, arg2, ledger_share(0x2::dynamic_object_field::borrow<PlatformFundKey, FundShares>(&arg0.id, v0), arg2))
    }

    entry fun publish_chapter<T0: drop>(arg0: &Platform, arg1: &PlatformDenyList, arg2: &mut User, arg3: &mut Dao, arg4: &mut Work, arg5: &AllowedCoins, arg6: &0x2::coin_registry::Currency<T0>, arg7: u64, arg8: u8, arg9: u64, arg10: 0x1::string::String, arg11: 0x1::string::String, arg12: vector<u8>, arg13: 0x1::string::String, arg14: vector<u8>, arg15: 0x1::string::String, arg16: 0x1::string::String, arg17: 0x1::string::String, arg18: &0x2::clock::Clock, arg19: &mut ChangeShard, arg20: &mut 0x2::tx_context::TxContext) {
        ensure_contract_version(arg0);
        assert_shard_matches(arg0, arg19, arg20);
        publish_chapter_impl<T0>(arg0, arg1, arg2, arg3, arg4, arg5, coin_decimals_from_currency<T0>(arg6), arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20);
    }

    fun publish_chapter_impl<T0: drop>(arg0: &Platform, arg1: &PlatformDenyList, arg2: &mut User, arg3: &mut Dao, arg4: &mut Work, arg5: &AllowedCoins, arg6: u8, arg7: u64, arg8: u8, arg9: u64, arg10: 0x1::string::String, arg11: 0x1::string::String, arg12: vector<u8>, arg13: 0x1::string::String, arg14: vector<u8>, arg15: 0x1::string::String, arg16: 0x1::string::String, arg17: 0x1::string::String, arg18: &0x2::clock::Clock, arg19: &mut ChangeShard, arg20: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg20);
        assert!(!0x2::dynamic_field::exists<address>(&arg1.id, v0), 1021);
        assert!(!0x2::dynamic_field::exists<address>(&arg1.id, arg2.owner), 1021);
        assert!(!arg0.disabled, 1091);
        assert!(0x1::string::length(&arg17) == 36, 1071);
        assert!(!arg3.disabled, 1043);
        assert!(!arg2.page_key_paused, 1070);
        assert!(arg2.banned_work_count < arg0.work.max_banned_works_for_author, 1042);
        assert!(arg4.owner == arg2.owner, 1009);
        assert!(arg3.owner == arg2.owner, 1009);
        assert!(0x1::option::is_some<0x2::object::ID>(&arg2.dao_id), 1009);
        assert!(0x2::object::id<Dao>(arg3) == *0x1::option::borrow<0x2::object::ID>(&arg2.dao_id), 1009);
        assert!(0x2::object::id<Dao>(arg3) == arg4.dao_id, 1009);
        assert!(!arg4.disabled, 1045);
        assert!(!arg4.banned, 1004);
        ensure_auto_wallet_sender(arg2, v0);
        let v1 = coin_type_from_type<T0>();
        assert!(0x2::vec_set::contains<0x1::string::String>(&arg5.symbols, &v1), 1006);
        assert!(0x1::vector::length<u8>(&arg12) == 32, 1029);
        let v2 = ChapterUuidKey{value: arg17};
        assert!(!0x2::dynamic_field::exists<ChapterUuidKey>(&arg2.id, v2), 1086);
        let v3 = ChapterContentHashKey{value: arg12};
        assert!(!0x2::dynamic_field::exists<ChapterContentHashKey>(&arg2.id, v3), 1087);
        assert!(0x1::vector::length<u8>(0x1::string::as_bytes(&arg13)) > 0, 1031);
        assert!(0x1::vector::length<u8>(&arg14) > 0, 1031);
        chapter_policy_assert_price_match(arg7, arg8, arg9);
        let v4 = 0x2::clock::timestamp_ms(arg18) / 1000;
        assert!(v4 >= arg4.last_chapter_published_at, 1106);
        if (arg0.work.min_chapter_publish_interval_seconds > 0) {
            assert!(v4 - arg4.last_chapter_published_at >= arg0.work.min_chapter_publish_interval_seconds, 1092);
        };
        create_dao_fund_impl<T0>(arg3, arg6, b"team", 1, arg19, arg20);
        arg4.last_chapter_published_at = v4;
        let v5 = arg4.chapter_count;
        arg4.chapter_count = v5 + 1;
        let v6 = Chapter{
            id            : 0x2::object::new(arg20),
            uuid          : arg17,
            owner         : arg2.owner,
            dao_id        : 0x2::object::id<Dao>(arg3),
            work_id       : 0x2::object::id<Work>(arg4),
            part_name     : arg10,
            title         : arg11,
            preview       : arg13,
            content_hash  : arg12,
            published_at  : v4,
            mime_type     : arg15,
            coin_type     : v1,
            coin_decimals : arg6,
            price         : arg7,
            policy        : arg8,
            banned        : false,
            complained    : 0x2::table::new<address, 0x2::object::ID>(arg20),
            seqno         : v5,
        };
        let v7 = 0x2::object::id<Chapter>(&v6);
        0x2::dynamic_field::add<ChapterUuidKey, 0x2::object::ID>(&mut arg2.id, v2, v7);
        0x2::dynamic_field::add<ChapterContentHashKey, 0x2::object::ID>(&mut arg2.id, v3, v7);
        if (arg8 == 4) {
            let v8 = ChapterMemberPriceKey{dummy_field: false};
            0x2::dynamic_field::add<ChapterMemberPriceKey, u64>(&mut v6.id, v8, arg9);
        };
        0x2::transfer::share_object<Chapter>(v6);
        let v9 = ChapterContent{
            id             : 0x2::object::new(arg20),
            owner          : arg2.owner,
            work_id        : 0x2::object::id<Work>(arg4),
            chapter_uuid   : 0x1::string::utf8(*0x1::string::as_bytes(&v6.uuid)),
            bytes          : arg14,
            mime_type      : 0x1::string::utf8(*0x1::string::as_bytes(&v6.mime_type)),
            encrypt_pubkey : 0x1::string::utf8(*0x1::string::as_bytes(&arg16)),
            created_at     : v4,
        };
        0x2::transfer::share_object<ChapterContent>(v9);
        record_object_change(arg19, 16, 0x2::object::id<ChapterContent>(&v9), arg20);
        record_object_change(arg19, 6, v7, arg20);
        record_object_change(arg19, 5, 0x2::object::id<Work>(arg4), arg20);
    }

    entry fun publish_self_hosted_node_v2(arg0: &Platform, arg1: &PlatformDenyList, arg2: &mut PubKeyRegistry, arg3: 0x1::string::String, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: &mut User, arg8: &mut ChangeShard, arg9: &mut 0x2::tx_context::TxContext) {
        ensure_contract_version(arg0);
        assert_shard_matches(arg0, arg8, arg9);
        assert!(!arg0.disabled, 1091);
        assert!(arg7.owner == 0x2::tx_context::sender(arg9), 1032);
        assert!(arg7.hosting.state == 0, 2004);
        assert!(!0x2::dynamic_field::exists<address>(&arg1.id, arg7.owner), 1021);
        assert!(!arg7.node_disabled, 1047);
        assert!(!arg7.author_service_disabled, 1048);
        let v0 = if (0x1::vector::length<u8>(&arg5) == 32) {
            true
        } else if (0x1::vector::length<u8>(&arg5) == 33) {
            true
        } else {
            0x1::vector::length<u8>(&arg5) == 34
        };
        assert!(v0, 1017);
        assert!(0x1::vector::length<u8>(&arg6) == 32, 1017);
        assert!(0x1::vector::length<u8>(&arg4) > 0, 1017);
        assert!(0x1::string::length(&arg3) > 0, 2014);
        register_pubkey(arg2, arg4, 0x2::tx_context::sender(arg9));
        register_pubkey(arg2, arg5, 0x2::tx_context::sender(arg9));
        register_pubkey(arg2, arg6, 0x2::tx_context::sender(arg9));
        let v1 = SelfHostedNode{
            id                          : 0x2::object::new(arg9),
            owner                       : 0x2::tx_context::sender(arg9),
            ip                          : arg3,
            port                        : 0,
            active                      : true,
            sync_public_key             : arg4,
            active_agreement_count      : 0,
            provider_registration_count : 0,
            node_encrypt_pubkey         : arg5,
            node_sign_pubkey            : arg6,
        };
        arg7.hosting.state = 3;
        0x2::transfer::share_object<SelfHostedNode>(v1);
        record_object_change(arg8, 2, 0x2::object::id<SelfHostedNode>(&v1), arg9);
        record_object_change(arg8, 0, 0x2::object::id<User>(arg7), arg9);
    }

    fun publish_work<T0: drop>(arg0: &Platform, arg1: &PlatformDenyList, arg2: &ContentTags, arg3: &mut User, arg4: &mut Dao, arg5: &0x2::clock::Clock, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: vector<0x1::string::String>, arg9: u8, arg10: u8, arg11: 0x1::option::Option<0x2::coin::Coin<T0>>, arg12: &AllowedCoins, arg13: &mut ChangeShard, arg14: &mut 0x2::tx_context::TxContext) {
        publish_work_impl<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, true, arg11, arg12, arg13, arg14);
    }

    fun publish_work_impl<T0: drop>(arg0: &Platform, arg1: &PlatformDenyList, arg2: &ContentTags, arg3: &mut User, arg4: &mut Dao, arg5: &0x2::clock::Clock, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: vector<0x1::string::String>, arg9: u8, arg10: u8, arg11: bool, arg12: 0x1::option::Option<0x2::coin::Coin<T0>>, arg13: &AllowedCoins, arg14: &mut ChangeShard, arg15: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg15);
        assert!(!0x2::dynamic_field::exists<address>(&arg1.id, v0), 1021);
        assert!(!0x2::dynamic_field::exists<address>(&arg1.id, arg3.owner), 1021);
        assert!(!arg0.disabled, 1091);
        assert!(0x2::vec_set::contains<u8>(&arg0.enabled_content_types, &arg10), 2011);
        assert!(!arg4.disabled, 1043);
        if (arg11) {
            assert!(!arg3.page_key_paused, 1070);
            ensure_auto_wallet_sender(arg3, v0);
        };
        assert!(arg4.owner == arg3.owner, 1009);
        assert!(0x1::option::is_some<0x2::object::ID>(&arg3.dao_id), 1009);
        assert!(0x2::object::id<Dao>(arg4) == *0x1::option::borrow<0x2::object::ID>(&arg3.dao_id), 1009);
        assert!(arg3.banned_work_count < arg0.work.max_banned_works_for_author, 1041);
        assert!(0x1::vector::length<u8>(0x1::string::as_bytes(&arg6)) > 0, 1026);
        assert!(0x1::vector::length<u8>(0x1::string::as_bytes(&arg7)) > 0, 1027);
        let v1 = if (arg9 == 0) {
            true
        } else if (arg9 == 1) {
            true
        } else if (arg9 == 2) {
            true
        } else {
            arg9 == 3
        };
        assert!(v1, 1028);
        let v2 = 0x1::vector::length<0x1::string::String>(&arg8);
        assert!(v2 > 0, 1066);
        assert!(v2 <= (arg0.work.max_work_tags as u64), 1058);
        assert!(arg2.content_type == arg10, 1059);
        let v3 = 0;
        while (v3 < v2) {
            assert!(0x2::vec_set::contains<0x1::string::String>(&arg2.list, 0x1::vector::borrow<0x1::string::String>(&arg8, v3)), 1059);
            v3 = v3 + 1;
        };
        let v4 = 0x2::object::id<Dao>(arg4);
        let v5 = 0x2::clock::timestamp_ms(arg5) / 1000;
        if (arg9 > arg4.age_rating) {
            arg4.age_rating = arg9;
            record_object_change(arg14, 1, v4, arg15);
        };
        arg3.work_count = arg3.work_count + 1;
        let v6 = Work{
            id                        : 0x2::object::new(arg15),
            owner                     : arg3.owner,
            content_type              : arg10,
            dao_id                    : v4,
            name                      : arg6,
            intro                     : arg7,
            tags                      : arg8,
            age_rating                : arg9,
            closed_chapter_count      : 0,
            banned                    : false,
            payers_count              : 0,
            disabled                  : false,
            cover                     : 0x1::option::none<0x2::object::ID>(),
            cover_mime_type           : 0x1::string::utf8(b""),
            published_at              : v5,
            chapter_count             : 0,
            last_chapter_published_at : 0,
        };
        let v7 = 0x2::object::id<Work>(&v6);
        0x2::transfer::share_object<Work>(v6);
        record_object_change(arg14, 5, v7, arg15);
        charge_work_deposit<T0>(arg0, arg13, arg3.owner, arg12, v7, v5, arg14, arg15);
        if (!0x2::dynamic_field::exists<0x2::object::ID>(&arg3.id, v7)) {
            let v8 = UserWork{dummy_field: false};
            0x2::dynamic_field::add<0x2::object::ID, UserWork>(&mut arg3.id, v7, v8);
        };
        if (!0x2::dynamic_field::exists<0x2::object::ID>(&arg4.id, v7)) {
            let v9 = DaoWork{dummy_field: false};
            0x2::dynamic_field::add<0x2::object::ID, DaoWork>(&mut arg4.id, v7, v9);
        };
        record_object_change(arg14, 0, 0x2::object::id<User>(arg3), arg15);
        ensure_author_fund_ledger(arg4, arg14, arg15);
    }

    entry fun publish_work_with_create_dao<T0: drop>(arg0: &Platform, arg1: &PlatformDenyList, arg2: &mut Registry, arg3: &ContentTags, arg4: &mut User, arg5: &0x2::clock::Clock, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: vector<0x1::string::String>, arg9: u8, arg10: u8, arg11: 0x1::option::Option<0x2::coin::Coin<T0>>, arg12: &AllowedCoins, arg13: &mut ChangeShard, arg14: &mut 0x2::tx_context::TxContext) {
        ensure_contract_version(arg0);
        assert_shard_matches(arg0, arg13, arg14);
        let v0 = 0x2::tx_context::sender(arg14);
        assert!(!0x2::dynamic_field::exists<address>(&arg1.id, arg4.owner), 1021);
        assert!(!0x2::dynamic_field::exists<address>(&arg1.id, v0), 1021);
        assert!(!arg0.disabled, 1091);
        ensure_auto_wallet_sender(arg4, v0);
        assert!(!arg4.page_key_paused, 1070);
        assert!(0x1::option::is_none<0x2::object::ID>(&arg4.dao_id), 1009);
        assert!(arg4.work_count == 0, 1046);
        let v1 = new_dao(arg1, arg2, arg4, 0x1::string::utf8(b""), 0x1::string::utf8(b""), 0x1::string::utf8(b""), 0x1::string::utf8(b""), 0x1::string::utf8(b""), arg13, arg14);
        let v2 = &mut v1;
        publish_work<T0>(arg0, arg1, arg3, arg4, v2, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        share_dao(v1);
    }

    entry fun publish_work_with_dao<T0: drop>(arg0: &Platform, arg1: &PlatformDenyList, arg2: &ContentTags, arg3: &mut User, arg4: &mut Dao, arg5: &0x2::clock::Clock, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: vector<0x1::string::String>, arg9: u8, arg10: u8, arg11: 0x1::option::Option<0x2::coin::Coin<T0>>, arg12: &AllowedCoins, arg13: &mut ChangeShard, arg14: &mut 0x2::tx_context::TxContext) {
        ensure_contract_version(arg0);
        assert_shard_matches(arg0, arg13, arg14);
        assert!(!arg0.disabled, 1091);
        assert!(0x1::option::is_some<0x2::object::ID>(&arg3.dao_id), 1009);
        assert!(0x2::object::id<Dao>(arg4) == *0x1::option::borrow<0x2::object::ID>(&arg3.dao_id), 1009);
        publish_work<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
    }

    fun record_admin_disable(arg0: u8, arg1: 0x2::object::ID, arg2: bool, arg3: &mut ChangeShard, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminDisableRecord{
            id          : 0x2::object::new(arg4),
            object_type : arg0,
            object_id   : arg1,
            disabled    : arg2,
            user_id     : arg1,
        };
        0x2::transfer::share_object<AdminDisableRecord>(v0);
        record_object_change(arg3, 10, 0x2::object::id<AdminDisableRecord>(&v0), arg4);
    }

    fun record_author_referral_fee<T0: drop>(arg0: u8, arg1: u8, arg2: u64, arg3: 0x1::string::String, arg4: u8, arg5: u64, arg6: 0x2::object::ID, arg7: &NovelFund<T0>, arg8: &User, arg9: 0x2::object::ID, arg10: &Chapter, arg11: &Work, arg12: &mut ChangeShard, arg13: &mut 0x2::tx_context::TxContext) {
        if (arg2 == 0) {
            return
        };
        let v0 = 0x2::object::id<NovelFund<T0>>(arg7);
        let v1 = FinancialPart{
            part_type   : 1,
            wallet_addr : @0x0,
            obj_id      : v0,
        };
        let v2 = FinancialPart{
            part_type   : 0,
            wallet_addr : arg8.referrer,
            obj_id      : 0x2::object::id_from_address(@0x0),
        };
        create_dual_financial_record(arg0, arg1, v1, v2, arg3, arg4, arg2, 0x2::object::id<Chapter>(arg10), 1, arg6, arg5, arg11.name, arg10.title, v0, arg9, arg12, arg13, 0);
    }

    fun record_object_change(arg0: &mut ChangeShard, arg1: u16, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = ObjectChangedKey{seq: arg0.count};
        let v1 = ObjectChanged{
            id          : 0x2::derived_object::claim<ObjectChangedKey>(&mut arg0.id, v0),
            object_type : arg1,
            object_id   : arg2,
        };
        arg0.count = arg0.count + 1;
        0x2::transfer::share_object<ObjectChanged>(v1);
    }

    entry fun register_hosting_provider(arg0: &Platform, arg1: &PlatformDenyList, arg2: &mut SelfHostedNode, arg3: &User, arg4: u16, arg5: &mut ChangeShard, arg6: &mut 0x2::tx_context::TxContext) {
        ensure_contract_version(arg0);
        assert_shard_matches(arg0, arg5, arg6);
        assert!(!arg0.disabled, 1091);
        assert!(!0x2::dynamic_field::exists<address>(&arg1.id, 0x2::tx_context::sender(arg6)), 1021);
        assert!(arg2.owner == 0x2::tx_context::sender(arg6), 1032);
        assert!(arg2.active, 2003);
        assert!(arg3.owner == 0x2::tx_context::sender(arg6), 1032);
        assert!(!arg3.node_disabled, 1047);
        assert!(!arg3.author_service_disabled, 1048);
        assert!(arg2.provider_registration_count == 0, 2017);
        assert!(arg4 <= 5000, 2006);
        assert!(arg4 + arg0.platform_fee_bps < 5000, 2006);
        let v0 = HostingProvider{
            id             : 0x2::object::new(arg6),
            owner          : 0x2::tx_context::sender(arg6),
            hosted_node_id : 0x2::object::id<SelfHostedNode>(arg2),
            commission_bps : arg4,
            active         : true,
            disabled       : false,
        };
        arg2.provider_registration_count = arg2.provider_registration_count + 1;
        0x2::transfer::share_object<HostingProvider>(v0);
        record_object_change(arg5, 14, 0x2::object::id<HostingProvider>(&v0), arg6);
        record_object_change(arg5, 2, 0x2::object::id<SelfHostedNode>(arg2), arg6);
    }

    fun register_pubkey(arg0: &mut PubKeyRegistry, arg1: vector<u8>, arg2: address) {
        assert!(0x1::vector::length<u8>(&arg1) > 0, 1017);
        let v0 = PubKeyRegKey{pubkey: arg1};
        if (0x2::dynamic_field::exists<PubKeyRegKey>(&arg0.id, v0)) {
            assert!(*0x2::dynamic_field::borrow<PubKeyRegKey, address>(&arg0.id, v0) == arg2, 1121);
        } else {
            0x2::dynamic_field::add<PubKeyRegKey, address>(&mut arg0.id, v0, arg2);
        };
    }

    entry fun register_user(arg0: &Platform, arg1: &PlatformDenyList, arg2: &mut Registry, arg3: &mut PubKeyRegistry, arg4: &mut User, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: vector<u8>, arg8: vector<u8>, arg9: vector<u8>, arg10: vector<u8>, arg11: vector<u8>, arg12: u8, arg13: &0x2::clock::Clock, arg14: &mut ChangeShard, arg15: &mut 0x2::tx_context::TxContext) {
        ensure_contract_version(arg0);
        assert_shard_matches(arg0, arg14, arg15);
        assert!(!arg0.disabled, 1091);
        let v0 = create_user_cap(arg15);
        register_user_with_user_cap(arg0, arg1, arg2, arg3, arg4, v0, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15);
    }

    entry fun register_user_and_publish_work<T0: drop>(arg0: &Platform, arg1: &PlatformDenyList, arg2: &mut Registry, arg3: &mut PubKeyRegistry, arg4: &mut User, arg5: &ContentTags, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: vector<u8>, arg9: vector<u8>, arg10: vector<u8>, arg11: vector<u8>, arg12: vector<u8>, arg13: u8, arg14: 0x1::string::String, arg15: 0x1::string::String, arg16: vector<0x1::string::String>, arg17: u8, arg18: u8, arg19: 0x1::option::Option<0x2::coin::Coin<T0>>, arg20: &AllowedCoins, arg21: &0x2::clock::Clock, arg22: &mut ChangeShard, arg23: &mut 0x2::tx_context::TxContext) {
        ensure_contract_version(arg0);
        assert_shard_matches(arg0, arg22, arg23);
        let v0 = 0x2::tx_context::sender(arg23);
        assert!(!0x2::dynamic_field::exists<address>(&arg1.id, v0), 1021);
        assert!(!arg0.disabled, 1091);
        let v1 = create_user_cap(arg23);
        v1.owner = v0;
        let v2 = create_user_with_owner(arg0, arg1, arg2, arg3, arg4, v0, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg21, arg22, arg23);
        let v3 = &mut v2;
        let v4 = new_dao(arg1, arg2, v3, 0x1::string::utf8(b""), 0x1::string::utf8(b""), 0x1::string::utf8(b""), 0x1::string::utf8(b""), 0x1::string::utf8(b""), arg22, arg23);
        let v5 = &mut v2;
        let v6 = &mut v4;
        publish_work_impl<T0>(arg0, arg1, arg5, v5, v6, arg21, arg14, arg15, arg16, arg17, arg18, false, arg19, arg20, arg22, arg23);
        0x2::transfer::share_object<User>(v2);
        share_dao(v4);
        0x2::transfer::transfer<UserCap>(v1, v0);
    }

    public fun register_user_with_user_cap(arg0: &Platform, arg1: &PlatformDenyList, arg2: &mut Registry, arg3: &mut PubKeyRegistry, arg4: &mut User, arg5: UserCap, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: vector<u8>, arg9: vector<u8>, arg10: vector<u8>, arg11: vector<u8>, arg12: vector<u8>, arg13: u8, arg14: &0x2::clock::Clock, arg15: &mut ChangeShard, arg16: &mut 0x2::tx_context::TxContext) {
        ensure_contract_version(arg0);
        assert_shard_matches(arg0, arg15, arg16);
        let v0 = 0x2::tx_context::sender(arg16);
        assert!(!0x2::dynamic_field::exists<address>(&arg1.id, v0), 1021);
        assert!(!arg0.disabled, 1091);
        if (arg5.owner == @0x0) {
            arg5.owner = v0;
        } else {
            assert!(arg5.owner == v0, 1068);
        };
        0x2::transfer::share_object<User>(create_user_with_owner(arg0, arg1, arg2, arg3, arg4, v0, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16));
        0x2::transfer::transfer<UserCap>(arg5, v0);
    }

    fun registry_user_id_of(arg0: &Registry, arg1: address) : 0x2::object::ID {
        if (!0x2::dynamic_field::exists<address>(&arg0.id, arg1)) {
            return 0x2::object::id_from_address(@0x0)
        };
        0x2::dynamic_field::borrow<address, UserInfo>(&arg0.id, arg1).user_id
    }

    fun require_active_hosting(arg0: &User) {
        assert!(arg0.hosting.state == 1, 2003);
        assert!(arg0.hosting.provider != @0x0, 2003);
    }

    fun resolve_reader_referral_bps(arg0: &User, arg1: &Platform, arg2: u64) : u16 {
        let v0 = 0;
        if (has_valid_referrer(arg0)) {
            let v1 = arg0.referral_time;
            let v2 = if (arg2 > v1) {
                arg2 - v1
            } else {
                0
            };
            v0 = resolve_referral_window_bps((arg1.referral.referral_window1 as u64), (arg1.referral.referral_window2 as u64), arg1.referral.referral_bps1, arg1.referral.referral_bps2, v2);
        };
        v0
    }

    fun resolve_referral_window_bps(arg0: u64, arg1: u64, arg2: u16, arg3: u16, arg4: u64) : u16 {
        let v0 = if (arg2 > 0) {
            if (arg0 > 0) {
                arg4 <= arg0 * 86400
            } else {
                false
            }
        } else {
            false
        };
        if (v0) {
            return arg2
        };
        let v1 = if (arg3 > 0) {
            if (arg1 > 0) {
                arg4 <= arg1 * 86400
            } else {
                false
            }
        } else {
            false
        };
        if (v1) {
            return arg3
        };
        0
    }

    entry fun resume_hosting_agreement(arg0: &Platform, arg1: &PlatformDenyList, arg2: &mut AuthorHostingAgreement, arg3: &mut User, arg4: &mut ChangeShard, arg5: &mut 0x2::tx_context::TxContext) {
        ensure_contract_version(arg0);
        assert_shard_matches(arg0, arg4, arg5);
        assert!(!arg0.disabled, 1091);
        assert!(!0x2::dynamic_field::exists<address>(&arg1.id, 0x2::tx_context::sender(arg5)), 1021);
        assert!(arg3.owner == 0x2::tx_context::sender(arg5), 1032);
        assert!(arg2.author == 0x2::tx_context::sender(arg5), 1032);
        assert!(arg2.suspension_state == 2, 2007);
        assert!(arg3.hosting.state == 2, 2007);
        arg2.suspension_state = 1;
        arg3.hosting.state = 1;
        record_object_change(arg4, 4, 0x2::object::id<AuthorHostingAgreement>(arg2), arg5);
        record_object_change(arg4, 0, 0x2::object::id<User>(arg3), arg5);
    }

    entry fun revoke_general_invite_code(arg0: &Platform, arg1: &mut User, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &mut ChangeShard, arg5: &mut 0x2::tx_context::TxContext) {
        ensure_contract_version(arg0);
        assert_shard_matches(arg0, arg4, arg5);
        assert!(!arg0.disabled, 1091);
        assert!(0x2::tx_context::sender(arg5) == arg1.owner, 1032);
        let v0 = GeneralInviteCodeBookKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists<GeneralInviteCodeBookKey>(&arg1.id, v0), 1093);
        let v1 = 0x2::dynamic_field::borrow_mut<GeneralInviteCodeBookKey, GeneralInviteCodeBook>(&mut arg1.id, v0);
        let v2 = general_invite_entry_index(v1, arg2);
        assert!(0x1::option::is_some<u64>(&v2), 1093);
        let v3 = 0x1::vector::borrow_mut<GeneralInviteCodeEntry>(&mut v1.entries, 0x1::option::destroy_some<u64>(v2));
        if (v3.revoked) {
            return
        };
        v3.revoked = true;
        v3.revoked_at = 0x2::clock::timestamp_ms(arg3) / 1000;
        record_object_change(arg4, 0, 0x2::object::id<User>(arg1), arg5);
    }

    fun sat_add_u128(arg0: u128, arg1: u128) : u128 {
        if (arg0 > 340282366920938463463374607431768211455 - arg1) {
            340282366920938463463374607431768211455
        } else {
            arg0 + arg1
        }
    }

    fun sat_mul_u128(arg0: u128, arg1: u128) : u128 {
        if (arg0 > 0 && arg1 > 340282366920938463463374607431768211455 / arg0) {
            340282366920938463463374607431768211455
        } else {
            arg0 * arg1
        }
    }

    fun sat_sub_u128(arg0: u128, arg1: u128) : u128 {
        if (arg0 < arg1) {
            0
        } else {
            arg0 - arg1
        }
    }

    fun settle_chapter_payment_common<T0: drop>(arg0: &mut Platform, arg1: &Dao, arg2: &User, arg3: &mut User, arg4: &mut Work, arg5: &mut NovelFund<T0>, arg6: &mut NovelFund<T0>, arg7: &Chapter, arg8: 0x2::balance::Balance<T0>, arg9: 0x2::balance::Balance<T0>, arg10: 0x1::string::String, arg11: u8, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u16, arg17: bool, arg18: u64, arg19: &mut ChangeShard, arg20: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        if (arg17) {
            let v0 = WorkPayer{dummy_field: false};
            0x2::dynamic_field::add<address, WorkPayer>(&mut arg4.id, arg3.owner, v0);
            arg4.payers_count = arg4.payers_count + 1;
            record_object_change(arg19, 5, 0x2::object::id<Work>(arg4), arg20);
        };
        let v1 = arg3.owner;
        let v2 = Payment{
            id            : 0x2::object::new(arg20),
            reader        : v1,
            author_id     : 0x2::object::id<User>(arg2),
            work_id       : arg7.work_id,
            chapter_id    : 0x2::object::id<Chapter>(arg7),
            price         : arg7.price,
            amount        : arg12,
            platform_bps  : arg0.platform_fee_bps,
            platform_fee  : arg13,
            referral_bps  : arg16,
            referral_fee  : arg15,
            coin_type     : arg10,
            coin_decimals : arg11,
        };
        let v3 = 0x2::object::id<Payment>(&v2);
        record_object_change(arg19, 12, v3, arg20);
        let v4 = 0x2::object::id<Chapter>(arg7);
        let v5 = 0x2::object::id_from_address(@0x0);
        let v6 = @0x0;
        let v7 = arg4.name;
        let v8 = arg7.title;
        let v9 = FinancialPart{
            part_type   : 0,
            wallet_addr : arg3.owner,
            obj_id      : v5,
        };
        let v10 = FinancialPart{
            part_type   : 0,
            wallet_addr : v6,
            obj_id      : v5,
        };
        create_financial_record(1, 0, v9, v10, arg10, arg11, arg12, v4, 1, v3, arg18, v7, v8, 0x2::object::id<User>(arg3), arg19, arg20, 0);
        platform_deposit<T0>(arg0, arg5, arg8);
        record_object_change(arg19, 3, 0x2::object::id<NovelFund<T0>>(arg5), arg20);
        let v11 = FinancialPart{
            part_type   : 0,
            wallet_addr : arg3.owner,
            obj_id      : v5,
        };
        let v12 = FinancialPart{
            part_type   : 1,
            wallet_addr : v6,
            obj_id      : 0x2::object::id<NovelFund<T0>>(arg5),
        };
        create_financial_record(1, 2, v11, v12, arg10, arg11, arg14, v4, 1, v3, arg18, v7, v8, 0x2::object::id<NovelFund<T0>>(arg5), arg19, arg20, 0);
        let v13 = dao_deposit<T0>(arg1, arg6, arg9);
        record_object_change(arg19, 3, 0x2::object::id<NovelFund<T0>>(arg6), arg20);
        let v14 = FinancialPart{
            part_type   : 0,
            wallet_addr : arg3.owner,
            obj_id      : v5,
        };
        let v15 = FinancialPart{
            part_type   : 1,
            wallet_addr : v6,
            obj_id      : 0x2::object::id<NovelFund<T0>>(arg6),
        };
        create_financial_record(1, 1, v14, v15, arg10, arg11, v13, v4, 1, v3, arg18, v7, v8, 0x2::object::id<NovelFund<T0>>(arg6), arg19, arg20, current_dao_fund_member_seq(arg1));
        0x2::dynamic_field::add<0x2::object::ID, bool>(&mut arg3.id, v4, true);
        0x2::transfer::transfer<Payment>(v2, v1);
        mint_points_for_pay(arg0, arg3, arg12, arg11, arg18, v7, v8, v4, arg19, arg20);
        v3
    }

    public fun settle_fund_pool<T0: drop>(arg0: &Platform, arg1: &PlatformDenyList, arg2: &mut Dao, arg3: &mut NovelFund<T0>, arg4: &User, arg5: SettleTicket, arg6: &0x2::clock::Clock, arg7: &mut ChangeShard, arg8: &mut 0x2::tx_context::TxContext) : SettleTicket {
        ensure_contract_version(arg0);
        assert_shard_matches(arg0, arg7, arg8);
        assert!(!arg0.disabled, 1091);
        assert!(!0x2::dynamic_field::exists<address>(&arg1.id, 0x2::tx_context::sender(arg8)), 1021);
        if (arg5.action == 4) {
            assert!(0x2::tx_context::sender(arg8) == arg4.owner, 1032);
        } else {
            assert!(0x2::tx_context::sender(arg8) == arg2.owner, 1104);
        };
        assert!(!arg2.disabled, 1043);
        assert!(arg5.dao_id == 0x2::object::id<Dao>(arg2), 1116);
        assert!(arg5.member == arg4.owner, 1116);
        assert!(arg3.owner == arg2.owner, 1035);
        assert!(arg3.dao_id == 0x2::object::id<Dao>(arg2), 1065);
        let v0 = 0x2::object::id<NovelFund<T0>>(arg3);
        let v1 = coin_type_from_type<T0>();
        let v2 = AuthorFundKey{dummy_field: false};
        assert!(v0 == derived_fund_id(&0x2::dynamic_object_field::borrow<AuthorFundKey, FundShares>(&arg2.id, v2).fund_coin_seqs, b"team", &v1), 1073);
        assert!(!0x1::vector::contains<0x2::object::ID>(&arg5.settled, &v0), 1119);
        assert!(arg5.action == 3 || arg5.action == 4, 1117);
        settle_pool_core<T0>(arg1, arg2, arg3, arg4, arg5.member, arg5.action, 0, 0x2::object::id_from_address(@0x0), arg6, arg7, arg8);
        0x1::vector::push_back<0x2::object::ID>(&mut arg5.settled, v0);
        arg5.done = arg5.done + 1;
        arg5
    }

    public fun settle_fund_pool_share<T0: drop>(arg0: &Platform, arg1: &PlatformDenyList, arg2: &mut Dao, arg3: &mut NovelFund<T0>, arg4: &User, arg5: ShareChangeTicket, arg6: &0x2::clock::Clock, arg7: &mut ChangeShard, arg8: &mut 0x2::tx_context::TxContext) : ShareChangeTicket {
        ensure_contract_version(arg0);
        assert_shard_matches(arg0, arg7, arg8);
        assert!(!arg0.disabled, 1091);
        assert!(!0x2::dynamic_field::exists<address>(&arg1.id, 0x2::tx_context::sender(arg8)), 1021);
        assert!(0x2::tx_context::sender(arg8) == arg2.owner, 1104);
        assert!(!arg2.disabled, 1043);
        assert!(arg5.dao_id == 0x2::object::id<Dao>(arg2), 1116);
        assert!(arg5.member == arg4.owner, 1116);
        assert!(arg5.action == 1 || arg5.action == 2, 1117);
        assert!(arg3.owner == arg2.owner, 1035);
        assert!(arg3.dao_id == 0x2::object::id<Dao>(arg2), 1065);
        let v0 = 0x2::object::id<NovelFund<T0>>(arg3);
        let v1 = coin_type_from_type<T0>();
        let v2 = AuthorFundKey{dummy_field: false};
        assert!(v0 == derived_fund_id(&0x2::dynamic_object_field::borrow<AuthorFundKey, FundShares>(&arg2.id, v2).fund_coin_seqs, b"team", &v1), 1073);
        assert!(!0x1::vector::contains<0x2::object::ID>(&arg5.settled, &v0), 1119);
        settle_pool_core<T0>(arg1, arg2, arg3, arg4, arg5.member, arg5.action, arg5.amount, arg5.author_obj_id, arg6, arg7, arg8);
        0x1::vector::push_back<0x2::object::ID>(&mut arg5.settled, v0);
        arg5.done = arg5.done + 1;
        arg5
    }

    fun settle_fund_withdraw_impl<T0: drop>(arg0: &PlatformDenyList, arg1: &NovelFund<T0>, arg2: address, arg3: 0x2::object::ID, arg4: 0x2::balance::Balance<T0>, arg5: u64, arg6: &mut ChangeShard, arg7: &mut 0x2::tx_context::TxContext, arg8: u8, arg9: bool) {
        let v0 = 0x2::balance::value<T0>(&arg4);
        if (v0 > 0) {
            let v1 = 0x2::object::id<NovelFund<T0>>(arg1);
            let v2 = 0x2::object::id_from_address(@0x0);
            let v3 = coin_type_from_type<T0>();
            let v4 = empty_string();
            let v5 = if (0x2::dynamic_field::exists<address>(&arg0.id, arg2) || arg9) {
                let v6 = PendingPayout<T0>{
                    id            : 0x2::object::new(arg7),
                    member        : arg2,
                    dao_id        : arg1.dao_id,
                    fund_id       : v1,
                    coin_type     : string_clone(&v3),
                    coin_decimals : arg1.coin_decimals,
                    amount        : v0,
                    balance       : 0x1::option::some<0x2::balance::Balance<T0>>(arg4),
                    claimed       : false,
                    created_at    : arg5,
                };
                let v7 = 0x2::object::id<PendingPayout<T0>>(&v6);
                0x2::transfer::transfer<PendingPayout<T0>>(v6, arg2);
                record_object_change(arg6, 27, v7, arg7);
                FinancialPart{part_type: 3, wallet_addr: arg2, obj_id: v7}
            } else {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg4, arg7), arg2);
                FinancialPart{part_type: 0, wallet_addr: arg2, obj_id: v2}
            };
            let v8 = FinancialPart{
                part_type   : 1,
                wallet_addr : @0x0,
                obj_id      : v1,
            };
            create_dual_financial_record(arg8, 0, v8, v5, string_clone(&v3), arg1.coin_decimals, v0, v1, 0, v2, arg5, v4, v4, 0x2::object::id<NovelFund<T0>>(arg1), arg3, arg6, arg7, 0);
        } else {
            0x2::balance::destroy_zero<T0>(arg4);
        };
    }

    fun settle_pool_core<T0: drop>(arg0: &PlatformDenyList, arg1: &mut Dao, arg2: &mut NovelFund<T0>, arg3: &User, arg4: address, arg5: u8, arg6: u64, arg7: 0x2::object::ID, arg8: &0x2::clock::Clock, arg9: &mut ChangeShard, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg8) / 1000;
        let v1 = DaoDenylistKey{user: arg4};
        let v2 = AuthorFundKey{dummy_field: false};
        let v3 = 0x2::dynamic_object_field::borrow_mut<AuthorFundKey, FundShares>(&mut arg1.id, v2);
        let v4 = v3.owner;
        let v5 = fund_claim<T0>(v3, arg2, arg4);
        let v6 = ledger_share(v3, arg4);
        let v7 = if (arg5 == 1 || arg5 == 2) {
            fund_claim<T0>(v3, arg2, v4)
        } else {
            0x2::balance::zero<T0>()
        };
        record_object_change(arg9, 3, 0x2::object::id<NovelFund<T0>>(arg2), arg10);
        let v8 = arg2.rewards_per_share_cumulative;
        if (arg5 == 3 || arg5 == 4) {
            if (0x2::table::contains<address, u128>(&arg2.debts, arg4)) {
                0x2::table::remove<address, u128>(&mut arg2.debts, arg4);
            };
            if (!0x2::table::contains<address, u128>(&arg2.debts, v4)) {
                0x2::table::add<address, u128>(&mut arg2.debts, v4, 0);
            };
            let v9 = 0x2::table::borrow_mut<address, u128>(&mut arg2.debts, v4);
            *v9 = sat_add_u128(*v9, sat_mul_u128((v6 as u128), v8));
        } else if (arg5 == 1) {
            if (!0x2::table::contains<address, u128>(&arg2.debts, arg4)) {
                0x2::table::add<address, u128>(&mut arg2.debts, arg4, 0);
            };
            let v10 = 0x2::table::borrow_mut<address, u128>(&mut arg2.debts, arg4);
            *v10 = sat_add_u128(*v10, sat_mul_u128((arg6 as u128), v8));
            if (!0x2::table::contains<address, u128>(&arg2.debts, v4)) {
                0x2::table::add<address, u128>(&mut arg2.debts, v4, 0);
            };
            let v11 = 0x2::table::borrow_mut<address, u128>(&mut arg2.debts, v4);
            *v11 = sat_sub_u128(*v11, sat_mul_u128((arg6 as u128), v8));
        } else {
            if (!0x2::table::contains<address, u128>(&arg2.debts, arg4)) {
                0x2::table::add<address, u128>(&mut arg2.debts, arg4, 0);
            };
            *0x2::table::borrow_mut<address, u128>(&mut arg2.debts, arg4) = sat_mul_u128((arg6 as u128), v8);
            if (!0x2::table::contains<address, u128>(&arg2.debts, v4)) {
                0x2::table::add<address, u128>(&mut arg2.debts, v4, 0);
            };
            if (arg6 > v6) {
                let v12 = 0x2::table::borrow_mut<address, u128>(&mut arg2.debts, v4);
                *v12 = sat_sub_u128(*v12, sat_mul_u128(((arg6 - v6) as u128), v8));
            } else if (arg6 < v6) {
                let v13 = 0x2::table::borrow_mut<address, u128>(&mut arg2.debts, v4);
                *v13 = sat_add_u128(*v13, sat_mul_u128(((v6 - arg6) as u128), v8));
            };
        };
        settle_fund_withdraw_impl<T0>(arg0, arg2, arg4, 0x2::object::id<User>(arg3), v5, v0, arg9, arg10, 13, 0x2::dynamic_field::exists<DaoDenylistKey>(&arg1.id, v1));
        if (arg5 == 1 || arg5 == 2) {
            settle_fund_withdraw_impl<T0>(arg0, arg2, v4, arg7, v7, v0, arg9, arg10, 13, false);
        } else {
            0x2::balance::destroy_zero<T0>(v7);
        };
    }

    fun share_dao(arg0: Dao) {
        0x2::transfer::share_object<Dao>(arg0);
    }

    entry fun sign_hosting_agreement(arg0: &Platform, arg1: &PlatformDenyList, arg2: &mut PubKeyRegistry, arg3: &mut SelfHostedNode, arg4: &HostingProvider, arg5: &User, arg6: &mut User, arg7: vector<u8>, arg8: vector<u8>, arg9: &0x2::clock::Clock, arg10: &mut ChangeShard, arg11: &mut 0x2::tx_context::TxContext) {
        ensure_contract_version(arg0);
        assert_shard_matches(arg0, arg10, arg11);
        assert!(!arg0.disabled, 1091);
        assert!(arg3.active, 2010);
        assert!(arg4.active, 2010);
        assert!(!arg4.disabled, 2010);
        assert!(arg5.owner == arg4.owner, 1032);
        assert!(!arg5.node_disabled, 1047);
        assert!(!arg6.author_service_disabled, 1048);
        assert!(!arg6.node_disabled, 1047);
        assert!(!0x2::dynamic_field::exists<address>(&arg1.id, arg5.owner), 1021);
        assert!(arg6.owner == 0x2::tx_context::sender(arg11), 1032);
        assert!(arg6.hosting.state == 0, 2004);
        assert!(!0x2::dynamic_field::exists<address>(&arg1.id, arg6.owner), 1021);
        let v0 = if (0x1::vector::length<u8>(&arg7) == 32) {
            true
        } else if (0x1::vector::length<u8>(&arg7) == 33) {
            true
        } else {
            0x1::vector::length<u8>(&arg7) == 34
        };
        assert!(v0, 1017);
        assert!(0x1::vector::length<u8>(&arg8) == 32, 1017);
        assert!(arg3.owner == arg4.owner, 2010);
        assert!(arg4.hosted_node_id == 0x2::object::id<SelfHostedNode>(arg3), 2010);
        register_pubkey(arg2, arg7, 0x2::tx_context::sender(arg11));
        register_pubkey(arg2, arg8, 0x2::tx_context::sender(arg11));
        let v1 = arg4.commission_bps;
        assert!(v1 <= 5000, 2006);
        assert!(v1 + arg0.platform_fee_bps < 5000, 2006);
        arg6.hosting.state = 1;
        arg6.hosting.provider = arg4.owner;
        arg3.active_agreement_count = arg3.active_agreement_count + 1;
        let v2 = AuthorHostingAgreement{
            id                  : 0x2::object::new(arg11),
            author              : arg6.owner,
            provider            : arg4.owner,
            provider_ip         : arg3.ip,
            provider_port       : arg3.port,
            commission_bps      : v1,
            active              : true,
            suspension_state    : 1,
            started_at          : 0x2::clock::timestamp_ms(arg9) / 1000,
            node_id             : 0x2::object::id<SelfHostedNode>(arg3),
            node_encrypt_pubkey : arg7,
            node_sign_pubkey    : arg8,
        };
        0x2::transfer::share_object<AuthorHostingAgreement>(v2);
        record_object_change(arg10, 4, 0x2::object::id<AuthorHostingAgreement>(&v2), arg11);
        record_object_change(arg10, 2, 0x2::object::id<SelfHostedNode>(arg3), arg11);
        record_object_change(arg10, 0, 0x2::object::id<User>(arg6), arg11);
    }

    fun split_chapter_payment_balances<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: u64, arg3: u64) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T0>, u64) {
        let v0 = 0x2::coin::into_balance<T0>(arg0);
        let v1 = 0x2::balance::split<T0>(&mut v0, arg1);
        (v1, 0x2::balance::split<T0>(&mut v1, arg2), 0x2::balance::split<T0>(&mut v1, arg3), v0, arg1 - arg2 - arg3)
    }

    fun string_clone(arg0: &0x1::string::String) : 0x1::string::String {
        *arg0
    }

    entry fun suspend_hosting_agreement(arg0: &Platform, arg1: &PlatformDenyList, arg2: &mut AuthorHostingAgreement, arg3: &mut User, arg4: &mut ChangeShard, arg5: &mut 0x2::tx_context::TxContext) {
        ensure_contract_version(arg0);
        assert_shard_matches(arg0, arg4, arg5);
        assert!(!arg0.disabled, 1091);
        assert!(!0x2::dynamic_field::exists<address>(&arg1.id, 0x2::tx_context::sender(arg5)), 1021);
        assert!(arg3.owner == 0x2::tx_context::sender(arg5), 1032);
        assert!(arg2.author == 0x2::tx_context::sender(arg5), 1032);
        assert!(arg2.active, 2003);
        assert!(arg2.suspension_state == 1, 2007);
        assert!(arg3.hosting.state == 1, 2007);
        arg2.suspension_state = 2;
        arg3.hosting.state = 2;
        record_object_change(arg4, 4, 0x2::object::id<AuthorHostingAgreement>(arg2), arg5);
        record_object_change(arg4, 0, 0x2::object::id<User>(arg3), arg5);
    }

    fun transfer_referral_fees<T0: drop>(arg0: 0x2::balance::Balance<T0>, arg1: 0x2::balance::Balance<T0>, arg2: &User, arg3: &User, arg4: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        let v0 = 0x2::balance::value<T0>(&arg0);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg4), arg2.referrer);
        } else {
            0x2::balance::destroy_zero<T0>(arg0);
        };
        let v1 = 0x2::balance::value<T0>(&arg1);
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg1, arg4), arg3.referrer);
        } else {
            0x2::balance::destroy_zero<T0>(arg1);
        };
        (v0, v1)
    }

    fun u8_to_ascii_bytes(arg0: u8) : vector<u8> {
        if (arg0 == 0) {
            return b"0"
        };
        let v0 = b"";
        while (arg0 > 0) {
            0x1::vector::push_back<u8>(&mut v0, arg0 % 10 + 48);
            arg0 = arg0 / 10;
        };
        0x1::vector::reverse<u8>(&mut v0);
        v0
    }

    entry fun unpublish_self_hosted_node(arg0: &Platform, arg1: &PlatformDenyList, arg2: &mut SelfHostedNode, arg3: &mut User, arg4: &mut ChangeShard, arg5: &mut 0x2::tx_context::TxContext) {
        ensure_contract_version(arg0);
        assert_shard_matches(arg0, arg4, arg5);
        assert!(!arg0.disabled, 1091);
        assert!(!0x2::dynamic_field::exists<address>(&arg1.id, 0x2::tx_context::sender(arg5)), 1021);
        assert!(arg2.owner == 0x2::tx_context::sender(arg5), 1032);
        assert!(arg3.owner == 0x2::tx_context::sender(arg5), 1032);
        assert!(arg2.active, 2003);
        assert!(arg3.hosting.state == 3, 2007);
        assert!(arg2.active_agreement_count == 0, 2016);
        assert!(arg2.provider_registration_count == 0, 2017);
        arg2.active = false;
        arg3.hosting.state = 0;
        record_object_change(arg4, 2, 0x2::object::id<SelfHostedNode>(arg2), arg5);
        record_object_change(arg4, 0, 0x2::object::id<User>(arg3), arg5);
    }

    entry fun unregister_hosting_provider(arg0: &Platform, arg1: &PlatformDenyList, arg2: &mut HostingProvider, arg3: &mut SelfHostedNode, arg4: &mut ChangeShard, arg5: &mut 0x2::tx_context::TxContext) {
        ensure_contract_version(arg0);
        assert_shard_matches(arg0, arg4, arg5);
        assert!(!arg0.disabled, 1091);
        assert!(!0x2::dynamic_field::exists<address>(&arg1.id, 0x2::tx_context::sender(arg5)), 1021);
        assert!(arg2.owner == 0x2::tx_context::sender(arg5), 1032);
        assert!(arg2.active, 2010);
        assert!(arg2.hosted_node_id == 0x2::object::id<SelfHostedNode>(arg3), 2008);
        assert!(arg3.active_agreement_count == 0, 2016);
        arg2.active = false;
        arg3.provider_registration_count = arg3.provider_registration_count - 1;
        record_object_change(arg4, 14, 0x2::object::id<HostingProvider>(arg2), arg5);
        record_object_change(arg4, 2, 0x2::object::id<SelfHostedNode>(arg3), arg5);
    }

    entry fun update_avatar(arg0: &Platform, arg1: &PlatformDenyList, arg2: &mut User, arg3: &mut Avatar, arg4: vector<u8>, arg5: 0x1::string::String, arg6: u32, arg7: u32, arg8: &mut ChangeShard, arg9: &mut 0x2::tx_context::TxContext) {
        ensure_contract_version(arg0);
        assert_shard_matches(arg0, arg8, arg9);
        assert!(!arg0.disabled, 1091);
        ensure_auto_wallet_sender(arg2, 0x2::tx_context::sender(arg9));
        assert!(!arg2.page_key_paused, 1070);
        assert!(!0x2::dynamic_field::exists<address>(&arg1.id, arg2.owner), 1021);
        assert!(0x1::vector::length<u8>(&arg4) > 0, 1031);
        assert!(arg3.owner == arg2.owner, 1032);
        assert!(arg3.user_id == 0x2::object::id<User>(arg2), 1032);
        arg3.bytes = arg4;
        arg3.mime_type = 0x1::string::utf8(*0x1::string::as_bytes(&arg5));
        arg3.width = arg6;
        arg3.height = arg7;
        arg3.updated_at = 0x2::tx_context::epoch_timestamp_ms(arg9) / 1000;
        arg2.avatar_mime_type = arg5;
        record_object_change(arg8, 17, 0x2::object::id<Avatar>(arg3), arg9);
        record_object_change(arg8, 0, 0x2::object::id<User>(arg2), arg9);
    }

    entry fun update_avatar_and_profile(arg0: &Platform, arg1: &PlatformDenyList, arg2: &mut User, arg3: &mut Registry, arg4: &mut Avatar, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: vector<u8>, arg8: 0x1::string::String, arg9: u32, arg10: u32, arg11: &mut ChangeShard, arg12: &mut 0x2::tx_context::TxContext) {
        ensure_contract_version(arg0);
        assert_shard_matches(arg0, arg11, arg12);
        assert!(!arg0.disabled, 1091);
        ensure_auto_wallet_sender(arg2, 0x2::tx_context::sender(arg12));
        assert!(!arg2.page_key_paused, 1070);
        assert!(!0x2::dynamic_field::exists<address>(&arg1.id, arg2.owner), 1021);
        assert!(0x1::vector::length<u8>(&arg7) > 0, 1031);
        assert!(arg4.owner == arg2.owner, 1032);
        assert!(arg4.user_id == 0x2::object::id<User>(arg2), 1032);
        arg4.bytes = arg7;
        arg4.mime_type = 0x1::string::utf8(*0x1::string::as_bytes(&arg8));
        arg4.width = arg9;
        arg4.height = arg10;
        arg4.updated_at = 0x2::tx_context::epoch_timestamp_ms(arg12) / 1000;
        arg2.avatar_mime_type = arg8;
        apply_user_profile_fields(arg2, arg3, arg5, arg6);
        record_object_change(arg11, 17, 0x2::object::id<Avatar>(arg4), arg12);
        record_object_change(arg11, 0, 0x2::object::id<User>(arg2), arg12);
    }

    entry fun update_cover(arg0: &Platform, arg1: &PlatformDenyList, arg2: &mut User, arg3: &mut Work, arg4: &mut Cover, arg5: vector<u8>, arg6: 0x1::string::String, arg7: u32, arg8: u32, arg9: &mut ChangeShard, arg10: &mut 0x2::tx_context::TxContext) {
        ensure_contract_version(arg0);
        assert_shard_matches(arg0, arg9, arg10);
        assert!(!arg0.disabled, 1091);
        let v0 = 0x2::tx_context::sender(arg10);
        assert!(!0x2::dynamic_field::exists<address>(&arg1.id, v0), 1021);
        assert!(!0x2::dynamic_field::exists<address>(&arg1.id, arg2.owner), 1021);
        ensure_auto_wallet_sender(arg2, v0);
        assert!(!arg2.page_key_paused, 1070);
        assert!(arg2.owner == arg3.owner, 1033);
        assert!(0x1::vector::length<u8>(&arg5) > 0, 1031);
        assert!(arg4.owner == arg3.owner, 1033);
        assert!(arg4.work_id == 0x2::object::id<Work>(arg3), 1033);
        arg4.bytes = arg5;
        arg4.mime_type = 0x1::string::utf8(*0x1::string::as_bytes(&arg6));
        arg4.width = arg7;
        arg4.height = arg8;
        arg4.updated_at = 0x2::tx_context::epoch_timestamp_ms(arg10) / 1000;
        arg3.cover_mime_type = arg6;
        record_object_change(arg9, 18, 0x2::object::id<Cover>(arg4), arg10);
        record_object_change(arg9, 5, 0x2::object::id<Work>(arg3), arg10);
    }

    entry fun update_hosting_agreement_endpoint_keys(arg0: &Platform, arg1: &PlatformDenyList, arg2: &mut PubKeyRegistry, arg3: &mut AuthorHostingAgreement, arg4: vector<u8>, arg5: vector<u8>, arg6: &mut ChangeShard, arg7: &mut 0x2::tx_context::TxContext) {
        ensure_contract_version(arg0);
        assert_shard_matches(arg0, arg6, arg7);
        assert!(!arg0.disabled, 1091);
        assert!(!0x2::dynamic_field::exists<address>(&arg1.id, 0x2::tx_context::sender(arg7)), 1021);
        assert!(arg3.author == 0x2::tx_context::sender(arg7), 1032);
        let v0 = if (0x1::vector::length<u8>(&arg4) == 32) {
            true
        } else if (0x1::vector::length<u8>(&arg4) == 33) {
            true
        } else {
            0x1::vector::length<u8>(&arg4) == 34
        };
        assert!(v0, 1017);
        assert!(0x1::vector::length<u8>(&arg5) == 32, 1017);
        if (arg4 != arg3.node_encrypt_pubkey) {
            register_pubkey(arg2, arg4, 0x2::tx_context::sender(arg7));
        };
        if (arg5 != arg3.node_sign_pubkey) {
            register_pubkey(arg2, arg5, 0x2::tx_context::sender(arg7));
        };
        arg3.node_encrypt_pubkey = arg4;
        arg3.node_sign_pubkey = arg5;
        record_object_change(arg6, 4, 0x2::object::id<AuthorHostingAgreement>(arg3), arg7);
    }

    entry fun update_hosting_provider(arg0: &Platform, arg1: &PlatformDenyList, arg2: &mut HostingProvider, arg3: u16, arg4: &mut ChangeShard, arg5: &mut 0x2::tx_context::TxContext) {
        ensure_contract_version(arg0);
        assert_shard_matches(arg0, arg4, arg5);
        assert!(!arg0.disabled, 1091);
        assert!(!0x2::dynamic_field::exists<address>(&arg1.id, 0x2::tx_context::sender(arg5)), 1021);
        assert!(arg2.owner == 0x2::tx_context::sender(arg5), 1032);
        assert!(arg3 <= 5000, 2006);
        assert!(arg3 + arg0.platform_fee_bps < 5000, 2006);
        arg2.commission_bps = arg3;
        record_object_change(arg4, 14, 0x2::object::id<HostingProvider>(arg2), arg5);
    }

    fun update_registered_name(arg0: &mut Registry, arg1: &0x1::string::String, arg2: 0x1::string::String, arg3: address) : 0x1::string::String {
        let v0 = normalize_name(arg2);
        assert!(0x1::string::length(&v0) > 0, 1023);
        if (v0 == *arg1) {
            return v0
        };
        let v1 = NameKey{name: v0};
        if (0x2::dynamic_field::exists<NameKey>(&arg0.id, v1)) {
            assert!(*0x2::dynamic_field::borrow<NameKey, address>(&arg0.id, v1) == arg3, 1084);
        } else {
            0x2::dynamic_field::add<NameKey, address>(&mut arg0.id, v1, arg3);
        };
        v0
    }

    entry fun update_self_hosted_node_endpoint_keys(arg0: &Platform, arg1: &PlatformDenyList, arg2: &mut PubKeyRegistry, arg3: &mut SelfHostedNode, arg4: vector<u8>, arg5: vector<u8>, arg6: &mut ChangeShard, arg7: &mut 0x2::tx_context::TxContext) {
        ensure_contract_version(arg0);
        assert_shard_matches(arg0, arg6, arg7);
        assert!(!arg0.disabled, 1091);
        assert!(!0x2::dynamic_field::exists<address>(&arg1.id, 0x2::tx_context::sender(arg7)), 1021);
        assert!(arg3.owner == 0x2::tx_context::sender(arg7), 1032);
        let v0 = if (0x1::vector::length<u8>(&arg4) == 32) {
            true
        } else if (0x1::vector::length<u8>(&arg4) == 33) {
            true
        } else {
            0x1::vector::length<u8>(&arg4) == 34
        };
        assert!(v0, 1017);
        assert!(0x1::vector::length<u8>(&arg5) == 32, 1017);
        if (arg4 != arg3.node_encrypt_pubkey) {
            register_pubkey(arg2, arg4, 0x2::tx_context::sender(arg7));
        };
        if (arg5 != arg3.node_sign_pubkey) {
            register_pubkey(arg2, arg5, 0x2::tx_context::sender(arg7));
        };
        arg3.node_encrypt_pubkey = arg4;
        arg3.node_sign_pubkey = arg5;
        record_object_change(arg6, 2, 0x2::object::id<SelfHostedNode>(arg3), arg7);
    }

    entry fun update_self_hosted_node_v2(arg0: &Platform, arg1: &PlatformDenyList, arg2: &mut SelfHostedNode, arg3: 0x1::string::String, arg4: &mut ChangeShard, arg5: &mut 0x2::tx_context::TxContext) {
        ensure_contract_version(arg0);
        assert_shard_matches(arg0, arg4, arg5);
        assert!(!arg0.disabled, 1091);
        assert!(!0x2::dynamic_field::exists<address>(&arg1.id, 0x2::tx_context::sender(arg5)), 1021);
        assert!(arg2.owner == 0x2::tx_context::sender(arg5), 1032);
        assert!(0x1::string::length(&arg3) > 0, 2014);
        arg2.ip = arg3;
        arg2.port = 0;
        record_object_change(arg4, 2, 0x2::object::id<SelfHostedNode>(arg2), arg5);
    }

    entry fun update_sync_public_key(arg0: &Platform, arg1: &PlatformDenyList, arg2: &mut PubKeyRegistry, arg3: &mut SelfHostedNode, arg4: vector<u8>, arg5: &mut ChangeShard, arg6: &mut 0x2::tx_context::TxContext) {
        ensure_contract_version(arg0);
        assert_shard_matches(arg0, arg5, arg6);
        assert!(!arg0.disabled, 1091);
        assert!(!0x2::dynamic_field::exists<address>(&arg1.id, 0x2::tx_context::sender(arg6)), 1021);
        assert!(arg3.owner == 0x2::tx_context::sender(arg6), 1032);
        assert!(0x1::vector::length<u8>(&arg4) > 0, 1017);
        if (arg4 != arg3.sync_public_key) {
            register_pubkey(arg2, arg4, 0x2::tx_context::sender(arg6));
        };
        arg3.sync_public_key = arg4;
        record_object_change(arg5, 2, 0x2::object::id<SelfHostedNode>(arg3), arg6);
    }

    entry fun update_user_keys(arg0: &Platform, arg1: &PlatformDenyList, arg2: &mut PubKeyRegistry, arg3: &mut Registry, arg4: &mut User, arg5: vector<u8>, arg6: vector<u8>, arg7: &mut ChangeShard, arg8: &mut 0x2::tx_context::TxContext) {
        ensure_contract_version(arg0);
        assert_shard_matches(arg0, arg7, arg8);
        assert!(!arg0.disabled, 1091);
        let v0 = 0x2::tx_context::sender(arg8);
        assert!(v0 == arg4.owner, 1032);
        assert!(!0x2::dynamic_field::exists<address>(&arg1.id, arg4.owner), 1021);
        assert!(0x1::vector::length<u8>(&arg6) == 32, 1080);
        let v1 = if (0x1::vector::length<u8>(&arg5) == 32) {
            true
        } else if (0x1::vector::length<u8>(&arg5) == 33) {
            true
        } else {
            0x1::vector::length<u8>(&arg5) == 34
        };
        assert!(v1, 1017);
        if (arg6 != arg4.auto_pubkey) {
            register_pubkey(arg2, arg6, v0);
        };
        arg4.encrypt_pubkey = arg5;
        arg4.auto_pubkey = arg6;
        let v2 = 0x2::dynamic_field::borrow_mut<address, UserInfo>(&mut arg3.id, arg4.owner);
        v2.auto_pubkey = arg6;
        v2.encrypt_pubkey = arg5;
        record_object_change(arg7, 0, 0x2::object::id<User>(arg4), arg8);
        if (0x2::table::contains<u8, vector<u8>>(&arg4.age_confirm_signatures, 0)) {
            0x2::table::remove<u8, vector<u8>>(&mut arg4.age_confirm_signatures, 0);
        };
        if (0x2::table::contains<u8, vector<u8>>(&arg4.age_confirm_signatures, 1)) {
            0x2::table::remove<u8, vector<u8>>(&mut arg4.age_confirm_signatures, 1);
        };
        if (0x2::table::contains<u8, vector<u8>>(&arg4.age_confirm_signatures, 2)) {
            0x2::table::remove<u8, vector<u8>>(&mut arg4.age_confirm_signatures, 2);
        };
        if (0x2::table::contains<u8, vector<u8>>(&arg4.age_confirm_signatures, 3)) {
            0x2::table::remove<u8, vector<u8>>(&mut arg4.age_confirm_signatures, 3);
        };
    }

    entry fun update_user_profile(arg0: &Platform, arg1: &PlatformDenyList, arg2: &mut User, arg3: &mut Registry, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: &mut ChangeShard, arg7: &mut 0x2::tx_context::TxContext) {
        ensure_contract_version(arg0);
        assert_shard_matches(arg0, arg6, arg7);
        assert!(!arg0.disabled, 1091);
        ensure_auto_wallet_sender(arg2, 0x2::tx_context::sender(arg7));
        assert!(!arg2.page_key_paused, 1070);
        assert!(!0x2::dynamic_field::exists<address>(&arg1.id, arg2.owner), 1021);
        if (0x1::string::length(&arg4) > 0) {
            arg2.name = update_registered_name(arg3, &arg2.name, arg4, arg2.owner);
        };
        if (0x1::string::length(&arg5) > 0) {
            arg2.intro = arg5;
        };
        record_object_change(arg6, 0, 0x2::object::id<User>(arg2), arg7);
    }

    fun upsert_tag_texts(arg0: &mut ContentTagText, arg1: vector<0x1::string::String>, arg2: vector<0x1::string::String>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1::string::String>(&arg1)) {
            let v1 = *0x1::vector::borrow<0x1::string::String>(&arg1, v0);
            let v2 = 0x1::vector::length<TagLocaleText>(&arg0.texts);
            let v3 = v2;
            let v4 = 0;
            while (v4 < v2) {
                if (0x1::vector::borrow<TagLocaleText>(&arg0.texts, v4).locale == v1) {
                    v3 = v4;
                    break
                };
                v4 = v4 + 1;
            };
            if (v3 < v2) {
                0x1::vector::borrow_mut<TagLocaleText>(&mut arg0.texts, v3).text = *0x1::vector::borrow<0x1::string::String>(&arg2, v0);
            } else {
                assert!(0x1::vector::length<TagLocaleText>(&arg0.texts) < 64, 1136);
                let v5 = TagLocaleText{
                    locale : v1,
                    text   : *0x1::vector::borrow<0x1::string::String>(&arg2, v0),
                };
                0x1::vector::push_back<TagLocaleText>(&mut arg0.texts, v5);
            };
            v0 = v0 + 1;
        };
    }

    entry fun user_confirm_min_age(arg0: &Platform, arg1: &PlatformDenyList, arg2: &mut User, arg3: u8, arg4: vector<u8>, arg5: &mut ChangeShard, arg6: &mut 0x2::tx_context::TxContext) {
        ensure_contract_version(arg0);
        assert_shard_matches(arg0, arg5, arg6);
        assert!(!arg0.disabled, 1091);
        let v0 = 0x2::tx_context::sender(arg6);
        assert!(!0x2::dynamic_field::exists<address>(&arg1.id, v0), 1021);
        assert!(!arg2.page_key_paused, 1070);
        ensure_auto_wallet_sender(arg2, v0);
        let v1 = if (arg3 == 1) {
            true
        } else if (arg3 == 2) {
            true
        } else {
            arg3 == 3
        };
        assert!(v1, 1028);
        assert!(!0x2::table::contains<u8, vector<u8>>(&arg2.age_confirm_signatures, arg3), 1050);
        0x2::table::add<u8, vector<u8>>(&mut arg2.age_confirm_signatures, arg3, arg4);
        record_object_change(arg5, 0, 0x2::object::id<User>(arg2), arg6);
    }

    entry fun user_init_author_funds<T0: drop>(arg0: &Platform, arg1: &PlatformDenyList, arg2: &AllowedCoins, arg3: &0x2::coin_registry::Currency<T0>, arg4: &User, arg5: &mut Dao, arg6: &mut ChangeShard, arg7: &mut 0x2::tx_context::TxContext) {
        ensure_contract_version(arg0);
        assert_shard_matches(arg0, arg6, arg7);
        let v0 = 0x2::tx_context::sender(arg7);
        assert!(!0x2::dynamic_field::exists<address>(&arg1.id, v0), 1021);
        assert!(!arg0.disabled, 1091);
        assert!(v0 == arg4.owner, 1032);
        assert!(0x1::option::is_some<0x2::object::ID>(&arg4.dao_id), 1009);
        assert!(0x2::object::id<Dao>(arg5) == *0x1::option::borrow<0x2::object::ID>(&arg4.dao_id), 1009);
        let v1 = coin_type_from_type<T0>();
        assert!(0x2::vec_set::contains<0x1::string::String>(&arg2.symbols, &v1), 1006);
        create_team_fund_v2<T0>(arg0, arg1, arg5, arg3, arg6, arg7);
    }

    entry fun user_pause_page_key(arg0: &Platform, arg1: &PlatformDenyList, arg2: &mut User, arg3: bool, arg4: &mut ChangeShard, arg5: &mut 0x2::tx_context::TxContext) {
        ensure_contract_version(arg0);
        assert_shard_matches(arg0, arg4, arg5);
        assert!(!arg0.disabled, 1091);
        assert!(0x2::tx_context::sender(arg5) == arg2.owner, 1032);
        if (!arg3) {
            assert!(!0x2::dynamic_field::exists<address>(&arg1.id, arg2.owner), 1021);
        };
        arg2.page_key_paused = arg3;
        record_object_change(arg4, 0, 0x2::object::id<User>(arg2), arg5);
    }

    public fun verify_chapter_payment(arg0: &Platform, arg1: &User, arg2: 0x2::object::ID) : bool {
        ensure_contract_version(arg0);
        0x2::dynamic_field::exists<0x2::object::ID>(&arg1.id, arg2)
    }

    fun verify_dao_private_invite(arg0: &mut Dao, arg1: &User, arg2: vector<u8>, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        if (!arg0.is_private) {
            return
        };
        assert!(0x1::vector::length<u8>(&arg2) > 0, 1110);
        assert!(0x1::vector::length<u8>(&arg3) > 0, 1110);
        assert!(0x1::vector::length<u8>(&arg2) == 17, 1111);
        let v0 = *0x1::vector::borrow<u8>(&arg2, 0);
        assert!(v0 == 0 || v0 == 1, 1111);
        let v1 = 0x2::tx_context::sender(arg5);
        let v2 = if (v0 == 1) {
            v1
        } else {
            @0x0
        };
        let v3 = v2;
        let v4 = 0x2::object::id<Dao>(arg0);
        assert!(arg0.owner == arg1.owner, 1111);
        let v5 = 0x2::bcs::to_bytes<0x2::object::ID>(&v4);
        0x1::vector::append<u8>(&mut v5, 0x2::bcs::to_bytes<vector<u8>>(&arg2));
        0x1::vector::append<u8>(&mut v5, 0x2::bcs::to_bytes<address>(&v3));
        assert!(verify_signature(&arg1.auto_pubkey, &v5, &arg3), 1111);
        let v6 = DaoInviteCode{uuid: arg2};
        assert!(!0x2::dynamic_field::exists<DaoInviteCode>(&arg0.id, v6), 1112);
        let v7 = DaoInviteCodeData{
            inviter   : arg1.owner,
            recipient : v3,
            used_by   : v1,
            used_at   : 0x2::clock::timestamp_ms(arg4) / 1000,
        };
        0x2::dynamic_field::add<DaoInviteCode, DaoInviteCodeData>(&mut arg0.id, v6, v7);
    }

    fun verify_reg_invite_code(arg0: &mut User, arg1: vector<u8>, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(&arg1) == 17, 1093);
        assert!(0x1::vector::length<u8>(&arg2) > 0, 1093);
        let v0 = *0x1::vector::borrow<u8>(&arg1, 0);
        let v1 = if (v0 == 0) {
            true
        } else if (v0 == 1) {
            true
        } else {
            v0 == 2
        };
        assert!(v1, 1093);
        let v2 = 0x2::tx_context::sender(arg4);
        let v3 = if (v0 == 1) {
            v2
        } else {
            @0x0
        };
        verify_reg_invite_signature(arg0, arg1, arg2, v3);
        if (v0 == 2) {
            let v4 = GeneralInviteCodeBookKey{dummy_field: false};
            assert!(0x2::dynamic_field::exists<GeneralInviteCodeBookKey>(&arg0.id, v4), 2037);
            let v5 = 0x2::dynamic_field::borrow<GeneralInviteCodeBookKey, GeneralInviteCodeBook>(&arg0.id, v4);
            let v6 = general_invite_entry_index(v5, arg1);
            assert!(0x1::option::is_some<u64>(&v6), 2037);
            assert!(!0x1::vector::borrow<GeneralInviteCodeEntry>(&v5.entries, 0x1::option::destroy_some<u64>(v6)).revoked, 2035);
        } else {
            let v7 = RegInviteCode{uuid: arg1};
            assert!(!0x2::dynamic_field::exists<RegInviteCode>(&arg0.id, v7), 1094);
            let v8 = RegInviteCodeData{
                inviter   : arg0.owner,
                recipient : v3,
                used_by   : v2,
                used_at   : 0x2::clock::timestamp_ms(arg3) / 1000,
            };
            0x2::dynamic_field::add<RegInviteCode, RegInviteCodeData>(&mut arg0.id, v7, v8);
        };
    }

    fun verify_reg_invite_signature(arg0: &User, arg1: vector<u8>, arg2: vector<u8>, arg3: address) {
        let v0 = 0x2::object::id<User>(arg0);
        let v1 = 0x2::bcs::to_bytes<0x2::object::ID>(&v0);
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<vector<u8>>(&arg1));
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<address>(&arg3));
        assert!(verify_signature(&arg0.auto_pubkey, &v1, &arg2), 1093);
    }

    fun verify_signature(arg0: &vector<u8>, arg1: &vector<u8>, arg2: &vector<u8>) : bool {
        let v0 = 0x1::vector::length<u8>(arg0);
        if (v0 == 32) {
            assert!(0x1::vector::length<u8>(arg2) == 64, 1018);
            0x2::ed25519::ed25519_verify(arg2, arg0, arg1)
        } else if (v0 == 33) {
            assert!(*0x1::vector::borrow<u8>(arg0, 0) == 0, 1017);
            let v2 = b"";
            let v3 = 1;
            while (v3 < 33) {
                0x1::vector::push_back<u8>(&mut v2, *0x1::vector::borrow<u8>(arg0, v3));
                v3 = v3 + 1;
            };
            assert!(0x1::vector::length<u8>(arg2) == 64, 1018);
            0x2::ed25519::ed25519_verify(arg2, &v2, arg1)
        } else {
            assert!(v0 == 34, 1017);
            let v4 = *0x1::vector::borrow<u8>(arg0, 0);
            let v5 = b"";
            let v6 = 1;
            while (v6 < 34) {
                0x1::vector::push_back<u8>(&mut v5, *0x1::vector::borrow<u8>(arg0, v6));
                v6 = v6 + 1;
            };
            if (v4 == 1) {
                assert!(0x1::vector::length<u8>(arg2) == 64, 1018);
                0x2::ecdsa_k1::secp256k1_verify(arg2, &v5, arg1, 1)
            } else {
                assert!(v4 == 2, 1017);
                assert!(0x1::vector::length<u8>(arg2) == 64, 1018);
                0x2::ecdsa_r1::secp256r1_verify(arg2, &v5, arg1, 1)
            }
        }
    }

    entry fun withdraw_work_deposit_v2<T0: drop>(arg0: &Platform, arg1: &PlatformDenyList, arg2: &Work, arg3: &mut WorkDeposit<T0>, arg4: &0x2::clock::Clock, arg5: &mut ChangeShard, arg6: &mut 0x2::tx_context::TxContext) {
        ensure_contract_version(arg0);
        assert_shard_matches(arg0, arg5, arg6);
        assert!(!0x2::dynamic_field::exists<address>(&arg1.id, 0x2::tx_context::sender(arg6)), 1021);
        assert!(!arg3.withdrawn, 1129);
        assert!(arg3.work_id == 0x2::object::id<Work>(arg2), 1131);
        let v0 = WorkDepositRefundSecondsKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists<WorkDepositRefundSecondsKey>(&arg0.id, v0), 1127);
        let v1 = WorkDepositRefundSecondsKey{dummy_field: false};
        assert!(0x2::clock::timestamp_ms(arg4) / 1000 >= arg2.published_at + *0x2::dynamic_field::borrow<WorkDepositRefundSecondsKey, u64>(&arg0.id, v1), 1128);
        arg3.withdrawn = true;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x1::option::extract<0x2::balance::Balance<T0>>(&mut arg3.balance), arg6), 0x2::tx_context::sender(arg6));
        record_object_change(arg5, 23, 0x2::object::id<WorkDeposit<T0>>(arg3), arg6);
    }

    entry fun work_update_intro(arg0: &Platform, arg1: &PlatformDenyList, arg2: &mut User, arg3: &mut Work, arg4: 0x1::string::String, arg5: &mut ChangeShard, arg6: &mut 0x2::tx_context::TxContext) {
        ensure_contract_version(arg0);
        assert_shard_matches(arg0, arg5, arg6);
        assert!(!arg0.disabled, 1091);
        let v0 = 0x2::tx_context::sender(arg6);
        assert!(!0x2::dynamic_field::exists<address>(&arg1.id, v0), 1021);
        assert!(!0x2::dynamic_field::exists<address>(&arg1.id, arg2.owner), 1021);
        ensure_auto_wallet_sender(arg2, v0);
        assert!(!arg2.page_key_paused, 1070);
        assert!(arg2.owner == arg3.owner, 1033);
        assert!(0x1::vector::length<u8>(0x1::string::as_bytes(&arg4)) > 0, 1027);
        arg3.intro = arg4;
        record_object_change(arg5, 5, 0x2::object::id<Work>(arg3), arg6);
    }

    // decompiled from Move bytecode v7
}

