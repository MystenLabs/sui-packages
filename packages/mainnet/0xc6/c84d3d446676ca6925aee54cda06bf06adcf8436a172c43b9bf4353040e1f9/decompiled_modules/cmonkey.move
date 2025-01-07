module 0xc6c84d3d446676ca6925aee54cda06bf06adcf8436a172c43b9bf4353040e1f9::cmonkey {
    struct CMONKEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CMONKEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CMONKEY>(arg0, 9, b"CMONKEY", b"CRAZYMONKE", b"Lfg", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5b295378-6840-4abb-8a2b-7a9e22bd0ddf.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CMONKEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CMONKEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

