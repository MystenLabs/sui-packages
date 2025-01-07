module 0x6e84fe5fb23f85aa1c4237f3e2991a23c02756577e973b6f6f664c7b8e8aeec0::dguaubg {
    struct DGUAUBG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DGUAUBG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DGUAUBG>(arg0, 9, b"DGUAUBG", b"Dragon3388", b"Gm good products jdgabgyx", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1d3431f3-f524-446c-a370-00b47584cb07.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DGUAUBG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DGUAUBG>>(v1);
    }

    // decompiled from Move bytecode v6
}

