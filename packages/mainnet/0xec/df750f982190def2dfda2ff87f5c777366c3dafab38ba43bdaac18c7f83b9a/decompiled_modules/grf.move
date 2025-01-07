module 0xecdf750f982190def2dfda2ff87f5c777366c3dafab38ba43bdaac18c7f83b9a::grf {
    struct GRF has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRF>(arg0, 9, b"GRF", b"Griffin", b"A great guy saving the world. Keeps the wolf from stealing the moon and starting Ragnarok.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/76879de2-6dd9-4d27-a5dc-18f57fd9b621.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GRF>>(v1);
    }

    // decompiled from Move bytecode v6
}

