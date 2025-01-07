module 0xe5397df5b9164fe6882b9c0e4132e98b5526f85bf3b8312096018cb05aa2b578::hrmb {
    struct HRMB has drop {
        dummy_field: bool,
    }

    fun init(arg0: HRMB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HRMB>(arg0, 6, b"HRMB", b"HARAMBE", b"IM THE FRIENDLY HARAMBLEEEE IN CRYPTO PLANET!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/KINGKONG_fd12ad29f6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HRMB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HRMB>>(v1);
    }

    // decompiled from Move bytecode v6
}

