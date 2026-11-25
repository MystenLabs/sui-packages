module 0xf0c6e0dda1508258943671e6275706615425952cf598c7e1ef7d08ea9986673b::so {
    struct SOPass has key {
        id: 0x2::object::UID,
        owner: address,
        nonce: u64,
    }

    struct SOAuthorization {
        voucher_id: address,
        pass_id: 0x2::object::ID,
        nonce: u64,
        max_so: u64,
        signer_version: u64,
    }

    struct SOPassCreated has copy, drop {
        pass_id: 0x2::object::ID,
        owner: address,
    }

    struct VoiceIntent has copy, drop {
        domain: vector<u8>,
        canvas_id: address,
        buyer: address,
        column: u16,
        row: u16,
        size: u8,
        text: vector<u8>,
        note: vector<u8>,
        max_total_mist: u64,
    }

    struct VoucherPayload has copy, drop {
        domain: vector<u8>,
        network_id: u8,
        package_id: address,
        canvas_id: address,
        buyer: address,
        so_pass_id: address,
        nonce: u64,
        intent_hash: vector<u8>,
        voucher_id: address,
        max_so: u64,
        expires_at_ms: u64,
        signer_version: u64,
    }

    struct BootstrapVoucherPayload has copy, drop {
        domain: vector<u8>,
        network_id: u8,
        package_id: address,
        canvas_id: address,
        buyer: address,
        intent_hash: vector<u8>,
        voucher_id: address,
        max_so: u64,
        expires_at_ms: u64,
        signer_version: u64,
    }

    public(friend) fun authorization_max_so(arg0: &SOAuthorization) : u64 {
        arg0.max_so
    }

    public(friend) fun authorization_nonce(arg0: &SOAuthorization) : u64 {
        arg0.nonce
    }

    public(friend) fun authorization_pass_id(arg0: &SOAuthorization) : 0x2::object::ID {
        arg0.pass_id
    }

    public(friend) fun authorization_signer_version(arg0: &SOAuthorization) : u64 {
        arg0.signer_version
    }

    public(friend) fun authorization_voucher_id(arg0: &SOAuthorization) : address {
        arg0.voucher_id
    }

    public(friend) fun authorize_voice_discount(arg0: &0xf0c6e0dda1508258943671e6275706615425952cf598c7e1ef7d08ea9986673b::canvas::Canvas, arg1: &mut SOPass, arg2: address, arg3: vector<u8>, arg4: address, arg5: u64, arg6: u64, arg7: u64, arg8: vector<u8>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : SOAuthorization {
        0xf0c6e0dda1508258943671e6275706615425952cf598c7e1ef7d08ea9986673b::canvas::assert_available(arg0, 0x2::clock::timestamp_ms(arg9));
        0xf0c6e0dda1508258943671e6275706615425952cf598c7e1ef7d08ea9986673b::canvas::assert_discounts_available(arg0);
        assert!(arg1.owner == arg2 && arg2 == 0x2::tx_context::sender(arg10), 0);
        assert!(arg4 != @0x0, 1);
        assert!(arg5 > 0, 2);
        assert!(0x2::clock::timestamp_ms(arg9) < arg6, 3);
        assert!(arg7 == 0xf0c6e0dda1508258943671e6275706615425952cf598c7e1ef7d08ea9986673b::canvas::discount_signer_version_internal(arg0), 4);
        assert!(0x1::vector::length<u8>(&arg8) == 64, 5);
        assert!(arg1.nonce < 18446744073709551615, 6);
        let v0 = 0x2::object::id<SOPass>(arg1);
        let v1 = arg1.nonce;
        let v2 = voucher_message(0xf0c6e0dda1508258943671e6275706615425952cf598c7e1ef7d08ea9986673b::canvas::network_id_internal(arg0), 0x2::object::id<0xf0c6e0dda1508258943671e6275706615425952cf598c7e1ef7d08ea9986673b::canvas::Canvas>(arg0), arg2, v0, v1, arg3, arg4, arg5, arg6, arg7);
        assert!(0x2::ed25519::ed25519_verify(&arg8, 0xf0c6e0dda1508258943671e6275706615425952cf598c7e1ef7d08ea9986673b::canvas::discount_signer_public_key_internal(arg0), &v2), 5);
        arg1.nonce = v1 + 1;
        SOAuthorization{
            voucher_id     : arg4,
            pass_id        : v0,
            nonce          : v1,
            max_so         : arg5,
            signer_version : arg7,
        }
    }

    fun bootstrap_voucher_message(arg0: u8, arg1: 0x2::object::ID, arg2: address, arg3: vector<u8>, arg4: address, arg5: u64, arg6: u64, arg7: u64) : vector<u8> {
        let v0 = BootstrapVoucherPayload{
            domain         : b"SAYSO_SO_VOICE_CREATE_WITH_PASS_V1",
            network_id     : arg0,
            package_id     : 0x1::type_name::original_id<0xf0c6e0dda1508258943671e6275706615425952cf598c7e1ef7d08ea9986673b::canvas::Canvas>(),
            canvas_id      : 0x2::object::id_to_address(&arg1),
            buyer          : arg2,
            intent_hash    : arg3,
            voucher_id     : arg4,
            max_so         : arg5,
            expires_at_ms  : arg6,
            signer_version : arg7,
        };
        0x1::bcs::to_bytes<BootstrapVoucherPayload>(&v0)
    }

    fun create_pass(arg0: &mut 0xf0c6e0dda1508258943671e6275706615425952cf598c7e1ef7d08ea9986673b::canvas::Canvas, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = SOPass{
            id    : 0x2::object::new(arg3),
            owner : arg1,
            nonce : arg2,
        };
        let v1 = 0x2::object::id<SOPass>(&v0);
        0xf0c6e0dda1508258943671e6275706615425952cf598c7e1ef7d08ea9986673b::canvas::register_so_pass(arg0, arg1, v1);
        let v2 = SOPassCreated{
            pass_id : v1,
            owner   : arg1,
        };
        0x2::event::emit<SOPassCreated>(v2);
        0x2::transfer::transfer<SOPass>(v0, arg1);
        v1
    }

    public(friend) fun create_pass_and_authorize_voice_discount(arg0: &mut 0xf0c6e0dda1508258943671e6275706615425952cf598c7e1ef7d08ea9986673b::canvas::Canvas, arg1: address, arg2: vector<u8>, arg3: address, arg4: u64, arg5: u64, arg6: u64, arg7: vector<u8>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : SOAuthorization {
        0xf0c6e0dda1508258943671e6275706615425952cf598c7e1ef7d08ea9986673b::canvas::assert_available(arg0, 0x2::clock::timestamp_ms(arg8));
        0xf0c6e0dda1508258943671e6275706615425952cf598c7e1ef7d08ea9986673b::canvas::assert_discounts_available(arg0);
        assert!(arg1 == 0x2::tx_context::sender(arg9), 0);
        assert!(arg3 != @0x0, 1);
        assert!(arg4 > 0, 2);
        assert!(0x2::clock::timestamp_ms(arg8) < arg5, 3);
        assert!(arg6 == 0xf0c6e0dda1508258943671e6275706615425952cf598c7e1ef7d08ea9986673b::canvas::discount_signer_version_internal(arg0), 4);
        assert!(0x1::vector::length<u8>(&arg7) == 64, 5);
        let v0 = bootstrap_voucher_message(0xf0c6e0dda1508258943671e6275706615425952cf598c7e1ef7d08ea9986673b::canvas::network_id_internal(arg0), 0x2::object::id<0xf0c6e0dda1508258943671e6275706615425952cf598c7e1ef7d08ea9986673b::canvas::Canvas>(arg0), arg1, arg2, arg3, arg4, arg5, arg6);
        assert!(0x2::ed25519::ed25519_verify(&arg7, 0xf0c6e0dda1508258943671e6275706615425952cf598c7e1ef7d08ea9986673b::canvas::discount_signer_public_key_internal(arg0), &v0), 5);
        SOAuthorization{
            voucher_id     : arg3,
            pass_id        : create_pass(arg0, arg1, 1, arg9),
            nonce          : 0,
            max_so         : arg4,
            signer_version : arg6,
        }
    }

    public(friend) fun destroy_authorization(arg0: SOAuthorization) {
        let SOAuthorization {
            voucher_id     : _,
            pass_id        : _,
            nonce          : _,
            max_so         : _,
            signer_version : _,
        } = arg0;
    }

    public(friend) fun voice_intent_hash(arg0: 0x2::object::ID, arg1: address, arg2: u16, arg3: u16, arg4: u8, arg5: &vector<u8>, arg6: &vector<u8>, arg7: u64) : vector<u8> {
        let v0 = VoiceIntent{
            domain         : b"SAYSO_VOICE_INTENT_V1",
            canvas_id      : 0x2::object::id_to_address(&arg0),
            buyer          : arg1,
            column         : arg2,
            row            : arg3,
            size           : arg4,
            text           : *arg5,
            note           : *arg6,
            max_total_mist : arg7,
        };
        let v1 = 0x1::bcs::to_bytes<VoiceIntent>(&v0);
        0x2::hash::blake2b256(&v1)
    }

    fun voucher_message(arg0: u8, arg1: 0x2::object::ID, arg2: address, arg3: 0x2::object::ID, arg4: u64, arg5: vector<u8>, arg6: address, arg7: u64, arg8: u64, arg9: u64) : vector<u8> {
        let v0 = VoucherPayload{
            domain         : b"SAYSO_SO_VOICE_CREATE_V1",
            network_id     : arg0,
            package_id     : 0x1::type_name::original_id<0xf0c6e0dda1508258943671e6275706615425952cf598c7e1ef7d08ea9986673b::canvas::Canvas>(),
            canvas_id      : 0x2::object::id_to_address(&arg1),
            buyer          : arg2,
            so_pass_id     : 0x2::object::id_to_address(&arg3),
            nonce          : arg4,
            intent_hash    : arg5,
            voucher_id     : arg6,
            max_so         : arg7,
            expires_at_ms  : arg8,
            signer_version : arg9,
        };
        0x1::bcs::to_bytes<VoucherPayload>(&v0)
    }

    // decompiled from Move bytecode v7
}

