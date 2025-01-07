module 0x2d9eb2c7025596205088afdd09e8484f9771467d7ab52c6870720801f5ae9aca::supix {
    struct SUPIX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUPIX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUPIX>(arg0, 6, b"SUPIX", b"Sui Pixel", b"Pixel in the sui ecosystem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a43126a9_ed99_483a_847f_b705049ad076_415d49ac38.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUPIX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUPIX>>(v1);
    }

    // decompiled from Move bytecode v6
}

