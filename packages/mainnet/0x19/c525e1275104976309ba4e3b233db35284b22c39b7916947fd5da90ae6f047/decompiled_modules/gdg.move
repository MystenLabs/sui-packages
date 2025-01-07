module 0x19c525e1275104976309ba4e3b233db35284b22c39b7916947fd5da90ae6f047::gdg {
    struct GDG has drop {
        dummy_field: bool,
    }

    fun init(arg0: GDG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GDG>(arg0, 9, b"GDG", b"DETECTIVE", b"Clever and innovative, inspired by the world of detective and espionage tools, unleash intrigue", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5820ab43-2e02-47c9-b621-537458deebd9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GDG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GDG>>(v1);
    }

    // decompiled from Move bytecode v6
}

