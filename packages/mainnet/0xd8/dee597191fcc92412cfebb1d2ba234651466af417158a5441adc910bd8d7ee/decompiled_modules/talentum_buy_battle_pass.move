module 0xd8dee597191fcc92412cfebb1d2ba234651466af417158a5441adc910bd8d7ee::talentum_buy_battle_pass {
    struct TalentumBuyBattlePassEvent has copy, drop {
        sender: address,
        receiver: address,
        amount: u64,
        battlePass_id: u64,
        user_id: u64,
    }

    public entry fun buy_battle_pass(arg0: u64, arg1: address, arg2: u64, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg3);
        assert!(v0 > 0, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, arg1);
        let v1 = TalentumBuyBattlePassEvent{
            sender        : 0x2::tx_context::sender(arg4),
            receiver      : arg1,
            amount        : v0,
            battlePass_id : arg0,
            user_id       : arg2,
        };
        0x2::event::emit<TalentumBuyBattlePassEvent>(v1);
    }

    // decompiled from Move bytecode v6
}

