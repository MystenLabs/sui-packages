module 0x7b58af86d9a66dc043ab23075443d09a0d079bc09e4400d7861b0c513353a5c5::taosui {
    struct TAOSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TAOSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TAOSUI>(arg0, 9, b"TAOSUI", b"TAO", b"TAO the Sui dog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/903fc062-3bd9-4ee7-bcb5-ccbce0af5ad5-1000522694.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TAOSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TAOSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

