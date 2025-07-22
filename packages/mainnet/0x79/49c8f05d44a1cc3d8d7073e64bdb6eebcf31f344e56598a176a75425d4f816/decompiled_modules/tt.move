module 0x7949c8f05d44a1cc3d8d7073e64bdb6eebcf31f344e56598a176a75425d4f816::tt {
    struct TT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TT>(arg0, 6, b"TT", b"test", b"dsgfsgs", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifnkspaa7c27frtxnn25lb4llcpak4n5vdhjzzxkhhdhl3vw2ucbe")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

