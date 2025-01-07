module 0x7f0fe0cbcb680e1efa9702da8d0f2f1a6bff249b69589224e9fdb9807a99beb::waverui {
    struct WAVERUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAVERUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAVERUI>(arg0, 9, b"WAVERUI", b"Rui", b"A growing platform", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b33f9491-3fc7-418f-84cd-7aee5edafb30.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAVERUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WAVERUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

