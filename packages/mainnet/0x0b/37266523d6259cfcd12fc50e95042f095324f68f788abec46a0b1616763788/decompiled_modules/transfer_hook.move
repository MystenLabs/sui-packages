module 0xb37266523d6259cfcd12fc50e95042f095324f68f788abec46a0b1616763788::transfer_hook {
    struct TransferHook has drop {
        dummy_field: bool,
    }

    public fun transfer_coin<T0>(arg0: &mut 0xb37266523d6259cfcd12fc50e95042f095324f68f788abec46a0b1616763788::distributor::ClaimedBalance<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xb37266523d6259cfcd12fc50e95042f095324f68f788abec46a0b1616763788::distributor::hook_call_info<T0, TransferHook>(arg0);
        let v1 = 0x2::bcs::new(0xb37266523d6259cfcd12fc50e95042f095324f68f788abec46a0b1616763788::distributor::calldata(&v0));
        let v2 = TransferHook{dummy_field: false};
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0xb37266523d6259cfcd12fc50e95042f095324f68f788abec46a0b1616763788::distributor::extract_claimed_balance<T0, TransferHook>(arg0, v2, 0x2::bcs::peel_u64(&mut v1)), arg1), 0xb37266523d6259cfcd12fc50e95042f095324f68f788abec46a0b1616763788::distributor::on_behalf_of<T0>(arg0));
    }

    // decompiled from Move bytecode v6
}

