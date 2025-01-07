module 0x6139c9fc2ffbcd478a0e241f7d2d28224ccc2f470508c8efd12358d1d230240b::al {
    struct AL has drop {
        dummy_field: bool,
    }

    fun init(arg0: AL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AL>(arg0, 9, b"AL", b"Snow", b"Sn", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ab728346-910c-425a-ad0a-3081f209531f-IMG_20241006_102532.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AL>>(v1);
    }

    // decompiled from Move bytecode v6
}

