module 0xabd3d11e728dd1e64ff28d14aa773656264256b892f129fc094af3bb39e11ba9::aaaape {
    struct AAAAPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAAAPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAAAPE>(arg0, 6, b"AAAAPE", b"aaaApe", b"AAAAAAAAAAAAAPE!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/aaa_Ape_332c47a5a4.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAAAPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAAAPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

