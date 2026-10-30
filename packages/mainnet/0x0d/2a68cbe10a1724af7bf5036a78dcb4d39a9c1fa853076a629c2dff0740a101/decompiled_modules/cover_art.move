module 0xd2a68cbe10a1724af7bf5036a78dcb4d39a9c1fa853076a629c2dff0740a101::cover_art {
    struct CoverArt has copy, drop, store {
        still_blob_id: u256,
        animated_blob_id: 0x1::option::Option<u256>,
    }

    public fun animated_blob_id(arg0: &CoverArt) : 0x1::option::Option<u256> {
        arg0.animated_blob_id
    }

    public fun new(arg0: u256, arg1: 0x1::option::Option<u256>) : CoverArt {
        CoverArt{
            still_blob_id    : arg0,
            animated_blob_id : arg1,
        }
    }

    public fun still_blob_id(arg0: &CoverArt) : u256 {
        arg0.still_blob_id
    }

    // decompiled from Move bytecode v7
}

