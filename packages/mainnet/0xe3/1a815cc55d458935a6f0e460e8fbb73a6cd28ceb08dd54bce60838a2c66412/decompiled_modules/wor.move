module 0xe31a815cc55d458935a6f0e460e8fbb73a6cd28ceb08dd54bce60838a2c66412::wor {
    struct WOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOR>(arg0, 9, b"WOR", b"WORLD", b"What is the power of the world in your hands?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/094396e5-9a74-484d-8fc8-af5b38e538e5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WOR>>(v1);
    }

    // decompiled from Move bytecode v6
}

