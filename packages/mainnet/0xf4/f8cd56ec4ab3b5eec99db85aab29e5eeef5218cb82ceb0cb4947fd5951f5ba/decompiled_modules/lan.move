module 0xf4f8cd56ec4ab3b5eec99db85aab29e5eeef5218cb82ceb0cb4947fd5951f5ba::lan {
    struct LAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: LAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LAN>(arg0, 9, b"LAN", b"Lannister", b"House Lannister Token for GOT lovers", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/de22ba4217ffd3c5ea93885ecac2d5f0blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LAN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LAN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

