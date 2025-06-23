module 0x22804e0f2d5fd6aa41847469c05dec3abfc3a3482483a02db795e951e2396872::memez_metadata {
    struct Key has copy, drop, store {
        dummy_field: bool,
    }

    struct MemezMetadata has store, key {
        id: 0x2::object::UID,
        decimals: u8,
    }

    public(friend) fun borrow(arg0: &MemezMetadata) : &0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String> {
        let v0 = Key{dummy_field: false};
        0x2::dynamic_field::borrow<Key, 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>(&arg0.id, v0)
    }

    public(friend) fun borrow_mut(arg0: &mut MemezMetadata) : &mut 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String> {
        let v0 = Key{dummy_field: false};
        0x2::dynamic_field::borrow_mut<Key, 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>(&mut arg0.id, v0)
    }

    public fun new<T0>(arg0: &0x2::coin::CoinMetadata<T0>, arg1: vector<0x1::string::String>, arg2: vector<0x1::string::String>, arg3: &mut 0x2::tx_context::TxContext) : MemezMetadata {
        assert!(0x2::coin::get_decimals<T0>(arg0) == 9, 22);
        let v0 = 0x2::object::new(arg3);
        let v1 = Key{dummy_field: false};
        0x2::dynamic_field::add<Key, 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>(&mut v0, v1, 0x2::vec_map::from_keys_values<0x1::string::String, 0x1::string::String>(arg1, arg2));
        MemezMetadata{
            id       : v0,
            decimals : 0x2::coin::get_decimals<T0>(arg0),
        }
    }

    public(friend) fun decimals(arg0: &MemezMetadata) : u8 {
        arg0.decimals
    }

    // decompiled from Move bytecode v6
}

