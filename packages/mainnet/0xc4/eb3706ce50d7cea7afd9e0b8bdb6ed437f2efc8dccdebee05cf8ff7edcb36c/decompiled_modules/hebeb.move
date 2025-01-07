module 0xc4eb3706ce50d7cea7afd9e0b8bdb6ed437f2efc8dccdebee05cf8ff7edcb36c::hebeb {
    struct HEBEB has drop {
        dummy_field: bool,
    }

    fun init(arg0: HEBEB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HEBEB>(arg0, 9, b"HEBEB", b"hddb", b"hdbd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c796ff70-9838-471f-a4ec-382b54b8c379.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HEBEB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HEBEB>>(v1);
    }

    // decompiled from Move bytecode v6
}

