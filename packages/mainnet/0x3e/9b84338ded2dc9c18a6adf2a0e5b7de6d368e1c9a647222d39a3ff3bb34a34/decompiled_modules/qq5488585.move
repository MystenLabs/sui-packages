module 0x3e9b84338ded2dc9c18a6adf2a0e5b7de6d368e1c9a647222d39a3ff3bb34a34::qq5488585 {
    struct QQ5488585 has drop {
        dummy_field: bool,
    }

    fun init(arg0: QQ5488585, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QQ5488585>(arg0, 9, b"QQ5488585", b"QQ", b"Handsomeboy yyyyyyyyyyyyyyy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b08aef32-80c6-49ce-a997-349579707e51.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QQ5488585>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<QQ5488585>>(v1);
    }

    // decompiled from Move bytecode v6
}

