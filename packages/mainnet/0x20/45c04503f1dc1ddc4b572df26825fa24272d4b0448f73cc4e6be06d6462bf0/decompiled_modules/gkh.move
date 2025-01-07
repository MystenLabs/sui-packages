module 0x2045c04503f1dc1ddc4b572df26825fa24272d4b0448f73cc4e6be06d6462bf0::gkh {
    struct GKH has drop {
        dummy_field: bool,
    }

    fun init(arg0: GKH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GKH>(arg0, 9, b"GKH", b"adfg", b"cz", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e9f8dd2c-0e82-4fe4-8c13-e686b04bc36d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GKH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GKH>>(v1);
    }

    // decompiled from Move bytecode v6
}

