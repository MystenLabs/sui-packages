module 0x339b32e85c9ae549bb670f703155de887ffb8e2176797843597df55d81df9b8::pns {
    struct PNS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PNS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PNS>(arg0, 9, b"PNS", b"Phines ", b"Freedom of the world against famine", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e876cfe8-a40b-44d6-ba10-7bcea76cee83.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PNS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PNS>>(v1);
    }

    // decompiled from Move bytecode v6
}

