module 0x24a82f6b7b1b39aac460b4c3d4a17760c1821b21f13318bc4ffaebd8d00aaa1a::meomeo {
    struct MEOMEO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEOMEO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEOMEO>(arg0, 9, b"MEOMEO", b"memeo", b"meomeopump", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9b27d593-b726-47e4-8245-16e277b8d81f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEOMEO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEOMEO>>(v1);
    }

    // decompiled from Move bytecode v6
}

