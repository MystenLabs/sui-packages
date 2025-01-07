module 0x1ca6efe5f08c423b110d32092cfb71f19ab82a938d25b89a35acb402b29231ea::drm {
    struct DRM has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRM>(arg0, 9, b"DRM", b"Dream", b"Dreaming about dream ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b8c04acf-41b5-4ba9-bc6a-99e4d785527d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DRM>>(v1);
    }

    // decompiled from Move bytecode v6
}

