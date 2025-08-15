module 0xbc7834f9d7a512a8eec4c19a88696abeb5081506306361006d3e37a4e1fc12c6::key_request {
    struct KeyRequest has store, key {
        id: 0x2::object::UID,
        package: 0x1::ascii::String,
        inner_id: vector<u8>,
        user: address,
        valid_till: u64,
    }

    public fun destroy(arg0: KeyRequest) {
        let KeyRequest {
            id         : v0,
            package    : _,
            inner_id   : _,
            user       : _,
            valid_till : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun request_key<T0: drop>(arg0: T0, arg1: vector<u8>, arg2: address, arg3: &0x2::clock::Clock, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : KeyRequest {
        let v0 = 0x1::type_name::get_with_original_ids<T0>();
        KeyRequest{
            id         : 0x2::object::new(arg5),
            package    : 0x1::type_name::get_address(&v0),
            inner_id   : arg1,
            user       : arg2,
            valid_till : 0x2::clock::timestamp_ms(arg3) + arg4,
        }
    }

    public fun verify<T0: drop>(arg0: &KeyRequest, arg1: T0, arg2: vector<u8>, arg3: address, arg4: &0x2::clock::Clock) : bool {
        let v0 = 0x1::type_name::get_with_original_ids<T0>();
        if (arg0.package == 0x1::type_name::get_address(&v0)) {
            if (arg0.inner_id == arg2) {
                if (arg0.user == arg3) {
                    0x2::clock::timestamp_ms(arg4) <= arg0.valid_till
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        }
    }

    // decompiled from Move bytecode v6
}

