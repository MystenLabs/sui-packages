module 0xecc7d89c2ec8d62c853e2102a19fda79575b592b4eaa0371a3a3b55f94ffce80::suip {
    struct SUIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIP>(arg0, 6, b"Suip", b"SuiP", b"Suip is here to hop into the meme coin world with style, humor, and a nod to everyones favorite frog, Pepe! Suip isnt just another token; its a community-driven movement that brings together fans of memes, frogs, and fun times in the crypto space.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/frog_8649486c00.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIP>>(v1);
    }

    // decompiled from Move bytecode v6
}

