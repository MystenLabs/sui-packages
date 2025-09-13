module 0x144a68b0ab1cd808593b52bc6987323921977407d66795664133e177d263fc4f::scard {
    public(friend) fun calculate_card_rebate_rate(arg0: &0xe7e651e4974fe367aa2837712d68081efb299c470242a15e2b9c26ea326159ec::card::SudoCard) : 0x144a68b0ab1cd808593b52bc6987323921977407d66795664133e177d263fc4f::rate::Rate {
        let v0 = max_rebate_for_tier(0xe7e651e4974fe367aa2837712d68081efb299c470242a15e2b9c26ea326159ec::card::get_tier(arg0));
        if (v0 == 0) {
            return 0x144a68b0ab1cd808593b52bc6987323921977407d66795664133e177d263fc4f::rate::zero()
        };
        let v1 = start_rebate_for_tier(0xe7e651e4974fe367aa2837712d68081efb299c470242a15e2b9c26ea326159ec::card::get_tier(arg0));
        let v2 = (0xe7e651e4974fe367aa2837712d68081efb299c470242a15e2b9c26ea326159ec::card::get_level(arg0) as u64);
        let v3 = 25;
        0x144a68b0ab1cd808593b52bc6987323921977407d66795664133e177d263fc4f::decimal::to_rate(0x144a68b0ab1cd808593b52bc6987323921977407d66795664133e177d263fc4f::decimal::div_by_u64(0x144a68b0ab1cd808593b52bc6987323921977407d66795664133e177d263fc4f::decimal::add(0x144a68b0ab1cd808593b52bc6987323921977407d66795664133e177d263fc4f::decimal::from_u64(v1), 0x144a68b0ab1cd808593b52bc6987323921977407d66795664133e177d263fc4f::decimal::div_by_u64(0x144a68b0ab1cd808593b52bc6987323921977407d66795664133e177d263fc4f::decimal::from_u64((v0 - v1) * 0x1::u64::min(v2 * v2, v3 * v3)), v3 * v3)), 100))
    }

    public(friend) fun max_rebate_for_tier(arg0: u8) : u64 {
        if (arg0 == 0) {
            50
        } else if (arg0 == 1) {
            45
        } else if (arg0 == 2) {
            35
        } else {
            0
        }
    }

    public(friend) fun start_rebate_for_tier(arg0: u8) : u64 {
        if (arg0 == 0) {
            20
        } else if (arg0 == 1) {
            15
        } else if (arg0 == 2) {
            12
        } else {
            0
        }
    }

    // decompiled from Move bytecode v6
}

