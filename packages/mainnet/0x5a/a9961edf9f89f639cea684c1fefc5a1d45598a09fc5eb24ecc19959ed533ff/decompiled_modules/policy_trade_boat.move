module 0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::policy_trade_boat {
    struct BuyMaxBOATWitness has drop {
        dummy_field: bool,
    }

    struct SellBOATWitness has drop {
        dummy_field: bool,
    }

    public fun buy_max_boat<T0>(arg0: &mut 0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::dao::Dao, arg1: &mut 0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::boat::BOATPool, arg2: &mut 0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::dao::ProposalAccepted<BuyMaxBOATWitness>, arg3: u64) {
        let v0 = BuyMaxBOATWitness{dummy_field: false};
        let v1 = 0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::dao::auth_withdraw_token<BuyMaxBOATWitness, T0>(arg0, arg2, &v0, arg3);
        let v2 = 0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::boat::buy_max_boat<T0>(arg1, &mut v1);
        0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::dao::deposit_token<T0>(arg0, v1);
        0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::dao::deposit_token<0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::boat::BOAT>(arg0, v2);
        let v3 = 0x1::string::utf8(b"Bought BOAT: ");
        0x1::string::append(&mut v3, 0x1::u64::to_string(0x2::balance::value<0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::boat::BOAT>(&v2)));
        let v4 = BuyMaxBOATWitness{dummy_field: false};
        0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::dao::auth_log<BuyMaxBOATWitness>(arg0, arg2, &v4, 0x1::string::utf8(0x1::string::into_bytes(v3)));
        let v5 = BuyMaxBOATWitness{dummy_field: false};
        0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::dao::stamp<BuyMaxBOATWitness>(arg2, &v5);
    }

    public fun sell_boat<T0>(arg0: &mut 0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::dao::Dao, arg1: &mut 0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::boat::BOATPool, arg2: &mut 0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::dao::ProposalAccepted<SellBOATWitness>, arg3: u64) {
        let v0 = SellBOATWitness{dummy_field: false};
        let v1 = 0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::boat::sell_boat<T0>(arg1, 0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::dao::auth_withdraw_token<SellBOATWitness, 0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::boat::BOAT>(arg0, arg2, &v0, arg3));
        0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::dao::deposit_token<T0>(arg0, v1);
        let v2 = 0x1::string::utf8(b"Bought ");
        let v3 = 0x1::type_name::get<T0>();
        let v4 = 0x1::type_name::get_module(&v3);
        0x1::string::append(&mut v2, 0x1::string::from_ascii(0x1::ascii::to_uppercase(&v4)));
        0x1::string::append_utf8(&mut v2, b": ");
        0x1::string::append(&mut v2, 0x1::u64::to_string(0x2::balance::value<T0>(&v1)));
        let v5 = SellBOATWitness{dummy_field: false};
        0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::dao::auth_log<SellBOATWitness>(arg0, arg2, &v5, v2);
        let v6 = SellBOATWitness{dummy_field: false};
        0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::dao::stamp<SellBOATWitness>(arg2, &v6);
    }

    public fun buy_max_boat_description() : 0x1::string::String {
        0x1::string::utf8(b"TODO")
    }

    public entry fun buy_max_boat_entry<T0>(arg0: &mut 0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::dao::Dao, arg1: &0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::admin::AdminCap, arg2: &mut 0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::boat::BOATPool, arg3: u64, arg4: &0x2::clock::Clock) {
        let v0 = 0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::dao::begin_proposal_execution<BuyMaxBOATWitness>(arg0, arg1);
        let v1 = &mut v0;
        buy_max_boat<T0>(arg0, arg2, v1, arg3);
        0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::dao::proposal_was_executed<BuyMaxBOATWitness>(arg0, v0, arg4);
    }

    public fun sell_boat_description() : 0x1::string::String {
        0x1::string::utf8(b"TODO")
    }

    public entry fun sell_boat_entry<T0>(arg0: &mut 0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::dao::Dao, arg1: &0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::admin::AdminCap, arg2: &mut 0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::boat::BOATPool, arg3: u64, arg4: &0x2::clock::Clock) {
        let v0 = 0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::dao::begin_proposal_execution<SellBOATWitness>(arg0, arg1);
        let v1 = &mut v0;
        sell_boat<T0>(arg0, arg2, v1, arg3);
        0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::dao::proposal_was_executed<SellBOATWitness>(arg0, v0, arg4);
    }

    // decompiled from Move bytecode v6
}

