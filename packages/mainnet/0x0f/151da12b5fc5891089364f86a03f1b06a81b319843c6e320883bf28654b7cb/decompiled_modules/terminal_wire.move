module 0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::terminal_wire {
    struct AnchorContextMarker has drop {
        dummy_field: bool,
    }

    public fun anchor_context_id() : vector<u8> {
        0x2::address::to_bytes(0x1::type_name::original_id<AnchorContextMarker>())
    }

    public(friend) fun derive_anchor_domain_id(arg0: &vector<u8>, arg1: vector<u8>) : vector<u8> {
        assert!(0x1::vector::length<u8>(arg0) == 32, 13906834414862467087);
        let v0 = *arg0;
        0x1::vector::append<u8>(&mut v0, 0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::signature::u64_to_be_bytes(0x1::vector::length<u8>(&arg1)));
        0x1::vector::append<u8>(&mut v0, arg1);
        digest_framed(b"arena_tunnel::anchor_domain_id_v1", &v0)
    }

    fun digest_anchor_consent(arg0: vector<u8>, arg1: &vector<u8>) : vector<u8> {
        let v0 = anchor_context_id();
        digest_framed(derive_anchor_domain_id(&v0, arg0), arg1)
    }

    public fun digest_checkpoint(arg0: &vector<u8>) : vector<u8> {
        digest_anchor_consent(b"arena_tunnel::state_update", arg0)
    }

    public fun digest_dispute_opening(arg0: &vector<u8>) : vector<u8> {
        digest_anchor_consent(b"arena_tunnel::dispute_opening", arg0)
    }

    public(friend) fun digest_framed(arg0: vector<u8>, arg1: &vector<u8>) : vector<u8> {
        let v0 = 0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::signature::u64_to_be_bytes(0x1::vector::length<u8>(&arg0));
        0x1::vector::append<u8>(&mut v0, arg0);
        0x1::vector::append<u8>(&mut v0, 0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::signature::u64_to_be_bytes(0x1::vector::length<u8>(arg1)));
        0x1::vector::append<u8>(&mut v0, *arg1);
        0x2::hash::blake2b256(&v0)
    }

    public fun digest_referee_disposition(arg0: &vector<u8>) : vector<u8> {
        digest_anchor_consent(b"arena_tunnel::referee_disposition", arg0)
    }

    public fun digest_resolution_policy(arg0: &vector<u8>) : vector<u8> {
        digest_anchor_consent(b"arena_tunnel::resolution_policy", arg0)
    }

    public fun digest_settlement(arg0: &vector<u8>) : vector<u8> {
        digest_anchor_consent(b"arena_tunnel::settlement", arg0)
    }

    public fun digest_void_disposition(arg0: &vector<u8>) : vector<u8> {
        digest_anchor_consent(b"arena_tunnel::void_disposition", arg0)
    }

    public fun encode_dispute_opening(arg0: vector<u8>, arg1: u64) : vector<u8> {
        assert!(0x1::vector::length<u8>(&arg0) == 32, 13906834857243836427);
        let v0 = u16_to_be_bytes(1);
        0x1::vector::append<u8>(&mut v0, arg0);
        0x1::vector::append<u8>(&mut v0, 0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::signature::u64_to_be_bytes(arg1));
        v0
    }

    public fun encode_resolution_policy(arg0: vector<u8>, arg1: u64, arg2: u8, arg3: &vector<u8>) : vector<u8> {
        assert!(0x1::vector::length<u8>(&arg0) == 32, 13906834719804882955);
        assert!(0x1::vector::length<u8>(arg3) <= 65535, 13906834724099850251);
        let v0 = u16_to_be_bytes(1);
        0x1::vector::append<u8>(&mut v0, arg0);
        0x1::vector::append<u8>(&mut v0, 0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::signature::u64_to_be_bytes(arg1));
        0x1::vector::push_back<u8>(&mut v0, arg2);
        0x1::vector::append<u8>(&mut v0, u16_to_be_bytes((0x1::vector::length<u8>(arg3) as u16)));
        0x1::vector::append<u8>(&mut v0, *arg3);
        v0
    }

    public fun encode_terminal_state(arg0: vector<u8>, arg1: vector<u8>, arg2: u64, arg3: u64, arg4: vector<u8>, arg5: u64, arg6: u16, arg7: &vector<u16>, arg8: &vector<u64>, arg9: &vector<u8>) : vector<u8> {
        assert!(0x1::vector::length<u16>(arg7) == 0x1::vector::length<u64>(arg8), 13906834530826190857);
        assert!(0x1::vector::length<u8>(&arg0) == 32, 13906834560891093003);
        assert!(0x1::vector::length<u8>(&arg1) == 32, 13906834565186060299);
        assert!(0x1::vector::length<u8>(&arg4) == 32, 13906834569481027595);
        assert!(0x1::vector::length<u16>(arg7) <= 65535, 13906834573776125965);
        assert!(0x1::vector::length<u8>(arg9) <= 4096, 13906834578071355409);
        assert!(arg6 == 0 == 0x1::vector::is_empty<u8>(arg9), 13906834582366453779);
        let v0 = u16_to_be_bytes(1);
        0x1::vector::append<u8>(&mut v0, arg0);
        0x1::vector::append<u8>(&mut v0, arg1);
        0x1::vector::append<u8>(&mut v0, 0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::signature::u64_to_be_bytes(arg2));
        0x1::vector::append<u8>(&mut v0, 0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::signature::u64_to_be_bytes(arg3));
        0x1::vector::append<u8>(&mut v0, arg4);
        0x1::vector::append<u8>(&mut v0, 0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::signature::u64_to_be_bytes(arg5));
        0x1::vector::append<u8>(&mut v0, u16_to_be_bytes(arg6));
        0x1::vector::append<u8>(&mut v0, u16_to_be_bytes((0x1::vector::length<u16>(arg7) as u16)));
        let v1 = 0;
        while (v1 < 0x1::vector::length<u16>(arg7)) {
            0x1::vector::append<u8>(&mut v0, u16_to_be_bytes(*0x1::vector::borrow<u16>(arg7, v1)));
            0x1::vector::append<u8>(&mut v0, 0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::signature::u64_to_be_bytes(*0x1::vector::borrow<u64>(arg8, v1)));
            v1 = v1 + 1;
        };
        0x1::vector::append<u8>(&mut v0, u16_to_be_bytes((0x1::vector::length<u8>(arg9) as u16)));
        0x1::vector::append<u8>(&mut v0, *arg9);
        v0
    }

    public fun encode_void_disposition(arg0: vector<u8>) : vector<u8> {
        assert!(0x1::vector::length<u8>(&arg0) == 32, 13906834934553247755);
        let v0 = u16_to_be_bytes(1);
        0x1::vector::append<u8>(&mut v0, arg0);
        v0
    }

    public(friend) fun u16_to_be_bytes(arg0: u16) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = &mut v0;
        0x1::vector::push_back<u8>(v1, ((arg0 >> 8 & 255) as u8));
        0x1::vector::push_back<u8>(v1, ((arg0 & 255) as u8));
        v0
    }

    // decompiled from Move bytecode v7
}

