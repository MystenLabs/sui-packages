module 0x18f709b4c35d02a1bd4c7a10aab0ff1e383b8377923502faaf0dff55d61f5593::ggu {
    struct GGU has drop {
        dummy_field: bool,
    }

    fun init(arg0: GGU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GGU>(arg0, 9, b"GGU", b"GulerGuu", b"GGU Meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b2128724-ca49-4d50-8a5e-81bb716a1d3e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GGU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GGU>>(v1);
    }

    // decompiled from Move bytecode v6
}

