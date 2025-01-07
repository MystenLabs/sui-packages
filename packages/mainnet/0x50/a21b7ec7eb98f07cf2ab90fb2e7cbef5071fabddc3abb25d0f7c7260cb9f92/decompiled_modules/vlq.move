module 0x50a21b7ec7eb98f07cf2ab90fb2e7cbef5071fabddc3abb25d0f7c7260cb9f92::vlq {
    struct VLQ has drop {
        dummy_field: bool,
    }

    fun init(arg0: VLQ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VLQ>(arg0, 9, b"VLQ", b"vailon", b"VLAWET", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a6d4a2ee-82f6-48b6-b9c9-f060de7481fc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VLQ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VLQ>>(v1);
    }

    // decompiled from Move bytecode v6
}

