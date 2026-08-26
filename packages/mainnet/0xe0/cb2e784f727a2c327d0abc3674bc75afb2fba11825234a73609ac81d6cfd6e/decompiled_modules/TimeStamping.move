module 0xe0cb2e784f727a2c327d0abc3674bc75afb2fba11825234a73609ac81d6cfd6e::TimeStamping {
    struct DocumentIdentity has copy, drop, store {
        packet_id: vector<u8>,
        document_id: vector<u8>,
        document_version: vector<u8>,
        content_sha256: vector<u8>,
    }

    struct SignerAttestation has copy, drop, store {
        signer: address,
        role: u8,
        signed_at_ms: u64,
        attestation_digest: vector<u8>,
        admitted_by: 0x1::option::Option<address>,
        evidence_hash: vector<u8>,
    }

    struct StampInfo has store {
        document: DocumentIdentity,
        created_at_ms: u64,
        users_signed: u64,
        users_to_sign: u64,
        admitter: address,
        signers: 0x2::vec_set::VecSet<address>,
        admitted_roles: 0x2::vec_map::VecMap<address, u8>,
        attestations: 0x2::table::Table<address, SignerAttestation>,
    }

    struct SignerInfo has copy, drop {
        signer: address,
        has_signed: bool,
        signature_timestamp_ms: u64,
    }

    struct DetailedStampInfo has copy, drop {
        admitter: address,
        created_at_ms: u64,
        users_to_sign: u64,
        users_signed: u64,
        stamp_hash: vector<u8>,
        packet_id: vector<u8>,
        document_id: vector<u8>,
        document_version: vector<u8>,
        content_sha256: vector<u8>,
        signers_info: vector<SignerInfo>,
    }

    struct StampTable has key {
        id: 0x2::object::UID,
        stamps: 0x2::table::Table<vector<u8>, StampInfo>,
        admin: address,
        is_paused: bool,
        signers_timestamps: 0x2::object::ID,
        signers_stamp_hashes: 0x2::object::ID,
    }

    struct SignersTimestamps has key {
        id: 0x2::object::UID,
        data: 0x2::table::Table<address, 0x2::table::Table<vector<u8>, u64>>,
    }

    struct SignersStampHashes has key {
        id: 0x2::object::UID,
        data: 0x2::table::Table<address, 0x2::vec_set::VecSet<vector<u8>>>,
    }

    struct StampCreated has copy, drop {
        stamp_hash: vector<u8>,
        created_at_ms: u64,
        users_to_sign: u64,
        admitter: address,
        packet_id: vector<u8>,
        document_id: vector<u8>,
        document_version: vector<u8>,
        content_sha256: vector<u8>,
        commitment_version: u8,
        signers: vector<address>,
    }

    struct StampSigned has copy, drop {
        stamp_hash: vector<u8>,
        signer: address,
        signer_role: u8,
        signed_at_ms: u64,
        content_sha256: vector<u8>,
        attestation_digest: vector<u8>,
        commitment_version: u8,
        evidence_hash: vector<u8>,
    }

    struct SignerAdmitted has copy, drop {
        stamp_hash: vector<u8>,
        signer: address,
        signer_role: u8,
        admitted_by: address,
        admitted_at_ms: u64,
    }

    struct AdmitterChanged has copy, drop {
        stamp_hash: vector<u8>,
        old_admitter: address,
        new_admitter: address,
        via_admin: bool,
    }

    struct TIMESTAMPING has drop {
        dummy_field: bool,
    }

    public entry fun admin_set_admitter(arg0: vector<u8>, arg1: address, arg2: &mut StampTable, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg2.admin, 1007);
        assert!(0x2::table::contains<vector<u8>, StampInfo>(&arg2.stamps, arg0), 1003);
        let v0 = 0x2::table::borrow_mut<vector<u8>, StampInfo>(&mut arg2.stamps, arg0);
        v0.admitter = arg1;
        let v1 = AdmitterChanged{
            stamp_hash   : arg0,
            old_admitter : v0.admitter,
            new_admitter : arg1,
            via_admin    : true,
        };
        0x2::event::emit<AdmitterChanged>(v1);
    }

    public entry fun admit_signer(arg0: vector<u8>, arg1: address, arg2: u8, arg3: &mut StampTable, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!arg3.is_paused, 1006);
        assert!(0x1::vector::length<u8>(&arg0) == 32, 1011);
        assert!(arg1 != @0x0, 1019);
        0xe0cb2e784f727a2c327d0abc3674bc75afb2fba11825234a73609ac81d6cfd6e::Attestation::assert_valid_role(arg2);
        assert!(0x2::table::contains<vector<u8>, StampInfo>(&arg3.stamps, arg0), 1003);
        let v0 = 0x2::table::borrow_mut<vector<u8>, StampInfo>(&mut arg3.stamps, arg0);
        assert!(0x2::tx_context::sender(arg5) == v0.admitter, 1014);
        if (0x2::vec_map::contains<address, u8>(&v0.admitted_roles, &arg1)) {
            assert!(*0x2::vec_map::get<address, u8>(&v0.admitted_roles, &arg1) == arg2, 1016);
            return
        };
        if (0x2::vec_set::contains<address>(&v0.signers, &arg1)) {
            return
        };
        assert!(0x2::vec_set::size<address>(&v0.signers) < v0.users_to_sign, 1015);
        0x2::vec_set::insert<address>(&mut v0.signers, arg1);
        0x2::vec_map::insert<address, u8>(&mut v0.admitted_roles, arg1, arg2);
        let v1 = SignerAdmitted{
            stamp_hash     : arg0,
            signer         : arg1,
            signer_role    : arg2,
            admitted_by    : 0x2::tx_context::sender(arg5),
            admitted_at_ms : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<SignerAdmitted>(v1);
    }

    fun assert_side_tables(arg0: &StampTable, arg1: &SignersTimestamps, arg2: &SignersStampHashes) {
        assert!(arg0.signers_timestamps == 0x2::object::id<SignersTimestamps>(arg1), 1013);
        assert!(arg0.signers_stamp_hashes == 0x2::object::id<SignersStampHashes>(arg2), 1013);
    }

    public fun attestation_admitted_by(arg0: &StampTable, arg1: vector<u8>, arg2: address) : 0x1::option::Option<address> {
        assert!(0x2::table::contains<vector<u8>, StampInfo>(&arg0.stamps, arg1), 1003);
        0x2::table::borrow<address, SignerAttestation>(&0x2::table::borrow<vector<u8>, StampInfo>(&arg0.stamps, arg1).attestations, arg2).admitted_by
    }

    public fun attestation_evidence_hash(arg0: &StampTable, arg1: vector<u8>, arg2: address) : vector<u8> {
        assert!(0x2::table::contains<vector<u8>, StampInfo>(&arg0.stamps, arg1), 1003);
        0x2::table::borrow<address, SignerAttestation>(&0x2::table::borrow<vector<u8>, StampInfo>(&arg0.stamps, arg1).attestations, arg2).evidence_hash
    }

    public fun compute_stamp_hash(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>) : vector<u8> {
        0xe0cb2e784f727a2c327d0abc3674bc75afb2fba11825234a73609ac81d6cfd6e::Attestation::document_digest(arg0, arg1, arg2, arg3)
    }

    fun create_shared_state(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = SignersTimestamps{
            id   : 0x2::object::new(arg0),
            data : 0x2::table::new<address, 0x2::table::Table<vector<u8>, u64>>(arg0),
        };
        let v1 = SignersStampHashes{
            id   : 0x2::object::new(arg0),
            data : 0x2::table::new<address, 0x2::vec_set::VecSet<vector<u8>>>(arg0),
        };
        let v2 = StampTable{
            id                   : 0x2::object::new(arg0),
            stamps               : 0x2::table::new<vector<u8>, StampInfo>(arg0),
            admin                : 0x2::tx_context::sender(arg0),
            is_paused            : false,
            signers_timestamps   : 0x2::object::id<SignersTimestamps>(&v0),
            signers_stamp_hashes : 0x2::object::id<SignersStampHashes>(&v1),
        };
        0x2::transfer::share_object<StampTable>(v2);
        0x2::transfer::share_object<SignersTimestamps>(v0);
        0x2::transfer::share_object<SignersStampHashes>(v1);
    }

    public entry fun create_stamp(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: bool, arg5: u8, arg6: vector<address>, arg7: u64, arg8: address, arg9: &mut StampTable, arg10: &mut SignersTimestamps, arg11: &mut SignersStampHashes, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        create_stamp_internal(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
    }

    fun create_stamp_internal(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: bool, arg5: u8, arg6: vector<address>, arg7: u64, arg8: address, arg9: &mut StampTable, arg10: &mut SignersTimestamps, arg11: &mut SignersStampHashes, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        assert!(!arg9.is_paused, 1006);
        assert_side_tables(arg9, arg10, arg11);
        let v0 = 0x2::tx_context::sender(arg13);
        assert!(0x1::vector::length<u8>(&arg3) == 32, 1011);
        assert!(0x1::vector::length<address>(&arg6) > 0, 1017);
        assert!(0x1::vector::length<address>(&arg6) <= 100, 1008);
        0xe0cb2e784f727a2c327d0abc3674bc75afb2fba11825234a73609ac81d6cfd6e::Attestation::assert_valid_role(arg5);
        let v1 = 0xe0cb2e784f727a2c327d0abc3674bc75afb2fba11825234a73609ac81d6cfd6e::Attestation::document_digest(arg0, arg1, arg2, arg3);
        assert!(!0x2::table::contains<vector<u8>, StampInfo>(&arg9.stamps, v1), 1001);
        let v2 = 0x2::table::new<address, bool>(arg13);
        let v3 = 0x1::vector::empty<address>();
        let v4 = 0;
        while (v4 < 0x1::vector::length<address>(&arg6)) {
            let v5 = *0x1::vector::borrow<address>(&arg6, v4);
            assert!(!0x2::table::contains<address, bool>(&v2, v5), 1009);
            0x2::table::add<address, bool>(&mut v2, v5, true);
            0x1::vector::push_back<address>(&mut v3, v5);
            v4 = v4 + 1;
        };
        if (!0x2::table::contains<address, bool>(&v2, v0)) {
            0x2::table::add<address, bool>(&mut v2, v0, true);
            0x1::vector::push_back<address>(&mut v3, v0);
        };
        let v6 = 0x2::vec_set::empty<address>();
        v4 = 0;
        while (v4 < 0x1::vector::length<address>(&v3)) {
            0x2::vec_set::insert<address>(&mut v6, *0x1::vector::borrow<address>(&v3, v4));
            v4 = v4 + 1;
        };
        0x2::table::drop<address, bool>(v2);
        let v7 = 0x2::vec_set::size<address>(&v6);
        assert!(arg7 >= v7, 1018);
        assert!(arg7 <= 100 + 1, 1018);
        if (arg8 == @0x0) {
            assert!(arg7 == v7, 1018);
        };
        let v8 = 0x2::clock::timestamp_ms(arg12);
        let v9 = DocumentIdentity{
            packet_id        : arg0,
            document_id      : arg1,
            document_version : arg2,
            content_sha256   : arg3,
        };
        let v10 = StampInfo{
            document       : v9,
            created_at_ms  : v8,
            users_signed   : 0,
            users_to_sign  : arg7,
            admitter       : arg8,
            signers        : v6,
            admitted_roles : 0x2::vec_map::empty<address, u8>(),
            attestations   : 0x2::table::new<address, SignerAttestation>(arg13),
        };
        0x2::table::add<vector<u8>, StampInfo>(&mut arg9.stamps, v1, v10);
        let v11 = StampCreated{
            stamp_hash         : v1,
            created_at_ms      : v8,
            users_to_sign      : arg7,
            admitter           : arg8,
            packet_id          : arg0,
            document_id        : arg1,
            document_version   : arg2,
            content_sha256     : arg3,
            commitment_version : 0xe0cb2e784f727a2c327d0abc3674bc75afb2fba11825234a73609ac81d6cfd6e::Attestation::commitment_version(),
            signers            : v3,
        };
        0x2::event::emit<StampCreated>(v11);
        if (arg4) {
            sign_internal(v1, arg3, arg5, 0x1::vector::empty<u8>(), arg9, arg10, arg11, arg12, arg13);
        };
    }

    public fun detailed_admitter(arg0: &DetailedStampInfo) : address {
        arg0.admitter
    }

    public fun detailed_content_sha256(arg0: &DetailedStampInfo) : vector<u8> {
        arg0.content_sha256
    }

    public fun detailed_created_at_ms(arg0: &DetailedStampInfo) : u64 {
        arg0.created_at_ms
    }

    public fun detailed_users_to_sign(arg0: &DetailedStampInfo) : u64 {
        arg0.users_to_sign
    }

    public fun get_attestation(arg0: &StampTable, arg1: vector<u8>, arg2: address) : (u8, u64, vector<u8>) {
        assert!(0x2::table::contains<vector<u8>, StampInfo>(&arg0.stamps, arg1), 1003);
        let v0 = 0x2::table::borrow<address, SignerAttestation>(&0x2::table::borrow<vector<u8>, StampInfo>(&arg0.stamps, arg1).attestations, arg2);
        (v0.role, v0.signed_at_ms, v0.attestation_digest)
    }

    public fun get_hashes_by_user_address(arg0: &SignersStampHashes, arg1: address) : vector<vector<u8>> {
        let v0 = get_signer_hashes_const(arg0, arg1);
        if (v0 == 0x1::option::none<0x2::vec_set::VecSet<vector<u8>>>()) {
            0x1::vector::empty<vector<u8>>()
        } else {
            0x2::vec_set::into_keys<vector<u8>>(*0x1::option::borrow<0x2::vec_set::VecSet<vector<u8>>>(&v0))
        }
    }

    fun get_signer_hashes(arg0: &mut SignersStampHashes, arg1: address) : &mut 0x2::vec_set::VecSet<vector<u8>> {
        if (!0x2::table::contains<address, 0x2::vec_set::VecSet<vector<u8>>>(&arg0.data, arg1)) {
            0x2::table::add<address, 0x2::vec_set::VecSet<vector<u8>>>(&mut arg0.data, arg1, 0x2::vec_set::empty<vector<u8>>());
        };
        0x2::table::borrow_mut<address, 0x2::vec_set::VecSet<vector<u8>>>(&mut arg0.data, arg1)
    }

    fun get_signer_hashes_const(arg0: &SignersStampHashes, arg1: address) : 0x1::option::Option<0x2::vec_set::VecSet<vector<u8>>> {
        if (0x2::table::contains<address, 0x2::vec_set::VecSet<vector<u8>>>(&arg0.data, arg1)) {
            0x1::option::some<0x2::vec_set::VecSet<vector<u8>>>(*0x2::table::borrow<address, 0x2::vec_set::VecSet<vector<u8>>>(&arg0.data, arg1))
        } else {
            0x1::option::none<0x2::vec_set::VecSet<vector<u8>>>()
        }
    }

    public fun get_stamp_admitter(arg0: &StampTable, arg1: vector<u8>) : address {
        assert!(0x2::table::contains<vector<u8>, StampInfo>(&arg0.stamps, arg1), 1003);
        0x2::table::borrow<vector<u8>, StampInfo>(&arg0.stamps, arg1).admitter
    }

    public fun get_stamp_created_at_ms(arg0: &StampTable, arg1: vector<u8>) : u64 {
        assert!(0x2::table::contains<vector<u8>, StampInfo>(&arg0.stamps, arg1), 1003);
        0x2::table::borrow<vector<u8>, StampInfo>(&arg0.stamps, arg1).created_at_ms
    }

    public fun get_stamp_info(arg0: &StampTable, arg1: &SignersTimestamps, arg2: &SignersStampHashes, arg3: vector<u8>) : DetailedStampInfo {
        assert_side_tables(arg0, arg1, arg2);
        assert!(0x2::table::contains<vector<u8>, StampInfo>(&arg0.stamps, arg3), 1003);
        let v0 = 0x2::table::borrow<vector<u8>, StampInfo>(&arg0.stamps, arg3);
        let v1 = 0x1::vector::empty<SignerInfo>();
        let v2 = 0x2::vec_set::into_keys<address>(v0.signers);
        let v3 = 0;
        while (v3 < 0x1::vector::length<address>(&v2)) {
            0x1::vector::push_back<SignerInfo>(&mut v1, get_user_info(arg1, arg2, *0x1::vector::borrow<address>(&v2, v3), arg3));
            v3 = v3 + 1;
        };
        DetailedStampInfo{
            admitter         : v0.admitter,
            created_at_ms    : v0.created_at_ms,
            users_to_sign    : v0.users_to_sign,
            users_signed     : v0.users_signed,
            stamp_hash       : arg3,
            packet_id        : v0.document.packet_id,
            document_id      : v0.document.document_id,
            document_version : v0.document.document_version,
            content_sha256   : v0.document.content_sha256,
            signers_info     : v1,
        }
    }

    public fun get_stamp_signer_set_size(arg0: &StampTable, arg1: vector<u8>) : u64 {
        assert!(0x2::table::contains<vector<u8>, StampInfo>(&arg0.stamps, arg1), 1003);
        0x2::vec_set::size<address>(&0x2::table::borrow<vector<u8>, StampInfo>(&arg0.stamps, arg1).signers)
    }

    public fun get_stamp_users_signed(arg0: &StampTable, arg1: vector<u8>) : u64 {
        assert!(0x2::table::contains<vector<u8>, StampInfo>(&arg0.stamps, arg1), 1003);
        0x2::table::borrow<vector<u8>, StampInfo>(&arg0.stamps, arg1).users_signed
    }

    public fun get_stamp_users_to_sign(arg0: &StampTable, arg1: vector<u8>) : u64 {
        assert!(0x2::table::contains<vector<u8>, StampInfo>(&arg0.stamps, arg1), 1003);
        0x2::table::borrow<vector<u8>, StampInfo>(&arg0.stamps, arg1).users_to_sign
    }

    public fun get_user_info(arg0: &SignersTimestamps, arg1: &SignersStampHashes, arg2: address, arg3: vector<u8>) : SignerInfo {
        let v0 = get_signer_hashes_const(arg1, arg2);
        let v1 = 0x1::option::is_some<0x2::vec_set::VecSet<vector<u8>>>(&v0) && 0x2::vec_set::contains<vector<u8>>(0x1::option::borrow<0x2::vec_set::VecSet<vector<u8>>>(&v0), &arg3);
        let v2 = if (v1) {
            if (0x2::table::contains<address, 0x2::table::Table<vector<u8>, u64>>(&arg0.data, arg2)) {
                let v3 = 0x2::table::borrow<address, 0x2::table::Table<vector<u8>, u64>>(&arg0.data, arg2);
                if (0x2::table::contains<vector<u8>, u64>(v3, arg3)) {
                    *0x2::table::borrow<vector<u8>, u64>(v3, arg3)
                } else {
                    0
                }
            } else {
                0
            }
        } else {
            0
        };
        SignerInfo{
            signer                 : arg2,
            has_signed             : v1,
            signature_timestamp_ms : v2,
        }
    }

    fun get_user_timestamps(arg0: &mut SignersTimestamps, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : &mut 0x2::table::Table<vector<u8>, u64> {
        if (!0x2::table::contains<address, 0x2::table::Table<vector<u8>, u64>>(&arg0.data, arg1)) {
            0x2::table::add<address, 0x2::table::Table<vector<u8>, u64>>(&mut arg0.data, arg1, 0x2::table::new<vector<u8>, u64>(arg2));
        };
        0x2::table::borrow_mut<address, 0x2::table::Table<vector<u8>, u64>>(&mut arg0.data, arg1)
    }

    public fun has_attestation(arg0: &StampTable, arg1: vector<u8>, arg2: address) : bool {
        assert!(0x2::table::contains<vector<u8>, StampInfo>(&arg0.stamps, arg1), 1003);
        0x2::table::contains<address, SignerAttestation>(&0x2::table::borrow<vector<u8>, StampInfo>(&arg0.stamps, arg1).attestations, arg2)
    }

    fun init(arg0: TIMESTAMPING, arg1: &mut 0x2::tx_context::TxContext) {
        create_shared_state(arg1);
    }

    public fun is_admitted(arg0: &StampTable, arg1: vector<u8>, arg2: address) : bool {
        assert!(0x2::table::contains<vector<u8>, StampInfo>(&arg0.stamps, arg1), 1003);
        0x2::vec_set::contains<address>(&0x2::table::borrow<vector<u8>, StampInfo>(&arg0.stamps, arg1).signers, &arg2)
    }

    public entry fun pause(arg0: &mut StampTable, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 1007);
        arg0.is_paused = true;
    }

    public entry fun set_admitter(arg0: vector<u8>, arg1: address, arg2: &mut StampTable, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg2.is_paused, 1006);
        assert!(0x2::table::contains<vector<u8>, StampInfo>(&arg2.stamps, arg0), 1003);
        let v0 = 0x2::table::borrow_mut<vector<u8>, StampInfo>(&mut arg2.stamps, arg0);
        assert!(0x2::tx_context::sender(arg3) == v0.admitter, 1014);
        v0.admitter = arg1;
        let v1 = AdmitterChanged{
            stamp_hash   : arg0,
            old_admitter : v0.admitter,
            new_admitter : arg1,
            via_admin    : false,
        };
        0x2::event::emit<AdmitterChanged>(v1);
    }

    public entry fun sign(arg0: vector<u8>, arg1: vector<u8>, arg2: u8, arg3: vector<u8>, arg4: &mut StampTable, arg5: &mut SignersTimestamps, arg6: &mut SignersStampHashes, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        sign_internal(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    fun sign_internal(arg0: vector<u8>, arg1: vector<u8>, arg2: u8, arg3: vector<u8>, arg4: &mut StampTable, arg5: &mut SignersTimestamps, arg6: &mut SignersStampHashes, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(!arg4.is_paused, 1006);
        assert_side_tables(arg4, arg5, arg6);
        let v0 = 0x2::tx_context::sender(arg8);
        let v1 = 0x2::clock::timestamp_ms(arg7);
        assert!(0x1::vector::length<u8>(&arg0) == 32, 1011);
        0xe0cb2e784f727a2c327d0abc3674bc75afb2fba11825234a73609ac81d6cfd6e::Attestation::assert_valid_role(arg2);
        assert!(0x1::vector::is_empty<u8>(&arg3) || 0x1::vector::length<u8>(&arg3) == 32, 1011);
        assert!(0x2::table::contains<vector<u8>, StampInfo>(&arg4.stamps, arg0), 1003);
        let v2 = 0x2::table::borrow<vector<u8>, StampInfo>(&arg4.stamps, arg0).document;
        assert!(v2.content_sha256 == arg1, 1012);
        let v3 = 0xe0cb2e784f727a2c327d0abc3674bc75afb2fba11825234a73609ac81d6cfd6e::Attestation::attestation_digest(v2.packet_id, v2.document_id, v2.document_version, v2.content_sha256, v0, arg2, v1);
        let v4 = get_signer_hashes(arg6, v0);
        assert!(!0x2::vec_set::contains<vector<u8>>(v4, &arg0), 1004);
        let v5 = 0x2::table::borrow_mut<vector<u8>, StampInfo>(&mut arg4.stamps, arg0);
        assert!(0x2::vec_set::contains<address>(&v5.signers, &v0), 1005);
        let v6 = if (0x2::vec_map::contains<address, u8>(&v5.admitted_roles, &v0)) {
            assert!(*0x2::vec_map::get<address, u8>(&v5.admitted_roles, &v0) == arg2, 1016);
            0x1::option::some<address>(v5.admitter)
        } else {
            0x1::option::none<address>()
        };
        assert!(v5.users_signed < 72057594037927935, 1010);
        v5.users_signed = v5.users_signed + 1;
        let v7 = SignerAttestation{
            signer             : v0,
            role               : arg2,
            signed_at_ms       : v1,
            attestation_digest : v3,
            admitted_by        : v6,
            evidence_hash      : arg3,
        };
        0x2::table::add<address, SignerAttestation>(&mut v5.attestations, v0, v7);
        0x2::table::add<vector<u8>, u64>(get_user_timestamps(arg5, v0, arg8), arg0, v1);
        0x2::vec_set::insert<vector<u8>>(v4, arg0);
        let v8 = StampSigned{
            stamp_hash         : arg0,
            signer             : v0,
            signer_role        : arg2,
            signed_at_ms       : v1,
            content_sha256     : arg1,
            attestation_digest : v3,
            commitment_version : 0xe0cb2e784f727a2c327d0abc3674bc75afb2fba11825234a73609ac81d6cfd6e::Attestation::commitment_version(),
            evidence_hash      : arg3,
        };
        0x2::event::emit<StampSigned>(v8);
    }

    public fun signer_info_has_signed(arg0: &SignerInfo) : bool {
        arg0.has_signed
    }

    public fun signer_info_timestamp_ms(arg0: &SignerInfo) : u64 {
        arg0.signature_timestamp_ms
    }

    public entry fun unpause(arg0: &mut StampTable, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 1007);
        arg0.is_paused = false;
    }

    // decompiled from Move bytecode v7
}

