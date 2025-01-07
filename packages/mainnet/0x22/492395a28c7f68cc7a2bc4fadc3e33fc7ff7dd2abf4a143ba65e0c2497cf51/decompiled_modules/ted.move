module 0x22492395a28c7f68cc7a2bc4fadc3e33fc7ff7dd2abf4a143ba65e0c2497cf51::ted {
    struct TED has drop {
        dummy_field: bool,
    }

    fun init(arg0: TED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TED>(arg0, 9, b"TED", b"Teddys", b"Stupid bears", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a2abf98f-9fe6-4e7e-bf80-65a10bbd2bba.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TED>>(v1);
    }

    // decompiled from Move bytecode v6
}

