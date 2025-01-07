module 0x2d9febb4b4cab5991e1790dad03857acd94a8f6d7f91a810a573044eb0140544::dwh {
    struct DWH has drop {
        dummy_field: bool,
    }

    fun init(arg0: DWH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DWH>(arg0, 6, b"DWH", b"Dolphin wif Hippo", x"5468652070657266656374206d6173636f7420666f72205355490a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dolphin_wif_hippo_a27c948c74.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DWH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DWH>>(v1);
    }

    // decompiled from Move bytecode v6
}

