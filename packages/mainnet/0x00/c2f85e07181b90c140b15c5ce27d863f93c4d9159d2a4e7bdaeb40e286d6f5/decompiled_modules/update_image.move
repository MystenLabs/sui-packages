module 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::update_image {
    struct UpdateImage has drop {
        dummy_field: bool,
    }

    entry fun update_image_url(arg0: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg1: &mut 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration, arg2: vector<u8>, arg3: vector<u8>, arg4: &0x2::clock::Clock) {
        0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::assert_app_is_authorized<UpdateImage>(arg0);
        0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::registry::assert_nft_is_authorized(0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::registry<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::registry::Registry>(arg0), arg1, arg4);
        assert!(0x2::ecdsa_k1::secp256k1_verify(&arg3, 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::config::public_key(0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::get_config<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::config::Config>(arg0)), &arg2, 1), 2);
        let (v0, v1, v2, _) = image_data_from_bcs(arg2);
        assert!(0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::expiration_timestamp_ms(arg1) == v2, 0);
        let v4 = 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::domain(arg1);
        assert!(0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::domain::to_string(&v4) == v1, 1);
        0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::update_image_url(arg1, v0);
    }

    fun image_data_from_bcs(arg0: vector<u8>) : (0x1::string::String, 0x1::string::String, u64, 0x1::string::String) {
        let v0 = 0x2::bcs::new(arg0);
        0x1::vector::destroy_empty<u8>(0x2::bcs::into_remainder_bytes(v0));
        (0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v0)), 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v0)), 0x2::bcs::peel_u64(&mut v0), 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v0)))
    }

    // decompiled from Move bytecode v6
}

