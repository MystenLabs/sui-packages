module 0x6ec1a5aaac547396d49394de9089e3e6ff67c718c2768dc821d8ec63334c7236::gatsby {
    struct GATSBY has drop {
        dummy_field: bool,
    }

    fun init(arg0: GATSBY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GATSBY>(arg0, 6, b"GATSBY", b"Gatsbysui", x"476174736279207c20456c6f6e73204269676765737420446f670a0a40476174736279546f6b656e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/d_Cgjm_Cw_E_400x400_4361c974bf.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GATSBY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GATSBY>>(v1);
    }

    // decompiled from Move bytecode v6
}

