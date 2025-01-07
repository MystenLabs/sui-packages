module 0xe9dea5944516fa9ed71baac496069c98cca923fbf557f95479456d9f47c74c5f::pxtrmp {
    struct PXTRMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PXTRMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PXTRMP>(arg0, 6, b"PXTRMP", b"PixelTrump", b"Trump needs your support https://makepxtrmp.pxtrmp.xyz/", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/fy_Kex6mj_400x400_11c6b53a73.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PXTRMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PXTRMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

