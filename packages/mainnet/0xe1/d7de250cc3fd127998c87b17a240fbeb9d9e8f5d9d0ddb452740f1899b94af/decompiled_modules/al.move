module 0xe1d7de250cc3fd127998c87b17a240fbeb9d9e8f5d9d0ddb452740f1899b94af::al {
    struct AL has drop {
        dummy_field: bool,
    }

    fun init(arg0: AL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AL>(arg0, 9, b"AL", b"Snow", b"Sn", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e2d4d2af-5ae4-43c4-b287-3de7596acd3c-IMG_20241006_102532.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AL>>(v1);
    }

    // decompiled from Move bytecode v6
}

