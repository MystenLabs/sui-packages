module 0x66f1e803c9a3b4e3f0261947ca206a97fc84e5d48043086b62dbfd3b9f2988b4::pussymagic {
    struct PUSSYMAGIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUSSYMAGIC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUSSYMAGIC>(arg0, 6, b"PUSSYMAGIC", b"Pussy Magic", b"will be light or light", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/712827650327fdb6a1f5b7de677efbed_4fe3479c75.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUSSYMAGIC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUSSYMAGIC>>(v1);
    }

    // decompiled from Move bytecode v6
}

