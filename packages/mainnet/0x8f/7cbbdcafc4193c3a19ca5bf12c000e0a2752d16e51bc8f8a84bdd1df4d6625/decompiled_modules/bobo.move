module 0x8f7cbbdcafc4193c3a19ca5bf12c000e0a2752d16e51bc8f8a84bdd1df4d6625::bobo {
    struct BOBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOBO>(arg0, 9, b"BOBO", b"Bo", b"Bodktl", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b2dd4f67-980a-470e-888b-3b170bd36e01.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOBO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOBO>>(v1);
    }

    // decompiled from Move bytecode v6
}

