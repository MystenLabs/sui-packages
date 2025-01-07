module 0x2b10b5bc12c99047ffaa79fc81be99524a4a6bdadfb85ab6185912a25e492320::jor {
    struct JOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: JOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JOR>(arg0, 9, b"JOR", b"JORDAN", b"SHOES JORDAN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b0a783c3-2535-48f4-a793-f630f24ae760.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JOR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JOR>>(v1);
    }

    // decompiled from Move bytecode v6
}

