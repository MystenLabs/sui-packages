module 0xe73a827d74e5dfee9a9928f3ba573abc6bd2009443807da979151311182847e6::minfin {
    struct MINFIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MINFIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MINFIN>(arg0, 9, b"MINFIN", b"Minfin", b"Cofol", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/68f038d7-7c56-456f-9ae8-6a04c17cc34a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MINFIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MINFIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

