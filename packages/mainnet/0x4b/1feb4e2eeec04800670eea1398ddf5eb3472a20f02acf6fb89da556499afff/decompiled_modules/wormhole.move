module 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::wormhole {
    struct WORMHOLE has drop {
        dummy_field: bool,
    }

    struct ProtectedEC has store, key {
        id: 0x2::object::UID,
        emitter_cap: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::emitter::EmitterCap,
    }

    public(friend) fun new(arg0: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = ProtectedEC{
            id          : 0x2::object::new(arg1),
            emitter_cap : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::emitter::new(arg0, arg1),
        };
        0x2::transfer::public_share_object<ProtectedEC>(v0);
    }

    public(friend) fun parse_and_verify_vaa(arg0: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg1: vector<u8>, arg2: u16, arg3: vector<u8>, arg4: vector<u8>, arg5: &0x2::clock::Clock) : (u64, vector<0x1::string::String>) {
        let v0 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg0, arg1, arg5);
        let (v1, v2, v3) = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::take_emitter_info_and_payload(v0);
        let v4 = 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::utils::convert_vaa_buffer_to_string(v3);
        assert!(arg2 == v1, 1);
        assert!(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::to_bytes(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::new(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes32::new(arg3))) == 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::to_bytes(v2), 2);
        assert!(*0x1::vector::borrow<0x1::string::String>(&v4, 0) == 0x1::string::utf8(b"21"), 3);
        assert!(0x1::string::utf8(arg4) == *0x1::vector::borrow<0x1::string::String>(&v4, 2), 4);
        let v5 = 0x1::vector::length<0x1::string::String>(&v4) - 1;
        let v6 = 0x1::vector::empty<0x1::string::String>();
        while (v5 > 2) {
            0x1::vector::push_back<0x1::string::String>(&mut v6, 0x1::vector::pop_back<0x1::string::String>(&mut v4));
            v5 = v5 - 1;
        };
        0x1::vector::reverse<0x1::string::String>(&mut v6);
        ((0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::timestamp(&v0) as u64), v6)
    }

    public(friend) fun send_message(arg0: &mut ProtectedEC, arg1: &mut 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg2: vector<u8>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0x2::clock::Clock) : u64 {
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::publish_message::publish_message(arg1, arg3, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::publish_message::prepare_message(&mut arg0.emitter_cap, 0, arg2), arg4)
    }

    // decompiled from Move bytecode v6
}

