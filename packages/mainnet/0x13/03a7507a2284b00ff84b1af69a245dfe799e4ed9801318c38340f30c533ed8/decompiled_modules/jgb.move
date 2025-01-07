module 0x1303a7507a2284b00ff84b1af69a245dfe799e4ed9801318c38340f30c533ed8::jgb {
    struct JGB has drop {
        dummy_field: bool,
    }

    fun init(arg0: JGB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JGB>(arg0, 9, b"JGB", b"JAGABANY ", b"Low key meme coin that will shake the enter crypto space", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/490db3f8-0158-4c66-8016-b5615c907677.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JGB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JGB>>(v1);
    }

    // decompiled from Move bytecode v6
}

