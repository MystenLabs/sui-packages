module 0x9636e0c761e7476b8579cb13d543838e3732ca482dc0a64f086f57b60c024e23::key_server {
    struct KeyServer has store, key {
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

    entry fun create_and_transfer_v1(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: u8, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = create_v1(arg0, arg1, arg2, arg3, arg4);
        0x2::transfer::transfer<KeyServer>(v0, 0x2::tx_context::sender(arg4));
    }

    fun create_v1(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: u8, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) : KeyServer {
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
        v0
    }

    public fun id(arg0: &KeyServer) : address {
        0x2::object::uid_to_address(&arg0.id)
    }

    public fun key_type(arg0: &KeyServer) : u8 {
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

    public fun update(arg0: &mut KeyServer, arg1: 0x1::string::String) {
        assert!(0x2::dynamic_field::exists_<u64>(&arg0.id, 1), 2);
        0x2::dynamic_field::borrow_mut<u64, KeyServerV1>(&mut arg0.id, 1).url = arg1;
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

