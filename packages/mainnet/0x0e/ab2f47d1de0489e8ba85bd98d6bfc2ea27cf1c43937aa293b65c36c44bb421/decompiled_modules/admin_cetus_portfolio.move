module 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::admin_cetus_portfolio {
    public fun claim_all(arg0: &0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::config::AdminCap, arg1: &mut 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::cetus_portfolio::CetusPortfolio, arg2: address) {
        0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::cetus_portfolio::claim_all(arg1, arg2);
    }

    public(friend) fun deposit_position(arg0: &0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::config::AdminCap, arg1: &mut 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::cetus_portfolio::CetusPortfolio, arg2: address, arg3: 0x1::ascii::String, arg4: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg5: &mut 0x2::tx_context::TxContext) {
        0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::cetus_portfolio::deposit_position(arg1, arg2, arg3, arg4, arg5);
    }

    // decompiled from Move bytecode v6
}

