module 0x3d1ef06d5b491e5948fdb90c304b0f51f34ce5db482f66c9c3ad7646dc86d50a::verifier {
    struct TrustedSignerInfo has copy, drop, store {
        public_key: vector<u8>,
        expires_at_ms: u64,
    }

    struct Verifier has key {
        id: 0x2::object::UID,
        version: u64,
        trusted_signers: vector<TrustedSignerInfo>,
    }

    fun assert_public_key(arg0: &vector<u8>) {
        assert!(0x1::vector::length<u8>(arg0) == 33, 13906835209430630403);
    }

    public fun assert_version(arg0: &Verifier) {
        if (arg0.version > 1) {
            abort 13906835183660695553
        };
    }

    public(friend) fun borrow_mut_id(arg0: &mut Verifier) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public(friend) fun create(arg0: &mut 0x2::tx_context::TxContext) : Verifier {
        Verifier{
            id              : 0x2::object::new(arg0),
            version         : 1,
            trusted_signers : 0x1::vector::empty<TrustedSignerInfo>(),
        }
    }

    public fun expires_at_ms(arg0: &TrustedSignerInfo) : u64 {
        arg0.expires_at_ms
    }

    public fun public_key(arg0: &TrustedSignerInfo) : &vector<u8> {
        &arg0.public_key
    }

    public(friend) fun share(arg0: Verifier) {
        0x2::transfer::share_object<Verifier>(arg0);
    }

    public fun trusted_signers(arg0: &Verifier) : &vector<TrustedSignerInfo> {
        &arg0.trusted_signers
    }

    public fun update_trusted_signer(arg0: &mut Verifier, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x3d1ef06d5b491e5948fdb90c304b0f51f34ce5db482f66c9c3ad7646dc86d50a::authority::PACKAGE, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>, arg2: vector<u8>, arg3: u64) {
        assert_version(arg0);
        update_trusted_signer_(arg0, arg2, arg3);
    }

    fun update_trusted_signer_(arg0: &mut Verifier, arg1: vector<u8>, arg2: u64) {
        assert_public_key(&arg1);
        let v0 = &arg0.trusted_signers;
        let v1 = 0;
        let v2;
        while (v1 < 0x1::vector::length<TrustedSignerInfo>(v0)) {
            if (public_key(0x1::vector::borrow<TrustedSignerInfo>(v0, v1)) == &arg1) {
                v2 = 0x1::option::some<u64>(v1);
                /* label 6 */
                if (arg2 == 0) {
                    assert!(0x1::option::is_some<u64>(&v2), 13906835020452462601);
                    0x1::vector::swap_remove<TrustedSignerInfo>(&mut arg0.trusted_signers, 0x1::option::extract<u64>(&mut v2));
                    0x3d1ef06d5b491e5948fdb90c304b0f51f34ce5db482f66c9c3ad7646dc86d50a::events::emit_removed_trusted_signer(0x2::object::uid_to_inner(&arg0.id), arg1);
                    return
                };
                if (0x1::option::is_some<u64>(&v2)) {
                    let v3 = 0x1::vector::borrow_mut<TrustedSignerInfo>(&mut arg0.trusted_signers, 0x1::option::extract<u64>(&mut v2));
                    v3.expires_at_ms = arg2;
                    0x3d1ef06d5b491e5948fdb90c304b0f51f34ce5db482f66c9c3ad7646dc86d50a::events::emit_updated_trusted_signer(0x2::object::uid_to_inner(&arg0.id), arg1, v3.expires_at_ms, arg2);
                } else {
                    0x1::option::destroy_none<u64>(v2);
                    assert!(0x1::vector::length<TrustedSignerInfo>(&arg0.trusted_signers) < 8, 13906835106351939595);
                    let v4 = TrustedSignerInfo{
                        public_key    : arg1,
                        expires_at_ms : arg2,
                    };
                    0x1::vector::push_back<TrustedSignerInfo>(&mut arg0.trusted_signers, v4);
                    0x3d1ef06d5b491e5948fdb90c304b0f51f34ce5db482f66c9c3ad7646dc86d50a::events::emit_added_trusted_signer(0x2::object::uid_to_inner(&arg0.id), arg1, arg2);
                };
                return
            };
            v1 = v1 + 1;
        };
        v2 = 0x1::option::none<u64>();
        /* goto 6 */
    }

    public fun upgrade_version(arg0: &mut Verifier, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x3d1ef06d5b491e5948fdb90c304b0f51f34ce5db482f66c9c3ad7646dc86d50a::authority::PACKAGE, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>) {
        assert!(arg0.version < 1, 13906834921667690497);
        arg0.version = 1;
    }

    public fun verify_and_parse(arg0: &Verifier, arg1: vector<u8>, arg2: vector<u8>, arg3: &0x2::clock::Clock) : 0x3d1ef06d5b491e5948fdb90c304b0f51f34ce5db482f66c9c3ad7646dc86d50a::update::Update {
        assert_version(arg0);
        let v0 = 0x2::ecdsa_k1::secp256k1_ecrecover(&arg2, &arg1, 0);
        let v1 = trusted_signers(arg0);
        let v2 = 0;
        while (v2 < 0x1::vector::length<TrustedSignerInfo>(v1)) {
            let v3 = 0x1::vector::borrow<TrustedSignerInfo>(v1, v2);
            if (public_key(v3) == &v0) {
                assert!(0x2::clock::timestamp_ms(arg3) < expires_at_ms(v3), 13906834719804620807);
                return 0x3d1ef06d5b491e5948fdb90c304b0f51f34ce5db482f66c9c3ad7646dc86d50a::update::parse(arg1)
            };
            v2 = v2 + 1;
        };
        abort 13906834745574293509
    }

    public fun version(arg0: &Verifier) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v7
}

