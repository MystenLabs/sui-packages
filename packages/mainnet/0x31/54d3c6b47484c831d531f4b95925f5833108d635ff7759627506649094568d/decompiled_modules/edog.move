module 0x3154d3c6b47484c831d531f4b95925f5833108d635ff7759627506649094568d::edog {
    struct EDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: EDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EDOG>(arg0, 9, b"EDOG", b"Elon dog", b"Hi Elon Musk from 2021", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f14e776a-b4e9-49c2-96be-bcb06f0449d3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

