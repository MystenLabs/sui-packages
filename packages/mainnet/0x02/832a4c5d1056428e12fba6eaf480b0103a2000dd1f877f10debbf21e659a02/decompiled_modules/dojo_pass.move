module 0x2832a4c5d1056428e12fba6eaf480b0103a2000dd1f877f10debbf21e659a02::dojo_pass {
    struct DojoPassConfig has key {
        id: 0x2::object::UID,
        recipient: address,
        answer_price: u64,
        badge_price: u64,
        proof_public_key: vector<u8>,
        claimed_addresses: vector<address>,
        collected: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct DojoPass has key {
        id: 0x2::object::UID,
        owner: address,
        unlocked_challenges: vector<u64>,
        minted_badges: vector<u64>,
        membership_tier: u64,
        created_epoch: u64,
    }

    struct AnswerUnlocked has copy, drop {
        owner: address,
        challenge_id: u64,
        amount: u64,
        epoch: u64,
    }

    struct BadgeMinted has copy, drop {
        owner: address,
        badge_type: u64,
        amount: u64,
        epoch: u64,
    }

    struct BadgeProof has copy, drop {
        owner: address,
        badge_type: u64,
        expires_epoch: u64,
        nonce: u64,
    }

    public fun answer_price(arg0: &DojoPassConfig) : u64 {
        arg0.answer_price
    }

    public fun badge_price(arg0: &DojoPassConfig) : u64 {
        arg0.badge_price
    }

    public fun badge_proof_message(arg0: address, arg1: u64, arg2: u64, arg3: u64) : vector<u8> {
        let v0 = BadgeProof{
            owner         : arg0,
            badge_type    : arg1,
            expires_epoch : arg2,
            nonce         : arg3,
        };
        0x1::bcs::to_bytes<BadgeProof>(&v0)
    }

    public fun collected(arg0: &DojoPassConfig) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.collected)
    }

    public fun create_config(arg0: address, arg1: u64, arg2: u64, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > 0 && arg2 > 0, 0);
        let v0 = DojoPassConfig{
            id                : 0x2::object::new(arg4),
            recipient         : arg0,
            answer_price      : arg1,
            badge_price       : arg2,
            proof_public_key  : arg3,
            claimed_addresses : vector[],
            collected         : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<DojoPassConfig>(v0);
    }

    public fun created_epoch(arg0: &DojoPass) : u64 {
        arg0.created_epoch
    }

    public fun has_claimed(arg0: &DojoPassConfig, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.claimed_addresses, &arg1)
    }

    public fun has_minted_badge(arg0: &DojoPass, arg1: u64) : bool {
        0x1::vector::contains<u64>(&arg0.minted_badges, &arg1)
    }

    public fun has_unlocked_answer(arg0: &DojoPass, arg1: u64) : bool {
        0x1::vector::contains<u64>(&arg0.unlocked_challenges, &arg1)
    }

    public fun membership_tier(arg0: &DojoPass) : u64 {
        arg0.membership_tier
    }

    public fun mint_badge(arg0: &mut DojoPassConfig, arg1: &mut DojoPass, arg2: u64, arg3: u64, arg4: u64, arg5: vector<u8>, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: &mut 0x2::tx_context::TxContext) : 0x2832a4c5d1056428e12fba6eaf480b0103a2000dd1f877f10debbf21e659a02::badge::Badge {
        let v0 = 0x2::tx_context::sender(arg7);
        assert!(arg1.owner == v0, 5);
        assert!(!0x1::vector::contains<u64>(&arg1.minted_badges, &arg2), 7);
        assert!(0x2::tx_context::epoch(arg7) <= arg3, 8);
        let v1 = badge_proof_message(v0, arg2, arg3, arg4);
        assert!(0x2::ed25519::ed25519_verify(&arg5, &arg0.proof_public_key, &v1), 9);
        let v2 = 0x2::coin::value<0x2::sui::SUI>(&arg6);
        assert!(v2 >= arg0.badge_price, 1);
        0x2::coin::put<0x2::sui::SUI>(&mut arg0.collected, arg6);
        0x1::vector::push_back<u64>(&mut arg1.minted_badges, arg2);
        let v3 = BadgeMinted{
            owner      : v0,
            badge_type : arg2,
            amount     : v2,
            epoch      : 0x2::tx_context::epoch(arg7),
        };
        0x2::event::emit<BadgeMinted>(v3);
        0x2832a4c5d1056428e12fba6eaf480b0103a2000dd1f877f10debbf21e659a02::badge::mint_for_owner(v0, arg2, arg7)
    }

    public fun mint_pass(arg0: &mut DojoPassConfig, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(!0x1::vector::contains<address>(&arg0.claimed_addresses, &v0), 4);
        0x1::vector::push_back<address>(&mut arg0.claimed_addresses, v0);
        let v1 = DojoPass{
            id                  : 0x2::object::new(arg1),
            owner               : v0,
            unlocked_challenges : vector[],
            minted_badges       : vector[],
            membership_tier     : 0,
            created_epoch       : 0x2::tx_context::epoch(arg1),
        };
        0x2::transfer::transfer<DojoPass>(v1, v0);
    }

    public fun minted_badge_count(arg0: &DojoPass) : u64 {
        0x1::vector::length<u64>(&arg0.minted_badges)
    }

    public fun owner(arg0: &DojoPass) : address {
        arg0.owner
    }

    public fun recipient(arg0: &DojoPassConfig) : address {
        arg0.recipient
    }

    public fun seal_approve(arg0: &DojoPass, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 5);
        assert!(0x1::vector::contains<u64>(&arg0.unlocked_challenges, &arg1), 10);
    }

    public fun unlock_answer(arg0: &mut DojoPassConfig, arg1: &mut DojoPass, arg2: u64, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(arg1.owner == v0, 5);
        assert!(!0x1::vector::contains<u64>(&arg1.unlocked_challenges, &arg2), 6);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg3);
        assert!(v1 >= arg0.answer_price, 1);
        0x2::coin::put<0x2::sui::SUI>(&mut arg0.collected, arg3);
        0x1::vector::push_back<u64>(&mut arg1.unlocked_challenges, arg2);
        let v2 = AnswerUnlocked{
            owner        : v0,
            challenge_id : arg2,
            amount       : v1,
            epoch        : 0x2::tx_context::epoch(arg4),
        };
        0x2::event::emit<AnswerUnlocked>(v2);
    }

    public fun unlocked_count(arg0: &DojoPass) : u64 {
        0x1::vector::length<u64>(&arg0.unlocked_challenges)
    }

    public fun withdraw(arg0: &mut DojoPassConfig, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(0x2::tx_context::sender(arg1) == arg0.recipient, 3);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.collected) > 0, 2);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.collected), arg1)
    }

    // decompiled from Move bytecode v7
}

