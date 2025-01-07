module 0x2e846914f86d0595430e9f0c6a9b7d5809746f685aabdc7b50fdab4c3d082af3::cherry {
    struct CHERRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHERRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHERRY>(arg0, 6, b"CHERRY", b"Cherry chain", b"Cherry chain ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241123_234513_202_99a539061c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHERRY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHERRY>>(v1);
    }

    // decompiled from Move bytecode v6
}

