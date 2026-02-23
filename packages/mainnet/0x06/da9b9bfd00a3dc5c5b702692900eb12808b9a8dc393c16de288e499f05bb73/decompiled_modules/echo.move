module 0x6da9b9bfd00a3dc5c5b702692900eb12808b9a8dc393c16de288e499f05bb73::echo {
    struct SingleValueEvent has copy, drop {
        value: u64,
    }

    struct NoConfigSingleValueEvent has copy, drop {
        value: u64,
    }

    struct DoubleValueEvent has copy, drop {
        number: u64,
        text: 0x1::string::String,
    }

    struct TripleValueEvent has copy, drop {
        values: vector<vector<u8>>,
    }

    struct EventStore has key {
        id: 0x2::object::UID,
    }

    public fun echo_byte_vector(arg0: vector<u8>) : vector<u8> {
        arg0
    }

    public fun echo_byte_vector_vector(arg0: vector<vector<u8>>) : vector<vector<u8>> {
        arg0
    }

    public fun echo_string(arg0: 0x1::string::String) : 0x1::string::String {
        arg0
    }

    public fun echo_u256(arg0: u256) : u256 {
        arg0
    }

    public fun echo_u32_u64_tuple(arg0: u32, arg1: u64) : (u32, u64) {
        (arg0, arg1)
    }

    public fun echo_u64(arg0: u64) : u64 {
        arg0
    }

    public entry fun echo_with_events(arg0: &EventStore, arg1: u64, arg2: 0x1::string::String, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = SingleValueEvent{value: arg1};
        0x2::event::emit<SingleValueEvent>(v0);
        let v1 = DoubleValueEvent{
            number : arg1,
            text   : arg2,
        };
        0x2::event::emit<DoubleValueEvent>(v1);
        let v2 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v2, arg3);
        let v3 = TripleValueEvent{values: v2};
        0x2::event::emit<TripleValueEvent>(v3);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = EventStore{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<EventStore>(v0);
    }

    public fun no_config_event_echo(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = NoConfigSingleValueEvent{value: arg0};
        0x2::event::emit<NoConfigSingleValueEvent>(v0);
        arg0
    }

    public fun simple_event_echo(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = SingleValueEvent{value: arg0};
        0x2::event::emit<SingleValueEvent>(v0);
        arg0
    }

    // decompiled from Move bytecode v6
}

