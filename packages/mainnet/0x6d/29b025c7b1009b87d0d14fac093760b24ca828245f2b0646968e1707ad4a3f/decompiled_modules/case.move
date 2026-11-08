module 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::case {
    public fun declaration() : 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::declaration::Declaration {
        0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::declaration::new(0x1::option::some<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::RecordKind>(0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::acceptance()), 0x1::option::none<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::RecordKind>(), 0x1::option::none<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::RecordKind>(), 0x1::vector::empty<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::RecordKind>(), 0x1::vector::empty<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::declaration::Placed>(), vector[], 0x1::vector::empty<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::RecordKind>())
    }

    public fun proposal_schema() : vector<u8> {
        b"rooms:template:case:0.1:proposal"
    }

    public fun template() : vector<u8> {
        b"case"
    }

    public fun terms_fit(arg0: bool, arg1: &vector<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::terms::TermField>) : bool {
        if (!arg0) {
            return false
        };
        let v0 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::terms::exact_keys(arg1, vector[b"credit", b"norms"]);
        if (!v0 && !0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::terms::exact_keys(arg1, vector[b"credit"])) {
            return false
        };
        let v1 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::terms::field(arg1, b"credit");
        if (0x1::option::is_none<0x1::string::String>(&v1) || !0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::terms::amount_text_fits(0x1::option::borrow<0x1::string::String>(&v1))) {
            return false
        };
        if (!v0) {
            return true
        };
        let v2 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::terms::raw_field(arg1, b"norms");
        0x1::option::is_some<0x1::string::String>(&v2) && 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::terms::norms_text_fits(0x1::option::borrow<0x1::string::String>(&v2))
    }

    // decompiled from Move bytecode v7
}

