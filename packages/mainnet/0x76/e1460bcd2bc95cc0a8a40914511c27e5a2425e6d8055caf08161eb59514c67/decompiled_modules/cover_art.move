module 0x76e1460bcd2bc95cc0a8a40914511c27e5a2425e6d8055caf08161eb59514c67::cover_art {
    struct CoverArt has copy, drop, store {
        still: 0xadefbe1aeb900807ed03144bddd80dc6478030c28ede3b2990f8e792606f317a::data::WalrusBlob,
        animated: 0x1::option::Option<0xadefbe1aeb900807ed03144bddd80dc6478030c28ede3b2990f8e792606f317a::data::WalrusBlob>,
    }

    public fun animated(arg0: &CoverArt) : &0x1::option::Option<0xadefbe1aeb900807ed03144bddd80dc6478030c28ede3b2990f8e792606f317a::data::WalrusBlob> {
        &arg0.animated
    }

    public fun new(arg0: 0xadefbe1aeb900807ed03144bddd80dc6478030c28ede3b2990f8e792606f317a::data::WalrusBlob, arg1: 0x1::option::Option<0xadefbe1aeb900807ed03144bddd80dc6478030c28ede3b2990f8e792606f317a::data::WalrusBlob>) : CoverArt {
        CoverArt{
            still    : arg0,
            animated : arg1,
        }
    }

    public fun still(arg0: &CoverArt) : &0xadefbe1aeb900807ed03144bddd80dc6478030c28ede3b2990f8e792606f317a::data::WalrusBlob {
        &arg0.still
    }

    // decompiled from Move bytecode v7
}

