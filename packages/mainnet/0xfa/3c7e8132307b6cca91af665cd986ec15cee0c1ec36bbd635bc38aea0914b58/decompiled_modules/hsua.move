module 0xfa3c7e8132307b6cca91af665cd986ec15cee0c1ec36bbd635bc38aea0914b58::hsua {
    struct HSUA has drop {
        dummy_field: bool,
    }

    fun init(arg0: HSUA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HSUA>(arg0, 9, b"HSUA", b"Loi", b"To the mon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/515822ca-6d32-4bc8-a87d-ac648e3071bb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HSUA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HSUA>>(v1);
    }

    // decompiled from Move bytecode v6
}

