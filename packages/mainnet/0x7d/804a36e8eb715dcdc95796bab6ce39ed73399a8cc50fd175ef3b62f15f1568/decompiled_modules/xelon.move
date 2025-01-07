module 0x7d804a36e8eb715dcdc95796bab6ce39ed73399a8cc50fd175ef3b62f15f1568::xelon {
    struct XELON has drop {
        dummy_field: bool,
    }

    fun init(arg0: XELON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XELON>(arg0, 9, b"XELON", b"X", b"We will change the world of Web 3", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/792b420a-bae6-4760-a96e-d1371312b76f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XELON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XELON>>(v1);
    }

    // decompiled from Move bytecode v6
}

