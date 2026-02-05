module 0xe24f54bb45d1777bc24589a5bcdce391608aeb0591ecff6974599b87785453a2::test_data {
    struct TestObject has store, key {
        id: 0x2::object::UID,
        category: u8,
        value: u64,
        data: vector<u8>,
    }

    struct TestObjectByCategory<phantom T0, phantom T1> has copy, drop {
        category: 0xe24f54bb45d1777bc24589a5bcdce391608aeb0591ecff6974599b87785453a2::move_auto_index::Partition<u8>,
        owner: 0xe24f54bb45d1777bc24589a5bcdce391608aeb0591ecff6974599b87785453a2::move_auto_index::Index<address>,
        value: 0xe24f54bb45d1777bc24589a5bcdce391608aeb0591ecff6974599b87785453a2::move_auto_index::Index<u64>,
        id: 0xe24f54bb45d1777bc24589a5bcdce391608aeb0591ecff6974599b87785453a2::move_auto_index::Index<0x2::object::UID>,
    }

    struct TestObjectByOwner<phantom T0, phantom T1> has copy, drop {
        owner: 0xe24f54bb45d1777bc24589a5bcdce391608aeb0591ecff6974599b87785453a2::move_auto_index::Partition<address>,
        category: 0xe24f54bb45d1777bc24589a5bcdce391608aeb0591ecff6974599b87785453a2::move_auto_index::Index<u8>,
        value: 0xe24f54bb45d1777bc24589a5bcdce391608aeb0591ecff6974599b87785453a2::move_auto_index::Index<u64>,
        id: 0xe24f54bb45d1777bc24589a5bcdce391608aeb0591ecff6974599b87785453a2::move_auto_index::Index<0x2::object::UID>,
    }

    struct TestEvent has copy, drop {
        category: u8,
        value: u64,
        data: vector<u8>,
    }

    struct TestEventByCategory<phantom T0, phantom T1> has copy, drop {
        category: 0xe24f54bb45d1777bc24589a5bcdce391608aeb0591ecff6974599b87785453a2::move_auto_index::Partition<u8>,
        value: 0xe24f54bb45d1777bc24589a5bcdce391608aeb0591ecff6974599b87785453a2::move_auto_index::Index<u64>,
    }

    struct TestEventBySender<phantom T0, phantom T1> has copy, drop {
        sender: 0xe24f54bb45d1777bc24589a5bcdce391608aeb0591ecff6974599b87785453a2::move_auto_index::Partition<address>,
        tx_sequence: 0xe24f54bb45d1777bc24589a5bcdce391608aeb0591ecff6974599b87785453a2::move_auto_index::Index<u64>,
        event_sequence: 0xe24f54bb45d1777bc24589a5bcdce391608aeb0591ecff6974599b87785453a2::move_auto_index::Index<u16>,
    }

    struct TestEventByValue<phantom T0, phantom T1> has copy, drop {
        category: 0xe24f54bb45d1777bc24589a5bcdce391608aeb0591ecff6974599b87785453a2::move_auto_index::Partition<u8>,
        value: 0xe24f54bb45d1777bc24589a5bcdce391608aeb0591ecff6974599b87785453a2::move_auto_index::Index<u64>,
    }

    public entry fun create_object(arg0: u8, arg1: u64, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = TestObject{
            id       : 0x2::object::new(arg3),
            category : arg0,
            value    : arg1,
            data     : arg2,
        };
        0x2::transfer::transfer<TestObject>(v0, 0x2::tx_context::sender(arg3));
    }

    public entry fun delete_object(arg0: TestObject) {
        let TestObject {
            id       : v0,
            category : _,
            value    : _,
            data     : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public entry fun emit_event(arg0: u8, arg1: u64, arg2: vector<u8>) {
        let v0 = TestEvent{
            category : arg0,
            value    : arg1,
            data     : arg2,
        };
        0x2::event::emit<TestEvent>(v0);
    }

    public entry fun emit_multiple_events(arg0: u8, arg1: u64, arg2: u64) {
        let v0 = 0;
        while (v0 < arg2) {
            let v1 = TestEvent{
                category : arg0,
                value    : arg1 + v0,
                data     : 0x1::vector::empty<u8>(),
            };
            0x2::event::emit<TestEvent>(v1);
            v0 = v0 + 1;
        };
    }

    public fun get_category(arg0: &TestObject) : u8 {
        arg0.category
    }

    public fun get_data(arg0: &TestObject) : &vector<u8> {
        &arg0.data
    }

    public fun get_value(arg0: &TestObject) : u64 {
        arg0.value
    }

    public entry fun update_object(arg0: &mut TestObject, arg1: u64) {
        arg0.value = arg1;
    }

    public entry fun update_object_data(arg0: &mut TestObject, arg1: vector<u8>) {
        arg0.data = arg1;
    }

    // decompiled from Move bytecode v6
}

