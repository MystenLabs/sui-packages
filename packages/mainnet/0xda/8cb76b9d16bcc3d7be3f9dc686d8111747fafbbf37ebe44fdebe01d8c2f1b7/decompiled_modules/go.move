module 0xda8cb76b9d16bcc3d7be3f9dc686d8111747fafbbf37ebe44fdebe01d8c2f1b7::go {
    struct GO has drop {
        dummy_field: bool,
    }

    fun init(arg0: GO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GO>(arg0, 9, b"GO", b"Gojo", b"Meme token ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/05372b00-39a3-4254-b105-85d0bd6baafe.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GO>>(v1);
    }

    // decompiled from Move bytecode v6
}

