module 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::declaration {
    struct Placed has copy, drop, store {
        kind: 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::RecordKind,
        entry: vector<u8>,
        receipt: vector<u8>,
    }

    struct Declaration has copy, drop, store {
        agreement: 0x1::option::Option<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::RecordKind>,
        commit: 0x1::option::Option<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::RecordKind>,
        opening: 0x1::option::Option<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::RecordKind>,
        sealed: vector<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::RecordKind>,
        placed: vector<Placed>,
        verifiable: vector<vector<u8>>,
        effect_free: vector<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::RecordKind>,
        reveal: 0x1::option::Option<0x1::string::String>,
        opening_hold: bool,
    }

    public fun none() : Declaration {
        new(0x1::option::none<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::RecordKind>(), 0x1::option::none<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::RecordKind>(), 0x1::option::none<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::RecordKind>(), 0x1::vector::empty<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::RecordKind>(), 0x1::vector::empty<Placed>(), vector[], 0x1::vector::empty<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::RecordKind>())
    }

    public fun agreement(arg0: &Declaration) : &0x1::option::Option<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::RecordKind> {
        &arg0.agreement
    }

    public fun allowed(arg0: &Declaration, arg1: &0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::RecordKind) : (0x1::string::String, 0x1::string::String) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Placed>(&arg0.placed)) {
            if (&0x1::vector::borrow<Placed>(&arg0.placed, v0).kind == arg1) {
                return (0x1::string::utf8(0x1::vector::borrow<Placed>(&arg0.placed, v0).entry), 0x1::string::utf8(0x1::vector::borrow<Placed>(&arg0.placed, v0).receipt))
            };
            v0 = v0 + 1;
        };
        (0x1::string::utf8(b"room"), 0x1::string::utf8(b"room"))
    }

    public fun commit(arg0: &Declaration) : &0x1::option::Option<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::RecordKind> {
        &arg0.commit
    }

    public fun is_effect_free(arg0: &Declaration, arg1: &0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::RecordKind) : bool {
        0x1::vector::contains<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::RecordKind>(&arg0.effect_free, arg1)
    }

    public fun new(arg0: 0x1::option::Option<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::RecordKind>, arg1: 0x1::option::Option<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::RecordKind>, arg2: 0x1::option::Option<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::RecordKind>, arg3: vector<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::RecordKind>, arg4: vector<Placed>, arg5: vector<vector<u8>>, arg6: vector<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::RecordKind>) : Declaration {
        Declaration{
            agreement    : arg0,
            commit       : arg1,
            opening      : arg2,
            sealed       : arg3,
            placed       : arg4,
            verifiable   : arg5,
            effect_free  : arg6,
            reveal       : 0x1::option::none<0x1::string::String>(),
            opening_hold : true,
        }
    }

    public fun opening(arg0: &Declaration) : &0x1::option::Option<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::RecordKind> {
        &arg0.opening
    }

    public fun opening_hold(arg0: &Declaration) : bool {
        arg0.opening_hold
    }

    public fun placed(arg0: 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::RecordKind, arg1: vector<u8>, arg2: vector<u8>) : Placed {
        Placed{
            kind    : arg0,
            entry   : arg1,
            receipt : arg2,
        }
    }

    public fun reveal(arg0: &Declaration) : &0x1::option::Option<0x1::string::String> {
        &arg0.reveal
    }

    public fun sealed(arg0: &Declaration) : &vector<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::RecordKind> {
        &arg0.sealed
    }

    public fun verifies(arg0: &Declaration, arg1: &0x1::string::String) : bool {
        0x1::vector::contains<vector<u8>>(&arg0.verifiable, 0x1::string::as_bytes(arg1))
    }

    public fun with_reveal(arg0: Declaration, arg1: vector<u8>) : Declaration {
        arg0.reveal = 0x1::option::some<0x1::string::String>(0x1::string::utf8(arg1));
        arg0
    }

    public fun without_hold(arg0: Declaration) : Declaration {
        arg0.opening_hold = false;
        arg0
    }

    // decompiled from Move bytecode v7
}

