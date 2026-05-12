module 0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::reaction {
    struct ReactionRecorded has copy, drop {
        reaction_kind: 0x1::string::String,
        challenge_id: 0x2::object::ID,
        cheerer_account: 0x2::object::ID,
        recipient_account: 0x2::object::ID,
        cheerer_has_pass: bool,
        giver_rep_delta: u64,
        receiver_rep_delta: u64,
        oracle_pubkey: vector<u8>,
        timestamp: u64,
    }

    struct ReactionsPurchased has copy, drop {
        buyer_account: 0x2::object::ID,
        quantity: u64,
        oracle_pubkey: vector<u8>,
        timestamp: u64,
    }

    fun assert_oracle_signature_valid(arg0: &0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::zenko::ZenkoRegistry, arg1: &vector<u8>, arg2: &vector<u8>) {
        assert!(0x1::vector::length<u8>(arg1) == 64, 1);
        assert!(0x1::vector::length<u8>(arg2) == 33, 2);
        assert!(0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::zenko::is_oracle_authorized(arg0, *arg2), 5);
    }

    fun assert_timestamp_fresh(arg0: u64, arg1: u64) {
        assert!(arg1 <= arg0, 4);
        assert!(arg0 - arg1 <= 600000, 3);
    }

    fun build_purchase_message(arg0: &0x2::object::ID, arg1: u64, arg2: u64) : vector<u8> {
        let v0 = b"";
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(arg0));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg1));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg2));
        v0
    }

    fun build_reaction_message(arg0: &0x2::object::ID, arg1: &0x1::string::String, arg2: &0x2::object::ID, arg3: &0x2::object::ID, arg4: u64) : vector<u8> {
        let v0 = b"";
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(arg0));
        0x1::vector::append<u8>(&mut v0, *0x1::string::as_bytes(arg1));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(arg2));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(arg3));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg4));
        v0
    }

    fun reason_for(arg0: &0x1::string::String, arg1: vector<u8>) : 0x1::string::String {
        let v0 = *0x1::string::as_bytes(arg0);
        0x1::vector::append<u8>(&mut v0, arg1);
        0x1::string::utf8(v0)
    }

    public fun record_reaction(arg0: &0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::access::RoleRegistry, arg1: &0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::zenko::ZenkoRegistry, arg2: &0x2::clock::Clock, arg3: 0x2::object::ID, arg4: 0x1::string::String, arg5: &mut 0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::Account, arg6: &mut 0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::Account, arg7: u64, arg8: vector<u8>, arg9: vector<u8>, arg10: &mut 0x2::tx_context::TxContext) {
        0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::access::assert_operations(arg0, arg10);
        assert!(!0x1::string::is_empty(&arg4), 7);
        assert!(0x2::object::id<0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::Account>(arg5) != 0x2::object::id<0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::Account>(arg6), 6);
        assert_oracle_signature_valid(arg1, &arg8, &arg9);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert_timestamp_fresh(v0, arg7);
        let v1 = 0x2::object::id<0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::Account>(arg5);
        let v2 = 0x2::object::id<0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::Account>(arg6);
        let v3 = build_reaction_message(&arg3, &arg4, &v1, &v2, arg7);
        assert!(0x2::ecdsa_k1::secp256k1_verify(&arg8, &arg9, &v3, 1), 0);
        let v4 = 0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::subscription_id(arg5);
        let v5 = 0x1::option::is_some<0x2::object::ID>(&v4);
        let v6 = if (v5) {
            2
        } else {
            1
        };
        let v7 = 1;
        0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::adjust_reputation_(arg5, v6, true, reason_for(&arg4, b"_given"), arg10);
        0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::adjust_reputation_(arg6, v7, true, reason_for(&arg4, b"_received"), arg10);
        let v8 = ReactionRecorded{
            reaction_kind      : arg4,
            challenge_id       : arg3,
            cheerer_account    : v1,
            recipient_account  : v2,
            cheerer_has_pass   : v5,
            giver_rep_delta    : v6,
            receiver_rep_delta : v7,
            oracle_pubkey      : arg9,
            timestamp          : v0,
        };
        0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::events::emit_event<ReactionRecorded>(v8);
    }

    public fun record_reaction_purchase(arg0: &0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::access::RoleRegistry, arg1: &0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::zenko::ZenkoRegistry, arg2: &0x2::clock::Clock, arg3: &0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::Account, arg4: u64, arg5: u64, arg6: vector<u8>, arg7: vector<u8>, arg8: &mut 0x2::tx_context::TxContext) {
        0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::access::assert_operations(arg0, arg8);
        assert!(arg4 > 0, 8);
        assert_oracle_signature_valid(arg1, &arg6, &arg7);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert_timestamp_fresh(v0, arg5);
        let v1 = 0x2::object::id<0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::Account>(arg3);
        let v2 = build_purchase_message(&v1, arg4, arg5);
        assert!(0x2::ecdsa_k1::secp256k1_verify(&arg6, &arg7, &v2, 1), 0);
        let v3 = ReactionsPurchased{
            buyer_account : v1,
            quantity      : arg4,
            oracle_pubkey : arg7,
            timestamp     : v0,
        };
        0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::events::emit_event<ReactionsPurchased>(v3);
    }

    // decompiled from Move bytecode v7
}

