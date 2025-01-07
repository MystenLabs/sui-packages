module 0x625d518a3cc78899742d76cf785609cd707e15228d4284aa4fee5ca53caa9849::dungeon_resident {
    struct TreasureKey has store, key {
        id: 0x2::object::UID,
        purchased_round: u64,
    }

    struct LeaderboardRecordItem has store, key {
        id: 0x2::object::UID,
        resident_id: 0x2::object::ID,
        rating: u64,
        rarity: 0x1::string::String,
        level: u64,
        identity: 0x1::string::String,
    }

    struct InviteCode has store {
        code: 0x1::string::String,
        is_used: bool,
    }

    struct DungeonState has store, key {
        id: 0x2::object::UID,
        rating_leaderboard: 0x625d518a3cc78899742d76cf785609cd707e15228d4284aa4fee5ca53caa9849::critbit::CritbitTree<vector<LeaderboardRecordItem>>,
        invite_code_inviter: 0x2::table::Table<0x1::string::String, address>,
        inviter_code_vecotr: 0x2::table::Table<address, vector<InviteCode>>,
        purchased_resident_count: u64,
        bured_dgg_count: u64,
        treasury_sui: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct DungeonResidentStyles has drop, store {
        rarity_color: 0x1::string::String,
        main_color: 0x1::string::String,
        sec_color: 0x1::string::String,
        contrast_color: 0x1::string::String,
    }

    struct DungeonResidentAttrs has drop, store {
        level: u64,
        rarity: 0x1::string::String,
        rating: u64,
    }

    struct Resident<T0> has store, key {
        id: 0x2::object::UID,
        identity_metadata: T0,
        level: u64,
        rating: u64,
        identity: 0x1::string::String,
        rarity: 0x1::string::String,
        main_color: 0x1::string::String,
        sec_color: 0x1::string::String,
        contrast_color: 0x1::string::String,
        rarity_color: 0x1::string::String,
    }

    struct ArcaneTrickster has store {
        dummy_field: bool,
    }

    struct CuteCommoner has store {
        dummy_field: bool,
    }

    struct DwarvenGlint has store {
        dummy_field: bool,
    }

    struct FlabbySpooky has store {
        dummy_field: bool,
    }

    struct FortressKnight has store {
        dummy_field: bool,
    }

    struct HornedBite has store {
        dummy_field: bool,
    }

    struct LaserReynard has store {
        dummy_field: bool,
    }

    struct MerrySeer has store {
        dummy_field: bool,
    }

    struct PrinceBoy has store {
        dummy_field: bool,
    }

    struct PumpkinMan has store {
        dummy_field: bool,
    }

    struct SkeletalCaptain has store {
        dummy_field: bool,
    }

    struct TinyQuirk has store {
        dummy_field: bool,
    }

    struct WhisperShaman has store {
        dummy_field: bool,
    }

    struct WizardSpeckle has store {
        dummy_field: bool,
    }

    struct ZippyDino has store {
        dummy_field: bool,
    }

    struct ResidentCount has store, key {
        id: 0x2::object::UID,
        count: 0x2::table::Table<u64, vector<0x2::object::ID>>,
    }

    struct RarityCount has store, key {
        id: 0x2::object::UID,
        count: 0x2::table::Table<u64, vector<0x2::object::ID>>,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct PlayerCap has key {
        id: 0x2::object::UID,
        account: address,
        inviter: address,
        purchase_key_num: u64,
    }

    struct DUNGEON_RESIDENT has drop {
        dummy_field: bool,
    }

    struct TreasureKeyPurchased has copy, drop {
        key_id: 0x2::object::ID,
        purchaser: address,
        purchase_time: u64,
    }

    fun add_leaderboard(arg0: &mut 0x625d518a3cc78899742d76cf785609cd707e15228d4284aa4fee5ca53caa9849::critbit::CritbitTree<vector<LeaderboardRecordItem>>, arg1: u64, arg2: LeaderboardRecordItem) {
        let (v0, v1) = 0x625d518a3cc78899742d76cf785609cd707e15228d4284aa4fee5ca53caa9849::critbit::find_leaf<vector<LeaderboardRecordItem>>(arg0, arg1);
        if (v0) {
            0x1::vector::push_back<LeaderboardRecordItem>(0x625d518a3cc78899742d76cf785609cd707e15228d4284aa4fee5ca53caa9849::critbit::borrow_mut_leaf_by_index<vector<LeaderboardRecordItem>>(arg0, v1), arg2);
        } else {
            0x625d518a3cc78899742d76cf785609cd707e15228d4284aa4fee5ca53caa9849::critbit::insert_leaf<vector<LeaderboardRecordItem>>(arg0, arg1, 0x1::vector::singleton<LeaderboardRecordItem>(arg2));
        };
    }

    fun add_rarity_child(arg0: &mut RarityCount, arg1: u64, arg2: 0x2::object::ID) {
        if (0x2::table::contains<u64, vector<0x2::object::ID>>(&arg0.count, arg1)) {
            0x1::vector::push_back<0x2::object::ID>(0x2::table::borrow_mut<u64, vector<0x2::object::ID>>(&mut arg0.count, arg1), arg2);
        } else {
            let v0 = 0x1::vector::empty<0x2::object::ID>();
            0x1::vector::push_back<0x2::object::ID>(&mut v0, arg2);
            0x2::table::add<u64, vector<0x2::object::ID>>(&mut arg0.count, arg1, v0);
        };
    }

    fun add_resident_child(arg0: &mut ResidentCount, arg1: u64, arg2: 0x2::object::ID) {
        if (0x2::table::contains<u64, vector<0x2::object::ID>>(&arg0.count, arg1)) {
            0x1::vector::push_back<0x2::object::ID>(0x2::table::borrow_mut<u64, vector<0x2::object::ID>>(&mut arg0.count, arg1), arg2);
        } else {
            let v0 = 0x1::vector::empty<0x2::object::ID>();
            0x1::vector::push_back<0x2::object::ID>(&mut v0, arg2);
            0x2::table::add<u64, vector<0x2::object::ID>>(&mut arg0.count, arg1, v0);
        };
    }

    public fun admin_get_invite_code(arg0: &AdminCap, arg1: &mut DungeonState, arg2: u8, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        generate_invite_code(arg1, arg2, arg3, arg4);
    }

    public fun admin_mint_dgg(arg0: &AdminCap, arg1: &mut 0x625d518a3cc78899742d76cf785609cd707e15228d4284aa4fee5ca53caa9849::dgg_token::DungeonVault, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x625d518a3cc78899742d76cf785609cd707e15228d4284aa4fee5ca53caa9849::dgg_token::internal_mint(arg1, arg2, 0x2::tx_context::sender(arg3), arg3);
    }

    public fun create_display<T0: key>(arg0: &0x2::package::Publisher, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Lv."));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"rating"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"identity"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(0x625d518a3cc78899742d76cf785609cd707e15228d4284aa4fee5ca53caa9849::identity_source::generateSVG(arg1, b"{rarity_color}", b"{level}", b"{rarity}", b"{rating}", b"{main_color}", b"{sec_color}", b"{contrast_color}")));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{level}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{rating}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{identity}"));
        let v4 = 0x2::display::new_with_fields<T0>(arg0, v0, v2, arg2);
        0x2::display::update_version<T0>(&mut v4);
        0x2::transfer::public_transfer<0x2::display::Display<T0>>(v4, 0x2::tx_context::sender(arg2));
    }

    public fun create_display_for_combating<T0: key>(arg0: &0x2::package::Publisher, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Lv."));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"rating"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"identity"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(0x625d518a3cc78899742d76cf785609cd707e15228d4284aa4fee5ca53caa9849::identity_source::generateSVG(arg1, b"{resident.rarity_color}", b"{resident.level}", b"{resident.rarity}", b"{resident.rating}", b"{resident.main_color}", b"{resident.sec_color}", b"{resident.contrast_color}")));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{resident.level}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{resident.rating}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{resident.identity}"));
        let v4 = 0x2::display::new_with_fields<T0>(arg0, v0, v2, arg2);
        0x2::display::update_version<T0>(&mut v4);
        0x2::transfer::public_transfer<0x2::display::Display<T0>>(v4, 0x2::tx_context::sender(arg2));
    }

    fun do_purchase(arg0: &mut DungeonState, arg1: &mut 0x625d518a3cc78899742d76cf785609cd707e15228d4284aa4fee5ca53caa9849::dgg_token::DungeonVault, arg2: &mut PlayerCap, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg4) / 1000;
        assert!(v0 <= 1692803367 + 3 * (arg3 - 2), 1);
        let v1 = 0x2::tx_context::sender(arg5);
        arg0.purchased_resident_count = arg0.purchased_resident_count + 1;
        let v2 = TreasureKey{
            id              : 0x2::object::new(arg5),
            purchased_round : arg3,
        };
        arg2.purchase_key_num = arg2.purchase_key_num + 1;
        0x625d518a3cc78899742d76cf785609cd707e15228d4284aa4fee5ca53caa9849::dgg_token::internal_mint(arg1, 1000000000, arg2.inviter, arg5);
        let v3 = TreasureKeyPurchased{
            key_id        : 0x2::object::id<TreasureKey>(&v2),
            purchaser     : v1,
            purchase_time : v0,
        };
        0x2::event::emit<TreasureKeyPurchased>(v3);
        0x2::transfer::public_transfer<TreasureKey>(v2, v1);
    }

    public fun dungeon_treasury_balance(arg0: &DungeonState) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.treasury_sui)
    }

    fun generate_invite_code(arg0: &mut DungeonState, arg1: u8, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::tx_context::digest(arg3);
        let v2 = 0x2::address::to_bytes(v0);
        0x1::vector::append<u8>(&mut v2, 0x625d518a3cc78899742d76cf785609cd707e15228d4284aa4fee5ca53caa9849::dungeon_utils::u64_to_ascii(0x2::clock::timestamp_ms(arg2)));
        let v3 = 0;
        let v4 = 0x1::vector::empty<InviteCode>();
        while (v3 < arg1) {
            let v5 = *v1;
            0x1::vector::push_back<u8>(&mut v2, v3);
            0x1::vector::append<u8>(&mut v5, v2);
            let v6 = 0x2::hash::blake2b256(&v5);
            let v7 = 0x1::vector::empty<u8>();
            let v8 = 0;
            while (v8 < 4) {
                0x1::vector::push_back<u8>(&mut v7, *0x1::vector::borrow<u8>(&v6, v8));
                v8 = v8 + 1;
            };
            let v9 = InviteCode{
                code    : 0x1::string::utf8(0x2::hex::encode(v7)),
                is_used : false,
            };
            0x1::vector::push_back<InviteCode>(&mut v4, v9);
            v3 = v3 + 1;
        };
        let v10 = 0;
        while (v10 < 0x1::vector::length<InviteCode>(&v4)) {
            0x2::table::add<0x1::string::String, address>(&mut arg0.invite_code_inviter, 0x1::vector::borrow<InviteCode>(&v4, v10).code, v0);
            v10 = v10 + 1;
        };
        if (0x2::table::contains<address, vector<InviteCode>>(&arg0.inviter_code_vecotr, v0)) {
            0x1::vector::append<InviteCode>(0x2::table::borrow_mut<address, vector<InviteCode>>(&mut arg0.inviter_code_vecotr, v0), v4);
        } else {
            0x2::table::add<address, vector<InviteCode>>(&mut arg0.inviter_code_vecotr, v0, v4);
        };
    }

    public fun get_rarity_count(arg0: &RarityCount) : vector<u64> {
        let v0 = 0x1::vector::empty<u64>();
        let v1 = 0;
        while (v1 < 5) {
            if (0x2::table::contains<u64, vector<0x2::object::ID>>(&arg0.count, v1)) {
                0x1::vector::push_back<u64>(&mut v0, 0x1::vector::length<0x2::object::ID>(0x2::table::borrow<u64, vector<0x2::object::ID>>(&arg0.count, v1)));
            } else {
                0x1::vector::push_back<u64>(&mut v0, 0);
            };
            v1 = v1 + 1;
        };
        0x625d518a3cc78899742d76cf785609cd707e15228d4284aa4fee5ca53caa9849::dungeon_event::rarity_count_event(v0);
        v0
    }

    public fun get_rating_leaderboard(arg0: &DungeonState, arg1: u64, arg2: u64) : vector<0x2::object::ID> {
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        let v1 = vector[];
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = vector[];
        let v4 = 0x1::vector::empty<0x1::string::String>();
        let v5 = 0;
        if (arg1 == 0) {
            let (v6, _) = 0x625d518a3cc78899742d76cf785609cd707e15228d4284aa4fee5ca53caa9849::critbit::max_leaf<vector<LeaderboardRecordItem>>(&arg0.rating_leaderboard);
            arg1 = v6;
        };
        while (v5 < 50) {
            let v8 = 0x625d518a3cc78899742d76cf785609cd707e15228d4284aa4fee5ca53caa9849::critbit::borrow_leaf_by_key<vector<LeaderboardRecordItem>>(&arg0.rating_leaderboard, arg1);
            while (0x1::vector::length<LeaderboardRecordItem>(v8) > arg2) {
                let v9 = 0x1::vector::borrow<LeaderboardRecordItem>(v8, arg2);
                0x1::vector::push_back<0x2::object::ID>(&mut v0, v9.resident_id);
                0x1::vector::push_back<u64>(&mut v1, v9.rating);
                0x1::vector::push_back<0x1::string::String>(&mut v2, v9.rarity);
                0x1::vector::push_back<u64>(&mut v3, v9.level);
                0x1::vector::push_back<0x1::string::String>(&mut v4, v9.identity);
                arg2 = arg2 + 1;
                let v10 = v5 + 1;
                v5 = v10;
                if (v10 >= 50) {
                    0x625d518a3cc78899742d76cf785609cd707e15228d4284aa4fee5ca53caa9849::dungeon_event::rating_leaderboard_event(v0, v1, v2, v3, v4);
                    return v0
                };
            };
            arg2 = 0;
            let (v11, v12) = 0x625d518a3cc78899742d76cf785609cd707e15228d4284aa4fee5ca53caa9849::critbit::previous_leaf<vector<LeaderboardRecordItem>>(&arg0.rating_leaderboard, arg1);
            if (v12 != 9223372036854775808) {
                arg1 = v11;
                continue
            };
            0x625d518a3cc78899742d76cf785609cd707e15228d4284aa4fee5ca53caa9849::dungeon_event::rating_leaderboard_event(v0, v1, v2, v3, v4);
            return v0
        };
        0x625d518a3cc78899742d76cf785609cd707e15228d4284aa4fee5ca53caa9849::dungeon_event::rating_leaderboard_event(v0, v1, v2, v3, v4);
        v0
    }

    public fun get_resident_count(arg0: &ResidentCount) : vector<u64> {
        let v0 = 0x1::vector::empty<u64>();
        let v1 = 0;
        while (v1 < 15) {
            if (0x2::table::contains<u64, vector<0x2::object::ID>>(&arg0.count, v1)) {
                0x1::vector::push_back<u64>(&mut v0, 0x1::vector::length<0x2::object::ID>(0x2::table::borrow<u64, vector<0x2::object::ID>>(&arg0.count, v1)));
            } else {
                0x1::vector::push_back<u64>(&mut v0, 0);
            };
            v1 = v1 + 1;
        };
        0x625d518a3cc78899742d76cf785609cd707e15228d4284aa4fee5ca53caa9849::dungeon_event::resident_count_event(v0);
        v0
    }

    public fun get_upgrade_fee(arg0: u64) {
        0x625d518a3cc78899742d76cf785609cd707e15228d4284aa4fee5ca53caa9849::dungeon_event::upgrade_fee_event(0x625d518a3cc78899742d76cf785609cd707e15228d4284aa4fee5ca53caa9849::dungeon_utils::getLevelUpFee(arg0));
    }

    public fun get_user_invite_code(arg0: &DungeonState, arg1: address) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = vector[];
        if (0x2::table::contains<address, vector<InviteCode>>(&arg0.inviter_code_vecotr, arg1)) {
            let v2 = 0x2::table::borrow<address, vector<InviteCode>>(&arg0.inviter_code_vecotr, arg1);
            let v3 = 0;
            while (v3 < 0x1::vector::length<InviteCode>(v2)) {
                let v4 = 0x1::vector::borrow<InviteCode>(v2, v3);
                0x1::vector::push_back<0x1::string::String>(&mut v0, v4.code);
                0x1::vector::push_back<bool>(&mut v1, v4.is_used);
                v3 = v3 + 1;
            };
        };
        0x625d518a3cc78899742d76cf785609cd707e15228d4284aa4fee5ca53caa9849::dungeon_event::user_invite_code_event(v0, v1);
    }

    fun init(arg0: DUNGEON_RESIDENT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        let v1 = ResidentCount{
            id    : 0x2::object::new(arg1),
            count : 0x2::table::new<u64, vector<0x2::object::ID>>(arg1),
        };
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<DUNGEON_RESIDENT>(arg0, arg1), 0x2::tx_context::sender(arg1));
        let v2 = DungeonState{
            id                       : 0x2::object::new(arg1),
            rating_leaderboard       : 0x625d518a3cc78899742d76cf785609cd707e15228d4284aa4fee5ca53caa9849::critbit::new<vector<LeaderboardRecordItem>>(arg1),
            invite_code_inviter      : 0x2::table::new<0x1::string::String, address>(arg1),
            inviter_code_vecotr      : 0x2::table::new<address, vector<InviteCode>>(arg1),
            purchased_resident_count : 0,
            bured_dgg_count          : 0,
            treasury_sui             : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<DungeonState>(v2);
        let v3 = RarityCount{
            id    : 0x2::object::new(arg1),
            count : 0x2::table::new<u64, vector<0x2::object::ID>>(arg1),
        };
        0x2::transfer::share_object<RarityCount>(v3);
        0x2::transfer::share_object<ResidentCount>(v1);
    }

    fun make_a_resident<T0: store>(arg0: T0, arg1: DungeonResidentAttrs, arg2: DungeonResidentStyles, arg3: u64, arg4: u64, arg5: 0x1::string::String, arg6: &mut RarityCount, arg7: &mut ResidentCount, arg8: &mut DungeonState, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = Resident<T0>{
            id                : 0x2::object::new(arg9),
            identity_metadata : arg0,
            level             : arg1.level,
            rating            : arg1.rating,
            identity          : arg5,
            rarity            : arg1.rarity,
            main_color        : arg2.main_color,
            sec_color         : arg2.sec_color,
            contrast_color    : arg2.contrast_color,
            rarity_color      : arg2.rarity_color,
        };
        let v1 = 0x2::object::uid_to_inner(&v0.id);
        add_resident_child(arg7, arg3, v1);
        add_rarity_child(arg6, arg4, v1);
        let v2 = LeaderboardRecordItem{
            id          : 0x2::object::new(arg9),
            resident_id : v1,
            rating      : arg1.rating,
            rarity      : arg1.rarity,
            level       : arg1.level,
            identity    : arg5,
        };
        let v3 = &mut arg8.rating_leaderboard;
        add_leaderboard(v3, arg1.rating, v2);
        0x2::transfer::transfer<Resident<T0>>(v0, 0x2::tx_context::sender(arg9));
    }

    public entry fun purchase_key_with_sui(arg0: &mut DungeonState, arg1: &mut 0x625d518a3cc78899742d76cf785609cd707e15228d4284aa4fee5ca53caa9849::dgg_token::DungeonVault, arg2: &mut PlayerCap, arg3: u64, arg4: &0x2::clock::Clock, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.purchased_resident_count < 30000, 0);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg5) == 3000000000, 7);
        0x2::coin::put<0x2::sui::SUI>(&mut arg0.treasury_sui, arg5);
        do_purchase(arg0, arg1, arg2, arg3, arg4, arg6);
    }

    public fun register(arg0: &mut DungeonState, arg1: 0x1::string::String, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(!0x2::table::contains<address, vector<InviteCode>>(&arg0.inviter_code_vecotr, v0), 5);
        let v1 = &mut arg0.invite_code_inviter;
        let v2 = &mut arg0.inviter_code_vecotr;
        assert!(0x2::table::contains<0x1::string::String, address>(v1, arg1), 4);
        let v3 = *0x2::table::borrow_mut<0x1::string::String, address>(v1, arg1);
        assert!(0x2::table::contains<address, vector<InviteCode>>(v2, v3), 4);
        let v4 = 0x2::table::borrow_mut<address, vector<InviteCode>>(v2, v3);
        let v5 = false;
        let v6 = 0;
        while (v6 < 0x1::vector::length<InviteCode>(v4)) {
            let v7 = 0x1::vector::borrow_mut<InviteCode>(v4, v6);
            if (v7.code == arg1) {
                assert!(!v7.is_used, 6);
                v5 = true;
                v7.is_used = true;
                break
            };
            v6 = v6 + 1;
        };
        assert!(v5, 4);
        generate_invite_code(arg0, 5, arg2, arg3);
        let v8 = PlayerCap{
            id               : 0x2::object::new(arg3),
            account          : v0,
            inviter          : v3,
            purchase_key_num : 0,
        };
        0x2::transfer::transfer<PlayerCap>(v8, v0);
    }

    fun remove_leaderboard(arg0: &mut 0x625d518a3cc78899742d76cf785609cd707e15228d4284aa4fee5ca53caa9849::critbit::CritbitTree<vector<LeaderboardRecordItem>>, arg1: u64, arg2: 0x2::object::ID) : LeaderboardRecordItem {
        let v0 = 0x625d518a3cc78899742d76cf785609cd707e15228d4284aa4fee5ca53caa9849::critbit::borrow_mut_leaf_by_key<vector<LeaderboardRecordItem>>(arg0, arg1);
        let v1 = 0;
        let v2 = 0x1::vector::length<LeaderboardRecordItem>(v0);
        while (v2 > v1) {
            if (arg2 == 0x1::vector::borrow<LeaderboardRecordItem>(v0, v1).resident_id) {
                break
            };
            v1 = v1 + 1;
        };
        assert!(v1 < v2, 3);
        if (0x1::vector::length<LeaderboardRecordItem>(v0) == 0) {
            let (v3, v4) = 0x625d518a3cc78899742d76cf785609cd707e15228d4284aa4fee5ca53caa9849::critbit::find_leaf<vector<LeaderboardRecordItem>>(arg0, arg1);
            if (v3) {
                0x1::vector::destroy_empty<LeaderboardRecordItem>(0x625d518a3cc78899742d76cf785609cd707e15228d4284aa4fee5ca53caa9849::critbit::remove_leaf_by_index<vector<LeaderboardRecordItem>>(arg0, v4));
            };
        };
        0x1::vector::remove<LeaderboardRecordItem>(v0, v1)
    }

    public fun resident_rating<T0>(arg0: &Resident<T0>) : u64 {
        arg0.rating
    }

    public fun reveal_round(arg0: u64) : u64 {
        arg0 + 10
    }

    public entry fun reveal_treasure(arg0: TreasureKey, arg1: vector<u8>, arg2: &mut RarityCount, arg3: &mut ResidentCount, arg4: &mut DungeonState, arg5: &mut 0x2::tx_context::TxContext) {
        0x625d518a3cc78899742d76cf785609cd707e15228d4284aa4fee5ca53caa9849::drand_lib::verify_drand_signature(arg1, reveal_round(arg0.purchased_round));
        let v0 = 0x625d518a3cc78899742d76cf785609cd707e15228d4284aa4fee5ca53caa9849::drand_lib::derive_randomness(arg1);
        let v1 = 0x2::object::id<TreasureKey>(&arg0);
        let v2 = 0x2::object::id_to_bytes(&v1);
        let v3 = 0x2::hmac::hmac_sha3_256(&v0, &v2);
        let v4 = 0x625d518a3cc78899742d76cf785609cd707e15228d4284aa4fee5ca53caa9849::drand_lib::safe_selection(15, &v3);
        let (v5, v6, v7, v8) = 0x625d518a3cc78899742d76cf785609cd707e15228d4284aa4fee5ca53caa9849::dungeon_utils::calcRarity(v3);
        let v9 = 0x2::object::id<TreasureKey>(&arg0);
        let (v10, v11, v12) = 0x625d518a3cc78899742d76cf785609cd707e15228d4284aa4fee5ca53caa9849::dungeon_utils::genreataColor(v4, v0, 0x2::object::id_to_bytes(&v9));
        let v13 = DungeonResidentStyles{
            rarity_color   : v8,
            main_color     : v10,
            sec_color      : v11,
            contrast_color : v12,
        };
        let v14 = DungeonResidentAttrs{
            level  : 1,
            rarity : v5,
            rating : 0x625d518a3cc78899742d76cf785609cd707e15228d4284aa4fee5ca53caa9849::dungeon_utils::calcRating(v6, v0),
        };
        if (v4 == 0) {
            let v15 = ArcaneTrickster{dummy_field: false};
            make_a_resident<ArcaneTrickster>(v15, v14, v13, v4, v7, 0x1::string::utf8(b"Arcane Trickster"), arg2, arg3, arg4, arg5);
        } else if (v4 == 1) {
            let v16 = CuteCommoner{dummy_field: false};
            make_a_resident<CuteCommoner>(v16, v14, v13, v4, v7, 0x1::string::utf8(b"Cute Commoner"), arg2, arg3, arg4, arg5);
        } else if (v4 == 2) {
            let v17 = DwarvenGlint{dummy_field: false};
            make_a_resident<DwarvenGlint>(v17, v14, v13, v4, v7, 0x1::string::utf8(b"Dwarven Glint"), arg2, arg3, arg4, arg5);
        } else if (v4 == 3) {
            let v18 = FlabbySpooky{dummy_field: false};
            make_a_resident<FlabbySpooky>(v18, v14, v13, v4, v7, 0x1::string::utf8(b"Flabby Spooky"), arg2, arg3, arg4, arg5);
        } else if (v4 == 4) {
            let v19 = FortressKnight{dummy_field: false};
            make_a_resident<FortressKnight>(v19, v14, v13, v4, v7, 0x1::string::utf8(b"Fortress Knight"), arg2, arg3, arg4, arg5);
        } else if (v4 == 5) {
            let v20 = HornedBite{dummy_field: false};
            make_a_resident<HornedBite>(v20, v14, v13, v4, v7, 0x1::string::utf8(b"Horned Bite"), arg2, arg3, arg4, arg5);
        } else if (v4 == 6) {
            let v21 = LaserReynard{dummy_field: false};
            make_a_resident<LaserReynard>(v21, v14, v13, v4, v7, 0x1::string::utf8(b"Laser Reynard"), arg2, arg3, arg4, arg5);
        } else if (v4 == 7) {
            let v22 = MerrySeer{dummy_field: false};
            make_a_resident<MerrySeer>(v22, v14, v13, v4, v7, 0x1::string::utf8(b"Merry Seer"), arg2, arg3, arg4, arg5);
        } else if (v4 == 8) {
            let v23 = PrinceBoy{dummy_field: false};
            make_a_resident<PrinceBoy>(v23, v14, v13, v4, v7, 0x1::string::utf8(b"Prince Boy"), arg2, arg3, arg4, arg5);
        } else if (v4 == 9) {
            let v24 = PumpkinMan{dummy_field: false};
            make_a_resident<PumpkinMan>(v24, v14, v13, v4, v7, 0x1::string::utf8(b"Pumpkin Man"), arg2, arg3, arg4, arg5);
        } else if (v4 == 10) {
            let v25 = SkeletalCaptain{dummy_field: false};
            make_a_resident<SkeletalCaptain>(v25, v14, v13, v4, v7, 0x1::string::utf8(b"Skeletal Captain"), arg2, arg3, arg4, arg5);
        } else if (v4 == 11) {
            let v26 = TinyQuirk{dummy_field: false};
            make_a_resident<TinyQuirk>(v26, v14, v13, v4, v7, 0x1::string::utf8(b"Tiny Quirk"), arg2, arg3, arg4, arg5);
        } else if (v4 == 12) {
            let v27 = WhisperShaman{dummy_field: false};
            make_a_resident<WhisperShaman>(v27, v14, v13, v4, v7, 0x1::string::utf8(b"Whisper Shaman"), arg2, arg3, arg4, arg5);
        } else if (v4 == 13) {
            let v28 = WizardSpeckle{dummy_field: false};
            make_a_resident<WizardSpeckle>(v28, v14, v13, v4, v7, 0x1::string::utf8(b"Wizard Speckle"), arg2, arg3, arg4, arg5);
        } else if (v4 == 14) {
            let v29 = ZippyDino{dummy_field: false};
            make_a_resident<ZippyDino>(v29, v14, v13, v4, v7, 0x1::string::utf8(b"Zippy Dino"), arg2, arg3, arg4, arg5);
        };
        let TreasureKey {
            id              : v30,
            purchased_round : _,
        } = arg0;
        0x2::object::delete(v30);
    }

    public fun upgrade_resident<T0>(arg0: &mut Resident<T0>, arg1: &mut 0x625d518a3cc78899742d76cf785609cd707e15228d4284aa4fee5ca53caa9849::dgg_token::DungeonVault, arg2: &mut DungeonState, arg3: 0x2::coin::Coin<0x625d518a3cc78899742d76cf785609cd707e15228d4284aa4fee5ca53caa9849::dgg_token::DGG_TOKEN>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.level < 30, 8);
        let v0 = 0x625d518a3cc78899742d76cf785609cd707e15228d4284aa4fee5ca53caa9849::dungeon_utils::getLevelUpFee(arg0.level);
        assert!(0x2::coin::value<0x625d518a3cc78899742d76cf785609cd707e15228d4284aa4fee5ca53caa9849::dgg_token::DGG_TOKEN>(&arg3) == (v0 as u64), 2);
        0x625d518a3cc78899742d76cf785609cd707e15228d4284aa4fee5ca53caa9849::dgg_token::internal_burn(arg1, arg3);
        arg2.bured_dgg_count = arg2.bured_dgg_count + v0;
        let v1 = 0;
        if (arg0.rarity == 0x1::string::utf8(b"UR")) {
            v1 = arg0.rating * 11400 / 10000;
        } else if (arg0.rarity == 0x1::string::utf8(b"SSR")) {
            v1 = arg0.rating * 11000 / 10000;
        } else if (arg0.rarity == 0x1::string::utf8(b"SR")) {
            v1 = arg0.rating * 10800 / 10000;
        } else if (arg0.rarity == 0x1::string::utf8(b"R")) {
            v1 = arg0.rating * 10600 / 10000;
        } else if (arg0.rarity == 0x1::string::utf8(b"N")) {
            v1 = arg0.rating * 10400 / 10000;
        };
        arg0.rating = v1;
        arg0.level = arg0.level + 1;
        let v2 = &mut arg2.rating_leaderboard;
        let LeaderboardRecordItem {
            id          : v3,
            resident_id : _,
            rating      : _,
            rarity      : _,
            level       : _,
            identity    : v8,
        } = remove_leaderboard(v2, arg0.rating, 0x2::object::uid_to_inner(&arg0.id));
        0x2::object::delete(v3);
        let v9 = LeaderboardRecordItem{
            id          : 0x2::object::new(arg4),
            resident_id : 0x2::object::uid_to_inner(&arg0.id),
            rating      : v1,
            rarity      : arg0.rarity,
            level       : arg0.level,
            identity    : v8,
        };
        let v10 = &mut arg2.rating_leaderboard;
        add_leaderboard(v10, v1, v9);
    }

    public fun withdraw_sui(arg0: &AdminCap, arg1: &mut DungeonState, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg1.treasury_sui, 0x2::balance::value<0x2::sui::SUI>(&arg1.treasury_sui), arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

