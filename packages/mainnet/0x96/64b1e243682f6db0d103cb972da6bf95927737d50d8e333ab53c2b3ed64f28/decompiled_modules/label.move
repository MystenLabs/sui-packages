module 0x9664b1e243682f6db0d103cb972da6bf95927737d50d8e333ab53c2b3ed64f28::label {
    struct Label has copy, drop, store {
        title: 0x1::string::String,
        fontSize: u8,
    }

    public fun new(arg0: 0x1::string::String) : Label {
        Label{
            title    : arg0,
            fontSize : 12,
        }
    }

    // decompiled from Move bytecode v6
}

