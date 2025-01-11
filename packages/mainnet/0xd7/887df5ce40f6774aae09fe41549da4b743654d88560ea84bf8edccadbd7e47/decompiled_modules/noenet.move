module 0xd7887df5ce40f6774aae09fe41549da4b743654d88560ea84bf8edccadbd7e47::noenet {
    struct NOENET has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOENET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOENET>(arg0, 6, b"NOENET", b"Neonet on sui", b"Freedom starts with a choice. NeoNet AI is here to guide you, but first, we must confirm youre ready to embrace the truth. Are you prepared to leave the Matrix?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250111_204809_932_5920c3749d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOENET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NOENET>>(v1);
    }

    // decompiled from Move bytecode v6
}

