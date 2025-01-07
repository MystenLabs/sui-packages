module 0xfb5b2a7c324ff5d34380f1b087433ffa7bbcf959cd7bce0de38c26787f66ca5b::ge {
    struct GE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GE>(arg0, 9, b"GE", b"GreenEarth", b"GreenEarth is a sustainable cryptocurrency aimed at funding eco-friendly projects and initiatives. By participating in our ecosystem, users can support renewable energy, conservation efforts.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/87ae78f0-a5fb-4fc8-8831-9a4aae953727.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GE>>(v1);
    }

    // decompiled from Move bytecode v6
}

