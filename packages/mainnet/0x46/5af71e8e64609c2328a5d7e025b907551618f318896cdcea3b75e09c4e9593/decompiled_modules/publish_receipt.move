module 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::publish_receipt {
    struct PublishReceipt has store, key {
        id: 0x2::object::UID,
        package: 0x2::object::ID,
    }

    public fun claim<T0: drop>(arg0: &T0, arg1: &mut 0x2::tx_context::TxContext) : PublishReceipt {
        assert!(0x2::types::is_one_time_witness<T0>(arg0), 0);
        PublishReceipt{
            id      : 0x2::object::new(arg1),
            package : 0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::encode::package_id<T0>(),
        }
    }

    public fun destroy(arg0: PublishReceipt) {
        let PublishReceipt {
            id      : v0,
            package : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun did_publish<T0>(arg0: &PublishReceipt) : bool {
        did_publish_(arg0, 0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::encode::package_id<T0>())
    }

    public fun did_publish_(arg0: &PublishReceipt, arg1: 0x2::object::ID) : bool {
        arg0.package == arg1
    }

    public fun into_package_id(arg0: &PublishReceipt) : 0x2::object::ID {
        arg0.package
    }

    public fun uid(arg0: &PublishReceipt) : &0x2::object::UID {
        &arg0.id
    }

    public fun uid_mut(arg0: &mut PublishReceipt) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    // decompiled from Move bytecode v6
}

