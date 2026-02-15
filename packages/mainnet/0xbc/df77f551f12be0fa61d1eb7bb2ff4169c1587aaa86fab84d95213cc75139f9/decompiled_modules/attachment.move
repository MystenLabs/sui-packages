module 0xbcdf77f551f12be0fa61d1eb7bb2ff4169c1587aaa86fab84d95213cc75139f9::attachment {
    struct Attachment has copy, drop, store {
        blob_ref: 0x1::string::String,
        encrypted_metadata: vector<u8>,
        data_nonce: vector<u8>,
        metadata_nonce: vector<u8>,
        key_version: u32,
    }

    public fun blob_ref(arg0: &Attachment) : 0x1::string::String {
        arg0.blob_ref
    }

    public fun data_nonce(arg0: &Attachment) : vector<u8> {
        arg0.data_nonce
    }

    public fun new(arg0: 0x1::string::String, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: u32) : Attachment {
        Attachment{
            blob_ref           : arg0,
            encrypted_metadata : arg1,
            data_nonce         : arg2,
            metadata_nonce     : arg3,
            key_version        : arg4,
        }
    }

    // decompiled from Move bytecode v6
}

