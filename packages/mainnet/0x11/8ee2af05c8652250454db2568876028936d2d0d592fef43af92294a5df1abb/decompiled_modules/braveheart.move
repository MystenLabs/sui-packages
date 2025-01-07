module 0x118ee2af05c8652250454db2568876028936d2d0d592fef43af92294a5df1abb::braveheart {
    struct BRAVEHEART has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRAVEHEART, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRAVEHEART>(arg0, 6, b"BRAVEHEART", b"FREEDOM", b"FFFFFFFFFFFFFFFRRRRRRRRRRRRRRREEEEEEEEEEEEEEEEEEEDDDDDDDDDDDDDDDOOOOOOOOOOOOOOOOOOOOOMMMMMMMMM!!!!!!!!!!!!!!!!!!!! CRYPTO IS FINALLY FREE FROM TYRANNYYYYY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730952979258.jfif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BRAVEHEART>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRAVEHEART>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

