module 0xf702a0a7056d6e1809b44c6c27f8de661e2b43668b96c4e31a736ee76624004b::aos {
    struct AOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: AOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AOS>(arg0, 6, b"AOS", b"Aquaman on Sui", b"$AQUA MAN THE NUMBER 1 DEFENDER OF SUI MEME UNIVERSE. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_4440_9e4fecaad6.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

