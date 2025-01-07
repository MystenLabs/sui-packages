module 0x3bbbc3491ffeb806ff9d9517b37df72beda0dcda52a6b6b9019ff26895769381::rsm {
    struct RSM has drop {
        dummy_field: bool,
    }

    fun init(arg0: RSM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RSM>(arg0, 9, b"RSM", b"Rusma", b"Its okay", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8fabb42b-8b54-48b2-833c-0d9002f80994.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RSM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RSM>>(v1);
    }

    // decompiled from Move bytecode v6
}

