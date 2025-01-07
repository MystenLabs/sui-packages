module 0xcc6a55e4d80f7351161f070a6caf03ca292b3e21688d8f0a6bef3d81902fdd65::gf {
    struct GF has drop {
        dummy_field: bool,
    }

    fun init(arg0: GF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GF>(arg0, 9, b"GF", b"Gold Fish", b"A nes monye for lover of golden fish", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e5988d57-53f2-467c-8425-9974398d0330.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GF>>(v1);
    }

    // decompiled from Move bytecode v6
}

