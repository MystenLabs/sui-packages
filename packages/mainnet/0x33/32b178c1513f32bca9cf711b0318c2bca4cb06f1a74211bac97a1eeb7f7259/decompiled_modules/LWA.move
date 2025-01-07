module 0x3332b178c1513f32bca9cf711b0318c2bca4cb06f1a74211bac97a1eeb7f7259::LWA {
    struct VoteBoard has key {
        id: 0x2::object::UID,
        status: 0x3332b178c1513f32bca9cf711b0318c2bca4cb06f1a74211bac97a1eeb7f7259::vote::VoteStatus,
        participants: 0x2::vec_map::VecMap<address, 0x3332b178c1513f32bca9cf711b0318c2bca4cb06f1a74211bac97a1eeb7f7259::vote::Participant>,
        result: u64,
    }

    struct LWA has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<LWA>, arg1: 0x2::coin::Coin<LWA>) {
        0x2::coin::burn<LWA>(arg0, arg1);
    }

    public entry fun add_deny(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCap<LWA>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_add<LWA>(arg0, arg1, arg2, arg3);
    }

    public entry fun enable_vote(arg0: &mut 0x2::coin::TreasuryCap<LWA>, arg1: &mut VoteBoard, arg2: bool, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x3332b178c1513f32bca9cf711b0318c2bca4cb06f1a74211bac97a1eeb7f7259::vote::is_votestatus_enable(&arg1.status) == false, 8);
        assert!(arg6 <= 100, 11);
        assert!(arg3 < arg4, 10);
        0x3332b178c1513f32bca9cf711b0318c2bca4cb06f1a74211bac97a1eeb7f7259::vote::votestatus_enable(&mut arg1.status, arg2, arg3, arg4, arg5, arg6);
    }

    fun init(arg0: LWA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency<LWA>(arg0, 9, b"LWA", b"LUMIWAVE", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://innofile.blob.core.windows.net/inno/live/icon/LUMIWAVE_Primary_black.png")), arg1);
        let v3 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LWA>>(v2);
        let v4 = 0x2::tx_context::sender(arg1);
        0x2::coin::mint_and_transfer<LWA>(&mut v3, 770075466000000000, v4, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LWA>>(v3, v4);
        0x2::transfer::public_transfer<0x2::coin::DenyCap<LWA>>(v1, v4);
        0x2::transfer::share_object<VoteBoard>(make_voteboard(arg1));
    }

    public fun is_enable_vote(arg0: &mut VoteBoard) : bool {
        0x3332b178c1513f32bca9cf711b0318c2bca4cb06f1a74211bac97a1eeb7f7259::vote::is_votestatus_enable(&arg0.status)
    }

    public fun is_voted(arg0: &mut VoteBoard, arg1: address) : bool {
        0x3332b178c1513f32bca9cf711b0318c2bca4cb06f1a74211bac97a1eeb7f7259::vote::is_voted(&arg0.participants, arg1)
    }

    public entry fun lock_coin_transfer(arg0: &mut 0x2::coin::TreasuryCap<LWA>, arg1: 0x2::coin::Coin<LWA>, arg2: address, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x2::pay::keep<LWA>(arg1, arg6);
        0x3332b178c1513f32bca9cf711b0318c2bca4cb06f1a74211bac97a1eeb7f7259::lock_coin::make_lock_coin<LWA>(arg2, 0x2::clock::timestamp_ms(arg5), arg4, 0x2::coin::into_balance<LWA>(0x2::coin::split<LWA>(&mut arg1, arg3, arg6)), arg6);
    }

    fun make_voteboard(arg0: &mut 0x2::tx_context::TxContext) : VoteBoard {
        VoteBoard{
            id           : 0x2::object::new(arg0),
            status       : 0x3332b178c1513f32bca9cf711b0318c2bca4cb06f1a74211bac97a1eeb7f7259::vote::empty_status(),
            participants : 0x3332b178c1513f32bca9cf711b0318c2bca4cb06f1a74211bac97a1eeb7f7259::vote::empty_participants(),
            result       : 0,
        }
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<LWA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::total_supply<LWA>(arg0) + arg1 <= 1000000000000000000, 4);
        0x2::coin::mint_and_transfer<LWA>(arg0, arg1, arg2, arg3);
    }

    public entry fun remove_deny(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCap<LWA>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_remove<LWA>(arg0, arg1, arg2, arg3);
    }

    public entry fun unlock_coin(arg0: 0x3332b178c1513f32bca9cf711b0318c2bca4cb06f1a74211bac97a1eeb7f7259::lock_coin::LockedCoin<LWA>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        0x3332b178c1513f32bca9cf711b0318c2bca4cb06f1a74211bac97a1eeb7f7259::lock_coin::unlock_wrapper<LWA>(arg0, arg1, arg2);
    }

    public entry fun vote(arg0: &mut VoteBoard, arg1: &0x2::coin::Coin<LWA>, arg2: &0x2::clock::Clock, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x3332b178c1513f32bca9cf711b0318c2bca4cb06f1a74211bac97a1eeb7f7259::vote::is_votestatus_enable(&arg0.status) == true, 1);
        assert!(0x3332b178c1513f32bca9cf711b0318c2bca4cb06f1a74211bac97a1eeb7f7259::vote::votestatus_period_check(&arg0.status, arg2) == true, 5);
        assert!(!0x3332b178c1513f32bca9cf711b0318c2bca4cb06f1a74211bac97a1eeb7f7259::vote::is_voted(&arg0.participants, 0x2::tx_context::sender(arg4)), 2);
        assert!(0x2::coin::value<LWA>(arg1) != 0, 3);
        0x3332b178c1513f32bca9cf711b0318c2bca4cb06f1a74211bac97a1eeb7f7259::vote::voting(&mut arg0.participants, 0x2::tx_context::sender(arg4), arg2, arg3);
        0x2::transfer::public_transfer<0x3332b178c1513f32bca9cf711b0318c2bca4cb06f1a74211bac97a1eeb7f7259::vote::VotingEvidence>(0x3332b178c1513f32bca9cf711b0318c2bca4cb06f1a74211bac97a1eeb7f7259::vote::make_VotingEvidence(arg4, arg3), 0x2::tx_context::sender(arg4));
    }

    public entry fun vote_counting(arg0: &mut 0x2::coin::TreasuryCap<LWA>, arg1: &mut VoteBoard, arg2: &0x2::clock::Clock, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.result == 0, 6);
        let (v0, v1) = 0x3332b178c1513f32bca9cf711b0318c2bca4cb06f1a74211bac97a1eeb7f7259::vote::votestatus_countable(&arg1.status, &arg1.participants, arg2);
        assert!(v0 == true, 9);
        if (v1 == true) {
            let (_, _, _, v5) = 0x3332b178c1513f32bca9cf711b0318c2bca4cb06f1a74211bac97a1eeb7f7259::vote::vote_counting(&arg1.participants, &arg1.status);
            if (v5 == true) {
                arg1.result = 1;
                let v6 = 0x2::tx_context::sender(arg4);
                mint(arg0, arg3, v6, arg4);
            } else {
                arg1.result = 2;
            };
        } else {
            arg1.result = 3;
        };
    }

    public fun vote_detail(arg0: &VoteBoard) : (0x3332b178c1513f32bca9cf711b0318c2bca4cb06f1a74211bac97a1eeb7f7259::vote::VoteStatus, 0x2::vec_map::VecMap<address, 0x3332b178c1513f32bca9cf711b0318c2bca4cb06f1a74211bac97a1eeb7f7259::vote::Participant>, u64) {
        (arg0.status, arg0.participants, arg0.result)
    }

    public entry fun vote_reset(arg0: &mut 0x2::coin::TreasuryCap<LWA>, arg1: &mut VoteBoard, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x3332b178c1513f32bca9cf711b0318c2bca4cb06f1a74211bac97a1eeb7f7259::vote::is_votestatus_enable(&arg1.status) == true, 1);
        assert!(arg1.result != 0, 7);
        arg1.status = 0x3332b178c1513f32bca9cf711b0318c2bca4cb06f1a74211bac97a1eeb7f7259::vote::empty_status();
        arg1.participants = 0x3332b178c1513f32bca9cf711b0318c2bca4cb06f1a74211bac97a1eeb7f7259::vote::empty_participants();
        arg1.result = 0;
    }

    // decompiled from Move bytecode v6
}

