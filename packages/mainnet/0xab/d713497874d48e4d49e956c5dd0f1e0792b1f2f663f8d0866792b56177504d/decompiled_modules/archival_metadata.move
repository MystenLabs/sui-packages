module 0xabd713497874d48e4d49e956c5dd0f1e0792b1f2f663f8d0866792b56177504d::archival_metadata {
    struct MetadataBlobPointer has key {
        id: 0x2::object::UID,
        blob_id: 0x1::option::Option<vector<u8>>,
    }

    public fun clear_metadata_blob_pointer(arg0: &0xabd713497874d48e4d49e956c5dd0f1e0792b1f2f663f8d0866792b56177504d::admin::AdminCap, arg1: &mut MetadataBlobPointer) {
        arg1.blob_id = 0x1::option::none<vector<u8>>();
    }

    public fun create_metadata_pointer(arg0: &0xabd713497874d48e4d49e956c5dd0f1e0792b1f2f663f8d0866792b56177504d::admin::AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = MetadataBlobPointer{
            id      : 0x2::object::new(arg1),
            blob_id : 0x1::option::none<vector<u8>>(),
        };
        0x2::transfer::share_object<MetadataBlobPointer>(v0);
    }

    public fun delete_metadata_blob_pointer(arg0: &0xabd713497874d48e4d49e956c5dd0f1e0792b1f2f663f8d0866792b56177504d::admin::AdminCap, arg1: MetadataBlobPointer) {
        let MetadataBlobPointer {
            id      : v0,
            blob_id : _,
        } = arg1;
        0x2::object::delete(v0);
    }

    public fun get_blob_id(arg0: &MetadataBlobPointer) : &0x1::option::Option<vector<u8>> {
        &arg0.blob_id
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MetadataBlobPointer{
            id      : 0x2::object::new(arg0),
            blob_id : 0x1::option::none<vector<u8>>(),
        };
        0x2::transfer::share_object<MetadataBlobPointer>(v0);
    }

    public fun update_metadata_blob_pointer(arg0: &0xabd713497874d48e4d49e956c5dd0f1e0792b1f2f663f8d0866792b56177504d::admin::AdminCap, arg1: &mut MetadataBlobPointer, arg2: vector<u8>) {
        assert!(0x1::vector::length<u8>(&arg2) == 32, 0);
        arg1.blob_id = 0x1::option::some<vector<u8>>(arg2);
    }

    // decompiled from Move bytecode v6
}

