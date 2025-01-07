module 0x1a32410d7308191934e6a67bf0d3974702a66588ad87638a820bf804c7132dd6::sex {
    struct SEX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEX>(arg0, 9, b"SEX", b"Siski", b"first sexy token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5c07e98d-5940-4aec-a690-d4cd9370dfa4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SEX>>(v1);
    }

    // decompiled from Move bytecode v6
}

