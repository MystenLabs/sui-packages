module 0xafd2cd83b930b923217fdc920b6a76016f5dc50d08d6e0d01c5aa30fcd57771f::mes {
    struct MES has drop {
        dummy_field: bool,
    }

    fun init(arg0: MES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MES>(arg0, 9, b"MES", b"Memesui", b"Memesui token focuses on currencies transfer among countries with the aid of cryptocurrency.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d137f3a2-1a78-47c7-bd7a-1e6d830c99ae.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MES>>(v1);
    }

    // decompiled from Move bytecode v6
}

