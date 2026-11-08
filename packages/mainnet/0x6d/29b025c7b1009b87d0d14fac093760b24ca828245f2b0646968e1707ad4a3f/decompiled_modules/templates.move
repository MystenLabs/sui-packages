module 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::templates {
    public fun declaration(arg0: &0x1::string::String) : 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::declaration::Declaration {
        let v0 = 0x1::string::as_bytes(arg0);
        let v1 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::case::template();
        if (v0 == &v1) {
            0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::case::declaration()
        } else {
            let v3 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::pool::template();
            if (v0 == &v3) {
                0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::pool::declaration()
            } else {
                let v4 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::sell::template();
                if (v0 == &v4) {
                    0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::sell::declaration()
                } else {
                    let v5 = 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::waitlist::template();
                    if (v0 == &v5) {
                        0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::waitlist::declaration()
                    } else {
                        0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::declaration::none()
                    }
                }
            }
        }
    }

    // decompiled from Move bytecode v7
}

