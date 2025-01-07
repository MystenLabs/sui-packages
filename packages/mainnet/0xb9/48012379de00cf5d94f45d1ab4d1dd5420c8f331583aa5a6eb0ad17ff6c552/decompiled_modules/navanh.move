module 0xb948012379de00cf5d94f45d1ab4d1dd5420c8f331583aa5a6eb0ad17ff6c552::navanh {
    struct NAVANH has drop {
        dummy_field: bool,
    }

    fun init(arg0: NAVANH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NAVANH>(arg0, 9, b"NAVANH", b"DAN", b"My baby", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/43396296-9e76-46e6-9cf2-d43575fc133e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NAVANH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NAVANH>>(v1);
    }

    // decompiled from Move bytecode v6
}

