module 0x437ddb9464bc32b9044e2c8b85943bd913163c4c2b2d5843247f7c6b93993e42::tt {
    struct TT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TT>(arg0, 9, b"TT", b"VN", b"TTT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/46146912-fd3c-4a15-9778-a2a19b8e5c56.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TT>>(v1);
    }

    // decompiled from Move bytecode v6
}

