module 0xa4b6bb369e12b42f86bc8482b1215e8fb6fcf1161be40260347539746ea26ca7::rdu {
    struct RDU has drop {
        dummy_field: bool,
    }

    fun init(arg0: RDU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RDU>(arg0, 9, b"RDU", b"Ridiculous", b"Strong and stable", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/82b838f2-ce5d-4798-8cc3-2e4787f695c2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RDU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RDU>>(v1);
    }

    // decompiled from Move bytecode v6
}

