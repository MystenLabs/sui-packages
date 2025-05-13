module 0xb6f00d2ad7cc7005ecf18c992a08eaf259c4a9890d8cc006c5ec9d1e01a7d120::fren {
    struct FREN has drop {
        dummy_field: bool,
    }

    fun init(arg0: FREN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FREN>(arg0, 6, b"FREN", b"SuiFren", b"SuiFren is a community-powered meme token on the Sui blockchain, created for the frens, by the frens. With a fun-loving frog mascot and strong community vibes, SuiFren brings humor, hype, and heart to the Sui ecosystem. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1747119447153.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FREN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FREN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

