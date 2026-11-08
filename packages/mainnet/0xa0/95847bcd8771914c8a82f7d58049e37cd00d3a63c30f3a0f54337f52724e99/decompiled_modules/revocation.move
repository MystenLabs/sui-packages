module 0xa095847bcd8771914c8a82f7d58049e37cd00d3a63c30f3a0f54337f52724e99::revocation {
    struct Revocation has copy, drop, store {
        envelope_id: address,
        decision_id: address,
        kind: 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::HelmKind,
        at: 0x1::string::String,
    }

    public fun at(arg0: &Revocation) : &0x1::string::String {
        &arg0.at
    }

    public fun decision_id(arg0: &Revocation) : address {
        arg0.decision_id
    }

    public fun envelope_id(arg0: &Revocation) : address {
        arg0.envelope_id
    }

    public fun kind(arg0: &Revocation) : &0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::HelmKind {
        &arg0.kind
    }

    public(friend) fun new(arg0: address, arg1: address, arg2: 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::records::HelmKind, arg3: 0x1::string::String) : Revocation {
        Revocation{
            envelope_id : arg0,
            decision_id : arg1,
            kind        : arg2,
            at          : arg3,
        }
    }

    // decompiled from Move bytecode v7
}

