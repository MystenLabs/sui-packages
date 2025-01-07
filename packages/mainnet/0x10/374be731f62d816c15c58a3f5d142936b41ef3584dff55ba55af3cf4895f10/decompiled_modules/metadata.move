module 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::metadata {
    struct TextMetadata has copy, drop, store {
        text: vector<u8>,
        timestamp_ms: u64,
        miner: address,
    }

    public fun decode_text_metadata(arg0: &0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Metadata) : TextMetadata {
        let v0 = 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::metadata_content_type(arg0);
        assert!(0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::content_type::is_bcs(&v0), 1);
        assert!(0x1::option::destroy_with_default<0x1::ascii::String>(0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::content_type::get_bcs_type_name(&v0), 0x1::ascii::string(b"")) == 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::type_util::type_to_name<TextMetadata>(), 2);
        let v1 = 0x2::bcs::new(0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::metadata_content(arg0));
        TextMetadata{
            text         : 0x2::bcs::peel_vec_u8(&mut v1),
            timestamp_ms : 0x2::bcs::peel_u64(&mut v1),
            miner        : 0x2::bcs::peel_address(&mut v1),
        }
    }

    public fun new_ascii_metadata(arg0: 0x1::ascii::String, arg1: u64, arg2: address) : TextMetadata {
        TextMetadata{
            text         : 0x1::ascii::into_bytes(arg0),
            timestamp_ms : arg1,
            miner        : arg2,
        }
    }

    public fun new_string_metadata(arg0: 0x1::string::String, arg1: u64, arg2: address) : TextMetadata {
        TextMetadata{
            text         : *0x1::string::bytes(&arg0),
            timestamp_ms : arg1,
            miner        : arg2,
        }
    }

    public fun text_metadata_miner(arg0: &TextMetadata) : address {
        arg0.miner
    }

    public fun text_metadata_text(arg0: &TextMetadata) : &vector<u8> {
        &arg0.text
    }

    public fun text_metadata_timestamp(arg0: &TextMetadata) : u64 {
        arg0.timestamp_ms
    }

    public fun unpack_text_metadata(arg0: TextMetadata) : (vector<u8>, u64, address) {
        let TextMetadata {
            text         : v0,
            timestamp_ms : v1,
            miner        : v2,
        } = arg0;
        (v0, v1, v2)
    }

    // decompiled from Move bytecode v6
}

