module 0xc7b712ff5441d8f19246b674c0f91d35dbbff396c89fcb2b6aad7c65a3e34f5f::gtt {
    struct GTT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GTT>(arg0, 9, b"GTT", b"GiangThen", b"GTT TO THE MOON", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9553a4d4-e900-457d-8685-1758b66c4c3b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GTT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GTT>>(v1);
    }

    // decompiled from Move bytecode v6
}

