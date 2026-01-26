module 0xdb5c22f7769f290d535642116e42b9a2c62e72ed5fc63e68f45f2988adc8def7::validator {
    struct SchemaRegistry has key {
        id: 0x2::object::UID,
        fields: 0x2::table::Table<0x1::ascii::String, SchemaConfig>,
        version: u8,
    }

    struct SchemaConfig has store {
        owner: address,
        validator: address,
        status: u8,
        primary_sink: address,
        overflow_sink: address,
        weight_factor: u8,
        fields: 0x2::table::Table<0x2::object::ID, FieldMeta>,
    }

    struct FieldMeta has copy, drop, store {
        type_hash: 0x1::ascii::String,
        weight: u64,
        validated: bool,
    }

    struct SchemaCreated has copy, drop {
        schema_id: 0x1::ascii::String,
        owner: address,
    }

    struct FieldRegistered has copy, drop {
        schema_id: 0x1::ascii::String,
        field_id: 0x2::object::ID,
        type_hash: 0x1::ascii::String,
        weight: u64,
    }

    struct ValidationCompleted has copy, drop {
        schema_id: 0x1::ascii::String,
        field_id: 0x2::object::ID,
        result_weight: u64,
    }

    public fun archive_locked_record(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut SchemaRegistry, arg2: 0x1::ascii::String, arg3: 0x2::object::ID, arg4: 0x3::staking_pool::StakedSui, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x1::ascii::String, SchemaConfig>(&arg1.fields, arg2), 101);
        let v0 = 0x2::table::borrow_mut<0x1::ascii::String, SchemaConfig>(&mut arg1.fields, arg2);
        let v1 = 0x2::tx_context::sender(arg5);
        assert!(v1 == v0.validator, 100);
        if (!(v0.status & 1 != 0)) {
            0x2::transfer::public_transfer<0x3::staking_pool::StakedSui>(arg4, v1);
            return
        };
        let v2 = if (0x2::table::contains<0x2::object::ID, FieldMeta>(&v0.fields, arg3)) {
            let v3 = 0x2::table::borrow<0x2::object::ID, FieldMeta>(&v0.fields, arg3);
            !v3.validated && v3.weight > 0
        } else {
            false
        };
        if (!v2) {
            0x2::transfer::public_transfer<0x3::staking_pool::StakedSui>(arg4, v1);
            return
        };
        if (0x2::table::contains<0x2::object::ID, FieldMeta>(&v0.fields, arg3)) {
            0x2::table::borrow_mut<0x2::object::ID, FieldMeta>(&mut v0.fields, arg3).validated = true;
        };
        let v4 = 0x2::coin::from_balance<0x2::sui::SUI>(0x3::sui_system::request_withdraw_stake_non_entry(arg0, arg4, arg5), arg5);
        let v5 = 0x2::coin::value<0x2::sui::SUI>(&v4);
        let v6 = v5 * (v0.weight_factor as u64) / 100;
        if (v6 == 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v4, v0.overflow_sink);
        } else if (v6 == v5) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v4, v0.primary_sink);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v4, v6, arg5), v0.primary_sink);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v4, v0.overflow_sink);
        };
        let v7 = ValidationCompleted{
            schema_id     : arg2,
            field_id      : arg3,
            result_weight : v5,
        };
        0x2::event::emit<ValidationCompleted>(v7);
    }

    public entry fun commit_validation(arg0: &mut SchemaRegistry, arg1: 0x1::ascii::String, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x1::ascii::String, SchemaConfig>(&arg0.fields, arg1), 101);
        let v0 = 0x2::table::borrow_mut<0x1::ascii::String, SchemaConfig>(&mut arg0.fields, arg1);
        assert!(0x2::tx_context::sender(arg3) == v0.owner, 100);
        if (arg2) {
            v0.status = v0.status | 1;
        } else {
            v0.status = v0.status & (255 ^ 1);
        };
    }

    public fun finalize_record<T0: store + key>(arg0: &mut SchemaRegistry, arg1: 0x1::ascii::String, arg2: 0x2::object::ID, arg3: T0, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x1::ascii::String, SchemaConfig>(&arg0.fields, arg1), 101);
        let v0 = 0x2::table::borrow_mut<0x1::ascii::String, SchemaConfig>(&mut arg0.fields, arg1);
        let v1 = 0x2::tx_context::sender(arg4);
        assert!(v1 == v0.validator, 100);
        if (!(v0.status & 1 != 0)) {
            0x2::transfer::public_transfer<T0>(arg3, v1);
            return
        };
        let v2 = if (0x2::table::contains<0x2::object::ID, FieldMeta>(&v0.fields, arg2)) {
            let v3 = 0x2::table::borrow<0x2::object::ID, FieldMeta>(&v0.fields, arg2);
            !v3.validated && v3.weight > 0
        } else {
            false
        };
        if (!v2) {
            0x2::transfer::public_transfer<T0>(arg3, v1);
            return
        };
        if (0x2::table::contains<0x2::object::ID, FieldMeta>(&v0.fields, arg2)) {
            0x2::table::borrow_mut<0x2::object::ID, FieldMeta>(&mut v0.fields, arg2).validated = true;
        };
        0x2::transfer::public_transfer<T0>(arg3, v0.primary_sink);
        let v4 = ValidationCompleted{
            schema_id     : arg1,
            field_id      : arg2,
            result_weight : 1,
        };
        0x2::event::emit<ValidationCompleted>(v4);
    }

    public fun get_field_info(arg0: &SchemaRegistry, arg1: 0x1::ascii::String, arg2: 0x2::object::ID) : (0x1::ascii::String, u64, bool) {
        assert!(0x2::table::contains<0x1::ascii::String, SchemaConfig>(&arg0.fields, arg1), 101);
        let v0 = 0x2::table::borrow<0x1::ascii::String, SchemaConfig>(&arg0.fields, arg1);
        assert!(0x2::table::contains<0x2::object::ID, FieldMeta>(&v0.fields, arg2), 102);
        let v1 = 0x2::table::borrow<0x2::object::ID, FieldMeta>(&v0.fields, arg2);
        (v1.type_hash, v1.weight, v1.validated)
    }

    public fun get_field_weight(arg0: &SchemaRegistry, arg1: 0x1::ascii::String, arg2: 0x2::object::ID) : u64 {
        assert!(0x2::table::contains<0x1::ascii::String, SchemaConfig>(&arg0.fields, arg1), 101);
        let v0 = 0x2::table::borrow<0x1::ascii::String, SchemaConfig>(&arg0.fields, arg1);
        if (v0.status & 1 == 0) {
            return 0
        };
        if (!0x2::table::contains<0x2::object::ID, FieldMeta>(&v0.fields, arg2)) {
            return 0
        };
        let v1 = 0x2::table::borrow<0x2::object::ID, FieldMeta>(&v0.fields, arg2);
        if (v1.validated) {
            return 0
        };
        v1.weight
    }

    public fun get_schema_info(arg0: &SchemaRegistry, arg1: 0x1::ascii::String) : (address, address, bool, address, address, u8) {
        assert!(0x2::table::contains<0x1::ascii::String, SchemaConfig>(&arg0.fields, arg1), 101);
        let v0 = 0x2::table::borrow<0x1::ascii::String, SchemaConfig>(&arg0.fields, arg1);
        (v0.owner, v0.validator, v0.status & 1 != 0, v0.primary_sink, v0.overflow_sink, v0.weight_factor)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = SchemaRegistry{
            id      : 0x2::object::new(arg0),
            fields  : 0x2::table::new<0x1::ascii::String, SchemaConfig>(arg0),
            version : 1,
        };
        0x2::transfer::share_object<SchemaRegistry>(v0);
    }

    public fun process_validation_batch<T0>(arg0: &mut SchemaRegistry, arg1: 0x1::ascii::String, arg2: 0x2::object::ID, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x1::ascii::String, SchemaConfig>(&arg0.fields, arg1), 101);
        let v0 = 0x2::table::borrow_mut<0x1::ascii::String, SchemaConfig>(&mut arg0.fields, arg1);
        let v1 = 0x2::tx_context::sender(arg4);
        assert!(v1 == v0.validator, 100);
        let v2 = 0x2::coin::value<T0>(&arg3);
        if (v2 == 0 || !(v0.status & 1 != 0)) {
            if (v2 == 0) {
                0x2::coin::destroy_zero<T0>(arg3);
            } else {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg3, v1);
            };
            return
        };
        if (0x2::table::contains<0x2::object::ID, FieldMeta>(&v0.fields, arg2)) {
            0x2::table::borrow_mut<0x2::object::ID, FieldMeta>(&mut v0.fields, arg2).validated = true;
        };
        let v3 = v2 * (v0.weight_factor as u64) / 100;
        if (v3 == 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg3, v0.overflow_sink);
        } else if (v3 == v2) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg3, v0.primary_sink);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg3, v3, arg4), v0.primary_sink);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg3, v0.overflow_sink);
        };
        let v4 = ValidationCompleted{
            schema_id     : arg1,
            field_id      : arg2,
            result_weight : v2,
        };
        0x2::event::emit<ValidationCompleted>(v4);
    }

    public entry fun register_field(arg0: &mut SchemaRegistry, arg1: 0x1::ascii::String, arg2: 0x2::object::ID, arg3: 0x1::ascii::String, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x1::ascii::String, SchemaConfig>(&arg0.fields, arg1), 101);
        let v0 = 0x2::table::borrow_mut<0x1::ascii::String, SchemaConfig>(&mut arg0.fields, arg1);
        let v1 = 0x2::tx_context::sender(arg5);
        assert!(v1 == v0.owner || v1 == v0.validator, 100);
        let v2 = FieldMeta{
            type_hash : arg3,
            weight    : arg4,
            validated : false,
        };
        if (0x2::table::contains<0x2::object::ID, FieldMeta>(&v0.fields, arg2)) {
            *0x2::table::borrow_mut<0x2::object::ID, FieldMeta>(&mut v0.fields, arg2) = v2;
        } else {
            0x2::table::add<0x2::object::ID, FieldMeta>(&mut v0.fields, arg2, v2);
        };
        let v3 = FieldRegistered{
            schema_id : arg1,
            field_id  : arg2,
            type_hash : arg3,
            weight    : arg4,
        };
        0x2::event::emit<FieldRegistered>(v3);
    }

    public fun should_process_field(arg0: &SchemaRegistry, arg1: 0x1::ascii::String, arg2: 0x2::object::ID) : bool {
        get_field_weight(arg0, arg1, arg2) > 0
    }

    public entry fun update_field_weight(arg0: &mut SchemaRegistry, arg1: 0x1::ascii::String, arg2: 0x2::object::ID, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x1::ascii::String, SchemaConfig>(&arg0.fields, arg1), 101);
        let v0 = 0x2::table::borrow_mut<0x1::ascii::String, SchemaConfig>(&mut arg0.fields, arg1);
        let v1 = 0x2::tx_context::sender(arg4);
        assert!(v1 == v0.owner || v1 == v0.validator, 100);
        assert!(0x2::table::contains<0x2::object::ID, FieldMeta>(&v0.fields, arg2), 102);
        0x2::table::borrow_mut<0x2::object::ID, FieldMeta>(&mut v0.fields, arg2).weight = arg3;
    }

    public entry fun validate_schema(arg0: &mut SchemaRegistry, arg1: 0x1::ascii::String, arg2: address, arg3: address, arg4: address, arg5: u8, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg5 <= 100, 106);
        let v0 = SchemaConfig{
            owner         : 0x2::tx_context::sender(arg6),
            validator     : arg2,
            status        : 0,
            primary_sink  : arg3,
            overflow_sink : arg4,
            weight_factor : arg5,
            fields        : 0x2::table::new<0x2::object::ID, FieldMeta>(arg6),
        };
        0x2::table::add<0x1::ascii::String, SchemaConfig>(&mut arg0.fields, arg1, v0);
        let v1 = SchemaCreated{
            schema_id : arg1,
            owner     : 0x2::tx_context::sender(arg6),
        };
        0x2::event::emit<SchemaCreated>(v1);
    }

    // decompiled from Move bytecode v6
}

