module 0x874a6524346be58dc9408d8b926126aa6674593114abd6b24d18e9192901da86::bbc {
    struct BBC has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBC>(arg0, 9, b"BBC", b"BB&CRYPTO", b"About everything and nothing, fan token by purchasing which you can support our channel", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/422f665a-32f7-4978-ac46-b7369982ac55.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BBC>>(v1);
    }

    // decompiled from Move bytecode v6
}

