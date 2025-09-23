module 0x97ff972ad8efc885000c6c49db90f6cf0ee83af350965ed8232814000f6689f9::registry {
    struct REGISTRY has drop {
        dummy_field: bool,
    }

    struct ProgramState has key {
        id: 0x2::object::UID,
        authority: address,
        verifier: address,
        verifier_public_key: vector<u8>,
        operation_counter: u64,
        used_timestamps: 0x2::table::Table<u64, bool>,
        timestamp_to_record: 0x2::table::Table<u64, 0x2::object::ID>,
    }

    struct OperationRecord has store, key {
        id: 0x2::object::UID,
        operation_name: 0x1::string::String,
        sender: address,
        timestamp: u64,
        operation_id: u64,
    }

    struct OperationExecuted has copy, drop {
        sender: address,
        operation_name: 0x1::string::String,
        timestamp: u64,
        operation_id: u64,
        record_id: 0x2::object::ID,
    }

    fun create_operation_message(arg0: 0x1::string::String, arg1: u64, arg2: address, arg3: u64, arg4: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, *0x1::string::as_bytes(&arg0));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg1));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<address>(&arg2));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg3));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg4));
        v0
    }

    public fun get_authority(arg0: &ProgramState) : address {
        arg0.authority
    }

    public fun get_operation_counter(arg0: &ProgramState) : u64 {
        arg0.operation_counter
    }

    public fun get_operation_record_details(arg0: &OperationRecord) : (0x1::string::String, address, u64, u64) {
        (arg0.operation_name, arg0.sender, arg0.timestamp, arg0.operation_id)
    }

    public fun get_record_id_by_timestamp(arg0: &ProgramState, arg1: u64) : 0x1::option::Option<0x2::object::ID> {
        if (0x2::table::contains<u64, 0x2::object::ID>(&arg0.timestamp_to_record, arg1)) {
            0x1::option::some<0x2::object::ID>(*0x2::table::borrow<u64, 0x2::object::ID>(&arg0.timestamp_to_record, arg1))
        } else {
            0x1::option::none<0x2::object::ID>()
        }
    }

    public fun get_verifier(arg0: &ProgramState) : address {
        arg0.verifier
    }

    public fun has_record_for_timestamp(arg0: &ProgramState, arg1: u64) : bool {
        0x2::table::contains<u64, 0x2::object::ID>(&arg0.timestamp_to_record, arg1)
    }

    fun init(arg0: REGISTRY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = ProgramState{
            id                  : 0x2::object::new(arg1),
            authority           : 0x2::tx_context::sender(arg1),
            verifier            : @0x4e3803889934c26540965b8684454a380cecdae5984bdf0e111721a3785d57d2,
            verifier_public_key : x"116e9ff64f20b766fbd549ef62e3a4553c763e803a32d50153d266e1a585d322",
            operation_counter   : 0,
            used_timestamps     : 0x2::table::new<u64, bool>(arg1),
            timestamp_to_record : 0x2::table::new<u64, 0x2::object::ID>(arg1),
        };
        0x2::transfer::share_object<ProgramState>(v0);
    }

    public fun is_timestamp_used(arg0: &ProgramState, arg1: u64) : bool {
        0x2::table::contains<u64, bool>(&arg0.used_timestamps, arg1)
    }

    public entry fun record_operation(arg0: &mut ProgramState, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: 0x1::string::String, arg4: u64, arg5: u64, arg6: u64, arg7: vector<u8>, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg8);
        assert!(!0x2::table::contains<u64, bool>(&arg0.used_timestamps, arg4), 3);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= arg5, 1);
        assert!(0x2::clock::timestamp_ms(arg2) / 1000 < arg6, 2);
        arg0.operation_counter = arg0.operation_counter + 1;
        let v1 = create_operation_message(arg3, arg4, v0, arg5, arg6);
        verify_signature(&v1, &arg7, &arg0.verifier_public_key);
        0x2::table::add<u64, bool>(&mut arg0.used_timestamps, arg4, true);
        if (arg5 > 0) {
            if (0x2::coin::value<0x2::sui::SUI>(&arg1) == arg5) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, arg0.verifier);
            } else {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, arg5, arg8), arg0.verifier);
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, v0);
            };
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, v0);
        };
        let v2 = OperationRecord{
            id             : 0x2::object::new(arg8),
            operation_name : arg3,
            sender         : v0,
            timestamp      : arg4,
            operation_id   : arg0.operation_counter,
        };
        let v3 = 0x2::object::id<OperationRecord>(&v2);
        0x2::table::add<u64, 0x2::object::ID>(&mut arg0.timestamp_to_record, arg4, v3);
        0x2::transfer::share_object<OperationRecord>(v2);
        let v4 = OperationExecuted{
            sender         : v0,
            operation_name : arg3,
            timestamp      : arg4,
            operation_id   : arg0.operation_counter,
            record_id      : v3,
        };
        0x2::event::emit<OperationExecuted>(v4);
    }

    public entry fun update_verifier(arg0: &mut ProgramState, arg1: address, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.authority, 5);
        assert!(0x1::vector::length<u8>(&arg2) == 32, 6);
        arg0.verifier = arg1;
        arg0.verifier_public_key = arg2;
    }

    fun verify_signature(arg0: &vector<u8>, arg1: &vector<u8>, arg2: &vector<u8>) {
        assert!(0x1::vector::length<u8>(arg1) == 64, 4);
        assert!(0x1::vector::length<u8>(arg2) == 32, 6);
        assert!(0x2::ed25519::ed25519_verify(arg1, arg2, arg0), 4);
    }

    // decompiled from Move bytecode v6
}

