module 0xed2cafccf4a8bd16003b24c7b95d7b0735d4bf764ed16e72b6c50541190eef9a::zay {
    struct ZAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZAY>(arg0, 6, b"ZAY", b"Zay The Cyber Bunny", b"In a neon-soaked cyber world, Zay the Cyber Bunny was born from a glitch deep in the blockchain, evolving into a fearless symbol of the wild crypto frontier. Quick-witted and turbo-charged, Z", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730682900202.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZAY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZAY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

