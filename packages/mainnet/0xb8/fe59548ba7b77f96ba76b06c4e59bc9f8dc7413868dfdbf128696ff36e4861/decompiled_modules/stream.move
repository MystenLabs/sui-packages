module 0xb8fe59548ba7b77f96ba76b06c4e59bc9f8dc7413868dfdbf128696ff36e4861::stream {
    struct Stream<phantom T0: drop + store> has store, key {
        id: 0x2::object::UID,
        owner: address,
        name: 0x1::string::String,
        data: 0x2::table::Table<u64, T0>,
        tags: 0x2::vec_map::VecMap<0x1::string::String, u8>,
        contributors: 0x2::vec_map::VecMap<address, u8>,
        created_at: u64,
        next_id: u64,
    }

    struct StreamRegistry has store, key {
        id: 0x2::object::UID,
    }

    public fun add<T0: drop + store>(arg0: &mut StreamRegistry, arg1: &mut Stream<T0>, arg2: T0, arg3: &0x2::tx_context::TxContext) {
        assert!(can_write_in_stream<T0>(arg1, 0x2::tx_context::sender(arg3)), 0xb8fe59548ba7b77f96ba76b06c4e59bc9f8dc7413868dfdbf128696ff36e4861::errors::EUnauthorized());
        0x2::table::add<u64, T0>(&mut arg1.data, arg1.next_id, arg2);
        arg1.next_id = arg1.next_id + 1;
    }

    public fun add_contributor<T0: drop + store>(arg0: &mut StreamRegistry, arg1: &mut Stream<T0>, arg2: address) {
        0x2::vec_map::insert<address, u8>(&mut arg1.contributors, arg2, 1);
    }

    public fun add_tag<T0: drop + store>(arg0: &mut StreamRegistry, arg1: &mut Stream<T0>, arg2: 0x1::string::String) {
        0x2::vec_map::insert<0x1::string::String, u8>(&mut arg1.tags, arg2, 1);
    }

    public fun can_write_in_stream<T0: drop + store>(arg0: &Stream<T0>, arg1: address) : bool {
        arg0.owner == arg1 || 0x2::vec_map::contains<address, u8>(&arg0.contributors, &arg1)
    }

    public fun get_next_id<T0: drop + store>(arg0: &Stream<T0>) : u64 {
        arg0.next_id
    }

    public fun get_stream_id<T0: drop + store>(arg0: &Stream<T0>) : 0x2::object::ID {
        0x2::object::id<Stream<T0>>(arg0)
    }

    public fun get_stream_name<T0: drop + store>(arg0: &Stream<T0>) : 0x1::string::String {
        arg0.name
    }

    public fun get_stream_owner<T0: drop + store>(arg0: &Stream<T0>) : address {
        arg0.owner
    }

    public fun new_stream<T0: drop + store>(arg0: &0x2::clock::Clock, arg1: &mut StreamRegistry, arg2: address, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) : Stream<T0> {
        Stream<T0>{
            id           : 0x2::object::new(arg4),
            owner        : arg2,
            name         : arg3,
            data         : 0x2::table::new<u64, T0>(arg4),
            tags         : 0x2::vec_map::empty<0x1::string::String, u8>(),
            contributors : 0x2::vec_map::empty<address, u8>(),
            created_at   : 0x2::clock::timestamp_ms(arg0),
            next_id      : 0,
        }
    }

    public fun remove_contributor<T0: drop + store>(arg0: &mut StreamRegistry, arg1: &mut Stream<T0>, arg2: address) {
        let (_, _) = 0x2::vec_map::remove<address, u8>(&mut arg1.contributors, &arg2);
    }

    public fun remove_tag<T0: drop + store>(arg0: &mut StreamRegistry, arg1: &mut Stream<T0>, arg2: 0x1::string::String) {
        let (_, _) = 0x2::vec_map::remove<0x1::string::String, u8>(&mut arg1.tags, &arg2);
    }

    // decompiled from Move bytecode v6
}

