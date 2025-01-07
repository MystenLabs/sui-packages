module 0xd659e0480e75874a6407e6f1303de772d6ea52575e6f0b49e3af4b0011e4b9af::issuer {
    struct VisitorList has store, key {
        id: 0x2::object::UID,
        date: 0x1::string::String,
        expired_at: u64,
        visitors: 0x2::vec_set::VecSet<address>,
    }

    fun count_key() : 0x1::string::String {
        0x1::string::utf8(b"count")
    }

    public entry fun create_list(arg0: 0x1::string::String, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = VisitorList{
            id         : 0x2::object::new(arg2),
            date       : arg0,
            expired_at : arg1,
            visitors   : 0x2::vec_set::empty<address>(),
        };
        0x2::transfer::public_share_object<VisitorList>(v0);
    }

    fun date_key() : 0x1::string::String {
        0x1::string::utf8(b"date_list")
    }

    public entry fun mint(arg0: &mut VisitorList, arg1: &0x2::clock::Clock, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg1) < arg0.expired_at, 1004);
        0x2::vec_set::insert<address>(&mut arg0.visitors, 0x2::tx_context::sender(arg6));
        let v0 = 0xd659e0480e75874a6407e6f1303de772d6ea52575e6f0b49e3af4b0011e4b9af::nft::new(arg2, arg3, arg4, arg1, arg6);
        0x2::dynamic_field::add<0x1::string::String, u64>(0xd659e0480e75874a6407e6f1303de772d6ea52575e6f0b49e3af4b0011e4b9af::nft::uid_mut_as_owner(&mut v0), count_key(), 1);
        0x2::dynamic_field::add<0x1::string::String, 0x2::vec_set::VecSet<0x1::string::String>>(0xd659e0480e75874a6407e6f1303de772d6ea52575e6f0b49e3af4b0011e4b9af::nft::uid_mut_as_owner(&mut v0), date_key(), 0x2::vec_set::singleton<0x1::string::String>(arg5));
        0x2::transfer::public_transfer<0xd659e0480e75874a6407e6f1303de772d6ea52575e6f0b49e3af4b0011e4b9af::nft::CoCoNFT>(v0, 0x2::tx_context::sender(arg6));
    }

    // decompiled from Move bytecode v6
}

