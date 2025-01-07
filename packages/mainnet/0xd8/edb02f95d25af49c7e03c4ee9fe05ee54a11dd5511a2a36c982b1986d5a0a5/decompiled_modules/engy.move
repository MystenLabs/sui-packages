module 0xd8edb02f95d25af49c7e03c4ee9fe05ee54a11dd5511a2a36c982b1986d5a0a5::engy {
    struct ENGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: ENGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ENGY>(arg0, 9, b"ENGY", b"ENERGY ", b"Free energy ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b2978682-1de7-405c-9e8d-ae1abd764738.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ENGY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ENGY>>(v1);
    }

    // decompiled from Move bytecode v6
}

