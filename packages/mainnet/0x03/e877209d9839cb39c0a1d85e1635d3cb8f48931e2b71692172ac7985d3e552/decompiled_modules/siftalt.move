module 0x3e877209d9839cb39c0a1d85e1635d3cb8f48931e2b71692172ac7985d3e552::siftalt {
    struct SIFTALT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIFTALT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIFTALT>(arg0, 9, b"SIFTALT", b"Siftal", b"Bee cyper", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a9763cbe-9d5a-4cda-bc9e-09bdd72b0754.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIFTALT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SIFTALT>>(v1);
    }

    // decompiled from Move bytecode v6
}

