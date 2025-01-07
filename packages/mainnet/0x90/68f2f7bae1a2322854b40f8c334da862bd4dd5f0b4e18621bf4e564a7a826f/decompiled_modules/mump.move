module 0x9068f2f7bae1a2322854b40f8c334da862bd4dd5f0b4e18621bf4e564a7a826f::mump {
    struct MUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUMP>(arg0, 9, b"MUMP", b"Muskpump", b"Meme In honour of musk and trump friendship", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2ce1ae81-4dc5-4ea8-b146-ea9cfc2e01bb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

