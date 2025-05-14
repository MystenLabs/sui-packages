module 0x5351ca119ec57b8ef5c50b0880673c43a9df4ce64ed1a6e5544dfeb4e3909576::ocr {
    struct OCR has drop {
        dummy_field: bool,
    }

    fun init(arg0: OCR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OCR>(arg0, 6, b"OCR", b"Octopus Gap", b"OCT is an octopus populating the Sui blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000069743_46fe032ac5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OCR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OCR>>(v1);
    }

    // decompiled from Move bytecode v6
}

