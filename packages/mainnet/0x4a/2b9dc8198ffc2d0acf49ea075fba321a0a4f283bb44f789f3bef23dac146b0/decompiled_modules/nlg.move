module 0x4a2b9dc8198ffc2d0acf49ea075fba321a0a4f283bb44f789f3bef23dac146b0::nlg {
    struct NLG has drop {
        dummy_field: bool,
    }

    fun init(arg0: NLG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NLG>(arg0, 9, b"NLG", b"NAILONG", b"CUTE YELLOW DINOSAUR FROM CHINA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/038479eb-f6a1-4e15-a994-64c0dbe5ae09.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NLG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NLG>>(v1);
    }

    // decompiled from Move bytecode v6
}

