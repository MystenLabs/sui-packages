module 0x7b02b59eb62af3c336d4e524cbf3e2943aa1f3e131681ca3325e31a2a1c04bbf::rageface {
    struct RAGEFACE has drop {
        dummy_field: bool,
    }

    fun init(arg0: RAGEFACE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RAGEFACE>(arg0, 9, b"RAGEFACE", b"Rage Face", b"A meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/514337dc-6aa0-45dd-b8fb-9c2a9b7bb1a9-IMG_0849.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAGEFACE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RAGEFACE>>(v1);
    }

    // decompiled from Move bytecode v6
}

