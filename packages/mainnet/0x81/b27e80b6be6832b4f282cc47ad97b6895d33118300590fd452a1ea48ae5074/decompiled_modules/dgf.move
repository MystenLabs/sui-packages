module 0x81b27e80b6be6832b4f282cc47ad97b6895d33118300590fd452a1ea48ae5074::dgf {
    struct DGF has drop {
        dummy_field: bool,
    }

    fun init(arg0: DGF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DGF>(arg0, 9, b"DGF", b"Dragon Fly", b"Dragon fly meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4b2362ab-6813-4dbd-96d4-6ace79ad4273.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DGF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DGF>>(v1);
    }

    // decompiled from Move bytecode v6
}

