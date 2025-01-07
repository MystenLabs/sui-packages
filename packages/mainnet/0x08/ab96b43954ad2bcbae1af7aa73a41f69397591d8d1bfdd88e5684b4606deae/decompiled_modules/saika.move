module 0x8ab96b43954ad2bcbae1af7aa73a41f69397591d8d1bfdd88e5684b4606deae::saika {
    struct SAIKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAIKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAIKA>(arg0, 9, b"SAIKA", b"Seika", b"HAHAHA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e0c2279a-1094-49cb-97c4-8e4e6183c1aa.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAIKA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SAIKA>>(v1);
    }

    // decompiled from Move bytecode v6
}

