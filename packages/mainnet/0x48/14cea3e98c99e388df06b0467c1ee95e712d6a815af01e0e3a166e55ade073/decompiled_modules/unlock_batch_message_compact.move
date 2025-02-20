module 0x4814cea3e98c99e388df06b0467c1ee95e712d6a815af01e0e3a166e55ade073::unlock_batch_message_compact {
    public(friend) fun deserialize(arg0: vector<u8>, arg1: vector<u8>) : 0x4814cea3e98c99e388df06b0467c1ee95e712d6a815af01e0e3a166e55ade073::unlock_batch_message::UnlockBatchMessage {
        assert!(0x1::vector::length<u8>(&arg0) == 35, 1);
        let v0 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::new<u8>(arg0);
        assert!(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::take_u8(&mut v0) == 5, 0);
        assert!(0x2::address::from_bytes(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::take_bytes(&mut v0, 32)) == 0x2::address::from_bytes(0x2::hash::keccak256(&arg1)), 2);
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::destroy_empty<u8>(v0);
        0x4814cea3e98c99e388df06b0467c1ee95e712d6a815af01e0e3a166e55ade073::unlock_batch_message::deserialize_items(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::new<u8>(arg1), 0x1::vector::length<u8>(&arg1), 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::take_u16_be(&mut v0))
    }

    public(friend) fun serialize(arg0: 0x4814cea3e98c99e388df06b0467c1ee95e712d6a815af01e0e3a166e55ade073::unlock_batch_message::UnlockBatchMessage) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::push_u8(&mut v0, 5);
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::push_u16_be(&mut v0, 0x4814cea3e98c99e388df06b0467c1ee95e712d6a815af01e0e3a166e55ade073::unlock_batch_message::get_items_count(&arg0));
        let v1 = 0x4814cea3e98c99e388df06b0467c1ee95e712d6a815af01e0e3a166e55ade073::unlock_batch_message::serialize_items(arg0);
        0x1::vector::append<u8>(&mut v0, 0x2::hash::keccak256(&v1));
        assert!(0x1::vector::length<u8>(&v0) == 35, 1);
        v0
    }

    // decompiled from Move bytecode v6
}

