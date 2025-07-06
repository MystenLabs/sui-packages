module 0x2c05398b432aa982c34311b5208f5ce23b95c4d8bc3e347804967471c8602fb0::key_server {
    struct KeyServer has key {
        id: 0x2::object::UID,
        first_version: u64,
        last_version: u64,
    }

    struct KeyServerV1 has store {
        name: 0x1::string::String,
        url: 0x1::string::String,
        key_type: u8,
        pk: vector<u8>,
    }

    struct Cap has store, key {
        id: 0x2::object::UID,
        key_server_id: 0x2::object::ID,
    }

    public fun id(arg0: &KeyServer) : &0x2::object::UID {
        &arg0.id
    }

    entry fun create_and_transfer_v1(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: u8, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = create_v1(arg0, arg1, arg2, arg3, arg4);
        0x2::transfer::transfer<Cap>(v0, 0x2::tx_context::sender(arg4));
    }

    public fun create_v1(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: u8, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) : Cap {
        assert!(arg2 == 0, 1);
        0x2::bls12381::g2_from_bytes(&arg3);
        let v0 = KeyServer{
            id            : 0x2::object::new(arg4),
            first_version : 1,
            last_version  : 1,
        };
        let v1 = KeyServerV1{
            name     : arg0,
            url      : arg1,
            key_type : arg2,
            pk       : arg3,
        };
        0x2::dynamic_field::add<u64, KeyServerV1>(&mut v0.id, 1, v1);
        let v2 = Cap{
            id            : 0x2::object::new(arg4),
            key_server_id : 0x2::object::id<KeyServer>(&v0),
        };
        0x2::transfer::share_object<KeyServer>(v0);
        v2
    }

    public fun key_type(arg0: &mut KeyServer) : u8 {
        v1(arg0).key_type
    }

    public fun name(arg0: &KeyServer) : 0x1::string::String {
        v1(arg0).name
    }

    public fun pk(arg0: &KeyServer) : &vector<u8> {
        &v1(arg0).pk
    }

    public fun pk_as_bf_bls12381(arg0: &KeyServer) : 0x2::group_ops::Element<0x2::bls12381::G2> {
        let v0 = v1(arg0);
        assert!(v0.key_type == 0, 1);
        0x2::bls12381::g2_from_bytes(&v0.pk)
    }

    public fun update(arg0: &mut KeyServer, arg1: &Cap, arg2: 0x1::string::String) {
        assert!(0x2::object::id<KeyServer>(arg0) == arg1.key_server_id, 0);
        assert!(0x2::dynamic_field::exists_<u64>(&arg0.id, 1), 2);
        0x2::dynamic_field::borrow_mut<u64, KeyServerV1>(&mut arg0.id, 1).url = arg2;
    }

    public fun url(arg0: &KeyServer) : 0x1::string::String {
        v1(arg0).url
    }

    public fun v1(arg0: &KeyServer) : &KeyServerV1 {
        assert!(0x2::dynamic_field::exists_<u64>(&arg0.id, 1), 2);
        0x2::dynamic_field::borrow<u64, KeyServerV1>(&arg0.id, 1)
    }

    // decompiled from Move bytecode v6
}

