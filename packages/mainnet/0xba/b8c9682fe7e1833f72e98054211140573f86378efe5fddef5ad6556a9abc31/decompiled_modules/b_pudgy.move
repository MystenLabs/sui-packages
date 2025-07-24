module 0xbab8c9682fe7e1833f72e98054211140573f86378efe5fddef5ad6556a9abc31::b_pudgy {
    struct B_PUDGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_PUDGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_PUDGY>(arg0, 9, b"bPUDGY", b"bToken PUDGY", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_PUDGY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_PUDGY>>(v1);
    }

    // decompiled from Move bytecode v6
}

