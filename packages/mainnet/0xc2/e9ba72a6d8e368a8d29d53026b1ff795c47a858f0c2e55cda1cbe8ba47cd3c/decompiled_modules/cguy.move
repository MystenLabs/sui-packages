module 0xc2e9ba72a6d8e368a8d29d53026b1ff795c47a858f0c2e55cda1cbe8ba47cd3c::cguy {
    struct CGUY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CGUY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CGUY>(arg0, 9, b"CGUY", b"CHILGUYSUI", b"Chilguy Token is a new meme token that is here to enliven the cryptocurrency ecosystem, especially for the community of meme lovers and innovation in blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/40b85439-af68-44c0-a2cd-146dd6e24172.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CGUY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CGUY>>(v1);
    }

    // decompiled from Move bytecode v6
}

