module 0xd5646edd9800962f7c5b48c1334d9cdf9cbaca539f105cf5e69673c5856dab02::event_type_r843v67gnl {
    struct EVENT_TYPE_R843V67GNL has drop {
        dummy_field: bool,
    }

    struct EventType_93kgv1h13jf has store {
        dummy_field: bool,
    }

    fun init(arg0: EVENT_TYPE_R843V67GNL, arg1: &mut 0x2::tx_context::TxContext) {
        0x89f0a1481600ea5efde8da94fc33277341b6192ffc4366d168e9bd54ea6dfbd6::ticketing::claim_ticket_type_proof<EVENT_TYPE_R843V67GNL, EventType_93kgv1h13jf>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

