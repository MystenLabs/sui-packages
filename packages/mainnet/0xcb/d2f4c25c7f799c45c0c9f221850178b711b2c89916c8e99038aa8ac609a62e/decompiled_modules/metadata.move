module 0xcbd2f4c25c7f799c45c0c9f221850178b711b2c89916c8e99038aa8ac609a62e::metadata {
    struct MetadataKey has copy, drop, store {
        pos0: u64,
    }

    struct Metadata has copy, drop, store {
        name: 0x1::string::String,
        uuid: 0x1::string::String,
        creator: address,
        data: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    public fun creator(arg0: &Metadata) : address {
        arg0.creator
    }

    public fun data(arg0: &Metadata) : &0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String> {
        &arg0.data
    }

    public(friend) fun insert_data(arg0: &mut Metadata, arg1: 0x1::string::String, arg2: 0x1::string::String) {
        assert!(0x1::string::length(&arg1) <= 64, 1);
        assert!(0x1::string::length(&arg2) <= 256, 2);
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut arg0.data, arg1, arg2);
    }

    public fun key() : MetadataKey {
        MetadataKey{pos0: 1}
    }

    public fun name(arg0: &Metadata) : &0x1::string::String {
        &arg0.name
    }

    public(friend) fun new(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: address) : Metadata {
        assert!(0x1::string::length(&arg0) <= 128, 0);
        Metadata{
            name    : arg0,
            uuid    : arg1,
            creator : arg2,
            data    : 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>(),
        }
    }

    public(friend) fun remove_data(arg0: &mut Metadata, arg1: &0x1::string::String) : (0x1::string::String, 0x1::string::String) {
        0x2::vec_map::remove<0x1::string::String, 0x1::string::String>(&mut arg0.data, arg1)
    }

    public(friend) fun set_name(arg0: &mut Metadata, arg1: 0x1::string::String) {
        assert!(0x1::string::length(&arg1) <= 128, 0);
        arg0.name = arg1;
    }

    public fun uuid(arg0: &Metadata) : &0x1::string::String {
        &arg0.uuid
    }

    // decompiled from Move bytecode v6
}

