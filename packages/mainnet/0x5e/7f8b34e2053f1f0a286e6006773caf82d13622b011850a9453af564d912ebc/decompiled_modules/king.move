module 0x5e7f8b34e2053f1f0a286e6006773caf82d13622b011850a9453af564d912ebc::king {
    struct KING has drop {
        dummy_field: bool,
    }

    fun init(arg0: KING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KING>(arg0, 9, b"KING", b"King of Se", b"For the powerful", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/165aab35-0187-417d-b83c-1665dff21106.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KING>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KING>>(v1);
    }

    // decompiled from Move bytecode v6
}

