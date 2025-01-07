module 0xeb35014ae6a7a04899ea2060b2759503e15b5276f95db539f672df704924a6e6::dnn {
    struct DNN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DNN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DNN>(arg0, 9, b"DNN", b"Smack ", b"Ckdndb is a good example ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7c1e2be3-27ca-45d3-8d61-610d5e72897a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DNN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DNN>>(v1);
    }

    // decompiled from Move bytecode v6
}

