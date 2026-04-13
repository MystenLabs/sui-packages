module 0xcaa9016a51371dedf0633de2ebbc1fcd83960d4dff262bb4d919c1946e22b47e::nine_forms_capital {
    struct CapitalMeasurement has copy, drop, store {
        form: u8,
        score: u64,
        weight: u64,
        weighted_value: u64,
        timestamp: u64,
        telemetry_source: 0x1::string::String,
    }

    struct NineFormsState has key {
        id: 0x2::object::UID,
        measurements: 0x2::table::Table<u8, CapitalMeasurement>,
        total_score: u64,
        weighted_equilibrium: u64,
        reporting_nodes: vector<0x2::object::ID>,
        last_update: u64,
        ai_governor: address,
        update_frequency_ms: u64,
    }

    struct CapitalFormUpdated has copy, drop {
        form: u8,
        old_score: u64,
        new_score: u64,
        new_weight: u64,
        timestamp: u64,
    }

    struct EquilibriumCalculated has copy, drop {
        equilibrium_value: u64,
        total_score: u64,
        timestamp: u64,
    }

    public fun batch_update_forms(arg0: &mut NineFormsState, arg1: vector<u64>, arg2: vector<u64>, arg3: 0x1::string::String, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg5) == arg0.ai_governor, 0);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        let v1 = 0x1::vector::empty<u8>();
        let v2 = &mut v1;
        0x1::vector::push_back<u8>(v2, 0);
        0x1::vector::push_back<u8>(v2, 1);
        0x1::vector::push_back<u8>(v2, 2);
        0x1::vector::push_back<u8>(v2, 3);
        0x1::vector::push_back<u8>(v2, 4);
        0x1::vector::push_back<u8>(v2, 5);
        0x1::vector::push_back<u8>(v2, 6);
        0x1::vector::push_back<u8>(v2, 7);
        0x1::vector::push_back<u8>(v2, 8);
        0x1::vector::push_back<u8>(v2, 9);
        let v3 = 0;
        while (v3 < 0x1::vector::length<u8>(&v1)) {
            let v4 = *0x1::vector::borrow<u64>(&arg1, v3);
            let v5 = *0x1::vector::borrow<u64>(&arg2, v3);
            if (v4 <= 1000) {
                let v6 = 0x2::table::borrow_mut<u8, CapitalMeasurement>(&mut arg0.measurements, *0x1::vector::borrow<u8>(&v1, v3));
                v6.score = v4;
                v6.weight = v5;
                v6.weighted_value = v4 * v5;
                v6.timestamp = v0;
                v6.telemetry_source = arg3;
            };
            v3 = v3 + 1;
        };
        recalculate_equilibrium(arg0);
        arg0.last_update = v0;
        let v7 = EquilibriumCalculated{
            equilibrium_value : arg0.weighted_equilibrium,
            total_score       : arg0.total_score,
            timestamp         : v0,
        };
        0x2::event::emit<EquilibriumCalculated>(v7);
    }

    public fun change_governor(arg0: &mut NineFormsState, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.ai_governor, 0);
        arg0.ai_governor = arg1;
    }

    public fun get_form_score(arg0: &NineFormsState, arg1: u8) : u64 {
        0x2::table::borrow<u8, CapitalMeasurement>(&arg0.measurements, arg1).score
    }

    public fun get_form_weight(arg0: &NineFormsState, arg1: u8) : u64 {
        0x2::table::borrow<u8, CapitalMeasurement>(&arg0.measurements, arg1).weight
    }

    public fun get_weighted_value(arg0: &NineFormsState, arg1: u8) : u64 {
        0x2::table::borrow<u8, CapitalMeasurement>(&arg0.measurements, arg1).weighted_value
    }

    public fun initialize_nine_forms(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::epoch_timestamp_ms(arg1);
        let v1 = NineFormsState{
            id                   : 0x2::object::new(arg1),
            measurements         : 0x2::table::new<u8, CapitalMeasurement>(arg1),
            total_score          : 0,
            weighted_equilibrium : 0,
            reporting_nodes      : 0x1::vector::empty<0x2::object::ID>(),
            last_update          : v0,
            ai_governor          : arg0,
            update_frequency_ms  : 5950,
        };
        let v2 = 0x1::vector::empty<u8>();
        let v3 = &mut v2;
        0x1::vector::push_back<u8>(v3, 0);
        0x1::vector::push_back<u8>(v3, 1);
        0x1::vector::push_back<u8>(v3, 2);
        0x1::vector::push_back<u8>(v3, 3);
        0x1::vector::push_back<u8>(v3, 4);
        0x1::vector::push_back<u8>(v3, 5);
        0x1::vector::push_back<u8>(v3, 6);
        0x1::vector::push_back<u8>(v3, 7);
        0x1::vector::push_back<u8>(v3, 8);
        0x1::vector::push_back<u8>(v3, 9);
        let v4 = 0;
        while (v4 < 0x1::vector::length<u8>(&v2)) {
            let v5 = *0x1::vector::borrow<u8>(&v2, v4);
            let v6 = CapitalMeasurement{
                form             : v5,
                score            : 500,
                weight           : 100,
                weighted_value   : 50000,
                timestamp        : v0,
                telemetry_source : 0x1::string::utf8(b"initialization"),
            };
            0x2::table::add<u8, CapitalMeasurement>(&mut v1.measurements, v5, v6);
            v4 = v4 + 1;
        };
        v1.total_score = 4500;
        v1.weighted_equilibrium = 450000;
        0x2::transfer::share_object<NineFormsState>(v1);
    }

    public fun last_update(arg0: &NineFormsState) : u64 {
        arg0.last_update
    }

    fun recalculate_equilibrium(arg0: &mut NineFormsState) {
        let v0 = 0;
        let v1 = 0;
        let v2 = 0x1::vector::empty<u8>();
        let v3 = &mut v2;
        0x1::vector::push_back<u8>(v3, 0);
        0x1::vector::push_back<u8>(v3, 1);
        0x1::vector::push_back<u8>(v3, 2);
        0x1::vector::push_back<u8>(v3, 3);
        0x1::vector::push_back<u8>(v3, 4);
        0x1::vector::push_back<u8>(v3, 5);
        0x1::vector::push_back<u8>(v3, 6);
        0x1::vector::push_back<u8>(v3, 7);
        0x1::vector::push_back<u8>(v3, 8);
        0x1::vector::push_back<u8>(v3, 9);
        let v4 = 0;
        while (v4 < 0x1::vector::length<u8>(&v2)) {
            let v5 = 0x2::table::borrow<u8, CapitalMeasurement>(&arg0.measurements, *0x1::vector::borrow<u8>(&v2, v4));
            v0 = v0 + v5.score;
            v1 = v1 + v5.weighted_value;
            v4 = v4 + 1;
        };
        arg0.total_score = v0;
        arg0.weighted_equilibrium = v1;
    }

    public fun reporting_node_count(arg0: &NineFormsState) : u64 {
        0x1::vector::length<0x2::object::ID>(&arg0.reporting_nodes)
    }

    public fun set_update_frequency(arg0: &mut NineFormsState, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.ai_governor, 0);
        arg0.update_frequency_ms = arg1;
    }

    public fun total_score(arg0: &NineFormsState) : u64 {
        arg0.total_score
    }

    public fun update_capital_form(arg0: &mut NineFormsState, arg1: u8, arg2: u64, arg3: u64, arg4: 0x1::string::String, arg5: 0x2::object::ID, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg6);
        assert!(arg2 <= 1000, 1);
        let v1 = 0x2::table::borrow_mut<u8, CapitalMeasurement>(&mut arg0.measurements, arg1);
        v1.score = arg2;
        v1.weight = arg3;
        v1.weighted_value = arg2 * arg3;
        v1.timestamp = v0;
        v1.telemetry_source = arg4;
        if (!0x1::vector::contains<0x2::object::ID>(&arg0.reporting_nodes, &arg5)) {
            0x1::vector::push_back<0x2::object::ID>(&mut arg0.reporting_nodes, arg5);
        };
        recalculate_equilibrium(arg0);
        arg0.last_update = v0;
        let v2 = CapitalFormUpdated{
            form       : arg1,
            old_score  : v1.score,
            new_score  : arg2,
            new_weight : arg3,
            timestamp  : v0,
        };
        0x2::event::emit<CapitalFormUpdated>(v2);
    }

    public fun update_compute_capital(arg0: &mut NineFormsState, arg1: u64, arg2: u64, arg3: u64, arg4: 0x2::object::ID, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = (arg1 / 1000 + arg2 / 1000000000 + arg3) / 3;
        let v1 = if (v0 > 1000) {
            1000
        } else {
            v0
        };
        update_capital_form(arg0, 3, v1, 168, 0x1::string::utf8(b"compute_telemetry"), arg4, arg5, arg6);
    }

    public fun update_material_capital(arg0: &mut NineFormsState, arg1: u64, arg2: u64, arg3: u64, arg4: 0x2::object::ID, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg1 > 0) {
            arg1 * 10 + arg2 / 1000 + arg3 / 1000000
        } else {
            0
        };
        let v1 = if (v0 > 1000) {
            1000
        } else {
            v0
        };
        update_capital_form(arg0, 0, v1, 168, 0x1::string::utf8(b"material_telemetry"), arg4, arg5, arg6);
    }

    public fun update_natural_capital(arg0: &mut NineFormsState, arg1: u64, arg2: u64, arg3: u64, arg4: 0x2::object::ID, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = arg2 * 10 + arg3 / 1000;
        let v1 = if (v0 > 1000) {
            1000
        } else {
            v0
        };
        update_capital_form(arg0, 6, v1, 168, 0x1::string::utf8(b"natural_telemetry"), arg4, arg5, arg6);
    }

    public fun update_social_capital(arg0: &mut NineFormsState, arg1: u64, arg2: u64, arg3: u64, arg4: 0x2::object::ID, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = (arg1 * 2 + arg2 / 1000 + arg3 * 10) / 3;
        let v1 = if (v0 > 1000) {
            1000
        } else {
            v0
        };
        update_capital_form(arg0, 4, v1, 144, 0x1::string::utf8(b"social_telemetry"), arg4, arg5, arg6);
    }

    public fun weighted_equilibrium(arg0: &NineFormsState) : u64 {
        arg0.weighted_equilibrium
    }

    // decompiled from Move bytecode v6
}

