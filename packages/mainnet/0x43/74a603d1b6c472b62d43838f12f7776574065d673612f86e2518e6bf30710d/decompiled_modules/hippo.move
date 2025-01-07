module 0x4374a603d1b6c472b62d43838f12f7776574065d673612f86e2518e6bf30710d::hippo {
    struct HIPPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: HIPPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HIPPO>(arg0, 6, b"HIPPO", b"HIPPO - SU DENG", b"THE SUDENG OF SUI = $HIPPO ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/8ohc_TVBD_400x400_cb2b7f154f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HIPPO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HIPPO>>(v1);
    }

    // decompiled from Move bytecode v6
}

