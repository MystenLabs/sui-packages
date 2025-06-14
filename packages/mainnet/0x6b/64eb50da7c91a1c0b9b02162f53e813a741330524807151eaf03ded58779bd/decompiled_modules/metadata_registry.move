module 0x6b64eb50da7c91a1c0b9b02162f53e813a741330524807151eaf03ded58779bd::metadata_registry {
    struct NFTMetadata has store {
        background: 0x1::string::String,
        skin: 0x1::string::String,
        clothes: 0x1::string::String,
        hats: 0x1::string::String,
        eyewear: 0x1::string::String,
        mouth: 0x1::string::String,
        earrings: 0x1::string::String,
    }

    struct MetadataAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct MetadataRegistry has key {
        id: 0x2::object::UID,
        metadata: 0x2::table::Table<u64, NFTMetadata>,
        total_entries: u64,
    }

    struct MetadataAdded has copy, drop {
        metadata_id: u64,
        background: 0x1::string::String,
        skin: 0x1::string::String,
        clothes: 0x1::string::String,
        hats: 0x1::string::String,
        eyewear: 0x1::string::String,
        mouth: 0x1::string::String,
        earrings: 0x1::string::String,
    }

    struct METADATA_REGISTRY has drop {
        dummy_field: bool,
    }

    public entry fun add_metadata(arg0: &MetadataAdminCap, arg1: &mut MetadataRegistry, arg2: u64, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: vector<u8>, arg9: vector<u8>, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(!0x2::table::contains<u64, NFTMetadata>(&arg1.metadata, arg2), 1);
        let v0 = NFTMetadata{
            background : 0x1::string::utf8(arg3),
            skin       : 0x1::string::utf8(arg4),
            clothes    : 0x1::string::utf8(arg5),
            hats       : 0x1::string::utf8(arg6),
            eyewear    : 0x1::string::utf8(arg7),
            mouth      : 0x1::string::utf8(arg8),
            earrings   : 0x1::string::utf8(arg9),
        };
        0x2::table::add<u64, NFTMetadata>(&mut arg1.metadata, arg2, v0);
        arg1.total_entries = arg1.total_entries + 1;
        let v1 = MetadataAdded{
            metadata_id : arg2,
            background  : 0x1::string::utf8(arg3),
            skin        : 0x1::string::utf8(arg4),
            clothes     : 0x1::string::utf8(arg5),
            hats        : 0x1::string::utf8(arg6),
            eyewear     : 0x1::string::utf8(arg7),
            mouth       : 0x1::string::utf8(arg8),
            earrings    : 0x1::string::utf8(arg9),
        };
        0x2::event::emit<MetadataAdded>(v1);
    }

    public entry fun batch_add_metadata(arg0: &MetadataAdminCap, arg1: &mut MetadataRegistry, arg2: vector<u64>, arg3: vector<vector<u8>>, arg4: vector<vector<u8>>, arg5: vector<vector<u8>>, arg6: vector<vector<u8>>, arg7: vector<vector<u8>>, arg8: vector<vector<u8>>, arg9: vector<vector<u8>>, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<u64>(&arg2);
        assert!(v0 == 0x1::vector::length<vector<u8>>(&arg3), 2);
        assert!(v0 == 0x1::vector::length<vector<u8>>(&arg4), 2);
        assert!(v0 == 0x1::vector::length<vector<u8>>(&arg5), 2);
        assert!(v0 == 0x1::vector::length<vector<u8>>(&arg6), 2);
        assert!(v0 == 0x1::vector::length<vector<u8>>(&arg7), 2);
        assert!(v0 == 0x1::vector::length<vector<u8>>(&arg8), 2);
        assert!(v0 == 0x1::vector::length<vector<u8>>(&arg9), 2);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = *0x1::vector::borrow<u64>(&arg2, v1);
            assert!(!0x2::table::contains<u64, NFTMetadata>(&arg1.metadata, v2), 1);
            let v3 = NFTMetadata{
                background : 0x1::string::utf8(*0x1::vector::borrow<vector<u8>>(&arg3, v1)),
                skin       : 0x1::string::utf8(*0x1::vector::borrow<vector<u8>>(&arg4, v1)),
                clothes    : 0x1::string::utf8(*0x1::vector::borrow<vector<u8>>(&arg5, v1)),
                hats       : 0x1::string::utf8(*0x1::vector::borrow<vector<u8>>(&arg6, v1)),
                eyewear    : 0x1::string::utf8(*0x1::vector::borrow<vector<u8>>(&arg7, v1)),
                mouth      : 0x1::string::utf8(*0x1::vector::borrow<vector<u8>>(&arg8, v1)),
                earrings   : 0x1::string::utf8(*0x1::vector::borrow<vector<u8>>(&arg9, v1)),
            };
            0x2::table::add<u64, NFTMetadata>(&mut arg1.metadata, v2, v3);
            arg1.total_entries = arg1.total_entries + 1;
            v1 = v1 + 1;
        };
    }

    public fun get_metadata(arg0: &MetadataRegistry, arg1: u64) : (0x1::string::String, 0x1::string::String, 0x1::string::String, 0x1::string::String, 0x1::string::String, 0x1::string::String, 0x1::string::String) {
        assert!(0x2::table::contains<u64, NFTMetadata>(&arg0.metadata, arg1), 2);
        let v0 = 0x2::table::borrow<u64, NFTMetadata>(&arg0.metadata, arg1);
        (v0.background, v0.skin, v0.clothes, v0.hats, v0.eyewear, v0.mouth, v0.earrings)
    }

    public fun get_total_entries(arg0: &MetadataRegistry) : u64 {
        arg0.total_entries
    }

    fun init(arg0: METADATA_REGISTRY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = MetadataAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<MetadataAdminCap>(v0, 0x2::tx_context::sender(arg1));
        let v1 = MetadataRegistry{
            id            : 0x2::object::new(arg1),
            metadata      : 0x2::table::new<u64, NFTMetadata>(arg1),
            total_entries : 0,
        };
        0x2::transfer::share_object<MetadataRegistry>(v1);
    }

    public fun metadata_exists(arg0: &MetadataRegistry, arg1: u64) : bool {
        0x2::table::contains<u64, NFTMetadata>(&arg0.metadata, arg1)
    }

    // decompiled from Move bytecode v6
}

