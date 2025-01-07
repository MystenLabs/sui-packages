module 0xb81350ff5f8392285b142f2333c8aae06ee6abdb922c88f1c2e451a8263b530b::wwe {
    struct WWE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WWE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WWE>(arg0, 9, b"WWE", b"WENWE", b"Get in if you are this imaginative.. this is an imaginative meme!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/232ee677-951e-46b4-85cc-94934832aee9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WWE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WWE>>(v1);
    }

    // decompiled from Move bytecode v6
}

