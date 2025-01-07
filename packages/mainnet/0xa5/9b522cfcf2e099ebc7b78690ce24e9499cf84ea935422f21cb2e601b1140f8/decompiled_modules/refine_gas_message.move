module 0xa59b522cfcf2e099ebc7b78690ce24e9499cf84ea935422f21cb2e601b1140f8::refine_gas_message {
    struct RefineGasMessage {
        cctp_nonce: u64,
        cctp_domain: u32,
        addr_unlocker: address,
        gas_drop: u64,
        addr_dest: address,
    }

    public(friend) fun deserialize(arg0: vector<u8>) : RefineGasMessage {
        assert!(0x1::vector::length<u8>(&arg0) == 86, 2);
        let v0 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::new<u8>(arg0);
        assert!(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::take_u8(&mut v0) == 5, 0);
        assert!(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::take_u8(&mut v0) == 1, 1);
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::destroy_empty<u8>(v0);
        RefineGasMessage{
            cctp_nonce    : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::take_u64_be(&mut v0),
            cctp_domain   : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::take_u32_be(&mut v0),
            addr_unlocker : 0x2::address::from_bytes(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::take_bytes(&mut v0, 32)),
            gas_drop      : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::take_u64_be(&mut v0),
            addr_dest     : 0x2::address::from_bytes(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::take_bytes(&mut v0, 32)),
        }
    }

    public(friend) fun unpack(arg0: RefineGasMessage) : (u64, u32, address, u64, address) {
        let RefineGasMessage {
            cctp_nonce    : v0,
            cctp_domain   : v1,
            addr_unlocker : v2,
            gas_drop      : v3,
            addr_dest     : v4,
        } = arg0;
        (v0, v1, v2, v3, v4)
    }

    // decompiled from Move bytecode v6
}

