module 0xc576f72b124f4ee6953ed04cbefc267d36905d80570a8d109d7421fafcc0ba63::endless_walrus_item {
    struct EndlessWalrusItem has store {
        bytes: 0x1::option::Option<vector<u8>>,
        blob: 0x1::option::Option<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>,
        meta: vector<u8>,
    }

    public fun burn_item(arg0: EndlessWalrusItem) {
        let EndlessWalrusItem {
            bytes : v0,
            blob  : v1,
            meta  : _,
        } = arg0;
        let v3 = v1;
        let v4 = v0;
        if (0x1::option::is_some<vector<u8>>(&v4)) {
            0x1::option::destroy_some<vector<u8>>(v4);
        } else {
            0x1::option::destroy_none<vector<u8>>(v4);
        };
        if (0x1::option::is_some<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(&v3)) {
            0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::burn(0x1::option::destroy_some<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(v3));
        } else {
            0x1::option::destroy_none<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(v3);
        };
    }

    public fun destroy_item_into_blob(arg0: EndlessWalrusItem) : 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob {
        let EndlessWalrusItem {
            bytes : v0,
            blob  : v1,
            meta  : _,
        } = arg0;
        let v3 = v0;
        if (0x1::option::is_some<vector<u8>>(&v3)) {
            0x1::option::destroy_some<vector<u8>>(v3);
        } else {
            0x1::option::destroy_none<vector<u8>>(v3);
        };
        0x1::option::destroy_some<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(v1)
    }

    public fun destroy_item_into_bytes(arg0: EndlessWalrusItem) : vector<u8> {
        let EndlessWalrusItem {
            bytes : v0,
            blob  : v1,
            meta  : _,
        } = arg0;
        let v3 = v1;
        let v4 = v0;
        if (0x1::option::is_some<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(&v3)) {
            abort 99
        };
        0x1::option::destroy_none<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(v3);
        if (0x1::option::is_some<vector<u8>>(&v4)) {
            return 0x1::option::destroy_some<vector<u8>>(v4)
        } else {
            0x1::option::destroy_none<vector<u8>>(v4);
            abort 98
        };
    }

    public fun item_binary_length(arg0: &EndlessWalrusItem) : u64 {
        if (0x1::option::is_some<vector<u8>>(&arg0.bytes)) {
            0x1::vector::length<u8>(0x1::option::borrow<vector<u8>>(&arg0.bytes))
        } else if (0x1::option::is_some<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(&arg0.blob)) {
            0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::size(0x1::option::borrow<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(&arg0.blob))
        } else {
            0
        }
    }

    public fun item_borrow_blob(arg0: &EndlessWalrusItem) : &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob {
        0x1::option::borrow<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(&arg0.blob)
    }

    public fun item_borrow_blob_mut(arg0: &mut EndlessWalrusItem) : &mut 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob {
        0x1::option::borrow_mut<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(&mut arg0.blob)
    }

    public fun item_borrow_bytes(arg0: &EndlessWalrusItem) : &vector<u8> {
        0x1::option::borrow<vector<u8>>(&arg0.bytes)
    }

    public fun item_borrow_meta(arg0: &EndlessWalrusItem) : &vector<u8> {
        &arg0.meta
    }

    public fun item_has_blob(arg0: &EndlessWalrusItem) : bool {
        0x1::option::is_some<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(&arg0.blob)
    }

    public fun item_has_bytes(arg0: &EndlessWalrusItem) : bool {
        0x1::option::is_some<vector<u8>>(&arg0.bytes)
    }

    public fun item_is_empty(arg0: &EndlessWalrusItem) : bool {
        0x1::option::is_none<vector<u8>>(&arg0.bytes) && 0x1::option::is_none<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(&arg0.blob)
    }

    public fun item_set_meta(arg0: &mut EndlessWalrusItem, arg1: vector<u8>) {
        arg0.meta = arg1;
    }

    public fun item_storage_volume(arg0: &EndlessWalrusItem) : u64 {
        let v0 = if (0x1::option::is_some<vector<u8>>(&arg0.bytes)) {
            0x1::vector::length<u8>(0x1::option::borrow<vector<u8>>(&arg0.bytes))
        } else if (0x1::option::is_some<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(&arg0.blob)) {
            32
        } else {
            0
        };
        v0 + 0x1::vector::length<u8>(&arg0.meta)
    }

    public fun new_blob_item(arg0: 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob) : EndlessWalrusItem {
        EndlessWalrusItem{
            bytes : 0x1::option::none<vector<u8>>(),
            blob  : 0x1::option::some<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(arg0),
            meta  : 0x1::vector::empty<u8>(),
        }
    }

    public fun new_bytes_item(arg0: vector<u8>) : EndlessWalrusItem {
        EndlessWalrusItem{
            bytes : 0x1::option::some<vector<u8>>(arg0),
            blob  : 0x1::option::none<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(),
            meta  : 0x1::vector::empty<u8>(),
        }
    }

    public fun new_empty_item() : EndlessWalrusItem {
        EndlessWalrusItem{
            bytes : 0x1::option::none<vector<u8>>(),
            blob  : 0x1::option::none<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(),
            meta  : 0x1::vector::empty<u8>(),
        }
    }

    // decompiled from Move bytecode v7
}

