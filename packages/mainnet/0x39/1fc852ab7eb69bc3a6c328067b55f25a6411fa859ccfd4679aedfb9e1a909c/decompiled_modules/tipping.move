module 0x391fc852ab7eb69bc3a6c328067b55f25a6411fa859ccfd4679aedfb9e1a909c::tipping {
    public entry fun tip_creator(arg0: address, arg1: 0x2::object::ID, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg2, arg3, arg5), arg0);
        0x391fc852ab7eb69bc3a6c328067b55f25a6411fa859ccfd4679aedfb9e1a909c::events::emit_tip_event(0x2::tx_context::sender(arg5), arg0, arg3, arg1, 0x2::clock::timestamp_ms(arg4));
    }

    // decompiled from Move bytecode v7
}

