module 0x863d31c772e494b26d9460d7f26697aa79706c882c77b382211a100e7f99ba07::mock_supply {
    struct MOCK has drop {
        dummy_field: bool,
    }

    struct MockPosition<phantom T0> has store, key {
        id: 0x2::object::UID,
        deposited: 0x2::balance::Balance<T0>,
    }

    fun deposit_and_custody<T0>(arg0: &mut 0x2e069f6be4e68b6a533676122754ba9611898a431c1b0240dc4e0cc8d1cde3a4::capability::Treasury<T0>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2e069f6be4e68b6a533676122754ba9611898a431c1b0240dc4e0cc8d1cde3a4::capability::ReleaseTicket, arg3: &mut 0x2::tx_context::TxContext) {
        if (0x2e069f6be4e68b6a533676122754ba9611898a431c1b0240dc4e0cc8d1cde3a4::capability::ticket_has_position<T0>(arg0, &arg2)) {
            0x2::balance::join<T0>(&mut 0x2e069f6be4e68b6a533676122754ba9611898a431c1b0240dc4e0cc8d1cde3a4::capability::borrow_for_ticket<T0, MockPosition<T0>>(arg0, &arg2).deposited, 0x2::coin::into_balance<T0>(arg1));
            0x2e069f6be4e68b6a533676122754ba9611898a431c1b0240dc4e0cc8d1cde3a4::capability::discharge_existing<T0>(arg0, arg2);
        } else {
            let v0 = MockPosition<T0>{
                id        : 0x2::object::new(arg3),
                deposited : 0x2::coin::into_balance<T0>(arg1),
            };
            0x2e069f6be4e68b6a533676122754ba9611898a431c1b0240dc4e0cc8d1cde3a4::capability::custody_new<T0, MockPosition<T0>>(arg0, arg2, v0);
        };
    }

    public fun owner_redeem<T0>(arg0: &mut 0x2e069f6be4e68b6a533676122754ba9611898a431c1b0240dc4e0cc8d1cde3a4::capability::Treasury<T0>, arg1: &0x2e069f6be4e68b6a533676122754ba9611898a431c1b0240dc4e0cc8d1cde3a4::capability::OwnerCap<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let MockPosition {
            id        : v0,
            deposited : v1,
        } = 0x2e069f6be4e68b6a533676122754ba9611898a431c1b0240dc4e0cc8d1cde3a4::capability::owner_take_receipt<T0, MockPosition<T0>>(arg0, arg1, 255);
        0x2::object::delete(v0);
        0x2::coin::from_balance<T0>(v1, arg2)
    }

    public fun verified_supply_mock_entry<T0>(arg0: &mut 0x2e069f6be4e68b6a533676122754ba9611898a431c1b0240dc4e0cc8d1cde3a4::decision::DecisionRegistry, arg1: &mut 0x2e069f6be4e68b6a533676122754ba9611898a431c1b0240dc4e0cc8d1cde3a4::capability::Treasury<T0>, arg2: &0x9aa904f2d8e55626f4ba4d3c76fd48fb84f00e86f2bfd558980b1d6268828b8b::enclave::Enclave<0x2e069f6be4e68b6a533676122754ba9611898a431c1b0240dc4e0cc8d1cde3a4::decision::DECISION>, arg3: &0x2e069f6be4e68b6a533676122754ba9611898a431c1b0240dc4e0cc8d1cde3a4::capability::AgentCap<T0>, arg4: u16, arg5: vector<u8>, arg6: address, arg7: address, arg8: u64, arg9: u64, arg10: u8, arg11: u8, arg12: vector<u8>, arg13: u64, arg14: u64, arg15: u64, arg16: vector<u8>, arg17: vector<u8>, arg18: vector<u8>, arg19: u64, arg20: vector<u8>, arg21: &0x2::clock::Clock, arg22: &mut 0x2::tx_context::TxContext) {
        let v0 = MOCK{dummy_field: false};
        let (v1, v2) = 0x2e069f6be4e68b6a533676122754ba9611898a431c1b0240dc4e0cc8d1cde3a4::decision::verified_release<T0, MOCK>(v0, arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20, arg21, arg22);
        deposit_and_custody<T0>(arg1, v1, v2, arg22);
    }

    // decompiled from Move bytecode v7
}

