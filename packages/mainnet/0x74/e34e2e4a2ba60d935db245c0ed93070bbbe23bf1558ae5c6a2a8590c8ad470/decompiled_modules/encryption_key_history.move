module 0xbcdf77f551f12be0fa61d1eb7bb2ff4169c1587aaa86fab84d95213cc75139f9::encryption_key_history {
    struct EditEncryptionKey has drop {
        dummy_field: bool,
    }

    struct EncryptionKeyHistory has store {
        latest: vector<u8>,
        latest_version: u32,
        history: 0x2::table_vec::TableVec<vector<u8>>,
    }

    public(friend) fun empty(arg0: &mut 0x2::tx_context::TxContext) : EncryptionKeyHistory {
        EncryptionKeyHistory{
            latest         : 0x1::vector::empty<u8>(),
            latest_version : 0,
            history        : 0x2::table_vec::empty<vector<u8>>(arg0),
        }
    }

    public(friend) fun has_encryption_key(arg0: &EncryptionKeyHistory) : bool {
        arg0.latest_version > 0 && !0x1::vector::is_empty<u8>(&arg0.latest)
    }

    public(friend) fun latest_key(arg0: &EncryptionKeyHistory) : vector<u8> {
        arg0.latest
    }

    public(friend) fun latest_key_version(arg0: &EncryptionKeyHistory) : u32 {
        arg0.latest_version
    }

    public(friend) fun rotate_key(arg0: &mut EncryptionKeyHistory, arg1: &0xbcdf77f551f12be0fa61d1eb7bb2ff4169c1587aaa86fab84d95213cc75139f9::auth::Auth, arg2: 0x2::object::ID, arg3: vector<u8>) {
        assert!(0xbcdf77f551f12be0fa61d1eb7bb2ff4169c1587aaa86fab84d95213cc75139f9::auth::has_permission<EditEncryptionKey>(arg1, arg2), 1);
        assert!(0x1::vector::length<u8>(&arg3) <= 512, 0);
        if (has_encryption_key(arg0)) {
            0x2::table_vec::push_back<vector<u8>>(&mut arg0.history, arg0.latest);
        };
        arg0.latest_version = arg0.latest_version + 1;
        arg0.latest = arg3;
    }

    // decompiled from Move bytecode v6
}

