module 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::self_portfolio {
    public fun apply_fee<T0>(arg0: &mut 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::portfolio::Portfolio, arg1: 0x1::ascii::String, arg2: &mut 0x2::tx_context::TxContext) {
        0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::portfolio::apply_fee<T0>(arg0, 0x2::tx_context::sender(arg2), arg1);
    }

    public fun apply_reward<T0>(arg0: &mut 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::portfolio::Portfolio, arg1: 0x1::ascii::String, arg2: &mut 0x2::tx_context::TxContext) {
        0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::portfolio::apply_reward<T0>(arg0, 0x2::tx_context::sender(arg2), arg1);
    }

    public fun claim<T0>(arg0: &mut 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::portfolio::Portfolio, arg1: 0x1::ascii::String, arg2: &mut 0x2::tx_context::TxContext) {
        0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::portfolio::claim<T0>(arg0, 0x2::tx_context::sender(arg2), arg1, arg2);
    }

    public fun claim_all<T0>(arg0: &mut 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::portfolio::Portfolio, arg1: &mut 0x2::tx_context::TxContext) {
        0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::portfolio::claim_all<T0>(arg0, 0x2::tx_context::sender(arg1), arg1);
    }

    public fun claim_all_fee<T0>(arg0: &mut 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::portfolio::Portfolio, arg1: &mut 0x2::tx_context::TxContext) {
        0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::portfolio::claim_all_fee<T0>(arg0, 0x2::tx_context::sender(arg1), arg1);
    }

    public fun claim_all_reward<T0>(arg0: &mut 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::portfolio::Portfolio, arg1: &mut 0x2::tx_context::TxContext) {
        0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::portfolio::claim_all_reward<T0>(arg0, 0x2::tx_context::sender(arg1), arg1);
    }

    public fun claim_fee<T0>(arg0: &mut 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::portfolio::Portfolio, arg1: 0x1::ascii::String, arg2: &mut 0x2::tx_context::TxContext) {
        0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::portfolio::claim_fee<T0>(arg0, 0x2::tx_context::sender(arg2), arg1, arg2);
    }

    public fun claim_reward<T0>(arg0: &mut 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::portfolio::Portfolio, arg1: 0x1::ascii::String, arg2: &mut 0x2::tx_context::TxContext) {
        0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::portfolio::claim_reward<T0>(arg0, 0x2::tx_context::sender(arg2), arg1, arg2);
    }

    public fun deposit<T0>(arg0: &mut 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::portfolio::Portfolio, arg1: 0x1::ascii::String, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::portfolio::deposit<T0>(arg0, 0x2::tx_context::sender(arg3), arg1, 0x2::coin::into_balance<T0>(arg2), arg3);
    }

    public fun transfer<T0>(arg0: &mut 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::portfolio::Portfolio, arg1: 0x1::ascii::String, arg2: 0x1::ascii::String, arg3: 0x1::option::Option<u64>, arg4: &mut 0x2::tx_context::TxContext) {
        0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::portfolio::transfer<T0>(arg0, 0x2::tx_context::sender(arg4), arg1, arg2, arg3, arg4);
    }

    public fun transfer_all<T0>(arg0: &mut 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::portfolio::Portfolio, arg1: 0x1::ascii::String, arg2: 0x1::ascii::String, arg3: &mut 0x2::tx_context::TxContext) {
        0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::portfolio::transfer_all<T0>(arg0, 0x2::tx_context::sender(arg3), arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

