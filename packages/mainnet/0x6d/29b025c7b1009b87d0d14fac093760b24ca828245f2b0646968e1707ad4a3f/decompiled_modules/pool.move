module 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::pool {
    public fun declaration() : 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::declaration::Declaration {
        0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::declaration::none()
    }

    public fun proposal_schema() : vector<u8> {
        b"rooms:template:pool:0.1:proposal"
    }

    public fun template() : vector<u8> {
        b"pool"
    }

    public fun terms_fit(arg0: bool, arg1: &vector<0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::terms::TermField>) : bool {
        if (!arg0) {
            return false
        };
        if (!0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::terms::exact_keys(arg1, vector[b"order", b"total"])) {
            return false
        };
        let v0 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::terms::field(arg1, b"order");
        let v1 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::terms::field(arg1, b"total");
        if (0x1::option::is_some<0x1::string::String>(&v0)) {
            if (!0x1::string::is_empty(0x1::option::borrow<0x1::string::String>(&v0))) {
                if (0x1::option::is_some<0x1::string::String>(&v1)) {
                    0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::terms::amount_text_fits(0x1::option::borrow<0x1::string::String>(&v1))
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        }
    }

    // decompiled from Move bytecode v7
}

