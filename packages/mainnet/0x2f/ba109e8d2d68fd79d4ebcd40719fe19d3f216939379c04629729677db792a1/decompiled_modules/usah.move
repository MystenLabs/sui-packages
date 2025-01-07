module 0x2fba109e8d2d68fd79d4ebcd40719fe19d3f216939379c04629729677db792a1::usah {
    struct USAH has drop {
        dummy_field: bool,
    }

    fun init(arg0: USAH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USAH>(arg0, 9, b"USAH", b"USA HEALER", x"546865204865616c696e67206973206e6f74206f6e6c7920666f722055534120f09f87baf09f87b82062757420616c736f20666f722074686520776f726c6420f09f8c9020426520612070617274206f6620f09faa99205553414820f09fabb6", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b337003b-9c4b-47c8-87da-3f4d6d11221a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USAH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<USAH>>(v1);
    }

    // decompiled from Move bytecode v6
}

