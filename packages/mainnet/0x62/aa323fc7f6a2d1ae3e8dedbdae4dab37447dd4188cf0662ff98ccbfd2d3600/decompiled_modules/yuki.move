module 0x62aa323fc7f6a2d1ae3e8dedbdae4dab37447dd4188cf0662ff98ccbfd2d3600::yuki {
    struct YUKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: YUKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YUKI>(arg0, 6, b"Yuki", b"Yuki The Son Lofi", b"$YUKI is a cute little fluffy furred Yeti and LOFI's son , he's stepping into Water chain as his Dad", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidxct4bynfszdxajv66hiehj46jyhf74t3dxl2lb7gbaxn4prq7na")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YUKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<YUKI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

