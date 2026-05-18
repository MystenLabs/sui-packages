module 0x948e8d5c42de14a22487e6fa46acdbcba363efbd6e4619c1cf84c84720ba4558::branding {
    struct BrandingAssetRegistered has copy, drop {
        form_id: 0x2::object::ID,
        asset_id: 0x2::object::ID,
        asset_type: u8,
        blob_id: vector<u8>,
        owner: address,
    }

    struct BrandingAssetUpdated has copy, drop {
        form_id: 0x2::object::ID,
        asset_id: 0x2::object::ID,
        old_blob_id: vector<u8>,
        new_blob_id: vector<u8>,
        updated_by: address,
    }

    struct BrandingAssetRemoved has copy, drop {
        form_id: 0x2::object::ID,
        asset_id: 0x2::object::ID,
        asset_type: u8,
        removed_by: address,
    }

    struct BrandingAsset has key {
        id: 0x2::object::UID,
        form_id: 0x2::object::ID,
        asset_type: u8,
        blob_id: vector<u8>,
        mime_type_hint: 0x1::string::String,
        uploaded_at: u64,
        owner: address,
    }

    public fun asset_type(arg0: &BrandingAsset) : u8 {
        arg0.asset_type
    }

    public fun blob_id(arg0: &BrandingAsset) : vector<u8> {
        arg0.blob_id
    }

    public fun form_id(arg0: &BrandingAsset) : 0x2::object::ID {
        arg0.form_id
    }

    public fun mime_type_hint(arg0: &BrandingAsset) : 0x1::string::String {
        arg0.mime_type_hint
    }

    public fun owner(arg0: &BrandingAsset) : address {
        arg0.owner
    }

    entry fun register_branding_asset(arg0: &0x948e8d5c42de14a22487e6fa46acdbcba363efbd6e4619c1cf84c84720ba4558::form::FormOwnerCap, arg1: &0x948e8d5c42de14a22487e6fa46acdbcba363efbd6e4619c1cf84c84720ba4558::form::Form, arg2: u8, arg3: vector<u8>, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) {
        0x948e8d5c42de14a22487e6fa46acdbcba363efbd6e4619c1cf84c84720ba4558::form::verify_cap(arg0, arg1);
        assert!(0x1::vector::length<u8>(&arg3) == 32, 4);
        validate_asset_type(arg2);
        validate_mime_type(&arg4);
        let v0 = 0x948e8d5c42de14a22487e6fa46acdbcba363efbd6e4619c1cf84c84720ba4558::form::id(arg1);
        let v1 = 0x2::tx_context::sender(arg5);
        let v2 = BrandingAsset{
            id             : 0x2::object::new(arg5),
            form_id        : v0,
            asset_type     : arg2,
            blob_id        : arg3,
            mime_type_hint : arg4,
            uploaded_at    : 0x2::tx_context::epoch(arg5),
            owner          : v1,
        };
        let v3 = BrandingAssetRegistered{
            form_id    : v0,
            asset_id   : 0x2::object::uid_to_inner(&v2.id),
            asset_type : arg2,
            blob_id    : v2.blob_id,
            owner      : v1,
        };
        0x2::event::emit<BrandingAssetRegistered>(v3);
        0x2::transfer::transfer<BrandingAsset>(v2, v1);
    }

    entry fun remove_branding_asset(arg0: &0x948e8d5c42de14a22487e6fa46acdbcba363efbd6e4619c1cf84c84720ba4558::form::FormOwnerCap, arg1: BrandingAsset, arg2: &0x2::tx_context::TxContext) {
        assert!(arg1.form_id == 0x948e8d5c42de14a22487e6fa46acdbcba363efbd6e4619c1cf84c84720ba4558::form::cap_form_id(arg0), 22);
        let BrandingAsset {
            id             : v0,
            form_id        : _,
            asset_type     : _,
            blob_id        : _,
            mime_type_hint : _,
            uploaded_at    : _,
            owner          : _,
        } = arg1;
        0x2::object::delete(v0);
        let v7 = BrandingAssetRemoved{
            form_id    : arg1.form_id,
            asset_id   : 0x2::object::uid_to_inner(&arg1.id),
            asset_type : arg1.asset_type,
            removed_by : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<BrandingAssetRemoved>(v7);
    }

    entry fun update_branding_asset(arg0: &0x948e8d5c42de14a22487e6fa46acdbcba363efbd6e4619c1cf84c84720ba4558::form::FormOwnerCap, arg1: &mut BrandingAsset, arg2: vector<u8>, arg3: &0x2::tx_context::TxContext) {
        assert!(arg1.form_id == 0x948e8d5c42de14a22487e6fa46acdbcba363efbd6e4619c1cf84c84720ba4558::form::cap_form_id(arg0), 22);
        assert!(0x1::vector::length<u8>(&arg2) == 32, 4);
        arg1.blob_id = arg2;
        let v0 = BrandingAssetUpdated{
            form_id     : arg1.form_id,
            asset_id    : 0x2::object::uid_to_inner(&arg1.id),
            old_blob_id : arg1.blob_id,
            new_blob_id : arg2,
            updated_by  : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<BrandingAssetUpdated>(v0);
    }

    public fun uploaded_at(arg0: &BrandingAsset) : u64 {
        arg0.uploaded_at
    }

    fun validate_asset_type(arg0: u8) {
        let v0 = if (arg0 == 0) {
            true
        } else if (arg0 == 1) {
            true
        } else {
            arg0 == 2
        };
        assert!(v0, 17);
    }

    fun validate_mime_type(arg0: &0x1::string::String) {
        let v0 = 0x1::string::as_bytes(arg0);
        let v1 = b"image/png";
        let v2 = b"image/jpeg";
        let v3 = b"image/webp";
        let v4 = b"image/svg+xml";
        let v5 = b"image/gif";
        let v6 = b"image/x-icon";
        let v7 = if (v0 == &v1) {
            true
        } else if (v0 == &v2) {
            true
        } else if (v0 == &v3) {
            true
        } else if (v0 == &v4) {
            true
        } else if (v0 == &v5) {
            true
        } else {
            v0 == &v6
        };
        assert!(v7, 18);
    }

    // decompiled from Move bytecode v6
}

