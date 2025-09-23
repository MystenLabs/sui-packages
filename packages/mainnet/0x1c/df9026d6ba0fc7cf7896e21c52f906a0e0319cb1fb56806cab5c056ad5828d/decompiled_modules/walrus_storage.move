module 0x1cdf9026d6ba0fc7cf7896e21c52f906a0e0319cb1fb56806cab5c056ad5828d::walrus_storage {
    struct WalrusBlob has copy, drop, store {
        blob_id: 0x1::string::String,
        url: 0x2::url::Url,
        content_type: 0x1::string::String,
        size: u64,
    }

    public fun blob_to_display_url(arg0: &WalrusBlob) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"");
        0x1::string::append(&mut v0, 0x1::string::utf8(b"https://walrus.space/v1/"));
        0x1::string::append(&mut v0, arg0.blob_id);
        v0
    }

    public fun build_walrus_url(arg0: 0x1::string::String) : 0x2::url::Url {
        let v0 = 0x1::string::utf8(b"");
        0x1::string::append(&mut v0, 0x1::string::utf8(b"https://walrus.space/v1/"));
        0x1::string::append(&mut v0, arg0);
        0x2::url::new_unsafe(0x1::string::to_ascii(v0))
    }

    public fun get_blob_id(arg0: &WalrusBlob) : 0x1::string::String {
        arg0.blob_id
    }

    public fun get_content_type(arg0: &WalrusBlob) : 0x1::string::String {
        arg0.content_type
    }

    public fun get_size(arg0: &WalrusBlob) : u64 {
        arg0.size
    }

    public fun get_url(arg0: &WalrusBlob) : 0x2::url::Url {
        arg0.url
    }

    public fun is_valid_blob_id(arg0: &0x1::string::String) : bool {
        0x1::string::length(arg0) >= 32 && 0x1::string::length(arg0) <= 128
    }

    public fun new_image_blob(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: u64) : WalrusBlob {
        let v0 = 0x1::string::utf8(b"image/");
        0x1::string::append(&mut v0, arg1);
        new_walrus_blob(arg0, v0, arg2)
    }

    public fun new_metadata_blob(arg0: 0x1::string::String, arg1: u64) : WalrusBlob {
        new_walrus_blob(arg0, 0x1::string::utf8(b"application/json"), arg1)
    }

    public fun new_walrus_blob(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: u64) : WalrusBlob {
        WalrusBlob{
            blob_id      : arg0,
            url          : build_walrus_url(arg0),
            content_type : arg1,
            size         : arg2,
        }
    }

    // decompiled from Move bytecode v6
}

