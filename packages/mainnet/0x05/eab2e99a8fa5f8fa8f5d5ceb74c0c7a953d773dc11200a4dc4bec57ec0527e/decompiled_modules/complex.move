module 0x5eab2e99a8fa5f8fa8f5d5ceb74c0c7a953d773dc11200a4dc4bec57ec0527e::complex {
    struct SampleObject has store, key {
        id: 0x2::object::UID,
        some_id: vector<u8>,
        some_number: u64,
        some_address: address,
        some_addresses: vector<address>,
    }

    struct DroppableObject has drop {
        some_id: vector<u8>,
        some_number: u64,
        some_address: address,
        some_addresses: vector<address>,
    }

    public fun check_string(arg0: 0x1::ascii::String) : 0x1::ascii::String {
        arg0
    }

    public fun check_u128(arg0: u128) : u128 {
        arg0
    }

    public fun check_u256(arg0: u256) : u256 {
        arg0
    }

    public fun check_with_mut_object_ref(arg0: &mut SampleObject, arg1: u64) : u64 {
        arg0.some_number = arg1;
        arg0.some_number
    }

    public fun check_with_object_ref(arg0: &SampleObject) : u64 {
        arg0.some_number
    }

    public fun flatten_address(arg0: address, arg1: vector<address>) : vector<address> {
        let v0 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v0, arg0);
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(&arg1)) {
            0x1::vector::push_back<address>(&mut v0, *0x1::vector::borrow<address>(&arg1, v1));
            v1 = v1 + 1;
        };
        v0
    }

    public fun flatten_string(arg0: vector<vector<0x1::ascii::String>>) : vector<0x1::ascii::String> {
        let v0 = 0x1::vector::empty<0x1::ascii::String>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<vector<0x1::ascii::String>>(&arg0)) {
            let v2 = 0x1::vector::borrow<vector<0x1::ascii::String>>(&arg0, v1);
            let v3 = 0;
            while (v3 < 0x1::vector::length<0x1::ascii::String>(v2)) {
                0x1::vector::push_back<0x1::ascii::String>(&mut v0, *0x1::vector::borrow<0x1::ascii::String>(v2, v3));
                v3 = v3 + 1;
            };
            v1 = v1 + 1;
        };
        v0
    }

    public fun flatten_u8(arg0: vector<vector<u8>>) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<vector<u8>>(&arg0)) {
            let v2 = 0x1::vector::borrow<vector<u8>>(&arg0, v1);
            let v3 = 0;
            while (v3 < 0x1::vector::length<u8>(v2)) {
                0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(v2, v3));
                v3 = v3 + 1;
            };
            v1 = v1 + 1;
        };
        v0
    }

    public fun new_object(arg0: vector<u8>, arg1: u64, arg2: address, arg3: vector<address>) : DroppableObject {
        DroppableObject{
            some_id        : arg0,
            some_number    : arg1,
            some_address   : arg2,
            some_addresses : arg3,
        }
    }

    public fun new_object_with_transfer(arg0: vector<u8>, arg1: u64, arg2: address, arg3: vector<address>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = SampleObject{
            id             : 0x2::object::new(arg4),
            some_id        : arg0,
            some_number    : arg1,
            some_address   : arg2,
            some_addresses : arg3,
        };
        0x2::transfer::share_object<SampleObject>(v0);
    }

    // decompiled from Move bytecode v6
}

