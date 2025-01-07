module 0x12b7454538639b1c7262915f51c09ae38d2afe08eac8940addf69324faa68a0d::wewetom {
    struct WEWETOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEWETOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEWETOM>(arg0, 9, b"WEWETOM", b"Tom", b"The man who stand for his family ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8ee34a08-cbfa-4172-b665-5c7796914d55.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEWETOM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WEWETOM>>(v1);
    }

    // decompiled from Move bytecode v6
}

