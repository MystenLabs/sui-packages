module 0xebf41a202c6ea8ecae4236b60bc1d754d3ab6ade69c53cd8f7282b8844c4da7f::donx {
    struct DONX has drop {
        dummy_field: bool,
    }

    fun init(arg0: DONX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DONX>(arg0, 6, b"DONX", b"Donx", b"Hi i'm DONX", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000020329_d609209dbf.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DONX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DONX>>(v1);
    }

    // decompiled from Move bytecode v6
}

