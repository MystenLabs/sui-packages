module 0x16720fc5784802228fd4be8f7b57825b9f59237e79ad552e3f635168f16252a5::djt {
    struct DJT has drop {
        dummy_field: bool,
    }

    fun init(arg0: DJT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DJT>(arg0, 6, b"DJT", b"Donald J. Trump", b"The Real Donald J. Trump", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Real_TRUMP_cbed3f1a5d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DJT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DJT>>(v1);
    }

    // decompiled from Move bytecode v6
}

