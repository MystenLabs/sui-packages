module 0xcc884f53ac1a8cf088b4b536ba50c6a90b4d2acb2dfb2d32127f734faeaf4402::dmpm {
    struct DMPM has drop {
        dummy_field: bool,
    }

    fun init(arg0: DMPM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DMPM>(arg0, 9, b"DMPM", b"DumbPump", b"Shit honey for smart money", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/65f5c42f-a39d-4828-90f2-149ba0191691.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DMPM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DMPM>>(v1);
    }

    // decompiled from Move bytecode v6
}

