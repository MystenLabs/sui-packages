module 0x7b6d64782bec63e0f4151b510444bef37e4993de5d99f52a8c39e6c1ae71f21d::registry {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Directory has key {
        id: 0x2::object::UID,
        sessions: 0x2::table::Table<vector<u8>, 0x2::object::ID>,
    }

    struct Principal has key {
        id: 0x2::object::UID,
        owner: address,
        name: 0x1::string::String,
        verified: bool,
        devices: 0x2::table::Table<vector<u8>, DeviceGrant>,
    }

    struct DeviceGrant has copy, drop, store {
        label: 0x1::string::String,
        scope: u8,
        not_before_ms: u64,
        not_after_ms: u64,
        revoked_at_ms: u64,
    }

    struct DeviceHistoryKey has copy, drop, store {
        device_pk: vector<u8>,
    }

    struct DeviceRenewed has copy, drop {
        principal: 0x2::object::ID,
        device_pk: vector<u8>,
        previous_not_after_ms: u64,
        not_after_ms: u64,
        renewed_at_ms: u64,
    }

    struct AnchorRecord has copy, drop, store {
        from_seq: u64,
        to_seq: u64,
        merkle_root: vector<u8>,
        head: vector<u8>,
        manifest_hash: vector<u8>,
        chain_time_ms: u64,
    }

    struct WitnessRecord has copy, drop, store {
        seq: u64,
        head: vector<u8>,
        witness_principal: 0x2::object::ID,
        witness_device_pk: vector<u8>,
        distance_cm: u64,
        ambient_digest: vector<u8>,
        chain_time_ms: u64,
    }

    struct Session has key {
        id: 0x2::object::UID,
        session_id: vector<u8>,
        principal: 0x2::object::ID,
        device_pk: vector<u8>,
        session_pk: vector<u8>,
        cert_sig: vector<u8>,
        start_ms: u64,
        max_duration_ms: u64,
        mode: u64,
        segment_ms: u64,
        next_seq: u64,
        anchors: vector<AnchorRecord>,
        anchored_heads: 0x2::table::Table<u64, vector<u8>>,
        witnesses: vector<WitnessRecord>,
    }

    struct DeviceGranted has copy, drop {
        principal: 0x2::object::ID,
        device_pk: vector<u8>,
        scope: u8,
    }

    struct DeviceRevoked has copy, drop {
        principal: 0x2::object::ID,
        device_pk: vector<u8>,
        at_ms: u64,
    }

    struct SessionOpened has copy, drop {
        session: 0x2::object::ID,
        session_id: vector<u8>,
        principal: 0x2::object::ID,
        mode: u64,
        start_ms: u64,
    }

    struct Anchored has copy, drop {
        session: 0x2::object::ID,
        from_seq: u64,
        to_seq: u64,
        merkle_root: vector<u8>,
        head: vector<u8>,
    }

    struct Witnessed has copy, drop {
        session: 0x2::object::ID,
        seq: u64,
        witness_principal: 0x2::object::ID,
        distance_cm: u64,
    }

    struct REGISTRY has drop {
        dummy_field: bool,
    }

    public fun anchor(arg0: &mut Session, arg1: &Principal, arg2: u64, arg3: u64, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: &0x2::clock::Clock) {
        assert!(0x2::object::id<Principal>(arg1) == arg0.principal, 6);
        assert!(arg2 == arg0.next_seq && arg3 >= arg2, 5);
        let v0 = 0x2::clock::timestamp_ms(arg8);
        assert!(v0 <= arg0.start_ms + arg0.max_duration_ms + 86400000, 8);
        let v1 = if (arg0.mode == 2) {
            2
        } else {
            1
        };
        assert_grant_active(arg1, &arg0.device_pk, v1, arg0.start_ms, v0);
        let v2 = anchor_msg(arg0.session_id, arg2, arg3, arg4, arg5, arg6);
        assert!(verify_p256(&arg7, &arg0.session_pk, &v2), 2);
        let v3 = AnchorRecord{
            from_seq      : arg2,
            to_seq        : arg3,
            merkle_root   : arg4,
            head          : arg5,
            manifest_hash : arg6,
            chain_time_ms : v0,
        };
        0x1::vector::push_back<AnchorRecord>(&mut arg0.anchors, v3);
        0x2::table::add<u64, vector<u8>>(&mut arg0.anchored_heads, arg3, arg5);
        arg0.next_seq = arg3 + 1;
        let v4 = Anchored{
            session     : 0x2::object::id<Session>(arg0),
            from_seq    : arg2,
            to_seq      : arg3,
            merkle_root : arg4,
            head        : arg5,
        };
        0x2::event::emit<Anchored>(v4);
    }

    public fun anchor_msg(arg0: vector<u8>, arg1: u64, arg2: u64, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>) : vector<u8> {
        let v0 = b"SSEAL/ANCHOR/v1";
        0x1::vector::append<u8>(&mut v0, arg0);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg1));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg2));
        0x1::vector::append<u8>(&mut v0, arg3);
        0x1::vector::append<u8>(&mut v0, arg4);
        0x1::vector::append<u8>(&mut v0, arg5);
        v0
    }

    fun assert_grant_active(arg0: &Principal, arg1: &vector<u8>, arg2: u8, arg3: u64, arg4: u64) {
        assert!(0x2::table::contains<vector<u8>, DeviceGrant>(&arg0.devices, *arg1), 3);
        let v0 = 0x2::table::borrow<vector<u8>, DeviceGrant>(&arg0.devices, *arg1);
        assert!(v0.scope & arg2 != 0, 3);
        assert!(arg3 >= v0.not_before_ms && arg3 <= v0.not_after_ms, 3);
        assert!(v0.revoked_at_ms == 0 || arg4 < v0.revoked_at_ms, 3);
    }

    public fun cosign(arg0: &mut Session, arg1: &Principal, arg2: u64, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: vector<u8>, arg7: vector<u8>, arg8: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg8);
        assert_grant_active(arg1, &arg4, 1 | 2, v0, v0);
        if (0x2::table::contains<u64, vector<u8>>(&arg0.anchored_heads, arg2)) {
            assert!(*0x2::table::borrow<u64, vector<u8>>(&arg0.anchored_heads, arg2) == arg3, 9);
        };
        let v1 = witness_msg(arg0.session_id, arg2, arg3, 0x2::object::id_bytes<Principal>(arg1), arg4, arg5, arg6);
        assert!(verify_p256(&arg7, &arg4, &v1), 2);
        let v2 = WitnessRecord{
            seq               : arg2,
            head              : arg3,
            witness_principal : 0x2::object::id<Principal>(arg1),
            witness_device_pk : arg4,
            distance_cm       : arg5,
            ambient_digest    : arg6,
            chain_time_ms     : v0,
        };
        0x1::vector::push_back<WitnessRecord>(&mut arg0.witnesses, v2);
        let v3 = Witnessed{
            session           : 0x2::object::id<Session>(arg0),
            seq               : arg2,
            witness_principal : 0x2::object::id<Principal>(arg1),
            distance_cm       : arg5,
        };
        0x2::event::emit<Witnessed>(v3);
    }

    public fun create_principal(arg0: 0x1::string::String, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Principal{
            id       : 0x2::object::new(arg1),
            owner    : 0x2::tx_context::sender(arg1),
            name     : arg0,
            verified : false,
            devices  : 0x2::table::new<vector<u8>, DeviceGrant>(arg1),
        };
        0x2::transfer::share_object<Principal>(v0);
    }

    public fun device_grant_history(arg0: &Principal, arg1: vector<u8>) : vector<DeviceGrant> {
        let v0 = DeviceHistoryKey{device_pk: arg1};
        if (0x2::dynamic_field::exists<DeviceHistoryKey>(&arg0.id, v0)) {
            *0x2::dynamic_field::borrow<DeviceHistoryKey, vector<DeviceGrant>>(&arg0.id, v0)
        } else if (0x2::table::contains<vector<u8>, DeviceGrant>(&arg0.devices, arg1)) {
            let v2 = 0x1::vector::empty<DeviceGrant>();
            0x1::vector::push_back<DeviceGrant>(&mut v2, *0x2::table::borrow<vector<u8>, DeviceGrant>(&arg0.devices, arg1));
            v2
        } else {
            0x1::vector::empty<DeviceGrant>()
        }
    }

    public fun grant_device(arg0: &mut Principal, arg1: vector<u8>, arg2: 0x1::string::String, arg3: u8, arg4: u64, arg5: u64, arg6: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg6) == arg0.owner, 1);
        assert!(0x1::vector::length<u8>(&arg1) == 33, 10);
        if (0x2::table::contains<vector<u8>, DeviceGrant>(&arg0.devices, arg1)) {
            assert!(0x2::table::borrow<vector<u8>, DeviceGrant>(&arg0.devices, arg1).revoked_at_ms == 0, 3);
            abort 11
        };
        assert!(arg4 <= arg5, 12);
        let v0 = DeviceGrant{
            label         : arg2,
            scope         : arg3,
            not_before_ms : arg4,
            not_after_ms  : arg5,
            revoked_at_ms : 0,
        };
        0x2::table::add<vector<u8>, DeviceGrant>(&mut arg0.devices, arg1, v0);
        let v1 = DeviceHistoryKey{device_pk: arg1};
        let v2 = 0x1::vector::empty<DeviceGrant>();
        0x1::vector::push_back<DeviceGrant>(&mut v2, v0);
        0x2::dynamic_field::add<DeviceHistoryKey, vector<DeviceGrant>>(&mut arg0.id, v1, v2);
        let v3 = DeviceGranted{
            principal : 0x2::object::id<Principal>(arg0),
            device_pk : arg1,
            scope     : arg3,
        };
        0x2::event::emit<DeviceGranted>(v3);
    }

    fun init(arg0: REGISTRY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<REGISTRY>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"project_url"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"ANAVRIN SourceSeal session"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://verify.yourstatsapp.com/s/{session_id}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://www.yourstatsapp.com"));
        let v5 = 0x2::display::new_with_fields<Session>(&v0, v1, v3, arg1);
        0x2::display::update_version<Session>(&mut v5);
        0x2::transfer::public_transfer<0x2::display::Display<Session>>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        let v6 = Directory{
            id       : 0x2::object::new(arg1),
            sessions : 0x2::table::new<vector<u8>, 0x2::object::ID>(arg1),
        };
        0x2::transfer::share_object<Directory>(v6);
        let v7 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v7, 0x2::tx_context::sender(arg1));
    }

    public fun lookup_session(arg0: &Directory, arg1: vector<u8>) : 0x2::object::ID {
        *0x2::table::borrow<vector<u8>, 0x2::object::ID>(&arg0.sessions, arg1)
    }

    public fun open_session(arg0: &mut Directory, arg1: &Principal, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: vector<u8>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(&arg2) == 32 && 0x1::vector::length<u8>(&arg4) == 33, 10);
        let v0 = 0x2::clock::timestamp_ms(arg10);
        assert!(arg5 <= v0 + 300000 && v0 <= arg5 + 300000, 7);
        assert!(!0x2::table::contains<vector<u8>, 0x2::object::ID>(&arg0.sessions, arg2), 4);
        let v1 = if (arg7 == 2) {
            2
        } else {
            1
        };
        assert_grant_active(arg1, &arg3, v1, arg5, v0);
        let v2 = session_cert_msg(0x2::object::id_bytes<Principal>(arg1), arg3, arg2, arg4, arg5, arg6, arg7);
        assert!(verify_p256(&arg9, &arg3, &v2), 2);
        let v3 = Session{
            id              : 0x2::object::new(arg11),
            session_id      : arg2,
            principal       : 0x2::object::id<Principal>(arg1),
            device_pk       : arg3,
            session_pk      : arg4,
            cert_sig        : arg9,
            start_ms        : arg5,
            max_duration_ms : arg6,
            mode            : arg7,
            segment_ms      : arg8,
            next_seq        : 0,
            anchors         : 0x1::vector::empty<AnchorRecord>(),
            anchored_heads  : 0x2::table::new<u64, vector<u8>>(arg11),
            witnesses       : 0x1::vector::empty<WitnessRecord>(),
        };
        let v4 = 0x2::object::id<Session>(&v3);
        0x2::table::add<vector<u8>, 0x2::object::ID>(&mut arg0.sessions, arg2, v4);
        let v5 = SessionOpened{
            session    : v4,
            session_id : arg2,
            principal  : 0x2::object::id<Principal>(arg1),
            mode       : arg7,
            start_ms   : arg5,
        };
        0x2::event::emit<SessionOpened>(v5);
        0x2::transfer::share_object<Session>(v3);
    }

    public fun principal_name(arg0: &Principal) : 0x1::string::String {
        arg0.name
    }

    public fun principal_verified(arg0: &Principal) : bool {
        arg0.verified
    }

    public fun renew_device(arg0: &mut Principal, arg1: vector<u8>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.owner, 1);
        assert!(0x2::table::contains<vector<u8>, DeviceGrant>(&arg0.devices, arg1), 3);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        let v1 = *0x2::table::borrow<vector<u8>, DeviceGrant>(&arg0.devices, arg1);
        let v2 = if (v1.revoked_at_ms == 0) {
            if (v0 >= v1.not_before_ms) {
                v0 <= v1.not_after_ms
            } else {
                false
            }
        } else {
            false
        };
        assert!(v2, 3);
        assert!(arg2 > v1.not_after_ms, 13);
        let v3 = DeviceHistoryKey{device_pk: arg1};
        if (!0x2::dynamic_field::exists<DeviceHistoryKey>(&arg0.id, v3)) {
            let v4 = 0x1::vector::empty<DeviceGrant>();
            0x1::vector::push_back<DeviceGrant>(&mut v4, v1);
            0x2::dynamic_field::add<DeviceHistoryKey, vector<DeviceGrant>>(&mut arg0.id, v3, v4);
        };
        0x2::table::borrow_mut<vector<u8>, DeviceGrant>(&mut arg0.devices, arg1).not_after_ms = arg2;
        0x1::vector::push_back<DeviceGrant>(0x2::dynamic_field::borrow_mut<DeviceHistoryKey, vector<DeviceGrant>>(&mut arg0.id, v3), *0x2::table::borrow<vector<u8>, DeviceGrant>(&arg0.devices, arg1));
        let v5 = DeviceRenewed{
            principal             : 0x2::object::id<Principal>(arg0),
            device_pk             : arg1,
            previous_not_after_ms : v1.not_after_ms,
            not_after_ms          : arg2,
            renewed_at_ms         : v0,
        };
        0x2::event::emit<DeviceRenewed>(v5);
    }

    public fun revoke_device(arg0: &mut Principal, arg1: vector<u8>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 1);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        0x2::table::borrow_mut<vector<u8>, DeviceGrant>(&mut arg0.devices, arg1).revoked_at_ms = v0;
        let v1 = DeviceRevoked{
            principal : 0x2::object::id<Principal>(arg0),
            device_pk : arg1,
            at_ms     : v0,
        };
        0x2::event::emit<DeviceRevoked>(v1);
    }

    public fun session_anchor_count(arg0: &Session) : u64 {
        0x1::vector::length<AnchorRecord>(&arg0.anchors)
    }

    public fun session_cert_msg(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: u64, arg5: u64, arg6: u64) : vector<u8> {
        let v0 = b"SSEAL/SESSION/v1";
        0x1::vector::append<u8>(&mut v0, arg0);
        0x1::vector::append<u8>(&mut v0, arg1);
        0x1::vector::append<u8>(&mut v0, arg2);
        0x1::vector::append<u8>(&mut v0, arg3);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg4));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg5));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg6));
        v0
    }

    public fun session_next_seq(arg0: &Session) : u64 {
        arg0.next_seq
    }

    public fun session_principal(arg0: &Session) : 0x2::object::ID {
        arg0.principal
    }

    public fun session_witness_count(arg0: &Session) : u64 {
        0x1::vector::length<WitnessRecord>(&arg0.witnesses)
    }

    public fun set_verified(arg0: &AdminCap, arg1: &mut Principal, arg2: bool) {
        arg1.verified = arg2;
    }

    public fun verify_p256(arg0: &vector<u8>, arg1: &vector<u8>, arg2: &vector<u8>) : bool {
        0x2::ecdsa_r1::secp256r1_verify(arg0, arg1, arg2, 1)
    }

    public fun witness_msg(arg0: vector<u8>, arg1: u64, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: vector<u8>) : vector<u8> {
        let v0 = b"SSEAL/WITNESS/v1";
        0x1::vector::append<u8>(&mut v0, arg0);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg1));
        0x1::vector::append<u8>(&mut v0, arg2);
        0x1::vector::append<u8>(&mut v0, arg3);
        0x1::vector::append<u8>(&mut v0, arg4);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg5));
        0x1::vector::append<u8>(&mut v0, arg6);
        v0
    }

    // decompiled from Move bytecode v7
}

