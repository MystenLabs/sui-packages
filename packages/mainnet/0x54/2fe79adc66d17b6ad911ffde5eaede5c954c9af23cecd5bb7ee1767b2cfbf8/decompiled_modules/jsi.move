module 0x542fe79adc66d17b6ad911ffde5eaede5c954c9af23cecd5bb7ee1767b2cfbf8::jsi {
    struct JSI has drop {
        dummy_field: bool,
    }

    fun init(arg0: JSI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JSI>(arg0, 9, b"JSI", b"Jtc sui", b"Deripo baser tete kadom polio ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d8d6b181-bef7-4269-bb33-74b558bd772f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JSI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JSI>>(v1);
    }

    // decompiled from Move bytecode v6
}

