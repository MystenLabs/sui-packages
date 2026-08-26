module 0x68a3f8a6fbc02bafc88b22af820ce4223ae73e0a61e56724b5fd5665e6adf15::external_verifier {
    struct ExternalVerifier has copy, drop, store {
        method: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::verifier::VerifierMethodId,
        witness: 0x2::object::ID,
        immutable_shared_objects: vector<0x2::object::ID>,
    }

    struct ExternalVerifierRegistration {
        method: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::verifier::VerifierMethodId,
        witness: 0x2::object::ID,
        immutable_shared_objects: vector<0x2::object::ID>,
    }

    public fun add_object<T0: key>(arg0: &mut ExternalVerifierRegistration, arg1: &T0) {
        let v0 = 0x2::object::id<T0>(arg1);
        assert!(!0x1::vector::contains<0x2::object::ID>(&arg0.immutable_shared_objects, &v0), 13906834389091745793);
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.immutable_shared_objects, v0);
    }

    public fun immutable_shared_objects(arg0: &ExternalVerifier) : vector<0x2::object::ID> {
        arg0.immutable_shared_objects
    }

    public(friend) fun into_external_verifier(arg0: ExternalVerifierRegistration) : ExternalVerifier {
        let ExternalVerifierRegistration {
            method                   : v0,
            witness                  : v1,
            immutable_shared_objects : v2,
        } = arg0;
        ExternalVerifier{
            method                   : v0,
            witness                  : v1,
            immutable_shared_objects : v2,
        }
    }

    public fun method(arg0: &ExternalVerifier) : 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::verifier::VerifierMethodId {
        arg0.method
    }

    public fun new<T0: key>(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x1::ascii::String, arg3: 0x1::ascii::String, arg4: &T0) : ExternalVerifierRegistration {
        let v0 = 0x2::object::id<T0>(arg4);
        let v1 = 0x1::vector::empty<0x2::object::ID>();
        0x1::vector::push_back<0x2::object::ID>(&mut v1, v0);
        ExternalVerifierRegistration{
            method                   : 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::verifier::new_method_id(arg0, arg1, arg2, arg3),
            witness                  : v0,
            immutable_shared_objects : v1,
        }
    }

    public fun witness(arg0: &ExternalVerifier) : 0x2::object::ID {
        arg0.witness
    }

    // decompiled from Move bytecode v7
}

