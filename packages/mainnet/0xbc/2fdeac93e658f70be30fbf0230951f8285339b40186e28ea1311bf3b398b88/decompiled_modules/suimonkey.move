module 0xbc2fdeac93e658f70be30fbf0230951f8285339b40186e28ea1311bf3b398b88::suimonkey {
    struct SUIMONKEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMONKEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMONKEY>(arg0, 6, b"SuiMonkey", b"Sui Monkey", b"The original monkey meme coin on the Sui blockchain! Get in on the ground floor with Sui Monkey and be part of the OG Monkey coin revolution!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000185561_b377a9fec9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMONKEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMONKEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

