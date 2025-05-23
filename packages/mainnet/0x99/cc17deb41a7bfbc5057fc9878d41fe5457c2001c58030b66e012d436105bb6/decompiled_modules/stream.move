module 0x99cc17deb41a7bfbc5057fc9878d41fe5457c2001c58030b66e012d436105bb6::stream {
    struct Stream<phantom T0: drop + store> has store, key {
        id: 0x2::object::UID,
        owner: address,
        data: 0x2::table::Table<u64, T0>,
        linked_stream: 0x1::option::Option<0x2::object::ID>,
        linked_stream_owner: 0x1::option::Option<address>,
        max_size: u64,
        next_id: u64,
        created_at: u64,
    }

    struct StreamRegistry has store, key {
        id: 0x2::object::UID,
    }

    public fun add<T0: drop + store>(arg0: &mut StreamRegistry, arg1: &mut Stream<T0>, arg2: T0, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg1.owner, 0x99cc17deb41a7bfbc5057fc9878d41fe5457c2001c58030b66e012d436105bb6::errors::EUnauthorized());
        let v0 = if (arg1.max_size == 0) {
            arg1.next_id
        } else {
            arg1.next_id % arg1.max_size
        };
        if (0x2::table::contains<u64, T0>(&arg1.data, v0)) {
            0x2::table::remove<u64, T0>(&mut arg1.data, v0);
        };
        0x2::table::add<u64, T0>(&mut arg1.data, v0, arg2);
        arg1.next_id = arg1.next_id + 1;
    }

    public fun get_linked_stream_id<T0: drop + store>(arg0: &Stream<T0>) : 0x1::option::Option<0x2::object::ID> {
        arg0.linked_stream
    }

    public fun get_linked_stream_owner<T0: drop + store>(arg0: &Stream<T0>) : 0x1::option::Option<address> {
        arg0.linked_stream_owner
    }

    public fun get_stream_id<T0: drop + store>(arg0: &Stream<T0>) : 0x2::object::ID {
        0x2::object::id<Stream<T0>>(arg0)
    }

    public fun get_stream_owner<T0: drop + store>(arg0: &Stream<T0>) : address {
        arg0.owner
    }

    public fun initialize(arg0: &mut 0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::registry::Registry, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = StreamRegistry{id: 0x2::object::new(arg1)};
        0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::registry::add<StreamRegistry>(arg0, v0);
    }

    public fun is_linked<T0: drop + store>(arg0: &Stream<T0>) : bool {
        0x1::option::is_some<0x2::object::ID>(&arg0.linked_stream) && 0x1::option::is_some<address>(&arg0.linked_stream_owner)
    }

    public fun link_streams<T0: drop + store>(arg0: &mut StreamRegistry, arg1: &mut Stream<T0>, arg2: &mut Stream<T0>, arg3: bool) {
        if (arg3 == false) {
            assert!(is_linked<T0>(arg1) == false, 0x99cc17deb41a7bfbc5057fc9878d41fe5457c2001c58030b66e012d436105bb6::errors::EStreamAlreadyLinked());
            assert!(is_linked<T0>(arg2) == false, 0x99cc17deb41a7bfbc5057fc9878d41fe5457c2001c58030b66e012d436105bb6::errors::EStreamAlreadyLinked());
        };
        set_linked_stream<T0>(arg0, arg1, get_stream_id<T0>(arg2), get_stream_owner<T0>(arg2));
        set_linked_stream<T0>(arg0, arg2, get_stream_id<T0>(arg1), arg1.owner);
    }

    public fun new_stream<T0: drop + store>(arg0: &0x2::clock::Clock, arg1: &mut StreamRegistry, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : Stream<T0> {
        Stream<T0>{
            id                  : 0x2::object::new(arg4),
            owner               : arg2,
            data                : 0x2::table::new<u64, T0>(arg4),
            linked_stream       : 0x1::option::none<0x2::object::ID>(),
            linked_stream_owner : 0x1::option::none<address>(),
            max_size            : arg3,
            next_id             : 0,
            created_at          : 0x2::clock::timestamp_ms(arg0),
        }
    }

    public fun set_linked_stream<T0: drop + store>(arg0: &mut StreamRegistry, arg1: &mut Stream<T0>, arg2: 0x2::object::ID, arg3: address) {
        arg1.linked_stream = 0x1::option::some<0x2::object::ID>(arg2);
        arg1.linked_stream_owner = 0x1::option::some<address>(arg3);
    }

    // decompiled from Move bytecode v6
}

