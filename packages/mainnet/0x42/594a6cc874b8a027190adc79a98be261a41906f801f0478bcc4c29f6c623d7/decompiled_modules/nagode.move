module 0x42594a6cc874b8a027190adc79a98be261a41906f801f0478bcc4c29f6c623d7::nagode {
    struct NAGODE has drop {
        dummy_field: bool,
    }

    fun init(arg0: NAGODE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NAGODE>(arg0, 9, b"NAGODE", b"Alfindiq", b"The coin is been created to support the people of Alfindiki", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/dccb233c-e996-4c8a-bd54-23333920b0a0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NAGODE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NAGODE>>(v1);
    }

    // decompiled from Move bytecode v6
}

