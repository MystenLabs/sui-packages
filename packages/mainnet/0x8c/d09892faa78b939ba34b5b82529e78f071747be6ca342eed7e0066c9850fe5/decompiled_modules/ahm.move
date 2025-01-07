module 0x8cd09892faa78b939ba34b5b82529e78f071747be6ca342eed7e0066c9850fe5::ahm {
    struct AHM has drop {
        dummy_field: bool,
    }

    fun init(arg0: AHM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AHM>(arg0, 9, b"AHM", b"Ahmat", b"Good 333", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4c7561d2-5b0d-4861-a041-675a4d611caf.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AHM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AHM>>(v1);
    }

    // decompiled from Move bytecode v6
}

