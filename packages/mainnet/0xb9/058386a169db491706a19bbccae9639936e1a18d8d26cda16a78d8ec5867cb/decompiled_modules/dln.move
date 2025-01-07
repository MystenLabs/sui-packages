module 0xb9058386a169db491706a19bbccae9639936e1a18d8d26cda16a78d8ec5867cb::dln {
    struct DLN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DLN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DLN>(arg0, 9, b"DLN", b"Dandelion", b"Dandelion of wishes", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/75b0f283-2bbc-4d4b-bef3-fca6b83dddd9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DLN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DLN>>(v1);
    }

    // decompiled from Move bytecode v6
}

