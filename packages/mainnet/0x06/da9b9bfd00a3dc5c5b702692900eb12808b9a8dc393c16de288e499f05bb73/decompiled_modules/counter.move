module 0x6da9b9bfd00a3dc5c5b702692900eb12808b9a8dc393c16de288e499f05bb73::counter {
    struct COUNTER has drop {
        dummy_field: bool,
    }

    struct CounterIncremented has copy, drop {
        counter_id: 0x2::object::ID,
        new_value: u64,
    }

    struct CounterDecremented has copy, drop {
        event_type: 0x1::string::String,
        counter_id: 0x2::object::ID,
        new_value: u64,
    }

    struct CounterBytes has copy, drop {
        bytes: vector<u8>,
        nested: NestedCounterBytes,
        values: vector<u64>,
    }

    struct NestedCounterBytes has copy, drop {
        value: u64,
        bytes: vector<u8>,
    }

    struct DoubleCheckCCIPPointer has copy, drop {
        addresses: vector<address>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Counter has store, key {
        id: 0x2::object::UID,
        value: u64,
    }

    struct CounterObject has key {
        id: 0x2::object::UID,
    }

    struct SomeObject has store, key {
        id: 0x2::object::UID,
    }

    struct CounterPointer has store, key {
        id: 0x2::object::UID,
        counter_object_id: address,
    }

    struct AddressList has copy, drop {
        addresses: vector<address>,
        count: u64,
    }

    struct SimpleResult has copy, drop {
        value: u64,
    }

    struct ComplexResult has copy, drop {
        count: u64,
        addr: address,
        is_complex: bool,
        bytes: vector<u8>,
    }

    struct NestedStruct has copy, drop {
        is_nested: bool,
        double_count: u64,
        nested_struct: ComplexResult,
        nested_simple_struct: SimpleResult,
    }

    struct MultiNestedStruct has copy, drop {
        is_multi_nested: bool,
        double_count: u64,
        nested_struct: NestedStruct,
        nested_simple_struct: SimpleResult,
    }

    struct ConfigInfo has copy, drop, store {
        config_digest: vector<u8>,
        big_f: u8,
        n: u8,
        is_signature_verification_enabled: bool,
    }

    struct OCRConfig has copy, drop, store {
        config_info: ConfigInfo,
        signers: vector<vector<u8>>,
        transmitters: vector<address>,
    }

    public fun create(arg0: &mut 0x2::tx_context::TxContext) : Counter {
        Counter{
            id    : 0x2::object::new(arg0),
            value : 0,
        }
    }

    public fun create_many_objects(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < arg0) {
            let v1 = SomeObject{id: 0x2::object::new(arg1)};
            0x2::transfer::transfer<SomeObject>(v1, 0x2::tx_context::sender(arg1));
            v0 = v0 + 1;
        };
    }

    public fun decrement(arg0: &mut Counter) {
        arg0.value = arg0.value - 1;
        let v0 = CounterDecremented{
            event_type : 0x1::string::utf8(b"CounterDecremented"),
            counter_id : 0x2::object::id<Counter>(arg0),
            new_value  : arg0.value,
        };
        0x2::event::emit<CounterDecremented>(v0);
    }

    public fun emit_counter_bytes(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = NestedCounterBytes{
            value : 42,
            bytes : b"test",
        };
        let v1 = CounterBytes{
            bytes  : b"test",
            nested : v0,
            values : vector[1, 2, 3, 4],
        };
        0x2::event::emit<CounterBytes>(v1);
    }

    public fun get_address_list() : AddressList {
        let v0 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v0, @0x1);
        0x1::vector::push_back<address>(&mut v0, @0x2);
        0x1::vector::push_back<address>(&mut v0, @0x3);
        0x1::vector::push_back<address>(&mut v0, @0x4);
        AddressList{
            addresses : v0,
            count     : 0x1::vector::length<address>(&v0),
        }
    }

    public fun get_coin_value<T0>(arg0: &0x2::coin::Coin<T0>) : u64 {
        0x2::coin::value<T0>(arg0)
    }

    public fun get_count(arg0: &Counter) : u64 {
        arg0.value
    }

    public fun get_count_no_entry(arg0: &Counter) : u64 {
        arg0.value
    }

    public fun get_count_using_pointer(arg0: &Counter) : u64 {
        arg0.value
    }

    public fun get_multi_nested_result_struct() : MultiNestedStruct {
        let v0 = SimpleResult{value: 42};
        MultiNestedStruct{
            is_multi_nested      : true,
            double_count         : 42,
            nested_struct        : get_nested_result_struct(),
            nested_simple_struct : v0,
        }
    }

    public fun get_nested_result_struct() : NestedStruct {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::push_back<u8>(&mut v0, 1);
        0x1::vector::push_back<u8>(&mut v0, 2);
        0x1::vector::push_back<u8>(&mut v0, 3);
        0x1::vector::push_back<u8>(&mut v0, 4);
        let v1 = ComplexResult{
            count      : 42,
            addr       : @0x1,
            is_complex : true,
            bytes      : v0,
        };
        let v2 = SimpleResult{value: 42};
        NestedStruct{
            is_nested            : true,
            double_count         : 42,
            nested_struct        : v1,
            nested_simple_struct : v2,
        }
    }

    public fun get_ocr_config() : OCRConfig {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::push_back<u8>(&mut v0, 2);
        0x1::vector::push_back<u8>(&mut v0, 3);
        0x1::vector::push_back<u8>(&mut v0, 4);
        0x1::vector::push_back<u8>(&mut v0, 5);
        let v1 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v1, 0x2::address::to_bytes(@0x5));
        let v2 = 0x1::vector::empty<u8>();
        0x1::vector::push_back<u8>(&mut v2, 6);
        0x1::vector::push_back<u8>(&mut v2, 6);
        0x1::vector::push_back<vector<u8>>(&mut v1, v2);
        let v3 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v3, @0x7);
        let v4 = ConfigInfo{
            config_digest                     : v0,
            big_f                             : 1,
            n                                 : 2,
            is_signature_verification_enabled : true,
        };
        OCRConfig{
            config_info  : v4,
            signers      : v1,
            transmitters : v3,
        }
    }

    public fun get_result_struct() : ComplexResult {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::push_back<u8>(&mut v0, 1);
        0x1::vector::push_back<u8>(&mut v0, 2);
        0x1::vector::push_back<u8>(&mut v0, 3);
        0x1::vector::push_back<u8>(&mut v0, 4);
        ComplexResult{
            count      : 42,
            addr       : @0x1,
            is_complex : true,
            bytes      : v0,
        }
    }

    public fun get_simple_result() : SimpleResult {
        SimpleResult{value: 42}
    }

    public fun get_tuple_struct() : (u64, address, bool, MultiNestedStruct) {
        let v0 = SimpleResult{value: 42};
        let v1 = MultiNestedStruct{
            is_multi_nested      : true,
            double_count         : 42,
            nested_struct        : get_nested_result_struct(),
            nested_simple_struct : v0,
        };
        (42, @0x1, true, v1)
    }

    public fun get_value_with_pointer_dependency(arg0: &mut Counter, arg1: &0x6da9b9bfd00a3dc5c5b702692900eb12808b9a8dc393c16de288e499f05bb73::state_object::CCIPObjectRef) : u64 {
        let v0 = DoubleCheckCCIPPointer{addresses: 0x6da9b9bfd00a3dc5c5b702692900eb12808b9a8dc393c16de288e499f05bb73::state_object::get_package_ids(arg1)};
        0x2::event::emit<DoubleCheckCCIPPointer>(v0);
        5
    }

    public fun get_vector_of_addresses() : vector<address> {
        let v0 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v0, @0x1);
        0x1::vector::push_back<address>(&mut v0, @0x2);
        0x1::vector::push_back<address>(&mut v0, @0x3);
        0x1::vector::push_back<address>(&mut v0, @0x4);
        v0
    }

    public fun get_vector_of_u8() : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::push_back<u8>(&mut v0, 1);
        0x1::vector::push_back<u8>(&mut v0, 2);
        0x1::vector::push_back<u8>(&mut v0, 3);
        0x1::vector::push_back<u8>(&mut v0, 4);
        v0
    }

    public fun get_vector_of_vectors_of_u8() : vector<vector<u8>> {
        let v0 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v0, 0x2::address::to_bytes(@0x1));
        0x1::vector::push_back<vector<u8>>(&mut v0, 0x2::address::to_bytes(@0x2));
        0x1::vector::push_back<vector<u8>>(&mut v0, 0x2::address::to_bytes(@0x3));
        0x1::vector::push_back<vector<u8>>(&mut v0, 0x2::address::to_bytes(@0x4));
        v0
    }

    public fun increment(arg0: &mut Counter) {
        arg0.value = arg0.value + 1;
        let v0 = CounterIncremented{
            counter_id : 0x2::object::id<Counter>(arg0),
            new_value  : arg0.value,
        };
        0x2::event::emit<CounterIncremented>(v0);
    }

    public fun increment_by(arg0: &mut Counter, arg1: u64) {
        assert!(arg1 <= 999, 1);
        arg0.value = arg0.value + arg1;
        let v0 = CounterIncremented{
            counter_id : 0x2::object::id<Counter>(arg0),
            new_value  : arg0.value,
        };
        0x2::event::emit<CounterIncremented>(v0);
    }

    public fun increment_by_bytes_length(arg0: &mut Counter, arg1: vector<u8>) {
        assert!(0x1::vector::length<u8>(&arg1) <= 4, 2);
        arg0.value = arg0.value + 0x1::vector::length<u8>(&arg1);
        let v0 = CounterIncremented{
            counter_id : 0x2::object::id<Counter>(arg0),
            new_value  : arg0.value,
        };
        0x2::event::emit<CounterIncremented>(v0);
    }

    public fun increment_by_one(arg0: &mut Counter, arg1: &mut 0x2::tx_context::TxContext) : u64 {
        arg0.value = arg0.value + 1;
        let v0 = CounterIncremented{
            counter_id : 0x2::object::id<Counter>(arg0),
            new_value  : arg0.value,
        };
        0x2::event::emit<CounterIncremented>(v0);
        arg0.value
    }

    public fun increment_by_one_no_context(arg0: &mut Counter) : u64 {
        arg0.value = arg0.value + 1;
        let v0 = CounterIncremented{
            counter_id : 0x2::object::id<Counter>(arg0),
            new_value  : arg0.value,
        };
        0x2::event::emit<CounterIncremented>(v0);
        arg0.value
    }

    public fun increment_by_two(arg0: &AdminCap, arg1: &mut Counter, arg2: &mut 0x2::tx_context::TxContext) {
        arg1.value = arg1.value + 2;
        let v0 = CounterIncremented{
            counter_id : 0x2::object::id<Counter>(arg1),
            new_value  : arg1.value,
        };
        0x2::event::emit<CounterIncremented>(v0);
    }

    public fun increment_by_two_no_context(arg0: &AdminCap, arg1: &mut Counter) {
        arg1.value = arg1.value + 2;
        let v0 = CounterIncremented{
            counter_id : 0x2::object::id<Counter>(arg1),
            new_value  : arg1.value,
        };
        0x2::event::emit<CounterIncremented>(v0);
    }

    public fun increment_mult(arg0: &mut Counter, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        arg0.value = arg0.value + arg1 * arg2;
        let v0 = CounterIncremented{
            counter_id : 0x2::object::id<Counter>(arg0),
            new_value  : arg0.value,
        };
        0x2::event::emit<CounterIncremented>(v0);
    }

    fun init(arg0: COUNTER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = CounterObject{id: 0x2::object::new(arg1)};
        let v1 = Counter{
            id    : 0x2::derived_object::claim<vector<u8>>(&mut v0.id, b"Counter"),
            value : 0,
        };
        let v2 = AdminCap{id: 0x2::object::new(arg1)};
        let v3 = CounterPointer{
            id                : 0x2::object::new(arg1),
            counter_object_id : 0x2::object::id_to_address(0x2::object::borrow_id<CounterObject>(&v0)),
        };
        let v4 = CounterPointer{
            id                : 0x2::object::new(arg1),
            counter_object_id : 0x2::object::id_to_address(0x2::object::borrow_id<CounterObject>(&v0)),
        };
        let v5 = 0x1::type_name::get_with_original_ids<COUNTER>();
        let v6 = 0x1::ascii::into_bytes(0x1::type_name::get_address(&v5));
        0x2::transfer::share_object<Counter>(v1);
        0x2::transfer::share_object<CounterObject>(v0);
        0x2::transfer::transfer<AdminCap>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::transfer<CounterPointer>(v3, 0x2::address::from_ascii_bytes(&v6));
        0x2::transfer::transfer<CounterPointer>(v4, 0x2::tx_context::sender(arg1));
    }

    public fun initialize(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Counter{
            id    : 0x2::object::new(arg0),
            value : 0,
        };
        0x2::transfer::share_object<Counter>(v0);
    }

    public fun type_and_version() : 0x1::string::String {
        0x1::string::utf8(b"Counter 1.6.0")
    }

    // decompiled from Move bytecode v6
}

