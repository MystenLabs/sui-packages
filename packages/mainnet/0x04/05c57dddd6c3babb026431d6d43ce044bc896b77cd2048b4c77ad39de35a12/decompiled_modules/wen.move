module 0x405c57dddd6c3babb026431d6d43ce044bc896b77cd2048b4c77ad39de35a12::wen {
    struct WEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEN>(arg0, 9, b"WEN", b"Wen", b"When", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a1ef1a8b-c847-4b3d-ad8f-6e6f6f30fa41.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

