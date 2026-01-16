module 0x9a814ab4f67fff8ec2a8bb1ddcf188b26119ae6866eea9f3f5d5e7eaf7a9c862::attachment {
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

