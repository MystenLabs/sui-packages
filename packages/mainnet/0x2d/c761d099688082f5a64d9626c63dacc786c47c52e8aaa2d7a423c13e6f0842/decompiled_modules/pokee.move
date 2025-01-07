module 0x2dc761d099688082f5a64d9626c63dacc786c47c52e8aaa2d7a423c13e6f0842::pokee {
    struct POKEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: POKEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POKEE>(arg0, 6, b"Pokee", b"Mr Pokee", x"497420616c6c207374617274656420776974682061206865646765686f67206e616d656420506f6b65652077686f2074617567687420757320746f20626520686170707920616e6420736d696c65200a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/h_MB_0s3_DU_400x400_68167ba49f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POKEE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POKEE>>(v1);
    }

    // decompiled from Move bytecode v6
}

