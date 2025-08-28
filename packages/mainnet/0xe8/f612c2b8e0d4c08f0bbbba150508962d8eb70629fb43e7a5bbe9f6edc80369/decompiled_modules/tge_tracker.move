module 0xe8f612c2b8e0d4c08f0bbbba150508962d8eb70629fb43e7a5bbe9f6edc80369::tge_tracker {
    public entry fun process_all<T0>(arg0: &0x2::coin::Coin<T0>, arg1: address, arg2: u64, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: &mut 0x2::tx_context::TxContext) {
        0xe8f612c2b8e0d4c08f0bbbba150508962d8eb70629fb43e7a5bbe9f6edc80369::transaction_batch::process_transaction<T0>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    // decompiled from Move bytecode v6
}

