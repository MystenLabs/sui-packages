module 0x53b01bd886755980da1c2c92f6dbb1713c0717045b7d40f19ec401bd3e13b3ee::deliver {
    struct DELIVER has drop {
        dummy_field: bool,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct GalxeNFT has store, key {
        id: 0x2::object::UID,
        version: u64,
        name: 0x1::string::String,
        cid: u64,
        image_url: 0x1::string::String,
    }

    struct GalxeTable has key {
        id: 0x2::object::UID,
        public_key: vector<u8>,
        treasurer: address,
        verify_ids: 0x2::table::Table<u64, bool>,
    }

    struct MintChallenge has drop {
        owner: address,
        name: 0x1::string::String,
        cid: u64,
        verify_id: u64,
        image_url: 0x1::string::String,
        expired_at: u64,
    }

    struct MintNFT has copy, drop {
        id: 0x2::object::ID,
        name: 0x1::string::String,
        cid: u64,
        verify_id: u64,
        owner: address,
        claim_fee_amount: u64,
    }

    fun consume_signature(arg0: &GalxeTable, arg1: &MintChallenge, arg2: &vector<u8>) {
        assert!(!0x2::table::contains<u64, bool>(&arg0.verify_ids, arg1.verify_id), 3);
        let v0 = 0x2::bcs::to_bytes<MintChallenge>(arg1);
        let v1 = 0x2::hash::keccak256(&v0);
        let v2 = arg0.public_key;
        assert!(0x2::ed25519::ed25519_verify(arg2, &v2, &v1) == true, 2);
    }

    fun init(arg0: DELIVER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v1, v0);
        let v2 = GalxeTable{
            id         : 0x2::object::new(arg1),
            public_key : x"bb3266b86640989d108bb6491f5b5de13d741419ecc39d14dfcca27f3e3abe39",
            treasurer  : @0x945150d87519d70ac7392b4c04d3e8c0bdb2ebf814ba1259cf22b0d0e91bb3a5,
            verify_ids : 0x2::table::new<u64, bool>(arg1),
        };
        0x2::transfer::share_object<GalxeTable>(v2);
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"cid"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"image_url"));
        let v5 = 0x1::vector::empty<0x1::string::String>();
        let v6 = &mut v5;
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"{cid}"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"{image_url}"));
        let v7 = 0x2::package::claim<DELIVER>(arg0, arg1);
        let v8 = 0x2::display::new_with_fields<GalxeNFT>(&v7, v3, v5, arg1);
        0x2::display::update_version<GalxeNFT>(&mut v8);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v7, v0);
        0x2::transfer::public_transfer<0x2::display::Display<GalxeNFT>>(v8, v0);
    }

    public fun is_verify_id_used(arg0: &GalxeTable, arg1: u64) : bool {
        0x2::table::contains<u64, bool>(&arg0.verify_ids, arg1)
    }

    public entry fun mint<T0>(arg0: &mut GalxeTable, arg1: address, arg2: 0x1::string::String, arg3: u64, arg4: u64, arg5: 0x1::string::String, arg6: u64, arg7: vector<u8>, arg8: &0x2::clock::Clock, arg9: 0x2::coin::Coin<T0>, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg8) <= arg6, 1);
        let v0 = MintChallenge{
            owner      : arg1,
            name       : arg2,
            cid        : arg3,
            verify_id  : arg4,
            image_url  : arg5,
            expired_at : arg6,
        };
        consume_signature(arg0, &v0, &arg7);
        let v1 = 0x2::object::new(arg10);
        let v2 = GalxeNFT{
            id        : v1,
            version   : 2,
            name      : arg2,
            cid       : arg3,
            image_url : arg5,
        };
        0x2::transfer::transfer<GalxeNFT>(v2, arg1);
        0x2::table::add<u64, bool>(&mut arg0.verify_ids, v0.verify_id, true);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg9, arg0.treasurer);
        let v3 = MintNFT{
            id               : 0x2::object::uid_to_inner(&v1),
            name             : arg2,
            cid              : arg3,
            verify_id        : arg4,
            owner            : arg1,
            claim_fee_amount : 0x2::coin::value<T0>(&arg9),
        };
        0x2::event::emit<MintNFT>(v3);
    }

    public entry fun update_public_key(arg0: &AdminCap, arg1: &mut GalxeTable, arg2: vector<u8>) {
        arg1.public_key = arg2;
    }

    // decompiled from Move bytecode v6
}

