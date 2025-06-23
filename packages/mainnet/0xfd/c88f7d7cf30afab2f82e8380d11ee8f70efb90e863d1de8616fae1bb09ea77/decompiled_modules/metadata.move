module 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::metadata {
    struct Metadata has drop, store {
        metadata: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    public fun remove(arg0: &mut Metadata, arg1: &0x1::string::String) : (0x1::string::String, 0x1::string::String) {
        0x2::vec_map::remove<0x1::string::String, 0x1::string::String>(&mut arg0.metadata, arg1)
    }

    public fun insert_or_update(arg0: &mut Metadata, arg1: 0x1::string::String, arg2: 0x1::string::String) {
        if (0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(&arg0.metadata, &arg1)) {
            let (_, _) = 0x2::vec_map::remove<0x1::string::String, 0x1::string::String>(&mut arg0.metadata, &arg1);
        };
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut arg0.metadata, arg1, arg2);
    }

    public fun new() : Metadata {
        Metadata{metadata: 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>()}
    }

    public fun remove_if_exists(arg0: &mut Metadata, arg1: &0x1::string::String) : 0x1::option::Option<0x1::string::String> {
        if (0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(&arg0.metadata, arg1)) {
            let (_, v2) = 0x2::vec_map::remove<0x1::string::String, 0x1::string::String>(&mut arg0.metadata, arg1);
            0x1::option::some<0x1::string::String>(v2)
        } else {
            0x1::option::none<0x1::string::String>()
        }
    }

    // decompiled from Move bytecode v6
}

