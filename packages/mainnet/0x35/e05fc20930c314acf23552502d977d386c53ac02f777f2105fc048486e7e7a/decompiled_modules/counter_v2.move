module 0x35e05fc20930c314acf23552502d977d386c53ac02f777f2105fc048486e7e7a::counter_v2 {
    struct AssetKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct Counter has store, key {
        id: 0x2::object::UID,
        version: u16,
    }

    public(friend) fun add_existing_assets<T0>(arg0: &mut Counter, arg1: u64) {
        add_field<T0>(arg0);
        let v0 = AssetKey<T0>{dummy_field: false};
        *0x2::dynamic_field::borrow_mut<AssetKey<T0>, u64>(&mut arg0.id, v0) = arg1;
    }

    public(friend) fun add_field<T0>(arg0: &mut Counter) {
        let v0 = AssetKey<T0>{dummy_field: false};
        0x2::dynamic_field::add<AssetKey<T0>, u64>(&mut arg0.id, v0, 0);
    }

    public(friend) fun incr_counter<T0>(arg0: &mut Counter) {
        let v0 = AssetKey<T0>{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow_mut<AssetKey<T0>, u64>(&mut arg0.id, v0);
        *v1 = *v1 + 1;
    }

    public(friend) fun new_internal(arg0: &mut 0x2::tx_context::TxContext) : Counter {
        Counter{
            id      : 0x2::object::new(arg0),
            version : 0x35e05fc20930c314acf23552502d977d386c53ac02f777f2105fc048486e7e7a::package::version(),
        }
    }

    public fun num_minted<T0>(arg0: &Counter) : u64 {
        let v0 = AssetKey<T0>{dummy_field: false};
        *0x2::dynamic_field::borrow<AssetKey<T0>, u64>(&arg0.id, v0)
    }

    entry fun update_version(arg0: &mut Counter, arg1: &0x2::package::Publisher) {
        assert!(0x2::package::from_package<0x35e05fc20930c314acf23552502d977d386c53ac02f777f2105fc048486e7e7a::package::PACKAGE>(arg1), 1);
        let v0 = 0x35e05fc20930c314acf23552502d977d386c53ac02f777f2105fc048486e7e7a::package::version();
        assert!(arg0.version < v0, 0);
        arg0.version = v0;
    }

    public fun version(arg0: &Counter) : u16 {
        arg0.version
    }

    // decompiled from Move bytecode v6
}

