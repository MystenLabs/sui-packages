module 0xa13550a527869afc672ba36d3aefd9f493a75e26d03f8f5dae4173c6806cb664::pdk {
    struct PDK has drop {
        dummy_field: bool,
    }

    fun init(arg0: PDK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PDK>(arg0, 9, b"PDK", b"Panda King", b"The panda King meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/916d5810-481c-4203-8332-edc8671bf463.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PDK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PDK>>(v1);
    }

    // decompiled from Move bytecode v6
}

