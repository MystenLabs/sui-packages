module 0x46dc245a0c84096acadda2552adc8af8fbf50b4d8e641ff81035f054648e251e::pelbdbd {
    struct PELBDBD has drop {
        dummy_field: bool,
    }

    fun init(arg0: PELBDBD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PELBDBD>(arg0, 9, b"PELBDBD", b"heoeke", b"svbeb", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c645adf2-0251-4140-8873-87bba82fd7e7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PELBDBD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PELBDBD>>(v1);
    }

    // decompiled from Move bytecode v6
}

