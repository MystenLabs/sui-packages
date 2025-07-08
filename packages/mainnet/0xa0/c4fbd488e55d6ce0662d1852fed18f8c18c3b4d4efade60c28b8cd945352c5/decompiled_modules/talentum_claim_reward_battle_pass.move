module 0xa0c4fbd488e55d6ce0662d1852fed18f8c18c3b4d4efade60c28b8cd945352c5::talentum_claim_reward_battle_pass {
    struct TalentumClaimRewardBattlePassEvent has copy, drop {
        battlePass_id: u64,
        user_id: u64,
        item_id: u64,
    }

    public entry fun claim(arg0: u64, arg1: u64, arg2: u64) {
        let v0 = TalentumClaimRewardBattlePassEvent{
            battlePass_id : arg0,
            user_id       : arg1,
            item_id       : arg2,
        };
        0x2::event::emit<TalentumClaimRewardBattlePassEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

