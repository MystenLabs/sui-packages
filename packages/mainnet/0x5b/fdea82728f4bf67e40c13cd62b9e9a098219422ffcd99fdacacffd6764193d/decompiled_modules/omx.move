module 0x5bfdea82728f4bf67e40c13cd62b9e9a098219422ffcd99fdacacffd6764193d::omx {
    struct OMX has drop {
        dummy_field: bool,
    }

    fun init(arg0: OMX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OMX>(arg0, 9, b"OMX", b"Ommix ", b"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e4a03374-a23f-44a9-8969-50dfda8b039a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OMX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OMX>>(v1);
    }

    // decompiled from Move bytecode v6
}

