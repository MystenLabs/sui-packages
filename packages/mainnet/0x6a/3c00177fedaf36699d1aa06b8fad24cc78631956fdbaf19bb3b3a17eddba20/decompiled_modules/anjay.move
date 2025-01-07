module 0x6a3c00177fedaf36699d1aa06b8fad24cc78631956fdbaf19bb3b3a17eddba20::anjay {
    struct ANJAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANJAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANJAY>(arg0, 9, b"ANJAY", b"AENJEAYE", b"Start crazy time", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a7a7f00c-f501-443a-8d30-78442fb3c80b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANJAY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ANJAY>>(v1);
    }

    // decompiled from Move bytecode v6
}

