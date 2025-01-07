module 0x56f7763f5c2ba7e8cd293b4069f3269eb6fc17f73f349c9f569401b90d121242::wisnn {
    struct WISNN has drop {
        dummy_field: bool,
    }

    fun init(arg0: WISNN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WISNN>(arg0, 9, b"WISNN", b"heiwn", b"dbnwn", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/63e2ea86-1412-45ff-b271-e932a729c4a4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WISNN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WISNN>>(v1);
    }

    // decompiled from Move bytecode v6
}

