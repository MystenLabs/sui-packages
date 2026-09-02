module 0xadefbe1aeb900807ed03144bddd80dc6478030c28ede3b2990f8e792606f317a::data {
    struct WalrusBlob has copy, drop, store {
        blob_id: u256,
        confidentiality: 0xadefbe1aeb900807ed03144bddd80dc6478030c28ede3b2990f8e792606f317a::confidentiality::Confidentiality,
    }

    struct WalrusQuilt has copy, drop, store {
        quilt_id: u256,
    }

    struct WalrusQuiltPatch has copy, drop, store {
        quilt_patch_id: vector<u8>,
        confidentiality: 0xadefbe1aeb900807ed03144bddd80dc6478030c28ede3b2990f8e792606f317a::confidentiality::Confidentiality,
    }

    public fun blob_confidentiality(arg0: &WalrusBlob) : &0xadefbe1aeb900807ed03144bddd80dc6478030c28ede3b2990f8e792606f317a::confidentiality::Confidentiality {
        &arg0.confidentiality
    }

    public fun blob_id(arg0: &WalrusBlob) : u256 {
        arg0.blob_id
    }

    public fun new_blob(arg0: u256, arg1: 0xadefbe1aeb900807ed03144bddd80dc6478030c28ede3b2990f8e792606f317a::confidentiality::Confidentiality) : WalrusBlob {
        WalrusBlob{
            blob_id         : arg0,
            confidentiality : arg1,
        }
    }

    public fun new_quilt(arg0: u256) : WalrusQuilt {
        WalrusQuilt{quilt_id: arg0}
    }

    public fun new_quilt_patch(arg0: vector<u8>, arg1: 0xadefbe1aeb900807ed03144bddd80dc6478030c28ede3b2990f8e792606f317a::confidentiality::Confidentiality) : WalrusQuiltPatch {
        assert!(!0x1::vector::is_empty<u8>(&arg0), 13906834419156516865);
        WalrusQuiltPatch{
            quilt_patch_id  : arg0,
            confidentiality : arg1,
        }
    }

    public fun quilt_id(arg0: &WalrusQuilt) : u256 {
        arg0.quilt_id
    }

    public fun quilt_patch_confidentiality(arg0: &WalrusQuiltPatch) : &0xadefbe1aeb900807ed03144bddd80dc6478030c28ede3b2990f8e792606f317a::confidentiality::Confidentiality {
        &arg0.confidentiality
    }

    public fun quilt_patch_id(arg0: &WalrusQuiltPatch) : &vector<u8> {
        &arg0.quilt_patch_id
    }

    // decompiled from Move bytecode v7
}

