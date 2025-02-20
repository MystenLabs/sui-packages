module 0x78b8c91ec5321bce57bdcbf12c8a2d7b5055afcff63ccf5572926ee197801520::keystore {
    struct KEYSTORE has drop {
        dummy_field: bool,
    }

    struct PublicKeyInfo has copy, drop, store {
        key_id: 0x1::string::String,
        public_key: 0x1::string::String,
    }

    struct KeystoreRecord has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        public_keys: vector<PublicKeyInfo>,
        image_url: 0x1::string::String,
        creator: 0x1::string::String,
        metadata: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    struct KeystoreCreated has copy, drop {
        id: 0x2::object::ID,
        name: 0x1::string::String,
    }

    struct KeystoreUpdated has copy, drop {
        id: 0x2::object::ID,
    }

    struct KeystoreDeleted has copy, drop {
        id: 0x2::object::ID,
    }

    public fun add_metadata(arg0: &mut KeystoreRecord, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut arg0.metadata, arg1, arg2);
        let v0 = KeystoreUpdated{id: 0x2::object::id<KeystoreRecord>(arg0)};
        0x2::event::emit<KeystoreUpdated>(v0);
    }

    public fun compute_key_id(arg0: &vector<u8>) : vector<u8> {
        assert!(0x1::vector::length<u8>(arg0) >= 50, 1);
        0x1::hash::sha2_256(*arg0)
    }

    public fun delete_keystore(arg0: KeystoreRecord, arg1: &mut 0x2::tx_context::TxContext) {
        let KeystoreRecord {
            id          : v0,
            name        : _,
            public_keys : _,
            image_url   : _,
            creator     : _,
            metadata    : _,
        } = arg0;
        0x2::object::delete(v0);
        let v6 = KeystoreDeleted{id: 0x2::object::id<KeystoreRecord>(&arg0)};
        0x2::event::emit<KeystoreDeleted>(v6);
    }

    fun init(arg0: KEYSTORE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Certificate Registry is a decentralized keystore for storing and managing public keys and metadata."));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://karrier.one"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{creator}"));
        let v4 = 0x2::package::claim<KEYSTORE>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<KeystoreRecord>(&v4, v0, v2, arg1);
        0x2::display::update_version<KeystoreRecord>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<KeystoreRecord>>(v5, 0x2::tx_context::sender(arg1));
    }

    public fun register_keystore(arg0: vector<0x1::string::String>, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = KeystoreRecord{
            id          : 0x2::object::new(arg5),
            name        : arg2,
            public_keys : transform_public_keys(arg0),
            image_url   : arg1,
            creator     : arg3,
            metadata    : arg4,
        };
        let v1 = KeystoreCreated{
            id   : 0x2::object::id<KeystoreRecord>(&v0),
            name : v0.name,
        };
        0x2::event::emit<KeystoreCreated>(v1);
        0x2::transfer::public_transfer<KeystoreRecord>(v0, 0x2::tx_context::sender(arg5));
    }

    public fun remove_metadata(arg0: &mut KeystoreRecord, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        let (_, _) = 0x2::vec_map::remove<0x1::string::String, 0x1::string::String>(&mut arg0.metadata, &arg1);
        let v2 = KeystoreUpdated{id: 0x2::object::id<KeystoreRecord>(arg0)};
        0x2::event::emit<KeystoreUpdated>(v2);
    }

    public fun setup_display<T0: key>(arg0: &0x2::package::Publisher, arg1: vector<0x1::string::String>, arg2: vector<0x1::string::String>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::display::Display<T0> {
        assert!(0x2::package::from_package<T0>(arg0), 0);
        let v0 = 0x2::display::new_with_fields<T0>(arg0, arg1, arg2, arg3);
        0x2::display::update_version<T0>(&mut v0);
        v0
    }

    public fun transform_public_keys(arg0: vector<0x1::string::String>) : vector<PublicKeyInfo> {
        let v0 = 0x1::vector::empty<PublicKeyInfo>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::string::String>(&arg0)) {
            let v2 = *0x1::vector::borrow<0x1::string::String>(&arg0, v1);
            let v3 = 0x1::string::utf8(0x2::hex::encode(compute_key_id(0x1::string::as_bytes(&v2))));
            let v4 = PublicKeyInfo{
                key_id     : 0x1::string::substring(&v3, 0, 32),
                public_key : v2,
            };
            0x1::vector::push_back<PublicKeyInfo>(&mut v0, v4);
            v1 = v1 + 1;
        };
        v0
    }

    public fun update_details(arg0: &mut KeystoreRecord, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        arg0.image_url = arg1;
        arg0.name = arg2;
        arg0.creator = arg3;
        let v0 = KeystoreUpdated{id: 0x2::object::id<KeystoreRecord>(arg0)};
        0x2::event::emit<KeystoreUpdated>(v0);
    }

    public fun update_keystore_key(arg0: &mut KeystoreRecord, arg1: vector<0x1::string::String>, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.public_keys = transform_public_keys(arg1);
        let v0 = KeystoreUpdated{id: 0x2::object::id<KeystoreRecord>(arg0)};
        0x2::event::emit<KeystoreUpdated>(v0);
    }

    public fun update_metadata(arg0: &mut KeystoreRecord, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        *0x2::vec_map::get_mut<0x1::string::String, 0x1::string::String>(&mut arg0.metadata, &arg1) = arg2;
        let v0 = KeystoreUpdated{id: 0x2::object::id<KeystoreRecord>(arg0)};
        0x2::event::emit<KeystoreUpdated>(v0);
    }

    public fun upsert_metadata(arg0: &mut KeystoreRecord, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        if (!0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(&arg0.metadata, &arg1)) {
            add_metadata(arg0, arg1, arg2, arg3);
        } else {
            update_metadata(arg0, arg1, arg2, arg3);
        };
    }

    // decompiled from Move bytecode v6
}

